Subject: Re: [PATCH v4 6/7] selinux: Revalidate invalid inode security labels
To: Andreas Gruenbacher <agruenba@redhat.com>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
References: <1446079635-22462-1-git-send-email-agruenba@redhat.com>
 <1446079635-22462-7-git-send-email-agruenba@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56323980.8040209@tycho.nsa.gov>
Date: Thu, 29 Oct 2015 11:21:36 -0400
MIME-Version: 1.0
In-Reply-To: <1446079635-22462-7-git-send-email-agruenba@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/28/2015 08:47 PM, Andreas Gruenbacher wrote:
> When fetching an inode's security label, check if it is still valid, and
> try reloading it if it is not. Reloading will fail when we are in RCU
> context which doesn't allow sleeping, or when we can't find a dentry for
> the inode.  (Reloading happens via iop->getxattr which takes a dentry
> parameter.)  When reloading fails, continue using the old, invalid
> label.
>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Could probably use inode_security_novalidate() for all of the 
SOCK_INODE() cases, right?  Otherwise,
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/hooks.c | 70 ++++++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 65 insertions(+), 5 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index dcac6dc..47dc704 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -241,11 +241,63 @@ static int inode_alloc_security(struct inode *inode)
>   	return 0;
>   }
>
> +static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry);
> +
> +/*
> + * Try reloading inode security labels that have been marked as invalid.  The
> + * @may_sleep parameter indicates when sleeping and thus reloading labels is
> + * allowed; when set to false, returns ERR_PTR(-ECHILD) when the label is
> + * invalid.  The @opt_dentry parameter should be set to a dentry of the inode;
> + * when no dentry is available, set it to NULL instead.
> + */
> +static int __inode_security_revalidate(struct inode *inode,
> +				       struct dentry *opt_dentry,
> +				       bool may_sleep)
> +{
> +	struct inode_security_struct *isec = inode->i_security;
> +
> +	might_sleep_if(may_sleep);
> +
> +	if (isec->initialized == LABEL_INVALID) {
> +		if (!may_sleep)
> +			return -ECHILD;
> +
> +		/*
> +		 * Try reloading the inode security label.  This will fail if
> +		 * @opt_dentry is NULL and no dentry for this inode can be
> +		 * found; in that case, continue using the old label.
> +		 */
> +		inode_doinit_with_dentry(inode, opt_dentry);
> +	}
> +	return 0;
> +}
> +
> +static void inode_security_revalidate(struct inode *inode)
> +{
> +	__inode_security_revalidate(inode, NULL, true);
> +}
> +
> +static struct inode_security_struct *inode_security_novalidate(struct inode *inode)
> +{
> +	return inode->i_security;
> +}
> +
> +static struct inode_security_struct *inode_security_rcu(struct inode *inode, bool rcu)
> +{
> +	int error;
> +
> +	error = __inode_security_revalidate(inode, NULL, !rcu);
> +	if (error)
> +		return ERR_PTR(error);
> +	return inode->i_security;
> +}
> +
>   /*
>    * Get the security label of an inode.
>    */
>   static struct inode_security_struct *inode_security(struct inode *inode)
>   {
> +	__inode_security_revalidate(inode, NULL, true);
>   	return inode->i_security;
>   }
>
> @@ -256,6 +308,7 @@ static struct inode_security_struct *backing_inode_security(struct dentry *dentr
>   {
>   	struct inode *inode = d_backing_inode(dentry);
>
> +	__inode_security_revalidate(inode, dentry, true);
>   	return inode->i_security;
>   }
>
> @@ -362,8 +415,6 @@ static const char *labeling_behaviors[7] = {
>   	"uses native labeling",
>   };
>
> -static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry);
> -
>   static inline int inode_doinit(struct inode *inode)
>   {
>   	return inode_doinit_with_dentry(inode, NULL);
> @@ -1655,6 +1706,7 @@ static inline int dentry_has_perm(const struct cred *cred,
>
>   	ad.type = LSM_AUDIT_DATA_DENTRY;
>   	ad.u.dentry = dentry;
> +	__inode_security_revalidate(inode, dentry, true);
>   	return inode_has_perm(cred, inode, av, &ad);
>   }
>
> @@ -1670,6 +1722,7 @@ static inline int path_has_perm(const struct cred *cred,
>
>   	ad.type = LSM_AUDIT_DATA_PATH;
>   	ad.u.path = *path;
> +	__inode_security_revalidate(inode, path->dentry, true);
>   	return inode_has_perm(cred, inode, av, &ad);
>   }
>
> @@ -2874,7 +2927,9 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct inode *inode,
>   	ad.type = LSM_AUDIT_DATA_DENTRY;
>   	ad.u.dentry = dentry;
>   	sid = cred_sid(cred);
> -	isec = inode_security(inode);
> +	isec = inode_security_rcu(inode, rcu);
> +	if (IS_ERR(isec))
> +		return PTR_ERR(isec);
>
>   	return avc_has_perm_flags(sid, isec->sid, isec->sclass, FILE__READ, &ad,
>   				  rcu ? MAY_NOT_BLOCK : 0);
> @@ -2926,7 +2981,9 @@ static int selinux_inode_permission(struct inode *inode, int mask)
>   	perms = file_mask_to_av(inode->i_mode, mask);
>
>   	sid = cred_sid(cred);
> -	isec = inode_security(inode);
> +	isec = inode_security_rcu(inode, flags & MAY_NOT_BLOCK);
> +	if (IS_ERR(isec))
> +		return PTR_ERR(isec);
>
>   	rc = avc_has_perm_noaudit(sid, isec->sid, isec->sclass, perms, 0, &avd);
>   	audited = avc_audit_required(perms, &avd, rc,
> @@ -3234,6 +3291,7 @@ static int selinux_file_permission(struct file *file, int mask)
>   		/* No change since file_open check. */
>   		return 0;
>
> +	inode_security_revalidate(inode);
>   	return selinux_revalidate_file_permission(file, mask);
>   }
>
> @@ -3539,6 +3597,7 @@ static int selinux_file_open(struct file *file, const struct cred *cred)
>   	 * new inode label or new policy.
>   	 * This check is not redundant - do not remove.
>   	 */
> +	inode_security_revalidate(file_inode(file));
>   	return file_path_has_perm(cred, file, open_file_to_av(file));
>   }
>
> @@ -4620,7 +4679,8 @@ static void selinux_sk_getsecid(struct sock *sk, u32 *secid)
>
>   static void selinux_sock_graft(struct sock *sk, struct socket *parent)
>   {
> -	struct inode_security_struct *isec = inode_security(SOCK_INODE(parent));
> +	struct inode_security_struct *isec =
> +		inode_security_novalidate(SOCK_INODE(parent));
>   	struct sk_security_struct *sksec = sk->sk_security;
>
>   	if (sk->sk_family == PF_INET || sk->sk_family == PF_INET6 ||
>

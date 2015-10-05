Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t95IOP3l022133
 for <selinux@tycho.nsa.gov>; Mon, 5 Oct 2015 14:24:25 -0400
Subject: Re: [PATCH v2 1/2] security: Add hook to invalidate inode security
 labels
To: Andreas Gruenbacher <agruenba@redhat.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christoph Hellwig <hch@infradead.org>
References: <1443986381-14412-1-git-send-email-agruenba@redhat.com>
 <1443986381-14412-2-git-send-email-agruenba@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 LSM <linux-security-module@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <5612C056.50303@schaufler-ca.com>
Date: Mon, 5 Oct 2015 11:24:22 -0700
MIME-Version: 1.0
In-Reply-To: <1443986381-14412-2-git-send-email-agruenba@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/4/2015 12:19 PM, Andreas Gruenbacher wrote:
> Add a hook to invalidate an inode's security label when the cached
> information becomes invalid.

Where is this used? If I need to do the same for Smack
or any other module, how would I know that it works right?

>
> Implement the new hook in selinux: set a flag when a security label becomes
> invalid.  When hitting a security label which has been marked as invalid in
> inode_has_perm, try reloading the label.
>
> If an inode does not have any dentries attached, we cannot reload its
> security label because we cannot use the getxattr inode operation.  In that
> case, continue using the old, invalid label until a dentry becomes
> available.
>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: Eric Paris <eparis@parisplace.org>
> Cc: selinux@tycho.nsa.gov
> ---
>  include/linux/lsm_hooks.h         |  6 ++++++
>  include/linux/security.h          |  5 +++++
>  security/security.c               |  8 ++++++++
>  security/selinux/hooks.c          | 23 +++++++++++++++++++++--
>  security/selinux/include/objsec.h |  3 ++-
>  5 files changed, 42 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index ec3a6ba..945ae1d 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1261,6 +1261,10 @@
>   *	audit_rule_init.
>   *	@rule contains the allocated rule
>   *
> + * @inode_invalidate_secctx:
> + *	Notify the security module that it must revalidate the security context
> + *	of an inode.
> + *
>   * @inode_notifysecctx:
>   *	Notify the security module of what the security context of an inode
>   *	should be.  Initializes the incore security context managed by the
> @@ -1516,6 +1520,7 @@ union security_list_options {
>  	int (*secctx_to_secid)(const char *secdata, u32 seclen, u32 *secid);
>  	void (*release_secctx)(char *secdata, u32 seclen);
>  
> +	void (*inode_invalidate_secctx)(struct inode *inode);
>  	int (*inode_notifysecctx)(struct inode *inode, void *ctx, u32 ctxlen);
>  	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
>  	int (*inode_getsecctx)(struct inode *inode, void **ctx, u32 *ctxlen);
> @@ -1757,6 +1762,7 @@ struct security_hook_heads {
>  	struct list_head secid_to_secctx;
>  	struct list_head secctx_to_secid;
>  	struct list_head release_secctx;
> +	struct list_head inode_invalidate_secctx;
>  	struct list_head inode_notifysecctx;
>  	struct list_head inode_setsecctx;
>  	struct list_head inode_getsecctx;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 2f4c1f7..9692571 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -353,6 +353,7 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
>  int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
>  void security_release_secctx(char *secdata, u32 seclen);
>  
> +void security_inode_invalidate_secctx(struct inode *inode);
>  int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
>  int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
>  int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
> @@ -1093,6 +1094,10 @@ static inline void security_release_secctx(char *secdata, u32 seclen)
>  {
>  }
>  
> +static inline void security_inode_invalidate_secctx(struct inode *inode)
> +{
> +}
> +
>  static inline int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
>  {
>  	return -EOPNOTSUPP;
> diff --git a/security/security.c b/security/security.c
> index 46f405c..e4371cd 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1161,6 +1161,12 @@ void security_release_secctx(char *secdata, u32 seclen)
>  }
>  EXPORT_SYMBOL(security_release_secctx);
>  
> +void security_inode_invalidate_secctx(struct inode *inode)
> +{
> +	call_void_hook(inode_invalidate_secctx, inode);
> +}
> +EXPORT_SYMBOL(security_inode_invalidate_secctx);
> +
>  int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
>  {
>  	return call_int_hook(inode_notifysecctx, 0, inode, ctx, ctxlen);
> @@ -1763,6 +1769,8 @@ struct security_hook_heads security_hook_heads = {
>  		LIST_HEAD_INIT(security_hook_heads.secctx_to_secid),
>  	.release_secctx =
>  		LIST_HEAD_INIT(security_hook_heads.release_secctx),
> +	.inode_invalidate_secctx =
> +		LIST_HEAD_INIT(security_hook_heads.inode_invalidate_secctx),
>  	.inode_notifysecctx =
>  		LIST_HEAD_INIT(security_hook_heads.inode_notifysecctx),
>  	.inode_setsecctx =
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e4369d8..c5e4ca8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1293,11 +1293,11 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>  	unsigned len = 0;
>  	int rc = 0;
>  
> -	if (isec->initialized)
> +	if (isec->initialized == 1)
>  		goto out;
>  
>  	mutex_lock(&isec->lock);
> -	if (isec->initialized)
> +	if (isec->initialized == 1)
>  		goto out_unlock;
>  
>  	sbsec = inode->i_sb->s_security;
> @@ -1625,6 +1625,14 @@ static int inode_has_perm(const struct cred *cred,
>  	sid = cred_sid(cred);
>  	isec = inode->i_security;
>  
> +	/*
> +	 * Try reloading the inode security label when it has been invalidated.
> +	 * This will fail if no dentry for this inode can be found; in that case,
> +	 * we will continue using the old label.
> +	 */
> +	if (isec->initialized == 2)
> +		inode_doinit(inode);
> +
>  	return avc_has_perm(sid, isec->sid, isec->sclass, perms, adp);
>  }
>  
> @@ -3509,6 +3517,7 @@ static int selinux_file_open(struct file *file, const struct cred *cred)
>  
>  	fsec = file->f_security;
>  	isec = file_inode(file)->i_security;
> +
>  	/*
>  	 * Save inode label and policy sequence number
>  	 * at open-time so that selinux_file_permission
> @@ -5762,6 +5771,15 @@ static void selinux_release_secctx(char *secdata, u32 seclen)
>  	kfree(secdata);
>  }
>  
> +static void selinux_inode_invalidate_secctx(struct inode *inode)
> +{
> +	struct inode_security_struct *isec = inode->i_security;
> +
> +	mutex_lock(&isec->lock);
> +	isec->initialized = 2;
> +	mutex_unlock(&isec->lock);
> +}
> +
>  /*
>   *	called with inode->i_mutex locked
>   */
> @@ -5993,6 +6011,7 @@ static struct security_hook_list selinux_hooks[] = {
>  	LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
>  	LSM_HOOK_INIT(secctx_to_secid, selinux_secctx_to_secid),
>  	LSM_HOOK_INIT(release_secctx, selinux_release_secctx),
> +	LSM_HOOK_INIT(inode_invalidate_secctx, selinux_inode_invalidate_secctx),
>  	LSM_HOOK_INIT(inode_notifysecctx, selinux_inode_notifysecctx),
>  	LSM_HOOK_INIT(inode_setsecctx, selinux_inode_setsecctx),
>  	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> index 81fa718..6d1fe19 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -46,7 +46,8 @@ struct inode_security_struct {
>  	u32 task_sid;		/* SID of creating task */
>  	u32 sid;		/* SID of this object */
>  	u16 sclass;		/* security class of this object */
> -	unsigned char initialized;	/* initialization flag */
> +	unsigned char initialized;	/* 0: not initialized, 1: initialized,
> +					   2: invalidated */
>  	struct mutex lock;
>  };
>  

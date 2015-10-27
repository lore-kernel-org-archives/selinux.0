Subject: Re: [PATCH] selinux: export validatetrans decisions
To: Andrew Perepechko <anserper@ya.ru>, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov
References: <1445965643-30900-1-git-send-email-anserper@ya.ru>
Cc: andrew.perepechko@seagate.com
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <562FBF50.2090700@tycho.nsa.gov>
Date: Tue, 27 Oct 2015 14:15:44 -0400
MIME-Version: 1.0
In-Reply-To: <1445965643-30900-1-git-send-email-anserper@ya.ru>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/27/2015 01:07 PM, Andrew Perepechko wrote:
> Make validatetrans decisions available through selinuxfs.
> "/transition" is added to selinuxfs for this purpose.
> This functionality is needed by file system servers
> implemented in userspace or kernelspace without the VFS
> layer.
>
> Writing "$oldcontext $newcontext $tclass $taskcontext"
> to /transition is expected to return 0 if the transition
> is allowed and -EPERM otherwise.
>
> Signed-off-by: Andrew Perepechko <anserper@ya.ru>
> CC: andrew.perepechko@seagate.com
> ---
>   security/selinux/hooks.c            |  2 +-
>   security/selinux/include/security.h |  2 +-
>   security/selinux/selinuxfs.c        | 81 +++++++++++++++++++++++++++++++++++++
>   security/selinux/ss/services.c      | 20 +++++----
>   4 files changed, 95 insertions(+), 10 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e4369d8..f40f4b4 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3043,7 +3043,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
>   		return rc;
>
>   	rc = security_validate_transition(isec->sid, newsid, sid,
> -					  isec->sclass);
> +					  isec->sclass, 0);

Follow the example of security_transition_sid(), i.e. introduce a _user 
interface() and re-factor the existing security_validate_transition() 
into a common helper that takes a bool argument.

>   	if (rc)
>   		return rc;
>
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 6a681d2..84dec31 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -183,7 +183,7 @@ int security_node_sid(u16 domain, void *addr, u32 addrlen,
>   	u32 *out_sid);
>
>   int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
> -				 u16 tclass);
> +				 u16 tclass, int user);
>
>   int security_bounded_transition(u32 oldsid, u32 newsid);
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 5bed7716..eb487ff 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -116,6 +116,7 @@ enum sel_inos {
>   	SEL_DENY_UNKNOWN, /* export unknown deny handling to userspace */
>   	SEL_STATUS,	/* export current status using mmap() */
>   	SEL_POLICY,	/* allow userspace to read the in kernel policy */
> +	SEL_TRANSITION,	/* compute validatetrans decision */

Could be confusing since it is for validate_transition not transition_sid.
Probably ought to put validate into the name in some form.

>   	SEL_INO_NEXT,	/* The next inode number to use */
>   };
>
> @@ -653,6 +654,85 @@ static const struct file_operations sel_checkreqprot_ops = {
>   	.llseek		= generic_file_llseek,
>   };
>
> +static ssize_t sel_write_transition(struct file *file, const char __user *buf,
> +				    size_t count, loff_t *ppos)
> +{
> +	char *oldcon = NULL, *newcon = NULL, *taskcon = NULL;
> +	char *req = NULL;
> +	u32 osid, nsid, tsid;
> +	u16 tclass;
> +	int rc;
> +
> +	rc = task_has_security(current, SECURITY__COMPUTE_AV);

Just define a new permission in include/classmap.h (and in your policy, 
of course) and use it.

> +	if (rc)
> +		goto out;
> +
> +	rc = -ENOMEM;
> +	if (count >= PAGE_SIZE - 1)
> +		goto out;

Why PAGE_SIZE-1?

> +
> +	/* No partial writes. */
> +	rc = -EINVAL;
> +	if (*ppos != 0)
> +		goto out;
> +
> +	rc = -ENOMEM;
> +	req = kzalloc(count + 1, GFP_KERNEL);
> +	if (!req)
> +		goto out;
> +
> +	rc = -EFAULT;
> +	if (copy_from_user(req, buf, count))
> +		goto out;
> +
> +	rc = -ENOMEM;
> +	oldcon = kzalloc(count + 1, GFP_KERNEL);
> +	if (!oldcon)
> +		goto out;
> +
> +	newcon = kzalloc(count + 1, GFP_KERNEL);
> +	if (!newcon)
> +		goto out;
> +
> +	taskcon = kzalloc(count + 1, GFP_KERNEL);
> +	if (!taskcon)
> +		goto out;
> +
> +	rc = -EINVAL;
> +	if (sscanf(req, "%s %s %hu %s", oldcon, newcon, &tclass, taskcon) != 4)
> +		goto out;
> +
> +	rc = security_context_to_sid(oldcon, strlen(oldcon) + 1, &osid,
> +				     GFP_KERNEL);

#next has security_context_str_to_sid() as a convenient helper for this.

> +	if (rc)
> +		goto out;
> +
> +	rc = security_context_to_sid(newcon, strlen(newcon) + 1, &nsid,
> +				     GFP_KERNEL);
> +	if (rc)
> +		goto out;
> +
> +	rc = security_context_to_sid(taskcon, strlen(taskcon) + 1, &tsid,
> +				     GFP_KERNEL);
> +	if (rc)
> +		goto out;
> +
> +	rc = security_validate_transition(osid, nsid, tsid, tclass, 1);
> +	if (!rc)
> +		rc = count;
> +out:
> +	kfree(req);
> +	kfree(oldcon);
> +	kfree(newcon);
> +	kfree(taskcon);
> +	return rc;
> +}
> +
> +static const struct file_operations sel_transition_ops = {
> +	.write		= sel_write_transition,
> +	.llseek		= generic_file_llseek,
> +};
> +
>   /*
>    * Remaining nodes use transaction based IO methods like nfsd/nfsctl.c
>    */
> @@ -1767,6 +1847,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
>   		[SEL_DENY_UNKNOWN] = {"deny_unknown", &sel_handle_unknown_ops, S_IRUGO},
>   		[SEL_STATUS] = {"status", &sel_handle_status_ops, S_IRUGO},
>   		[SEL_POLICY] = {"policy", &sel_policy_ops, S_IRUGO},
> +		[SEL_TRANSITION] = {"transition", &sel_transition_ops, S_IWUSR},
>   		/* last one */ {""}
>   	};
>   	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index b7df12b..d3058bf 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -750,7 +750,7 @@ static void context_struct_compute_av(struct context *scontext,
>   				 tclass, avd);
>   }
>
> -static int security_validtrans_handle_fail(struct context *ocontext,
> +static void security_validtrans_audit_fail(struct context *ocontext,
>   					   struct context *ncontext,
>   					   struct context *tcontext,
>   					   u16 tclass)
> @@ -772,14 +772,10 @@ out:
>   	kfree(o);
>   	kfree(n);
>   	kfree(t);
> -
> -	if (!selinux_enforcing)
> -		return 0;
> -	return -EPERM;
>   }
>
>   int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
> -				 u16 orig_tclass)
> +				 u16 orig_tclass, int user)
>   {
>   	struct context *ocontext;
>   	struct context *ncontext;
> @@ -832,8 +828,16 @@ int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
>   	while (constraint) {
>   		if (!constraint_expr_eval(ocontext, ncontext, tcontext,
>   					  constraint->expr)) {
> -			rc = security_validtrans_handle_fail(ocontext, ncontext,
> -							     tcontext, tclass);
> +			if (!user)
> +				security_validtrans_audit_fail(ocontext,
> +								ncontext,
> +								tcontext,
> +								tclass);
> +			if (!selinux_enforcing && !user)
> +				rc = 0;
> +			else
> +				rc = -EPERM;

Hmm...in what situation don't you want it to reflect the kernel 
enforcing mode (i.e. when won't you just have your userspace file server 
end up checking security_getenforce() and ignore the error in that 
situation)?  Userspace AVC is different since it is caching decisions 
from the kernel but still ends up honoring the kernel's enforcing status 
(unless you explicitly set it to use its own private one).

Beyond that, the things that you don't want to happen when called from 
userspace include not unmapping the class value and not printk'ing on an 
unrecognized class.  See security_transition_sid_user() -> 
security_compute_sid() for example.


> +
>   			goto out;
>   		}
>   		constraint = constraint->next;
>

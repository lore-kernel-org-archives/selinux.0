Subject: Re: [PATCH] SELinux: check open perms in dentry_open not
	inode_permission
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <20081029210646.14332.52199.stgit@paris.rdu.redhat.com>
References: <20081029210646.14332.52199.stgit@paris.rdu.redhat.com>
Content-Type: text/plain
Date: Thu, 30 Oct 2008 10:31:24 -0400
Message-Id: <1225377084.13709.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-10-29 at 17:06 -0400, Eric Paris wrote:
> Some operations, like searching a directory path or connecting a unix domain
> socket, make explicit calls into inode_permission.  Our choices are to
> either try to come up with a signature for all of the explicit calls to
> inode_permission and do not check open on those, or to move the open checks to
> dentry_open where we know this is always an open operation.  This patch moves
> the checks to dentry_open.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Thanks, mea culpa - the original RFC patch for open permission put it
into dentry_open but I (wrongly) recommended taking it to
inode_permission at the time.

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
> 
>  security/selinux/hooks.c |   59 +++++++++++++++++++++++-----------------------
>  1 files changed, 30 insertions(+), 29 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3e3fde7..47cba68 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1687,15 +1687,39 @@ static inline u32 file_mask_to_av(int mode, int mask)
>  	return av;
>  }
>  
> +/* Convert a Linux file to an access vector. */
> +static inline u32 file_to_av(struct file *file)
> +{
> +	u32 av = 0;
> +
> +	if (file->f_mode & FMODE_READ)
> +		av |= FILE__READ;
> +	if (file->f_mode & FMODE_WRITE) {
> +		if (file->f_flags & O_APPEND)
> +			av |= FILE__APPEND;
> +		else
> +			av |= FILE__WRITE;
> +	}
> +	if (!av) {
> +		/*
> +		 * Special file opened with flags 3 for ioctl-only use.
> +		 */
> +		av = FILE__IOCTL;
> +	}
> +
> +	return av;
> +}
> +
>  /*
> - * Convert a file mask to an access vector and include the correct open
> + * Convert a file to an access vector and include the correct open
>   * open permission.
>   */
> -static inline u32 open_file_mask_to_av(int mode, int mask)
> +static inline u32 open_file_to_av(struct file *file)
>  {
> -	u32 av = file_mask_to_av(mode, mask);
> +	u32 av = file_to_av(file);
>  
>  	if (selinux_policycap_openperm) {
> +		mode_t mode = file->f_path.dentry->d_inode->i_mode;
>  		/*
>  		 * lnk files and socks do not really have an 'open'
>  		 */
> @@ -1711,34 +1735,11 @@ static inline u32 open_file_mask_to_av(int mode, int mask)
>  			av |= DIR__OPEN;
>  		else
>  			printk(KERN_ERR "SELinux: WARNING: inside %s with "
> -				"unknown mode:%x\n", __func__, mode);
> +				"unknown mode:%o\n", __func__, mode);
>  	}
>  	return av;
>  }
>  
> -/* Convert a Linux file to an access vector. */
> -static inline u32 file_to_av(struct file *file)
> -{
> -	u32 av = 0;
> -
> -	if (file->f_mode & FMODE_READ)
> -		av |= FILE__READ;
> -	if (file->f_mode & FMODE_WRITE) {
> -		if (file->f_flags & O_APPEND)
> -			av |= FILE__APPEND;
> -		else
> -			av |= FILE__WRITE;
> -	}
> -	if (!av) {
> -		/*
> -		 * Special file opened with flags 3 for ioctl-only use.
> -		 */
> -		av = FILE__IOCTL;
> -	}
> -
> -	return av;
> -}
> -
>  /* Hook functions begin here. */
>  
>  static int selinux_ptrace_may_access(struct task_struct *child,
> @@ -2648,7 +2649,7 @@ static int selinux_inode_permission(struct inode *inode, int mask)
>  	}
>  
>  	return inode_has_perm(current, inode,
> -			       open_file_mask_to_av(inode->i_mode, mask), NULL);
> +			      file_mask_to_av(inode->i_mode, mask), NULL);
>  }
>  
>  static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
> @@ -3164,7 +3165,7 @@ static int selinux_dentry_open(struct file *file)
>  	 * new inode label or new policy.
>  	 * This check is not redundant - do not remove.
>  	 */
> -	return inode_has_perm(current, inode, file_to_av(file), NULL);
> +	return inode_has_perm(current, inode, open_file_to_av(file), NULL);
>  }
>  
>  /* task security operations */
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

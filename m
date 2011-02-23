Subject: Re: [PATCH] Revert "selinux: simplify ioctl checking"
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <20110223025453.17573.3153.stgit@paris.rdu.redhat.com>
References: <20110223025453.17573.3153.stgit@paris.rdu.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 23 Feb 2011 10:24:41 -0500
Message-ID: <1298474681.13789.25.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-02-22 at 21:54 -0500, Eric Paris wrote:
> This reverts commit 242631c49d4cf39642741d6627750151b058233b.
> 
> Conflicts:
> 
> 	security/selinux/hooks.c
> 
> SELinux used to recognize certain individual ioctls and check
> permissions based on the knowledge of the individual ioctl.  In commit
> 242631c49d4cf396 the SELinux code stopped trying to understand
> individual ioctls and to instead looked at the ioctl access bits to
> determine in we should check read or write for that operation.  This
> same suggestion was made to SMACK (and I believe copied into TOMOYO).
> But this suggestion is total rubbish.  The ioctl access bits are
> actually the access requirements for the structure being passed into the
> ioctl, and are completely unrelated to the operation of the ioctl or the
> object the ioctl is being performed upon.
> 
> Take FS_IOC_FIEMAP as an example.  FS_IOC_FIEMAP is defined as:
> 
> FS_IOC_FIEMAP _IOWR('f', 11, struct fiemap)
> 
> So it has access bits R and W.  What this really means is that the
> kernel is going to both read and write to the struct fiemap.  It has
> nothing at all to do with the operations that this ioctl might perform
> on the file itself!
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

I would however recommend applying another patch on top that completely
removes all knowledge of specific ioctls (at least the ioctls beyond
those directly implemented by the vfs) from SELinux and just checks
FILE__IOCTL in all cases. You'll notice that the list of ioctls with
specific logic is rather outdated and limited in scope (ext2?).  

> ---
> 
>  security/selinux/hooks.c |   50 +++++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 42 insertions(+), 8 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 8cc5359..5e6b46a 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -24,9 +24,11 @@
>   */
>  
>  #include <linux/init.h>
> +#include <linux/kd.h>
>  #include <linux/kernel.h>
>  #include <linux/tracehook.h>
>  #include <linux/errno.h>
> +#include <linux/ext2_fs.h>
>  #include <linux/sched.h>
>  #include <linux/security.h>
>  #include <linux/xattr.h>
> @@ -36,6 +38,7 @@
>  #include <linux/mman.h>
>  #include <linux/slab.h>
>  #include <linux/pagemap.h>
> +#include <linux/proc_fs.h>
>  #include <linux/swap.h>
>  #include <linux/spinlock.h>
>  #include <linux/syscalls.h>
> @@ -2860,16 +2863,47 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
>  			      unsigned long arg)
>  {
>  	const struct cred *cred = current_cred();
> -	u32 av = 0;
> +	int error = 0;
>  
> -	if (_IOC_DIR(cmd) & _IOC_WRITE)
> -		av |= FILE__WRITE;
> -	if (_IOC_DIR(cmd) & _IOC_READ)
> -		av |= FILE__READ;
> -	if (!av)
> -		av = FILE__IOCTL;
> +	switch (cmd) {
> +	case FIONREAD:
> +	/* fall through */
> +	case FIBMAP:
> +	/* fall through */
> +	case FIGETBSZ:
> +	/* fall through */
> +	case EXT2_IOC_GETFLAGS:
> +	/* fall through */
> +	case EXT2_IOC_GETVERSION:
> +		error = file_has_perm(cred, file, FILE__GETATTR);
> +		break;
> +
> +	case EXT2_IOC_SETFLAGS:
> +	/* fall through */
> +	case EXT2_IOC_SETVERSION:
> +		error = file_has_perm(cred, file, FILE__SETATTR);
> +		break;
>  
> -	return file_has_perm(cred, file, av);
> +	/* sys_ioctl() checks */
> +	case FIONBIO:
> +	/* fall through */
> +	case FIOASYNC:
> +		error = file_has_perm(cred, file, 0);
> +		break;
> +
> +	case KDSKBENT:
> +	case KDSKBSENT:
> +		error = task_has_capability(current, cred, CAP_SYS_TTY_CONFIG,
> +					    SECURITY_CAP_AUDIT);
> +		break;
> +
> +	/* default case assumes that the command will go
> +	 * to the file's ioctl() function.
> +	 */
> +	default:
> +		error = file_has_perm(cred, file, FILE__IOCTL);
> +	}
> +	return error;
>  }
>  
>  static int default_noexec;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

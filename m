Message-ID: <53175F8B.7010704@tycho.nsa.gov>
Date: Wed, 05 Mar 2014 12:31:55 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Paul Moore <pmoore@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: correctly label /proc inodes in use before the
 policy is loaded
References: <20140305164407.16288.91349.stgit@localhost>
In-Reply-To: <20140305164407.16288.91349.stgit@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Cc: eparis@redhat.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/05/2014 11:44 AM, Paul Moore wrote:
> This patch is based on an earlier patch by Eric Paris, he describes
> the problem below:
> 
>   "If an inode is accessed before policy load it will get placed on a
>    list of inodes to be initialized after policy load.  After policy
>    load we call inode_doinit() which calls inode_doinit_with_dentry()
>    on all inodes accessed before policy load.  In the case of inodes
>    in procfs that means we'll end up at the bottom where it does:
> 
>      /* Default to the fs superblock SID. */
>      isec->sid = sbsec->sid;
> 
>      if ((sbsec->flags & SE_SBPROC) && !S_ISLNK(inode->i_mode)) {
>              if (opt_dentry) {
>                      isec->sclass = inode_mode_to_security_class(...)
>                      rc = selinux_proc_get_sid(opt_dentry,
>                                                isec->sclass,
>                                                &sid);
>                      if (rc)
>                              goto out_unlock;
>                      isec->sid = sid;
>              }
>      }
> 
>    Since opt_dentry is null, we'll never call selinux_proc_get_sid()
>    and will leave the inode labeled with the label on the superblock.
>    I believe a fix would be to mimic the behavior of xattrs.  Look
>    for an alias of the inode.  If it can't be found, just leave the
>    inode uninitialized (and pick it up later) if it can be found, we
>    should be able to call selinux_proc_get_sid() ..."
> 
> On a system exhibiting this problem, you will notice a lot of files in
> /proc with the generic "proc_t" type (at least the ones that were
> accessed early in the boot), for example:
> 
>    # ls -Z /proc/sys/kernel/shmmax | awk '{ print $4 " " $5 }'
>    system_u:object_r:proc_t:s0 /proc/sys/kernel/shmmax
> 
> However, with this patch in place we see the expected result:
> 
>    # ls -Z /proc/sys/kernel/shmmax | awk '{ print $4 " " $5 }'
>    system_u:object_r:sysctl_kernel_t:s0 /proc/sys/kernel/shmmax
> 
> Cc: Eric Paris <eparis@redhat.com>
> Signed-off-by: Paul Moore <pmoore@redhat.com>
> ---
>  security/selinux/hooks.c |   35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 57b0b49..d554e7e 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1419,15 +1419,32 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>  		isec->sid = sbsec->sid;
>  
>  		if ((sbsec->flags & SE_SBPROC) && !S_ISLNK(inode->i_mode)) {
> -			if (opt_dentry) {
> -				isec->sclass = inode_mode_to_security_class(inode->i_mode);
> -				rc = selinux_proc_get_sid(opt_dentry,
> -							  isec->sclass,
> -							  &sid);
> -				if (rc)
> -					goto out_unlock;
> -				isec->sid = sid;
> -			}
> +			/* Need a dentry, since the procfs API requires one. */

Comment isn't accurate; unlike the xattr case where the dentry
requirement originates from the ->getxattr API, here we need a dentry
for our own internal selinux_proc_get_sid() helper.  Otherwise, looks fine.

> +			if (opt_dentry)
> +				/* Called from d_instantiate or
> +				 * d_splice_alias. */
> +				dentry = dget(opt_dentry);
> +			else
> +				/* Called from selinux_complete_init, try to
> +				 * find a dentry. */
> +				dentry = d_find_alias(inode);
> +			/*
> +			 * This can be hit on boot when a file is accessed
> +			 * before the policy is loaded.  When we load policy we
> +			 * may find inodes that have no dentry on the
> +			 * sbsec->isec_head list.  No reason to complain as
> +			 * these will get fixed up the next time we go through
> +			 * inode_doinit() with a dentry, before these inodes
> +			 * could be used again by userspace.
> +			 */
> +			if (!dentry)
> +				goto out_unlock;
> +			isec->sclass = inode_mode_to_security_class(inode->i_mode);
> +			rc = selinux_proc_get_sid(dentry, isec->sclass, &sid);
> +			dput(dentry);
> +			if (rc)
> +				goto out_unlock;
> +			isec->sid = sid;
>  		}
>  		break;
>  	}
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
> 

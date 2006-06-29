Subject: Re: [RFC PATCH] 2/2 rootcontext=
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1151536181.26384.50.camel@localhost.localdomain>
References: <1151536181.26384.50.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 12:16:05 -0400
Message-Id: <1151597765.6999.107.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-06-28 at 19:09 -0400, Eric Paris wrote:
> The second patch will introduce a new rootcontext= option to mounting.
> This option will allow you to explicitly label the root inode of a FS
> being mounted.  This was found to be useful for things like stateless
> linux, see https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=190001
> I'd like some close eyes on this patch, specifically because I had to
> move the avc_has_perm() checks farther up the stack.  I'm also not sure
> even if we want perms on this operation.  Right now you need the same
> perms to use rootcontext= that you need to use chcon /mnt/point after
> you mount.  I'm also not sure if this might be a good mechanism to
> usefully mount a fs (with XATTR support) from a different machine that
> had contexts that may not even exist on the mounting machine.

Usually one would use context= aka mountpoint labeling for that purpose,
not just rootcontext=.

> 
>  hooks.c          |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  include/objsec.h |    1
>  2 files changed, 56 insertions(+), 1 deletion(-)

diffstat -p1 

> --- linux-2.6.17-rootcontext/security/selinux/hooks.c.decouple	2006-06-28 17:59:31.000000000 -0400
> +++ linux-2.6.17-rootcontext/security/selinux/hooks.c	2006-06-28 17:51:22.000000000 -0400
> @@ -407,6 +410,22 @@ static int try_context_mount(struct supe
>  				seen |= Opt_fscontext;
>  				break;
>  
> +			case Opt_rootcontext:
> +				if (seen & Opt_rootcontext) {
> +					rc = -EINVAL;
> +					printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
> +					goto out_free;
> +				}
> +				rootcontext = match_strdup(&args[0]);
> +				if (!rootcontext) {
> +					rc = -ENOMEM;
> +					goto out_free;
> +				}
> +				if (!alloc)
> +					alloc = 1;
> +				seen |= Opt_fscontext;

Wrong flag set above.  Which also happens to be the value of token.

> @@ -506,6 +525,23 @@ static int try_context_mount(struct supe
>  			sbsec->behavior = SECURITY_FS_USE_MNTPOINT;
>  	}
>  
> +	if (rootcontext) {
> +		rc = security_context_to_sid(rootcontext, strlen(rootcontext), &sid);
> +		if (rc) {
> +			printk(KERN_WARNING "SELinux: security_context_to_sid"
> +			       "(%s) failed for (dev %s, type %s) errno=%d\n",
> +			       rootcontext, sb->s_id, name, rc);
> +			goto out_free;
> +		}
> +
> +		/* 
> +		 * Security checking on this transition is done later in superblock_doinit()
> +		 * since we don't actually know the root inode context we are relabeling from
> +		 * until after inode_doinit_with_dentry() has been called on the root inode.
> +		 */
> +		sbsec->root_sid = sid;

I'd favor doing checking here, and paralleling the defcontext checks,
i.e. you still check relabelfrom to the superblock (which abstractly
represents setting any of these context options at mount time), and then
check associate between the root SID and the superblock to ensure that
they form a legal pair.  I doubt we'd care to distinguish the ability to
set rootcontext= from the ability to set defcontext= in the policy,
whereas I think we might care to distinguish between setting the root
inode security context to a particular value at mount time (before it is
user-accessible) versus relabeling it later.

> @@ -536,11 +572,14 @@ out_free:
>  		kfree(context);
>  		kfree(defcontext);
>  		kfree(fscontext);
> +		kfree(rootcontext);
>  	}
>  out:
>  	return rc;
>  }
>  
> +static int inode_security_set_sid(struct inode *inode, u32 sid);
> +
>  static int superblock_doinit(struct super_block *sb, void *data)
>  {
>  	struct superblock_security_struct *sbsec = sb->s_security;
> @@ -619,6 +658,20 @@ static int superblock_doinit(struct supe
>  	/* Initialize the root inode. */
>  	rc = inode_doinit_with_dentry(sb->s_root->d_inode, sb->s_root);
>  
> +	/* Set the context on the root inode if mounted with rootcontext= */
> +	if ((sbsec->root_sid != SECINITSID_UNLABELED) && !rc) {
> +		struct inode_security_struct *isec = sb->s_root->d_inode->i_security;
> +		struct task_security_struct *tsec = current->security;
> +
> +		rc = avc_has_perm(tsec->sid, isec->sid, SECCLASS_FILESYSTEM, 
> +			FILESYSTEM__RELABELFROM, NULL);
> +		if (!rc)
> +			rc = avc_has_perm(tsec->sid, sbsec->root_sid, SECCLASS_FILESYSTEM,
> +				FILESYSTEM__RELABELTO, NULL);
> +		if (!rc)
> +			inode_security_set_sid(sb->s_root->d_inode, sbsec->root_sid);
> +	}

I think that the mixing of inode SIDs with filesystem classes here will
cause confusion in the policy, so I wouldn't do this.  Note that the
actual file relabeling checks by setxattr are different - those are
against the isec->sclass.  If you set the root inode SID and its
initialized flag in try_context_mount, then inode_doinit should do
nothing here.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

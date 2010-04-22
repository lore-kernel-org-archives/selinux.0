Subject: Re: [PATCH] SELINUX: new permission controlling the ability to set
 suid
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <20100422204612.25506.16029.stgit@paris.rdu.redhat.com>
References: <20100422204612.25506.16029.stgit@paris.rdu.redhat.com>
Content-Type: text/plain
Date: Thu, 22 Apr 2010 17:35:55 -0400
Message-Id: <1271972155.16202.55.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-04-22 at 16:46 -0400, Eric Paris wrote:
> This patch adds a new permission, setsuid, to the file class.  This
> permission is checked any time a file has its attributes modified
> (setattr) and the setuid or setgid bits are involved.  The purpose for
> this change is to further allow selinux to confine administrative
> duties.
> 
> This permission is needed to both set the setuid bit and to add more
> permissions to a file which already has setuid bit.  This is also checked
> when an acl is modified on a file containing the suid or sgid bit.  We
> do not know if the acl is more or less restrictive, so we always check
> the permission on acl changes.

Can you help us all remember why you want this permission?  Specific use
case example, what threat you are mitigating, why it is sufficiently
important to justify an entirely new permission dedicated to it.

If we add this permission for this purpose, why wouldn't we also add
distinct permissions for other DAC purposes, e.g. suid-root vs.
suid-nonroot, suid vs sgid, sticky bit, setting vs clearing, making a
file executable, ...?  Where does it stop?

I'm also not keen on overloading it to also cover other changes to the
mode/ACL.  Presumably that is to constrain extending execute access to
an existing suid file more widely than originally set?  Write access
should kill suid/sgid bits.  Read access is perhaps a concern, but
relying on unreadable executables isn't a good idea.

Can you write a description of this permission and how it differs from
setattr permission in a way that will make sense to a typical Linux
admin?  

> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
> 
>  security/selinux/hooks.c            |   38 ++++++++++++++++++++++++++++++-----
>  security/selinux/include/classmap.h |    2 +-
>  2 files changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 26b0a8a..bab6061 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -76,6 +76,7 @@
>  #include <linux/selinux.h>
>  #include <linux/mutex.h>
>  #include <linux/posix-timers.h>
> +#include <linux/posix_acl_xattr.h>
>  #include <linux/syslog.h>
>  
>  #include "avc.h"
> @@ -2728,6 +2729,9 @@ static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
>  {
>  	const struct cred *cred = current_cred();
>  	unsigned int ia_valid = iattr->ia_valid;
> +	unsigned int mode = dentry->d_inode->i_mode;
> +	unsigned int ia_mode = iattr->ia_mode;
> +	u32 av = 0;
>  
>  	/* ATTR_FORCE is just used for ATTR_KILL_S[UG]ID. */
>  	if (ia_valid & ATTR_FORCE) {
> @@ -2737,11 +2741,28 @@ static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
>  			return 0;
>  	}
>  
> -	if (ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID |
> -			ATTR_ATIME_SET | ATTR_MTIME_SET | ATTR_TIMES_SET))
> -		return dentry_has_perm(cred, NULL, dentry, FILE__SETATTR);
> +	/*
> +	 * are we changing mode?
> +	 * is this a regular file?
> +	 * do resulting iattr->i_mode have the suid/gid bits set?
> +	 */
> +	if ((iattr->ia_valid & ATTR_MODE) &&
> +	    (S_ISREG(mode)) &&
> +	    (ia_mode & (S_ISUID | S_ISGID))) {
> +		/* calculate what bits are being added (if any) */
> +		unsigned int new_bits = ((mode ^ ia_mode) & ia_mode);
> +		if (new_bits)
> +			av |= FILE__SETSUID;
> +	}
> +
> +	if (iattr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID |
> +			       ATTR_ATIME_SET | ATTR_MTIME_SET))

Logic changed in the ATTR_TIMES_SET case?

> +		av |= FILE__SETATTR;
> +	else
> +		av |= FILE__WRITE;
> +
> +	return dentry_has_perm(cred, NULL, dentry, av);
>  
> -	return dentry_has_perm(cred, NULL, dentry, FILE__WRITE);
>  }
>  
>  static int selinux_inode_getattr(struct vfsmount *mnt, struct dentry *dentry)
> @@ -2754,6 +2775,7 @@ static int selinux_inode_getattr(struct vfsmount *mnt, struct dentry *dentry)
>  static int selinux_inode_setotherxattr(struct dentry *dentry, const char *name)
>  {
>  	const struct cred *cred = current_cred();
> +	u32 av = FILE__SETATTR;
>  
>  	if (!strncmp(name, XATTR_SECURITY_PREFIX,
>  		     sizeof XATTR_SECURITY_PREFIX - 1)) {
> @@ -2765,11 +2787,17 @@ static int selinux_inode_setotherxattr(struct dentry *dentry, const char *name)
>  			   Restrict to administrator. */
>  			return -EPERM;
>  		}
> +	} else if ((dentry->d_inode->i_mode & (S_ISUID | S_ISGID)) &&
> +		   (!strncmp(name, POSIX_ACL_XATTR_ACCESS,
> +			     sizeof(POSIX_ACL_XATTR_ACCESS) - 1))) {
> +			/* changing access acl on a file with setuid/segid
> +			 * requires FILE_SETSUID */
> +			av |= FILE__SETSUID;
>  	}
>  
>  	/* Not an attribute we recognize, so just check the
>  	   ordinary setattr permission. */
> -	return dentry_has_perm(cred, NULL, dentry, FILE__SETATTR);
> +	return dentry_has_perm(cred, NULL, dentry, av);
>  }
>  
>  static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index b4c9eb4..503b23e 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -44,7 +44,7 @@ struct security_class_mapping secclass_map[] = {
>  	    "quotaget", NULL } },
>  	{ "file",
>  	  { COMMON_FILE_PERMS,
> -	    "execute_no_trans", "entrypoint", NULL } },
> +	    "execute_no_trans", "entrypoint", "setsuid", NULL } },
>  	{ "dir",
>  	  { COMMON_FILE_PERMS, "add_name", "remove_name",
>  	    "reparent", "search", "rmdir", NULL } },
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

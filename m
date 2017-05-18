Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4IG4NEp005421
 for <selinux@tycho.nsa.gov>; Thu, 18 May 2017 12:04:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id d127so12246922wmf.1
 for <selinux@tycho.nsa.gov>; Thu, 18 May 2017 09:04:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170512164124.16981-1-sds@tycho.nsa.gov>
References: <20170512164124.16981-1-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 18 May 2017 12:04:14 -0400
Message-ID: <CAHC9VhQa01JcPQTJ2LzJdCZH7WmmxUgp-d_gk0SHn9OqMHQZAQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: do not check open permission on sockets
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, May 12, 2017 at 12:41 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> open permission is currently only defined for files in the kernel
> (COMMON_FILE_PERMS rather than COMMON_FILE_SOCK_PERMS). Construction of
> an artificial test case that tries to open a socket via /proc/pid/fd will
> generate a recvfrom avc denial because recvfrom and open happen to map to
> the same permission bit in socket vs file classes.
>
> open of a socket via /proc/pid/fd is not supported by the kernel regardless
> and will ultimately return ENXIO. But we hit the permission check first and
> can thus produce these odd/misleading denials.  Omit the open check when
> operating on a socket.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e67a526..dd356ed 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2063,8 +2063,9 @@ static inline u32 file_to_av(struct file *file)
>  static inline u32 open_file_to_av(struct file *file)
>  {
>         u32 av = file_to_av(file);
> +       struct inode *inode = file_inode(file);
>
> -       if (selinux_policycap_openperm)
> +       if (selinux_policycap_openperm && inode->i_sb->s_magic != SOCKFS_MAGIC)
>                 av |= FILE__OPEN;

No real objection to this patch, I'm just wondering if we are better
served by only adding the open permission on a specific whitelist of
object classes?  From a practical point of view it probably has little
impact either way and one check to rule out sockets is arguably faster
than checking a handful of object classes, but I wonder how likely it
would be that we would ever see someone trying to open other non-file
objects and hitting this code?

Also, as an aside, it seems rather odd that we don't have a macro
somewhere to check if an inode is a socket.  Oh well.

>         return av;
> @@ -3059,6 +3060,7 @@ static int selinux_inode_permission(struct inode *inode, int mask)
>  static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
>  {
>         const struct cred *cred = current_cred();
> +       struct inode *inode = d_backing_inode(dentry);
>         unsigned int ia_valid = iattr->ia_valid;
>         __u32 av = FILE__WRITE;
>
> @@ -3074,8 +3076,10 @@ static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
>                         ATTR_ATIME_SET | ATTR_MTIME_SET | ATTR_TIMES_SET))
>                 return dentry_has_perm(cred, dentry, FILE__SETATTR);
>
> -       if (selinux_policycap_openperm && (ia_valid & ATTR_SIZE)
> -                       && !(ia_valid & ATTR_FILE))
> +       if (selinux_policycap_openperm &&
> +           inode->i_sb->s_magic != SOCKFS_MAGIC &&
> +           (ia_valid & ATTR_SIZE) &&
> +           !(ia_valid & ATTR_FILE))
>                 av |= FILE__OPEN;
>
>         return dentry_has_perm(cred, dentry, av);
> --
> 2.9.3
>

-- 
paul moore
www.paul-moore.com

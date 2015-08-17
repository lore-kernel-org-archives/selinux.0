Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t7HGZL2M015185
 for <selinux@tycho.nsa.gov>; Mon, 17 Aug 2015 12:35:22 -0400
Received: by pdbfa8 with SMTP id fa8so57507717pdb.1
 for <selinux@tycho.nsa.gov>; Mon, 17 Aug 2015 09:35:19 -0700 (PDT)
Date: Mon, 17 Aug 2015 09:35:17 -0700
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Jeff Layton <jlayton@poochiereds.net>,
 "J. Bruce Fields" <bfields@fieldses.org>
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 Andy Lutomirski <luto@amacapital.net>, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 2/7] userns: Simpilify MNT_NODEV handling.
Message-ID: <20150817163517.GB2976@ubuntu-xps13>
References: <1439240719-46850-1-git-send-email-seth.forshee@canonical.com>
 <1439240719-46850-3-git-send-email-seth.forshee@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1439240719-46850-3-git-send-email-seth.forshee@canonical.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Aug 10, 2015 at 04:05:13PM -0500, Seth Forshee wrote:
> From: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> - Consolidate the testing if a device node may be opened in a new
>   function may_open_dev.
> 
> - Move the check for allowing access to device nodes on filesystems
>   not mounted in the initial user namespace from mount time to open
>   time and include it in may_open_dev.
> 
> This set of changes removes the implicit adding of MNT_NODEV which
> simplifies the logic in fs/namespace.c and removes a potentially
> problematic user visible difference in how normal and unprivileged
> mount namespaces work.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  fs/block_dev.c     |  2 +-
>  fs/namei.c         |  9 ++++++++-
>  fs/namespace.c     | 18 ++++--------------
>  include/linux/fs.h |  1 +
>  4 files changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 198243717da5..f8ce371c437c 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1729,7 +1729,7 @@ struct block_device *lookup_bdev(const char *pathname)
>  	if (!S_ISBLK(inode->i_mode))
>  		goto fail;
>  	error = -EACCES;
> -	if (path.mnt->mnt_flags & MNT_NODEV)
> +	if (!may_open_dev(&path))
>  		goto fail;
>  	error = -ENOMEM;
>  	bdev = bd_acquire(inode);
> diff --git a/fs/namei.c b/fs/namei.c
> index fbbcf0993312..59444c066f47 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2640,6 +2640,13 @@ int vfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
>  }
>  EXPORT_SYMBOL(vfs_create);
>  
> +bool may_open_dev(const struct path *path)
> +{
> +	return !(path->mnt->mnt_flags & MNT_NODEV) &&
> +		((path->mnt->mnt_sb->s_user_ns == &init_user_ns) ||
> +		 (path->mnt->mnt_sb->s_type->fs_flags & FS_USERNS_DEV_MOUNT));
> +}
> +
>  static int may_open(struct path *path, int acc_mode, int flag)
>  {
>  	struct dentry *dentry = path->dentry;
> @@ -2662,7 +2669,7 @@ static int may_open(struct path *path, int acc_mode, int flag)
>  		break;
>  	case S_IFBLK:
>  	case S_IFCHR:
> -		if (path->mnt->mnt_flags & MNT_NODEV)
> +		if (!may_open_dev(path))
>  			return -EACCES;
>  		/*FALLTHRU*/
>  	case S_IFIFO:
> diff --git a/fs/namespace.c b/fs/namespace.c
> index d023a353dc63..e48fa1c23378 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2177,13 +2177,7 @@ static int do_remount(struct path *path, int flags, int mnt_flags,
>  	}
>  	if ((mnt->mnt.mnt_flags & MNT_LOCK_NODEV) &&
>  	    !(mnt_flags & MNT_NODEV)) {
> -		/* Was the nodev implicitly added in mount? */
> -		if ((mnt->mnt_ns->user_ns != &init_user_ns) &&
> -		    !(sb->s_type->fs_flags & FS_USERNS_DEV_MOUNT)) {
> -			mnt_flags |= MNT_NODEV;
> -		} else {
> -			return -EPERM;
> -		}
> +		return -EPERM;
>  	}
>  	if ((mnt->mnt.mnt_flags & MNT_LOCK_NOSUID) &&
>  	    !(mnt_flags & MNT_NOSUID)) {
> @@ -2396,13 +2390,6 @@ static int do_new_mount(struct path *path, const char *fstype, int flags,
>  			put_filesystem(type);
>  			return -EPERM;
>  		}
> -		/* Only in special cases allow devices from mounts
> -		 * created outside the initial user namespace.
> -		 */
> -		if (!(type->fs_flags & FS_USERNS_DEV_MOUNT)) {
> -			flags |= MS_NODEV;
> -			mnt_flags |= MNT_NODEV | MNT_LOCK_NODEV;
> -		}
>  		if (type->fs_flags & FS_USERNS_VISIBLE) {
>  			if (!fs_fully_visible(type, &mnt_flags))
>  				return -EPERM;
> @@ -3238,6 +3225,9 @@ static bool fs_fully_visible(struct file_system_type *type, int *new_mnt_flags)
>  		mnt_flags = mnt->mnt.mnt_flags;
>  		if (mnt->mnt.mnt_sb->s_iflags & SB_I_NOEXEC)
>  			mnt_flags &= ~(MNT_LOCK_NOSUID | MNT_LOCK_NOEXEC);
> +		if (current_user_ns() != &init_user_ns &&
> +		    !(mnt->mnt.mnt_sb->s_type->fs_flags & FS_USERNS_DEV_MOUNT))
> +			mnt_flags &= ~(MNT_LOCK_NODEV);

Oops, this should be s_user_ns and not current_user_ns(). I think I had
to change it when I had made changes to make sysfs, etc. use s_user_ns =
&init_user_ns and then frogot to change it back.

Seth

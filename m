MIME-Version: 1.0
In-Reply-To: <20100409221614.2681.64052.stgit@paris.rdu.redhat.com>
References: <20100409221614.2681.64052.stgit@paris.rdu.redhat.com>
Date: Thu, 6 May 2010 13:42:41 -0400
Message-ID: <j2w7e0fb38c1005061042nfd8a38fdgc28522e2dcf7588e@mail.gmail.com>
Subject: Re: [PATCH 1/3] vfs: re-introduce MAY_CHDIR
From: Eric Paris <eparis@parisplace.org>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org, jmorris@namei.org,
        sds@tycho.nsa.gov, casey@schaufler-ca.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Apr 9, 2010 at 6:16 PM, Eric Paris <eparis@redhat.com> wrote:
> Currently MAY_ACCESS means that filesystems must check the permissions
> right then and not rely on cached results or the results of future
> operations on the object.  This can be because of a call to sys_access() or
> because of a call to chdir() which needs to check search without relying on
> any future operations inside that dir.  I plan to use MAY_ACCESS for other
> purposes in the security system, so I split the MAY_ACCESS and the
> MAY_CHDIR cases.

Does anyone, ?Al? have a problem with this patch?  If I hear no
objections I'm going to ask James to push it through the security
tree, but I'd really like to hear any VFS person say they don't mind
before doing so.  It's obviously safe and doesn't change VFS behaviour
at all, but maybe there is some better way to indicate to the LSM that
a call came from access(2) rather than read/write.

-Eric

>
> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
>
>  fs/fuse/dir.c      |    2 +-
>  fs/nfs/dir.c       |    2 +-
>  fs/open.c          |    6 +++---
>  include/linux/fs.h |    1 +
>  4 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 4787ae6..7c8c55b 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1016,7 +1016,7 @@ static int fuse_permission(struct inode *inode, int mask)
>                   exist.  So if permissions are revoked this won't be
>                   noticed immediately, only after the attribute
>                   timeout has expired */
> -       } else if (mask & MAY_ACCESS) {
> +       } else if (mask & (MAY_ACCESS | MAY_CHDIR)) {
>                err = fuse_access(inode, mask);
>        } else if ((mask & MAY_EXEC) && S_ISREG(inode->i_mode)) {
>                if (!(inode->i_mode & S_IXUGO)) {
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index be46f26..4c7d8fc 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -1927,7 +1927,7 @@ int nfs_permission(struct inode *inode, int mask)
>        if ((mask & (MAY_READ | MAY_WRITE | MAY_EXEC)) == 0)
>                goto out;
>        /* Is this sys_access() ? */
> -       if (mask & MAY_ACCESS)
> +       if (mask & (MAY_ACCESS | MAY_CHDIR))
>                goto force_lookup;
>
>        switch (inode->i_mode & S_IFMT) {
> diff --git a/fs/open.c b/fs/open.c
> index b93eac3..d01e116 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -534,7 +534,7 @@ SYSCALL_DEFINE1(chdir, const char __user *, filename)
>        if (error)
>                goto out;
>
> -       error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_ACCESS);
> +       error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
>        if (error)
>                goto dput_and_out;
>
> @@ -563,7 +563,7 @@ SYSCALL_DEFINE1(fchdir, unsigned int, fd)
>        if (!S_ISDIR(inode->i_mode))
>                goto out_putf;
>
> -       error = inode_permission(inode, MAY_EXEC | MAY_ACCESS);
> +       error = inode_permission(inode, MAY_EXEC | MAY_CHDIR);
>        if (!error)
>                set_fs_pwd(current->fs, &file->f_path);
>  out_putf:
> @@ -581,7 +581,7 @@ SYSCALL_DEFINE1(chroot, const char __user *, filename)
>        if (error)
>                goto out;
>
> -       error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_ACCESS);
> +       error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
>        if (error)
>                goto dput_and_out;
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 14d8597..188d3e4 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -53,6 +53,7 @@ struct inodes_stat_t {
>  #define MAY_APPEND 8
>  #define MAY_ACCESS 16
>  #define MAY_OPEN 32
> +#define MAY_CHDIR 64
>
>  /*
>  * flags in file.f_mode.  Note that FMODE_READ and FMODE_WRITE must correspond
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

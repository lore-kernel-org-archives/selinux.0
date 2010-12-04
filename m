Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oB44LDtL014839
	for <selinux@tycho.nsa.gov>; Fri, 3 Dec 2010 23:21:14 -0500
Received: from smtp109.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id oB44LAiV001423
	for <selinux@tycho.nsa.gov>; Sat, 4 Dec 2010 04:21:11 GMT
Message-ID: <4CF9C1A1.7050603@schaufler-ca.com>
Date: Fri, 03 Dec 2010 20:20:49 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org,
        linux-security-module@vger.kernel.org, viro@zeniv.linux.org.uk,
        hch@lst.de, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC PATCH 1/2] fs/vfs/security: pass last path component to
 LSM on	inode creation
References: <20101203214518.30001.89859.stgit@paris.rdu.redhat.com>
In-Reply-To: <20101203214518.30001.89859.stgit@paris.rdu.redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/3/2010 1:45 PM, Eric Paris wrote:
> SELinux would like to implement a new labeling behavior of newly created
> inodes.  We currently label new inodes based on the parent and the creating
> process.  This new behavior would also take into account the name of the
> new object when deciding the new label.  This is not the (supposed) full path,
> just the last component of the path.

I see. Pathname based controls. In SELinux.

> This is very useful because creating /etc/shadow is different than creating
> /etc/passwd but the kernel hooks are unable to differentiate these
> operations.

If I recall correctly, this has been the Apparmor/TOMOYO argument all along.

> We currently require that userspace realize it is doing some
> difficult operation like that and that userspace jump through SELinux hoops
> to get things set up correctly.  This patch does not implement new
> behavior, that is obviously contained in a seperate SELinux patch, but it
> does pass the needed name down to the correct LSM hook.  If no such name
> exists it is fine to pass NULL.

Why can't you use the existing pathname hooks?

If you want pathname based behavior there are already two perfectly good
LSMs that do that. Why do we need a third? Especially when the people who
run SELinux have been so adamant that name based access controls have no
place in the kernel?

Sure, you're just talking about the final component, but that's because
you've already done user space labeling of the entire file system and are
counting on standardized directory structures. Let's face it, outside the
context of a specific distribution and an SELinux policy tailored to that
distribution, final component name based controls do not have any kind of
generality.

If you really have seen the light and believe that pathname based access
controls have merit a scheme that is half based on labels and half based
on final components can't possibly seem satisfactory.

Or am I missing something?


> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
>
>  fs/btrfs/inode.c               |   11 ++++++-----
>  fs/btrfs/xattr.c               |    3 ++-
>  fs/btrfs/xattr.h               |    1 +
>  fs/ext2/ext2.h                 |    2 +-
>  fs/ext2/ialloc.c               |    4 ++--
>  fs/ext2/namei.c                |    8 ++++----
>  fs/ext2/xattr.h                |    4 ++--
>  fs/ext2/xattr_security.c       |    4 ++--
>  fs/ext3/ialloc.c               |    5 +++--
>  fs/ext3/namei.c                |    8 ++++----
>  fs/ext3/xattr.h                |    8 ++++----
>  fs/ext3/xattr_security.c       |    5 +++--
>  fs/ext4/ialloc.c               |    2 +-
>  fs/ext4/migrate.c              |    2 +-
>  fs/ext4/xattr.h                |    8 ++++----
>  fs/ext4/xattr_security.c       |    5 +++--
>  fs/gfs2/inode.c                |    7 ++++---
>  fs/jffs2/dir.c                 |    9 ++++-----
>  fs/jffs2/nodelist.h            |    2 +-
>  fs/jffs2/security.c            |    5 +++--
>  fs/jffs2/write.c               |   16 ++++++++--------
>  fs/jffs2/xattr.h               |    5 +++--
>  fs/jfs/jfs_xattr.h             |    5 +++--
>  fs/jfs/namei.c                 |    8 ++++----
>  fs/jfs/xattr.c                 |    5 +++--
>  fs/ocfs2/namei.c               |    4 ++--
>  fs/ocfs2/refcounttree.c        |    3 ++-
>  fs/ocfs2/xattr.c               |   12 +++++++-----
>  fs/ocfs2/xattr.h               |    6 ++++--
>  fs/reiserfs/namei.c            |    8 ++++----
>  fs/reiserfs/xattr_security.c   |    5 +++--
>  fs/xfs/linux-2.6/xfs_iops.c    |    9 +++++----
>  include/linux/ext3_fs.h        |    2 +-
>  include/linux/reiserfs_xattr.h |    6 ++++--
>  include/linux/security.h       |   13 ++++++++-----
>  mm/shmem.c                     |    8 ++++----
>  security/capability.c          |    5 +++--
>  security/security.c            |    8 +++++---
>  security/selinux/hooks.c       |    6 +++---
>  security/smack/smack_lsm.c     |    6 ++++--
>  40 files changed, 135 insertions(+), 108 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 8039390..7a993ad 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -90,13 +90,14 @@ static noinline int cow_file_range(struct inode *inode,
>  				   unsigned long *nr_written, int unlock);
>  
>  static int btrfs_init_inode_security(struct btrfs_trans_handle *trans,
> +				     const struct qstr *qstr,
>  				     struct inode *inode,  struct inode *dir)
>  {
>  	int err;
>  
>  	err = btrfs_init_acl(trans, inode, dir);
>  	if (!err)
> -		err = btrfs_xattr_security_init(trans, inode, dir);
> +		err = btrfs_xattr_security_init(trans, qstr, inode, dir);
>  	return err;
>  }
>  
> @@ -4675,7 +4676,7 @@ static int btrfs_mknod(struct inode *dir, struct dentry *dentry,
>  	if (IS_ERR(inode))
>  		goto out_unlock;
>  
> -	err = btrfs_init_inode_security(trans, inode, dir);
> +	err = btrfs_init_inode_security(trans, &dentry->d_name, inode, dir);
>  	if (err) {
>  		drop_inode = 1;
>  		goto out_unlock;
> @@ -4736,7 +4737,7 @@ static int btrfs_create(struct inode *dir, struct dentry *dentry,
>  	if (IS_ERR(inode))
>  		goto out_unlock;
>  
> -	err = btrfs_init_inode_security(trans, inode, dir);
> +	err = btrfs_init_inode_security(trans, &dentry->d_name, inode, dir);
>  	if (err) {
>  		drop_inode = 1;
>  		goto out_unlock;
> @@ -4864,7 +4865,7 @@ static int btrfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
>  
>  	drop_on_err = 1;
>  
> -	err = btrfs_init_inode_security(trans, inode, dir);
> +	err = btrfs_init_inode_security(trans, &dentry->d_name, inode, dir);
>  	if (err)
>  		goto out_fail;
>  
> @@ -6940,7 +6941,7 @@ static int btrfs_symlink(struct inode *dir, struct dentry *dentry,
>  	if (IS_ERR(inode))
>  		goto out_unlock;
>  
> -	err = btrfs_init_inode_security(trans, inode, dir);
> +	err = btrfs_init_inode_security(trans, &dentry->d_name, inode, dir);
>  	if (err) {
>  		drop_inode = 1;
>  		goto out_unlock;
> diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
> index 698fdd2..7e9dd88 100644
> --- a/fs/btrfs/xattr.c
> +++ b/fs/btrfs/xattr.c
> @@ -352,6 +352,7 @@ int btrfs_removexattr(struct dentry *dentry, const char *name)
>  }
>  
>  int btrfs_xattr_security_init(struct btrfs_trans_handle *trans,
> +			      const struct qstr *qstr,
>  			      struct inode *inode, struct inode *dir)
>  {
>  	int err;
> @@ -360,7 +361,7 @@ int btrfs_xattr_security_init(struct btrfs_trans_handle *trans,
>  	char *suffix;
>  	char *name;
>  
> -	err = security_inode_init_security(inode, dir, &suffix, &value, &len);
> +	err = security_inode_init_security(qstr, inode, dir, &suffix, &value, &len);
>  	if (err) {
>  		if (err == -EOPNOTSUPP)
>  			return 0;
> diff --git a/fs/btrfs/xattr.h b/fs/btrfs/xattr.h
> index 7a43fd6..1e1d9b0 100644
> --- a/fs/btrfs/xattr.h
> +++ b/fs/btrfs/xattr.h
> @@ -37,6 +37,7 @@ extern int btrfs_setxattr(struct dentry *dentry, const char *name,
>  extern int btrfs_removexattr(struct dentry *dentry, const char *name);
>  
>  extern int btrfs_xattr_security_init(struct btrfs_trans_handle *trans,
> +				     const struct qstr *qstr,
>  				     struct inode *inode, struct inode *dir);
>  
>  #endif /* __XATTR__ */
> diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
> index 6346a2a..1b48c33 100644
> --- a/fs/ext2/ext2.h
> +++ b/fs/ext2/ext2.h
> @@ -110,7 +110,7 @@ extern struct ext2_dir_entry_2 * ext2_dotdot (struct inode *, struct page **);
>  extern void ext2_set_link(struct inode *, struct ext2_dir_entry_2 *, struct page *, struct inode *, int);
>  
>  /* ialloc.c */
> -extern struct inode * ext2_new_inode (struct inode *, int);
> +extern struct inode * ext2_new_inode (struct inode *, int, const struct qstr *);
>  extern void ext2_free_inode (struct inode *);
>  extern unsigned long ext2_count_free_inodes (struct super_block *);
>  extern void ext2_check_inodes_bitmap (struct super_block *);
> diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
> index ad70479..5be2348 100644
> --- a/fs/ext2/ialloc.c
> +++ b/fs/ext2/ialloc.c
> @@ -429,7 +429,7 @@ found:
>  	return group;
>  }
>  
> -struct inode *ext2_new_inode(struct inode *dir, int mode)
> +struct inode *ext2_new_inode(struct inode *dir, int mode, const struct qstr *qstr)
>  {
>  	struct super_block *sb;
>  	struct buffer_head *bitmap_bh = NULL;
> @@ -585,7 +585,7 @@ got:
>  	if (err)
>  		goto fail_free_drop;
>  
> -	err = ext2_init_security(inode,dir);
> +	err = ext2_init_security(qstr, inode, dir);
>  	if (err)
>  		goto fail_free_drop;
>  
> diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
> index f8aecd2..368d704 100644
> --- a/fs/ext2/namei.c
> +++ b/fs/ext2/namei.c
> @@ -104,7 +104,7 @@ static int ext2_create (struct inode * dir, struct dentry * dentry, int mode, st
>  
>  	dquot_initialize(dir);
>  
> -	inode = ext2_new_inode(dir, mode);
> +	inode = ext2_new_inode(dir, mode, &dentry->d_name);
>  	if (IS_ERR(inode))
>  		return PTR_ERR(inode);
>  
> @@ -133,7 +133,7 @@ static int ext2_mknod (struct inode * dir, struct dentry *dentry, int mode, dev_
>  
>  	dquot_initialize(dir);
>  
> -	inode = ext2_new_inode (dir, mode);
> +	inode = ext2_new_inode (dir, mode, &dentry->d_name);
>  	err = PTR_ERR(inode);
>  	if (!IS_ERR(inode)) {
>  		init_special_inode(inode, inode->i_mode, rdev);
> @@ -159,7 +159,7 @@ static int ext2_symlink (struct inode * dir, struct dentry * dentry,
>  
>  	dquot_initialize(dir);
>  
> -	inode = ext2_new_inode (dir, S_IFLNK | S_IRWXUGO);
> +	inode = ext2_new_inode (dir, S_IFLNK | S_IRWXUGO, &dentry->d_name);
>  	err = PTR_ERR(inode);
>  	if (IS_ERR(inode))
>  		goto out;
> @@ -230,7 +230,7 @@ static int ext2_mkdir(struct inode * dir, struct dentry * dentry, int mode)
>  
>  	inode_inc_link_count(dir);
>  
> -	inode = ext2_new_inode (dir, S_IFDIR | mode);
> +	inode = ext2_new_inode(dir, S_IFDIR | mode, &dentry->d_name);
>  	err = PTR_ERR(inode);
>  	if (IS_ERR(inode))
>  		goto out_dir;
> diff --git a/fs/ext2/xattr.h b/fs/ext2/xattr.h
> index a1a1c21..7460429 100644
> --- a/fs/ext2/xattr.h
> +++ b/fs/ext2/xattr.h
> @@ -116,9 +116,9 @@ exit_ext2_xattr(void)
>  # endif  /* CONFIG_EXT2_FS_XATTR */
>  
>  #ifdef CONFIG_EXT2_FS_SECURITY
> -extern int ext2_init_security(struct inode *inode, struct inode *dir);
> +extern int ext2_init_security(const struct qstr *qstr, struct inode *inode, struct inode *dir);
>  #else
> -static inline int ext2_init_security(struct inode *inode, struct inode *dir)
> +static inline int ext2_init_security(const struct qstr *qstr, struct inode *inode, struct inode *dir)
>  {
>  	return 0;
>  }
> diff --git a/fs/ext2/xattr_security.c b/fs/ext2/xattr_security.c
> index 3004e15..e06c1c9 100644
> --- a/fs/ext2/xattr_security.c
> +++ b/fs/ext2/xattr_security.c
> @@ -47,14 +47,14 @@ ext2_xattr_security_set(struct dentry *dentry, const char *name,
>  }
>  
>  int
> -ext2_init_security(struct inode *inode, struct inode *dir)
> +ext2_init_security(const struct qstr *qstr, struct inode *inode, struct inode *dir)
>  {
>  	int err;
>  	size_t len;
>  	void *value;
>  	char *name;
>  
> -	err = security_inode_init_security(inode, dir, &name, &value, &len);
> +	err = security_inode_init_security(qstr, inode, dir, &name, &value, &len);
>  	if (err) {
>  		if (err == -EOPNOTSUPP)
>  			return 0;
> diff --git a/fs/ext3/ialloc.c b/fs/ext3/ialloc.c
> index 9724aef..7fb0940 100644
> --- a/fs/ext3/ialloc.c
> +++ b/fs/ext3/ialloc.c
> @@ -404,7 +404,8 @@ static int find_group_other(struct super_block *sb, struct inode *parent)
>   * For other inodes, search forward from the parent directory's block
>   * group to find a free inode.
>   */
> -struct inode *ext3_new_inode(handle_t *handle, struct inode * dir, int mode)
> +struct inode *ext3_new_inode(handle_t *handle, struct inode * dir,
> +			     const struct qstr *qstr, int mode)
>  {
>  	struct super_block *sb;
>  	struct buffer_head *bitmap_bh = NULL;
> @@ -589,7 +590,7 @@ got:
>  	if (err)
>  		goto fail_free_drop;
>  
> -	err = ext3_init_security(handle,inode, dir);
> +	err = ext3_init_security(handle, qstr, inode, dir);
>  	if (err)
>  		goto fail_free_drop;
>  
> diff --git a/fs/ext3/namei.c b/fs/ext3/namei.c
> index bce9dce..a900033 100644
> --- a/fs/ext3/namei.c
> +++ b/fs/ext3/namei.c
> @@ -1707,7 +1707,7 @@ retry:
>  	if (IS_DIRSYNC(dir))
>  		handle->h_sync = 1;
>  
> -	inode = ext3_new_inode (handle, dir, mode);
> +	inode = ext3_new_inode (handle, dir, &dentry->d_name, mode);
>  	err = PTR_ERR(inode);
>  	if (!IS_ERR(inode)) {
>  		inode->i_op = &ext3_file_inode_operations;
> @@ -1743,7 +1743,7 @@ retry:
>  	if (IS_DIRSYNC(dir))
>  		handle->h_sync = 1;
>  
> -	inode = ext3_new_inode (handle, dir, mode);
> +	inode = ext3_new_inode (handle, dir, &dentry->d_name, mode);
>  	err = PTR_ERR(inode);
>  	if (!IS_ERR(inode)) {
>  		init_special_inode(inode, inode->i_mode, rdev);
> @@ -1781,7 +1781,7 @@ retry:
>  	if (IS_DIRSYNC(dir))
>  		handle->h_sync = 1;
>  
> -	inode = ext3_new_inode (handle, dir, S_IFDIR | mode);
> +	inode = ext3_new_inode (handle, dir, &dentry->d_name, S_IFDIR | mode);
>  	err = PTR_ERR(inode);
>  	if (IS_ERR(inode))
>  		goto out_stop;
> @@ -2195,7 +2195,7 @@ retry:
>  	if (IS_DIRSYNC(dir))
>  		handle->h_sync = 1;
>  
> -	inode = ext3_new_inode (handle, dir, S_IFLNK|S_IRWXUGO);
> +	inode = ext3_new_inode (handle, dir, &dentry->d_name, S_IFLNK|S_IRWXUGO);
>  	err = PTR_ERR(inode);
>  	if (IS_ERR(inode))
>  		goto out_stop;
> diff --git a/fs/ext3/xattr.h b/fs/ext3/xattr.h
> index 377fe72..7cb86ba 100644
> --- a/fs/ext3/xattr.h
> +++ b/fs/ext3/xattr.h
> @@ -127,11 +127,11 @@ exit_ext3_xattr(void)
>  # endif  /* CONFIG_EXT3_FS_XATTR */
>  
>  #ifdef CONFIG_EXT3_FS_SECURITY
> -extern int ext3_init_security(handle_t *handle, struct inode *inode,
> -				struct inode *dir);
> +extern int ext3_init_security(handle_t *handle, const struct qstr *qstr,
> +				struct inode *inode, struct inode *dir);
>  #else
> -static inline int ext3_init_security(handle_t *handle, struct inode *inode,
> -				struct inode *dir)
> +static inline int ext3_init_security(handle_t *handle, const struct qstr *qstr,
> +				struct inode *inode, struct inode *dir)
>  {
>  	return 0;
>  }
> diff --git a/fs/ext3/xattr_security.c b/fs/ext3/xattr_security.c
> index 03a99bf..c0159b3 100644
> --- a/fs/ext3/xattr_security.c
> +++ b/fs/ext3/xattr_security.c
> @@ -49,14 +49,15 @@ ext3_xattr_security_set(struct dentry *dentry, const char *name,
>  }
>  
>  int
> -ext3_init_security(handle_t *handle, struct inode *inode, struct inode *dir)
> +ext3_init_security(handle_t *handle, const struct qstr *qstr, struct inode *inode,
> +		struct inode *dir)
>  {
>  	int err;
>  	size_t len;
>  	void *value;
>  	char *name;
>  
> -	err = security_inode_init_security(inode, dir, &name, &value, &len);
> +	err = security_inode_init_security(qstr, inode, dir, &name, &value, &len);
>  	if (err) {
>  		if (err == -EOPNOTSUPP)
>  			return 0;
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index 1ce240a..22b7628 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -1042,7 +1042,7 @@ got:
>  	if (err)
>  		goto fail_free_drop;
>  
> -	err = ext4_init_security(handle, inode, dir);
> +	err = ext4_init_security(handle, qstr, inode, dir);
>  	if (err)
>  		goto fail_free_drop;
>  
> diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
> index 25f3a97..b0a126f 100644
> --- a/fs/ext4/migrate.c
> +++ b/fs/ext4/migrate.c
> @@ -496,7 +496,7 @@ int ext4_ext_migrate(struct inode *inode)
>  	goal = (((inode->i_ino - 1) / EXT4_INODES_PER_GROUP(inode->i_sb)) *
>  		EXT4_INODES_PER_GROUP(inode->i_sb)) + 1;
>  	tmp_inode = ext4_new_inode(handle, inode->i_sb->s_root->d_inode,
> -				   S_IFREG, 0, goal);
> +				   S_IFREG, NULL, goal);
>  	if (IS_ERR(tmp_inode)) {
>  		retval = -ENOMEM;
>  		ext4_journal_stop(handle);
> diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
> index 1ef1652..93051a9 100644
> --- a/fs/ext4/xattr.h
> +++ b/fs/ext4/xattr.h
> @@ -144,11 +144,11 @@ ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
>  # endif  /* CONFIG_EXT4_FS_XATTR */
>  
>  #ifdef CONFIG_EXT4_FS_SECURITY
> -extern int ext4_init_security(handle_t *handle, struct inode *inode,
> -				struct inode *dir);
> +extern int ext4_init_security(handle_t *handle, const struct qstr *qstr,
> +				struct inode *inode, struct inode *dir);
>  #else
> -static inline int ext4_init_security(handle_t *handle, struct inode *inode,
> -				struct inode *dir)
> +static inline int ext4_init_security(handle_t *handle, const struct qstr *qstr,
> +				struct inode *inode, struct inode *dir)
>  {
>  	return 0;
>  }
> diff --git a/fs/ext4/xattr_security.c b/fs/ext4/xattr_security.c
> index 9b21268..1390ff3 100644
> --- a/fs/ext4/xattr_security.c
> +++ b/fs/ext4/xattr_security.c
> @@ -49,14 +49,15 @@ ext4_xattr_security_set(struct dentry *dentry, const char *name,
>  }
>  
>  int
> -ext4_init_security(handle_t *handle, struct inode *inode, struct inode *dir)
> +ext4_init_security(handle_t *handle, const struct qstr *qstr, struct inode *inode,
> +		struct inode *dir)
>  {
>  	int err;
>  	size_t len;
>  	void *value;
>  	char *name;
>  
> -	err = security_inode_init_security(inode, dir, &name, &value, &len);
> +	err = security_inode_init_security(qstr, inode, dir, &name, &value, &len);
>  	if (err) {
>  		if (err == -EOPNOTSUPP)
>  			return 0;
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index e1213f7..7de62cf 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -791,14 +791,15 @@ fail:
>  	return error;
>  }
>  
> -static int gfs2_security_init(struct gfs2_inode *dip, struct gfs2_inode *ip)
> +static int gfs2_security_init(struct gfs2_inode *dip, struct gfs2_inode *ip,
> +			      const struct qstr *qstr)
>  {
>  	int err;
>  	size_t len;
>  	void *value;
>  	char *name;
>  
> -	err = security_inode_init_security(&ip->i_inode, &dip->i_inode,
> +	err = security_inode_init_security(qstr, &ip->i_inode, &dip->i_inode,
>  					   &name, &value, &len);
>  
>  	if (err) {
> @@ -882,7 +883,7 @@ struct inode *gfs2_createi(struct gfs2_holder *ghs, const struct qstr *name,
>  	if (error)
>  		goto fail_gunlock2;
>  
> -	error = gfs2_security_init(dip, GFS2_I(inode));
> +	error = gfs2_security_init(dip, GFS2_I(inode), name);
>  	if (error)
>  		goto fail_gunlock2;
>  
> diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
> index 9297865..82faddd 100644
> --- a/fs/jffs2/dir.c
> +++ b/fs/jffs2/dir.c
> @@ -215,8 +215,7 @@ static int jffs2_create(struct inode *dir_i, struct dentry *dentry, int mode,
>  	   no chance of AB-BA deadlock involving its f->sem). */
>  	mutex_unlock(&f->sem);
>  
> -	ret = jffs2_do_create(c, dir_f, f, ri,
> -			      dentry->d_name.name, dentry->d_name.len);
> +	ret = jffs2_do_create(c, dir_f, f, ri, &dentry->d_name);
>  	if (ret)
>  		goto fail;
>  
> @@ -386,7 +385,7 @@ static int jffs2_symlink (struct inode *dir_i, struct dentry *dentry, const char
>  
>  	jffs2_complete_reservation(c);
>  
> -	ret = jffs2_init_security(inode, dir_i);
> +	ret = jffs2_init_security(inode, dir_i, &dentry->d_name);
>  	if (ret)
>  		goto fail;
>  
> @@ -530,7 +529,7 @@ static int jffs2_mkdir (struct inode *dir_i, struct dentry *dentry, int mode)
>  
>  	jffs2_complete_reservation(c);
>  
> -	ret = jffs2_init_security(inode, dir_i);
> +	ret = jffs2_init_security(inode, dir_i, &dentry->d_name);
>  	if (ret)
>  		goto fail;
>  
> @@ -703,7 +702,7 @@ static int jffs2_mknod (struct inode *dir_i, struct dentry *dentry, int mode, de
>  
>  	jffs2_complete_reservation(c);
>  
> -	ret = jffs2_init_security(inode, dir_i);
> +	ret = jffs2_init_security(inode, dir_i, &dentry->d_name);
>  	if (ret)
>  		goto fail;
>  
> diff --git a/fs/jffs2/nodelist.h b/fs/jffs2/nodelist.h
> index 5a53d9b..e4619b0 100644
> --- a/fs/jffs2/nodelist.h
> +++ b/fs/jffs2/nodelist.h
> @@ -401,7 +401,7 @@ int jffs2_write_inode_range(struct jffs2_sb_info *c, struct jffs2_inode_info *f,
>  			    struct jffs2_raw_inode *ri, unsigned char *buf,
>  			    uint32_t offset, uint32_t writelen, uint32_t *retlen);
>  int jffs2_do_create(struct jffs2_sb_info *c, struct jffs2_inode_info *dir_f, struct jffs2_inode_info *f,
> -		    struct jffs2_raw_inode *ri, const char *name, int namelen);
> +		    struct jffs2_raw_inode *ri, const struct qstr *qstr);
>  int jffs2_do_unlink(struct jffs2_sb_info *c, struct jffs2_inode_info *dir_f, const char *name,
>  		    int namelen, struct jffs2_inode_info *dead_f, uint32_t time);
>  int jffs2_do_link(struct jffs2_sb_info *c, struct jffs2_inode_info *dir_f, uint32_t ino,
> diff --git a/fs/jffs2/security.c b/fs/jffs2/security.c
> index 239f512..ddc389e 100644
> --- a/fs/jffs2/security.c
> +++ b/fs/jffs2/security.c
> @@ -23,14 +23,15 @@
>  #include "nodelist.h"
>  
>  /* ---- Initial Security Label Attachment -------------- */
> -int jffs2_init_security(struct inode *inode, struct inode *dir)
> +int jffs2_init_security(struct inode *inode, struct inode *dir,
> +			const struct qstr *qstr)
>  {
>  	int rc;
>  	size_t len;
>  	void *value;
>  	char *name;
>  
> -	rc = security_inode_init_security(inode, dir, &name, &value, &len);
> +	rc = security_inode_init_security(qstr, inode, dir, &name, &value, &len);
>  	if (rc) {
>  		if (rc == -EOPNOTSUPP)
>  			return 0;
> diff --git a/fs/jffs2/write.c b/fs/jffs2/write.c
> index c819eb0..ef2e592 100644
> --- a/fs/jffs2/write.c
> +++ b/fs/jffs2/write.c
> @@ -424,7 +424,7 @@ int jffs2_write_inode_range(struct jffs2_sb_info *c, struct jffs2_inode_info *f,
>  	return ret;
>  }
>  
> -int jffs2_do_create(struct jffs2_sb_info *c, struct jffs2_inode_info *dir_f, struct jffs2_inode_info *f, struct jffs2_raw_inode *ri, const char *name, int namelen)
> +int jffs2_do_create(struct jffs2_sb_info *c, struct jffs2_inode_info *dir_f, struct jffs2_inode_info *f, struct jffs2_raw_inode *ri, const struct qstr *qstr)
>  {
>  	struct jffs2_raw_dirent *rd;
>  	struct jffs2_full_dnode *fn;
> @@ -466,15 +466,15 @@ int jffs2_do_create(struct jffs2_sb_info *c, struct jffs2_inode_info *dir_f, str
>  	mutex_unlock(&f->sem);
>  	jffs2_complete_reservation(c);
>  
> -	ret = jffs2_init_security(&f->vfs_inode, &dir_f->vfs_inode);
> +	ret = jffs2_init_security(&f->vfs_inode, &dir_f->vfs_inode, qstr);
>  	if (ret)
>  		return ret;
>  	ret = jffs2_init_acl_post(&f->vfs_inode);
>  	if (ret)
>  		return ret;
>  
> -	ret = jffs2_reserve_space(c, sizeof(*rd)+namelen, &alloclen,
> -				ALLOC_NORMAL, JFFS2_SUMMARY_DIRENT_SIZE(namelen));
> +	ret = jffs2_reserve_space(c, sizeof(*rd)+qstr->len, &alloclen,
> +				ALLOC_NORMAL, JFFS2_SUMMARY_DIRENT_SIZE(qstr->len));
>  
>  	if (ret) {
>  		/* Eep. */
> @@ -493,19 +493,19 @@ int jffs2_do_create(struct jffs2_sb_info *c, struct jffs2_inode_info *dir_f, str
>  
>  	rd->magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
>  	rd->nodetype = cpu_to_je16(JFFS2_NODETYPE_DIRENT);
> -	rd->totlen = cpu_to_je32(sizeof(*rd) + namelen);
> +	rd->totlen = cpu_to_je32(sizeof(*rd) + qstr->len);
>  	rd->hdr_crc = cpu_to_je32(crc32(0, rd, sizeof(struct jffs2_unknown_node)-4));
>  
>  	rd->pino = cpu_to_je32(dir_f->inocache->ino);
>  	rd->version = cpu_to_je32(++dir_f->highest_version);
>  	rd->ino = ri->ino;
>  	rd->mctime = ri->ctime;
> -	rd->nsize = namelen;
> +	rd->nsize = qstr->len;
>  	rd->type = DT_REG;
>  	rd->node_crc = cpu_to_je32(crc32(0, rd, sizeof(*rd)-8));
> -	rd->name_crc = cpu_to_je32(crc32(0, name, namelen));
> +	rd->name_crc = cpu_to_je32(crc32(0, qstr->name, qstr->len));
>  
> -	fd = jffs2_write_dirent(c, dir_f, rd, name, namelen, ALLOC_NORMAL);
> +	fd = jffs2_write_dirent(c, dir_f, rd, qstr->name, qstr->len, ALLOC_NORMAL);
>  
>  	jffs2_free_raw_dirent(rd);
>  
> diff --git a/fs/jffs2/xattr.h b/fs/jffs2/xattr.h
> index cf4f575..7be4beb 100644
> --- a/fs/jffs2/xattr.h
> +++ b/fs/jffs2/xattr.h
> @@ -121,10 +121,11 @@ extern ssize_t jffs2_listxattr(struct dentry *, char *, size_t);
>  #endif /* CONFIG_JFFS2_FS_XATTR */
>  
>  #ifdef CONFIG_JFFS2_FS_SECURITY
> -extern int jffs2_init_security(struct inode *inode, struct inode *dir);
> +extern int jffs2_init_security(struct inode *inode, struct inode *dir,
> +			       const struct qstr *qstr);
>  extern const struct xattr_handler jffs2_security_xattr_handler;
>  #else
> -#define jffs2_init_security(inode,dir)	(0)
> +#define jffs2_init_security(inode,dir,qstr)	(0)
>  #endif /* CONFIG_JFFS2_FS_SECURITY */
>  
>  #endif /* _JFFS2_FS_XATTR_H_ */
> diff --git a/fs/jfs/jfs_xattr.h b/fs/jfs/jfs_xattr.h
> index 88b6cc5..e9e100f 100644
> --- a/fs/jfs/jfs_xattr.h
> +++ b/fs/jfs/jfs_xattr.h
> @@ -62,10 +62,11 @@ extern ssize_t jfs_listxattr(struct dentry *, char *, size_t);
>  extern int jfs_removexattr(struct dentry *, const char *);
>  
>  #ifdef CONFIG_JFS_SECURITY
> -extern int jfs_init_security(tid_t, struct inode *, struct inode *);
> +extern int jfs_init_security(tid_t, struct inode *, struct inode *,
> +			     const struct qstr *);
>  #else
>  static inline int jfs_init_security(tid_t tid, struct inode *inode,
> -				    struct inode *dir)
> +				    struct inode *dir, const struct qstr *qstr)
>  {
>  	return 0;
>  }
> diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
> index 231ca4a..ff0fda9 100644
> --- a/fs/jfs/namei.c
> +++ b/fs/jfs/namei.c
> @@ -114,7 +114,7 @@ static int jfs_create(struct inode *dip, struct dentry *dentry, int mode,
>  	if (rc)
>  		goto out3;
>  
> -	rc = jfs_init_security(tid, ip, dip);
> +	rc = jfs_init_security(tid, ip, dip, &dentry->d_name);
>  	if (rc) {
>  		txAbort(tid, 0);
>  		goto out3;
> @@ -252,7 +252,7 @@ static int jfs_mkdir(struct inode *dip, struct dentry *dentry, int mode)
>  	if (rc)
>  		goto out3;
>  
> -	rc = jfs_init_security(tid, ip, dip);
> +	rc = jfs_init_security(tid, ip, dip, &dentry->d_name);
>  	if (rc) {
>  		txAbort(tid, 0);
>  		goto out3;
> @@ -931,7 +931,7 @@ static int jfs_symlink(struct inode *dip, struct dentry *dentry,
>  	mutex_lock_nested(&JFS_IP(dip)->commit_mutex, COMMIT_MUTEX_PARENT);
>  	mutex_lock_nested(&JFS_IP(ip)->commit_mutex, COMMIT_MUTEX_CHILD);
>  
> -	rc = jfs_init_security(tid, ip, dip);
> +	rc = jfs_init_security(tid, ip, dip, &dentry->d_name);
>  	if (rc)
>  		goto out3;
>  
> @@ -1394,7 +1394,7 @@ static int jfs_mknod(struct inode *dir, struct dentry *dentry,
>  	if (rc)
>  		goto out3;
>  
> -	rc = jfs_init_security(tid, ip, dir);
> +	rc = jfs_init_security(tid, ip, dir, &dentry->d_name);
>  	if (rc) {
>  		txAbort(tid, 0);
>  		goto out3;
> diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
> index 2d7f165..61fbe00 100644
> --- a/fs/jfs/xattr.c
> +++ b/fs/jfs/xattr.c
> @@ -1091,7 +1091,8 @@ int jfs_removexattr(struct dentry *dentry, const char *name)
>  }
>  
>  #ifdef CONFIG_JFS_SECURITY
> -int jfs_init_security(tid_t tid, struct inode *inode, struct inode *dir)
> +int jfs_init_security(tid_t tid, struct inode *inode, struct inode *dir,
> +		      const struct qstr *qstr)
>  {
>  	int rc;
>  	size_t len;
> @@ -1099,7 +1100,7 @@ int jfs_init_security(tid_t tid, struct inode *inode, struct inode *dir)
>  	char *suffix;
>  	char *name;
>  
> -	rc = security_inode_init_security(inode, dir, &suffix, &value, &len);
> +	rc = security_inode_init_security(qstr, inode, dir, &suffix, &value, &len);
>  	if (rc) {
>  		if (rc == -EOPNOTSUPP)
>  			return 0;
> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
> index ff5744e..0fc5362 100644
> --- a/fs/ocfs2/namei.c
> +++ b/fs/ocfs2/namei.c
> @@ -294,7 +294,7 @@ static int ocfs2_mknod(struct inode *dir,
>  	}
>  
>  	/* get security xattr */
> -	status = ocfs2_init_security_get(inode, dir, &si);
> +	status = ocfs2_init_security_get(inode, dir, &si, &dentry->d_name);
>  	if (status) {
>  		if (status == -EOPNOTSUPP)
>  			si.enable = 0;
> @@ -1665,7 +1665,7 @@ static int ocfs2_symlink(struct inode *dir,
>  	}
>  
>  	/* get security xattr */
> -	status = ocfs2_init_security_get(inode, dir, &si);
> +	status = ocfs2_init_security_get(inode, dir, &si, &dentry->d_name);
>  	if (status) {
>  		if (status == -EOPNOTSUPP)
>  			si.enable = 0;
> diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
> index b5f9160..cd3f5b4 100644
> --- a/fs/ocfs2/refcounttree.c
> +++ b/fs/ocfs2/refcounttree.c
> @@ -4325,7 +4325,8 @@ static int ocfs2_reflink(struct dentry *old_dentry, struct inode *dir,
>  
>  	/* If the security isn't preserved, we need to re-initialize them. */
>  	if (!preserve) {
> -		error = ocfs2_init_security_and_acl(dir, new_orphan_inode);
> +		error = ocfs2_init_security_and_acl(dir, new_orphan_inode,
> +						    &new_dentry->d_name);
>  		if (error)
>  			mlog_errno(error);
>  	}
> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> index 67cd439..429dca6 100644
> --- a/fs/ocfs2/xattr.c
> +++ b/fs/ocfs2/xattr.c
> @@ -7185,7 +7185,8 @@ out:
>   * must not hold any lock expect i_mutex.
>   */
>  int ocfs2_init_security_and_acl(struct inode *dir,
> -				struct inode *inode)
> +				struct inode *inode,
> +				const struct qstr *qstr)
>  {
>  	int ret = 0;
>  	struct buffer_head *dir_bh = NULL;
> @@ -7193,7 +7194,7 @@ int ocfs2_init_security_and_acl(struct inode *dir,
>  		.enable = 1,
>  	};
>  
> -	ret = ocfs2_init_security_get(inode, dir, &si);
> +	ret = ocfs2_init_security_get(inode, dir, &si, qstr);
>  	if (!ret) {
>  		ret = ocfs2_xattr_set(inode, OCFS2_XATTR_INDEX_SECURITY,
>  				      si.name, si.value, si.value_len,
> @@ -7261,13 +7262,14 @@ static int ocfs2_xattr_security_set(struct dentry *dentry, const char *name,
>  
>  int ocfs2_init_security_get(struct inode *inode,
>  			    struct inode *dir,
> -			    struct ocfs2_security_xattr_info *si)
> +			    struct ocfs2_security_xattr_info *si,
> +			    const struct qstr *qstr)
>  {
>  	/* check whether ocfs2 support feature xattr */
>  	if (!ocfs2_supports_xattr(OCFS2_SB(dir->i_sb)))
>  		return -EOPNOTSUPP;
> -	return security_inode_init_security(inode, dir, &si->name, &si->value,
> -					    &si->value_len);
> +	return security_inode_init_security(qstr, inode, dir, &si->name,
> +					    &si->value, &si->value_len);
>  }
>  
>  int ocfs2_init_security_set(handle_t *handle,
> diff --git a/fs/ocfs2/xattr.h b/fs/ocfs2/xattr.h
> index aa64bb3..dbb6c53 100644
> --- a/fs/ocfs2/xattr.h
> +++ b/fs/ocfs2/xattr.h
> @@ -57,7 +57,8 @@ int ocfs2_has_inline_xattr_value_outside(struct inode *inode,
>  					 struct ocfs2_dinode *di);
>  int ocfs2_xattr_remove(struct inode *, struct buffer_head *);
>  int ocfs2_init_security_get(struct inode *, struct inode *,
> -			    struct ocfs2_security_xattr_info *);
> +			    struct ocfs2_security_xattr_info *,
> +			    const struct qstr *);
>  int ocfs2_init_security_set(handle_t *, struct inode *,
>  			    struct buffer_head *,
>  			    struct ocfs2_security_xattr_info *,
> @@ -94,5 +95,6 @@ int ocfs2_reflink_xattrs(struct inode *old_inode,
>  			 struct buffer_head *new_bh,
>  			 bool preserve_security);
>  int ocfs2_init_security_and_acl(struct inode *dir,
> -				struct inode *inode);
> +				struct inode *inode,
> +				const struct qstr *qstr);
>  #endif /* OCFS2_XATTR_H */
> diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
> index ba5f51e..df59f3d 100644
> --- a/fs/reiserfs/namei.c
> +++ b/fs/reiserfs/namei.c
> @@ -593,7 +593,7 @@ static int reiserfs_create(struct inode *dir, struct dentry *dentry, int mode,
>  	new_inode_init(inode, dir, mode);
>  
>  	jbegin_count += reiserfs_cache_default_acl(dir);
> -	retval = reiserfs_security_init(dir, inode, &security);
> +	retval = reiserfs_security_init(dir, inode, &security, &dentry->d_name);
>  	if (retval < 0) {
>  		drop_new_inode(inode);
>  		return retval;
> @@ -667,7 +667,7 @@ static int reiserfs_mknod(struct inode *dir, struct dentry *dentry, int mode,
>  	new_inode_init(inode, dir, mode);
>  
>  	jbegin_count += reiserfs_cache_default_acl(dir);
> -	retval = reiserfs_security_init(dir, inode, &security);
> +	retval = reiserfs_security_init(dir, inode, &security, &dentry->d_name);
>  	if (retval < 0) {
>  		drop_new_inode(inode);
>  		return retval;
> @@ -747,7 +747,7 @@ static int reiserfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
>  	new_inode_init(inode, dir, mode);
>  
>  	jbegin_count += reiserfs_cache_default_acl(dir);
> -	retval = reiserfs_security_init(dir, inode, &security);
> +	retval = reiserfs_security_init(dir, inode, &security, &dentry->d_name);
>  	if (retval < 0) {
>  		drop_new_inode(inode);
>  		return retval;
> @@ -1032,7 +1032,7 @@ static int reiserfs_symlink(struct inode *parent_dir,
>  	}
>  	new_inode_init(inode, parent_dir, mode);
>  
> -	retval = reiserfs_security_init(parent_dir, inode, &security);
> +	retval = reiserfs_security_init(parent_dir, inode, &security, &dentry->d_name);
>  	if (retval < 0) {
>  		drop_new_inode(inode);
>  		return retval;
> diff --git a/fs/reiserfs/xattr_security.c b/fs/reiserfs/xattr_security.c
> index 237c692..e8895d4 100644
> --- a/fs/reiserfs/xattr_security.c
> +++ b/fs/reiserfs/xattr_security.c
> @@ -54,7 +54,8 @@ static size_t security_list(struct dentry *dentry, char *list, size_t list_len,
>   * of blocks needed for the transaction. If successful, reiserfs_security
>   * must be released using reiserfs_security_free when the caller is done. */
>  int reiserfs_security_init(struct inode *dir, struct inode *inode,
> -			   struct reiserfs_security_handle *sec)
> +			   struct reiserfs_security_handle *sec,
> +			   const struct qstr *qstr)
>  {
>  	int blocks = 0;
>  	int error;
> @@ -65,7 +66,7 @@ int reiserfs_security_init(struct inode *dir, struct inode *inode,
>  	if (IS_PRIVATE(dir))
>  		return 0;
>  
> -	error = security_inode_init_security(inode, dir, &sec->name,
> +	error = security_inode_init_security(qstr, inode, dir, &sec->name,
>  					     &sec->value, &sec->length);
>  	if (error) {
>  		if (error == -EOPNOTSUPP)
> diff --git a/fs/xfs/linux-2.6/xfs_iops.c b/fs/xfs/linux-2.6/xfs_iops.c
> index 94d5fd6..6baf95c 100644
> --- a/fs/xfs/linux-2.6/xfs_iops.c
> +++ b/fs/xfs/linux-2.6/xfs_iops.c
> @@ -103,7 +103,8 @@ xfs_mark_inode_dirty(
>  STATIC int
>  xfs_init_security(
>  	struct inode	*inode,
> -	struct inode	*dir)
> +	struct inode	*dir,
> +	const struct qstr *qstr)
>  {
>  	struct xfs_inode *ip = XFS_I(inode);
>  	size_t		length;
> @@ -111,7 +112,7 @@ xfs_init_security(
>  	unsigned char	*name;
>  	int		error;
>  
> -	error = security_inode_init_security(inode, dir, (char **)&name,
> +	error = security_inode_init_security(qstr, inode, dir, (char **)&name,
>  					     &value, &length);
>  	if (error) {
>  		if (error == -EOPNOTSUPP)
> @@ -195,7 +196,7 @@ xfs_vn_mknod(
>  
>  	inode = VFS_I(ip);
>  
> -	error = xfs_init_security(inode, dir);
> +	error = xfs_init_security(inode, dir, &dentry->d_name);
>  	if (unlikely(error))
>  		goto out_cleanup_inode;
>  
> @@ -368,7 +369,7 @@ xfs_vn_symlink(
>  
>  	inode = VFS_I(cip);
>  
> -	error = xfs_init_security(inode, dir);
> +	error = xfs_init_security(inode, dir, &dentry->d_name);
>  	if (unlikely(error))
>  		goto out_cleanup_inode;
>  
> diff --git a/include/linux/ext3_fs.h b/include/linux/ext3_fs.h
> index 6ce1bca..db9691c 100644
> --- a/include/linux/ext3_fs.h
> +++ b/include/linux/ext3_fs.h
> @@ -874,7 +874,7 @@ extern int ext3fs_dirhash(const char *name, int len, struct
>  			  dx_hash_info *hinfo);
>  
>  /* ialloc.c */
> -extern struct inode * ext3_new_inode (handle_t *, struct inode *, int);
> +extern struct inode * ext3_new_inode (handle_t *, struct inode *, const struct qstr *, int);
>  extern void ext3_free_inode (handle_t *, struct inode *);
>  extern struct inode * ext3_orphan_get (struct super_block *, unsigned long);
>  extern unsigned long ext3_count_free_inodes (struct super_block *);
> diff --git a/include/linux/reiserfs_xattr.h b/include/linux/reiserfs_xattr.h
> index b2cf208..876dab7 100644
> --- a/include/linux/reiserfs_xattr.h
> +++ b/include/linux/reiserfs_xattr.h
> @@ -63,7 +63,8 @@ extern const struct xattr_handler reiserfs_xattr_trusted_handler;
>  extern const struct xattr_handler reiserfs_xattr_security_handler;
>  #ifdef CONFIG_REISERFS_FS_SECURITY
>  int reiserfs_security_init(struct inode *dir, struct inode *inode,
> -			   struct reiserfs_security_handle *sec);
> +			   struct reiserfs_security_handle *sec,
> +			   const struct qstr *qstr);
>  int reiserfs_security_write(struct reiserfs_transaction_handle *th,
>  			    struct inode *inode,
>  			    struct reiserfs_security_handle *sec);
> @@ -130,7 +131,8 @@ static inline void reiserfs_init_xattr_rwsem(struct inode *inode)
>  #ifndef CONFIG_REISERFS_FS_SECURITY
>  static inline int reiserfs_security_init(struct inode *dir,
>  					 struct inode *inode,
> -					 struct reiserfs_security_handle *sec)
> +					 struct reiserfs_security_handle *sec,
> +					 const struct qstr *qstr)
>  {
>  	return 0;
>  }
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 4ab684e..d42619e 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1436,8 +1436,9 @@ struct security_operations {
>  
>  	int (*inode_alloc_security) (struct inode *inode);
>  	void (*inode_free_security) (struct inode *inode);
> -	int (*inode_init_security) (struct inode *inode, struct inode *dir,
> -				    char **name, void **value, size_t *len);
> +	int (*inode_init_security) (const struct qstr *qstr, struct inode *inode,
> +				    struct inode *dir, char **name, void **value,
> +				    size_t *len);
>  	int (*inode_create) (struct inode *dir,
>  			     struct dentry *dentry, int mode);
>  	int (*inode_link) (struct dentry *old_dentry,
> @@ -1700,8 +1701,9 @@ int security_sb_parse_opts_str(char *options, struct security_mnt_opts *opts);
>  
>  int security_inode_alloc(struct inode *inode);
>  void security_inode_free(struct inode *inode);
> -int security_inode_init_security(struct inode *inode, struct inode *dir,
> -				  char **name, void **value, size_t *len);
> +int security_inode_init_security(const struct qstr *qstr, struct inode *inode,
> +				 struct inode *dir, char **name, void **value,
> +				 size_t *len);
>  int security_inode_create(struct inode *dir, struct dentry *dentry, int mode);
>  int security_inode_link(struct dentry *old_dentry, struct inode *dir,
>  			 struct dentry *new_dentry);
> @@ -2026,7 +2028,8 @@ static inline int security_inode_alloc(struct inode *inode)
>  static inline void security_inode_free(struct inode *inode)
>  { }
>  
> -static inline int security_inode_init_security(struct inode *inode,
> +static inline int security_inode_init_security(const struct qstr *qstr,
> +						struct inode *inode,
>  						struct inode *dir,
>  						char **name,
>  						void **value,
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 47fdeeb..06aa3cf 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1843,8 +1843,8 @@ shmem_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
>  
>  	inode = shmem_get_inode(dir->i_sb, dir, mode, dev, VM_NORESERVE);
>  	if (inode) {
> -		error = security_inode_init_security(inode, dir, NULL, NULL,
> -						     NULL);
> +		error = security_inode_init_security(&dentry->d_name, inode,
> +						     dir, NULL, NULL, NULL);
>  		if (error) {
>  			if (error != -EOPNOTSUPP) {
>  				iput(inode);
> @@ -1983,8 +1983,8 @@ static int shmem_symlink(struct inode *dir, struct dentry *dentry, const char *s
>  	if (!inode)
>  		return -ENOSPC;
>  
> -	error = security_inode_init_security(inode, dir, NULL, NULL,
> -					     NULL);
> +	error = security_inode_init_security(&dentry->d_name, inode, dir, NULL,
> +					     NULL, NULL);
>  	if (error) {
>  		if (error != -EOPNOTSUPP) {
>  			iput(inode);
> diff --git a/security/capability.c b/security/capability.c
> index 92a1bff..778a28f 100644
> --- a/security/capability.c
> +++ b/security/capability.c
> @@ -117,8 +117,9 @@ static void cap_inode_free_security(struct inode *inode)
>  {
>  }
>  
> -static int cap_inode_init_security(struct inode *inode, struct inode *dir,
> -				   char **name, void **value, size_t *len)
> +static int cap_inode_init_security(const struct qstr *qstr, struct inode *inode,
> +				   struct inode *dir, char **name, void **value,
> +				   size_t *len)
>  {
>  	return -EOPNOTSUPP;
>  }
> diff --git a/security/security.c b/security/security.c
> index 799239d..639a72a 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -335,12 +335,14 @@ void security_inode_free(struct inode *inode)
>  	security_ops->inode_free_security(inode);
>  }
>  
> -int security_inode_init_security(struct inode *inode, struct inode *dir,
> -				  char **name, void **value, size_t *len)
> +int security_inode_init_security(const struct qstr *qstr, struct inode *inode,
> +				 struct inode *dir, char **name, void **value,
> +				 size_t *len)
>  {
>  	if (unlikely(IS_PRIVATE(inode)))
>  		return -EOPNOTSUPP;
> -	return security_ops->inode_init_security(inode, dir, name, value, len);
> +	return security_ops->inode_init_security(qstr, inode, dir, name, value,
> +						 len);
>  }
>  EXPORT_SYMBOL(security_inode_init_security);
>  
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index b8dcd05..609e8d3 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -39,6 +39,7 @@
>  #include <linux/swap.h>
>  #include <linux/spinlock.h>
>  #include <linux/syscalls.h>
> +#include <linux/dcache.h>
>  #include <linux/file.h>
>  #include <linux/fdtable.h>
>  #include <linux/namei.h>
> @@ -2508,9 +2509,8 @@ static void selinux_inode_free_security(struct inode *inode)
>  	inode_free_security(inode);
>  }
>  
> -static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
> -				       char **name, void **value,
> -				       size_t *len)
> +static int selinux_inode_init_security(const struct qstr *qstr, struct inode *inode,
> +			struct inode *dir, char **name, void **value, size_t *len)
>  {
>  	const struct task_security_struct *tsec = current_security();
>  	struct inode_security_struct *dsec;
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 489a85a..f4794e9 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -31,6 +31,7 @@
>  #include <net/cipso_ipv4.h>
>  #include <linux/audit.h>
>  #include <linux/magic.h>
> +#include <linux/dcache.h>
>  #include "smack.h"
>  
>  #define task_security(task)	(task_cred_xxx((task), security))
> @@ -430,8 +431,9 @@ static void smack_inode_free_security(struct inode *inode)
>   *
>   * Returns 0 if it all works out, -ENOMEM if there's no memory
>   */
> -static int smack_inode_init_security(struct inode *inode, struct inode *dir,
> -				     char **name, void **value, size_t *len)
> +static int smack_inode_init_security(const struct qstr *qstr, struct inode *inode,
> +				     struct inode *dir, char **name, void **value,
> +				     size_t *len)
>  {
>  	char *isp = smk_of_inode(inode);
>  
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

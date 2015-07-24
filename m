Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6OFBi0o007719
 for <selinux@tycho.nsa.gov>; Fri, 24 Jul 2015 11:11:49 -0400
Received: by oigd21 with SMTP id d21so19996781oig.1
 for <selinux@tycho.nsa.gov>; Fri, 24 Jul 2015 08:11:45 -0700 (PDT)
Date: Fri, 24 Jul 2015 10:11:37 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 6/7] selinux: Ignore security labels on user namespace
 mounts
Message-ID: <20150724151137.GA82891@ubuntu-hedt>
References: <1436989569-69582-7-git-send-email-seth.forshee@canonical.com>
 <55A7B055.4050809@tycho.nsa.gov> <55AFBE85.6010809@tycho.nsa.gov>
 <20150722161422.GC124342@ubuntu-hedt>
 <55AFFC32.6070701@tycho.nsa.gov> <55AFFFBD.8040907@tycho.nsa.gov>
 <55B0F2C0.8070709@tycho.nsa.gov>
 <20150723143920.GA25235@ubuntu-hedt>
 <55B109E3.6030207@tycho.nsa.gov>
 <20150723162331.GB25235@ubuntu-hedt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150723162331.GB25235@ubuntu-hedt>
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 James Morris <james.l.morris@oracle.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, linux-security-module@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, selinux@tycho.nsa.gov,
 linux-fsdevel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jul 23, 2015 at 11:23:31AM -0500, Seth Forshee wrote:
> On Thu, Jul 23, 2015 at 11:36:03AM -0400, Stephen Smalley wrote:
> > On 07/23/2015 10:39 AM, Seth Forshee wrote:
> > > On Thu, Jul 23, 2015 at 09:57:20AM -0400, Stephen Smalley wrote:
> > >> On 07/22/2015 04:40 PM, Stephen Smalley wrote:
> > >>> On 07/22/2015 04:25 PM, Stephen Smalley wrote:
> > >>>> On 07/22/2015 12:14 PM, Seth Forshee wrote:
> > >>>>> On Wed, Jul 22, 2015 at 12:02:13PM -0400, Stephen Smalley wrote:
> > >>>>>> On 07/16/2015 09:23 AM, Stephen Smalley wrote:
> > >>>>>>> On 07/15/2015 03:46 PM, Seth Forshee wrote:
> > >>>>>>>> Unprivileged users should not be able to supply security labels
> > >>>>>>>> in filesystems, nor should they be able to supply security
> > >>>>>>>> contexts in unprivileged mounts. For any mount where s_user_ns is
> > >>>>>>>> not init_user_ns, force the use of SECURITY_FS_USE_NONE behavior
> > >>>>>>>> and return EPERM if any contexts are supplied in the mount
> > >>>>>>>> options.
> > >>>>>>>>
> > >>>>>>>> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> > >>>>>>>
> > >>>>>>> I think this is obsoleted by the subsequent discussion, but just for the
> > >>>>>>> record: this patch would cause the files in the userns mount to be left
> > >>>>>>> with the "unlabeled" label, and therefore under typical policies,
> > >>>>>>> completely inaccessible to any process in a confined domain.
> > >>>>>>
> > >>>>>> The right way to handle this for SELinux would be to automatically use
> > >>>>>> mountpoint labeling (SECURITY_FS_USE_MNTPOINT, normally set by
> > >>>>>> specifying a context= mount option), with the sbsec->mntpoint_sid set
> > >>>>>> from some related object (e.g. the block device file context, as in your
> > >>>>>> patches for Smack).  That will cause SELinux to use that value instead
> > >>>>>> of any xattr value from the filesystem and will cause attempts by
> > >>>>>> userspace to set the security.selinux xattr to fail on that filesystem.
> > >>>>>>  That is how SELinux normally deals with untrusted filesystems, except
> > >>>>>> that it is normally specified as a mount option by a trusted mounting
> > >>>>>> process, whereas in your case you need to automatically set it.
> > >>>>>
> > >>>>> Excellent, thank you for the advice. I'll start on this when I've
> > >>>>> finished with Smack.
> > >>>>
> > >>>> Not tested, but something like this should work. Note that it should
> > >>>> come after the call to security_fs_use() so we know whether SELinux
> > >>>> would even try to use xattrs supplied by the filesystem in the first place.
> > >>>>
> > >>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > >>>> index 564079c..84da3a2 100644
> > >>>> --- a/security/selinux/hooks.c
> > >>>> +++ b/security/selinux/hooks.c
> > >>>> @@ -745,6 +745,30 @@ static int selinux_set_mnt_opts(struct super_block *sb,
> > >>>>                         goto out;
> > >>>>                 }
> > >>>>         }
> > >>>> +
> > >>>> +       /*
> > >>>> +        * If this is a user namespace mount, no contexts are allowed
> > >>>> +        * on the command line and security labels must be ignored.
> > >>>> +        */
> > >>>> +       if (sb->s_user_ns != &init_user_ns) {
> > >>>> +               if (context_sid || fscontext_sid || rootcontext_sid ||
> > >>>> +                   defcontext_sid) {
> > >>>> +                       rc = -EACCES;
> > >>>> +                       goto out;
> > >>>> +               }
> > >>>> +               if (sbsec->behavior == SECURITY_FS_USE_XATTR) {
> > >>>> +                       struct block_device *bdev = sb->s_bdev;
> > >>>> +                       sbsec->behavior = SECURITY_FS_USE_MNTPOINT;
> > >>>> +                       if (bdev) {
> > >>>> +                               struct inode_security_struct *isec =
> > >>>> bdev->bd_inode;
> > >>>
> > >>> That should be bdev->bd_inode->i_security.
> > >>
> > >> Sorry, this won't work.  bd_inode is not the inode of the block device
> > >> file that was passed to mount, and it isn't labeled in any way.  It will
> > >> just be unlabeled.
> > >>
> > >> So I guess the only real option here as a fallback is
> > >> sbsec->mntpoint_sid = current_sid().  Which isn't great either, as the
> > >> only case where we currently assign task labels to files is for their
> > >> /proc/pid inodes, and no current policy will therefore allow create
> > >> permission to such files.
> > > 
> > > Darn, you're right, that isn't the inode we want. There really doesn't
> > > seem to be any way to get back to the one we want from the LSM, short of
> > > adding a new hook.
> > 
> > Maybe list_first_entry(&sb->s_bdev->bd_inodes, struct inode, i_devices)?
> > Feels like a layering violation though...
> 
> Yeah, and even though that probably works out to be the inode we want in
> most cases I don't think we can be absolutely certain that it is. Maybe
> there's some way we could walk the list and be sure we've found the
> right inode, but I'm not seeing it.

I guess we could do something like this (note that most of the changes
here are just to give a version of blkdev_get_by_path which takes a
struct path * so that the filename lookup doesn't have to be done
twice). Basically add a new hook that informs the security module of the
inode for the backing device file passed to mount and call that from
mount_bdev. The security module could grab a reference to the inode and
stash it away.

Something else to note is that, as I have it here, the hook would end up
getting called for every mount of a given block device, not just the
first. So it's possible the security module could see the hook called a
second time with a different inode that has a different label. The hook
could be changed to return int if you wanted to have the opportunity to
reject such mounts.

Seth

---

diff --git a/fs/block_dev.c b/fs/block_dev.c
index f8ce371c437c..dc2173e24e30 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1372,14 +1372,39 @@ int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
 }
 EXPORT_SYMBOL(blkdev_get);
 
+static struct block_device *__lookup_bdev(struct path *path);
+
+struct block_device * __blkdev_get_by_path(struct path *path, fmode_t mode,
+					   void *holder)
+{
+	struct block_device *bdev;
+	int err;
+
+	bdev = __lookup_bdev(path);
+	if (IS_ERR(bdev))
+		return bdev;
+
+	err = blkdev_get(bdev, mode, holder);
+	if (err)
+		return ERR_PTR(err);
+
+	if ((mode & FMODE_WRITE) && bdev_read_only(bdev)) {
+		blkdev_put(bdev, mode);
+		return ERR_PTR(-EACCES);
+	}
+
+	return bdev;
+}
+EXPORT_SYMBOL(__blkdev_get_by_path);
+
 /**
  * blkdev_get_by_path - open a block device by name
- * @path: path to the block device to open
+ * @pathname: path to the block device to open
  * @mode: FMODE_* mask
  * @holder: exclusive holder identifier
  *
- * Open the blockdevice described by the device file at @path.  @mode
- * and @holder are identical to blkdev_get().
+ * Open the blockdevice described by the device file at @pathname.
+ * @mode and @holder are identical to blkdev_get().
  *
  * On success, the returned block_device has reference count of one.
  *
@@ -1389,25 +1414,22 @@ EXPORT_SYMBOL(blkdev_get);
  * RETURNS:
  * Pointer to block_device on success, ERR_PTR(-errno) on failure.
  */
-struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
+struct block_device *blkdev_get_by_path(const char *pathname, fmode_t mode,
 					void *holder)
 {
 	struct block_device *bdev;
-	int err;
-
-	bdev = lookup_bdev(path);
-	if (IS_ERR(bdev))
-		return bdev;
+	struct path path;
+	int error;
 
-	err = blkdev_get(bdev, mode, holder);
-	if (err)
-		return ERR_PTR(err);
+	if (!pathname || !*pathname)
+		return ERR_PTR(-EINVAL);
 
-	if ((mode & FMODE_WRITE) && bdev_read_only(bdev)) {
-		blkdev_put(bdev, mode);
-		return ERR_PTR(-EACCES);
-	}
+	error = kern_path(pathname, LOOKUP_FOLLOW, &path);
+	if (error)
+		return ERR_PTR(error);
 
+	bdev = __blkdev_get_by_path(&path, mode, holder);
+	path_put(&path);
 	return bdev;
 }
 EXPORT_SYMBOL(blkdev_get_by_path);
@@ -1702,6 +1724,30 @@ int ioctl_by_bdev(struct block_device *bdev, unsigned cmd, unsigned long arg)
 
 EXPORT_SYMBOL(ioctl_by_bdev);
 
+static struct block_device *__lookup_bdev(struct path *path)
+{
+	struct block_device *bdev;
+	struct inode *inode;
+	int error;
+
+	inode = d_backing_inode(path->dentry);
+	error = -ENOTBLK;
+	if (!S_ISBLK(inode->i_mode))
+		goto fail;
+	error = -EACCES;
+	if (!may_open_dev(path))
+		goto fail;
+	error = -ENOMEM;
+	bdev = bd_acquire(inode);
+	if (!bdev)
+		goto fail;
+out:
+	return bdev;
+fail:
+	bdev = ERR_PTR(error);
+	goto out;
+}
+
 /**
  * lookup_bdev  - lookup a struct block_device by name
  * @pathname:	special file representing the block device
@@ -1713,7 +1759,6 @@ EXPORT_SYMBOL(ioctl_by_bdev);
 struct block_device *lookup_bdev(const char *pathname)
 {
 	struct block_device *bdev;
-	struct inode *inode;
 	struct path path;
 	int error;
 
@@ -1724,23 +1769,9 @@ struct block_device *lookup_bdev(const char *pathname)
 	if (error)
 		return ERR_PTR(error);
 
-	inode = d_backing_inode(path.dentry);
-	error = -ENOTBLK;
-	if (!S_ISBLK(inode->i_mode))
-		goto fail;
-	error = -EACCES;
-	if (!may_open_dev(&path))
-		goto fail;
-	error = -ENOMEM;
-	bdev = bd_acquire(inode);
-	if (!bdev)
-		goto fail;
-out:
+	bdev = __lookup_bdev(&path);
 	path_put(&path);
 	return bdev;
-fail:
-	bdev = ERR_PTR(error);
-	goto out;
 }
 EXPORT_SYMBOL(lookup_bdev);
 
diff --git a/fs/super.c b/fs/super.c
index 008f938e3ec0..558f7845a171 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -34,6 +34,7 @@
 #include <linux/fsnotify.h>
 #include <linux/lockdep.h>
 #include <linux/user_namespace.h>
+#include <linux/namei.h>
 #include "internal.h"
 
 
@@ -980,15 +981,26 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 {
 	struct block_device *bdev;
 	struct super_block *s;
+	struct path path;
+	struct inode *inode;
 	fmode_t mode = FMODE_READ | FMODE_EXCL;
 	int error = 0;
 
 	if (!(flags & MS_RDONLY))
 		mode |= FMODE_WRITE;
 
-	bdev = blkdev_get_by_path(dev_name, mode, fs_type);
-	if (IS_ERR(bdev))
-		return ERR_CAST(bdev);
+	if (!dev_name || !*dev_name)
+		return ERR_PTR(-EINVAL);
+
+	error = kern_path(dev_name, LOOKUP_FOLLOW, &path);
+	if (error)
+		return ERR_PTR(error);
+
+	bdev = __blkdev_get_by_path(&path, mode, fs_type);
+	if (IS_ERR(bdev)) {
+		error = PTR_ERR(bdev);
+		goto error;
+	}
 
 	/*
 	 * once the super is inserted into the list by sget, s_umount
@@ -1040,6 +1052,10 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 		bdev->bd_super = s;
 	}
 
+	inode = d_backing_inode(path.dentry);
+	security_sb_backing_dev(s, inode);
+	path_put(&path);
+
 	return dget(s->s_root);
 
 error_s:
@@ -1047,6 +1063,7 @@ error_s:
 error_bdev:
 	blkdev_put(bdev, mode);
 error:
+	path_put(&path);
 	return ERR_PTR(error);
 }
 EXPORT_SYMBOL(mount_bdev);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4597420ab933..3748945bf0d5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2315,6 +2315,8 @@ extern int ioctl_by_bdev(struct block_device *, unsigned, unsigned long);
 extern int blkdev_ioctl(struct block_device *, fmode_t, unsigned, unsigned long);
 extern long compat_blkdev_ioctl(struct file *, unsigned, unsigned long);
 extern int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder);
+extern struct block_device *__blkdev_get_by_path(struct path *path, fmode_t mode,
+						 void *holder);
 extern struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
 					       void *holder);
 extern struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode,
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 9429f054c323..52ce1a094e04 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1351,6 +1351,7 @@ union security_list_options {
 	int (*sb_clone_mnt_opts)(const struct super_block *oldsb,
 					struct super_block *newsb);
 	int (*sb_parse_opts_str)(char *options, struct security_mnt_opts *opts);
+	void (*sb_backing_dev)(struct super_block *sb, struct inode *inode);
 	int (*dentry_init_security)(struct dentry *dentry, int mode,
 					struct qstr *name, void **ctx,
 					u32 *ctxlen);
@@ -1648,6 +1649,7 @@ struct security_hook_heads {
 	struct list_head sb_set_mnt_opts;
 	struct list_head sb_clone_mnt_opts;
 	struct list_head sb_parse_opts_str;
+	struct list_head sb_backing_dev;
 	struct list_head dentry_init_security;
 #ifdef CONFIG_SECURITY_PATH
 	struct list_head path_unlink;
diff --git a/include/linux/security.h b/include/linux/security.h
index 79d85ddf8093..7a4d8382af20 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -231,6 +231,7 @@ int security_sb_set_mnt_opts(struct super_block *sb,
 int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 				struct super_block *newsb);
 int security_sb_parse_opts_str(char *options, struct security_mnt_opts *opts);
+void security_sb_backing_dev(struct super_block *sb, struct inode *inode);
 int security_dentry_init_security(struct dentry *dentry, int mode,
 					struct qstr *name, void **ctx,
 					u32 *ctxlen);
@@ -562,6 +563,10 @@ static inline int security_sb_parse_opts_str(char *options, struct security_mnt_
 	return 0;
 }
 
+static inline void security_sb_backing_dev(struct super_block *sb,
+					   struct inode *inode)
+{ }
+
 static inline int security_inode_alloc(struct inode *inode)
 {
 	return 0;
diff --git a/security/security.c b/security/security.c
index 062f3c997fdc..f6f89e0f06d8 100644
--- a/security/security.c
+++ b/security/security.c
@@ -347,6 +347,11 @@ int security_sb_parse_opts_str(char *options, struct security_mnt_opts *opts)
 }
 EXPORT_SYMBOL(security_sb_parse_opts_str);
 
+void security_sb_backing_dev(struct super_block *sb, struct inode *inode)
+{
+	call_void_hook(sb_backing_dev, sb, inode);
+}
+
 int security_inode_alloc(struct inode *inode)
 {
 	inode->i_security = NULL;
@@ -1595,6 +1600,8 @@ struct security_hook_heads security_hook_heads = {
 		LIST_HEAD_INIT(security_hook_heads.sb_clone_mnt_opts),
 	.sb_parse_opts_str =
 		LIST_HEAD_INIT(security_hook_heads.sb_parse_opts_str),
+	.sb_backing_dev =
+		LIST_HEAD_INIT(security_hook_heads.sb_backing_dev),
 	.dentry_init_security =
 		LIST_HEAD_INIT(security_hook_heads.dentry_init_security),
 #ifdef CONFIG_SECURITY_PATH

Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8GK3eO1026669
 for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2015 16:03:47 -0400
Received: by igbkq10 with SMTP id kq10so41970282igb.0
 for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2015 13:03:46 -0700 (PDT)
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Jeff Layton <jlayton@poochiereds.net>,
 "J. Bruce Fields" <bfields@fieldses.org>
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 Andy Lutomirski <luto@amacapital.net>, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH v3 3/7] fs: Verify access of user towards block device file
 when mounting
Date: Wed, 16 Sep 2015 15:02:39 -0500
Message-Id: <1442433764-80826-4-git-send-email-seth.forshee@canonical.com>
In-Reply-To: <1442433764-80826-1-git-send-email-seth.forshee@canonical.com>
References: <1442433764-80826-1-git-send-email-seth.forshee@canonical.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When mounting a filesystem on a block device there is currently
no verification that the user has appropriate access to the
device file passed to mount. This has not been an issue so far
since the user in question has always been root, but this must
be changed before allowing unprivileged users to mount in user
namespaces.

To do this, a new version of lookup_bdev() is added named
lookup_bdev_perm(). Both of these functions become wrappers
around a common inner fucntion. The behavior of lookup_bdev() is
unchanged, but calling lookup_bdev_perm() will fail if the user
does not have the specified access rights to the supplied path.
The permission check is skipped if the user has CAP_SYS_ADMIN to
avoid any possible regressions in behavior.

blkdev_get_by_path() is updated to use lookup_bdev_perm(). This
is used by mount_bdev() and mount_mtd(), so this will cause
mounts on block devices to fail when the user lacks the required
permissions. Other calls to blkdev_get_by_path() will all happen
with root privileges, so these calls will be unaffected.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 drivers/mtd/mtdsuper.c |  7 ++++++-
 fs/block_dev.c         | 52 ++++++++++++++++++++++++++++++++++++++++----------
 include/linux/fs.h     |  1 +
 3 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/mtdsuper.c b/drivers/mtd/mtdsuper.c
index 20c02a3b7417..a3970b0506b9 100644
--- a/drivers/mtd/mtdsuper.c
+++ b/drivers/mtd/mtdsuper.c
@@ -125,6 +125,7 @@ struct dentry *mount_mtd(struct file_system_type *fs_type, int flags,
 #ifdef CONFIG_BLOCK
 	struct block_device *bdev;
 	int ret, major;
+	int perm = 0;
 #endif
 	int mtdnr;
 
@@ -176,7 +177,11 @@ struct dentry *mount_mtd(struct file_system_type *fs_type, int flags,
 	/* try the old way - the hack where we allowed users to mount
 	 * /dev/mtdblock$(n) but didn't actually _use_ the blockdev
 	 */
-	bdev = lookup_bdev(dev_name);
+	if (flags & FMODE_READ)
+		perm |= MAY_READ;
+	if (flags & FMODE_WRITE)
+		perm |= MAY_WRITE;
+	bdev = lookup_bdev_perm(dev_name, perm);
 	if (IS_ERR(bdev)) {
 		ret = PTR_ERR(bdev);
 		pr_debug("MTDSB: lookup_bdev() returned %d\n", ret);
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 26cee058dc02..d7b83e4ec138 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1394,9 +1394,14 @@ struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
 					void *holder)
 {
 	struct block_device *bdev;
+	int perm = 0;
 	int err;
 
-	bdev = lookup_bdev(path);
+	if (mode & FMODE_READ)
+		perm |= MAY_READ;
+	if (mode & FMODE_WRITE)
+		perm |= MAY_WRITE;
+	bdev = lookup_bdev_perm(path, perm);
 	if (IS_ERR(bdev))
 		return bdev;
 
@@ -1703,15 +1708,8 @@ int ioctl_by_bdev(struct block_device *bdev, unsigned cmd, unsigned long arg)
 
 EXPORT_SYMBOL(ioctl_by_bdev);
 
-/**
- * lookup_bdev  - lookup a struct block_device by name
- * @pathname:	special file representing the block device
- *
- * Get a reference to the blockdevice at @pathname in the current
- * namespace if possible and return it.  Return ERR_PTR(error)
- * otherwise.
- */
-struct block_device *lookup_bdev(const char *pathname)
+static struct block_device *__lookup_bdev(const char *pathname, int mask,
+					  bool check_perm)
 {
 	struct block_device *bdev;
 	struct inode *inode;
@@ -1726,6 +1724,11 @@ struct block_device *lookup_bdev(const char *pathname)
 		return ERR_PTR(error);
 
 	inode = d_backing_inode(path.dentry);
+	if (check_perm && !capable(CAP_SYS_ADMIN)) {
+		error = inode_permission(inode, mask);
+		if (error)
+			goto fail;
+	}
 	error = -ENOTBLK;
 	if (!S_ISBLK(inode->i_mode))
 		goto fail;
@@ -1743,6 +1746,35 @@ fail:
 	bdev = ERR_PTR(error);
 	goto out;
 }
+
+/*
+ * lookup_bdev_perm - lookup a struct block_device by name and check for
+ *		      access rights
+ * @pathname:	special file representing the block device
+ * @mask:	rights to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC)
+ *
+ * Get a reference to the blockdevice at @pathname in the current
+ * namespace if possible, check for the specified rights to the device
+ * at @pathname, and return it.  Return ERR_PTR(error) otherwise.
+ */
+struct block_device *lookup_bdev_perm(const char *pathname, int mask)
+{
+	return __lookup_bdev(pathname, mask, true);
+}
+EXPORT_SYMBOL(lookup_bdev_perm);
+
+/**
+ * lookup_bdev  - lookup a struct block_device by name
+ * @pathname:	special file representing the block device
+ *
+ * Get a reference to the blockdevice at @pathname in the current
+ * namespace if possible and return it.  Return ERR_PTR(error)
+ * otherwise.
+ */
+struct block_device *lookup_bdev(const char *pathname)
+{
+	return __lookup_bdev(pathname, 0, false);
+}
 EXPORT_SYMBOL(lookup_bdev);
 
 int __invalidate_device(struct block_device *bdev, bool kill_dirty)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5ec201e8308c..d03c2061bdd2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2383,6 +2383,7 @@ static inline void unregister_chrdev(unsigned int major, const char *name)
 #define BLKDEV_MAJOR_HASH_SIZE	255
 extern const char *__bdevname(dev_t, char *buffer);
 extern const char *bdevname(struct block_device *bdev, char *buffer);
+extern struct block_device *lookup_bdev_perm(const char *, int);
 extern struct block_device *lookup_bdev(const char *);
 extern void blkdev_show(struct seq_file *,off_t);
 
-- 
1.9.1

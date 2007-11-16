Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lAGK7gnR018571
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 15:07:42 -0500
Subject: [PATCH 04/13] VFS: Add label field to the iattr structure
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: labeled-nfs@linux-nfs.org
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
References: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 16 Nov 2007 15:07:40 -0500
Message-Id: <1195243660.20981.11.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The ia_label and ia_label_len fields are used to hold the information taken
from the wire to be passed with the other file attributes to be set. This patch
also modifies inode_setattr to make use of the new iattr fields.

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
Signed-off-by: Matthew N. Dodd <Matthew.Dodd@sparta.com>
---
 fs/attr.c             |   40 ++++++++++++++++++++++++++++++++++++++++
 fs/xattr.c            |   31 +++++++++++++++++++++++++------
 include/linux/fs.h    |   11 +++++++++++
 include/linux/xattr.h |    1 +
 4 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 966b73e..50e34b9 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -5,6 +5,7 @@
  *  changes by Thomas Schoebel-Theuer
  */
 
+#include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/time.h>
 #include <linux/mm.h>
@@ -14,9 +15,32 @@
 #include <linux/fcntl.h>
 #include <linux/quotaops.h>
 #include <linux/security.h>
+#include <linux/xattr.h>
 
 /* Taken over from the old code... */
 
+int inode_setsecurity(struct inode *inode, struct iattr *attr)
+{
+	const char *key = security_inode_xattr_getname();
+	const char *suffix = key + XATTR_SECURITY_PREFIX_LEN;
+	int error;
+
+	if (inode->i_security == NULL)
+		return -EOPNOTSUPP;
+
+	if (!attr->ia_valid & ATTR_SECURITY_LABEL)
+		return -EINVAL;
+
+	error = security_inode_setsecurity(inode, suffix, attr->ia_label,
+					   attr->ia_label_len, 0);
+	if (error)
+		printk("%s() %s %d security_inode_setsecurity() %d\n", __func__,
+			(char *)attr->ia_label, attr->ia_label_len, error);
+
+	return (0);
+}
+EXPORT_SYMBOL(inode_setsecurity);
+
 /* POSIX UID/GID verification for setting inode attributes. */
 int inode_change_ok(struct inode *inode, struct iattr *attr)
 {
@@ -94,6 +118,10 @@ int inode_setattr(struct inode * inode, struct iattr * attr)
 			mode &= ~S_ISGID;
 		inode->i_mode = mode;
 	}
+#ifdef CONFIG_SECURITY
+	if (ia_valid & ATTR_SECURITY_LABEL)
+		inode_setsecurity(inode, attr);
+#endif
 	mark_inode_dirty(inode);
 
 	return 0;
@@ -157,6 +185,18 @@ int notify_change(struct dentry * dentry, struct iattr * attr)
 	if (ia_valid & ATTR_SIZE)
 		down_write(&dentry->d_inode->i_alloc_sem);
 
+#ifdef CONFIG_SECURITY
+	if (ia_valid & ATTR_SECURITY_LABEL) {
+		char *key = (char *)security_inode_xattr_getname();
+		vfs_setxattr_locked(dentry, key,
+			attr->ia_label, attr->ia_label_len, 0);
+		/* Avoid calling inode_setsecurity()
+		 * via inode_setattr() below
+		 */
+		attr->ia_valid &= ~ATTR_SECURITY_LABEL;
+	}
+#endif
+
 	if (inode->i_op && inode->i_op->setattr) {
 		error = security_inode_setattr(dentry, attr);
 		if (!error)
diff --git a/fs/xattr.c b/fs/xattr.c
index 91c7929..b7ebc85 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -67,9 +67,9 @@ xattr_permission(struct inode *inode, const char *name, int mask)
 	return permission(inode, mask, NULL);
 }
 
-int
-vfs_setxattr(struct dentry *dentry, char *name, void *value,
-		size_t size, int flags)
+static int
+_vfs_setxattr(struct dentry *dentry, char *name, void *value,
+		size_t size, int flags, int lock)
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
@@ -78,7 +78,8 @@ vfs_setxattr(struct dentry *dentry, char *name, void *value,
 	if (error)
 		return error;
 
-	mutex_lock(&inode->i_mutex);
+	if (lock)
+		mutex_lock(&inode->i_mutex);
 	error = security_inode_setxattr(dentry, name, value, size, flags);
 	if (error)
 		goto out;
@@ -95,15 +96,33 @@ vfs_setxattr(struct dentry *dentry, char *name, void *value,
 		const char *suffix = name + XATTR_SECURITY_PREFIX_LEN;
 		error = security_inode_setsecurity(inode, suffix, value,
 						   size, flags);
-		if (!error)
+		if (!error) {
+			fsnotify_change(dentry, ATTR_SECURITY_LABEL);
 			fsnotify_xattr(dentry);
+		}
 	}
 out:
-	mutex_unlock(&inode->i_mutex);
+	if (lock)
+		mutex_unlock(&inode->i_mutex);
 	return error;
 }
+
+int
+vfs_setxattr(struct dentry *dentry, char *name, void *value,
+		size_t size, int flags)
+{
+	return _vfs_setxattr(dentry, name, value, size, flags, 1);
+}
 EXPORT_SYMBOL_GPL(vfs_setxattr);
 
+int
+vfs_setxattr_locked(struct dentry *dentry, char *name, void *value,
+			size_t size, int flags)
+{
+	return _vfs_setxattr(dentry, name, value, size, flags, 0);
+}
+EXPORT_SYMBOL_GPL(vfs_setxattr_locked);
+
 ssize_t
 xattr_getsecurity(struct inode *inode, const char *name, void *value,
 			size_t size)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b3ec4a4..3383ae4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -333,6 +333,10 @@ typedef void (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define ATTR_KILL_PRIV	16384
 #define ATTR_OPEN	32768	/* Truncating from open(O_TRUNC) */
 
+#ifdef CONFIG_SECURITY
+#define ATTR_SECURITY_LABEL  65536
+#endif
+
 /*
  * This is the Inode Attributes structure, used for notify_change().  It
  * uses the above definitions as flags, to know which values have changed.
@@ -358,6 +362,10 @@ struct iattr {
 	 * check for (ia_valid & ATTR_FILE), and not for (ia_file != NULL).
 	 */
 	struct file	*ia_file;
+#ifdef CONFIG_SECURITY
+	void		*ia_label;
+	u32		 ia_label_len;
+#endif
 };
 
 /*
@@ -1974,6 +1982,9 @@ extern int buffer_migrate_page(struct address_space *,
 #define buffer_migrate_page NULL
 #endif
 
+#ifdef CONFIG_SECURITY
+extern int inode_setsecurity(struct inode *inode, struct iattr *attr);
+#endif
 extern int inode_change_ok(struct inode *, struct iattr *);
 extern int __must_check inode_setattr(struct inode *, struct iattr *);
 
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index df6b95d..1169963 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -50,6 +50,7 @@ ssize_t xattr_getsecurity(struct inode *, const char *, void *, size_t);
 ssize_t vfs_getxattr(struct dentry *, char *, void *, size_t);
 ssize_t vfs_listxattr(struct dentry *d, char *list, size_t size);
 int vfs_setxattr(struct dentry *, char *, void *, size_t, int);
+int vfs_setxattr_locked(struct dentry *, char *, void *, size_t, int);
 int vfs_removexattr(struct dentry *, char *);
 
 ssize_t generic_getxattr(struct dentry *dentry, const char *name, void *buffer, size_t size);
-- 
1.5.3.4



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

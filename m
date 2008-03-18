From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: casey@schaufler-ca.com, chrisw@sous-sol.org, sds@tycho.nsa.gov,
        jmorris@namei.org, hch@lst.de, viro@zeniv.linux.org.uk
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org,
        "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: [PATCH 1/2] VFS: Factor out part of vfs_setxattr so it can be called from the SELinux hook for inode_setsecctx.
Date: Tue, 18 Mar 2008 14:57:43 -0400
Message-Id: <1205866664-24902-2-git-send-email-dpquigl@tycho.nsa.gov>
In-Reply-To: <1205866664-24902-1-git-send-email-dpquigl@tycho.nsa.gov>
References: <1205866664-24902-1-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This factors out the part of the vfs_setxattr function that performs the
setting of the xattr and its notification. This is needed so the SELinux
implementation of inode_setsecctx can handle the setting of it's xattr while
maintaining the proper separation of layers.

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
---
 fs/xattr.c            |   55 +++++++++++++++++++++++++++++++++++++-----------
 include/linux/xattr.h |    3 +-
 2 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 3acab16..464265e 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -67,22 +67,28 @@ xattr_permission(struct inode *inode, const char *name, int mask)
 	return permission(inode, mask, NULL);
 }
 
-int
-vfs_setxattr(struct dentry *dentry, char *name, void *value,
+/**
+ *  __vfs_setxattr_noperm - perform setxattr operation without performing
+ *  permission checks.
+ *
+ *  @dentry - object to perform setxattr on
+ *  @name - xattr name to set
+ *  @value - value to set @name to
+ *  @size - size of @value
+ *  @flags
+ *
+ *  returns the result of the internel setxattr or setsecurity operations.
+ *
+ *  This function requires the the caller locks the inode's i_mutex before it
+ *  is executed. It also that the caller will make the appropriate permission
+ *  checks.
+ */
+int __vfs_setxattr_noperm(struct dentry *dentry, char *name, void *value,
 		size_t size, int flags)
 {
 	struct inode *inode = dentry->d_inode;
-	int error;
-
-	error = xattr_permission(inode, name, MAY_WRITE);
-	if (error)
-		return error;
-
-	mutex_lock(&inode->i_mutex);
-	error = security_inode_setxattr(dentry, name, value, size, flags);
-	if (error)
-		goto out;
-	error = -EOPNOTSUPP;
+	int error = -EOPNOTSUPP;
+	
 	if (inode->i_op->setxattr) {
 		error = inode->i_op->setxattr(dentry, name, value, size, flags);
 		if (!error) {
@@ -98,6 +104,29 @@ vfs_setxattr(struct dentry *dentry, char *name, void *value,
 		if (!error)
 			fsnotify_xattr(dentry);
 	}
+
+	return error;
+}
+
+
+int
+vfs_setxattr(struct dentry *dentry, char *name, void *value,
+		size_t size, int flags)
+{
+	struct inode *inode = dentry->d_inode;
+	int error;
+
+	error = xattr_permission(inode, name, MAY_WRITE);
+	if (error)
+		return error;
+
+	mutex_lock(&inode->i_mutex);
+	error = security_inode_setxattr(dentry, name, value, size, flags);
+	if (error)
+		goto out;
+
+	error = __vfs_setxattr_noperm(dentry, name, value, size, flags);
+
 out:
 	mutex_unlock(&inode->i_mutex);
 	return error;
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index df6b95d..324c792 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -49,7 +49,8 @@ struct xattr_handler {
 ssize_t xattr_getsecurity(struct inode *, const char *, void *, size_t);
 ssize_t vfs_getxattr(struct dentry *, char *, void *, size_t);
 ssize_t vfs_listxattr(struct dentry *d, char *list, size_t size);
-int vfs_setxattr(struct dentry *, char *, void *, size_t, int);
+int __vfs_setxattr_noperm(struct dentry *, char *, void *, size_t, int);
+int do_setxattr(struct dentry *, char *, void *, size_t, int);
 int vfs_removexattr(struct dentry *, char *);
 
 ssize_t generic_getxattr(struct dentry *dentry, const char *name, void *buffer, size_t size);
-- 
1.5.4.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

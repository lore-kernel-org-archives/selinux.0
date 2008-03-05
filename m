From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: casey@schaufler-ca.com, chrisw@sous-sol.org, sds@tycho.nsa.gov,
        jmorris@namei.org, hch@lst.de, viro@zeniv.linux.org.uk
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: [PATCH 1/2] VFS: Factor out part of vfs_setxattr so it can be called from the SELinux hook for inode_setsecctx.
Date: Wed,  5 Mar 2008 13:54:47 -0500
Message-Id: <1204743288-3461-2-git-send-email-dpquigl@tycho.nsa.gov>
In-Reply-To: <1204743288-3461-1-git-send-email-dpquigl@tycho.nsa.gov>
References: <1204743288-3461-1-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This factors out the part of the vfs_setxattr function that performs the
setting of the xattr and its notification. This is needed so the SELinux
implementation of inode_setsecctx can handle the setting of it's xattr while
maintaining the proper separation of layers.

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
---
 fs/xattr.c            |   40 ++++++++++++++++++++++++++--------------
 include/linux/xattr.h |    1 +
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 3acab16..3811a41 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -66,23 +66,12 @@ xattr_permission(struct inode *inode, const char *name, int mask)
 
 	return permission(inode, mask, NULL);
 }
-
-int
-vfs_setxattr(struct dentry *dentry, char *name, void *value,
+int do_setxattr(struct dentry *dentry, char *name, void *value,
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
@@ -98,6 +87,29 @@ vfs_setxattr(struct dentry *dentry, char *name, void *value,
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
+	error = do_setxattr(dentry, name, value, size, flags);
+
 out:
 	mutex_unlock(&inode->i_mutex);
 	return error;
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index df6b95d..c7c1dc5 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -50,6 +50,7 @@ ssize_t xattr_getsecurity(struct inode *, const char *, void *, size_t);
 ssize_t vfs_getxattr(struct dentry *, char *, void *, size_t);
 ssize_t vfs_listxattr(struct dentry *d, char *list, size_t size);
 int vfs_setxattr(struct dentry *, char *, void *, size_t, int);
+int do_setxattr(struct dentry *, char *, void *, size_t, int);
 int vfs_removexattr(struct dentry *, char *);
 
 ssize_t generic_getxattr(struct dentry *dentry, const char *name, void *buffer, size_t size);
-- 
1.5.4.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

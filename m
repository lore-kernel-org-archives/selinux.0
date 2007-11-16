Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lAGK5U4n018143
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 15:05:30 -0500
Subject: [PATCH 01/13] VFS/Security: Rework inode_getsecurity and callers
	to return resulting buffer
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: labeled-nfs@linux-nfs.org
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
References: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 16 Nov 2007 15:05:29 -0500
Message-Id: <1195243529.20981.5.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch modifies the interface to inode_getsecurity to have the function
return a buffer containing the security blob and its length via parameters
instead of relying on the calling function to give it an appropriately sized
buffer. Security blobs obtained with this function should be freed using the
release_secctx LSM hook. This alleviates the problem of the caller having to
guess a length and preallocate a buffer for this function allowing it to be
used elsewhere for Labeled NFS. The patch also removed the unused err
parameter. The conversion is similar to the one performed by Al Viro for the
security_getprocattr hook.

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
Signed-off-by: Matthew N. Dodd <Matthew.Dodd@sparta.com>
---
 fs/xattr.c               |   30 ++++++++++++++++++++++++++++--
 include/linux/security.h |   21 +++++++++------------
 include/linux/xattr.h    |    1 +
 mm/shmem.c               |    3 +--
 security/dummy.c         |    2 +-
 security/security.c      |    4 ++--
 security/selinux/hooks.c |   43 +++++++++++++++----------------------------
 7 files changed, 57 insertions(+), 47 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 6645b73..56b5b88 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -105,6 +105,33 @@ out:
 EXPORT_SYMBOL_GPL(vfs_setxattr);
 
 ssize_t
+xattr_getsecurity(struct inode *inode, const char *name, void *value,
+			size_t size)
+{
+	void *buffer = NULL;
+	ssize_t len;
+
+	if (!value || !size) {
+		len = security_inode_getsecurity(inode, name, &buffer, false);
+		goto out_noalloc;
+	}
+	
+	len = security_inode_getsecurity(inode, name, &buffer, true);
+	if (len < 0)
+		return len;
+	if (size < len) {
+		len = -ERANGE;
+		goto out;
+	}
+	memcpy(value, buffer, len);
+out:
+	security_release_secctx(buffer, len);
+out_noalloc:
+	return len;
+}
+EXPORT_SYMBOL_GPL(xattr_getsecurity);
+
+ssize_t
 vfs_getxattr(struct dentry *dentry, char *name, void *value, size_t size)
 {
 	struct inode *inode = dentry->d_inode;
@@ -126,8 +153,7 @@ vfs_getxattr(struct dentry *dentry, char *name, void *value, size_t size)
 	if (!strncmp(name, XATTR_SECURITY_PREFIX,
 				XATTR_SECURITY_PREFIX_LEN)) {
 		const char *suffix = name + XATTR_SECURITY_PREFIX_LEN;
-		int ret = security_inode_getsecurity(inode, suffix, value,
-						     size, error);
+		int ret = xattr_getsecurity(inode, suffix, value, size);
 		/*
 		 * Only overwrite the return value if a security module
 		 * is actually active.
diff --git a/include/linux/security.h b/include/linux/security.h
index ac05083..3c4c91e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -404,15 +404,12 @@ struct request_sock;
  * 	identified by @name for @dentry.
  * 	Return 0 if permission is granted.
  * @inode_getsecurity:
- *	Copy the extended attribute representation of the security label 
- *	associated with @name for @inode into @buffer.  @buffer may be
- *	NULL to request the size of the buffer required.  @size indicates
- *	the size of @buffer in bytes.  Note that @name is the remainder
- *	of the attribute name after the security. prefix has been removed.
- *	@err is the return value from the preceding fs getxattr call,
- *	and can be used by the security module to determine whether it
- *	should try and canonicalize the attribute value.
- *	Return number of bytes used/required on success.
+ *	Retrieve a copy of the extended attribute representation of the
+ *	security label associated with @name for @inode via @buffer.  Note that
+ *	@name is the remainder of the attribute name after the security prefix
+ *	has been removed. @alloc is used to specify of the call should return a
+ *	value via the buffer or just the value length Return size of buffer on
+ *	success.
  * @inode_setsecurity:
  *	Set the security label associated with @name for @inode from the
  *	extended attribute value @value.  @size indicates the size of the
@@ -1275,7 +1272,7 @@ struct security_operations {
 	int (*inode_removexattr) (struct dentry *dentry, char *name);
 	int (*inode_need_killpriv) (struct dentry *dentry);
 	int (*inode_killpriv) (struct dentry *dentry);
-  	int (*inode_getsecurity)(const struct inode *inode, const char *name, void *buffer, size_t size, int err);
+  	int (*inode_getsecurity)(const struct inode *inode, const char *name, void **buffer, bool alloc);
   	int (*inode_setsecurity)(struct inode *inode, const char *name, const void *value, size_t size, int flags);
   	int (*inode_listsecurity)(struct inode *inode, char *buffer, size_t buffer_size);
 
@@ -1529,7 +1526,7 @@ int security_inode_listxattr(struct dentry *dentry);
 int security_inode_removexattr(struct dentry *dentry, char *name);
 int security_inode_need_killpriv(struct dentry *dentry);
 int security_inode_killpriv(struct dentry *dentry);
-int security_inode_getsecurity(const struct inode *inode, const char *name, void *buffer, size_t size, int err);
+int security_inode_getsecurity(const struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
 int security_file_permission(struct file *file, int mask);
@@ -1933,7 +1930,7 @@ static inline int security_inode_killpriv(struct dentry *dentry)
 	return cap_inode_killpriv(dentry);
 }
 
-static inline int security_inode_getsecurity(const struct inode *inode, const char *name, void *buffer, size_t size, int err)
+static inline int security_inode_getsecurity(const struct inode *inode, const char *name, void **buffer, bool alloc)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index def131a..df6b95d 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -46,6 +46,7 @@ struct xattr_handler {
 		   size_t size, int flags);
 };
 
+ssize_t xattr_getsecurity(struct inode *, const char *, void *, size_t);
 ssize_t vfs_getxattr(struct dentry *, char *, void *, size_t);
 ssize_t vfs_listxattr(struct dentry *d, char *list, size_t size);
 int vfs_setxattr(struct dentry *, char *, void *, size_t, int);
diff --git a/mm/shmem.c b/mm/shmem.c
index 253d205..ba59f48 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1995,8 +1995,7 @@ static int shmem_xattr_security_get(struct inode *inode, const char *name,
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	return security_inode_getsecurity(inode, name, buffer, size,
-					  -EOPNOTSUPP);
+	return xattr_getsecurity(inode, name, buffer, size);
 }
 
 static int shmem_xattr_security_set(struct inode *inode, const char *name,
diff --git a/security/dummy.c b/security/dummy.c
index 6d895ad..7de65dc 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -384,7 +384,7 @@ static int dummy_inode_killpriv(struct dentry *dentry)
 	return 0;
 }
 
-static int dummy_inode_getsecurity(const struct inode *inode, const char *name, void *buffer, size_t size, int err)
+static int dummy_inode_getsecurity(const struct inode *inode, const char *name, void **buffer, bool alloc)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index 0e1f1f1..39de3f4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -478,11 +478,11 @@ int security_inode_killpriv(struct dentry *dentry)
 	return security_ops->inode_killpriv(dentry);
 }
 
-int security_inode_getsecurity(const struct inode *inode, const char *name, void *buffer, size_t size, int err)
+int security_inode_getsecurity(const struct inode *inode, const char *name, void **buffer, bool alloc)
 {
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
-	return security_ops->inode_getsecurity(inode, name, buffer, size, err);
+	return security_ops->inode_getsecurity(inode, name, buffer, alloc);
 }
 
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9f3124b..128f363 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -127,32 +127,6 @@ static DEFINE_SPINLOCK(sb_security_lock);
 
 static struct kmem_cache *sel_inode_cache;
 
-/* Return security context for a given sid or just the context 
-   length if the buffer is null or length is 0 */
-static int selinux_getsecurity(u32 sid, void *buffer, size_t size)
-{
-	char *context;
-	unsigned len;
-	int rc;
-
-	rc = security_sid_to_context(sid, &context, &len);
-	if (rc)
-		return rc;
-
-	if (!buffer || !size)
-		goto getsecurity_exit;
-
-	if (size < len) {
-		len = -ERANGE;
-		goto getsecurity_exit;
-	}
-	memcpy(buffer, context, len);
-
-getsecurity_exit:
-	kfree(context);
-	return len;
-}
-
 /* Allocate and free functions for each kind of security blob. */
 
 static int task_alloc_security(struct task_struct *task)
@@ -2416,14 +2390,27 @@ static int selinux_inode_removexattr (struct dentry *dentry, char *name)
  *
  * Permission check is handled by selinux_inode_getxattr hook.
  */
-static int selinux_inode_getsecurity(const struct inode *inode, const char *name, void *buffer, size_t size, int err)
+static int selinux_inode_getsecurity(const struct inode *inode, const char *name, void **buffer, bool alloc)
 {
+	u32 size;
+	int error;
+	char *context = NULL;
 	struct inode_security_struct *isec = inode->i_security;
 
 	if (strcmp(name, XATTR_SELINUX_SUFFIX))
 		return -EOPNOTSUPP;
 
-	return selinux_getsecurity(isec->sid, buffer, size);
+	error = security_sid_to_context(isec->sid, &context, &size);
+	if (error)
+		return error;
+	error = size;
+	if (alloc) {
+		*buffer = context;
+		goto out_nofree;
+	}
+	kfree(context);
+out_nofree:
+	return error;
 }
 
 static int selinux_inode_setsecurity(struct inode *inode, const char *name,
-- 
1.5.3.4



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

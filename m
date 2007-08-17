From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: jmorris@namei.org
Cc: selinux@tycho.nsa.gov, "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: [PATCH 1/2] VFS/Security: Rework inode_getsecurity and callers to return resulting buffer
Date: Fri, 17 Aug 2007 13:01:13 -0400
Message-Id: <11873700741313-git-send-email-dpquigl@tycho.nsa.gov>
In-Reply-To: <1187370074408-git-send-email-dpquigl@tycho.nsa.gov>
References: <1187370074408-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: David P. Quigley <dpquigl@tycho.nsa.gov>

This patch modifies the interface to inode_getsecurity to have the function
return a buffer containing the security blob and its length via parameters
instead of relying on the calling function to give it an appropriately sized
buffer. Security blobs obtained with this function should be freed using the
release_secctx LSM hook. This alleviates the problem of the caller having to
guess a length and preallocate a buffer for this function allowing it to be
used elsewhere for Labeled NFS. The patch also removed the unused err
parameter. The same conversion is similar to the one used by Al Viro for the
security_getprocattr hook.

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
---
 fs/xattr.c               |   27 +++++++++++++++++++++++++--
 include/linux/security.h |   27 ++++++++++++++-------------
 include/linux/xattr.h    |    1 +
 mm/shmem.c               |    3 +--
 security/dummy.c         |    4 +++-
 security/selinux/hooks.c |   39 +++++++++++----------------------------
 6 files changed, 55 insertions(+), 46 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index a44fd92..6d59a72 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -105,6 +105,30 @@ out:
 EXPORT_SYMBOL_GPL(vfs_setxattr);
 
 ssize_t
+xattr_getsecurity(struct inode *inode, const char *name, void *value,
+			size_t size)
+{
+	void *buffer = NULL;
+	ssize_t len;
+
+	len = security_inode_getsecurity(inode, name, &buffer);
+	if (len < 0)
+		return len;
+	if (!value || !size) {
+		goto out;
+	}
+	if (size < len) {
+		len = -ERANGE;
+		goto out;
+	}
+	memcpy(value, buffer, len);
+out:
+	security_release_secctx(buffer, len);
+	return len;
+}
+EXPORT_SYMBOL_GPL(xattr_getsecurity);
+
+ssize_t
 vfs_getxattr(struct dentry *dentry, char *name, void *value, size_t size)
 {
 	struct inode *inode = dentry->d_inode;
@@ -126,8 +150,7 @@ vfs_getxattr(struct dentry *dentry, char *name, void *value, size_t size)
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
index c11dc8a..b6dfa0a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -391,15 +391,11 @@ struct request_sock;
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
+ *	@name is the remainder of the attribute name after the security. prefix
+ *	has been removed.  
+ *	Return size of buffer on success.
  * @inode_setsecurity:
  *	Set the security label associated with @name for @inode from the
  *	extended attribute value @value.  @size indicates the size of the
@@ -1232,7 +1228,8 @@ struct security_operations {
 	int (*inode_listxattr) (struct dentry *dentry);
 	int (*inode_removexattr) (struct dentry *dentry, char *name);
 	const char *(*inode_xattr_getsuffix) (void);
-  	int (*inode_getsecurity)(const struct inode *inode, const char *name, void *buffer, size_t size, int err);
+	int (*inode_getsecurity)(const struct inode *inode, const char *name,
+					void **buffer);
   	int (*inode_setsecurity)(struct inode *inode, const char *name, const void *value, size_t size, int flags);
   	int (*inode_listsecurity)(struct inode *inode, char *buffer, size_t buffer_size);
 
@@ -1772,11 +1769,13 @@ static inline const char *security_inode_xattr_getsuffix(void)
 	return security_ops->inode_xattr_getsuffix();
 }
 
-static inline int security_inode_getsecurity(const struct inode *inode, const char *name, void *buffer, size_t size, int err)
+static inline int security_inode_getsecurity(const struct inode *inode,
+						const char *name,
+						void **buffer)
 {
 	if (unlikely (IS_PRIVATE (inode)))
 		return 0;
-	return security_ops->inode_getsecurity(inode, name, buffer, size, err);
+	return security_ops->inode_getsecurity(inode, name, buffer);
 }
 
 static inline int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
@@ -2458,7 +2457,9 @@ static inline const char *security_inode_xattr_getsuffix (void)
 	return NULL ;
 }
 
-static inline int security_inode_getsecurity(const struct inode *inode, const char *name, void *buffer, size_t size, int err)
+static inline int security_inode_getsecurity(const struct inode *inode,
+						const char *name,
+						void **buffer)
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
index fcd19d3..5ed3a66 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1958,8 +1958,7 @@ static int shmem_xattr_security_get(struct inode *inode, const char *name,
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	return security_inode_getsecurity(inode, name, buffer, size,
-					  -EOPNOTSUPP);
+	return xattr_getsecurity(inode, name, buffer, size);
 }
 
 static int shmem_xattr_security_set(struct inode *inode, const char *name,
diff --git a/security/dummy.c b/security/dummy.c
index 19d813d..b1d28b4 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -377,7 +377,9 @@ static int dummy_inode_removexattr (struct dentry *dentry, char *name)
 	return 0;
 }
 
-static int dummy_inode_getsecurity(const struct inode *inode, const char *name, void *buffer, size_t size, int err)
+static int dummy_inode_getsecurity(const struct inode *inode,
+					const char *name,
+					void **buffer)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6237933..bd51f74 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -125,32 +125,6 @@ static DEFINE_SPINLOCK(sb_security_lock);
 
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
@@ -2418,14 +2392,23 @@ static const char *selinux_inode_xattr_getsuffix(void)
  *
  * Permission check is handled by selinux_inode_getxattr hook.
  */
-static int selinux_inode_getsecurity(const struct inode *inode, const char *name, void *buffer, size_t size, int err)
+static int selinux_inode_getsecurity(const struct inode *inode,
+					const char *name,
+					void **buffer)
 {
+	u32 size;
+	int error;
 	struct inode_security_struct *isec = inode->i_security;
 
 	if (strcmp(name, XATTR_SELINUX_SUFFIX))
 		return -EOPNOTSUPP;
 
-	return selinux_getsecurity(isec->sid, buffer, size);
+	error = security_sid_to_context(isec->sid, (char **)buffer, &size);
+	if (error)
+		return error;
+	error = size;
+	return error;
+	
 }
 
 static int selinux_inode_setsecurity(struct inode *inode, const char *name,
-- 
1.5.2.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

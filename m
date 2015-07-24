From: Lukasz Pawelczyk <l.pawelczyk@samsung.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@amacapital.net>, Arnd Bergmann <arnd@arndb.de>,
 Casey Schaufler <casey@schaufler-ca.com>,
 David Howells <dhowells@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Eric Paris <eparis@parisplace.org>,
 Fabian Frederick <fabf@skynet.be>, Greg KH <gregkh@linuxfoundation.org>,
 James Morris <james.l.morris@oracle.com>, Jiri Slaby <jslaby@suse.com>,
 Joe Perches <joe@perches.com>, John Johansen <john.johansen@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
 Lukasz Pawelczyk <l.pawelczyk@samsung.com>,
 Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 NeilBrown <neilb@suse.de>, Oleg Nesterov <oleg@redhat.com>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Zefan Li <lizefan@huawei.com>, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: [PATCH v3 04/11] lsm: inode_pre_setxattr hook
Date: Fri, 24 Jul 2015 12:04:38 +0200
Message-id: <1437732285-11524-5-git-send-email-l.pawelczyk@samsung.com>
In-reply-to: <1437732285-11524-1-git-send-email-l.pawelczyk@samsung.com>
References: <1437732285-11524-1-git-send-email-l.pawelczyk@samsung.com>
Cc: havner@gmail.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add a new LSM hook called before inode's setxattr. It is required for
LSM to be able to reliably replace the xattr's value to be set to
filesystem in __vfs_setxattr_noperm(). Useful for mapped values, like in
the upcoming Smack namespace patches.

Signed-off-by: Lukasz Pawelczyk <l.pawelczyk@samsung.com>
---
 fs/xattr.c                | 10 ++++++++++
 include/linux/lsm_hooks.h |  9 +++++++++
 include/linux/security.h  | 10 ++++++++++
 security/security.c       | 12 ++++++++++++
 4 files changed, 41 insertions(+)

diff --git a/fs/xattr.c b/fs/xattr.c
index 072fee1..cbc8d19 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -100,12 +100,22 @@ int __vfs_setxattr_noperm(struct dentry *dentry, const char *name,
 	if (issec)
 		inode->i_flags &= ~S_NOSEC;
 	if (inode->i_op->setxattr) {
+		bool alloc = false;
+
+		error = security_inode_pre_setxattr(dentry, name, &value,
+						    &size, flags, &alloc);
+		if (error)
+			return error;
+
 		error = inode->i_op->setxattr(dentry, name, value, size, flags);
 		if (!error) {
 			fsnotify_xattr(dentry);
 			security_inode_post_setxattr(dentry, name, value,
 						     size, flags);
 		}
+
+		if (alloc)
+			kfree(value);
 	} else if (issec) {
 		const char *suffix = name + XATTR_SECURITY_PREFIX_LEN;
 		error = security_inode_setsecurity(inode, suffix, value,
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 1751864..0aeed91 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -349,6 +349,11 @@
  *	Check permission before setting the extended attributes
  *	@value identified by @name for @dentry.
  *	Return 0 if permission is granted.
+ * @inode_pre_setxattr:
+ *	Be able to do some operation before setting the @value identified
+ *	by @name on the filesystem. Replacing the @value and its @size is
+ *	possible. Useful for mapped values. Set @alloc to true if @value
+ *	needs to be kfreed afterwards.
  * @inode_post_setxattr:
  *	Update inode security field after successful setxattr operation.
  *	@value identified by @name for @dentry.
@@ -1448,6 +1453,9 @@ union security_list_options {
 	int (*inode_getattr)(const struct path *path);
 	int (*inode_setxattr)(struct dentry *dentry, const char *name,
 				const void *value, size_t size, int flags);
+	int (*inode_pre_setxattr)(struct dentry *dentry, const char *name,
+				  const void **value, size_t *size,
+				  int flags, bool *alloc);
 	void (*inode_post_setxattr)(struct dentry *dentry, const char *name,
 					const void *value, size_t size,
 					int flags);
@@ -1730,6 +1738,7 @@ struct security_hook_heads {
 	struct list_head inode_setattr;
 	struct list_head inode_getattr;
 	struct list_head inode_setxattr;
+	struct list_head inode_pre_setxattr;
 	struct list_head inode_post_setxattr;
 	struct list_head inode_getxattr;
 	struct list_head inode_listxattr;
diff --git a/include/linux/security.h b/include/linux/security.h
index f0d2914..24f91e0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -263,6 +263,9 @@ int security_inode_setattr(struct dentry *dentry, struct iattr *attr);
 int security_inode_getattr(const struct path *path);
 int security_inode_setxattr(struct dentry *dentry, const char *name,
 			    const void *value, size_t size, int flags);
+int security_inode_pre_setxattr(struct dentry *dentry, const char *name,
+				const void **value, size_t *size, int flags,
+				bool *alloc);
 void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags);
 int security_inode_getxattr(struct dentry *dentry, const char *name);
@@ -691,6 +694,13 @@ static inline int security_inode_setxattr(struct dentry *dentry,
 	return cap_inode_setxattr(dentry, name, value, size, flags);
 }
 
+static inline int security_inode_pre_setxattr(struct dentry *dentry,
+				const char *name, const void **value,
+				size_t *size, int flags, bool *alloc)
+{
+	return 0;
+}
+
 static inline void security_inode_post_setxattr(struct dentry *dentry,
 		const char *name, const void *value, size_t size, int flags)
 { }
diff --git a/security/security.c b/security/security.c
index 88a3b78..e1d2c6f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -649,6 +649,16 @@ int security_inode_setxattr(struct dentry *dentry, const char *name,
 	return evm_inode_setxattr(dentry, name, value, size);
 }
 
+int security_inode_pre_setxattr(struct dentry *dentry, const char *name,
+				const void **value, size_t *size, int flags,
+				bool *alloc)
+{
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+	return call_int_hook(inode_pre_setxattr, 0, dentry, name, value, size,
+			     flags, alloc);
+}
+
 void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags)
 {
@@ -1666,6 +1676,8 @@ struct security_hook_heads security_hook_heads = {
 		LIST_HEAD_INIT(security_hook_heads.inode_getattr),
 	.inode_setxattr =
 		LIST_HEAD_INIT(security_hook_heads.inode_setxattr),
+	.inode_pre_setxattr =
+		LIST_HEAD_INIT(security_hook_heads.inode_pre_setxattr),
 	.inode_post_setxattr =
 		LIST_HEAD_INIT(security_hook_heads.inode_post_setxattr),
 	.inode_getxattr =
-- 
2.4.3

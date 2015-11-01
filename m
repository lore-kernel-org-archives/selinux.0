Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tA1HOfFQ002493
 for <selinux@tycho.nsa.gov>; Sun, 1 Nov 2015 12:24:46 -0500
From: Andreas Gruenbacher <agruenba@redhat.com>
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v5 3/7] security: Make inode argument of inode_getsecid
 non-const
Date: Sun,  1 Nov 2015 18:24:29 +0100
Message-Id: <1446398673-886-4-git-send-email-agruenba@redhat.com>
In-Reply-To: <1446398673-886-1-git-send-email-agruenba@redhat.com>
References: <1446398673-886-1-git-send-email-agruenba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Make the inode argument of the inode_getsecid hook non-const so that we
can use it to revalidate invalid security labels.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
---
 include/linux/audit.h      | 8 ++++----
 include/linux/lsm_hooks.h  | 2 +-
 include/linux/security.h   | 4 ++--
 kernel/audit.c             | 2 +-
 kernel/audit.h             | 2 +-
 kernel/auditsc.c           | 6 +++---
 security/security.c        | 2 +-
 security/selinux/hooks.c   | 2 +-
 security/smack/smack_lsm.c | 2 +-
 9 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index b2abc99..7a9e0d7 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -137,7 +137,7 @@ extern void __audit_getname(struct filename *name);
 extern void __audit_inode(struct filename *name, const struct dentry *dentry,
 				unsigned int flags);
 extern void __audit_file(const struct file *);
-extern void __audit_inode_child(const struct inode *parent,
+extern void __audit_inode_child(struct inode *parent,
 				const struct dentry *dentry,
 				const unsigned char type);
 extern void __audit_seccomp(unsigned long syscall, long signr, int code);
@@ -202,7 +202,7 @@ static inline void audit_inode_parent_hidden(struct filename *name,
 		__audit_inode(name, dentry,
 				AUDIT_INODE_PARENT | AUDIT_INODE_HIDDEN);
 }
-static inline void audit_inode_child(const struct inode *parent,
+static inline void audit_inode_child(struct inode *parent,
 				     const struct dentry *dentry,
 				     const unsigned char type) {
 	if (unlikely(!audit_dummy_context()))
@@ -359,7 +359,7 @@ static inline void __audit_inode(struct filename *name,
 					const struct dentry *dentry,
 					unsigned int flags)
 { }
-static inline void __audit_inode_child(const struct inode *parent,
+static inline void __audit_inode_child(struct inode *parent,
 					const struct dentry *dentry,
 					const unsigned char type)
 { }
@@ -373,7 +373,7 @@ static inline void audit_file(struct file *file)
 static inline void audit_inode_parent_hidden(struct filename *name,
 				const struct dentry *dentry)
 { }
-static inline void audit_inode_child(const struct inode *parent,
+static inline void audit_inode_child(struct inode *parent,
 				     const struct dentry *dentry,
 				     const unsigned char type)
 { }
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index bdd0a3a..4c48227 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1420,7 +1420,7 @@ union security_list_options {
 					int flags);
 	int (*inode_listsecurity)(struct inode *inode, char *buffer,
 					size_t buffer_size);
-	void (*inode_getsecid)(const struct inode *inode, u32 *secid);
+	void (*inode_getsecid)(struct inode *inode, u32 *secid);
 
 	int (*file_permission)(struct file *file, int mask);
 	int (*file_alloc_security)(struct file *file);
diff --git a/include/linux/security.h b/include/linux/security.h
index 9ee61b2..e79149a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -273,7 +273,7 @@ int security_inode_killpriv(struct dentry *dentry);
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(const struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, u32 *secid);
 int security_file_permission(struct file *file, int mask);
 int security_file_alloc(struct file *file);
 void security_file_free(struct file *file);
@@ -734,7 +734,7 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
 	return 0;
 }
 
-static inline void security_inode_getsecid(const struct inode *inode, u32 *secid)
+static inline void security_inode_getsecid(struct inode *inode, u32 *secid)
 {
 	*secid = 0;
 }
diff --git a/kernel/audit.c b/kernel/audit.c
index 662c007..d20f674 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1708,7 +1708,7 @@ static inline int audit_copy_fcaps(struct audit_names *name,
 
 /* Copy inode data into an audit_names. */
 void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
-		      const struct inode *inode)
+		      struct inode *inode)
 {
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
diff --git a/kernel/audit.h b/kernel/audit.h
index dadf86a..400877b 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -207,7 +207,7 @@ extern u32 audit_ever_enabled;
 
 extern void audit_copy_inode(struct audit_names *name,
 			     const struct dentry *dentry,
-			     const struct inode *inode);
+			     struct inode *inode);
 extern void audit_log_cap(struct audit_buffer *ab, char *prefix,
 			  kernel_cap_t *cap);
 extern void audit_log_name(struct audit_context *context,
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index b86cc04..195ffae 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1754,7 +1754,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
 		   unsigned int flags)
 {
 	struct audit_context *context = current->audit_context;
-	const struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_backing_inode(dentry);
 	struct audit_names *n;
 	bool parent = flags & AUDIT_INODE_PARENT;
 
@@ -1848,12 +1848,12 @@ void __audit_file(const struct file *file)
  * must be hooked prior, in order to capture the target inode during
  * unsuccessful attempts.
  */
-void __audit_inode_child(const struct inode *parent,
+void __audit_inode_child(struct inode *parent,
 			 const struct dentry *dentry,
 			 const unsigned char type)
 {
 	struct audit_context *context = current->audit_context;
-	const struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_backing_inode(dentry);
 	const char *dname = dentry->d_name.name;
 	struct audit_names *n, *found_parent = NULL, *found_child = NULL;
 
diff --git a/security/security.c b/security/security.c
index 73514c9..c5beb7e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -721,7 +721,7 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
 }
 EXPORT_SYMBOL(security_inode_listsecurity);
 
-void security_inode_getsecid(const struct inode *inode, u32 *secid)
+void security_inode_getsecid(struct inode *inode, u32 *secid)
 {
 	call_void_hook(inode_getsecid, inode, secid);
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index adec2e2..a8f09af 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3182,7 +3182,7 @@ static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t
 	return len;
 }
 
-static void selinux_inode_getsecid(const struct inode *inode, u32 *secid)
+static void selinux_inode_getsecid(struct inode *inode, u32 *secid)
 {
 	struct inode_security_struct *isec = inode->i_security;
 	*secid = isec->sid;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 07d0344..db75cd1 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1508,7 +1508,7 @@ static int smack_inode_listsecurity(struct inode *inode, char *buffer,
  * @inode: inode to extract the info from
  * @secid: where result will be saved
  */
-static void smack_inode_getsecid(const struct inode *inode, u32 *secid)
+static void smack_inode_getsecid(struct inode *inode, u32 *secid)
 {
 	struct inode_smack *isp = inode->i_security;
 
-- 
2.5.0

Date: Mon, 30 Oct 2017 21:04:20 +1100 (AEDT)
From: James Morris <james.l.morris@oracle.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Message-ID: <alpine.LFD.2.20.1710301859170.11614@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [RFC v0.1][PATCH] selinuxns: extend namespace support to
 security.selinux xattrs
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a proof-of-concept patch to demonstrate an approach to supporting 
SELinux namespaces for security.selinux xattr labels.

This follows on from the experimental SELinux namespace code posted by 
Stephen: https://marc.info/?l=selinux&m=150696042210126&w=2

In the initial code, namespacing was only implemented for in-core inodes 
per this posting: https://marc.info/?l=selinux&m=150696324110943&w=2

In this patch, namespacing is extended to on-disk inode labels (xattrs), 
transparently to normal applications.

A summary of the approach is as follows:

1. Add a namespace "name" field to the SELinux namespace, which is 
   specified by writing to the selinuxfs unshare node (instead of the 
   current boolean value) during namespace creation.

   e.g. if the namespace name is "vm8", run: 

   # echo vm8 > /sys/fs/selinux/unshare

   followed by the remaining steps from the original code.

   This value can also be read back from the node, and the initial SELinux 
   namespace is internally set to "init".

   
2. Transparently modify SELinux xattrs so that any non-initial namespace 
   xattrs include the namespace name. 

   e.g. if the namespace name is "vm6", the "security.selinux" xattr is 
   translated in the kernel to "security.selinux.ns.vm6" for disk read and
   write of xattrs.

   This allows each SELinux namespace to independently manage its own 
   xattr labels, transparently to applications. Namespaces only see their 
   own xattrs, which are acted on by their own namespaced policies.

   Note that the "init" namespace performs no translation for apps, it 
   just uses regular old security.selinux xattrs.


Some examples:

  [root@test]# cat /sys/fs/selinux/unshare 
  vm8

  [root@test]# touch testfile

  [root@test]# ls -Z testfile 
  -rw-r--r--. root root unconfined_u:object_r:unlabeled_t:s0 testfile

  [root@test]# getfattr -n security.selinux testfile 
  # file: testfile
  security.selinux="unconfined_u:object_r:unlabeled_t:s0"

  # restorecon -v testfile 
  restorecon reset /root/selinux/testfile context unconfined_u:object_r:unlabeled_t:s0->unconfined_u:object_r:admin_home_t:s0

  [root@test]# getfattr -n security.selinux testfile 
  # file: testfile
  security.selinux="unconfined_u:object_r:admin_home_t:s0"

  [root@test]# chcon -t etc_t testfile 

  [root@test]# getfattr -n security.selinux testfile 
  # file: testfile
  security.selinux="unconfined_u:object_r:etc_t:s0"


Ok, so this all looks pretty normal, but what's happening on disk is not.  
>From the init namespace, I'll access the same file:

  [root@test]# cat /sys/fs/selinux/unshare 
  init

  [root@test]# ls -Z testfile 
  -rw-r--r--. root root system_u:object_r:unlabeled_t:s0 testfile

  [root@test]# getfattr -n security.selinux testfile 
  # file: testfile
  security.selinux="system_u:object_r:unlabeled_t:s0"

There is in fact no security.selinux xattr yet on this file as it was 
created in a different namespace and only initialized there.  What you're 
seeing here is the default unlabeled label.  Dumping out the xattrs shows 
what's on disk:

  [root@test]# getfattr -d -m . testfile 
  # file: testfile
  security.selinux.ns.vm8="unconfined_u:object_r:etc_t:s0"

The xattr belonging to "vm8" is there but not being interpreted outside 
that namespace.  Let's give it a proper label for the init ns:

  # restorecon -v testfile 
  restorecon reset /root/selinux/testfile context system_u:object_r:unlabeled_t:s0->system_u:object_r:admin_home_t:s0

  [root@test]# getfattr -d -m . testfile 
  # file: testfile
  security.selinux="system_u:object_r:admin_home_t:s0"
  security.selinux.ns.vm8="unconfined_u:object_r:etc_t:s0"

  [root@test]# ls -Z testfile 
  -rw-r--r--. root root system_u:object_r:admin_home_t:s0 testfile

And if you go into the vm8 namespace you'll see the label there is:

  [root@test]# echo  vm8 > /sys/fs/selinux/unshare 
  [root@test]# unshare -m -n
  [root@test]# umount /sys/fs/selinux && mount -t selinuxfs none /sys/fs/selinux && load_policy
  [root@test]# runcon unconfined_u:unconfined_r:unconfined_t:s0:c0.c1023 /bin/bash
  [root@test]# setenforce 1

  [root@test]# ls -Z testfile 
  -rw-r--r--. root root unconfined_u:object_r:etc_t:s0   testfile


I hope that demonstrates the concept well enough: that there are zero 
changes for applications and the namespaced policy always uses xattrs 
belonging to that namespace.

The prototype code is far from complete, and also needs to implement 
support for listxattr and removexattr, as well as provide appropriate 
administrative access to raw (untranslated) xattrs, which you can 
currently see from any ns but not write at all.  Other TODO items include 
accounting for dynamic xattr name size, nested policy enforcement, 
uniqueness of namespace names, and better audit support.

Comments?

Patch below...

---
From: James Morris <james.l.morris@oracle.com>
Date: Mon, 30 Oct 2017 19:10:36 +1100
Subject: [PATCH] selinuxns: extend namespace support to security.selinux xattrs

Prototype code only.

Signed-off-by: James Morris <james.l.morris@oracle.com>
---
 fs/xattr.c                            | 12 ++++--
 include/linux/lsm_hooks.h             |  2 +
 include/linux/security.h              |  6 +++
 include/linux/xattr.h                 |  2 +-
 include/uapi/linux/xattr.h            |  3 ++
 security/integrity/evm/evm_crypto.c   |  2 +-
 security/integrity/ima/ima_appraise.c |  2 +-
 security/security.c                   |  6 +++
 security/selinux/hooks.c              | 75 ++++++++++++++++++++++++++++++-----
 security/selinux/include/security.h   |  7 +++-
 security/selinux/selinuxfs.c          | 63 ++++++++++++++++++-----------
 security/smack/smack_lsm.c            |  2 +-
 12 files changed, 142 insertions(+), 40 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 4424f7f..d8107b7 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -157,6 +157,7 @@
  *
  *  @dentry - object to perform setxattr on
  *  @name - xattr name to set
+ *  @nsname - namespaced xattr name, use instead of @name if set
  *  @value - value to set @name to
  *  @size - size of @value
  *  @flags - flags to pass into filesystem operations
@@ -168,7 +169,7 @@
  *  permission checks.
  */
 int __vfs_setxattr_noperm(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags)
+		const char *nsname, const void *value, size_t size, int flags)
 {
 	struct inode *inode = dentry->d_inode;
 	int error = -EAGAIN;
@@ -178,7 +179,8 @@ int __vfs_setxattr_noperm(struct dentry *dentry, const char *name,
 	if (issec)
 		inode->i_flags &= ~S_NOSEC;
 	if (inode->i_opflags & IOP_XATTR) {
-		error = __vfs_setxattr(dentry, inode, name, value, size, flags);
+		error = __vfs_setxattr(dentry, inode, nsname?:name, value,
+					size, flags);
 		if (!error) {
 			fsnotify_xattr(dentry);
 			security_inode_post_setxattr(dentry, name, value,
@@ -211,6 +213,7 @@ int __vfs_setxattr_noperm(struct dentry *dentry, const char *name,
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
+	char *nsname = NULL;
 
 	error = xattr_permission(inode, name, MAY_WRITE);
 	if (error)
@@ -221,8 +224,11 @@ int __vfs_setxattr_noperm(struct dentry *dentry, const char *name,
 	if (error)
 		goto out;
 
-	error = __vfs_setxattr_noperm(dentry, name, value, size, flags);
+	error = security_inode_translate_xattr_to_ns(name, &nsname);
+	if (error)
+		goto out;
 
+	error = __vfs_setxattr_noperm(dentry, name, nsname, value, size, flags);
 out:
 	inode_unlock(inode);
 	return error;
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index c925812..e4eb43e 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1480,6 +1480,7 @@
 	void (*inode_getsecid)(struct inode *inode, u32 *secid);
 	int (*inode_copy_up)(struct dentry *src, struct cred **new);
 	int (*inode_copy_up_xattr)(const char *name);
+	int (*inode_translate_xattr_to_ns)(const char *name, char **tr);
 
 	int (*file_permission)(struct file *file, int mask);
 	int (*file_alloc_security)(struct file *file);
@@ -1760,6 +1761,7 @@ struct security_hook_heads {
 	struct list_head inode_getsecid;
 	struct list_head inode_copy_up;
 	struct list_head inode_copy_up_xattr;
+	struct list_head inode_translate_xattr_to_ns;
 	struct list_head file_permission;
 	struct list_head file_alloc_security;
 	struct list_head file_free_security;
diff --git a/include/linux/security.h b/include/linux/security.h
index ce62659..64297e1 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -302,6 +302,7 @@ void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 void security_inode_getsecid(struct inode *inode, u32 *secid);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
+int security_inode_translate_xattr_to_ns(const char *name, char **tr);
 int security_file_permission(struct file *file, int mask);
 int security_file_alloc(struct file *file);
 void security_file_free(struct file *file);
@@ -808,6 +809,11 @@ static inline int security_inode_copy_up_xattr(const char *name)
 	return -EOPNOTSUPP;
 }
 
+static inline int security_inode_translate_xattr_to_ns(const char *name, char **tr)
+{
+	return 0;
+}
+
 static inline int security_file_permission(struct file *file, int mask)
 {
 	return 0;
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index e77605a..c25eb8a 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -50,7 +50,7 @@ struct xattr {
 ssize_t vfs_getxattr(struct dentry *, const char *, void *, size_t);
 ssize_t vfs_listxattr(struct dentry *d, char *list, size_t size);
 int __vfs_setxattr(struct dentry *, struct inode *, const char *, const void *, size_t, int);
-int __vfs_setxattr_noperm(struct dentry *, const char *, const void *, size_t, int);
+int __vfs_setxattr_noperm(struct dentry *, const char *, const char *, const void *, size_t, int);
 int vfs_setxattr(struct dentry *, const char *, const void *, size_t, int);
 int __vfs_removexattr(struct dentry *, const char *);
 int vfs_removexattr(struct dentry *, const char *);
diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
index 1590c49..528a5f7 100644
--- a/include/uapi/linux/xattr.h
+++ b/include/uapi/linux/xattr.h
@@ -51,6 +51,9 @@
 
 #define XATTR_SELINUX_SUFFIX "selinux"
 #define XATTR_NAME_SELINUX XATTR_SECURITY_PREFIX XATTR_SELINUX_SUFFIX
+#define XATTR_SELINUX_NS_INFIX ".ns."
+#define XATTR_NAME_SELINUX_NS XATTR_NAME_SELINUX XATTR_SELINUX_NS_INFIX
+#define XATTR_NAME_SELINUX_NS_LEN (sizeof(XATTR_NAME_SELINUX_NS) - 1)
 
 #define XATTR_SMACK_SUFFIX "SMACK64"
 #define XATTR_SMACK_IPIN "SMACK64IPIN"
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 1d32cd2..2249186 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -260,7 +260,7 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
 	if (rc == 0) {
 		xattr_data.type = EVM_XATTR_HMAC;
 		rc = __vfs_setxattr_noperm(dentry, XATTR_NAME_EVM,
-					   &xattr_data,
+					   NULL, &xattr_data,
 					   sizeof(xattr_data), 0);
 	} else if (rc == -ENODATA && (inode->i_opflags & IOP_XATTR)) {
 		rc = __vfs_removexattr(dentry, XATTR_NAME_EVM);
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 809ba70..914cf5f 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -71,7 +71,7 @@ static int ima_fix_xattr(struct dentry *dentry,
 		iint->ima_hash->xattr.ng.algo = algo;
 	}
 	rc = __vfs_setxattr_noperm(dentry, XATTR_NAME_IMA,
-				   &iint->ima_hash->xattr.data[offset],
+				   NULL, &iint->ima_hash->xattr.data[offset],
 				   (sizeof(iint->ima_hash->xattr) - offset) +
 				   iint->ima_hash->length, 0);
 	return rc;
diff --git a/security/security.c b/security/security.c
index 4bf0f57..7fce259 100644
--- a/security/security.c
+++ b/security/security.c
@@ -856,6 +856,12 @@ int security_inode_copy_up_xattr(const char *name)
 }
 EXPORT_SYMBOL(security_inode_copy_up_xattr);
 
+int security_inode_translate_xattr_to_ns(const char *name, char **tr)
+{
+	return call_int_hook(inode_translate_xattr_to_ns, 0, name, tr);
+}
+EXPORT_SYMBOL(security_inode_translate_xattr_to_ns);
+
 int security_file_permission(struct file *file, int mask)
 {
 	int ret;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3daad14..6b29d70 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -646,6 +646,22 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
 		  !strcmp(sb->s_type->name, "cgroup2")));
 }
 
+static char *current_xattr_suffix(void)
+{
+	if (current_selinux_ns != init_selinux_ns)
+		return current_selinux_ns->xattr_name + XATTR_SECURITY_PREFIX_LEN;
+	else
+		return XATTR_SELINUX_SUFFIX;
+}
+
+static char *current_xattr_name(void)
+{
+	if (current_selinux_ns != init_selinux_ns)
+		return current_selinux_ns->xattr_name;
+	else
+		return XATTR_NAME_SELINUX;
+}
+
 static int sb_finish_set_opts(struct super_block *sb)
 {
 	struct superblock_security_struct *sbsec = superblock_security(sb);
@@ -654,6 +670,8 @@ static int sb_finish_set_opts(struct super_block *sb)
 	int rc = 0;
 
 	if (sbsec->behavior == SECURITY_FS_USE_XATTR) {
+		char *name;
+
 		/* Make sure that the xattr handler exists and that no
 		   error other than -ENODATA is returned by getxattr on
 		   the root directory.  -ENODATA is ok, as this may be
@@ -666,7 +684,9 @@ static int sb_finish_set_opts(struct super_block *sb)
 			goto out;
 		}
 
-		rc = __vfs_getxattr(root, root_inode, XATTR_NAME_SELINUX, NULL, 0);
+		name = current_xattr_name();
+
+		rc = __vfs_getxattr(root, root_inode, name, NULL, 0);
 		if (rc < 0 && rc != -ENODATA) {
 			if (rc == -EOPNOTSUPP)
 				printk(KERN_WARNING "SELinux: (dev %s, type "
@@ -1660,6 +1680,7 @@ static int inode_doinit_with_dentry(struct inode *inode,
 	char *context = NULL;
 	unsigned len = 0;
 	int rc = 0;
+	char *name;
 
 	if (isec->initialized == LABEL_INITIALIZED)
 		return 0;
@@ -1729,12 +1750,14 @@ static int inode_doinit_with_dentry(struct inode *inode,
 			goto out;
 		}
 		context[len] = '\0';
-		rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, context, len);
+
+		name = current_xattr_name();
+		rc = __vfs_getxattr(dentry, inode, name, context, len);
 		if (rc == -ERANGE) {
 			kfree(context);
 
 			/* Need a larger buffer.  Query for the right size. */
-			rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, NULL, 0);
+			rc = __vfs_getxattr(dentry, inode, name, NULL, 0);
 			if (rc < 0) {
 				dput(dentry);
 				goto out;
@@ -1747,7 +1770,7 @@ static int inode_doinit_with_dentry(struct inode *inode,
 				goto out;
 			}
 			context[len] = '\0';
-			rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, context, len);
+			rc = __vfs_getxattr(dentry, inode, name, context, len);
 		}
 		dput(dentry);
 		if (rc < 0) {
@@ -3167,7 +3190,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 		return -EOPNOTSUPP;
 
 	if (name)
-		*name = XATTR_SELINUX_SUFFIX;
+		*name = current_xattr_suffix();
 
 	if (value && len) {
 		rc = security_sid_to_context_force(current_selinux_ns, newsid,
@@ -3382,6 +3405,10 @@ static bool has_cap_mac_admin(bool audit)
 	return true;
 }
 
+/* TODO:
+ * - audit
+ * - handle raw namespaced xattrs
+ */
 static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags)
 {
@@ -3392,8 +3419,12 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 	u32 newsid, sid = current_sid();
 	int rc = 0;
 
-	if (strcmp(name, XATTR_NAME_SELINUX))
+	if (strcmp(name, XATTR_NAME_SELINUX)) {
+		/* No raw namespaced xattrs, yet */
+		if (!strncmp(name, XATTR_NAME_SELINUX_NS, XATTR_NAME_SELINUX_NS_LEN))
+			return -EPERM;
 		return selinux_inode_setotherxattr(dentry, name);
+	}
 
 	sbsec = superblock_security(inode->i_sb);
 	if (!(sbsec->flags & SBLABEL_MNT))
@@ -3640,6 +3671,13 @@ static int selinux_inode_copy_up_xattr(const char *name)
 	return -EOPNOTSUPP;
 }
 
+static int selinux_inode_translate_xattr_to_ns(const char *name, char **tr)
+{
+	if(!strcmp(name, XATTR_NAME_SELINUX))
+		*tr = current_xattr_name();
+	return 0;
+}
+
 /* file security operations */
 
 static int selinux_revalidate_file_permission(struct file *file, int mask)
@@ -6430,10 +6468,11 @@ static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen
 
 /*
  *	called with inode->i_mutex locked
+ *	TODO: namespace translation
  */
 static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
-	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SELINUX, ctx, ctxlen, 0);
+	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SELINUX, NULL, ctx, ctxlen, 0);
 }
 
 static int selinux_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
@@ -6647,6 +6686,7 @@ static void selinux_ib_free_security(void *ib_sec)
 	LSM_HOOK_INIT(inode_getsecid, selinux_inode_getsecid),
 	LSM_HOOK_INIT(inode_copy_up, selinux_inode_copy_up),
 	LSM_HOOK_INIT(inode_copy_up_xattr, selinux_inode_copy_up_xattr),
+	LSM_HOOK_INIT(inode_translate_xattr_to_ns, selinux_inode_translate_xattr_to_ns),
 
 	LSM_HOOK_INIT(file_permission, selinux_file_permission),
 	LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
@@ -6805,7 +6845,7 @@ static void selinux_ib_free_security(void *ib_sec)
 
 static void selinux_ns_free(struct work_struct *work);
 
-int selinux_ns_create(struct selinux_ns *parent, struct selinux_ns **ns)
+int selinux_ns_create(struct selinux_ns *parent, struct selinux_ns **ns, const char *name)
 {
 	struct selinux_ns *newns;
 	int rc;
@@ -6825,14 +6865,29 @@ int selinux_ns_create(struct selinux_ns *parent, struct selinux_ns **ns)
 	if (rc)
 		goto err;
 
+	newns->name = kstrdup(name, GFP_KERNEL);
+	if (!newns->name) {
+		rc = -ENOMEM;
+		goto err_avc;
+        }
+
+	newns->xattr_name = kasprintf(GFP_KERNEL, "%s.ns.%s", XATTR_NAME_SELINUX, name);
+	if (!newns->xattr_name) {
+		rc = -ENOMEM;
+		goto err_avc;
+	}
+
 	if (parent)
 		newns->parent = get_selinux_ns(parent);
 
 	*ns = newns;
 	return 0;
+err_avc:
+	selinux_avc_free(newns->avc);
 err:
 	selinux_ss_free(newns->ss);
 	kfree(newns);
+	kfree(newns->name);
 	return rc;
 }
 
@@ -6845,6 +6900,8 @@ static void selinux_ns_free(struct work_struct *work)
 		parent = ns->parent;
 		selinux_ss_free(ns->ss);
 		selinux_avc_free(ns->avc);
+		kfree(ns->name);
+		kfree(ns->xattr_name);
 		kfree(ns);
 		ns = parent;
 	} while (ns && refcount_dec_and_test(&ns->count));
@@ -6869,7 +6926,7 @@ static __init int selinux_init(void)
 
 	printk(KERN_INFO "SELinux:  Initializing.\n");
 
-	if (selinux_ns_create(NULL, &init_selinux_ns))
+	if (selinux_ns_create(NULL, &init_selinux_ns, SELINUX_NS_INIT_NAME))
 		panic("SELinux: Could not create initial namespace\n");
 
 	set_ns_enforcing(init_selinux_ns, selinux_enforcing_boot);
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index b80f9bd..f5f5a31 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -92,6 +92,9 @@ enum {
 /* limitation of boundary depth  */
 #define POLICYDB_BOUNDS_MAXDEPTH	4
 
+/* Name of SELinux initial namespace */
+#define SELINUX_NS_INIT_NAME "init"
+
 struct selinux_avc;
 struct selinux_ss;
 
@@ -108,9 +111,11 @@ struct selinux_ns {
 	struct selinux_avc *avc;
 	struct selinux_ss *ss;
 	struct selinux_ns *parent;
+	char *name;
+	char *xattr_name;
 };
 
-int selinux_ns_create(struct selinux_ns *parent, struct selinux_ns **ns);
+int selinux_ns_create(struct selinux_ns *parent, struct selinux_ns **ns, const char *name);
 void __put_selinux_ns(struct selinux_ns *ns);
 
 int selinux_ss_create(struct selinux_ss **ss);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 6c52d24..d190213 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -334,9 +334,10 @@ static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 {
 	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
 	struct selinux_ns *ns = fsi->ns;
+	struct cred *cred;
+	struct task_security_struct *tsec;
 	char *page;
 	ssize_t length;
-	bool set;
 	int rc;
 
 	if (ns != current_selinux_ns)
@@ -359,30 +360,32 @@ static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 	if (IS_ERR(page))
 		return PTR_ERR(page);
 
-	length = -EINVAL;
-	if (kstrtobool(page, &set))
-		goto out;
+	/* strip any trailing newline */
+	if (page[strlen(page) - 1] == '\n')
+		page[strlen(page) - 1] = 0;
 
-	if (set) {
-		struct cred *cred = prepare_creds();
-		struct task_security_struct *tsec;
+	/* TODO: check for uniqueness! */
+	if (!strcmp(SELINUX_NS_INIT_NAME, page)) {
+		length = -EINVAL;
+		goto out;
+	}
 
-		if (!cred) {
-			length = -ENOMEM;
-			goto out;
-		}
-		tsec = cred->security;
-		if (selinux_ns_create(ns, &tsec->ns)) {
-			abort_creds(cred);
-			length = -ENOMEM;
-			goto out;
-		}
-		tsec->osid = tsec->sid = SECINITSID_KERNEL;
-		tsec->exec_sid = tsec->create_sid = tsec->keycreate_sid =
-			tsec->sockcreate_sid = SECSID_NULL;
-		tsec->parent_cred = get_current_cred();
-		commit_creds(cred);
+	cred = prepare_creds();
+	if (!cred) {
+		length = -ENOMEM;
+		goto out;
+	}
+	tsec = cred->security;
+	if (selinux_ns_create(ns, &tsec->ns, page)) {
+		abort_creds(cred);
+		length = -ENOMEM;
+		goto out;
 	}
+	tsec->osid = tsec->sid = SECINITSID_KERNEL;
+	tsec->exec_sid = tsec->create_sid = tsec->keycreate_sid =
+		tsec->sockcreate_sid = SECSID_NULL;
+	tsec->parent_cred = get_current_cred();
+	commit_creds(cred);
 
 	length = count;
 out:
@@ -390,8 +393,22 @@ static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 	return length;
 }
 
+static ssize_t sel_read_unshare(struct file *file, char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
+	struct selinux_ns *ns = fsi->ns;
+	char *name = ns->name;
+
+	if (ns != current_selinux_ns)
+		return -EPERM;
+
+	return simple_read_from_buffer(buf, count, ppos, name, strlen(name));
+}
+
 static const struct file_operations sel_unshare_ops = {
 	.write		= sel_write_unshare,
+	.read		= sel_read_unshare,
 	.llseek		= generic_file_llseek,
 };
 
@@ -2021,7 +2038,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 		[SEL_POLICY] = {"policy", &sel_policy_ops, S_IRUGO},
 		[SEL_VALIDATE_TRANS] = {"validatetrans", &sel_transition_ops,
 					S_IWUGO},
-		[SEL_UNSHARE] = {"unshare", &sel_unshare_ops, 0222},
+		[SEL_UNSHARE] = {"unshare", &sel_unshare_ops, 0666},
 		/* last one */ {""}
 	};
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 319add3..5ea841f 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4591,7 +4591,7 @@ static int smack_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 
 static int smack_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
-	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SMACK, ctx, ctxlen, 0);
+	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SMACK, NULL, ctx, ctxlen, 0);
 }
 
 static int smack_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
-- 
1.8.3.1

Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB2EjnRb014584
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 09:45:49 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB2Ej9p5001509
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 14:45:09 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions.epoch.ncsc.mil [144.51.25.4])
	by jazzswing.ncsc.mil  with ESMTP id hB2Ej8t0001506
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 14:45:08 GMT
Subject: Re: xattr
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: russell@coker.com.au
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200312021433.48383.russell@coker.com.au>
References: <200312021433.48383.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1070376336.15777.146.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 02 Dec 2003 09:45:36 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-12-01 at 22:33, Russell Coker wrote:
> Please send me the patch Steve mentioned:

Here is the ext2 patch.  

This patch is relative to linux 2.4.22 with the
ea+acl+nfsacl-2.4.22-0.8.61.diff applied.  (It will also apply cleanly
with the ea and acl patches applied.)  It is a backport of the
extended attribute handler in the 2.5/6 kernel for security modules.

For the 2.4.21 kernel I used the ea+acl+nfsacl because that was the only
patch available, in the 2.4.22 kernel I used only the ea patch, since
that was all that was needed to support SELinux.  For 2.4.23, I plan on
going back to the full patch (or at least ea and acl) since there seems
to be interest in using acls along with SELinux.

 Documentation/Configure.help |   10 ++++++
 fs/Config.in                 |    2 +
 fs/ext2/Makefile             |    1 
 fs/ext2/super.c              |    8 ++++
 fs/ext2/xattr_security.c     |   69 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/ext2_xattr.h   |   21 +++++++++++++
 6 files changed, 110 insertions(+), 1 deletion(-)

Index: linux-2.4/Documentation/Configure.help
diff -u linux-2.4/Documentation/Configure.help:1.1.1.2 linux-2.4/Documentation/Configure.help:1.10
--- linux-2.4/Documentation/Configure.help:1.1.1.2	Mon Jul 28 14:33:23 2003
+++ linux-2.4/Documentation/Configure.help	Fri Sep  5 16:10:47 2003
@@ -15653,6 +15653,16 @@
 
   If unsure, say N.
 
+Ext2 Security Labels
+CONFIG_EXT2_FS_SECURITY
+  Security labels support alternative access control models
+  implemented by security modules like SELinux.  This option
+  enables an extended attribute handler for file security
+  labels in the ext2 filesystem.
+
+  If you are not using a security module that requires using
+  extended attributes for file security labels, say N.
+
 Ext2 POSIX Access Control Lists
 CONFIG_EXT2_FS_POSIX_ACL
   POSIX Access Control Lists (ACLs) support permissions for users and
Index: linux-2.4/fs/Config.in
diff -u linux-2.4/fs/Config.in:1.1.1.2 linux-2.4/fs/Config.in:1.7
--- linux-2.4/fs/Config.in:1.1.1.2	Mon Jul 28 14:18:20 2003
+++ linux-2.4/fs/Config.in	Tue Jul 29 16:00:34 2003
@@ -104,6 +104,8 @@
     CONFIG_EXT2_FS_XATTR_USER $CONFIG_EXT2_FS_XATTR
 dep_bool '    Ext2 trusted extended attributes' \
     CONFIG_EXT2_FS_XATTR_TRUSTED $CONFIG_EXT2_FS_XATTR
+dep_bool '    Ext2 security labels' \
+    CONFIG_EXT2_FS_SECURITY $CONFIG_EXT2_FS_XATTR
 dep_bool '    Ext2 POSIX Access Control Lists' \
 	CONFIG_EXT2_FS_POSIX_ACL $CONFIG_EXT2_FS_XATTR
 
Index: linux-2.4/fs/ext2/Makefile
diff -u linux-2.4/fs/ext2/Makefile:1.1.1.2 linux-2.4/fs/ext2/Makefile:1.3
--- linux-2.4/fs/ext2/Makefile:1.1.1.2	Mon Jul 28 14:18:34 2003
+++ linux-2.4/fs/ext2/Makefile	Tue Jul 29 16:00:44 2003
@@ -17,6 +17,7 @@
 obj-$(CONFIG_EXT2_FS_XATTR) += xattr.o
 obj-$(CONFIG_EXT2_FS_XATTR_USER) += xattr_user.o
 obj-$(CONFIG_EXT2_FS_XATTR_TRUSTED) += xattr_trusted.o
+obj-$(CONFIG_EXT2_FS_SECURITY) += xattr_security.o
 obj-$(CONFIG_EXT2_FS_POSIX_ACL) += acl.o
 
 include $(TOPDIR)/Rules.make
Index: linux-2.4/fs/ext2/super.c
diff -u linux-2.4/fs/ext2/super.c:1.1.1.2 linux-2.4/fs/ext2/super.c:1.3
--- linux-2.4/fs/ext2/super.c:1.1.1.2	Mon Jul 28 14:18:34 2003
+++ linux-2.4/fs/ext2/super.c	Tue Jul 29 16:00:44 2003
@@ -869,14 +869,20 @@
 	error = init_ext2_xattr_trusted();
 	if (error)
 		goto fail2;
-	error = init_ext2_acl();
+	error = init_ext2_xattr_security();
 	if (error)
 		goto fail3;
+	error = init_ext2_acl();
+	if (error)
+		goto fail4;
+
 	error = register_filesystem(&ext2_fs_type);
 	if (!error)
 		return 0;
 
 	exit_ext2_acl();
+fail4:
+	exit_ext2_xattr_security();
 fail3:
 	exit_ext2_xattr_trusted();
 fail2:
Index: linux-2.4/fs/ext2/xattr_security.c
diff -u /dev/null linux-2.4/fs/ext2/xattr_security.c:1.2
--- /dev/null	Tue Sep 23 10:30:46 2003
+++ linux-2.4/fs/ext2/xattr_security.c	Thu Jun 26 15:32:56 2003
@@ -0,0 +1,69 @@
+/*
+ * linux/fs/ext2/xattr_security.c
+ * Handler for storing security labels as extended attributes.
+ */
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/fs.h>
+/* #include <linux/smp_lock.h> */
+#include <linux/ext2_fs.h>
+#include <linux/ext2_xattr.h>
+
+#define XATTR_SECURITY_PREFIX "security."
+
+static size_t
+ext2_xattr_security_list(char *list, struct inode *inode,
+			const char *name, int name_len)
+{
+	const int prefix_len = sizeof(XATTR_SECURITY_PREFIX)-1;
+
+	if (list) {
+		memcpy(list, XATTR_SECURITY_PREFIX, prefix_len);
+		memcpy(list+prefix_len, name, name_len);
+		list[prefix_len + name_len] = '\0';
+	}
+	return prefix_len + name_len + 1;
+}
+
+static int
+ext2_xattr_security_get(struct inode *inode, const char *name,
+		       void *buffer, size_t size)
+{
+	if (strcmp(name, "") == 0)
+		return -EINVAL;
+	return ext2_xattr_get(inode, EXT2_XATTR_INDEX_SECURITY, name,
+			      buffer, size);
+}
+
+static int
+ext2_xattr_security_set(struct inode *inode, const char *name,
+		       const void *value, size_t size, int flags)
+{
+	if (strcmp(name, "") == 0)
+		return -EINVAL;
+	return ext2_xattr_set(inode, EXT2_XATTR_INDEX_SECURITY, name,
+			      value, size, flags);
+}
+
+struct ext2_xattr_handler ext2_xattr_security_handler = {
+	.prefix	= XATTR_SECURITY_PREFIX,
+	.list	= ext2_xattr_security_list,
+	.get	= ext2_xattr_security_get,
+	.set	= ext2_xattr_security_set,
+};
+
+int __init
+init_ext2_xattr_security(void)
+{
+	return ext2_xattr_register(EXT2_XATTR_INDEX_SECURITY,
+				   &ext2_xattr_security_handler);
+}
+
+void
+exit_ext2_xattr_security(void)
+{
+	ext2_xattr_unregister(EXT2_XATTR_INDEX_SECURITY,
+			      &ext2_xattr_security_handler);
+}
+
Index: linux-2.4/include/linux/ext2_xattr.h
diff -u linux-2.4/include/linux/ext2_xattr.h:1.1.1.2 linux-2.4/include/linux/ext2_xattr.h:1.5
--- linux-2.4/include/linux/ext2_xattr.h:1.1.1.2	Mon Jul 28 14:20:05 2003
+++ linux-2.4/include/linux/ext2_xattr.h	Wed Jul 30 15:58:10 2003
@@ -22,6 +22,7 @@
 #define EXT2_XATTR_INDEX_POSIX_ACL_ACCESS	2
 #define EXT2_XATTR_INDEX_POSIX_ACL_DEFAULT	3
 #define EXT2_XATTR_INDEX_TRUSTED		4
+#define EXT2_XATTR_INDEX_SECURITY		6
 
 struct ext2_xattr_header {
 	__u32	h_magic;	/* magic number for identification */
@@ -175,6 +176,26 @@
 }
 
 # endif  /* CONFIG_EXT2_FS_XATTR_TRUSTED */
+
+# ifdef CONFIG_EXT2_FS_SECURITY
+
+extern int init_ext2_xattr_security(void) __init;
+extern void exit_ext2_xattr_security(void);
+
+# else  /* CONFIG_EXT2_FS_SECURITY */
+
+static inline int
+init_ext2_xattr_security(void)
+{
+	return 0;
+}
+
+static inline void
+exit_ext2_xattr_security(void)
+{
+}
+
+#endif	/* CONFIG_EXT2_FS_SECURITY */
 
 #endif  /* __KERNEL__ */
 


-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

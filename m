Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB2EjnRb014583
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 09:45:49 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB2EjmqY026899
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 14:45:48 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions.epoch.ncsc.mil [144.51.25.4])
        by jazzband.ncsc.mil  with ESMTP id hB2Ejm0o026896 for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 14:45:48 GMT
Subject: Re: xattr
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: russell@coker.com.au
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200312021433.48383.russell@coker.com.au>
References: <200312021433.48383.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1070376344.15777.150.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 02 Dec 2003 09:45:44 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-12-01 at 22:33, Russell Coker wrote:
> Please send me the patch Steve mentioned:

Here is the ext3 patch.  

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
 fs/ext3/Makefile             |    1 
 fs/ext3/super.c              |    8 ++++-
 fs/ext3/xattr_security.c     |   68 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/ext3_xattr.h   |   23 ++++++++++++++
 6 files changed, 111 insertions(+), 1 deletion(-)

Index: linux-2.4/Documentation/Configure.help
diff -u linux-2.4/Documentation/Configure.help:1.1.1.2 linux-2.4/Documentation/Configure.help:1.10
--- linux-2.4/Documentation/Configure.help:1.1.1.2	Mon Jul 28 14:33:23 2003
+++ linux-2.4/Documentation/Configure.help	Fri Sep  5 16:10:47 2003
@@ -15722,6 +15722,16 @@
 
   If unsure, say N.
 
+Ext3 Security Labels
+CONFIG_EXT3_FS_SECURITY
+  Security labels support alternative access control models
+  implemented by security modules like SELinux.  This option
+  enables an extended attribute handler for file security
+  labels in the ext3 filesystem.
+
+  If you are not using a security module that requires using
+  extended attributes for file security labels, say N.
+
 Ext3 POSIX Access Control Lists
 CONFIG_EXT3_FS_POSIX_ACL
   POSIX Access Control Lists (ACLs) support permissions for users and
Index: linux-2.4/fs/Config.in
diff -u linux-2.4/fs/Config.in:1.1.1.2 linux-2.4/fs/Config.in:1.7
--- linux-2.4/fs/Config.in:1.1.1.2	Mon Jul 28 14:18:20 2003
+++ linux-2.4/fs/Config.in	Tue Jul 29 16:00:34 2003
@@ -36,6 +36,8 @@
     CONFIG_EXT3_FS_XATTR_USER $CONFIG_EXT3_FS_XATTR
 dep_bool '    Ext3 trusted extended attributes' \
     CONFIG_EXT3_FS_XATTR_TRUSTED $CONFIG_EXT3_FS_XATTR
+dep_bool '    Ext3 security labels' \
+    CONFIG_EXT3_FS_SECURITY $CONFIG_EXT3_FS_XATTR
 dep_bool '    Ext3 POSIX Access Control Lists' \
     CONFIG_EXT3_FS_POSIX_ACL $CONFIG_EXT3_FS_XATTR
 # CONFIG_JBD could be its own option (even modular), but until there are
Index: linux-2.4/fs/ext3/Makefile
diff -u linux-2.4/fs/ext3/Makefile:1.1.1.2 linux-2.4/fs/ext3/Makefile:1.5
--- linux-2.4/fs/ext3/Makefile:1.1.1.2	Mon Jul 28 14:19:13 2003
+++ linux-2.4/fs/ext3/Makefile	Tue Jul 29 16:00:45 2003
@@ -17,6 +17,7 @@
 obj-$(CONFIG_EXT3_FS_XATTR) += xattr.o
 obj-$(CONFIG_EXT3_FS_XATTR_USER) += xattr_user.o
 obj-$(CONFIG_EXT3_FS_XATTR_TRUSTED) += xattr_trusted.o
+obj-$(CONFIG_EXT3_FS_SECURITY) += xattr_security.o
 obj-$(CONFIG_EXT3_FS_POSIX_ACL) += acl.o
 
 include $(TOPDIR)/Rules.make
Index: linux-2.4/fs/ext3/super.c
diff -u linux-2.4/fs/ext3/super.c:1.1.1.2 linux-2.4/fs/ext3/super.c:1.3
--- linux-2.4/fs/ext3/super.c:1.1.1.2	Mon Jul 28 14:19:12 2003
+++ linux-2.4/fs/ext3/super.c	Tue Jul 29 16:00:45 2003
@@ -1882,14 +1882,20 @@
 	error = init_ext3_xattr_trusted();
 	if (error)
 		goto fail2;
-	error = init_ext3_acl();
+	error = init_ext3_xattr_security();
 	if (error)
 		goto fail3;
+	error = init_ext3_acl();
+	if (error)
+		goto fail4;
+
 	error = register_filesystem(&ext3_fs_type);
 	if (!error)
 		return 0;
 	
 	exit_ext3_acl();
+fail4:
+	exit_ext3_xattr_security();
 fail3:
 	exit_ext3_xattr_trusted();
 fail2:
Index: linux-2.4/fs/ext3/xattr_security.c
diff -u /dev/null linux-2.4/fs/ext3/xattr_security.c:1.2
--- /dev/null	Tue Sep 23 10:30:46 2003
+++ linux-2.4/fs/ext3/xattr_security.c	Thu Jun 26 14:48:32 2003
@@ -0,0 +1,68 @@
+/*
+ * linux/fs/ext3/xattr_security.c
+ * Handler for storing security labels as extended attributes.
+ */
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/fs.h>
+#include <linux/ext3_jbd.h>
+#include <linux/ext3_fs.h>
+#include <linux/ext3_xattr.h>
+
+#define XATTR_SECURITY_PREFIX "security."
+
+static size_t
+ext3_xattr_security_list(char *list, struct inode *inode,
+		    const char *name, int name_len)
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
+ext3_xattr_security_get(struct inode *inode, const char *name,
+		       void *buffer, size_t size)
+{
+	if (strcmp(name, "") == 0)
+		return -EINVAL;
+	return ext3_xattr_get(inode, EXT3_XATTR_INDEX_SECURITY, name,
+			      buffer, size);
+}
+
+static int
+ext3_xattr_security_set(struct inode *inode, const char *name,
+		       const void *value, size_t size, int flags)
+{
+	if (strcmp(name, "") == 0)
+		return -EINVAL;
+	return ext3_xattr_set(inode, EXT3_XATTR_INDEX_SECURITY, name,
+			      value, size, flags);
+}
+
+struct ext3_xattr_handler ext3_xattr_security_handler = {
+	.prefix	= XATTR_SECURITY_PREFIX,
+	.list	= ext3_xattr_security_list,
+	.get	= ext3_xattr_security_get,
+	.set	= ext3_xattr_security_set,
+};
+
+int __init
+init_ext3_xattr_security(void)
+{
+	return ext3_xattr_register(EXT3_XATTR_INDEX_SECURITY,
+				   &ext3_xattr_security_handler);
+}
+
+void
+exit_ext3_xattr_security(void)
+{
+	ext3_xattr_unregister(EXT3_XATTR_INDEX_SECURITY,
+			      &ext3_xattr_security_handler);
+}
Index: linux-2.4/include/linux/ext3_xattr.h
diff -u linux-2.4/include/linux/ext3_xattr.h:1.1.1.2 linux-2.4/include/linux/ext3_xattr.h:1.6
--- linux-2.4/include/linux/ext3_xattr.h:1.1.1.2	Mon Jul 28 14:20:05 2003
+++ linux-2.4/include/linux/ext3_xattr.h	Wed Jul 30 15:58:10 2003
@@ -22,6 +22,7 @@
 #define EXT3_XATTR_INDEX_POSIX_ACL_ACCESS	2
 #define EXT3_XATTR_INDEX_POSIX_ACL_DEFAULT	3
 #define EXT3_XATTR_INDEX_TRUSTED		4
+#define EXT3_XATTR_INDEX_SECURITY		6
 
 struct ext3_xattr_header {
 	__u32	h_magic;	/* magic number for identification */
@@ -178,5 +179,27 @@
 
 #endif  /* CONFIG_EXT3_FS_XATTR_TRUSTED */
 
+# ifdef CONFIG_EXT3_FS_SECURITY
+
+extern int init_ext3_xattr_security(void) __init;
+extern void exit_ext3_xattr_security(void);
+
+# else  /* CONFIG_EXT3_FS_SECURITY */
+
+static inline int
+init_ext3_xattr_security(void)
+{
+	return 0;
+}
+
+static inline void
+exit_ext3_xattr_security(void)
+{
+}
+
+#endif	/* CONFIG_EXT3_FS_SECURITY */
+
 #endif  /* __KERNEL__ */
+
+
 


-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

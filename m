Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB6EOAIi021038
	for <selinux@tycho.nsa.gov>; Mon, 6 Dec 2004 09:24:11 -0500 (EST)
Received: from e33.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB6EOCoX008486
	for <selinux@tycho.nsa.gov>; Mon, 6 Dec 2004 14:24:12 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id iB6EOCDr278442
	for <selinux@tycho.nsa.gov>; Mon, 6 Dec 2004 09:24:13 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id iB6EOCdp420840
	for <selinux@tycho.nsa.gov>; Mon, 6 Dec 2004 07:24:12 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id iB6EOCB0006621
	for <selinux@tycho.nsa.gov>; Mon, 6 Dec 2004 07:24:12 -0700
Subject: JFS filesystem support for SELinux ..... kernel patch included
From: Jerone Young <jyoung5@us.ibm.com>
To: selinux@tycho.nsa.gov
Cc: Dave Kleikamp <shaggy@austin.ibm.com>
Content-Type: multipart/mixed; boundary="=-gQ+H7XjlJqbZfK2LDf+b"
Date: Mon, 06 Dec 2004 08:25:54 -0600
Message-Id: <1102343154.3968.23.camel@thinkpad>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-gQ+H7XjlJqbZfK2LDf+b
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The JFS filesystem has been missing SELinux exposure do to it's lack of
"Security Labels" support. Attached is a kernel patch by Dave Kleikamp
("Shaggy") that adds this support to JFS. This patch should be included
in rc3-mm1 kernel, but for those who would like to try it out now, you
could help us out by trying it out and see if you run into any issues.
We have a machine running it successfully with strict policy on Fedora
3.

Quick howto
-----------
1) Apply kernel patch and recompile kernel
2) In your policy source edit "fs_use" and add the line:
   	fs_use_xattr jfs system_u:object_r:fs_t;
3) recompile policy with changes , and move binary policy to proper
directory
4) reboot

-- 
Jerone Young <jyoung5@us.ibm.com>
Linux Technology Center Security Team

--=-gQ+H7XjlJqbZfK2LDf+b
Content-Disposition: attachment; filename=jfs_sec_plus_trusted.patch
Content-Type: text/x-patch; name=jfs_sec_plus_trusted.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Nurp linux-2.6.9/fs/Kconfig linux/fs/Kconfig
--- linux-2.6.9/fs/Kconfig	2004-11-29 09:33:11.636222488 -0600
+++ linux/fs/Kconfig	2004-11-29 09:33:27.475814504 -0600
@@ -266,6 +266,18 @@ config JFS_POSIX_ACL
 
 	  If you don't know what Access Control Lists are, say N
 
+config JFS_SECURITY
+	bool "JFS Security Labels"
+	depends on JFS_FS
+	help
+	  Security labels support alternative access control models
+	  implemented by security modules like SELinux.  This option
+	  enables an extended attribute handler for file security
+	  labels in the jfs filesystem.
+
+	  If you are not using a security module that requires using
+	  extended attributes for file security labels, say N.
+
 config JFS_DEBUG
 	bool "JFS debugging"
 	depends on JFS_FS
diff -Nurp linux-2.6.9/fs/jfs/xattr.c linux/fs/jfs/xattr.c
--- linux-2.6.9/fs/jfs/xattr.c	2004-11-29 09:31:25.000000000 -0600
+++ linux/fs/jfs/xattr.c	2004-11-29 09:37:44.774699128 -0600
@@ -91,6 +91,12 @@ struct ea_buffer {
 #define XATTR_OS2_PREFIX "os2."
 #define XATTR_OS2_PREFIX_LEN (sizeof (XATTR_OS2_PREFIX) - 1)
 
+/* XATTR_SECURITY_PREFIX is defined in include/linux/xattr.h */
+#define XATTR_SECURITY_PREFIX_LEN (sizeof (XATTR_SECURITY_PREFIX) - 1)
+
+#define XATTR_TRUSTED_PREFIX "trusted."
+#define XATTR_TRUSTED_PREFIX_LEN (sizeof (XATTR_TRUSTED_PREFIX) - 1)
+
 /*
  * These three routines are used to recognize on-disk extended attributes
  * that are in a recognized namespace.  If the attribute is not recognized,
@@ -111,6 +117,19 @@ static inline int is_os2_xattr(struct jf
 	    !strncmp(ea->name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
 		return FALSE;
 	/*
+	 * Check for "security."
+	 */
+	if ((ea->namelen >= XATTR_SECURITY_PREFIX_LEN) &&
+	    !strncmp(ea->name, XATTR_SECURITY_PREFIX,
+		     XATTR_SECURITY_PREFIX_LEN))
+		return FALSE;
+	/*
+	 * Check for "trusted."
+	 */
+	if ((ea->namelen >= XATTR_TRUSTED_PREFIX_LEN) &&
+	    !strncmp(ea->name, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN))
+		return FALSE;
+	/*
 	 * Add any other valid namespace prefixes here
 	 */
 
@@ -770,6 +789,15 @@ static int can_set_xattr(struct inode *i
 		 */
 		return can_set_system_xattr(inode, name, value, value_len);
 
+	if(strncmp(name, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN) != 0)
+		return (capable(CAP_SYS_ADMIN) ? 0 : -EPERM);
+
+#ifdef CONFIG_JFS_SECURITY
+	if (strncmp(name, XATTR_SECURITY_PREFIX, XATTR_SECURITY_PREFIX_LEN)
+	    != 0)
+		return 0;	/* Leave it to the security module */
+#endif
+		
 	if((strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN) != 0) &&
 	   (strncmp(name, XATTR_OS2_PREFIX, XATTR_OS2_PREFIX_LEN) != 0))
 		return -EOPNOTSUPP;
@@ -937,8 +965,17 @@ int jfs_setxattr(struct dentry *dentry, 
 
 static int can_get_xattr(struct inode *inode, const char *name)
 {
+#ifdef CONFIG_JFS_SECURITY
+	if(strncmp(name, XATTR_SECURITY_PREFIX, XATTR_SECURITY_PREFIX_LEN) == 0)
+		return 0;
+#endif
+
+	if(strncmp(name, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN) == 0)
+		return (capable(CAP_SYS_ADMIN) ? 0 : -EPERM);
+
 	if(strncmp(name, XATTR_SYSTEM_PREFIX, XATTR_SYSTEM_PREFIX_LEN) == 0)
 		return 0;
+
 	return permission(inode, MAY_READ, NULL);
 }
 
@@ -1021,6 +1058,16 @@ ssize_t jfs_getxattr(struct dentry *dent
 	return err;
 }
 
+/*
+ * No special permissions are needed to list attributes except for trusted.*
+ */
+static inline int can_list(struct jfs_ea *ea)
+{
+	return (strncmp(ea->name, XATTR_TRUSTED_PREFIX,
+			    XATTR_TRUSTED_PREFIX_LEN) ||
+		capable(CAP_SYS_ADMIN));
+}
+
 ssize_t jfs_listxattr(struct dentry * dentry, char *data, size_t buf_size)
 {
 	struct inode *inode = dentry->d_inode;
@@ -1045,8 +1092,10 @@ ssize_t jfs_listxattr(struct dentry * de
 	ealist = (struct jfs_ea_list *) ea_buf.xattr;
 
 	/* compute required size of list */
-	for (ea = FIRST_EA(ealist); ea < END_EALIST(ealist); ea = NEXT_EA(ea))
-		size += name_size(ea) + 1;
+	for (ea = FIRST_EA(ealist); ea < END_EALIST(ealist); ea = NEXT_EA(ea)) {
+	    	if (can_list(ea))
+			size += name_size(ea) + 1;
+	}
 
 	if (!data)
 		goto release;
@@ -1059,8 +1108,10 @@ ssize_t jfs_listxattr(struct dentry * de
 	/* Copy attribute names to buffer */
 	buffer = data;
 	for (ea = FIRST_EA(ealist); ea < END_EALIST(ealist); ea = NEXT_EA(ea)) {
-		int namelen = copy_name(buffer, ea);
-		buffer += namelen + 1;
+	    	if (can_list(ea)) {
+			int namelen = copy_name(buffer, ea);
+			buffer += namelen + 1;
+		}
 	}
 
       release:

--=-gQ+H7XjlJqbZfK2LDf+b--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h99FGeWt026498
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2003 11:16:40 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h99FCs0p000586
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2003 15:12:56 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h99F8Sr7029969
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2003 15:08:29 GMT
Subject: [patch] 2.6.0-test7-selinux1
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Cc: James Morris <jmorris@redhat.com>
Content-Type: text/plain
Message-Id: <1065712103.8181.266.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 09 Oct 2003 11:08:23 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

2.6.0-test7 has been released and includes the following SELinux-related
changes:
- Fixed the bug in convert_context when invalidating a context upon
a policy reload, bug reported by Magosanyi Arpad.
- Pass nameidata to inode_permission hook, so we can often generate
full pathnames for audit messages on permission(9) checks.

Below is the current SELinux patch against 2.6.0-test7.  Note that the
policyvers changes have been submitted for inclusion in the mainline
kernel but have not yet been merged into it.   The other remaining
change (which was in the SELinux patch for 2.6.0-test6) is to display
the dname in audit messages when a full pathname cannot be generated
(due to the lack of a vfsmount), primarily to assist in policy
debugging.  Note that the old SELinux would generate a path up to the
mount point in that case via the old avc_d_path function, but that was
dropped out as part of preparation for mainline inclusion due to an
earlier objection to it by a kernel developer.  We likely need to
revisit this issue and develop a clean solution that can go into the
mainline kernel.

Patch against 2.6.0-test7 follows.

 Makefile                            |    2 -
 security/selinux/avc.c              |   13 +++++++++-
 security/selinux/include/security.h |    1 
 security/selinux/selinuxfs.c        |   44 +++++++++++++++++++++++++++++++++++-
 security/selinux/ss/policydb.h      |    1 
 5 files changed, 56 insertions(+), 5 deletions(-)

Index: linux-2.6/Makefile
diff -u linux-2.6/Makefile:1.1.1.19 linux-2.6/Makefile:1.21
--- linux-2.6/Makefile:1.1.1.19	Thu Oct  9 08:24:21 2003
+++ linux-2.6/Makefile	Thu Oct  9 09:03:36 2003
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 0
-EXTRAVERSION = -test7
+EXTRAVERSION = -test7-selinux1
 
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"
Index: linux-2.6/security/selinux/avc.c
diff -u linux-2.6/security/selinux/avc.c:1.1.1.2 linux-2.6/security/selinux/avc.c:1.35
--- linux-2.6/security/selinux/avc.c:1.1.1.2	Mon Aug 25 10:58:08 2003
+++ linux-2.6/security/selinux/avc.c	Wed Sep 24 12:15:25 2003
@@ -575,17 +575,26 @@
 			break;
 		case AVC_AUDIT_DATA_FS:
 			if (a->u.fs.dentry) {
+				struct dentry *dentry = a->u.fs.dentry;
 				if (a->u.fs.mnt) {
-					p = d_path(a->u.fs.dentry,
+					p = d_path(dentry,
 						   a->u.fs.mnt,
 						   avc_audit_buffer,
 						   PAGE_SIZE);
 					if (p)
 						printk(" path=%s", p);
+				} else {
+					printk(" name=%s", dentry->d_name.name);
 				}
-				inode = a->u.fs.dentry->d_inode;
+				inode = dentry->d_inode;
 			} else if (a->u.fs.inode) {
+				struct dentry *dentry;
 				inode = a->u.fs.inode;
+				dentry = d_find_alias(inode);
+				if (dentry) {
+					printk(" name=%s", dentry->d_name.name);
+					dput(dentry);
+				}
 			}
 			if (inode)
 				printk(" dev=%s ino=%ld",
Index: linux-2.6/security/selinux/selinuxfs.c
diff -u linux-2.6/security/selinux/selinuxfs.c:1.1.1.3 linux-2.6/security/selinux/selinuxfs.c:1.32
--- linux-2.6/security/selinux/selinuxfs.c:1.1.1.3	Mon Sep 29 09:14:40 2003
+++ linux-2.6/security/selinux/selinuxfs.c	Fri Oct  3 16:01:16 2003
@@ -37,7 +37,8 @@
 	SEL_ACCESS,	/* compute access decision */
 	SEL_CREATE,	/* compute create labeling decision */
 	SEL_RELABEL,	/* compute relabeling decision */
-	SEL_USER	/* compute reachable user contexts */
+	SEL_USER,	/* compute reachable user contexts */
+	SEL_POLICYVERS	/* return policy version for this kernel */
 };
 
 static ssize_t sel_read_enforce(struct file *filp, char *buf,
@@ -125,6 +126,46 @@
 	.write		= sel_write_enforce,
 };
 
+static ssize_t sel_read_policyvers(struct file *filp, char *buf,
+                                   size_t count, loff_t *ppos)
+{
+	char *page;
+	ssize_t length;
+	ssize_t end;
+
+	if (count < 0 || count > PAGE_SIZE)
+		return -EINVAL;
+	if (!(page = (char*)__get_free_page(GFP_KERNEL)))
+		return -ENOMEM;
+	memset(page, 0, PAGE_SIZE);
+
+	length = snprintf(page, PAGE_SIZE, "%u", POLICYDB_VERSION);
+	if (length < 0) {
+		free_page((unsigned long)page);
+		return length;
+	}
+
+	if (*ppos >= length) {
+		free_page((unsigned long)page);
+		return 0;
+	}
+	if (count + *ppos > length)
+		count = length - *ppos;
+	end = count + *ppos;
+	if (copy_to_user(buf, (char *) page + *ppos, count)) {
+		count = -EFAULT;
+		goto out;
+	}
+	*ppos = end;
+out:
+	free_page((unsigned long)page);
+	return count;
+}
+
+static struct file_operations sel_policyvers_ops = {
+	.read		= sel_read_policyvers,
+};
+
 static ssize_t sel_write_load(struct file * file, const char * buf,
 			      size_t count, loff_t *ppos)
 
@@ -568,6 +609,7 @@
 		[SEL_CREATE] = {"create", &transaction_ops, S_IRUGO|S_IWUGO},
 		[SEL_RELABEL] = {"relabel", &transaction_ops, S_IRUGO|S_IWUGO},
 		[SEL_USER] = {"user", &transaction_ops, S_IRUGO|S_IWUGO},
+		[SEL_POLICYVERS] = {"policyvers", &sel_policyvers_ops, S_IRUGO},
 		/* last one */ {""}
 	};
 	return simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
Index: linux-2.6/security/selinux/include/security.h
diff -u linux-2.6/security/selinux/include/security.h:1.1.1.2 linux-2.6/security/selinux/include/security.h:1.12
--- linux-2.6/security/selinux/include/security.h:1.1.1.2	Mon Sep 29 09:14:42 2003
+++ linux-2.6/security/selinux/include/security.h	Fri Oct  3 16:01:19 2003
@@ -13,6 +13,7 @@
 #define SECCLASS_NULL			0x0000 /* no class */
 
 #define SELINUX_MAGIC 0xf97cff8c
+#define POLICYDB_VERSION 15
 
 #ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
 extern int selinux_enabled;
Index: linux-2.6/security/selinux/ss/policydb.h
diff -u linux-2.6/security/selinux/ss/policydb.h:1.1.1.1 linux-2.6/security/selinux/ss/policydb.h:1.18
--- linux-2.6/security/selinux/ss/policydb.h:1.1.1.1	Tue Aug 12 09:05:07 2003
+++ linux-2.6/security/selinux/ss/policydb.h	Fri Oct  3 16:01:23 2003
@@ -225,7 +225,6 @@
 
 #define PERM_SYMTAB_SIZE 32
 
-#define POLICYDB_VERSION 15
 #define POLICYDB_CONFIG_MLS    1
 
 #define OBJECT_R "object_r"


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

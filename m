Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1MICNdW024622
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 13:12:23 -0500 (EST)
Subject: [RFC][PATCH] Pass requested protection to
	security_file_mmap/mprotect hooks
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: lsm <linux-security-module@wirex.com>, Chris Wright <chrisw@osdl.org>,
   James Morris <jmorris@redhat.com>
Cc: selinux@tycho.nsa.gov, Ivan Gyurdiev <ivg2@cornell.edu>,
   Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 13:02:48 -0500
Message-Id: <1109095368.15893.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds a reqprot parameter to the security_file_mmap and
security_file_mprotect hooks that is the original requested protection
value prior to any modification for read-implies-exec, and changes the
SELinux module to allow a mode of operation (controllable via
a /selinux/checkreqprot setting) where it applies checks based on that
protection value rather than the protection that will be applied by the
kernel, effectively restoring SELinux's original behavior prior to the
introduction of the read-implies-exec logic in the mainline kernel.  At
present, the read-implies-exec logic causes SELinux to see every
mmap/mprotect read request by legacy binaries or binaries marked with
PT_GNU_STACK RWE as a read|execute request, which tends to distort
policy even if it reflects what is ultimately possible.
The /selinux/checkreqprot setting allows one to set the desired behavior
for SELinux, so either the current behavior or the original behavior is
possible.  What do people think about this proposed patch (obviously not
intended for upstreaming until after 2.6.11 is out)?  Are there any
other changes to these two hooks that should be made at the same time?
Should the default value for /selinux/checkreqprot be configurable?

 include/linux/security.h                     |   25 ++++++++----
 mm/mmap.c                                    |    4 +-
 mm/mprotect.c                                |    4 +-
 security/dummy.c                             |    7 ++-
 security/selinux/hooks.c                     |   14 +++++--
 security/selinux/include/av_perm_to_string.h |    1 
 security/selinux/include/av_permissions.h    |    1 
 security/selinux/include/objsec.h            |    2 +
 security/selinux/selinuxfs.c                 |   53 +++++++++++++++++++++++++++
 9 files changed, 94 insertions(+), 17 deletions(-)

Index: linux-2.6/include/linux/security.h
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/include/linux/security.h,v
retrieving revision 1.43
diff -u -p -r1.43 security.h
--- linux-2.6/include/linux/security.h	12 Jan 2005 15:37:48 -0000	1.43
+++ linux-2.6/include/linux/security.h	22 Feb 2005 14:57:17 -0000
@@ -458,13 +458,15 @@ struct swap_info_struct;
  *	Check permissions for a mmap operation.  The @file may be NULL, e.g.
  *	if mapping anonymous memory.
  *	@file contains the file structure for file to map (may be NULL).
- *	@prot contains the requested permissions.
+ *	@reqprot contains the protection requested by the application.
+ *	@prot contains the protection that will be applied by the kernel.
  *	@flags contains the operational flags.
  *	Return 0 if permission is granted.
  * @file_mprotect:
  *	Check permissions before changing memory access permissions.
  *	@vma contains the memory region to modify.
- *	@prot contains the requested permissions.
+ *	@reqprot contains the protection requested by the application.
+ *	@prot contains the protection that will be applied by the kernel.
  *	Return 0 if permission is granted.
  * @file_lock:
  *	Check permission before performing file locking operations.
@@ -1128,9 +1130,12 @@ struct security_operations {
 	void (*file_free_security) (struct file * file);
 	int (*file_ioctl) (struct file * file, unsigned int cmd,
 			   unsigned long arg);
-	int (*file_mmap) (struct file * file,
+	int (*file_mmap) (struct file * file, 
+			  unsigned long reqprot,
 			  unsigned long prot, unsigned long flags);
-	int (*file_mprotect) (struct vm_area_struct * vma, unsigned long prot);
+	int (*file_mprotect) (struct vm_area_struct * vma, 
+			      unsigned long reqprot,
+			      unsigned long prot);
 	int (*file_lock) (struct file * file, unsigned int cmd);
 	int (*file_fcntl) (struct file * file, unsigned int cmd,
 			   unsigned long arg);
@@ -1631,16 +1636,18 @@ static inline int security_file_ioctl (s
 	return security_ops->file_ioctl (file, cmd, arg);
 }
 
-static inline int security_file_mmap (struct file *file, unsigned long prot,
+static inline int security_file_mmap (struct file *file, unsigned long reqprot,
+				      unsigned long prot,
 				      unsigned long flags)
 {
-	return security_ops->file_mmap (file, prot, flags);
+	return security_ops->file_mmap (file, reqprot, prot, flags);
 }
 
 static inline int security_file_mprotect (struct vm_area_struct *vma,
+					  unsigned long reqprot,
 					  unsigned long prot)
 {
-	return security_ops->file_mprotect (vma, prot);
+	return security_ops->file_mprotect (vma, reqprot, prot);
 }
 
 static inline int security_file_lock (struct file *file, unsigned int cmd)
@@ -2278,13 +2285,15 @@ static inline int security_file_ioctl (s
 	return 0;
 }
 
-static inline int security_file_mmap (struct file *file, unsigned long prot,
+static inline int security_file_mmap (struct file *file, unsigned long reqprot,
+				      unsigned long prot,
 				      unsigned long flags)
 {
 	return 0;
 }
 
 static inline int security_file_mprotect (struct vm_area_struct *vma,
+					  unsigned long reqprot,
 					  unsigned long prot)
 {
 	return 0;
Index: linux-2.6/mm/mmap.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/mm/mmap.c,v
retrieving revision 1.20
diff -u -p -r1.20 mmap.c
--- linux-2.6/mm/mmap.c	12 Jan 2005 15:42:38 -0000	1.20
+++ linux-2.6/mm/mmap.c	22 Feb 2005 14:32:07 -0000
@@ -859,7 +859,7 @@ unsigned long do_mmap_pgoff(struct file 
 	int error;
 	struct rb_node ** rb_link, * rb_parent;
 	int accountable = 1;
-	unsigned long charged = 0;
+	unsigned long charged = 0, reqprot = prot;
 
 	if (file) {
 		if (is_file_hugepages(file))
@@ -977,7 +977,7 @@ unsigned long do_mmap_pgoff(struct file 
 		}
 	}
 
-	error = security_file_mmap(file, prot, flags);
+	error = security_file_mmap(file, reqprot, prot, flags);
 	if (error)
 		return error;
 		
Index: linux-2.6/mm/mprotect.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/mm/mprotect.c,v
retrieving revision 1.10
diff -u -p -r1.10 mprotect.c
--- linux-2.6/mm/mprotect.c	27 Dec 2004 15:09:53 -0000	1.10
+++ linux-2.6/mm/mprotect.c	22 Feb 2005 14:36:21 -0000
@@ -193,7 +193,7 @@ fail:
 asmlinkage long
 sys_mprotect(unsigned long start, size_t len, unsigned long prot)
 {
-	unsigned long vm_flags, nstart, end, tmp;
+	unsigned long vm_flags, nstart, end, tmp, reqprot = prot;
 	struct vm_area_struct *vma, *prev;
 	int error = -EINVAL;
 	const int grows = prot & (PROT_GROWSDOWN|PROT_GROWSUP);
@@ -264,7 +264,7 @@ sys_mprotect(unsigned long start, size_t
 			goto out;
 		}
 
-		error = security_file_mprotect(vma, prot);
+		error = security_file_mprotect(vma, reqprot, prot);
 		if (error)
 			goto out;
 
Index: linux-2.6/security/dummy.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/dummy.c,v
retrieving revision 1.43
diff -u -p -r1.43 dummy.c
--- linux-2.6/security/dummy.c	26 Jan 2005 21:20:58 -0000	1.43
+++ linux-2.6/security/dummy.c	22 Feb 2005 14:38:16 -0000
@@ -446,13 +446,16 @@ static int dummy_file_ioctl (struct file
 	return 0;
 }
 
-static int dummy_file_mmap (struct file *file, unsigned long prot,
+static int dummy_file_mmap (struct file *file, unsigned long reqprot,
+			    unsigned long prot,
 			    unsigned long flags)
 {
 	return 0;
 }
 
-static int dummy_file_mprotect (struct vm_area_struct *vma, unsigned long prot)
+static int dummy_file_mprotect (struct vm_area_struct *vma, 
+				unsigned long reqprot,
+				unsigned long prot)
 {
 	return 0;
 }
Index: linux-2.6/security/selinux/hooks.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/hooks.c,v
retrieving revision 1.151
diff -u -p -r1.151 hooks.c
--- linux-2.6/security/selinux/hooks.c	4 Feb 2005 17:59:53 -0000	1.151
+++ linux-2.6/security/selinux/hooks.c	22 Feb 2005 17:00:08 -0000
@@ -2441,27 +2441,35 @@ static int file_map_prot_check(struct fi
 	return 0;
 }
 
-static int selinux_file_mmap(struct file *file, unsigned long prot, unsigned long flags)
+static int selinux_file_mmap(struct file *file, unsigned long reqprot, 
+			     unsigned long prot, unsigned long flags)
 {
 	int rc;
 
-	rc = secondary_ops->file_mmap(file, prot, flags);
+	rc = secondary_ops->file_mmap(file, reqprot, prot, flags);
 	if (rc)
 		return rc;
 
+	if (selinux_checkreqprot)
+		prot = reqprot;
+
 	return file_map_prot_check(file, prot,
 				   (flags & MAP_TYPE) == MAP_SHARED);
 }
 
 static int selinux_file_mprotect(struct vm_area_struct *vma,
+				 unsigned long reqprot,
 				 unsigned long prot)
 {
 	int rc;
 
-	rc = secondary_ops->file_mprotect(vma, prot);
+	rc = secondary_ops->file_mprotect(vma, reqprot, prot);
 	if (rc)
 		return rc;
 
+	if (selinux_checkreqprot)
+		prot = reqprot;
+
 	if (vma->vm_file != NULL && vma->anon_vma != NULL && (prot & PROT_EXEC)) {
 		/*
 		 * We are making executable a file mapping that has
Index: linux-2.6/security/selinux/selinuxfs.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/selinuxfs.c,v
retrieving revision 1.51
diff -u -p -r1.51 selinuxfs.c
--- linux-2.6/security/selinux/selinuxfs.c	2 Dec 2004 15:21:42 -0000	1.51
+++ linux-2.6/security/selinux/selinuxfs.c	22 Feb 2005 15:33:39 -0000
@@ -34,6 +34,8 @@
 #include "objsec.h"
 #include "conditional.h"
 
+unsigned int selinux_checkreqprot = 0;
+
 static DECLARE_MUTEX(sel_sem);
 
 /* global data for booleans */
@@ -72,6 +74,7 @@ enum sel_inos {
 	SEL_DISABLE,	/* disable SELinux until next reboot */
 	SEL_AVC,	/* AVC management directory */
 	SEL_MEMBER,	/* compute polyinstantiation membership decision */
+	SEL_CHECKREQPROT, /* check requested protection, not kernel-applied one */
 };
 
 #define TMPBUFLEN	12
@@ -300,6 +303,55 @@ static struct file_operations sel_contex
 	.write		= sel_write_context,
 };
 
+#define TMPBUFLEN	12
+static ssize_t sel_read_checkreqprot(struct file *filp, char __user *buf,
+				     size_t count, loff_t *ppos)
+{
+	char tmpbuf[TMPBUFLEN];
+	ssize_t length;
+
+	length = scnprintf(tmpbuf, TMPBUFLEN, "%u", selinux_checkreqprot);
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
+}
+
+static ssize_t sel_write_checkreqprot(struct file * file, const char __user * buf,
+				      size_t count, loff_t *ppos)
+{
+	char *page;
+	ssize_t length;
+	unsigned int new_value;
+
+	length = task_has_security(current, SECURITY__SETCHECKREQPROT);
+	if (length)
+		return length;
+
+	if (count < 0 || count >= PAGE_SIZE)
+		return -ENOMEM;
+	if (*ppos != 0) {
+		/* No partial writes. */
+		return -EINVAL;
+	}
+	page = (char*)get_zeroed_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+	length = -EFAULT;
+	if (copy_from_user(page, buf, count))
+		goto out;
+
+	length = -EINVAL;
+	if (sscanf(page, "%u", &new_value) != 1)
+		goto out;
+
+	selinux_checkreqprot = new_value;
+	length = count;
+out:
+	free_page((unsigned long) page);
+	return length;
+}
+static struct file_operations sel_checkreqprot_ops = {
+	.read		= sel_read_checkreqprot,
+	.write		= sel_write_checkreqprot,
+};
 
 /*
  * Remaining nodes use transaction based IO methods like nfsd/nfsctl.c
@@ -1182,6 +1234,7 @@ static int sel_fill_super(struct super_b
 		[SEL_MLS] = {"mls", &sel_mls_ops, S_IRUGO},
 		[SEL_DISABLE] = {"disable", &sel_disable_ops, S_IWUSR},
 		[SEL_MEMBER] = {"member", &transaction_ops, S_IRUGO|S_IWUGO},
+		[SEL_CHECKREQPROT] = {"checkreqprot", &sel_checkreqprot_ops, S_IRUGO|S_IWUSR},
 		/* last one */ {""}
 	};
 	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
Index: linux-2.6/security/selinux/include/av_perm_to_string.h
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/include/av_perm_to_string.h,v
retrieving revision 1.22
diff -u -p -r1.22 av_perm_to_string.h
--- linux-2.6/security/selinux/include/av_perm_to_string.h	8 Feb 2005 20:46:21 -0000	1.22
+++ linux-2.6/security/selinux/include/av_perm_to_string.h	22 Feb 2005 14:55:17 -0000
@@ -83,6 +83,7 @@
    S_(SECCLASS_SECURITY, SECURITY__SETENFORCE, "setenforce")
    S_(SECCLASS_SECURITY, SECURITY__SETBOOL, "setbool")
    S_(SECCLASS_SECURITY, SECURITY__SETSECPARAM, "setsecparam")
+   S_(SECCLASS_SECURITY, SECURITY__SETCHECKREQPROT, "setcheckreqprot")
    S_(SECCLASS_SYSTEM, SYSTEM__IPC_INFO, "ipc_info")
    S_(SECCLASS_SYSTEM, SYSTEM__SYSLOG_READ, "syslog_read")
    S_(SECCLASS_SYSTEM, SYSTEM__SYSLOG_MOD, "syslog_mod")
Index: linux-2.6/security/selinux/include/av_permissions.h
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/include/av_permissions.h,v
retrieving revision 1.21
diff -u -p -r1.21 av_permissions.h
--- linux-2.6/security/selinux/include/av_permissions.h	8 Feb 2005 20:46:21 -0000	1.21
+++ linux-2.6/security/selinux/include/av_permissions.h	22 Feb 2005 14:55:17 -0000
@@ -522,6 +522,7 @@
 #define SECURITY__SETENFORCE                      0x00000080UL
 #define SECURITY__SETBOOL                         0x00000100UL
 #define SECURITY__SETSECPARAM                     0x00000200UL
+#define SECURITY__SETCHECKREQPROT                 0x00000400UL
 
 #define SYSTEM__IPC_INFO                          0x00000001UL
 #define SYSTEM__SYSLOG_READ                       0x00000002UL
Index: linux-2.6/security/selinux/include/objsec.h
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/include/objsec.h,v
retrieving revision 1.26
diff -u -p -r1.26 objsec.h
--- linux-2.6/security/selinux/include/objsec.h	12 Jan 2005 15:37:53 -0000	1.26
+++ linux-2.6/security/selinux/include/objsec.h	22 Feb 2005 14:41:46 -0000
@@ -108,4 +108,6 @@ struct sk_security_struct {
 
 extern int inode_security_set_sid(struct inode *inode, u32 sid);
 
+extern unsigned int selinux_checkreqprot;
+
 #endif /* _SELINUX_OBJSEC_H_ */

  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

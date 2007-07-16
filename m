Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6GG4Woi023162
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2007 12:04:32 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6GG4V1q019884
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2007 16:04:31 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1) with ESMTP id l6GG5FNc004560
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2007 12:05:15 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1/Submit) id l6GG5F1s004559
	for selinux@tycho.nsa.gov; Mon, 16 Jul 2007 12:05:15 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6GDrRRn010284
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2007 09:53:37 -0400
Received: from e33.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6GDrPNs026049
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2007 13:53:26 GMT
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6GDrPap026401
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2007 09:53:25 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6GDrPae268400
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2007 07:53:25 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6GDrPn8020007
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2007 07:53:25 -0600
Subject: [RFC]integrity: SELinux patch
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: selinux@tycho.nsa.gov
Cc: zohar@us.ibm.com, safford@watson.ibm.com
Content-Type: text/plain
Date: Mon, 16 Jul 2007 09:57:20 -0400
Message-Id: <1184594240.5860.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a first attempt to verify and measure file integrity, by
adding the new Linux Integrity Modules(LIM) API calls to SElinux.
We are planning on posting the corresponding LIM and IMA patches to
LKML, but would like comments/suggestions here first, particularly
in regards to the policy checking code in selinux_measure() called 
from selinux_inode_permission().

SELINUX_ENFORCE_INTEGRITY can be configured to either verify and
enforce integrity or to just log integrity failures. The default
is to just log integrity failures.

The integrity of the SELinux metadata is verified when the xattr
is initially retrieved.  On an integrity failure, assuming that
integrity verification is enforced, normal error processing occurs.

By default, all executables and all files that are mmap'ed executable
are measured. This patch extends the file class with 'measure'.
Additional files can be measured in selinux_inode_permission()
based on a FILE__MEASURE policy. (As the policy call is causing too
many files to be measured, it is commented out.) For example, to
measure kernel modules add:
	module ima 1.0;

	require {
		type insmod_t;
		type modules_object_t;
		class file measure;
	}

	#============= insmod_t ==============
	allow insmod_t modules_object_t:file measure;

Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
---
Index: linux-2.6.22-rc6-mm1/security/selinux/hooks.c
===================================================================
--- linux-2.6.22-rc6-mm1.orig/security/selinux/hooks.c
+++ linux-2.6.22-rc6-mm1/security/selinux/hooks.c
@@ -70,6 +70,7 @@
 #include <linux/audit.h>
 #include <linux/string.h>
 #include <linux/selinux.h>
+#include <linux/integrity.h>
 #include <linux/mutex.h>
 
 #include "avc.h"
@@ -109,6 +110,12 @@ __setup("selinux=", selinux_enabled_setu
 int selinux_enabled = 1;
 #endif
 
+#ifdef CONFIG_SECURITY_SELINUX_ENFORCE_INTEGRITY
+static int integrity_enforce = 1;
+#else
+static int integrity_enforce;
+#endif
+
 /* Original (dummy) security module. */
 static struct security_operations *original_ops = NULL;
 
@@ -847,6 +854,7 @@ static int inode_doinit_with_dentry(stru
 	char *context = NULL;
 	unsigned len = 0;
 	int rc = 0;
+	int status;
 
 	if (isec->initialized)
 		goto out;
@@ -890,35 +898,12 @@ static int inode_doinit_with_dentry(stru
 			goto out_unlock;
 		}
 
-		len = INITCONTEXTLEN;
-		context = kmalloc(len, GFP_KERNEL);
-		if (!context) {
-			rc = -ENOMEM;
+		rc = integrity_verify_metadata(dentry, XATTR_NAME_SELINUX,
+				       &context, &len, &status);
+		if (rc == -ENOMEM) {
 			dput(dentry);
 			goto out_unlock;
 		}
-		rc = inode->i_op->getxattr(dentry, XATTR_NAME_SELINUX,
-					   context, len);
-		if (rc == -ERANGE) {
-			/* Need a larger buffer.  Query for the right size. */
-			rc = inode->i_op->getxattr(dentry, XATTR_NAME_SELINUX,
-						   NULL, 0);
-			if (rc < 0) {
-				dput(dentry);
-				goto out_unlock;
-			}
-			kfree(context);
-			len = rc;
-			context = kmalloc(len, GFP_KERNEL);
-			if (!context) {
-				rc = -ENOMEM;
-				dput(dentry);
-				goto out_unlock;
-			}
-			rc = inode->i_op->getxattr(dentry,
-						   XATTR_NAME_SELINUX,
-						   context, len);
-		}
 		dput(dentry);
 		if (rc < 0) {
 			if (rc != -ENODATA) {
@@ -932,6 +917,19 @@ static int inode_doinit_with_dentry(stru
 			sid = sbsec->def_sid;
 			rc = 0;
 		} else {
+			/* Log integrity failures, if integrity enforced
+			 * behave like for any other failure.
+			 */
+			if (status == INTEGRITY_FAIL) {
+				printk(KERN_WARNING "%s: verify_metadata "
+				       "failed for dev=%s ino=%ld\n",
+					__FUNCTION__,
+					inode->i_sb->s_id, inode->i_ino);
+				if (integrity_enforce) {
+					kfree(context);
+					goto out_unlock;
+				}
+			}
 			rc = security_context_to_sid_default(context, rc, &sid,
 			                                     sbsec->def_sid);
 			if (rc) {
@@ -1701,9 +1699,109 @@ static int selinux_bprm_set_security(str
 	return 0;
 }
 
-static int selinux_bprm_check_security (struct linux_binprm *bprm)
+static inline int is_kernel_thread(struct task_struct *tsk)
+{
+	return (!tsk->mm) ? 1 : 0;
+}
+
+static int selinux_verify_metadata(struct dentry *dentry)
+{
+	int rc, status;
+
+	if (!dentry)
+		return 0;
+
+	rc = integrity_verify_metadata(dentry, NULL, NULL, NULL, &status);
+	if (rc == -EOPNOTSUPP)
+		return 0;
+
+	if (rc < 0) {
+		printk(KERN_INFO "%s: verify_metadata %s failed"
+				"(rc: %d - status: %d)\n", __FUNCTION__,
+				dentry->d_name.name, rc, status);
+		if (!integrity_enforce)
+			rc = 0;
+		goto out;
+	}
+	if (status != INTEGRITY_PASS) {	/* FAIL | NO_LABEL */
+		if (!is_kernel_thread(current)) {
+			printk(KERN_INFO "%s: verify_metadata %s "
+			       "(Integrity status: %s)\n", __FUNCTION__,
+				dentry->d_name.name,
+				status == INTEGRITY_FAIL ? "FAIL" : "NOLABEL");
+			if (integrity_enforce) {
+				rc = -EACCES;
+				goto out;
+			}
+		}
+	}
+	return 0;
+out:
+	return rc;
+}
+
+static int selinux_verify_and_measure(struct dentry *dentry,
+					struct file *file,
+					char *filename, int mask)
+{
+	int rc, status;
+
+	if (!dentry && !file)
+		return 0;
+
+	rc = integrity_verify_data(dentry, file, &status);
+	if (rc < 0) {
+		printk(KERN_INFO "%s: %s verify_data failed "
+		       "(rc: %d - status: %d)\n", __FUNCTION__,
+			filename, rc, status);
+		if (!integrity_enforce)
+			rc = 0;
+		goto out;
+	}
+
+	if (status != INTEGRITY_PASS) {
+		if (!is_kernel_thread(current)) {
+			printk(KERN_INFO "%s: verify_data %s "
+			       "(Integrity status: FAIL)\n",
+				__FUNCTION__, filename);
+			if (integrity_enforce) {
+				rc = -EACCES;
+				goto out;
+			}
+		}
+	}
+
+	/* Only measure files that passed integrity verification. */
+	integrity_measure(dentry, file, filename, mask);
+	return 0;
+out:
+	/*
+	 * Verification failed, but as integrity is not being enforced,
+	 * we still need to measure.
+	 */
+	if (rc == 0)
+		integrity_measure(dentry, file, filename, mask);
+	return rc;
+}
+
+static int selinux_bprm_check_security(struct linux_binprm *bprm)
 {
-	return secondary_ops->bprm_check_security(bprm);
+	struct dentry *dentry = bprm->file->f_dentry;
+	int rc;
+
+	rc = secondary_ops->bprm_check_security(bprm);
+	if (rc != 0)
+		return rc;
+
+	/* We probably want to re-verify the metadata, verify
+	 * the data, and measure the integrity of all executables.
+	 */
+	rc = selinux_verify_metadata(dentry);
+	if (rc == 0)
+		rc = selinux_verify_and_measure(dentry,
+				bprm->file, bprm->filename, MAY_EXEC);
+
+	return rc;
 }
 
 
@@ -2252,6 +2350,30 @@ static int selinux_inode_follow_link(str
 	return dentry_has_perm(current, NULL, dentry, FILE__READ);
 }
 
+/*
+ * Measure based on a policy
+ */
+static int selinux_measure(struct inode *inode, struct dentry *dentry)
+{
+	int rc = 1;
+#if 0
+	struct inode_security_struct *isec = inode->i_security;
+	struct task_security_struct *tsec = current->security;
+	struct av_decision avd;
+	struct avc_audit_data ad;
+
+	/* This initial attempt to base on policy measures too much. */
+	rc = avc_has_perm_noaudit(tsec->sid, isec->sid, SECCLASS_FILE,
+				  FILE__MEASURE, AVC_STRICT, &avd);
+	AVC_AUDIT_DATA_INIT(&ad,FS);
+	ad.u.fs.mnt = NULL;
+	ad.u.fs.dentry = dentry;
+	avc_audit(tsec->sid, isec->sid, SECCLASS_FILE, FILE__MEASURE,
+		  &avd, rc, &ad);
+#endif
+	return rc;
+}
+
 static int selinux_inode_permission(struct inode *inode, int mask,
 				    struct nameidata *nd)
 {
@@ -2265,9 +2387,26 @@ static int selinux_inode_permission(stru
 		/* No permission to check.  Existence test. */
 		return 0;
 	}
-
-	return inode_has_perm(current, inode,
+	rc = inode_has_perm(current, inode,
 			       file_mask_to_av(inode->i_mode, mask), NULL);
+	if (rc != 0)
+		return rc;
+
+	if (S_ISREG(inode->i_mode) && (mask & MAY_READ)) {
+		struct dentry *dentry;
+
+		dentry = (!nd || !nd->dentry) ?
+				d_find_alias(inode) : nd->dentry;
+
+		if (dentry) {
+			if (selinux_measure(inode, dentry) == 0)
+				integrity_measure(dentry, NULL,
+					(char *)dentry->d_name.name, mask);
+			if (!nd || !nd->dentry)
+				dput(dentry);
+		}
+	}
+	return rc;
 }
 
 static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
@@ -2630,8 +2769,20 @@ static int selinux_file_mprotect(struct 
 			return rc;
 	}
 #endif
+	rc = file_map_prot_check(vma->vm_file, prot, vma->vm_flags&VM_SHARED);
+	if (rc != 0)
+		return rc;
 
-	return file_map_prot_check(vma->vm_file, prot, vma->vm_flags&VM_SHARED);
+	if (vma->vm_file && vma->vm_file->f_dentry) {
+		rc = selinux_verify_metadata(vma->vm_file->f_dentry);
+		if (rc == 0)
+			rc = selinux_verify_and_measure(NULL, vma->vm_file,
+				(char *)vma->vm_file->f_dentry->d_name.name,
+				MAY_EXEC);
+		if (rc != 0)
+			return rc;
+	}
+	return rc;
 }
 
 static int selinux_file_lock(struct file *file, unsigned int cmd)
Index: linux-2.6.22-rc6-mm1/security/selinux/Kconfig
===================================================================
--- linux-2.6.22-rc6-mm1.orig/security/selinux/Kconfig
+++ linux-2.6.22-rc6-mm1/security/selinux/Kconfig
@@ -161,3 +161,15 @@ config SECURITY_SELINUX_POLICYDB_VERSION
 	  installed under /etc/selinux/$SELINUXTYPE/policy, where
 	  SELINUXTYPE is defined in your /etc/selinux/config.
 
+config SECURITY_SELINUX_ENFORCE_INTEGRITY
+	bool "SELinux integrity "
+	depends on SECURITY_SELINUX && INTEGRITY
+	default n
+	help
+	  This option enables SELinux, using the Linux Integrity
+	  Module (LIM) API, to verify metadata stored as extended
+	  attributes, verify the file data and extend the TPM PCR
+	  measurements.
+
+	  If you are unsure how to answer this question, answer N.
+
Index: linux-2.6.22-rc6-mm1/security/selinux/include/av_permissions.h
===================================================================
--- linux-2.6.22-rc6-mm1.orig/security/selinux/include/av_permissions.h
+++ linux-2.6.22-rc6-mm1/security/selinux/include/av_permissions.h
@@ -99,6 +99,7 @@
 #define FILE__EXECUTE_NO_TRANS                    0x00020000UL
 #define FILE__ENTRYPOINT                          0x00040000UL
 #define FILE__EXECMOD                             0x00080000UL
+#define FILE__MEASURE                             0x00100000UL
 #define LNK_FILE__IOCTL                           0x00000001UL
 #define LNK_FILE__READ                            0x00000002UL
 #define LNK_FILE__WRITE                           0x00000004UL
Index: linux-2.6.22-rc6-mm1/security/selinux/include/av_perm_to_string.h
===================================================================
--- linux-2.6.22-rc6-mm1.orig/security/selinux/include/av_perm_to_string.h
+++ linux-2.6.22-rc6-mm1/security/selinux/include/av_perm_to_string.h
@@ -17,6 +17,7 @@
    S_(SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, "execute_no_trans")
    S_(SECCLASS_FILE, FILE__ENTRYPOINT, "entrypoint")
    S_(SECCLASS_FILE, FILE__EXECMOD, "execmod")
+   S_(SECCLASS_FILE, FILE__MEASURE, "measure")
    S_(SECCLASS_CHR_FILE, CHR_FILE__EXECUTE_NO_TRANS, "execute_no_trans")
    S_(SECCLASS_CHR_FILE, CHR_FILE__ENTRYPOINT, "entrypoint")
    S_(SECCLASS_CHR_FILE, CHR_FILE__EXECMOD, "execmod")


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

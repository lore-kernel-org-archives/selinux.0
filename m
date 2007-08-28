Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7SMTVnA014857
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 18:29:32 -0400
Received: from e31.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7SMTUKY025694
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 22:29:30 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7SMTPa8002975
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 18:29:25 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l7SMTOEc409474
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 16:29:25 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l7SMTOd6030413
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 16:29:24 -0600
Subject: [RFC]integrity: SELinux patch
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: selinux@tycho.nsa.gov
Cc: zohar@us.ibm.com, safford@watson.ibm.com, sailer@us.ibm.com
Content-Type: text/plain
Date: Tue, 28 Aug 2007 18:35:01 -0400
Message-Id: <1188340501.11528.14.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a second attempt to verify and measure file integrity, by
adding the new Linux Integrity Modules(LIM) API calls to SElinux.
This posting addresses comments previously made on this list. 
I will also post the current set of LIM patches, as well as an
initial integrity.te example. 

The integrity of the SELinux metadata is verified when the xattr
is initially retrieved.  On an integrity failure, normal selinux 
error processing occurs.

This patch defines a new 'integrity' class with the permission 
'measure'.  Measurement calls are made in selinux_file_mmap(), 
selinux_bprm_check_security, and selinux_inode_permission(),
based on policy.  (Additional calls might be required.)

Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
---
Index: linux-2.6.23-rc3-mm1/security/selinux/hooks.c
===================================================================
--- linux-2.6.23-rc3-mm1.orig/security/selinux/hooks.c
+++ linux-2.6.23-rc3-mm1/security/selinux/hooks.c
@@ -69,6 +69,7 @@
 #include <linux/audit.h>
 #include <linux/string.h>
 #include <linux/selinux.h>
+#include <linux/integrity.h>
 #include <linux/mutex.h>
 
 #include "avc.h"
@@ -844,6 +845,7 @@ static int inode_doinit_with_dentry(stru
 	char *context = NULL;
 	unsigned len = 0;
 	int rc = 0;
+	int status;
 
 	if (isec->initialized)
 		goto out;
@@ -888,34 +890,12 @@ static int inode_doinit_with_dentry(stru
 		}
 
 		len = INITCONTEXTLEN;
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
@@ -929,6 +909,14 @@ static int inode_doinit_with_dentry(stru
 			sid = sbsec->def_sid;
 			rc = 0;
 		} else {
+			if (status == INTEGRITY_FAIL) {
+				printk(KERN_WARNING "%s: verify_metadata "
+				       "failed for dev=%s ino=%ld\n",
+					__FUNCTION__,
+					inode->i_sb->s_id, inode->i_ino);
+				kfree(context);
+				goto out_unlock;
+			}
 			rc = security_context_to_sid_default(context, rc, &sid,
 			                                     sbsec->def_sid);
 			if (rc) {
@@ -1698,9 +1686,98 @@ static int selinux_bprm_set_security(str
 	return 0;
 }
 
-static int selinux_bprm_check_security (struct linux_binprm *bprm)
+static int selinux_verify_metadata(struct dentry *dentry)
 {
-	return secondary_ops->bprm_check_security(bprm);
+	int rc, status;
+
+	if (!dentry)
+		return 0;
+
+	rc = integrity_verify_metadata(dentry, NULL, NULL, NULL, &status);
+	if (rc == -EOPNOTSUPP)
+		return 0;
+	if (rc < 0)
+		goto out;
+
+	if (status != INTEGRITY_PASS) 	/* FAIL | NO_LABEL */
+		rc = -EACCES;
+out:
+	return rc;
+}
+
+static int selinux_verify_data(struct dentry *dentry, struct file *file)
+{
+	int rc, status;
+
+	if (!dentry && !file)
+		return 0;
+
+	rc = integrity_verify_data(dentry, file, &status);
+	if (rc < 0)
+		return 0;
+
+	if (status != INTEGRITY_PASS)
+		rc = -EACCES;
+
+	return rc;
+}
+
+/*
+ * Measure based on new 'integrity' class policy
+ */
+static void selinux_measure(struct inode *inode, struct dentry *dentry,
+				struct file *file, char *filename,
+				int mask)
+{
+	int rc = 1;
+	struct inode_security_struct *isec = inode->i_security;
+	struct task_security_struct *tsec = current->security;
+	struct av_decision avd;
+
+	if (!S_ISREG(inode->i_mode))
+		return;
+
+	rc = avc_has_perm_noaudit(tsec->sid, isec->sid, SECCLASS_INTEGRITY,
+				  INTEGRITY__MEASURE, AVC_STRICT, &avd);
+	if (rc == 0)
+		integrity_measure(inode, dentry, file, filename, mask);
+#if 0
+	else { /* Only used for debugging */
+		struct avc_audit_data ad;
+
+		AVC_AUDIT_DATA_INIT(&ad,FS);
+		ad.u.fs.mnt = NULL;
+		ad.u.fs.dentry = dentry;
+		avc_audit(tsec->sid, isec->sid, SECCLASS_INTEGRITY,
+			INTEGRITY__MEASURE, &avd, rc, &ad);
+	}
+#endif
+	return;
+}
+
+/* The OS protects against an executable file, already open for write,
+ * from being executed in deny_write_access() and an executable file
+ * already open for execute, from being modified in get_write_access().
+ * So we can be certain that what we verify and measure here is actually
+ * what is being executed.
+ */
+static int selinux_bprm_check_security(struct linux_binprm *bprm)
+{
+	struct dentry *dentry = bprm->file->f_dentry;
+	int rc;
+
+	rc = secondary_ops->bprm_check_security(bprm);
+	if (rc != 0)
+		return rc;
+
+	rc = selinux_verify_metadata(dentry);
+	if (rc == 0) {
+		rc = selinux_verify_data(dentry, bprm->file);
+		if (rc == 0)
+			selinux_measure(dentry->d_inode, dentry, bprm->file,
+					bprm->filename, MAY_EXEC);
+	}
+	return rc;
 }
 

@@ -2249,6 +2326,30 @@ static int selinux_inode_follow_link(str
 	return dentry_has_perm(current, NULL, dentry, FILE__READ);
 }
 
+static char *get_fname(struct dentry *dentry, struct vfsmount *mnt,
+			char **buf)
+{
+	char *fname = NULL;
+	char *path = NULL;
+
+	path = (char *)__get_free_page(GFP_KERNEL);
+	if (path) {
+		fname = d_path(dentry, mnt, path, PAGE_SIZE);
+		*buf = path;
+	}
+
+	if (!fname)	/* no choice, use short name */
+		fname = (!dentry->d_name.name) ?
+		    (char *)dentry->d_iname : (char *)dentry->d_name.name;
+	return fname;
+}
+
+static void free_fname(char *path)
+{
+	if (path)
+		free_page((unsigned long)path);
+}
+
 static int selinux_inode_permission(struct inode *inode, int mask,
 				    struct nameidata *nd)
 {
@@ -2263,8 +2364,29 @@ static int selinux_inode_permission(stru
 		return 0;
 	}
 
-	return inode_has_perm(current, inode,
+	rc = inode_has_perm(current, inode,
 			       file_mask_to_av(inode->i_mode, mask), NULL);
+	if (rc != 0)
+		return rc;
+
+	if (mask & ~MAY_EXEC) { /* measure executables later */
+		struct dentry *dentry = NULL;
+		char *path = NULL;
+		char *fname = NULL;
+
+		/* The file name is not required, but only a hint.
+		 * When possible, supply a fully qualified path name.
+		 */
+		if (nd) {
+			dentry = nd->dentry;
+			fname = get_fname(nd->dentry, nd->mnt, &path);
+		}
+
+		selinux_measure(inode, dentry, NULL, fname, mask);
+		if (path)
+			free_fname(path);
+	}
+	return rc;
 }
 
 static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
@@ -2585,8 +2707,18 @@ static int selinux_file_mmap(struct file
 	if (selinux_checkreqprot)
 		prot = reqprot;
 
-	return file_map_prot_check(file, prot,
-				   (flags & MAP_TYPE) == MAP_SHARED);
+	rc = file_map_prot_check(file, prot, (flags & MAP_TYPE) == MAP_SHARED);
+	if (file && file->f_dentry && rc == 0) {
+		rc = selinux_verify_metadata(file->f_dentry);
+		if (rc == 0) {
+			rc = selinux_verify_data(NULL, file);
+			if (rc == 0)
+				selinux_measure(file->f_dentry->d_inode,
+						  file->f_dentry, file,
+						  NULL, MAY_EXEC);
+		}
+	}
+	return rc;
 }
 
 static int selinux_file_mprotect(struct vm_area_struct *vma,
@@ -2628,7 +2760,6 @@ static int selinux_file_mprotect(struct 
 			return rc;
 	}
 #endif
-
 	return file_map_prot_check(vma->vm_file, prot, vma->vm_flags&VM_SHARED);
 }
 
Index: linux-2.6.23-rc3-mm1/security/selinux/include/av_permissions.h
===================================================================
--- linux-2.6.23-rc3-mm1.orig/security/selinux/include/av_permissions.h
+++ linux-2.6.23-rc3-mm1/security/selinux/include/av_permissions.h
@@ -824,3 +824,4 @@
 #define DCCP_SOCKET__NODE_BIND                    0x00400000UL
 #define DCCP_SOCKET__NAME_CONNECT                 0x00800000UL
 #define MEMPROTECT__MMAP_ZERO                     0x00000001UL
+#define INTEGRITY__MEASURE                        0x00000001UL
Index: linux-2.6.23-rc3-mm1/security/selinux/include/av_perm_to_string.h
===================================================================
--- linux-2.6.23-rc3-mm1.orig/security/selinux/include/av_perm_to_string.h
+++ linux-2.6.23-rc3-mm1/security/selinux/include/av_perm_to_string.h
@@ -159,3 +159,4 @@
    S_(SECCLASS_DCCP_SOCKET, DCCP_SOCKET__NODE_BIND, "node_bind")
    S_(SECCLASS_DCCP_SOCKET, DCCP_SOCKET__NAME_CONNECT, "name_connect")
    S_(SECCLASS_MEMPROTECT, MEMPROTECT__MMAP_ZERO, "mmap_zero")
+   S_(SECCLASS_INTEGRITY, INTEGRITY__MEASURE, "measure")
Index: linux-2.6.23-rc3-mm1/security/selinux/include/flask.h
===================================================================
--- linux-2.6.23-rc3-mm1.orig/security/selinux/include/flask.h
+++ linux-2.6.23-rc3-mm1/security/selinux/include/flask.h
@@ -50,6 +50,7 @@
 #define SECCLASS_KEY                                     58
 #define SECCLASS_DCCP_SOCKET                             60
 #define SECCLASS_MEMPROTECT                              61
+#define SECCLASS_INTEGRITY                               62
 
 /*
  * Security identifier indices for initial entities
Index: linux-2.6.23-rc3-mm1/security/selinux/include/class_to_string.h
===================================================================
--- linux-2.6.23-rc3-mm1.orig/security/selinux/include/class_to_string.h
+++ linux-2.6.23-rc3-mm1/security/selinux/include/class_to_string.h
@@ -64,3 +64,4 @@
     S_(NULL)
     S_("dccp_socket")
     S_("memprotect")
+    S_("integrity")
Index: linux-2.6.23-rc3-mm1/security/selinux/ss/services.c
===================================================================
--- linux-2.6.23-rc3-mm1.orig/security/selinux/ss/services.c
+++ linux-2.6.23-rc3-mm1/security/selinux/ss/services.c
@@ -305,12 +305,12 @@ static int context_struct_compute_av(str
 		    tclass <= SECCLASS_NETLINK_DNRT_SOCKET)
 			tclass = SECCLASS_NETLINK_SOCKET;
 
-	if (!tclass || tclass > policydb.p_classes.nprim) {
-		printk(KERN_ERR "security_compute_av:  unrecognized class %d\n",
-		       tclass);
-		return -EINVAL;
-	}
-	tclass_datum = policydb.class_val_to_struct[tclass - 1];
+//	if (!tclass || tclass > policydb.p_classes.nprim) {
+//		printk(KERN_ERR "security_compute_av:  unrecognized class %d\n",
+//		       tclass);
+//		return -EINVAL;
+//	}
+//	tclass_datum = policydb.class_val_to_struct[tclass - 1];
 
 	/*
 	 * Initialize the access vectors to the default values.
@@ -321,6 +321,10 @@ static int context_struct_compute_av(str
 	avd->auditdeny = 0xffffffff;
 	avd->seqno = latest_granting;
 
+	if (!tclass || tclass > policydb.p_classes.nprim)
+		return 0;
+	tclass_datum = policydb.class_val_to_struct[tclass - 1];
+
 	/*
 	 * If a specific type enforcement rule was defined for
 	 * this permission check, then use it.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

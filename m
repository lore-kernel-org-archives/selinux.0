Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3JKwY1l004032
 for <selinux@tycho.nsa.gov>; Tue, 19 Apr 2016 16:58:34 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BE85F3B707
 for <selinux@tycho.nsa.gov>; Tue, 19 Apr 2016 20:58:31 +0000 (UTC)
Subject: [PATCH] selinux: delay inode label lookup as long as possible
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Tue, 19 Apr 2016 16:58:30 -0400
Message-ID: <146109951077.27582.3768964432833439374.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

Since looking up an inode's label can result in revalidation, delay
the lookup as long as possible to limit the performance impact.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f8ecc0a..b09aad7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1790,7 +1790,6 @@ static int selinux_determine_inode_label(struct inode *dir,
 					 u32 *_new_isid)
 {
 	const struct superblock_security_struct *sbsec = dir->i_sb->s_security;
-	const struct inode_security_struct *dsec = inode_security(dir);
 	const struct task_security_struct *tsec = current_security();
 
 	if ((sbsec->flags & SE_SBINITIALIZED) &&
@@ -1800,6 +1799,7 @@ static int selinux_determine_inode_label(struct inode *dir,
 		   tsec->create_sid) {
 		*_new_isid = tsec->create_sid;
 	} else {
+		const struct inode_security_struct *dsec = inode_security(dir);
 		return security_transition_sid(tsec->sid, dsec->sid, tclass,
 					       name, _new_isid);
 	}
@@ -2084,7 +2084,7 @@ static int selinux_binder_transfer_file(struct task_struct *from,
 	u32 sid = task_sid(to);
 	struct file_security_struct *fsec = file->f_security;
 	struct dentry *dentry = file->f_path.dentry;
-	struct inode_security_struct *isec = backing_inode_security(dentry);
+	struct inode_security_struct *isec;
 	struct common_audit_data ad;
 	int rc;
 
@@ -2103,6 +2103,7 @@ static int selinux_binder_transfer_file(struct task_struct *from,
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
 
+	isec = backing_inode_security(dentry);
 	return avc_has_perm(sid, isec->sid, isec->sclass, file_to_av(file),
 			    &ad);
 }
@@ -3057,7 +3058,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags)
 {
 	struct inode *inode = d_backing_inode(dentry);
-	struct inode_security_struct *isec = backing_inode_security(dentry);
+	struct inode_security_struct *isec;
 	struct superblock_security_struct *sbsec;
 	struct common_audit_data ad;
 	u32 newsid, sid = current_sid();
@@ -3076,6 +3077,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 	ad.u.dentry = dentry;
 
+	isec = backing_inode_security(dentry);
 	rc = avc_has_perm(sid, isec->sid, isec->sclass,
 			  FILE__RELABELFROM, &ad);
 	if (rc)
@@ -3134,7 +3136,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 					int flags)
 {
 	struct inode *inode = d_backing_inode(dentry);
-	struct inode_security_struct *isec = backing_inode_security(dentry);
+	struct inode_security_struct *isec;
 	u32 newsid;
 	int rc;
 
@@ -3151,6 +3153,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 		return;
 	}
 
+	isec = backing_inode_security(dentry);
 	isec->sclass = inode_mode_to_security_class(inode->i_mode);
 	isec->sid = newsid;
 	isec->initialized = LABEL_INITIALIZED;
@@ -3192,7 +3195,7 @@ static int selinux_inode_getsecurity(struct inode *inode, const char *name, void
 	u32 size;
 	int error;
 	char *context = NULL;
-	struct inode_security_struct *isec = inode_security(inode);
+	struct inode_security_struct *isec;
 
 	if (strcmp(name, XATTR_SELINUX_SUFFIX))
 		return -EOPNOTSUPP;
@@ -3211,6 +3214,7 @@ static int selinux_inode_getsecurity(struct inode *inode, const char *name, void
 	if (!error)
 		error = cred_has_capability(current_cred(), CAP_MAC_ADMIN,
 					    SECURITY_CAP_NOAUDIT);
+	isec = inode_security(inode);
 	if (!error)
 		error = security_sid_to_context_force(isec->sid, &context,
 						      &size);
@@ -3320,7 +3324,7 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 	struct common_audit_data ad;
 	struct file_security_struct *fsec = file->f_security;
 	struct inode *inode = file_inode(file);
-	struct inode_security_struct *isec = inode_security(inode);
+	struct inode_security_struct *isec;
 	struct lsm_ioctlop_audit ioctl;
 	u32 ssid = cred_sid(cred);
 	int rc;
@@ -3344,6 +3348,7 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
 
+	isec = inode_security(inode);
 	rc = avc_has_extended_perms(ssid, isec->sid, isec->sclass,
 			requested, driver, xperm, &ad);
 out:
@@ -3745,18 +3750,18 @@ static int selinux_kernel_module_from_file(struct file *file)
 					SYSTEM__MODULE_LOAD, NULL);
 
 	/* finit_module */
+
 	ad.type = LSM_AUDIT_DATA_PATH;
 	ad.u.path = file->f_path;
 
-	isec = inode_security(file_inode(file));
 	fsec = file->f_security;
-
 	if (sid != fsec->sid) {
 		rc = avc_has_perm(sid, fsec->sid, SECCLASS_FD, FD__USE, &ad);
 		if (rc)
 			return rc;
 	}
 
+	isec = inode_security(file_inode(file));
 	return avc_has_perm(sid, isec->sid, SECCLASS_SYSTEM,
 				SYSTEM__MODULE_LOAD, &ad);
 }

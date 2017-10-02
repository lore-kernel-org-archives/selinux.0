From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, jmorris@namei.org, Stephen Smalley <sds@tycho.nsa.gov>
Date: Mon,  2 Oct 2017 11:58:21 -0400
Message-Id: <20171002155825.28620-7-sds@tycho.nsa.gov>
In-Reply-To: <20171002155825.28620-1-sds@tycho.nsa.gov>
References: <20171002155825.28620-1-sds@tycho.nsa.gov>
Subject: [RFC 06/10] selinux: introduce cred_selinux_ns() and use it
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When using the SID from a cred, we should pass the selinux
namespace associated with the cred on security server calls
rather than the current selinux namespace, since they could differ.
In some of these cases, the cred is always obtained from the current
task so there is no real change, but this is cleaner and hopefully
less fragile. In other cases, the cred could in fact differ.

Not-signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c            | 42 ++++++++++++++++++-------------------
 security/selinux/include/security.h |  2 ++
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f9c1e2c..efe8083 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -483,13 +483,13 @@ static int may_context_mount_sb_relabel(u32 sid,
 	const struct task_security_struct *tsec = cred->security;
 	int rc;
 
-	rc = avc_has_perm(current_selinux_ns,
+	rc = avc_has_perm(cred_selinux_ns(cred),
 			  tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(current_selinux_ns,
+	rc = avc_has_perm(cred_selinux_ns(cred),
 			  tsec->sid, sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELTO, NULL);
 	return rc;
@@ -501,13 +501,13 @@ static int may_context_mount_inode_relabel(u32 sid,
 {
 	const struct task_security_struct *tsec = cred->security;
 	int rc;
-	rc = avc_has_perm(current_selinux_ns,
+	rc = avc_has_perm(cred_selinux_ns(cred),
 			  tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(current_selinux_ns,
+	rc = avc_has_perm(cred_selinux_ns(cred),
 			  sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__ASSOCIATE, NULL);
 	return rc;
@@ -1793,10 +1793,10 @@ static int cred_has_capability(const struct cred *cred,
 		return -EINVAL;
 	}
 
-	rc = avc_has_perm_noaudit(current_selinux_ns,
+	rc = avc_has_perm_noaudit(cred_selinux_ns(cred),
 				  sid, sid, sclass, av, 0, &avd);
 	if (audit == SECURITY_CAP_AUDIT) {
-		int rc2 = avc_audit(current_selinux_ns,
+		int rc2 = avc_audit(cred_selinux_ns(cred),
 				    sid, sid, sclass, av, &avd, rc, &ad, 0);
 		if (rc2)
 			return rc2;
@@ -1823,7 +1823,7 @@ static int inode_has_perm(const struct cred *cred,
 	sid = cred_sid(cred);
 	isec = inode->i_security;
 
-	return avc_has_perm(current_selinux_ns,
+	return avc_has_perm(cred_selinux_ns(cred),
 			    sid, isec->sid, isec->sclass, perms, adp);
 }
 
@@ -1893,7 +1893,7 @@ static int file_has_perm(const struct cred *cred,
 	ad.u.file = file;
 
 	if (sid != fsec->sid) {
-		rc = avc_has_perm(current_selinux_ns,
+		rc = avc_has_perm(cred_selinux_ns(cred),
 				  sid, fsec->sid,
 				  SECCLASS_FD,
 				  FD__USE,
@@ -2101,7 +2101,7 @@ static int superblock_has_perm(const struct cred *cred,
 	u32 sid = cred_sid(cred);
 
 	sbsec = sb->s_security;
-	return avc_has_perm(current_selinux_ns,
+	return avc_has_perm(cred_selinux_ns(cred),
 			    sid, sbsec->sid, SECCLASS_FILESYSTEM, perms, ad);
 }
 
@@ -2282,7 +2282,7 @@ static int selinux_capset(struct cred *new, const struct cred *old,
 			  const kernel_cap_t *inheritable,
 			  const kernel_cap_t *permitted)
 {
-	return avc_has_perm(current_selinux_ns,
+	return avc_has_perm(cred_selinux_ns(old),
 			    cred_sid(old), cred_sid(new), SECCLASS_PROCESS,
 			    PROCESS__SETCAP, NULL);
 }
@@ -3122,7 +3122,7 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct inode *inode,
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
 
-	return avc_has_perm_flags(current_selinux_ns,
+	return avc_has_perm_flags(cred_selinux_ns(cred),
 				  sid, isec->sid, isec->sclass, FILE__READ, &ad,
 				  rcu ? MAY_NOT_BLOCK : 0);
 }
@@ -3178,7 +3178,7 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
 
-	rc = avc_has_perm_noaudit(current_selinux_ns,
+	rc = avc_has_perm_noaudit(cred_selinux_ns(cred),
 				  sid, isec->sid, isec->sclass, perms, 0, &avd);
 	audited = avc_audit_required(perms, &avd, rc,
 				     from_access ? FILE__AUDIT_ACCESS : 0,
@@ -3584,7 +3584,7 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 	ad.u.op->path = file->f_path;
 
 	if (ssid != fsec->sid) {
-		rc = avc_has_perm(current_selinux_ns,
+		rc = avc_has_perm(cred_selinux_ns(cred),
 				  ssid, fsec->sid,
 				SECCLASS_FD,
 				FD__USE,
@@ -3667,7 +3667,7 @@ static int file_map_prot_check(struct file *file, unsigned long prot, int shared
 		 * private file mapping that will also be writable.
 		 * This has an additional check.
 		 */
-		rc = avc_has_perm(current_selinux_ns,
+		rc = avc_has_perm(cred_selinux_ns(cred),
 				  sid, sid, SECCLASS_PROCESS,
 				  PROCESS__EXECMEM, NULL);
 		if (rc)
@@ -3743,14 +3743,14 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 		int rc = 0;
 		if (vma->vm_start >= vma->vm_mm->start_brk &&
 		    vma->vm_end <= vma->vm_mm->brk) {
-			rc = avc_has_perm(current_selinux_ns,
+			rc = avc_has_perm(cred_selinux_ns(cred),
 					  sid, sid, SECCLASS_PROCESS,
 					  PROCESS__EXECHEAP, NULL);
 		} else if (!vma->vm_file &&
 			   ((vma->vm_start <= vma->vm_mm->start_stack &&
 			     vma->vm_end >= vma->vm_mm->start_stack) ||
 			    vma_is_stack_for_current(vma))) {
-			rc = avc_has_perm(current_selinux_ns,
+			rc = avc_has_perm(cred_selinux_ns(cred),
 					  sid, sid, SECCLASS_PROCESS,
 					  PROCESS__EXECSTACK, NULL);
 		} else if (vma->vm_file && vma->anon_vma) {
@@ -3870,7 +3870,7 @@ static int selinux_file_open(struct file *file, const struct cred *cred)
 	 * struct as its SID.
 	 */
 	fsec->isid = isec->sid;
-	fsec->pseqno = avc_policy_seqno(current_selinux_ns);
+	fsec->pseqno = avc_policy_seqno(cred_selinux_ns(cred));
 	/*
 	 * Since the inode label or policy seqno may have changed
 	 * between the selinux_inode_permission check and the saving
@@ -3973,7 +3973,7 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
 	u32 sid = current_sid();
 	int ret;
 
-	ret = avc_has_perm(current_selinux_ns,
+	ret = avc_has_perm(tsec->ns,
 			   sid, secid,
 			   SECCLASS_KERNEL_SERVICE,
 			   KERNEL_SERVICE__USE_AS_OVERRIDE,
@@ -3998,7 +3998,7 @@ static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 	u32 sid = current_sid();
 	int ret;
 
-	ret = avc_has_perm(current_selinux_ns,
+	ret = avc_has_perm(tsec->ns,
 			   sid, isec->sid,
 			   SECCLASS_KERNEL_SERVICE,
 			   KERNEL_SERVICE__CREATE_FILES_AS,
@@ -4128,7 +4128,7 @@ int selinux_task_prlimit(const struct cred *cred, const struct cred *tcred,
 		av |= PROCESS__SETRLIMIT;
 	if (flags & LSM_PRLIMIT_READ)
 		av |= PROCESS__GETRLIMIT;
-	return avc_has_perm(current_selinux_ns,
+	return avc_has_perm(cred_selinux_ns(cred),
 			    cred_sid(cred), cred_sid(tcred),
 			    SECCLASS_PROCESS, av, NULL);
 }
@@ -6371,7 +6371,7 @@ static int selinux_key_permission(key_ref_t key_ref,
 	key = key_ref_to_ptr(key_ref);
 	ksec = key->security;
 
-	return avc_has_perm(current_selinux_ns,
+	return avc_has_perm(cred_selinux_ns(cred),
 			    sid, ksec->sid, SECCLASS_KEY, perm, NULL);
 }
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 246f9de..005d65c 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -146,6 +146,8 @@ struct task_security_struct {
 
 #define current_selinux_ns (((struct task_security_struct *)current_security())->ns)
 
+#define cred_selinux_ns(cred) (((struct task_security_struct *)(cred)->security)->ns)
+
 #define ss_initialized (current_selinux_ns->initialized)
 
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
-- 
2.9.5

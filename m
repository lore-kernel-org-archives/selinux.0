Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3RBvZRb027157
	for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 07:57:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i3RBt8W3011138
	for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 11:55:08 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i3RBt8Ix011135
	for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 11:55:08 GMT
Subject: [PATCH] Fix exec ptrace checking flaw in SELinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Cc: Russell Coker <russell@coker.com.au>, James Morris <jmorris@redhat.com>,
   Joshua Brindle <jbrindle@snu.edu>
Content-Type: text/plain
Message-Id: <1083067017.24445.48.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 27 Apr 2004 07:56:57 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

In looking again at the SELinux exec ptrace checking in response to the
recent fixes to the base/capability compute_creds logic, I realized that
there is an unrelated race in the SELinux exec ptrace checking code due
to the fact that parent process link is only updated after releasing the
task lock in ptrace_attach.  As a result, the exec ptrace checking may
use the wrong parent information and thereby allow a domain A to ptrace
another domain B in violation of policy, given suitable conditions.  For
example, if A and B are allowed by policy to ptrace themselves and to
each transition to each other, and a B->A parent-child relationship can
be arranged by A, then another process in A may be able to attach to the
child and continue ptracing across an exec by the child to domain B due
to erroneous check against the real parent (also in B) rather than the
tracer (in A) before the parent link is updated.  Example scenario would
be for B to be newrole or su, except that the domains for these programs
are not allowed to ptrace by the example policy, so even the erroneous
check against the real parent would be denied in those cases.
 
This patch against 2.6.6-rc2-mm2 (which includes the other recent fixes
to compute_creds) fixes this race condition in SELinux by saving the
security context of the tracer at the time of ptrace_attach and using
the saved context in the exec ptrace checking in
compute_creds/apply_creds.  The patch is also now in Linus' Bitkeeper
tree.  The fix is similar to how the existing capability logic performs
the CAP_SYS_PTRACE check at the time of ptrace_attach and saves the
result via a task ptrace flag for later use in the exec ptrace checking,
but differs in that only the tracer security context is saved at the
time of ptrace_attach and the permission check is still performed during
exec to preserve the fine-grained process-to-process check (Can process
A ptrace process B?) of SELinux rather than using a global privilege
(Can process A ptrace all processes other than init?) as in the
capability model.

 security/selinux/hooks.c          |   17 +++++++++++--
 security/selinux/include/objsec.h |    1 +
 2 files changed, 12 insertions(+), 6 deletions(-)

-- linux-2.6/security/selinux/include/objsec.h.orig	2004-04-26 12:05:14.000000000 -0400
+++ linux-2.6/security/selinux/include/objsec.h	2004-04-26 12:05:43.000000000 -0400
@@ -34,6 +34,7 @@
 	u32 exec_sid;        /* exec SID */
 	u32 create_sid;      /* fscreate SID */
         struct avc_entry_ref avcr;     /* reference to process permissions */
+	u32 ptrace_sid;      /* SID of ptrace parent */
 };
 
 struct inode_security_struct {
-- linux-2.6/security/selinux/hooks.c.orig	2004-04-26 12:04:06.000000000 -0400
+++ linux-2.6/security/selinux/hooks.c	2004-04-26 12:21:59.716631610 -0400
@@ -119,7 +119,7 @@
 	memset(tsec, 0, sizeof(struct task_security_struct));
 	tsec->magic = SELINUX_MAGIC;
 	tsec->task = task;
-	tsec->osid = tsec->sid = SECINITSID_UNLABELED;
+	tsec->osid = tsec->sid = tsec->ptrace_sid = SECINITSID_UNLABELED;
 	task->security = tsec;
 
 	return 0;
@@ -1332,13 +1332,19 @@
 
 static int selinux_ptrace(struct task_struct *parent, struct task_struct *child)
 {
+	struct task_security_struct *psec = parent->security;
+	struct task_security_struct *csec = child->security;
 	int rc;
 
 	rc = secondary_ops->ptrace(parent,child);
 	if (rc)
 		return rc;
 
-	return task_has_perm(parent, child, PROCESS__PTRACE);
+	rc = task_has_perm(parent, child, PROCESS__PTRACE);
+	/* Save the SID of the tracing process for later use in apply_creds. */
+	if (!rc)
+		csec->ptrace_sid = psec->sid;
+	return rc;
 }
 
 static int selinux_capget(struct task_struct *target, kernel_cap_t *effective,
@@ -1748,7 +1754,7 @@
 
 static void selinux_bprm_apply_creds(struct linux_binprm *bprm, int unsafe)
 {
-	struct task_security_struct *tsec, *psec;
+	struct task_security_struct *tsec;
 	struct bprm_security_struct *bsec;
 	u32 sid;
 	struct av_decision avd;
@@ -1783,14 +1789,13 @@
 		/* Check for ptracing, and update the task SID if ok.
 		   Otherwise, leave SID unchanged and kill. */
 		if (unsafe & (LSM_UNSAFE_PTRACE | LSM_UNSAFE_PTRACE_CAP)) {
-			psec = current->parent->security;
-			rc = avc_has_perm_noaudit(psec->sid, sid,
+			rc = avc_has_perm_noaudit(tsec->ptrace_sid, sid,
 					  SECCLASS_PROCESS, PROCESS__PTRACE,
 					  NULL, &avd);
 			if (!rc)
 				tsec->sid = sid;
 			task_unlock(current);
-			avc_audit(psec->sid, sid, SECCLASS_PROCESS,
+			avc_audit(tsec->ptrace_sid, sid, SECCLASS_PROCESS,
 				  PROCESS__PTRACE, &avd, rc, NULL);
 			if (rc) {
 				force_sig_specific(SIGKILL, current);

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

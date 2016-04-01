Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u32Ievoo024784
 for <selinux@tycho.nsa.gov>; Sat, 2 Apr 2016 14:41:05 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A2CC58051D
 for <selinux@tycho.nsa.gov>; Fri,  1 Apr 2016 20:23:48 +0000 (UTC)
Subject: [PATCH] selinux: consolidate the ptrace parent lookup code
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Fri, 01 Apr 2016 16:23:47 -0400
Message-ID: <145954222742.26745.4617901757833366253.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

We lookup the tracing parent in two places, using effectively the
same code, let's consolidate it.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c |   38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 837c566..ac0c72d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2229,6 +2229,20 @@ static int selinux_vm_enough_memory(struct mm_struct *mm, long pages)
 
 /* binprm security operations */
 
+static u32 ptrace_parent_sid(struct task_struct *task)
+{
+	u32 sid = 0;
+	struct task_struct *tracer;
+
+	rcu_read_lock();
+	tracer = ptrace_parent(task);
+	if (tracer)
+		sid = task_sid(tracer);
+	rcu_read_unlock();
+
+	return sid;
+}
+
 static int check_nnp_nosuid(const struct linux_binprm *bprm,
 			    const struct task_security_struct *old_tsec,
 			    const struct task_security_struct *new_tsec)
@@ -2350,18 +2364,7 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 		 * changes its SID has the appropriate permit */
 		if (bprm->unsafe &
 		    (LSM_UNSAFE_PTRACE | LSM_UNSAFE_PTRACE_CAP)) {
-			struct task_struct *tracer;
-			struct task_security_struct *sec;
-			u32 ptsid = 0;
-
-			rcu_read_lock();
-			tracer = ptrace_parent(current);
-			if (likely(tracer != NULL)) {
-				sec = __task_cred(tracer)->security;
-				ptsid = sec->sid;
-			}
-			rcu_read_unlock();
-
+			u32 ptsid = ptrace_parent_sid(current);
 			if (ptsid != 0) {
 				rc = avc_has_perm(ptsid, new_tsec->sid,
 						  SECCLASS_PROCESS,
@@ -5677,7 +5680,6 @@ static int selinux_setprocattr(struct task_struct *p,
 			       char *name, void *value, size_t size)
 {
 	struct task_security_struct *tsec;
-	struct task_struct *tracer;
 	struct cred *new;
 	u32 sid = 0, ptsid;
 	int error;
@@ -5784,14 +5786,8 @@ static int selinux_setprocattr(struct task_struct *p,
 
 		/* Check for ptracing, and update the task SID if ok.
 		   Otherwise, leave SID unchanged and fail. */
-		ptsid = 0;
-		rcu_read_lock();
-		tracer = ptrace_parent(p);
-		if (tracer)
-			ptsid = task_sid(tracer);
-		rcu_read_unlock();
-
-		if (tracer) {
+		ptsid = ptrace_parent_sid(p);
+		if (ptsid != 0) {
 			error = avc_has_perm(ptsid, sid, SECCLASS_PROCESS,
 					     PROCESS__PTRACE, NULL);
 			if (error)

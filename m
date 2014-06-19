From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v2] selinux: Permit exec transitions under NO_NEW_PRIVS or
 NOSUID under certain circumstances.
Date: Thu, 19 Jun 2014 16:04:18 -0400
Message-ID: <2612411.5tyaPs4jv0@sifl>
In-Reply-To: <5399FF80.604@tycho.nsa.gov>
References: <5399FD14.60101@tycho.nsa.gov>
 <CALCETrVbD3NxxhJsjiAGcEE-5yjH34+BijTHrOFiefwotu6krA@mail.gmail.com>
 <5399FF80.604@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: SELinux-NSA <SELinux@tycho.nsa.gov>, Andy Lutomirski <luto@amacapital.net>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, June 12, 2014 03:29:04 PM Stephen Smalley wrote:
> v2 - fix patch description to match the code.

Okay Stephen, I suppose you should get some special consideration, but is 
posting your patches inline really that hard :)

---
>From c1fa21950c5c3eb0dd97ae5145fa3d3f04adc5c4 Mon Sep 17 00:00:00 2001
From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Thu, 12 Jun 2014 08:17:48 -0400
Subject: [PATCH] selinux:  Permit exec transitions under NO_NEW_PRIVS or
 NOSUID under certain circumstances.

If the callee SID is bounded by the caller SID or if the caller SID is allowed
to perform a dynamic transition (setcon) to the callee SID, then allowing
the transition to occur poses no risk of privilege escalation and we can
therefore safely allow the transition to occur.  Add these two exemptions
for both the case where a transition was explicitly requested by the
application and the case where an automatic transition is defined in
policy.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Andy Lutomirski <luto@amacapital.net>
---
 security/selinux/hooks.c | 54 
+++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 83d06db..d5e8dc5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2086,6 +2086,36 @@ static int selinux_vm_enough_memory(struct mm_struct 
*mm, long pages)
 
 /* binprm security operations */
 
+static int check_nnp_nosuid(const struct linux_binprm *bprm,
+			    const struct task_security_struct *old_tsec,
+			    const struct task_security_struct *new_tsec)
+{
+	int nnp = (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS);
+	int nosuid = (bprm->file->f_path.mnt->mnt_flags & MNT_NOSUID);
+	int rc;
+
+	if (!nnp && !nosuid)
+		return 0; /* neither NNP nor nosuid */
+
+	if (new_tsec->sid == old_tsec->sid)
+		return 0; /* No change in credentials */
+
+	rc = security_bounded_transition(old_tsec->sid, new_tsec->sid);
+	if (rc == 0)
+		return 0; /* allowed via bounded transition */
+
+	/* Only allow if dyntransition permission aka setcon() is allowed. */
+	rc = avc_has_perm(old_tsec->sid, new_tsec->sid, SECCLASS_PROCESS,
+			  PROCESS__DYNTRANSITION, NULL);
+	if (rc) {
+		if (nnp)
+			return -EPERM;
+		else
+			return -EACCES;
+	}
+	return 0;
+}
+
 static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 {
 	const struct task_security_struct *old_tsec;
@@ -2122,14 +2152,10 @@ static int selinux_bprm_set_creds(struct linux_binprm 
*bprm)
 		/* Reset exec SID on execve. */
 		new_tsec->exec_sid = 0;
 
-		/*
-		 * Minimize confusion: if no_new_privs or nosuid and a
-		 * transition is explicitly requested, then fail the exec.
-		 */
-		if (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS)
-			return -EPERM;
-		if (bprm->file->f_path.mnt->mnt_flags & MNT_NOSUID)
-			return -EACCES;
+		/* Fail on NNP or nosuid if not an allowed transition. */
+		rc = check_nnp_nosuid(bprm, old_tsec, new_tsec);
+		if (rc)
+			return rc;
 	} else {
 		/* Check for a default transition on this program. */
 		rc = security_transition_sid(old_tsec->sid, isec->sid,
@@ -2137,15 +2163,19 @@ static int selinux_bprm_set_creds(struct linux_binprm 
*bprm)
 					     &new_tsec->sid);
 		if (rc)
 			return rc;
+
+		/*
+		 * Fallback to old SID on NNP or nosuid if not an allowed
+		 * transition.
+		 */
+		rc = check_nnp_nosuid(bprm, old_tsec, new_tsec);
+		if (rc)
+			new_tsec->sid = old_tsec->sid;
 	}
 
 	ad.type = LSM_AUDIT_DATA_PATH;
 	ad.u.path = bprm->file->f_path;
 
-	if ((bprm->file->f_path.mnt->mnt_flags & MNT_NOSUID) ||
-	    (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS))
-		new_tsec->sid = old_tsec->sid;
-
 	if (new_tsec->sid == old_tsec->sid) {
 		rc = avc_has_perm(old_tsec->sid, isec->sid,
 				  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
-- 
1.8.3.1

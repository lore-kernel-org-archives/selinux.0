Subject: [RFC PATCH] selinux: prevent setting a security label on MNT_NOSUID
 applications
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Wed, 14 May 2014 11:58:07 -0400
Message-ID: <20140514155807.32072.32113.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: sds@tycho.nsa.gov, luto@amacapital.net
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

We presently prevent processes from explicitly setting an arbitrary
security label on new processes when NO_NEW_PRIVS is enabled; in an
attempt for more consistency, this patch extends this to prevent
setting an arbitrary label when the new application lives on a
filesystem mounted with MNT_NOSUID.

Signed-off-by: Paul Moore <pmoore@redhat.com>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 57b0b49..6fafe86 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2106,11 +2106,13 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 		new_tsec->exec_sid = 0;
 
 		/*
-		 * Minimize confusion: if no_new_privs and a transition is
-		 * explicitly requested, then fail the exec.
+		 * Minimize confusion: if no_new_privs or nosuid and a
+		 * transition is explicitly requested, then fail the exec.
 		 */
 		if (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS)
 			return -EPERM;
+		if (bprm->file->f_path.mnt->mnt_flags & MNT_NOSUID)
+			return -EACCES;
 	} else {
 		/* Check for a default transition on this program. */
 		rc = security_transition_sid(old_tsec->sid, isec->sid,

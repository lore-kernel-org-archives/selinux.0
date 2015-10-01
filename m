From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: bigon@debian.org, dwalsh@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 2/3] policycoreutils/newrole: Set keepcaps around setresuid
 calls.
Date: Thu,  1 Oct 2015 15:51:30 -0400
Message-Id: <1443729091-9496-2-git-send-email-sds@tycho.nsa.gov>
In-Reply-To: <1443729091-9496-1-git-send-email-sds@tycho.nsa.gov>
References: <1443729091-9496-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Set the "keep capabilities" flag around the setresuid() calls in
drop_capabilities() so that we do not simultaneously drop all
capabilities (when newrole is setuid).

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policycoreutils/newrole/newrole.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index 55e8d39..af7198d 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -548,11 +548,22 @@ static int drop_capabilities(int full)
 	capng_setpid(getpid());
 	capng_clear(CAPNG_SELECT_CAPS);
 
+	if (prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0) < 0) {
+		fprintf(stderr, _("Error resetting KEEPCAPS, aborting\n"));
+		return -1;
+	}
+
 	/* Change uid */
 	if (setresuid(uid, uid, uid)) {
 		fprintf(stderr, _("Error changing uid, aborting.\n"));
 		return -1;
 	}
+
+	if (prctl(PR_SET_KEEPCAPS, 0, 0, 0, 0) < 0) {
+		fprintf(stderr, _("Error resetting KEEPCAPS, aborting\n"));
+		return -1;
+	}
+
 	if (! full) 
 		capng_update(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED, CAP_AUDIT_WRITE);
 	return capng_apply(CAPNG_SELECT_CAPS);
@@ -579,11 +590,22 @@ static int drop_capabilities(int full)
 	capng_setpid(getpid());
 	capng_clear(CAPNG_SELECT_CAPS);
 
+	if (prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0) < 0) {
+		fprintf(stderr, _("Error resetting KEEPCAPS, aborting\n"));
+		return -1;
+	}
+
 	/* Change uid */
 	if (setresuid(uid, uid, uid)) {
 		fprintf(stderr, _("Error changing uid, aborting.\n"));
 		return -1;
 	}
+
+	if (prctl(PR_SET_KEEPCAPS, 0, 0, 0, 0) < 0) {
+		fprintf(stderr, _("Error resetting KEEPCAPS, aborting\n"));
+		return -1;
+	}
+
 	if (! full) 
 		capng_updatev(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED, CAP_SYS_ADMIN , CAP_FOWNER , CAP_CHOWN, CAP_DAC_OVERRIDE, CAP_AUDIT_WRITE, -1);
 	
-- 
2.1.0

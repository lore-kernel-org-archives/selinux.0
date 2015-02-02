From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] libselinux: Only check SELinux enabled status once in
 selinux_check_access().
Date: Mon,  2 Feb 2015 15:37:25 -0500
Message-Id: <1422909446-9142-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Move the SELinux enabled check to the once handler so that we do
not perform this on each call to selinux_check_access().  Reduces
overhead in both the SELinux-enabled and the SELinux-disabled cases.

Extracted from the Android external/libselinux tree.

Change-Id: I61fe85bc04fe53cbf840ba712c81bdb06e4e0c2f
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/checkAccess.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
index ee85ebc..29be16e 100644
--- a/libselinux/src/checkAccess.c
+++ b/libselinux/src/checkAccess.c
@@ -8,10 +8,13 @@
 #include "avc_internal.h"
 
 static pthread_once_t once = PTHREAD_ONCE_INIT;
+static int selinux_enabled;
 
 static void avc_init_once(void)
 {
-	avc_open(NULL, 0);
+	selinux_enabled = is_selinux_enabled();
+	if (selinux_enabled == 1)
+		avc_open(NULL, 0);
 }
 
 int selinux_check_access(const char *scon, const char *tcon, const char *class, const char *perm, void *aux) {
@@ -21,11 +24,11 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
 	security_class_t sclass;
 	access_vector_t av;
 
-	if (is_selinux_enabled() == 0)
-		return 0;
-
 	__selinux_once(once, avc_init_once);
 
+	if (selinux_enabled != 1)
+		return 0;
+
 	rc = avc_context_to_sid(scon, &scon_id);
 	if (rc < 0)
 		return rc;
-- 
1.9.3

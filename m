Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r8PFqUja011894
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2013 11:52:36 -0400
Received: by mail-wg0-f46.google.com with SMTP id k14so6225188wgh.13
        for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2013 08:52:33 -0700 (PDT)
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: [PATCH 5/5] Current stable policycoreutils requires selinux_current_policy_path
Date: Wed, 25 Sep 2013 17:52:02 +0200
Message-Id: <1380124322-32745-6-git-send-email-sven.vermeulen@siphos.be>
In-Reply-To: <1380124322-32745-1-git-send-email-sven.vermeulen@siphos.be>
References: <1380124322-32745-1-git-send-email-sven.vermeulen@siphos.be>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Without this fix, stolen from Fedora's patchset, recent policycoreutils
just fails.

See http://marc.info/?t=136926404600001&r=1&w=2 and
see http://marc.info/?l=selinux&m=136692033821285&w=2

Signed-off-by: Sven Vermeulen <sven.vermeulen@siphos.be>
---
 libselinux/include/selinux/selinux.h             |  1 +
 libselinux/man/man3/selinux_binary_policy_path.3 |  7 ++++++-
 libselinux/src/selinux_config.c                  | 23 +++++++++++++++++++++++
 libselinux/src/selinux_internal.h                |  1 +
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index a4079aa..82954c2 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -498,6 +498,7 @@ extern const char *selinux_policy_root(void);
 
 /* These functions return the paths to specific files under the 
    policy root directory. */
+extern const char *selinux_current_policy_path(void);
 extern const char *selinux_binary_policy_path(void);
 extern const char *selinux_failsafe_context_path(void);
 extern const char *selinux_removable_context_path(void);
diff --git a/libselinux/man/man3/selinux_binary_policy_path.3 b/libselinux/man/man3/selinux_binary_policy_path.3
index ec97dcf..503c52c 100644
--- a/libselinux/man/man3/selinux_binary_policy_path.3
+++ b/libselinux/man/man3/selinux_binary_policy_path.3
@@ -1,6 +1,6 @@
 .TH "selinux_binary_policy_path" "3" "15 November 2004" "dwalsh@redhat.com" "SELinux API Documentation"
 .SH "NAME"
-selinux_path, selinux_policy_root, selinux_binary_policy_path,
+selinux_path, selinux_policy_root, selinux_binary_policy_path, selinux_current_policy_path,
 selinux_failsafe_context_path, selinux_removable_context_path,
 selinux_default_context_path, selinux_user_contexts_path,
 selinux_file_context_path, selinux_media_context_path,
@@ -17,6 +17,8 @@ directories and files
 .sp
 .B const char *selinux_binary_policy_path(void);
 .sp
+.B const char *selinux_current_policy_path(void);
+.sp
 .B const char *selinux_failsafe_context_path(void);
 .sp
 .B const char *selinux_removable_context_path(void);
@@ -55,6 +57,9 @@ returns the top-level policy directory.
 .BR selinux_binary_policy_path ()
 returns the binary policy file loaded into kernel.
 .sp
+.BR selinux_current_policy_path ()
+returns the currently loaded policy file from the kernel.
+.sp
 .BR selinux_default_type_path ()
 returns the context file mapping roles to default types.
 .sp
diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index 296f357..29b6d40 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -8,6 +8,7 @@
 #include <limits.h>
 #include <unistd.h>
 #include <pthread.h>
+#include "policy.h"
 #include "selinux_internal.h"
 #include "get_default_type_internal.h"
 
@@ -303,6 +304,28 @@ const char *selinux_binary_policy_path(void)
 
 hidden_def(selinux_binary_policy_path)
 
+const char *selinux_current_policy_path(void)
+{
+	int rc = 0;
+	int vers = 0;
+	static char policy_path[PATH_MAX];
+
+	snprintf(policy_path, sizeof(policy_path), "%s/policy", selinux_mnt);
+	if (access(policy_path, F_OK) == 0) {
+		vers = security_policyvers();
+		do {
+			/* Check prior versions to see if old policy is available */
+			snprintf(policy_path, sizeof(policy_path), "%s.%d",
+				selinux_binary_policy_path(), vers);
+		} while ((rc = access(policy_path, F_OK)) && --vers > 0);
+
+		if (rc) return NULL;
+	}
+	return policy_path;
+}
+
+hidden_def(selinux_current_policy_path)
+
 const char *selinux_file_context_path(void)
 {
 	return get_path(FILE_CONTEXTS);
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 2c7c85c..4a4aebc 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -60,6 +60,7 @@ hidden_proto(selinux_mkload_policy)
     hidden_proto(security_setenforce)
     hidden_proto(security_deny_unknown)
     hidden_proto(selinux_boolean_sub)
+    hidden_proto(selinux_current_policy_path)
     hidden_proto(selinux_binary_policy_path)
     hidden_proto(selinux_booleans_subs_path)
     hidden_proto(selinux_default_context_path)
-- 
1.8.1.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

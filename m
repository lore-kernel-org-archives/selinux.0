Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9KFM1am005287
	for <selinux@tycho.nsa.gov>; Tue, 20 Oct 2009 11:22:01 -0400
Received: from columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n9KFL8k7007945
	for <selinux@tycho.nsa.gov>; Tue, 20 Oct 2009 15:21:08 GMT
From: Chad Sellers <csellers@tresys.com>
To: selinux@tycho.nsa.gov
Cc: method@manicmethod.com, slawrence@tresys.com,
        Chad Sellers <csellers@tresys.com>
Subject: [PATCH] libselinux: Export reset_selinux_config()
Date: Tue, 20 Oct 2009 11:21:59 -0400
Message-Id: <1256052119-23845-1-git-send-email-csellers@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In integrating SELinux policy into rpm, we have a need to be
able to reset the configuration data (e.g. policy type) loaded
into libselinux. These values are currently loaded lazily by a
number of different functions (e.g. matchpatchcon_init()).
Since we are changing rpm to install policy, including initial
base policy, we need to be able to reload these configuration
items after the policy has been installed.

reset_selinux_config() already exists and is used by
selinux_init_load_policy() for a similar reason, but it is not
exported. This was probably intentionaly since it is not thread
safe at all. That said, rpm needs to do the same thing. This
patch makes the function public, and places a warning in the
header comment that it is not thread safe.

Signed-off-by:  Chad Sellers <csellers@tresys.com>
---
 libselinux/include/selinux/selinux.h |    7 +++++++
 libselinux/src/load_policy.c         |    2 +-
 libselinux/src/selinux_config.c      |    4 +++-
 libselinux/src/selinux_internal.h    |    2 +-
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 56f7900..cacb3cb 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -568,6 +568,13 @@ extern int selinux_file_context_verify(const char *path, mode_t mode);
 /* This function sets the file context on to the system defaults returns 0 on success */
 extern int selinux_lsetfilecon_default(const char *path);
 
+/* 
+ * Force a reset of the loaded configuration
+ * WARNING: This is not thread safe. Be very sure that no other threads
+ * are calling into libselinux when this is called.
+ */
+extern void selinux_reset_config(void);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index a7800da..36ce029 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -320,7 +320,7 @@ int selinux_init_load_policy(int *enforce)
 	 * Example:  Caller has chroot'd and is now loading policy from
 	 * chroot'd environment.
 	 */
-	reset_selinux_config();
+	selinux_reset_config();
 
 	/*
 	 * Get desired mode (disabled, permissive, enforcing) from 
diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index af8731c..7e588cc 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -230,12 +230,14 @@ static void fini_selinux_policyroot(void)
 	selinux_policytype = NULL;
 }
 
-void reset_selinux_config(void)
+void selinux_reset_config(void)
 {
 	fini_selinux_policyroot();
 	init_selinux_config();
 }
 
+hidden_def(selinux_reset_config)
+
 static const char *get_path(int idx)
 {
 	__selinux_once(once, init_selinux_config);
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 7a2c1ad..88b6bd6 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -88,8 +88,8 @@ hidden_proto(selinux_trans_to_raw_context);
     hidden_proto(selinux_raw_context_to_color);
 hidden_proto(security_get_initial_context);
 hidden_proto(security_get_initial_context_raw);
+hidden_proto(selinux_reset_config);
 
-extern void reset_selinux_config(void) hidden;
 extern int load_setlocaldefs hidden;
 extern int require_seusers hidden;
 extern int selinux_page_size hidden;
-- 
1.6.2.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

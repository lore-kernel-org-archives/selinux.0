Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u636M874017946
 for <selinux@tycho.nsa.gov>; Sun, 3 Jul 2016 02:22:08 -0400
Received: by mail-pa0-f66.google.com with SMTP id lm4so1905056pab.3
 for <selinux@tycho.nsa.gov>; Sat, 02 Jul 2016 23:22:06 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: Add openrc_contexts functions
Date: Sun,  3 Jul 2016 14:22:02 +0800
Message-Id: <1467526922-19922-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 libselinux/src/file_path_suffixes.h |  1 +
 libselinux/src/selinux_config.c     | 10 +++++++++-
 libselinux/src/selinux_internal.h   |  1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/file_path_suffixes.h b/libselinux/src/file_path_suffixes.h
index 95b228b..2d3ca49 100644
--- a/libselinux/src/file_path_suffixes.h
+++ b/libselinux/src/file_path_suffixes.h
@@ -23,6 +23,7 @@ S_(BINPOLICY, "/policy/policy")
     S_(VIRTUAL_DOMAIN, "/contexts/virtual_domain_context")
     S_(VIRTUAL_IMAGE, "/contexts/virtual_image_context")
     S_(LXC_CONTEXTS, "/contexts/lxc_contexts")
+    S_(OPENRC_CONTEXTS, "/contexts/openrc_contexts")
     S_(OPENSSH_CONTEXTS, "/contexts/openssh_contexts")
     S_(SNAPPERD_CONTEXTS, "/contexts/snapperd_contexts")
     S_(SYSTEMD_CONTEXTS, "/contexts/systemd_contexts")
diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index c519a77..88bcc85 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -51,7 +51,8 @@
 #define OPENSSH_CONTEXTS  28
 #define SYSTEMD_CONTEXTS  29
 #define SNAPPERD_CONTEXTS 30
-#define NEL               31
+#define OPENRC_CONTEXTS   31
+#define NEL               32
 
 /* Part of one-time lazy init */
 static pthread_once_t once = PTHREAD_ONCE_INIT;
@@ -493,6 +494,13 @@ const char *selinux_lxc_contexts_path(void)
 
 hidden_def(selinux_lxc_contexts_path)
 
+const char *selinux_openrc_contexts_path(void)
+{
+    return get_path(OPENRC_CONTEXTS);
+}
+
+hidden_def(selinux_openrc_contexts_path)
+
 const char *selinux_openssh_contexts_path(void)
 {
     return get_path(OPENSSH_CONTEXTS);
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 9b9145c..3d5c9fb 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -83,6 +83,7 @@ hidden_proto(selinux_mkload_policy)
     hidden_proto(selinux_media_context_path)
     hidden_proto(selinux_x_context_path)
     hidden_proto(selinux_sepgsql_context_path)
+    hidden_proto(selinux_openrc_contexts_path)
     hidden_proto(selinux_openssh_contexts_path)
     hidden_proto(selinux_snapperd_contexts_path)
     hidden_proto(selinux_systemd_contexts_path)
-- 
2.7.3

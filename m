Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7BDYMQq003481
	for <selinux@tycho.nsa.gov>; Fri, 11 Aug 2006 09:34:22 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k7BDY47f019158
	for <selinux@tycho.nsa.gov>; Fri, 11 Aug 2006 13:34:04 GMT
Subject: [PATCH 1/3] Separate local file contexts into file_contexts.local
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 09:34:28 -0400
Message-Id: <1155303268.8722.62.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds paths to libselinux for the file_contexts.local, and for
completeness, also file_contexts.homedir.

 libselinux/include/selinux/selinux.h |    2 ++
 libselinux/src/file_path_suffixes.h  |    2 ++
 libselinux/src/selinux_config.c      |   18 +++++++++++++++++-
 libselinux/src/selinux_internal.h    |    2 ++
 libselinux/src/selinuxswig.i         |    2 ++
 5 files changed, 25 insertions(+), 1 deletion(-)

diff --exclude .svn -urN trunk/libselinux/include/selinux/selinux.h fc-local-fix/libselinux/include/selinux/selinux.h
--- trunk/libselinux/include/selinux/selinux.h	2006-08-03 11:01:12.429812000 -0400
+++ fc-local-fix/libselinux/include/selinux/selinux.h	2006-08-10 10:10:19.407091750 -0400
@@ -390,6 +390,8 @@
 	extern const char *selinux_default_context_path(void);
 	extern const char *selinux_user_contexts_path(void);
 	extern const char *selinux_file_context_path(void);
+	extern const char *selinux_file_context_homedir_path(void);
+	extern const char *selinux_file_context_local_path(void);
 	extern const char *selinux_homedir_context_path(void);
 	extern const char *selinux_media_context_path(void);
 	extern const char *selinux_contexts_path(void);
diff --exclude .svn -urN trunk/libselinux/src/file_path_suffixes.h fc-local-fix/libselinux/src/file_path_suffixes.h
--- trunk/libselinux/src/file_path_suffixes.h	2006-08-03 11:01:12.429812000 -0400
+++ fc-local-fix/libselinux/src/file_path_suffixes.h	2006-08-10 10:10:19.407091750 -0400
@@ -15,3 +15,5 @@
     S_(SEUSERS, "/seusers")
     S_(TRANSLATIONS, "/setrans.conf")
     S_(NETFILTER_CONTEXTS, "/contexts/netfilter_contexts")
+    S_(FILE_CONTEXTS_HOMEDIR, "/contexts/files/file_contexts.homedir")
+    S_(FILE_CONTEXTS_LOCAL, "/contexts/files/file_contexts.local")
diff --exclude .svn -urN trunk/libselinux/src/selinux_config.c fc-local-fix/libselinux/src/selinux_config.c
--- trunk/libselinux/src/selinux_config.c	2006-08-03 11:01:12.429812000 -0400
+++ fc-local-fix/libselinux/src/selinux_config.c	2006-08-10 10:10:19.483096500 -0400
@@ -36,7 +36,9 @@
 #define SEUSERS           13
 #define TRANSLATIONS      14
 #define NETFILTER_CONTEXTS    15
-#define NEL               16
+#define FILE_CONTEXTS_HOMEDIR 16
+#define FILE_CONTEXTS_LOCAL 17
+#define NEL               18
 
 /* New layout is relative to SELINUXDIR/policytype. */
 static char *file_paths[NEL];
@@ -392,3 +394,17 @@
 }
 
 hidden_def(selinux_netfilter_context_path)
+
+const char *selinux_file_context_homedir_path()
+{
+	return get_path(FILE_CONTEXTS_HOMEDIR);
+}
+
+hidden_def(selinux_file_context_homedir_path)
+
+const char *selinux_file_context_local_path()
+{
+	return get_path(FILE_CONTEXTS_LOCAL);
+}
+
+hidden_def(selinux_file_context_local_path)
diff --exclude .svn -urN trunk/libselinux/src/selinux_internal.h fc-local-fix/libselinux/src/selinux_internal.h
--- trunk/libselinux/src/selinux_internal.h	2006-08-03 11:01:12.429812000 -0400
+++ fc-local-fix/libselinux/src/selinux_internal.h	2006-08-10 10:10:19.483096500 -0400
@@ -54,6 +54,8 @@
     hidden_proto(selinux_failsafe_context_path)
     hidden_proto(selinux_removable_context_path)
     hidden_proto(selinux_file_context_path)
+    hidden_proto(selinux_file_context_homedir_path)
+    hidden_proto(selinux_file_context_local_path)
     hidden_proto(selinux_netfilter_context_path)
     hidden_proto(selinux_homedir_context_path)
     hidden_proto(selinux_user_contexts_path)
diff --exclude .svn -urN trunk/libselinux/src/selinuxswig.i fc-local-fix/libselinux/src/selinuxswig.i
--- trunk/libselinux/src/selinuxswig.i	2006-08-03 11:01:12.429812000 -0400
+++ fc-local-fix/libselinux/src/selinuxswig.i	2006-08-09 15:26:12.731938000 -0400
@@ -99,6 +99,8 @@
 extern const char *selinux_default_context_path(void);
 extern const char *selinux_user_contexts_path(void);
 extern const char *selinux_file_context_path(void);
+extern const char *selinux_file_context_homedir_path(void);
+extern const char *selinux_file_context_local_path(void);
 extern const char *selinux_homedir_context_path(void);
 extern const char *selinux_media_context_path(void);
 extern const char *selinux_contexts_path(void);


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

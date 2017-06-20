Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5KE7VhA007848
 for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2017 10:07:37 -0400
From: Patrick Steinhardt <ps@pks.im>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/3] libsepol: replace non-standard use of __BEGIN_DECLS
Date: Tue, 20 Jun 2017 16:07:01 +0200
Message-Id: <2327ff9fc6746fe9aaff982154d6a1863bd1dd67.1497967444.git.ps@pks.im>
In-Reply-To: <cover.1497967444.git.ps@pks.im>
References: <cover.1497967444.git.ps@pks.im>
In-Reply-To: <cover.1497967444.git.ps@pks.im>
References: <cover.1497967444.git.ps@pks.im>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

While most header files already use the common pattern of `extern "C"`
declarations to enable compiling in a C++ project, some header files in
libsepol instead use the macros `__BEGIN_DECLS` and `__END_DECLS`. These
macros are defined in the "sys/cdefs.h" header file, which provides
some non-standard extensions for glibc.

Convert usage of these declarations with the standard `extern "C"`
pattern. This improves compatibility with other libc implementations,
e.g. musl libc.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 libsepol/include/sepol/ibendport_record.h | 10 +++++++---
 libsepol/include/sepol/ibendports.h       | 11 ++++++++---
 libsepol/include/sepol/ibpkey_record.h    | 11 ++++++++---
 libsepol/include/sepol/ibpkeys.h          | 12 +++++++++---
 4 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/libsepol/include/sepol/ibendport_record.h b/libsepol/include/sepol/ibendport_record.h
index e30b252d..2a37ec63 100644
--- a/libsepol/include/sepol/ibendport_record.h
+++ b/libsepol/include/sepol/ibendport_record.h
@@ -4,9 +4,10 @@
 #include <stddef.h>
 #include <sepol/context_record.h>
 #include <sepol/handle.h>
-#include <sys/cdefs.h>
 
-__BEGIN_DECLS
+#ifdef __cplusplus
+extern "C" {
+#endif
 
 struct sepol_ibendport;
 struct sepol_ibendport_key;
@@ -64,5 +65,8 @@ extern int sepol_ibendport_clone(sepol_handle_t *handle,
 
 extern void sepol_ibendport_free(sepol_ibendport_t *ibendport);
 
-__END_DECLS
+#ifdef __cplusplus
+}
+#endif
+
 #endif
diff --git a/libsepol/include/sepol/ibendports.h b/libsepol/include/sepol/ibendports.h
index 4a89e0ca..4ad77a12 100644
--- a/libsepol/include/sepol/ibendports.h
+++ b/libsepol/include/sepol/ibendports.h
@@ -4,9 +4,10 @@
 #include <sepol/handle.h>
 #include <sepol/policydb.h>
 #include <sepol/ibendport_record.h>
-#include <sys/cdefs.h>
 
-__BEGIN_DECLS
+#ifdef __cplusplus
+extern "C" {
+#endif
 
 /* Return the number of ibendports */
 extern int sepol_ibendport_count(sepol_handle_t *handle,
@@ -41,5 +42,9 @@ extern int sepol_ibendport_iterate(sepol_handle_t *handle,
 				   int (*fn)(const sepol_ibendport_t *ibendport,
 					     void *fn_arg), void *arg);
 
-__END_DECLS
+
+#ifdef __cplusplus
+}
+#endif
+
 #endif
diff --git a/libsepol/include/sepol/ibpkey_record.h b/libsepol/include/sepol/ibpkey_record.h
index ab68147c..1511785d 100644
--- a/libsepol/include/sepol/ibpkey_record.h
+++ b/libsepol/include/sepol/ibpkey_record.h
@@ -5,11 +5,12 @@
 #include <stdint.h>
 #include <sepol/context_record.h>
 #include <sepol/handle.h>
-#include <sys/cdefs.h>
 
 #define INET6_ADDRLEN 16
 
-__BEGIN_DECLS
+#ifdef __cplusplus
+extern "C" {
+#endif
 
 struct sepol_ibpkey;
 struct sepol_ibpkey_key;
@@ -71,5 +72,9 @@ extern int sepol_ibpkey_clone(sepol_handle_t *handle,
 
 extern void sepol_ibpkey_free(sepol_ibpkey_t *ibpkey);
 
-__END_DECLS
+
+#ifdef __cplusplus
+}
+#endif
+
 #endif
diff --git a/libsepol/include/sepol/ibpkeys.h b/libsepol/include/sepol/ibpkeys.h
index 4ab0a8a6..4b69d1e9 100644
--- a/libsepol/include/sepol/ibpkeys.h
+++ b/libsepol/include/sepol/ibpkeys.h
@@ -4,9 +4,11 @@
 #include <sepol/handle.h>
 #include <sepol/policydb.h>
 #include <sepol/ibpkey_record.h>
-#include <sys/cdefs.h>
 
-__BEGIN_DECLS
+
+#ifdef __cplusplus
+extern "C" {
+#endif
 
 /* Return the number of ibpkeys */
 extern int sepol_ibpkey_count(sepol_handle_t *handle,
@@ -40,5 +42,9 @@ extern int sepol_ibpkey_iterate(sepol_handle_t *handle,
 				int (*fn)(const sepol_ibpkey_t *ibpkey,
 					  void *fn_arg), void *arg);
 
-__END_DECLS
+
+#ifdef __cplusplus
+}
+#endif
+
 #endif
-- 
2.13.1

Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3FDqDnQ011192
 for <selinux@tycho.nsa.gov>; Wed, 15 Apr 2015 09:52:13 -0400
From: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH] libsepol: Don't use symbol versioning for static object files
Date: Wed, 15 Apr 2015 09:51:42 -0400
Message-ID: <1429105902-7284-1-git-send-email-ykhodorkovskiy@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Libraries such as libqpol that link with libsepol statically do not understand
the symbolic versioning in libsepol. This patch disables the symbolic versioning
in libsepol if building the static library or building for Android.

Signed-off-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
---
 libsepol/cil/src/cil.c       | 21 +++++++++++----------
 libsepol/{ => cil}/src/dso.h |  4 ++++
 libsepol/src/dso.h           |  4 ++++
 3 files changed, 19 insertions(+), 10 deletions(-)
 copy libsepol/{ => cil}/src/dso.h (89%)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index b852628..5c53bf3 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -50,8 +50,9 @@
 #include "cil_binary.h"
 #include "cil_policy.h"
 #include "cil_strpool.h"
+#include "dso.h"
 
-#ifndef ANDROID
+#ifndef DISABLE_SYMVER
 asm(".symver cil_build_policydb_pdb,        cil_build_policydb@");
 asm(".symver cil_build_policydb_create_pdb, cil_build_policydb@@LIBSEPOL_1.1");
 
@@ -354,7 +355,7 @@ exit:
 	return rc;
 }
 
-#ifdef ANDROID
+#ifdef DISABLE_SYMVER
 int cil_compile(struct cil_db *db)
 #else
 int cil_compile_nopdb(struct cil_db *db)
@@ -402,7 +403,7 @@ exit:
 	return rc;
 }
 
-#ifndef ANDROID
+#ifndef DISABLE_SYMVER
 int cil_compile_pdb(struct cil_db *db, __attribute__((unused)) sepol_policydb_t *sepol_db)
 {
 	return cil_compile_nopdb(db);
@@ -424,7 +425,7 @@ exit:
 }
 #endif
 
-#ifdef ANDROID
+#ifdef DISABLE_SYMVER
 int cil_build_policydb(cil_db_t *db, sepol_policydb_t **sepol_db)
 #else
 int cil_build_policydb_create_pdb(cil_db_t *db, sepol_policydb_t **sepol_db)
@@ -1116,7 +1117,7 @@ const char * cil_node_to_string(struct cil_tree_node *node)
 	return "<unknown>";
 }
 
-#ifdef ANDROID
+#ifdef DISABLE_SYMVER
 int cil_userprefixes_to_string(struct cil_db *db, char **out, size_t *size)
 #else
 int cil_userprefixes_to_string_nopdb(struct cil_db *db, char **out, size_t *size)
@@ -1165,7 +1166,7 @@ exit:
 
 }
 
-#ifndef ANDROID
+#ifndef DISABLE_SYMVER
 int cil_userprefixes_to_string_pdb(struct cil_db *db, __attribute__((unused)) sepol_policydb_t *sepol_db, char **out, size_t *size)
 {
 	return cil_userprefixes_to_string_nopdb(db, out, size);
@@ -1357,7 +1358,7 @@ static int __cil_level_to_string(struct cil_level *lvl, char *out)
 	return str_tmp - out;
 }
 
-#ifdef ANDROID
+#ifdef DISABLE_SYMVER
 int cil_selinuxusers_to_string(struct cil_db *db, char **out, size_t *size)
 #else
 int cil_selinuxusers_to_string_nopdb(struct cil_db *db, char **out, size_t *size)
@@ -1418,14 +1419,14 @@ int cil_selinuxusers_to_string_nopdb(struct cil_db *db, char **out, size_t *size
 	return SEPOL_OK;
 }
 
-#ifndef ANDROID
+#ifndef DISABLE_SYMVER
 int cil_selinuxusers_to_string_pdb(struct cil_db *db, __attribute__((unused)) sepol_policydb_t *sepol_db, char **out, size_t *size)
 {
 	return cil_selinuxusers_to_string_nopdb(db, out, size);
 }
 #endif
 
-#ifdef ANDROID
+#ifdef DISABLE_SYMVER
 int cil_filecons_to_string(struct cil_db *db, char **out, size_t *size)
 #else
 int cil_filecons_to_string_nopdb(struct cil_db *db, char **out, size_t *size)
@@ -1547,7 +1548,7 @@ int cil_filecons_to_string_nopdb(struct cil_db *db, char **out, size_t *size)
 	return SEPOL_OK;
 }
 
-#ifndef ANDROID
+#ifndef DISABLE_SYMVER
 int cil_filecons_to_string_pdb(struct cil_db *db, __attribute__((unused)) sepol_policydb_t *sepol_db, char **out, size_t *size)
 {
 	return cil_filecons_to_string_nopdb(db, out, size);
diff --git a/libsepol/src/dso.h b/libsepol/cil/src/dso.h
similarity index 89%
copy from libsepol/src/dso.h
copy to libsepol/cil/src/dso.h
index 5c69aae..a06e349 100644
--- a/libsepol/src/dso.h
+++ b/libsepol/cil/src/dso.h
@@ -1,6 +1,10 @@
 #ifndef _SEPOL_DSO_H
 #define _SEPOL_DSO_H	1
 
+#if !defined(SHARED) || defined(ANDROID)
+    #define DISABLE_SYMVER 1
+#endif
+
 #ifdef SHARED
 # define hidden __attribute__ ((visibility ("hidden")))
 # define hidden_proto(fct) __hidden_proto (fct, fct##_internal)
diff --git a/libsepol/src/dso.h b/libsepol/src/dso.h
index 5c69aae..a06e349 100644
--- a/libsepol/src/dso.h
+++ b/libsepol/src/dso.h
@@ -1,6 +1,10 @@
 #ifndef _SEPOL_DSO_H
 #define _SEPOL_DSO_H	1
 
+#if !defined(SHARED) || defined(ANDROID)
+    #define DISABLE_SYMVER 1
+#endif
+
 #ifdef SHARED
 # define hidden __attribute__ ((visibility ("hidden")))
 # define hidden_proto(fct) __hidden_proto (fct, fct##_internal)
-- 
1.9.3

From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov, slawrence@tresys.com
Subject: [PATCH v2] libsepol:  Fix build for Android.
Date: Thu,  2 Apr 2015 11:36:23 -0400
Message-Id: <1427988983-4202-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The Android build does not like the symbol versioning introduced
by commit 8147bc7; the build fails with:
host SharedLib: libsepol (out/host/linux-x86/obj/lib/libsepol.so)
prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8//x86_64-linux/bin/ld: error: symbol cil_build_policydb has undefined version
prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8//x86_64-linux/bin/ld: error: symbol cil_build_policydb has undefined version LIBSEPOL_1.1
clang: error: linker command failed with exit code 1 (use -v to see invocation)

Drop the compatibility interfaces and the symbol versioning and only
build the current API when building on Android.

Also export the libsepol headers for use in building secilc since it has
moved outside of libsepol.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsepol/Android.mk    |  3 +++
 libsepol/cil/src/cil.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/libsepol/Android.mk b/libsepol/Android.mk
index 3e4700b..6168224 100644
--- a/libsepol/Android.mk
+++ b/libsepol/Android.mk
@@ -62,6 +62,7 @@ cil_src_files := \
 	cil/src/cil_verify.c
 
 common_cflags := \
+	-D_ANDROID_ \
 	-Wall -W -Wundef \
 	-Wshadow -Wmissing-noreturn \
 	-Wmissing-format-attribute
@@ -89,6 +90,8 @@ include $(CLEAR_VARS)
 
 LOCAL_MODULE := libsepol
 LOCAL_MODULE_TAGS := optional
+LOCAL_COPY_HEADERS_TO := sepol
+LOCAL_COPY_HEADERS := include/sepol/handle.h include/sepol/policydb.h cil/include/cil/cil.h
 LOCAL_C_INCLUDES := $(common_includes) 
 LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
 LOCAL_SRC_FILES := $(common_src_files) $(cil_src_files)
diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 1594be6..614e066 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -51,6 +51,7 @@
 #include "cil_policy.h"
 #include "cil_strpool.h"
 
+#ifndef _ANDROID_
 asm(".symver cil_build_policydb_pdb,        cil_build_policydb@");
 asm(".symver cil_build_policydb_create_pdb, cil_build_policydb@@LIBSEPOL_1.1");
 
@@ -65,6 +66,7 @@ asm(".symver cil_selinuxusers_to_string_nopdb, cil_selinuxusers_to_string@@LIBSE
 
 asm(".symver cil_filecons_to_string_pdb,   cil_filecons_to_string@");
 asm(".symver cil_filecons_to_string_nopdb, cil_filecons_to_string@@LIBSEPOL_1.1");
+#endif
 
 int cil_sym_sizes[CIL_SYM_ARRAY_NUM][CIL_SYM_NUM] = {
 	{64, 64, 64, 1 << 13, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64},
@@ -352,7 +354,11 @@ exit:
 	return rc;
 }
 
+#ifdef _ANDROID_
+int cil_compile(struct cil_db *db)
+#else
 int cil_compile_nopdb(struct cil_db *db)
+#endif
 {
 	int rc = SEPOL_ERR;
 
@@ -396,6 +402,7 @@ exit:
 	return rc;
 }
 
+#ifndef _ANDROID_
 int cil_compile_pdb(struct cil_db *db, __attribute__((unused)) sepol_policydb_t *sepol_db)
 {
 	return cil_compile_nopdb(db);
@@ -415,8 +422,13 @@ int cil_build_policydb_pdb(cil_db_t *db, sepol_policydb_t *sepol_db)
 exit:
 	return rc;
 }
+#endif
 
+#ifdef _ANDROID_
+int cil_build_policydb(cil_db_t *db, sepol_policydb_t **sepol_db)
+#else
 int cil_build_policydb_create_pdb(cil_db_t *db, sepol_policydb_t **sepol_db)
+#endif
 {
 	int rc;
 
@@ -1104,7 +1116,11 @@ const char * cil_node_to_string(struct cil_tree_node *node)
 	return "<unknown>";
 }
 
+#ifdef _ANDROID_
+int cil_userprefixes_to_string(struct cil_db *db, char **out, size_t *size)
+#else
 int cil_userprefixes_to_string_nopdb(struct cil_db *db, char **out, size_t *size)
+#endif
 {
 	int rc = SEPOL_ERR;
 	size_t str_len = 0;
@@ -1149,10 +1165,12 @@ exit:
 
 }
 
+#ifndef _ANDROID_
 int cil_userprefixes_to_string_pdb(struct cil_db *db, __attribute__((unused)) sepol_policydb_t *sepol_db, char **out, size_t *size)
 {
 	return cil_userprefixes_to_string_nopdb(db, out, size);
 }
+#endif
 
 static int cil_cats_to_ebitmap(struct cil_cats *cats, struct ebitmap* cats_ebitmap)
 {
@@ -1339,7 +1357,11 @@ static int __cil_level_to_string(struct cil_level *lvl, char *out)
 	return str_tmp - out;
 }
 
+#ifdef _ANDROID_
+int cil_selinuxusers_to_string(struct cil_db *db, char **out, size_t *size)
+#else
 int cil_selinuxusers_to_string_nopdb(struct cil_db *db, char **out, size_t *size)
+#endif
 {
 	size_t str_len = 0;
 	int buf_pos = 0;
@@ -1396,12 +1418,18 @@ int cil_selinuxusers_to_string_nopdb(struct cil_db *db, char **out, size_t *size
 	return SEPOL_OK;
 }
 
+#ifndef _ANDROID_
 int cil_selinuxusers_to_string_pdb(struct cil_db *db, __attribute__((unused)) sepol_policydb_t *sepol_db, char **out, size_t *size)
 {
 	return cil_selinuxusers_to_string_nopdb(db, out, size);
 }
+#endif
 
+#ifdef _ANDROID_
+int cil_filecons_to_string(struct cil_db *db, char **out, size_t *size)
+#else
 int cil_filecons_to_string_nopdb(struct cil_db *db, char **out, size_t *size)
+#endif
 {
 	uint32_t i = 0;
 	int buf_pos = 0;
@@ -1519,10 +1547,12 @@ int cil_filecons_to_string_nopdb(struct cil_db *db, char **out, size_t *size)
 	return SEPOL_OK;
 }
 
+#ifndef _ANDROID_
 int cil_filecons_to_string_pdb(struct cil_db *db, __attribute__((unused)) sepol_policydb_t *sepol_db, char **out, size_t *size)
 {
 	return cil_filecons_to_string_nopdb(db, out, size);
 }
+#endif
 
 void cil_set_disable_dontaudit(struct cil_db *db, int disable_dontaudit)
 {
-- 
1.9.3

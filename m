From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsepol:  Fix build for Android.
Date: Thu,  2 Apr 2015 11:00:08 -0400
Message-Id: <1427986808-845-1-git-send-email-sds@tycho.nsa.gov>
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

The simplest fix appears to be to just drop the symver entries when
building on Android.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsepol/Android.mk    | 1 +
 libsepol/cil/src/cil.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/libsepol/Android.mk b/libsepol/Android.mk
index 3e4700b..f84b0d7 100644
--- a/libsepol/Android.mk
+++ b/libsepol/Android.mk
@@ -62,6 +62,7 @@ cil_src_files := \
 	cil/src/cil_verify.c
 
 common_cflags := \
+	-D_ANDROID_ \
 	-Wall -W -Wundef \
 	-Wshadow -Wmissing-noreturn \
 	-Wmissing-format-attribute
diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 1594be6..c13e8a4 100644
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
-- 
1.9.3

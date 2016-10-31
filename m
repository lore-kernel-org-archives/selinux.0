Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9VFqbkL001250
 for <selinux@tycho.nsa.gov>; Mon, 31 Oct 2016 11:52:37 -0400
Received: by mail-pf0-f194.google.com with SMTP id n85so9060184pfi.3
 for <selinux@tycho.nsa.gov>; Mon, 31 Oct 2016 08:52:32 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsepol: Add symver with explicit version to build with
 ld.gold
Date: Mon, 31 Oct 2016 23:52:27 +0800
Message-Id: <1477929147-18929-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The blank default symver fails to compile with ld.gold. This updates the
symver from blank to LIBSEPOL_1.0. The dynamic linker will first look
for the symbol with the explicit version specified. If there is none, it
will pick the first listed symbol so there is no breakage.
This also matches how symvers are defined in libsemanage.

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 libsepol/cil/src/cil.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 929ab19..9b18773 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -53,19 +53,19 @@
 #include "dso.h"
 
 #ifndef DISABLE_SYMVER
-asm(".symver cil_build_policydb_pdb,        cil_build_policydb@");
+asm(".symver cil_build_policydb_pdb,        cil_build_policydb@LIBSEPOL_1.0");
 asm(".symver cil_build_policydb_create_pdb, cil_build_policydb@@LIBSEPOL_1.1");
 
-asm(".symver cil_compile_pdb,   cil_compile@");
+asm(".symver cil_compile_pdb,   cil_compile@LIBSEPOL_1.0");
 asm(".symver cil_compile_nopdb, cil_compile@@LIBSEPOL_1.1");
 
-asm(".symver cil_userprefixes_to_string_pdb,   cil_userprefixes_to_string@");
+asm(".symver cil_userprefixes_to_string_pdb,   cil_userprefixes_to_string@LIBSEPOL_1.0");
 asm(".symver cil_userprefixes_to_string_nopdb, cil_userprefixes_to_string@@LIBSEPOL_1.1");
 
-asm(".symver cil_selinuxusers_to_string_pdb,   cil_selinuxusers_to_string@");
+asm(".symver cil_selinuxusers_to_string_pdb,   cil_selinuxusers_to_string@LIBSEPOL_1.0");
 asm(".symver cil_selinuxusers_to_string_nopdb, cil_selinuxusers_to_string@@LIBSEPOL_1.1");
 
-asm(".symver cil_filecons_to_string_pdb,   cil_filecons_to_string@");
+asm(".symver cil_filecons_to_string_pdb,   cil_filecons_to_string@LIBSEPOL_1.0");
 asm(".symver cil_filecons_to_string_nopdb, cil_filecons_to_string@@LIBSEPOL_1.1");
 #endif
 
-- 
2.7.3

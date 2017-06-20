Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5KEGDBJ011062
 for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2017 10:16:13 -0400
From: Patrick Steinhardt <ps@pks.im>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/3] libselinux: fix error when FORTIFY_SOURCE is already set
Date: Tue, 20 Jun 2017 16:07:02 +0200
Message-Id: <8e3ba217e8ac1d93dc438e8ce08ae8557eb94e8f.1497967444.git.ps@pks.im>
In-Reply-To: <cover.1497967444.git.ps@pks.im>
References: <cover.1497967444.git.ps@pks.im>
In-Reply-To: <cover.1497967444.git.ps@pks.im>
References: <cover.1497967444.git.ps@pks.im>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Two makefiles of ours pass `-D_FORTIFY_SOURCE` directly to the
preprocessor. While this does not pose any problems when the value has
not been previously set, it can break the build if it is part of the
standard build flags.

Fix the issue by undefining the flag with `-Wp,-U_FORTIFY_SOURCE` right
before redefining the value. This fixes builds with some hardened
compiler chains.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 libselinux/src/Makefile   | 3 ++-
 libselinux/utils/Makefile | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 4306dd0e..010b7ffe 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -59,7 +59,8 @@ ifeq ($(COMPILER), gcc)
 EXTRA_CFLAGS = -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -Wsync-nand \
 	-Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const \
 	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init \
-	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -Wp,-D_FORTIFY_SOURCE=2
+	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const \
+	-Wp,-U_FORTIFY_SOURCE -Wp,-D_FORTIFY_SOURCE=2
 else
 EXTRA_CFLAGS = -Wunused-command-line-argument
 endif
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 474ee95b..c94d7cf2 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -32,7 +32,8 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
           -Wformat-extra-args -Wformat-zero-length -Wformat=2 -Wmultichar \
           -Woverflow -Wpointer-to-int-cast -Wpragmas \
           -Wno-missing-field-initializers -Wno-sign-compare \
-          -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) -Wp,-D_FORTIFY_SOURCE=2 \
+          -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) \
+          -Wp,-U_FORTIFY_SOURCE -Wp,-D_FORTIFY_SOURCE=2 \
           -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions \
           -fasynchronous-unwind-tables -fdiagnostics-show-option -funit-at-a-time \
           -Werror -Wno-aggregate-return -Wno-redundant-decls \
-- 
2.13.1

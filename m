From: Patrick Steinhardt <ps@pks.im>
To: selinux@tycho.nsa.gov
Cc: Patrick Steinhardt <ps@pks.im>, Stephen Smalley <sds@tycho.nsa.gov>,
 Jason Zaman <jason@perfinion.com>, Petr Lautrbach <plautrba@redhat.com>,
 Daniel J Walsh <dwalsh@redhat.com>
Subject: [PATCH v2 1/2] libselinux: avoid redefining _FORTIFY_SOURCE
Date: Thu, 22 Jun 2017 11:45:57 +0200
Message-Id: <c3aaa64ce2545f7359e67f22069a5149aecfd5c9.1498124363.git.ps@pks.im>
In-Reply-To: <cover.1498124363.git.ps@pks.im>
References: <cover.1498124363.git.ps@pks.im>
In-Reply-To: <cover.1498124363.git.ps@pks.im>
References: <cover.1497967444.git.ps@pks.im> <cover.1498124363.git.ps@pks.im>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Two makefiles of ours pass `-D_FORTIFY_SOURCE=2` directly to the
preprocessor. While this does not pose any problems when the value has
not been previously set, it can break the build if it is part of the
standard build flags.

The issue can easily be fixed by instead defining `_FORTIFY_SOURCE`
without specifying a concrete value. In this case, gcc will not error
out and simply keep using the previously defined value. On the other
hand, if no value has been defined, we will now compile with
`_FORTIFY_SOURCE=1`. From feature_test_macros(7):

    If _FORTIFY_SOURCE is set to 1, with compiler optimization level 1
    (gcc -O1) and above, checks that shouldn't change the behavior of
    conforming programs are performed.  With _FORTIFY_SOURCE set to 2,
    some more checking is added, but some conforming programs might
    fail.

While this leaves us with less checks for buffer overflows, it will only
enable checks that should not change behaviour of conforming programs.
With _FORTIFY_SOURCE=2, the compiler may even unintentionally change
behaviour of conforming programs. So in fact, one could even argue that
we should only be setting the value to 1 anyway to avoid surprising side
effects.

So this patch changes our CFLAGS to only pass `-D_FORTIFY_SOURCE`
without any concrete value, fixing the build issue.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 libselinux/src/Makefile   | 2 +-
 libselinux/utils/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 4306dd0e..ea912609 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -59,7 +59,7 @@ ifeq ($(COMPILER), gcc)
 EXTRA_CFLAGS = -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -Wsync-nand \
 	-Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const \
 	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init \
-	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -Wp,-D_FORTIFY_SOURCE=2
+	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -Wp,-D_FORTIFY_SOURCE
 else
 EXTRA_CFLAGS = -Wunused-command-line-argument
 endif
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 843b0e7c..eb4851a9 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -32,7 +32,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
           -Wformat-extra-args -Wformat-zero-length -Wformat=2 -Wmultichar \
           -Woverflow -Wpointer-to-int-cast -Wpragmas \
           -Wno-missing-field-initializers -Wno-sign-compare \
-          -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) -Wp,-D_FORTIFY_SOURCE=2 \
+          -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) -Wp,-D_FORTIFY_SOURCE \
           -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions \
           -fasynchronous-unwind-tables -fdiagnostics-show-option -funit-at-a-time \
           -Werror -Wno-aggregate-return -Wno-redundant-decls \
-- 
2.13.1

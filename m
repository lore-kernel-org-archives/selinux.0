From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: jwcart2@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: Fix CFLAGS definition
Date: Tue,  9 May 2017 10:54:38 -0400
Message-Id: <20170509145438.22346-1-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

commit 16c123f4b1f3c8d20b3f597df161d7e635620923 ("libselinux:
support ANDROID_HOST=1 on Mac") split up warning flags in
CFLAGS based on compiler support in a manner that could lead to
including a subset that is invalid, e.g. upon
make DESTDIR=/path/to/dest install.  Fix it.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/Makefile   | 21 +++++++++++----------
 libselinux/utils/Makefile | 17 +++++++++--------
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index f1b8bd9..4306dd0 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -55,6 +55,15 @@ SRCS= $(filter-out $(GENERATED) audit2why.c, $(sort $(wildcard *.c)))
 
 MAX_STACK_SIZE=32768
 
+ifeq ($(COMPILER), gcc)
+EXTRA_CFLAGS = -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -Wsync-nand \
+	-Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const \
+	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init \
+	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -Wp,-D_FORTIFY_SOURCE=2
+else
+EXTRA_CFLAGS = -Wunused-command-line-argument
+endif
+
 OBJS= $(patsubst %.c,%.o,$(SRCS))
 LOBJS= $(patsubst %.c,%.lo,$(SRCS))
 CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissing-include-dirs \
@@ -72,19 +81,11 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
           -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) \
           -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions \
           -fasynchronous-unwind-tables -fdiagnostics-show-option -funit-at-a-time \
-          -Werror -Wno-aggregate-return -Wno-redundant-decls
+          -Werror -Wno-aggregate-return -Wno-redundant-decls \
+          $(EXTRA_CFLAGS)
 
 LD_SONAME_FLAGS=-soname,$(LIBSO),-z,defs,-z,relro
 
-ifeq ($(COMPILER), gcc)
-CFLAGS += -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -Wsync-nand \
-	-Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const \
-	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init \
-	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -Wp,-D_FORTIFY_SOURCE=2
-else
-CFLAGS += -Wunused-command-line-argument
-endif
-
 ifeq ($(OS), Darwin)
 override CFLAGS += -I/opt/local/include
 override LDFLAGS += -L/opt/local/lib -undefined dynamic_lookup
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 5d61031..14f94bd 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -12,6 +12,13 @@ else
 COMPILER ?= clang
 endif
 
+ifeq ($(COMPILER), gcc)
+EXTRA_CFLAGS = -fipa-pure-const -Wpacked-bitfield-compat -Wsync-nand -Wcoverage-mismatch \
+	-Wcpp -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const \
+	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init \
+	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const
+endif
+
 MAX_STACK_SIZE=8192
 CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissing-include-dirs \
           -Wunused -Wunknown-pragmas -Wstrict-aliasing -Wshadow -Wpointer-arith \
@@ -28,17 +35,11 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
           -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) -Wp,-D_FORTIFY_SOURCE=2 \
           -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions \
           -fasynchronous-unwind-tables -fdiagnostics-show-option -funit-at-a-time \
-          -Werror -Wno-aggregate-return -Wno-redundant-decls
+          -Werror -Wno-aggregate-return -Wno-redundant-decls \
+          $(EXTRA_CFLAGS)
 
 LD_SONAME_FLAGS=-soname,$(LIBSO),-z,defs,-z,relro
 
-ifeq ($(COMPILER), gcc)
-CFLAGS += -fipa-pure-const -Wpacked-bitfield-compat -Wsync-nand -Wcoverage-mismatch \
-	-Wcpp -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const \
-	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init \
-	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const
-endif
-
 ifeq ($(OS), Darwin)
 override CFLAGS += -I/opt/local/include -I../../libsepol/include
 override LDFLAGS += -L../../libsepol/src -undefined dynamic_lookup
-- 
2.9.3

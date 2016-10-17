From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: [PATCH 6/8] libselinux: support ANDROID_HOST=1 on Mac
Date: Mon, 17 Oct 2016 16:24:08 -0400
Message-Id: <1476735850-7844-6-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1476735850-7844-1-git-send-email-william.c.roberts@intel.com>
References: <1476735850-7844-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

To build on mac, first build libsepol with
DISABLE_CIL=y and no DESTDIR set.

Secondly, build libselinux with ANDROID_HOST=y

This configuration can be used to test the Android
host build on Mac.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/Makefile       | 10 ++++++++++
 libselinux/src/Makefile   | 36 ++++++++++++++++++++++++++----------
 libselinux/utils/Makefile | 29 +++++++++++++++++++++--------
 3 files changed, 57 insertions(+), 18 deletions(-)

diff --git a/libselinux/Makefile b/libselinux/Makefile
index baa0db3..ef971f4 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -27,6 +27,16 @@ else
 endif
 export PCRE_CFLAGS PCRE_LDFLAGS
 
+OS := $(shell uname)
+export OS
+
+ifeq ($(shell $(CC) -v 2>&1 | grep "clang"),)
+COMPILER := gcc
+else
+COMPILER := clang
+endif
+export COMPILER
+
 all install relabel clean distclean indent:
 	@for subdir in $(SUBDIRS); do \
 		(cd $$subdir && $(MAKE) $@) || exit 1; \
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 13501cd..7a1ae05 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -48,23 +48,39 @@ OBJS= $(patsubst %.c,%.o,$(SRCS))
 LOBJS= $(patsubst %.c,%.lo,$(SRCS))
 CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissing-include-dirs \
           -Wunused -Wunknown-pragmas -Wstrict-aliasing -Wshadow -Wpointer-arith \
-          -Wbad-function-cast -Wcast-align -Wwrite-strings -Wlogical-op -Waggregate-return \
+          -Wbad-function-cast -Wcast-align -Wwrite-strings -Waggregate-return \
           -Wstrict-prototypes -Wold-style-definition -Wmissing-prototypes \
           -Wmissing-declarations -Wmissing-noreturn -Wmissing-format-attribute \
           -Wredundant-decls -Wnested-externs -Winline -Winvalid-pch -Wvolatile-register-var \
-          -Wdisabled-optimization -Wbuiltin-macro-redefined -Wpacked-bitfield-compat \
-          -Wsync-nand -Wattributes -Wcoverage-mismatch -Wmultichar -Wcpp \
+          -Wdisabled-optimization -Wbuiltin-macro-redefined \
+          -Wattributes -Wmultichar \
           -Wdeprecated-declarations -Wdiv-by-zero -Wdouble-promotion -Wendif-labels -Wextra \
-          -Wformat-contains-nul -Wformat-extra-args -Wformat-zero-length -Wformat=2 -Wmultichar \
-          -Wnormalized=nfc -Woverflow -Wpointer-to-int-cast -Wpragmas -Wsuggest-attribute=const \
-          -Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines \
-          -Wno-missing-field-initializers -Wno-sign-compare -Wjump-misses-init \
-          -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) -Wp,-D_FORTIFY_SOURCE=2 \
+          -Wformat-extra-args -Wformat-zero-length -Wformat=2 -Wmultichar \
+          -Woverflow -Wpointer-to-int-cast -Wpragmas \
+          -Wno-missing-field-initializers -Wno-sign-compare \
+          -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) \
           -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions \
           -fasynchronous-unwind-tables -fdiagnostics-show-option -funit-at-a-time \
-          -fipa-pure-const -Wno-suggest-attribute=pure -Wno-suggest-attribute=const \
           -Werror -Wno-aggregate-return -Wno-redundant-decls
 
+LD_SONAME_FLAGS=-soname,$(LIBSO),-z,defs,-z,relro
+
+ifeq ($(COMPILER), gcc)
+override CFLAGS += -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -Wsync-nand \
+	-Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const \
+	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init \
+	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -Wp,-D_FORTIFY_SOURCE=2
+else
+override CFLAGS += -Wunused-command-line-argument
+override LDFLAGS += -L/opt/local/lib -undefined dynamic_lookup
+LD_SONAME_FLAGS=-install_name,$(LIBSO)
+endif
+
+ifeq ($(OS), Darwin)
+override CFLAGS += -I/opt/local/include
+override LDFLAGS += -L/opt/local/lib -undefined dynamic_lookup
+endif
+
 PCRE_LDFLAGS ?= -lpcre
 
 override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
@@ -117,7 +133,7 @@ $(LIBA): $(OBJS)
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(CFLAGS) -shared -o $@ $^ $(PCRE_LDFLAGS) -ldl $(LDFLAGS) -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
+	$(CC) $(CFLAGS) -shared -o $@ $^ $(PCRE_LDFLAGS) -ldl $(LDFLAGS) -L$(LIBDIR) -Wl,$(LD_SONAME_FLAGS)
 	ln -sf $@ $(TARGET) 
 
 $(LIBPC): $(LIBPC).in ../VERSION
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index e56a953..a4f9903 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -8,22 +8,35 @@ INCLUDEDIR ?= $(PREFIX)/include
 MAX_STACK_SIZE=8192
 CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissing-include-dirs \
           -Wunused -Wunknown-pragmas -Wstrict-aliasing -Wshadow -Wpointer-arith \
-          -Wbad-function-cast -Wcast-align -Wwrite-strings -Wlogical-op -Waggregate-return \
+          -Wbad-function-cast -Wcast-align -Wwrite-strings -Waggregate-return \
           -Wstrict-prototypes -Wold-style-definition -Wmissing-prototypes \
           -Wmissing-declarations -Wmissing-noreturn -Wmissing-format-attribute \
           -Wredundant-decls -Wnested-externs -Winline -Winvalid-pch -Wvolatile-register-var \
-          -Wdisabled-optimization -Wbuiltin-macro-redefined -Wpacked-bitfield-compat \
-          -Wsync-nand -Wattributes -Wcoverage-mismatch -Wmultichar -Wcpp \
+          -Wdisabled-optimization -Wbuiltin-macro-redefined \
+          -Wattributes -Wmultichar \
           -Wdeprecated-declarations -Wdiv-by-zero -Wdouble-promotion -Wendif-labels -Wextra \
-          -Wformat-contains-nul -Wformat-extra-args -Wformat-zero-length -Wformat=2 -Wmultichar \
-          -Wnormalized=nfc -Woverflow -Wpointer-to-int-cast -Wpragmas -Wsuggest-attribute=const \
-          -Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines \
-          -Wno-missing-field-initializers -Wno-sign-compare -Wjump-misses-init \
+          -Wformat-extra-args -Wformat-zero-length -Wformat=2 -Wmultichar \
+          -Woverflow -Wpointer-to-int-cast -Wpragmas \
+          -Wno-missing-field-initializers -Wno-sign-compare \
           -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) -Wp,-D_FORTIFY_SOURCE=2 \
           -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions \
           -fasynchronous-unwind-tables -fdiagnostics-show-option -funit-at-a-time \
-          -fipa-pure-const -Wno-suggest-attribute=pure -Wno-suggest-attribute=const \
           -Werror -Wno-aggregate-return -Wno-redundant-decls
+
+LD_SONAME_FLAGS=-soname,$(LIBSO),-z,defs,-z,relro
+
+ifeq ($(COMPILER), gcc)
+override CFLAGS += -fipa-pure-const -Wpacked-bitfield-compat -Wsync-nand -Wcoverage-mismatch \
+	-Wcpp -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const \
+	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init \
+	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const
+endif
+
+ifeq ($(OS), Darwin)
+override CFLAGS += -I/opt/local/include -I../../libsepol/include
+override LDFLAGS += -L../../libsepol/src -undefined dynamic_lookup
+endif
+
 override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
 LDLIBS += -L../src -lselinux -L$(LIBDIR)
 PCRE_LDFLAGS ?= -lpcre
-- 
1.9.1

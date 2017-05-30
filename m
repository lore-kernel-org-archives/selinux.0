From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: bwiedemann@suse.de
Subject: [PATCH] sort input files
Date: Tue, 30 May 2017 12:47:37 -0400
Message-Id: <20170530164737.5266-1-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: "Bernhard M. Wiedemann" <bwiedemann@suse.de>

when building packages (e.g. for openSUSE Linux)
(random) filesystem order of input files
influences ordering of functions in the output,
thus without the patch, builds (in disposable VMs) would usually differ.

See https://reproducible-builds.org/ for why this matters.
---
 libselinux/utils/Makefile            | 2 +-
 libsemanage/src/Makefile             | 2 +-
 libsemanage/tests/Makefile           | 2 +-
 libsepol/tests/Makefile              | 2 +-
 libsepol/utils/Makefile              | 2 +-
 mcstrans/utils/Makefile              | 2 +-
 policycoreutils/hll/pp/Makefile      | 2 +-
 policycoreutils/load_policy/Makefile | 2 +-
 policycoreutils/run_init/Makefile    | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 14f94bd..5f5368a 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -53,7 +53,7 @@ PCRE_LDLIBS ?= -lpcre
 ifeq ($(ANDROID_HOST),y)
 TARGETS=sefcontext_compile
 else
-TARGETS=$(patsubst %.c,%,$(wildcard *.c))
+TARGETS=$(patsubst %.c,%,$(sort $(wildcard *.c)))
 endif
 
 sefcontext_compile: LDLIBS += $(PCRE_LDLIBS) ../src/libselinux.a -lsepol
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index dba50c8..f01385c 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -51,7 +51,7 @@ SWIGFILES=$(SWIGSO) semanage.py
 SWIGRUBYSO=$(RUBYPREFIX)_semanage.so
 LIBSO=$(TARGET).$(LIBVERSION)
 
-GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) semanageswig_python_exception.i $(wildcard conf-*.[ch])
+GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) semanageswig_python_exception.i $(sort $(wildcard conf-*.[ch]))
 SRCS= $(filter-out $(GENERATED),$(sort $(wildcard *.c)))
 
 OBJS= $(patsubst %.c,%.o,$(SRCS)) conf-scan.o conf-parse.o
diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index 9b27224..9ccb5b2 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -2,7 +2,7 @@ PREFIX ?= $(DESTDIR)/usr
 LIBDIR ?= $(PREFIX)/lib
 
 # Add your test source files here:
-SOURCES = $(wildcard *.c)
+SOURCES = $(sort $(wildcard *.c))
 
 # Add the required external object files here:
 LIBS = ../src/libsemanage.a -lselinux -lsepol
diff --git a/libsepol/tests/Makefile b/libsepol/tests/Makefile
index 6ae8ad2..1bd96db 100644
--- a/libsepol/tests/Makefile
+++ b/libsepol/tests/Makefile
@@ -15,7 +15,7 @@ CHECKPOLICY := ../../checkpolicy/
 CPPFLAGS += -I../include/ -I$(CHECKPOLICY)
 
 # test program object files
-objs := $(patsubst %.c,%.o,$(wildcard *.c))
+objs := $(patsubst %.c,%.o,$(sort $(wildcard *.c)))
 parserobjs := $(CHECKPOLICY)queue.o $(CHECKPOLICY)y.tab.o \
 	$(CHECKPOLICY)parse_util.o $(CHECKPOLICY)lex.yy.o \
 	$(CHECKPOLICY)policy_define.o $(CHECKPOLICY)module_compiler.o
diff --git a/libsepol/utils/Makefile b/libsepol/utils/Makefile
index 3b2fb77..467aff2 100644
--- a/libsepol/utils/Makefile
+++ b/libsepol/utils/Makefile
@@ -7,7 +7,7 @@ override CFLAGS += -I../include
 override LDFLAGS += -L../src
 LDLIBS += -lsepol
 
-TARGETS=$(patsubst %.c,%,$(wildcard *.c))
+TARGETS=$(patsubst %.c,%,$(sort $(wildcard *.c)))
 
 all: $(TARGETS)
 
diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
index e6f329b..7e59641 100644
--- a/mcstrans/utils/Makefile
+++ b/mcstrans/utils/Makefile
@@ -8,7 +8,7 @@ CFLAGS ?= -Wall
 override CFLAGS += -I../src -D_GNU_SOURCE
 LDLIBS += -lselinux -lpcre
 
-TARGETS=$(patsubst %.c,%,$(wildcard *.c))
+TARGETS=$(patsubst %.c,%,$(sort $(wildcard *.c)))
 
 all: $(TARGETS)
 
diff --git a/policycoreutils/hll/pp/Makefile b/policycoreutils/hll/pp/Makefile
index 1ca6c9d..813c9c6 100644
--- a/policycoreutils/hll/pp/Makefile
+++ b/policycoreutils/hll/pp/Makefile
@@ -10,7 +10,7 @@ HLLDIR ?= $(LIBEXECDIR)/selinux/hll
 CFLAGS ?= -Werror -Wall -W
 LDLIBS = -lsepol
 
-PP_SRCS = $(wildcard *.c)
+PP_SRCS = $(sort $(wildcard *.c))
 PP_OBJS = $(patsubst %.c,%.o,$(PP_SRCS))
 
 all: pp
diff --git a/policycoreutils/load_policy/Makefile b/policycoreutils/load_policy/Makefile
index 6ab0f9d..256d95a 100644
--- a/policycoreutils/load_policy/Makefile
+++ b/policycoreutils/load_policy/Makefile
@@ -9,7 +9,7 @@ CFLAGS ?= -Werror -Wall -W
 override CFLAGS += $(LDFLAGS) -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
 LDLIBS += -lsepol -lselinux
 
-TARGETS=$(patsubst %.c,%,$(wildcard *.c))
+TARGETS=$(patsubst %.c,%,$(sort $(wildcard *.c)))
 
 all: $(TARGETS)
 
diff --git a/policycoreutils/run_init/Makefile b/policycoreutils/run_init/Makefile
index 6f5ee13..7b25952 100644
--- a/policycoreutils/run_init/Makefile
+++ b/policycoreutils/run_init/Makefile
@@ -23,7 +23,7 @@ ifeq ($(AUDITH), y)
 	LDLIBS += -laudit
 endif
 
-TARGETS=$(patsubst %.c,%,$(wildcard *.c))
+TARGETS=$(patsubst %.c,%,$(sort $(wildcard *.c)))
 
 all: $(TARGETS)
 
-- 
2.9.4

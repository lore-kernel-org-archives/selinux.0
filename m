Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3RJDpCe031113
 for <selinux@tycho.nsa.gov>; Mon, 27 Apr 2015 15:13:51 -0400
Received: by igbyr2 with SMTP id yr2so71880977igb.0
 for <selinux@tycho.nsa.gov>; Mon, 27 Apr 2015 12:13:49 -0700 (PDT)
From: Nick Kralevich <nnk@google.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Don't assume SELinux code is already installed on host
Date: Mon, 27 Apr 2015 12:13:44 -0700
Message-Id: <1430162024-29420-1-git-send-email-nnk@google.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Many parts of the SELinux userspace code appear to assume that there's
already a pre-existing install of libselinux / selinux head files on the
host. That may not be true if you're building SELinux for the first time.

Make the following modifications:

1) SELinux header files should be referenced from the source tree,
not from /usr/include.
2) *.a files should be referenced from the source tree, not from
/usr/lib
3) #include statements should exactly match the path in the source
tree.

This patch only addresses some of the issues found and testing has been
extremely limited.

Signed-off-by: Nick Kralevich <nnk@google.com>
---
 checkpolicy/Makefile             | 4 ++--
 checkpolicy/test/Makefile        | 4 ++--
 libselinux/src/Makefile          | 2 +-
 libsemanage/src/Makefile         | 8 ++++----
 libsemanage/src/direct_api.c     | 2 +-
 libsemanage/src/semanage_store.h | 2 +-
 secilc/Makefile                  | 4 ++--
 secilc/secilc.c                  | 2 +-
 8 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
index e5fae3d..9c18a95 100644
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -12,14 +12,14 @@ YACC = bison -y
 
 CFLAGS ?= -g -Wall -Werror -Wshadow -O2 -pipe -fno-strict-aliasing
 
-override CFLAGS += -I. -I${INCLUDEDIR}
+override CFLAGS += -I. -I../libsepol/include
 
 CHECKOBJS = y.tab.o lex.yy.o queue.o module_compiler.o parse_util.o \
 	    policy_define.o
 CHECKPOLOBJS = $(CHECKOBJS) checkpolicy.o
 CHECKMODOBJS = $(CHECKOBJS) checkmodule.o
 
-LDLIBS=$(LIBDIR)/libsepol.a -lfl
+LDLIBS=../libsepol/src/libsepol.a -lfl
 
 GENERATED=lex.yy.c y.tab.c y.tab.h
 
diff --git a/checkpolicy/test/Makefile b/checkpolicy/test/Makefile
index c2367e1..215dc87 100644
--- a/checkpolicy/test/Makefile
+++ b/checkpolicy/test/Makefile
@@ -7,9 +7,9 @@ LIBDIR ?= $(PREFIX)/lib
 INCLUDEDIR ?= $(PREFIX)/include
 
 CFLAGS ?= -g -Wall -W -Werror -O2 -pipe
-override CFLAGS += -I$(INCLUDEDIR)
+override CFLAGS += -I../../libsepol/include
 
-LDLIBS=-lfl $(LIBDIR)/libsepol.a -L$(LIBDIR)
+LDLIBS=-lfl ../../libsepol/src/libsepol.a
 
 all: dispol dismod
 
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index ac25c1f..3a510b2 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -72,7 +72,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
           -fipa-pure-const -Wno-suggest-attribute=pure -Wno-suggest-attribute=const \
           -Werror -Wno-aggregate-return -Wno-redundant-decls
 
-override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(EMFLAGS)
+override CFLAGS += -I../include -I../../libsepol/include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(EMFLAGS)
 
 SWIG_CFLAGS += -Wno-error -Wno-unused-variable -Wno-unused-but-set-variable -Wno-unused-parameter \
 		-Wno-shadow -Wno-uninitialized -Wno-missing-prototypes -Wno-missing-declarations
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index d1fcc0b..955fa50 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -60,7 +60,7 @@ CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-
 SWIG_CFLAGS += -Wno-error -Wno-unused-but-set-variable -Wno-unused-variable -Wno-shadow \
 		-Wno-unused-parameter
 
-override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE 
+override CFLAGS += -I../include -I../../libsepol/include -I../../libsepol/cil/include -I../../libselinux/include -D_GNU_SOURCE
 RANLIB=ranlib
 
 SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
@@ -82,17 +82,17 @@ $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
 	$(CC) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o $@ $<
 
 $(SWIGSO): $(SWIGLOBJ)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $< -L. -lsemanage -L$(LIBDIR)
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $< -L. -L../../libselinux/src -L../../libsepol/src -lsemanage
 
 $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lsemanage -L$(LIBDIR)
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -L../../libselinux/src -L../../libsepol/src -lsemanage
 
 $(LIBA): $(OBJS)
 	$(AR) rcs $@ $^
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -laudit -lselinux -lbz2 -lustr -L$(LIBDIR) -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -laudit -lselinux -lbz2 -lustr -L../../libselinux/src -L../../libsepol/src -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
 	ln -sf $@ $(TARGET)
 
 $(LIBPC): $(LIBPC).in ../VERSION
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index e4f168e..ee3f623 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -21,7 +21,7 @@
 
 #include <sepol/module.h>
 #include <sepol/handle.h>
-#include <sepol/cil/cil.h>
+#include <cil/cil.h>
 #include <selinux/selinux.h>
 
 #include <assert.h>
diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
index 62c7079..40a401c 100644
--- a/libsemanage/src/semanage_store.h
+++ b/libsemanage/src/semanage_store.h
@@ -26,7 +26,7 @@
 
 #include <sys/time.h>
 #include <sepol/module.h>
-#include <sepol/cil/cil.h>
+#include <cil/cil.h>
 #include "handle.h"
 
 enum semanage_store_defs {
diff --git a/secilc/Makefile b/secilc/Makefile
index 739bf68..26e2d75 100644
--- a/secilc/Makefile
+++ b/secilc/Makefile
@@ -4,7 +4,7 @@ MANDIR ?= $(PREFIX)/share/man
 LIBDIR ?= $(PREFIX)/lib
 INCLUDEDIR ?= $(PREFIX)/include
 
-LDLIBS = -lsepol -L$(LIBDIR)
+LDLIBS = -lsepol -L../libsepol/src
 SECILC = secilc
 SECILC_SRCS := secilc.c
 SECILC_OBJS := $(patsubst %.c,%.o,$(SECILC_SRCS))
@@ -15,7 +15,7 @@ XMLTO = xmlto
 
 CFLAGS ?= -Wall -Wshadow -Wextra -Wundef -Wmissing-format-attribute -Wcast-align -Wstrict-prototypes -Wpointer-arith -Wunused
 
-override CFLAGS += -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
+override CFLAGS += -I../libsepol/include -I../libsepol/cil/include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
 
 $(SECILC): $(SECILC_OBJS)
 	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS)
diff --git a/secilc/secilc.c b/secilc/secilc.c
index e98abe2..c9cd87f 100644
--- a/secilc/secilc.c
+++ b/secilc/secilc.c
@@ -37,7 +37,7 @@
 #ifdef ANDROID
 #include <sepol/cil.h>
 #else
-#include <sepol/cil/cil.h>
+#include <cil/cil.h>
 #endif
 #include <sepol/policydb.h>
 
-- 
2.2.0.rc0.207.ga3a616c

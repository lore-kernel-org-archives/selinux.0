Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0EEcq69005656
 for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2017 09:38:53 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 714E9564CA3
 for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2017 15:38:49 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] Re-link programs after libsepol.a is updated
Date: Sat, 14 Jan 2017 15:38:25 +0100
Message-Id: <20170114143825.4592-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

After libsepol is modified (for example while developing new features or
fixing bugs), running "make install" in the top-level directory does not
update the programs which use libsepol.a. Add this static library to the
target dependencies in order to force their updates. This makes "make"
use libsepol.a in the linking command without using LDLIBS.

While at it, copy what commit 14d706434846 ("libselinux: Allow
overriding libsepol.a location during build") introduced in libselinux
Makefile by using a new LIBSEPOLA variable in all Makefiles.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 checkpolicy/Makefile                  | 7 +++----
 checkpolicy/test/Makefile             | 7 +++----
 libselinux/src/Makefile               | 4 ++--
 mcstrans/utils/Makefile               | 7 +++++--
 python/audit2allow/Makefile           | 4 ++--
 semodule-utils/semodule_deps/Makefile | 4 ++--
 6 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
index 875cf008cae0..98fa38017583 100644
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -6,6 +6,7 @@ BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
 LIBDIR ?= $(PREFIX)/lib
 INCLUDEDIR ?= $(PREFIX)/include
+LIBSEPOLA ?= $(LIBDIR)/libsepol.a
 TARGETS = checkpolicy checkmodule
 
 LEX = flex
@@ -20,16 +21,14 @@ CHECKOBJS = y.tab.o lex.yy.o queue.o module_compiler.o parse_util.o \
 CHECKPOLOBJS = $(CHECKOBJS) checkpolicy.o
 CHECKMODOBJS = $(CHECKOBJS) checkmodule.o
 
-LDLIBS=$(LIBDIR)/libsepol.a
-
 GENERATED=lex.yy.c y.tab.c y.tab.h
 
 all:  $(TARGETS)
 	$(MAKE) -C test
 
-checkpolicy: $(CHECKPOLOBJS)
+checkpolicy: $(CHECKPOLOBJS) $(LIBSEPOLA)
 
-checkmodule: $(CHECKMODOBJS)
+checkmodule: $(CHECKMODOBJS) $(LIBSEPOLA)
 
 %.o: %.c 
 	$(CC) $(CFLAGS) -o $@ -c $<
diff --git a/checkpolicy/test/Makefile b/checkpolicy/test/Makefile
index e7bd717a7c9a..54d07f81a9c7 100644
--- a/checkpolicy/test/Makefile
+++ b/checkpolicy/test/Makefile
@@ -5,17 +5,16 @@ PREFIX ?= $(DESTDIR)/usr
 BINDIR=$(PREFIX)/bin
 LIBDIR ?= $(PREFIX)/lib
 INCLUDEDIR ?= $(PREFIX)/include
+LIBSEPOLA ?= $(LIBDIR)/libsepol.a
 
 CFLAGS ?= -g -Wall -W -Werror -O2 -pipe
 override CFLAGS += -I$(INCLUDEDIR)
 
-LDLIBS=$(LIBDIR)/libsepol.a -L$(LIBDIR)
-
 all: dispol dismod
 
-dispol: dispol.o
+dispol: dispol.o $(LIBSEPOLA)
 
-dismod: dismod.o
+dismod: dismod.o $(LIBSEPOLA)
 
 clean:
 	-rm -f dispol dismod *.o 
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index d17792c13350..5640a57d2768 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -155,8 +155,8 @@ selinuxswig_python_exception.i: ../include/selinux/selinux.h
 $(AUDIT2WHYLOBJ): audit2why.c
 	$(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED -c -o $@ $<
 
-$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)
-	$(CC) $(CFLAGS) -shared -o $@ $^ -L. $(LDFLAGS) -lselinux $(LIBSEPOLA) $(PYLIBS) -L$(LIBDIR)
+$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(LIBSEPOLA)
+	$(CC) $(CFLAGS) -shared -o $@ $^ -L. $(LDFLAGS) -lselinux $(PYLIBS) -L$(LIBDIR)
 
 %.o:  %.c policy.h
 	$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
index a0f93f548557..043d001d639c 100644
--- a/mcstrans/utils/Makefile
+++ b/mcstrans/utils/Makefile
@@ -2,14 +2,17 @@
 PREFIX ?= $(DESTDIR)/usr
 LIBDIR ?= $(PREFIX)/lib
 BINDIR ?= $(PREFIX)/sbin
+LIBSEPOLA ?= $(LIBDIR)/libsepol.a
 
 CFLAGS ?= -Wall
 override CFLAGS += -I../src -I$(PREFIX)/include -D_GNU_SOURCE
-LDLIBS += -L$(LIBDIR) ../src/mcstrans.o ../src/mls_level.o -lselinux -lpcre $(LIBDIR)/libsepol.a
+LDLIBS += -L$(LIBDIR) -lselinux -lpcre
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
-all: $(TARGETS) 
+all: $(TARGETS)
+
+$(TARGETS): ../src/mcstrans.o ../src/mls_level.o $(LIBSEPOLA)
 
 install: all
 	-mkdir -p $(BINDIR)
diff --git a/python/audit2allow/Makefile b/python/audit2allow/Makefile
index 16b5cc8dcb59..4f03e956125a 100644
--- a/python/audit2allow/Makefile
+++ b/python/audit2allow/Makefile
@@ -7,14 +7,14 @@ LIBDIR ?= $(PREFIX)/lib
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 INCLUDEDIR ?= $(PREFIX)/include
+LIBSEPOLA ?= $(LIBDIR)/libsepol.a
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = $(LIBDIR)/libsepol.a
 
 all: audit2why sepolgen-ifgen-attr-helper
 
-sepolgen-ifgen-attr-helper: sepolgen-ifgen-attr-helper.o
+sepolgen-ifgen-attr-helper: sepolgen-ifgen-attr-helper.o $(LIBSEPOLA)
 
 audit2why:
 	ln -sf audit2allow audit2why
diff --git a/semodule-utils/semodule_deps/Makefile b/semodule-utils/semodule_deps/Makefile
index 28d667e9f4b8..7d8490f2f1a8 100644
--- a/semodule-utils/semodule_deps/Makefile
+++ b/semodule-utils/semodule_deps/Makefile
@@ -4,14 +4,14 @@ INCLUDEDIR ?= $(PREFIX)/include
 BINDIR ?= $(PREFIX)/bin
 LIBDIR ?= $(PREFIX)/lib
 MANDIR ?= $(PREFIX)/share/man
+LIBSEPOLA ?= $(LIBDIR)/libsepol.a
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = $(LIBDIR)/libsepol.a
 
 all: semodule_deps
 
-semodule_deps:  semodule_deps.o 
+semodule_deps:  semodule_deps.o $(LIBSEPOLA)
 
 install: all
 	-mkdir -p $(BINDIR)
-- 
2.11.0

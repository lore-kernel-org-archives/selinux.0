Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pAF1cN4V015343
	for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2011 20:38:23 -0500
Received: from cp-out9.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id pAF1cLFo024412
	for <selinux@tycho.nsa.gov>; Tue, 15 Nov 2011 01:38:22 GMT
Received: from [192.168.2.2] (151.76.42.106) by cp-out9.libero.it (8.5.133)
        id 4EA2ECE103683788 for selinux@tycho.nsa.gov; Tue, 15 Nov 2011 02:38:20 +0100
Message-ID: <1321321099.24229.19.camel@vortex>
Subject: [PATCH] Fix includes for userspace tools and libraries
From: Guido Trentalancia <guido@trentalancia.com>
To: selinux@tycho.nsa.gov
Date: Tue, 15 Nov 2011 02:38:19 +0100
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I am still not able to build cleanly from scratch the git tree because
some header files and some shared libraries are still getting sourced
from the standard system-wide locations instead of from the build tree
itself.

The following patch should make it possible to build the git tree from
scratch. However, this patch might need to be reverted (for example by a
script) before creating the single components to be released (as it
might fail for statically linked libraries).

Signed-off-by: Guido Trentalancia <guido@trentalancia.com>

---

diff -pru selinux-15112011/checkpolicy/Makefile selinux-15112011-local-includes-and-libs/checkpolicy/Makefile
--- selinux-15112011/checkpolicy/Makefile	2011-09-09 20:12:55.978662153 +0200
+++ selinux-15112011-local-includes-and-libs/checkpolicy/Makefile	2011-11-15 01:46:54.609125450 +0100
@@ -12,14 +12,14 @@ YACC = bison -y
 
 CFLAGS ?= -g -Wall -Werror -Wshadow -O2 -pipe -fno-strict-aliasing
 
-override CFLAGS += -I. -I${INCLUDEDIR}
+override CFLAGS += -I. -I../libsepol/include -I${INCLUDEDIR}
 
 CHECKOBJS = y.tab.o lex.yy.o queue.o module_compiler.o parse_util.o \
 	    policy_define.o
 CHECKPOLOBJS = $(CHECKOBJS) checkpolicy.o
 CHECKMODOBJS = $(CHECKOBJS) checkmodule.o
 
-LDLIBS=$(LIBDIR)/libsepol.a -lfl
+LDLIBS=../libsepol/src/libsepol.a -L$(LIBDIR) -lfl
 
 GENERATED=lex.yy.c y.tab.c y.tab.h
 
diff -pru selinux-15112011/checkpolicy/test/Makefile selinux-15112011-local-includes-and-libs/checkpolicy/test/Makefile
--- selinux-15112011/checkpolicy/test/Makefile	2011-11-15 00:32:56.831740699 +0100
+++ selinux-15112011-local-includes-and-libs/checkpolicy/test/Makefile	2011-11-15 01:47:23.400293093 +0100
@@ -7,9 +7,10 @@ LIBDIR=$(PREFIX)/lib
 INCLUDEDIR ?= $(PREFIX)/include
 
 CFLAGS ?= -g -Wall -O2 -pipe
-override CFLAGS += -I$(INCLUDEDIR)
+override CFLAGS += -I../../libsepol/include -I$(INCLUDEDIR)
+
+LDLIBS=-lselinux ../../libsepol/src/libsepol.a -L$(LIBDIR) -lfl
 
-LDLIBS=-lfl -lselinux $(LIBDIR)/libsepol.a -L$(LIBDIR)
 
 all: dispol dismod
 
diff -pru selinux-15112011/libselinux/src/Makefile selinux-15112011-local-includes-and-libs/libselinux/src/Makefile
--- selinux-15112011/libselinux/src/Makefile	2011-11-15 00:32:56.859740900 +0100
+++ selinux-15112011-local-includes-and-libs/libselinux/src/Makefile	2011-11-15 01:45:23.584598520 +0100
@@ -54,7 +54,7 @@ SRCS= $(filter-out $(UNUSED_SRCS) $(GENE
 OBJS= $(patsubst %.c,%.o,$(SRCS))
 LOBJS= $(patsubst %.c,%.lo,$(SRCS))
 CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute
-override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(EMFLAGS)
+override CFLAGS += -I../include -I../../libsepol/include -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(EMFLAGS)
 RANLIB=ranlib
 
 ARCH := $(patsubst i%86,i386,$(shell uname -m))
diff -pru selinux-15112011/libsemanage/src/Makefile selinux-15112011-local-includes-and-libs/libsemanage/src/Makefile
--- selinux-15112011/libsemanage/src/Makefile	2011-11-15 00:32:56.861740916 +0100
+++ selinux-15112011-local-includes-and-libs/libsemanage/src/Makefile	2011-11-15 02:01:52.256879650 +0100
@@ -55,7 +55,7 @@ OBJS= $(patsubst %.c,%.o,$(SRCS)) conf-s
 LOBJS= $(patsubst %.c,%.lo,$(SRCS)) conf-scan.lo conf-parse.lo
 CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute
 
-override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE 
+override CFLAGS += -I../include -I../../libselinux/include -I../../libsepol/include -I$(INCLUDEDIR) -D_GNU_SOURCE 
 RANLIB=ranlib
 
 SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
diff -pru selinux-15112011/Makefile selinux-15112011-local-includes-and-libs/Makefile
--- selinux-15112011/Makefile	2011-09-09 20:12:55.977662144 +0200
+++ selinux-15112011-local-includes-and-libs/Makefile	2011-11-15 01:27:41.651225245 +0100
@@ -3,10 +3,15 @@ PYSUBDIRS=libselinux libsemanage
 DISTCLEANSUBIDRS=libselinux libsemanage
 
 ifeq ($(DEBUG),1)
-	export CFLAGS = -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror
-	export LDFLAGS = -g
+	CFLAGS += -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror
+	LDFLAGS += -g
 endif
 
+CFLAGS += -I$(CURDIR)/libselinux/include -I$(CURDIR)/libsepol/include -I$(CURDIR)/libsemanage/include
+LDFLAGS += -L$(CURDIR)/libselinux/src -L$(CURDIR)/libsepol/src -L$(CURDIR)/libsemanage/src
+export CFLAGS
+export LDFLAGS
+
 all install relabel clean test indent:
 	@for subdir in $(SUBDIRS); do \
 		(cd $$subdir && $(MAKE) $@) || exit 1; \
diff -pru selinux-15112011/policycoreutils/load_policy/Makefile selinux-15112011-local-includes-and-libs/policycoreutils/load_policy/Makefile
--- selinux-15112011/policycoreutils/load_policy/Makefile	2011-11-15 00:32:56.864740937 +0100
+++ selinux-15112011-local-includes-and-libs/policycoreutils/load_policy/Makefile	2011-11-15 02:02:55.818315068 +0100
@@ -6,7 +6,7 @@ MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+override CFLAGS += $(LDFLAGS) -I../../libselinux/include -I../../libsepol/include -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
 LDLIBS += -lsepol -lselinux -L$(PREFIX)/lib
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
diff -pru selinux-15112011/policycoreutils/newrole/Makefile selinux-15112011-local-includes-and-libs/policycoreutils/newrole/Makefile
--- selinux-15112011/policycoreutils/newrole/Makefile	2011-11-15 00:32:56.864740937 +0100
+++ selinux-15112011-local-includes-and-libs/policycoreutils/newrole/Makefile	2011-11-15 02:05:52.178539722 +0100
@@ -22,7 +22,7 @@ VERSION = $(shell cat ../VERSION)
 
 CFLAGS ?= -Werror -Wall -W
 EXTRA_OBJS =
-override CFLAGS += -DVERSION=\"$(VERSION)\" $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+override CFLAGS += -DVERSION=\"$(VERSION)\" $(LDFLAGS) -I../../libselinux/include -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
 LDLIBS += -lselinux -L$(PREFIX)/lib
 ifeq ($(PAMH), /usr/include/security/pam_appl.h)
 	override CFLAGS += -DUSE_PAM
diff -pru selinux-15112011/policycoreutils/restorecond/Makefile selinux-15112011-local-includes-and-libs/policycoreutils/restorecond/Makefile
--- selinux-15112011/policycoreutils/restorecond/Makefile	2011-11-15 00:32:56.864740937 +0100
+++ selinux-15112011-local-includes-and-libs/policycoreutils/restorecond/Makefile	2011-11-15 02:07:42.927317168 +0100
@@ -14,7 +14,7 @@ DBUSFLAGS = -DHAVE_DBUS -I/usr/include/d
 DBUSLIB = -ldbus-glib-1 -ldbus-1
 
 CFLAGS ?= -g -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include $(DBUSFLAGS) -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/lib/glib-2.0/include
+override CFLAGS += -I../../libselinux/include -I../../libsepol/include -I$(PREFIX)/include $(DBUSFLAGS) -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/lib/glib-2.0/include
 
 LDLIBS += -lselinux $(DBUSLIB) -lglib-2.0 -L$(LIBDIR)
 
diff -pru selinux-15112011/policycoreutils/run_init/Makefile selinux-15112011-local-includes-and-libs/policycoreutils/run_init/Makefile
--- selinux-15112011/policycoreutils/run_init/Makefile	2011-11-15 00:32:56.865740944 +0100
+++ selinux-15112011-local-includes-and-libs/policycoreutils/run_init/Makefile	2011-11-15 02:06:12.110678273 +0100
@@ -9,7 +9,7 @@ PAMH = $(shell ls /usr/include/security/
 AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+override CFLAGS += -I../../libselinux/include -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
 LDLIBS += -lselinux -L$(PREFIX)/lib
 ifeq ($(PAMH), /usr/include/security/pam_appl.h)
 	override CFLAGS += -DUSE_PAM
diff -pru selinux-15112011/policycoreutils/sandbox/Makefile selinux-15112011-local-includes-and-libs/policycoreutils/sandbox/Makefile
--- selinux-15112011/policycoreutils/sandbox/Makefile	2011-11-15 00:32:56.865740944 +0100
+++ selinux-15112011-local-includes-and-libs/policycoreutils/sandbox/Makefile	2011-11-15 02:06:27.943790083 +0100
@@ -8,7 +8,7 @@ SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 SHAREDIR ?= $(PREFIX)/share/sandbox
-override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DPACKAGE="\"policycoreutils\"" -Wall -Werror -Wextra
+override CFLAGS += $(LDFLAGS) -I../../libselinux/include -I$(PREFIX)/include -DPACKAGE="\"policycoreutils\"" -Wall -Werror -Wextra
 LDLIBS += -lcgroup -lselinux -lcap-ng
 
 all: sandbox seunshare sandboxX.sh start
diff -pru selinux-15112011/policycoreutils/secon/Makefile selinux-15112011-local-includes-and-libs/policycoreutils/secon/Makefile
--- selinux-15112011/policycoreutils/secon/Makefile	2011-11-15 00:32:56.866740951 +0100
+++ selinux-15112011-local-includes-and-libs/policycoreutils/secon/Makefile	2011-11-15 02:06:43.537899460 +0100
@@ -8,7 +8,7 @@ LIBDIR ?= $(PREFIX)/lib
 WARNS=-Werror -W -Wall -Wundef -Wshadow -Wpointer-arith -Wbad-function-cast -Wcast-align -Wwrite-strings -Waggregate-return -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wnested-externs -Wno-format-zero-length -Wformat-nonliteral -Wformat-security -Wfloat-equal
 VERSION = $(shell cat ../VERSION)
 CFLAGS ?= $(WARNS) -O1
-override CFLAGS += -DVERSION=\"$(VERSION)\" -I$(INCLUDEDIR) 
+override CFLAGS += -DVERSION=\"$(VERSION)\" -I../../libselinux/include -I$(INCLUDEDIR) 
 LDLIBS = -lselinux -L$(LIBDIR)
 
 all: secon
diff -pru selinux-15112011/policycoreutils/semodule/Makefile selinux-15112011-local-includes-and-libs/policycoreutils/semodule/Makefile
--- selinux-15112011/policycoreutils/semodule/Makefile	2011-11-15 00:32:56.867740958 +0100
+++ selinux-15112011-local-includes-and-libs/policycoreutils/semodule/Makefile	2011-11-15 01:50:24.771383284 +0100
@@ -6,7 +6,7 @@ MANDIR = $(PREFIX)/share/man
 LIBDIR ?= $(PREFIX)/lib
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
+override CFLAGS += -I../../libsemanage/include -I$(INCLUDEDIR)
 LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
 SEMODULE_OBJS = semodule.o
 
diff -pru selinux-15112011/policycoreutils/semodule_deps/Makefile selinux-15112011-local-includes-and-libs/policycoreutils/semodule_deps/Makefile
--- selinux-15112011/policycoreutils/semodule_deps/Makefile	2011-11-15 00:32:56.867740958 +0100
+++ selinux-15112011-local-includes-and-libs/policycoreutils/semodule_deps/Makefile	2011-11-15 01:51:21.582738330 +0100
@@ -6,8 +6,8 @@ LIBDIR ?= $(PREFIX)/lib
 MANDIR ?= $(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = $(LIBDIR)/libsepol.a
+override CFLAGS += -I../../libsepol/include -I$(INCLUDEDIR)
+LDLIBS = ../../libsepol/src/libsepol.a
 
 all: semodule_deps
 
diff -pru selinux-15112011/policycoreutils/semodule_expand/Makefile selinux-15112011-local-includes-and-libs/policycoreutils/semodule_expand/Makefile
--- selinux-15112011/policycoreutils/semodule_expand/Makefile	2011-11-15 00:32:56.867740958 +0100
+++ selinux-15112011-local-includes-and-libs/policycoreutils/semodule_expand/Makefile	2011-11-15 01:51:00.883609644 +0100
@@ -6,7 +6,7 @@ LIBDIR ?= $(PREFIX)/lib
 MANDIR ?= $(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
+override CFLAGS += -I../../libsepol/include -I$(INCLUDEDIR)
 LDLIBS = -lsepol -lselinux -L$(LIBDIR)
 
 all: semodule_expand
diff -pru selinux-15112011/policycoreutils/semodule_link/Makefile selinux-15112011-local-includes-and-libs/policycoreutils/semodule_link/Makefile
--- selinux-15112011/policycoreutils/semodule_link/Makefile	2011-11-15 00:32:56.867740958 +0100
+++ selinux-15112011-local-includes-and-libs/policycoreutils/semodule_link/Makefile	2011-11-15 01:50:42.126493487 +0100
@@ -6,7 +6,7 @@ MANDIR ?= $(PREFIX)/share/man
 LIBDIR ?= $(PREFIX)/lib
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
+override CFLAGS += -I../../libsepol/include -I$(INCLUDEDIR)
 LDLIBS = -lsepol -lselinux -L$(LIBDIR)
 
 all: semodule_link
diff -pru selinux-15112011/policycoreutils/semodule_package/Makefile selinux-15112011-local-includes-and-libs/policycoreutils/semodule_package/Makefile
--- selinux-15112011/policycoreutils/semodule_package/Makefile	2011-11-15 00:32:56.867740958 +0100
+++ selinux-15112011-local-includes-and-libs/policycoreutils/semodule_package/Makefile	2011-11-15 01:49:58.368224341 +0100
@@ -6,7 +6,7 @@ LIBDIR ?= $(PREFIX)/lib
 MANDIR ?= $(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
+override CFLAGS += -I../../libsepol/include -I$(INCLUDEDIR)
 LDLIBS = -lsepol -lselinux -L$(LIBDIR)
 
 all: semodule_package semodule_unpackage
diff -pru selinux-15112011/policycoreutils/sepolgen-ifgen/Makefile selinux-15112011-local-includes-and-libs/policycoreutils/sepolgen-ifgen/Makefile
--- selinux-15112011/policycoreutils/sepolgen-ifgen/Makefile	2011-11-15 00:32:56.878741037 +0100
+++ selinux-15112011-local-includes-and-libs/policycoreutils/sepolgen-ifgen/Makefile	2011-11-15 01:51:39.799852046 +0100
@@ -5,8 +5,8 @@ LIBDIR ?= $(PREFIX)/lib
 INCLUDEDIR ?= $(PREFIX)/include
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = $(LIBDIR)/libsepol.a
+override CFLAGS += -I../../libsepol/include -I$(INCLUDEDIR)
+LDLIBS = ../../libsepol/src/libsepol.a
 
 all: sepolgen-ifgen-attr-helper
 
diff -pru selinux-15112011/policycoreutils/sestatus/Makefile selinux-15112011-local-includes-and-libs/policycoreutils/sestatus/Makefile
--- selinux-15112011/policycoreutils/sestatus/Makefile	2011-11-15 00:32:56.878741037 +0100
+++ selinux-15112011-local-includes-and-libs/policycoreutils/sestatus/Makefile	2011-11-15 02:06:59.553010844 +0100
@@ -5,8 +5,8 @@ MANDIR = $(PREFIX)/share/man
 ETCDIR ?= $(DESTDIR)/etc
 LIBDIR ?= $(PREFIX)/lib
 
-CFLAGS = -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
+CFLAGS ?= -Werror -Wall -W
+override CFLAGS += -I../../libselinux/include -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
 LDLIBS = -lselinux -L$(LIBDIR)
 
 all: sestatus
diff -pru selinux-15112011/policycoreutils/setfiles/Makefile selinux-15112011-local-includes-and-libs/policycoreutils/setfiles/Makefile
--- selinux-15112011/policycoreutils/setfiles/Makefile	2011-11-15 00:32:56.879741044 +0100
+++ selinux-15112011-local-includes-and-libs/policycoreutils/setfiles/Makefile	2011-11-15 02:02:28.803130252 +0100
@@ -6,7 +6,7 @@ LIBDIR ?= $(PREFIX)/lib
 AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
 
 CFLAGS = -g -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include
+override CFLAGS += -I../../libselinux/include -I../../libsepol/include -I$(PREFIX)/include
 LDLIBS = -lselinux -lsepol -L$(LIBDIR)
 
 ifeq ($(AUDITH), /usr/include/libaudit.h)
diff -pru selinux-15112011/policycoreutils/setsebool/Makefile selinux-15112011-local-includes-and-libs/policycoreutils/setsebool/Makefile
--- selinux-15112011/policycoreutils/setsebool/Makefile	2011-11-15 00:32:56.879741044 +0100
+++ selinux-15112011-local-includes-and-libs/policycoreutils/setsebool/Makefile	2011-11-15 02:07:22.348172229 +0100
@@ -6,7 +6,7 @@ MANDIR = $(PREFIX)/share/man
 LIBDIR ?= $(PREFIX)/lib
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
+override CFLAGS += -I../../libselinux/include -I../../libsemanage/include -I$(INCLUDEDIR)
 LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
 SETSEBOOL_OBJS = setsebool.o
 

Similar modifications had already been posted in mid-September.

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

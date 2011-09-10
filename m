Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8A14dT8014024
	for <selinux@tycho.nsa.gov>; Fri, 9 Sep 2011 21:04:40 -0400
Received: from cp-out7.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8A14bt5005226
	for <selinux@tycho.nsa.gov>; Sat, 10 Sep 2011 01:04:38 GMT
Subject: [RFC] Userspace git local build (was Re: [RFC] Userspace top-level
 Makefile)
From: Guido Trentalancia <guido@trentalancia.com>
To: Eric Paris <eparis@redhat.com>
Cc: Joshua Brindle <method@manicmethod.com>,
        Eric Paris
 <eparis@parisplace.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Date: Sat, 10 Sep 2011 03:04:23 +0200
In-Reply-To: <1315612611.2482.46.camel@vortex>
References: <1315587716.2170.16.camel@vortex>
	 <1315588656.2170.26.camel@vortex>
	 <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
	 <1315590383.2170.32.camel@vortex> <1315591143.2170.36.camel@vortex>
	 <1315603187.2482.22.camel@vortex> <4E6A8707.9080602@manicmethod.com>
	 <1315607702.2482.28.camel@vortex> <4E6A9C4D.6010303@redhat.com>
	 <1315609967.2482.39.camel@vortex> <4E6A9E26.9080806@redhat.com>
	 <1315610720.2482.42.camel@vortex> <1315611916.2482.44.camel@vortex>
	 <1315612611.2482.46.camel@vortex>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315616664.2482.58.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The final version of the patch which works on my system is attached
below for further testing.

This patch is intended to make sure that the SELinux userspace libraries
and tools bundle from the git repository can be built from scratch
without requiring existing SELinux installations (in particular header
files). It should also fix a possible installation issue (creation of
symbolic links to shared libraries for libselinux and libsepol).

diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/checkpolicy/Makefile selinux-09092011-final-local-build/checkpolicy/Makefile
--- selinux-09092011-orig/checkpolicy/Makefile	2011-09-09 20:12:55.978662153 +0200
+++ selinux-09092011-final-local-build/checkpolicy/Makefile	2011-09-10 02:47:16.066676508 +0200
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
 
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/checkpolicy/test/Makefile selinux-09092011-final-local-build/checkpolicy/test/Makefile
--- selinux-09092011-orig/checkpolicy/test/Makefile	2011-09-09 20:12:55.980662174 +0200
+++ selinux-09092011-final-local-build/checkpolicy/test/Makefile	2011-09-10 02:44:50.695849882 +0200
@@ -7,9 +7,9 @@ LIBDIR=$(PREFIX)/lib
 INCLUDEDIR ?= $(PREFIX)/include
 
 CFLAGS ?= -g -Wall -O2 -pipe
-override CFLAGS += -I$(INCLUDEDIR)
+override CFLAGS += -I../../libsepol/include -I$(INCLUDEDIR)
 
-LDLIBS=-lfl -lsepol -lselinux $(LIBDIR)/libsepol.a -L$(LIBDIR)
+LDLIBS=-L../../libselinux/src -lselinux -L../../libsepol/src -lsepol ../../libsepol/src/libsepol.a -L$(LIBDIR) -lfl
 
 all: dispol dismod
 
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/libselinux/src/Makefile selinux-09092011-final-local-build/libselinux/src/Makefile
--- selinux-09092011-orig/libselinux/src/Makefile	2011-09-09 20:12:55.992662259 +0200
+++ selinux-09092011-final-local-build/libselinux/src/Makefile	2011-09-10 02:44:02.015567636 +0200
@@ -54,7 +54,7 @@ SRCS= $(filter-out $(UNUSED_SRCS) $(GENE
 OBJS= $(patsubst %.c,%.o,$(SRCS))
 LOBJS= $(patsubst %.c,%.lo,$(SRCS))
 CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute
-override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(EMFLAGS)
+override CFLAGS += -I../include -I../../libsepol/include -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(EMFLAGS)
 RANLIB=ranlib
 
 ARCH := $(patsubst i%86,i386,$(shell uname -m))
@@ -102,7 +102,7 @@ $(AUDIT2WHYLOBJ): audit2why.c
 	$(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED -c -o $@ $<
 
 $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux ${LIBDIR}/libsepol.a -L$(LIBDIR) -Wl,-soname,$@
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux ../../libsepol/libsepol.a -L$(LIBDIR) -Wl,-soname,$@
 
 %.o:  %.c policy.h
 	$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
@@ -126,7 +126,7 @@ install: all
 	install -m 755 $(LIBSO) $(SHLIBDIR)
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
-	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
+	cd $(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
 
 install-pywrap: pywrap
 	test -d $(PYLIBDIR)/site-packages/selinux || install -m 755 -d $(PYLIBDIR)/site-packages/selinux
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/libsemanage/src/Makefile selinux-09092011-final-local-build/libsemanage/src/Makefile
--- selinux-09092011-orig/libsemanage/src/Makefile	2011-09-09 20:12:56.008662374 +0200
+++ selinux-09092011-final-local-build/libsemanage/src/Makefile	2011-09-10 02:48:50.111197707 +0200
@@ -55,7 +55,7 @@ OBJS= $(patsubst %.c,%.o,$(SRCS)) conf-s
 LOBJS= $(patsubst %.c,%.lo,$(SRCS)) conf-scan.lo conf-parse.lo
 CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute
 
-override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE 
+override CFLAGS += -I../include -I../../libselinux/include -I../../libsepol/include -I$(INCLUDEDIR) -D_GNU_SOURCE 
 RANLIB=ranlib
 
 SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
@@ -87,7 +87,7 @@ $(LIBA): $(OBJS)
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -lselinux -lbz2 -lustr -L$(LIBDIR) -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L../../libsepol/src -lsepol -L../../libselinux/src -lselinux -L$(LIBDIR) -lbz2 -lustr -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
 	ln -sf $@ $(TARGET)
 
 $(LIBPC): $(LIBPC).in
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/libsepol/src/Makefile selinux-09092011-final-local-build/libsepol/src/Makefile
--- selinux-09092011-orig/libsepol/src/Makefile	2011-09-09 20:12:56.021662468 +0200
+++ selinux-09092011-final-local-build/libsepol/src/Makefile	2011-09-10 01:58:06.437254998 +0200
@@ -43,7 +43,7 @@ install: all
 	install -m 755 $(LIBSO) $(SHLIBDIR)
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
-	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
+	cd $(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
 
 relabel:
 	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/load_policy/Makefile selinux-09092011-final-local-build/policycoreutils/load_policy/Makefile
--- selinux-09092011-orig/policycoreutils/load_policy/Makefile	2011-09-09 20:12:56.035662568 +0200
+++ selinux-09092011-final-local-build/policycoreutils/load_policy/Makefile	2011-09-10 02:28:53.752122765 +0200
@@ -6,8 +6,8 @@ MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-LDLIBS += -lsepol -lselinux -L$(PREFIX)/lib
+override CFLAGS += $(LDFLAGS) -I../../libselinux/include -I../../libsepol/include -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+LDLIBS += -L../../libsepol/src -lsepol -L../../libselinux/src -lselinux
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/mcstrans/src/Makefile selinux-09092011-final-local-build/policycoreutils/mcstrans/src/Makefile
--- selinux-09092011-orig/policycoreutils/mcstrans/src/Makefile	2011-09-09 20:12:56.040662607 +0200
+++ selinux-09092011-final-local-build/policycoreutils/mcstrans/src/Makefile	2011-09-10 02:39:34.153967929 +0200
@@ -28,7 +28,7 @@ override CFLAGS += -I../include -D_GNU_S
 all: $(PROG)
 
 $(PROG): $(PROG_OBJS)
-	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre $(LIBDIR)/libsepol.a
+	$(CC) $(LDFLAGS) -pie -o $@ $^ -L../../../libselinux/src -lselinux ../../../libsepol/src/libsepol.a -L$(LIBDIR) -lcap -lpcre
 
 %.o:  %.c 
 	$(CC) $(CFLAGS) -fPIE -c -o $@ $<
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/mcstrans/utils/Makefile selinux-09092011-final-local-build/policycoreutils/mcstrans/utils/Makefile
--- selinux-09092011-orig/policycoreutils/mcstrans/utils/Makefile	2011-09-09 20:12:56.041662614 +0200
+++ selinux-09092011-final-local-build/policycoreutils/mcstrans/utils/Makefile	2011-09-10 02:41:11.963560821 +0200
@@ -21,7 +21,7 @@ endif
 
 CFLAGS ?= -Wall
 override CFLAGS += -I../src -D_GNU_SOURCE
-LDLIBS += -L../src ../src/mcstrans.o ../src/mls_level.o -lselinux -lpcre $(LIBDIR)/libsepol.a
+LDLIBS += -L../src ../src/mcstrans.o ../src/mls_level.o -L../../../libselinux/src -lselinux ../../../libsepol/src/libsepol.a -L$(LIBDIR) -lpcre
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/newrole/Makefile selinux-09092011-final-local-build/policycoreutils/newrole/Makefile
--- selinux-09092011-orig/policycoreutils/newrole/Makefile	2011-09-09 20:12:56.041662614 +0200
+++ selinux-09092011-final-local-build/policycoreutils/newrole/Makefile	2011-09-10 01:58:14.064277530 +0200
@@ -22,7 +22,7 @@ VERSION = $(shell cat ../VERSION)
 
 CFLAGS ?= -Werror -Wall -W
 EXTRA_OBJS =
-override CFLAGS += -DVERSION=\"$(VERSION)\" $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+override CFLAGS += -DVERSION=\"$(VERSION)\" $(LDFLAGS) -I../../libselinux/include -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
 LDLIBS += -lselinux -L$(PREFIX)/lib
 ifeq (${PAMH}, /usr/include/security/pam_appl.h)
 	override CFLAGS += -DUSE_PAM
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/restorecond/Makefile selinux-09092011-final-local-build/policycoreutils/restorecond/Makefile
--- selinux-09092011-orig/policycoreutils/restorecond/Makefile	2011-09-09 20:12:56.072662837 +0200
+++ selinux-09092011-final-local-build/policycoreutils/restorecond/Makefile	2011-09-10 01:58:14.064277530 +0200
@@ -6,7 +6,7 @@ INITDIR = $(DESTDIR)/etc/rc.d/init.d
 SELINUXDIR = $(DESTDIR)/etc/selinux
 
 CFLAGS ?= -g -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
+override CFLAGS += -I../../libselinux/include -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
 LDLIBS += -lselinux -L$(PREFIX)/lib
 
 all: restorecond
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/run_init/Makefile selinux-09092011-final-local-build/policycoreutils/run_init/Makefile
--- selinux-09092011-orig/policycoreutils/run_init/Makefile	2011-09-09 20:12:56.072662837 +0200
+++ selinux-09092011-final-local-build/policycoreutils/run_init/Makefile	2011-09-10 01:58:14.064277530 +0200
@@ -9,7 +9,7 @@ PAMH = $(shell ls /usr/include/security/
 AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+override CFLAGS += -I../../libselinux/include -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
 LDLIBS += -lselinux -L$(PREFIX)/lib
 ifeq (${PAMH}, /usr/include/security/pam_appl.h)
 	override CFLAGS += -DUSE_PAM
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/sandbox/Makefile selinux-09092011-final-local-build/policycoreutils/sandbox/Makefile
--- selinux-09092011-orig/policycoreutils/sandbox/Makefile	2011-09-09 20:12:56.073662844 +0200
+++ selinux-09092011-final-local-build/policycoreutils/sandbox/Makefile	2011-09-10 01:58:14.064277530 +0200
@@ -7,7 +7,7 @@ SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 SHAREDIR ?= $(PREFIX)/share/sandbox
-override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DPACKAGE="\"policycoreutils\""
+override CFLAGS += $(LDFLAGS) -I../../libselinux/include -I$(PREFIX)/include -DPACKAGE="\"policycoreutils\""
 LDLIBS += -lselinux -lcap-ng 
 
 all: sandbox seunshare sandboxX.sh start
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/secon/Makefile selinux-09092011-final-local-build/policycoreutils/secon/Makefile
--- selinux-09092011-orig/policycoreutils/secon/Makefile	2011-09-09 20:12:56.075662858 +0200
+++ selinux-09092011-final-local-build/policycoreutils/secon/Makefile	2011-09-10 02:40:05.057152235 +0200
@@ -8,8 +8,8 @@ LIBDIR ?= ${PREFIX}/lib
 WARNS=-Werror -W -Wall -Wundef -Wshadow -Wpointer-arith -Wbad-function-cast -Wcast-align -Wwrite-strings -Waggregate-return -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wnested-externs -Wno-format-zero-length -Wformat-nonliteral -Wformat-security -Wfloat-equal
 VERSION = $(shell cat ../VERSION)
 CFLAGS ?= $(WARNS) -O1
-override CFLAGS += -DVERSION=\"$(VERSION)\" -I$(INCLUDEDIR) 
-LDLIBS = -lselinux -L$(LIBDIR)
+override CFLAGS += -DVERSION=\"$(VERSION)\" -I../../libselinux/include -I$(INCLUDEDIR) 
+LDLIBS = -L../../libselinux/src -lselinux
 
 all: secon
 
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/semodule/Makefile selinux-09092011-final-local-build/policycoreutils/semodule/Makefile
--- selinux-09092011-orig/policycoreutils/semodule/Makefile	2011-09-09 20:12:56.076662865 +0200
+++ selinux-09092011-final-local-build/policycoreutils/semodule/Makefile	2011-09-10 02:50:14.999662210 +0200
@@ -6,8 +6,8 @@ MANDIR = $(PREFIX)/share/man
 LIBDIR ?= ${PREFIX}/lib
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
+override CFLAGS += -I../../libsemanage/include -I$(INCLUDEDIR)
+LDLIBS = -L../../libselinux/src -lselinux -L../../libsepol/src -lsepol -L../../libsemanage/src -lsemanage
 SEMODULE_OBJS = semodule.o
 
 all: semodule
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/semodule_deps/Makefile selinux-09092011-final-local-build/policycoreutils/semodule_deps/Makefile
--- selinux-09092011-orig/policycoreutils/semodule_deps/Makefile	2011-09-09 20:12:56.076662865 +0200
+++ selinux-09092011-final-local-build/policycoreutils/semodule_deps/Makefile	2011-09-10 02:30:24.767631670 +0200
@@ -6,8 +6,8 @@ LIBDIR ?= ${PREFIX}/lib
 MANDIR ?= $(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = $(LIBDIR)/libsepol.a
+override CFLAGS += -I../../libsepol/include -I$(INCLUDEDIR)
+LDLIBS = ../../libsepol/src/libsepol.a
 
 all: semodule_deps
 
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/semodule_expand/Makefile selinux-09092011-final-local-build/policycoreutils/semodule_expand/Makefile
--- selinux-09092011-orig/policycoreutils/semodule_expand/Makefile	2011-09-09 20:12:56.077662873 +0200
+++ selinux-09092011-final-local-build/policycoreutils/semodule_expand/Makefile	2011-09-10 02:30:08.252537492 +0200
@@ -6,8 +6,8 @@ LIBDIR ?= ${PREFIX}/lib
 MANDIR ?= $(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = -lsepol -lselinux -L$(LIBDIR)
+override CFLAGS += -I../../libsepol/include -I$(INCLUDEDIR)
+LDLIBS = -L../../libsepol/src -lsepol -L../../libselinux/src -lselinux
 
 all: semodule_expand
 
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/semodule_link/Makefile selinux-09092011-final-local-build/policycoreutils/semodule_link/Makefile
--- selinux-09092011-orig/policycoreutils/semodule_link/Makefile	2011-09-09 20:12:56.077662873 +0200
+++ selinux-09092011-final-local-build/policycoreutils/semodule_link/Makefile	2011-09-10 02:29:46.351416558 +0200
@@ -6,8 +6,8 @@ MANDIR ?= $(PREFIX)/share/man
 LIBDIR ?= ${PREFIX}/lib
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = -lsepol -lselinux -L$(LIBDIR)
+override CFLAGS += -I../../libsepol/include -I$(INCLUDEDIR)
+LDLIBS = -L../../libsepol/src -lsepol -L../../libselinux/src -lselinux
 
 all: semodule_link
 
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/semodule_package/Makefile selinux-09092011-final-local-build/policycoreutils/semodule_package/Makefile
--- selinux-09092011-orig/policycoreutils/semodule_package/Makefile	2011-09-09 20:12:56.077662873 +0200
+++ selinux-09092011-final-local-build/policycoreutils/semodule_package/Makefile	2011-09-10 02:29:22.305283135 +0200
@@ -6,8 +6,8 @@ LIBDIR ?= ${PREFIX}/lib
 MANDIR ?= $(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = -lsepol -lselinux -L$(LIBDIR)
+override CFLAGS += -I../../libsepol/include -I$(INCLUDEDIR)
+LDLIBS = -L../../libsepol/src -lsepol -L../../libselinux/src -lselinux
 
 all: semodule_package semodule_unpackage
 
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/sestatus/Makefile selinux-09092011-final-local-build/policycoreutils/sestatus/Makefile
--- selinux-09092011-orig/policycoreutils/sestatus/Makefile	2011-09-09 20:12:56.077662873 +0200
+++ selinux-09092011-final-local-build/policycoreutils/sestatus/Makefile	2011-09-10 02:37:29.161194093 +0200
@@ -6,8 +6,8 @@ ETCDIR ?= $(DESTDIR)/etc
 LIBDIR ?= ${PREFIX}/lib
 
 CFLAGS = -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
-LDLIBS = -lselinux -L$(LIBDIR)
+override CFLAGS += -I../../libselinux/include -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
+LDLIBS = -L../../libselinux/src -lselinux
 
 all: sestatus
 
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/setfiles/Makefile selinux-09092011-final-local-build/policycoreutils/setfiles/Makefile
--- selinux-09092011-orig/policycoreutils/setfiles/Makefile	2011-09-09 20:12:56.078662881 +0200
+++ selinux-09092011-final-local-build/policycoreutils/setfiles/Makefile	2011-09-10 02:28:17.323919113 +0200
@@ -6,8 +6,8 @@ LIBDIR ?= $(PREFIX)/lib
 AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
 
 CFLAGS = -g -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include
-LDLIBS = -lselinux -lsepol -L$(LIBDIR)
+override CFLAGS += -I../../libsepol/include -I../../libselinux/include -I$(PREFIX)/include
+LDLIBS = -L../../libselinux/src -lselinux -L../../libsepol/src -lsepol
 
 ifeq (${AUDITH}, /usr/include/libaudit.h)
 	override CFLAGS += -DUSE_AUDIT
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/setsebool/Makefile selinux-09092011-final-local-build/policycoreutils/setsebool/Makefile
--- selinux-09092011-orig/policycoreutils/setsebool/Makefile	2011-09-09 20:12:56.078662881 +0200
+++ selinux-09092011-final-local-build/policycoreutils/setsebool/Makefile	2011-09-10 02:51:08.457950279 +0200
@@ -6,8 +6,8 @@ MANDIR = $(PREFIX)/share/man
 LIBDIR ?= ${PREFIX}/lib
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
+override CFLAGS += -I../../libselinux/include -I../../libsemanage/include -I$(INCLUDEDIR)
+LDLIBS = -L../../libselinux/src -lselinux -L../../libsepol/src -lsepol -L../../libsemanage/src -lsemanage
 SETSEBOOL_OBJS = setsebool.o
 
 all: setsebool


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

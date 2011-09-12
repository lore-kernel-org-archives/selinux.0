Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8C2D89A027787
	for <selinux@tycho.nsa.gov>; Sun, 11 Sep 2011 22:13:08 -0400
Received: from cp-out8.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8C2D5jb018866
	for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2011 02:13:06 GMT
Subject: Re: [RFC] Userspace top-level Makefile (was Re: [PATCH] Fix LIBDIR
 usage for load_policy)
From: Guido Trentalancia <guido@trentalancia.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: Eric Paris <eparis@redhat.com>, Eric Paris <eparis@parisplace.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Date: Mon, 12 Sep 2011 04:12:50 +0200
In-Reply-To: <4E6D429A.7060403@manicmethod.com>
References: <1315587716.2170.16.camel@vortex>
	    <1315588656.2170.26.camel@vortex>
	    <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
	    <1315590383.2170.32.camel@vortex> <1315591143.2170.36.camel@vortex>
	   <1315603187.2482.22.camel@vortex> <4E6A8707.9080602@manicmethod.com>
	  <1315607702.2482.28.camel@vortex> <4E6A9C4D.6010303@redhat.com>
	 <1315609967.2482.39.camel@vortex> <4E6A9E26.9080806@redhat.com>
	 <4E6D429A.7060403@manicmethod.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315793570.2209.22.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2011-09-11 at 19:22 -0400, Joshua Brindle wrote:
> Eric Paris wrote:
> > On 09/09/2011 07:12 PM, Guido Trentalancia wrote:
> >> On Fri, 2011-09-09 at 19:07 -0400, Eric Paris wrote:
> >>> On 09/09/2011 06:35 PM, Guido Trentalancia wrote:
> >>>> The following patch is probably even better as it actually sorts out the
> >>>> problem rather than just printing out a warning (it can still be
> >>>> combined with the creation of a top-level README file):
> >>>>
> >>>> diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/checkpolicy/Makefile selinux-09092011-local-headers/checkpolicy/Makefile
> >>>> --- selinux-09092011-orig/checkpolicy/Makefile	2011-09-09 20:12:55.978662153 +0200
> >>>> +++ selinux-09092011-local-headers/checkpolicy/Makefile	2011-09-10 00:21:16.242852130 +0200
> >>>> @@ -12,7 +12,7 @@ YACC = bison -y
> >>>>
> >>>>   CFLAGS ?= -g -Wall -Werror -Wshadow -O2 -pipe -fno-strict-aliasing
> >>>>
> >>>> -override CFLAGS += -I. -I${INCLUDEDIR}
> >>>> +override CFLAGS += -I. -I../libsepol/include -I${INCLUDEDIR}
> >>> I haven't checked, but can the makefiles then work when there is no
> >>> ../libsepol/include?
> >> If ../libsepol/include does not exist and libsepol headers are not
> >> installed under the standard location (${INCLUDEDIR}), then the above is
> >> going to fail.
> >>
> >> But why should libsepol/include be missing from git in the first
> >> place ??
> >
> > I agree that they must be in one or the other for it to build.  A number
> > of distros build these packages separately, rather than all at once.
> > Thus there would be no ../libsepol/include directory at all, but the
> > headers should be picked up by -I$(INCLUDEDIR).  As long as gcc doesn't
> > care that the directory doesn't exist, I actually like it.
> >
> 
> gcc doesn't care and I swear we use to have ../ directories in the 
> include path, not sure what happened to those :X

Honestly, I don't know, I can't remember. From reading a bit of git log,
perhaps I can speculate it wasn't there, but what I am hitting is also
cross-dependencies between the objects in the library directories (so
for example libsepol symbols being required by objects in the libselinux
directory).

But if you decide to apply that latest patch, you then need a different
patch afterwards to fix the LIBDIR issue with load_policy:

--- selinux-09092011-make-arguments/policycoreutils/load_policy/Makefile	2011-09-10 04:03:52.381049637 +0200
+++ selinux-09092011-make-arguments-fix-load_policy-LIBDIR/policycoreutils/load_policy/Makefile	2011-09-12 02:54:23.279934801 +0200
@@ -3,11 +3,12 @@ PREFIX ?= ${DESTDIR}/usr
 SBINDIR ?= $(DESTDIR)/sbin
 USRSBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
+LIBDIR ?= $(PREFIX)/usr/lib
 LOCALEDIR ?= /usr/share/locale
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += $(LDFLAGS) -I../../libselinux/include -I../../libsepol/include -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-LDLIBS += -L../../libsepol/src -lsepol -L../../libselinux/src -lselinux -L$(PREFIX)/lib
+LDLIBS += -L../../libsepol/src -lsepol -L../../libselinux/src -lselinux -L$(LIBDIR)
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 

It is maintenance tasks and it strongly depends which way you prefer
amongst many different ways of doing it more or less equivalently. There
might be other things that could be fixed too.

Or a new complete patch (with further minor fixes) could be as follows:

This is a maintenance patch for further testing. It potentially replaces
any other patch previously posted in this same thread.

Make sure that the SELinux userspace libraries and tools bundle from the
git repository can be built from scratch without requiring existing
SELinux installations (in particular header files).

Fix a possible installation issue (creation of symbolic links with wrong
target to shared libraries for libselinux and libsepol).

Replace curly brackets with parentheses for some variables such as
DESTDIR and PREFIX in the Makefiles. Add and make use of LIBDIR and
INCLUDEDIR where appropriate within the Makefiles. Make use of PREFIX
for creating LOCALEDIR within the Makefiles. Do not override passed
environment variables (replace = with ?=) within the Makefiles.

diff -pru selinux/checkpolicy/Makefile selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/checkpolicy/Makefile
--- selinux/checkpolicy/Makefile	2011-09-09 20:12:55.978662153 +0200
+++ selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/checkpolicy/Makefile	2011-09-12 03:05:45.347163564 +0200
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
 
diff -pru selinux/checkpolicy/test/Makefile selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/checkpolicy/test/Makefile
--- selinux/checkpolicy/test/Makefile	2011-09-09 20:12:55.980662174 +0200
+++ selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/checkpolicy/test/Makefile	2011-09-12 03:05:45.348163614 +0200
@@ -7,9 +7,9 @@ LIBDIR=$(PREFIX)/lib
 INCLUDEDIR ?= $(PREFIX)/include
 
 CFLAGS ?= -g -Wall -O2 -pipe
-override CFLAGS += -I$(INCLUDEDIR)
+override CFLAGS += -I../../libsepol/include -I$(INCLUDEDIR)
 
-LDLIBS=-lfl -lsepol -lselinux $(LIBDIR)/libsepol.a -L$(LIBDIR)
+LDLIBS=-L../../libsepol/src -lsepol -L../../libselinux/src -lselinux ../../libsepol/src/libsepol.a -L$(LIBDIR) -lfl
 
 all: dispol dismod
 
diff -pru selinux/libselinux/src/Makefile selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/libselinux/src/Makefile
--- selinux/libselinux/src/Makefile	2011-09-09 20:12:55.992662259 +0200
+++ selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/libselinux/src/Makefile	2011-09-12 03:05:45.349163662 +0200
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
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux ../../libsepol/src/libsepol.a -L$(LIBDIR) -Wl,-soname,$@
 
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
diff -pru selinux/libsemanage/src/Makefile selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/libsemanage/src/Makefile
--- selinux/libsemanage/src/Makefile	2011-09-09 20:12:56.008662374 +0200
+++ selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/libsemanage/src/Makefile	2011-09-12 03:05:45.350163708 +0200
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
diff -pru selinux/libsepol/src/Makefile selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/libsepol/src/Makefile
--- selinux/libsepol/src/Makefile	2011-09-09 20:12:56.021662468 +0200
+++ selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/libsepol/src/Makefile	2011-09-12 03:05:45.351163751 +0200
@@ -43,7 +43,7 @@ install: all
 	install -m 755 $(LIBSO) $(SHLIBDIR)
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
-	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
+	cd $(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
 
 relabel:
 	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
diff -pru selinux/policycoreutils/audit2allow/Makefile selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/audit2allow/Makefile
--- selinux/policycoreutils/audit2allow/Makefile	2011-09-09 20:12:56.034662561 +0200
+++ selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/audit2allow/Makefile	2011-09-12 03:30:42.428707945 +0200
@@ -1,9 +1,9 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 BINDIR ?= $(PREFIX)/bin
 LIBDIR ?= $(PREFIX)/lib
 MANDIR ?= $(PREFIX)/share/man
-LOCALEDIR ?= /usr/share/locale
+LOCALEDIR ?= $(PREFIX)/share/locale
 
 all: ;
 
diff -pru selinux/policycoreutils/audit2why/Makefile selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/audit2why/Makefile
--- selinux/policycoreutils/audit2why/Makefile	2011-09-09 20:12:56.035662568 +0200
+++ selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/audit2why/Makefile	2011-09-12 03:23:29.933039451 +0200
@@ -1,5 +1,5 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
 
diff -pru selinux/policycoreutils/load_policy/Makefile selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/load_policy/Makefile
--- selinux/policycoreutils/load_policy/Makefile	2011-09-09 20:12:56.035662568 +0200
+++ selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/load_policy/Makefile	2011-09-12 03:34:53.862216941 +0200
@@ -1,13 +1,15 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 SBINDIR ?= $(DESTDIR)/sbin
 USRSBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
-LOCALEDIR ?= /usr/share/locale
+LIBDIR ?= $(PREFIX)/lib
+INCLUDEDIR ?= $(PREFIX)/include
+LOCALEDIR ?= $(PREFIX)/share/locale
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-LDLIBS += -lsepol -lselinux -L$(PREFIX)/lib
+override CFLAGS += $(LDFLAGS) -I../../libselinux/include -I../../libsepol/include -I$(INCLUDEDIR) -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+LDLIBS += -L../../libsepol/src -lsepol -L../../libselinux/src -lselinux -L$(LIBDIR)
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
diff -pru selinux/policycoreutils/mcstrans/src/Makefile selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/mcstrans/src/Makefile
--- selinux/policycoreutils/mcstrans/src/Makefile	2011-09-09 20:12:56.040662607 +0200
+++ selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/mcstrans/src/Makefile	2011-09-12 03:05:45.351163751 +0200
@@ -28,7 +28,7 @@ override CFLAGS += -I../include -D_GNU_S
 all: $(PROG)
 
 $(PROG): $(PROG_OBJS)
-	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre $(LIBDIR)/libsepol.a
+	$(CC) $(LDFLAGS) -pie -o $@ $^ -L../../../libselinux/src -lselinux -L$(LIBDIR) -lcap -lpcre ../../../libsepol/src/libsepol.a
 
 %.o:  %.c 
 	$(CC) $(CFLAGS) -fPIE -c -o $@ $<
diff -pru selinux/policycoreutils/mcstrans/utils/Makefile selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/mcstrans/utils/Makefile
--- selinux/policycoreutils/mcstrans/utils/Makefile	2011-09-09 20:12:56.041662614 +0200
+++ selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/mcstrans/utils/Makefile	2011-09-12 03:05:45.351163751 +0200
@@ -21,7 +21,7 @@ endif
 
 CFLAGS ?= -Wall
 override CFLAGS += -I../src -D_GNU_SOURCE
-LDLIBS += -L../src ../src/mcstrans.o ../src/mls_level.o -lselinux -lpcre $(LIBDIR)/libsepol.a
+LDLIBS += -L../src ../src/mcstrans.o ../src/mls_level.o -L../../../libselinux/src -lselinux -L$(LIBDIR) -lpcre ../../../libsepol/src/libsepol.a
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
diff -pru selinux/policycoreutils/newrole/Makefile selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/newrole/Makefile
--- selinux/policycoreutils/newrole/Makefile	2011-09-09 20:12:56.041662614 +0200
+++ selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/newrole/Makefile	2011-09-12 03:43:51.666590241 +0200
@@ -1,9 +1,11 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 BINDIR ?= $(PREFIX)/bin
+LIBDIR ?= $(PREFIX)/lib
+INCLUDEDIR ?= $(PREFIX)/include
 MANDIR ?= $(PREFIX)/share/man
 ETCDIR ?= $(DESTDIR)/etc
-LOCALEDIR = /usr/share/locale
+LOCALEDIR ?= $(PREFIX)/share/locale
 PAMH = $(shell ls /usr/include/security/pam_appl.h 2>/dev/null)
 AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
 # Enable capabilities to permit newrole to generate audit records.
@@ -22,8 +24,8 @@ VERSION = $(shell cat ../VERSION)
 
 CFLAGS ?= -Werror -Wall -W
 EXTRA_OBJS =
-override CFLAGS += -DVERSION=\"$(VERSION)\" $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-LDLIBS += -lselinux -L$(PREFIX)/lib
+override CFLAGS += -DVERSION=\"$(VERSION)\" $(LDFLAGS) -I../../libselinux/include -I$(INCLUDEDIR) -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+LDLIBS += -L../../libselinux/src -lselinux -L$(LIBDIR)
 ifeq (${PAMH}, /usr/include/security/pam_appl.h)
 	override CFLAGS += -DUSE_PAM
 	EXTRA_OBJS += hashtab.o
diff -pru selinux/policycoreutils/restorecond/Makefile selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/restorecond/Makefile
--- selinux/policycoreutils/restorecond/Makefile	2011-09-09 20:12:56.072662837 +0200
+++ selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/restorecond/Makefile	2011-09-12 03:14:53.053779265 +0200
@@ -1,13 +1,15 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 SBINDIR ?= $(PREFIX)/sbin
-MANDIR = $(PREFIX)/share/man
-INITDIR = $(DESTDIR)/etc/rc.d/init.d
-SELINUXDIR = $(DESTDIR)/etc/selinux
+MANDIR ?= $(PREFIX)/share/man
+LIBDIR ?= $(PREFIX)/lib
+INCLUDEDIR ?= $(PREFIX)/include
+INITDIR ?= $(DESTDIR)/etc/rc.d/init.d
+SELINUXDIR ?= $(DESTDIR)/etc/selinux
 
 CFLAGS ?= -g -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
-LDLIBS += -lselinux -L$(PREFIX)/lib
+override CFLAGS += -I../../libselinux/include -I$(INCLUDEDIR) -D_FILE_OFFSET_BITS=64
+LDLIBS += -L../../libselinux/src -lselinux -L$(LIBDIR)
 
 all: restorecond
 
diff -pru selinux/policycoreutils/run_init/Makefile selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/run_init/Makefile
--- selinux/policycoreutils/run_init/Makefile	2011-09-09 20:12:56.072662837 +0200
+++ selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/run_init/Makefile	2011-09-12 03:17:44.646835066 +0200
@@ -1,16 +1,17 @@
-
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
+LIBDIR ?= $(PREFIX)/lib
+INCLUDEDIR ?= $(PREFIX)/include
 ETCDIR ?= $(DESTDIR)/etc
-LOCALEDIR ?= /usr/share/locale
+LOCALEDIR ?= $(PREFIX)/share/locale
 PAMH = $(shell ls /usr/include/security/pam_appl.h 2>/dev/null)
 AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-LDLIBS += -lselinux -L$(PREFIX)/lib
+override CFLAGS += -I../../libselinux/include -I$(INCLUDEDIR) -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+LDLIBS += -L../../libselinux/src -lselinux -L$(LIBDIR)
 ifeq (${PAMH}, /usr/include/security/pam_appl.h)
 	override CFLAGS += -DUSE_PAM
 	LDLIBS += -lpam -lpam_misc
diff -pru selinux/policycoreutils/sandbox/Makefile selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/sandbox/Makefile
--- selinux/policycoreutils/sandbox/Makefile	2011-09-09 20:12:56.073662844 +0200
+++ selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/sandbox/Makefile	2011-09-12 03:22:05.676502737 +0200
@@ -1,14 +1,16 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
-INITDIR ?= ${DESTDIR}/etc/rc.d/init.d/
-SYSCONFDIR ?= ${DESTDIR}/etc/sysconfig
+PREFIX ?= $(DESTDIR)/usr
+INITDIR ?= $(DESTDIR)/etc/rc.d/init.d/
+SYSCONFDIR ?= $(DESTDIR)/etc/sysconfig
 BINDIR ?= $(PREFIX)/bin
 SBINDIR ?= $(PREFIX)/sbin
+LIBDIR ?= $(PREFIX)/lib
+INCLUDEDIR ?= $(PREFIX)/include
 MANDIR ?= $(PREFIX)/share/man
-LOCALEDIR ?= /usr/share/locale
+LOCALEDIR ?= $(PREFIX)/share/locale
 SHAREDIR ?= $(PREFIX)/share/sandbox
-override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DPACKAGE="\"policycoreutils\""
-LDLIBS += -lselinux -lcap-ng 
+override CFLAGS += $(LDFLAGS) -I../../libselinux/include -I$(INCLUDEDIR) -DPACKAGE="\"policycoreutils\""
+LDLIBS += -L../../libselinux/src -lselinux -L$(LIBDIR) -lcap-ng
 
 all: sandbox seunshare sandboxX.sh start
 
diff -pru selinux/policycoreutils/scripts/Makefile selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/scripts/Makefile
--- selinux/policycoreutils/scripts/Makefile	2011-09-09 20:12:56.074662851 +0200
+++ selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/scripts/Makefile	2011-09-12 03:23:14.450939678 +0200
@@ -1,9 +1,9 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 BINDIR ?= $(PREFIX)/bin
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
-LOCALEDIR ?= /usr/share/locale
+LOCALEDIR ?= $(PREFIX)/share/locale
 
 all: fixfiles genhomedircon chcat
 
diff -pru selinux/policycoreutils/secon/Makefile selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/secon/Makefile
--- selinux/policycoreutils/secon/Makefile	2011-09-09 20:12:56.075662858 +0200
+++ selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/secon/Makefile	2011-09-12 03:13:21.263202624 +0200
@@ -1,15 +1,15 @@
 # secon tool - command-line context
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 INCLUDEDIR ?= $(PREFIX)/include
 BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
-LIBDIR ?= ${PREFIX}/lib
+LIBDIR ?= $(PREFIX)/lib
 
 WARNS=-Werror -W -Wall -Wundef -Wshadow -Wpointer-arith -Wbad-function-cast -Wcast-align -Wwrite-strings -Waggregate-return -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wnested-externs -Wno-format-zero-length -Wformat-nonliteral -Wformat-security -Wfloat-equal
 VERSION = $(shell cat ../VERSION)
 CFLAGS ?= $(WARNS) -O1
-override CFLAGS += -DVERSION=\"$(VERSION)\" -I$(INCLUDEDIR) 
-LDLIBS = -lselinux -L$(LIBDIR)
+override CFLAGS += -DVERSION=\"$(VERSION)\" -I../../libselinux/include -I$(INCLUDEDIR) 
+LDLIBS = -L../../libselinux/src -lselinux -L$(LIBDIR)
 
 all: secon
 
diff -pru selinux/policycoreutils/semanage/Makefile selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/semanage/Makefile
--- selinux/policycoreutils/semanage/Makefile	2011-09-09 20:12:56.075662858 +0200
+++ selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/semanage/Makefile	2011-09-12 03:28:17.878828483 +0200
@@ -1,8 +1,8 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 LIBDIR ?= $(PREFIX)/lib
 SBINDIR ?= $(PREFIX)/sbin
-MANDIR = $(PREFIX)/share/man
+MANDIR ?= $(PREFIX)/share/man
 PYLIBVER ?= $(shell python -c 'import sys;print "python%d.%d" % sys.version_info[0:2]')
 PYTHONLIBDIR ?= $(LIBDIR)/$(PYLIBVER)
 
diff -pru selinux/policycoreutils/semodule/Makefile selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/semodule/Makefile
--- selinux/policycoreutils/semodule/Makefile	2011-09-09 20:12:56.076662865 +0200
+++ selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/semodule/Makefile	2011-09-12 03:43:35.983488162 +0200
@@ -2,12 +2,12 @@
 PREFIX ?= $(DESTDIR)/usr
 INCLUDEDIR ?= $(PREFIX)/include
 SBINDIR ?= $(PREFIX)/sbin
-MANDIR = $(PREFIX)/share/man
-LIBDIR ?= ${PREFIX}/lib
+MANDIR ?= $(PREFIX)/share/man
+LIBDIR ?= $(PREFIX)/lib
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
+override CFLAGS += -I../../libsemanage/include -I$(INCLUDEDIR)
+LDLIBS = -L../../libsepol/src -lsepol -L../../libselinux/src -lselinux -L../../libsemanage/src -lsemanage -L$(LIBDIR)
 SEMODULE_OBJS = semodule.o
 
 all: semodule
diff -pru selinux/policycoreutils/semodule_deps/Makefile selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/semodule_deps/Makefile
--- selinux/policycoreutils/semodule_deps/Makefile	2011-09-09 20:12:56.076662865 +0200
+++ selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/semodule_deps/Makefile	2011-09-12 03:29:21.625217525 +0200
@@ -1,13 +1,13 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 INCLUDEDIR ?= $(PREFIX)/include
 BINDIR ?= $(PREFIX)/bin
-LIBDIR ?= ${PREFIX}/lib
+LIBDIR ?= $(PREFIX)/lib
 MANDIR ?= $(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = $(LIBDIR)/libsepol.a
+override CFLAGS += -I../../libsepol/include -I$(INCLUDEDIR)
+LDLIBS = ../../libsepol/src/libsepol.a
 
 all: semodule_deps
 
diff -pru selinux/policycoreutils/semodule_expand/Makefile selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/semodule_expand/Makefile
--- selinux/policycoreutils/semodule_expand/Makefile	2011-09-09 20:12:56.077662873 +0200
+++ selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/semodule_expand/Makefile	2011-09-12 03:11:53.599642029 +0200
@@ -1,13 +1,13 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 INCLUDEDIR ?= $(PREFIX)/include
 BINDIR ?= $(PREFIX)/bin
-LIBDIR ?= ${PREFIX}/lib
+LIBDIR ?= $(PREFIX)/lib
 MANDIR ?= $(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = -lsepol -lselinux -L$(LIBDIR)
+override CFLAGS += -I../../libsepol/include -I$(INCLUDEDIR)
+LDLIBS = -L../../libsepol/src -lsepol -L../../libselinux/src -lselinux -L$(LIBDIR)
 
 all: semodule_expand
 
diff -pru selinux/policycoreutils/semodule_link/Makefile selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/semodule_link/Makefile
--- selinux/policycoreutils/semodule_link/Makefile	2011-09-09 20:12:56.077662873 +0200
+++ selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/semodule_link/Makefile	2011-09-12 03:29:39.181324480 +0200
@@ -1,13 +1,13 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 INCLUDEDIR ?= $(PREFIX)/include
 BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
-LIBDIR ?= ${PREFIX}/lib
+LIBDIR ?= $(PREFIX)/lib
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = -lsepol -lselinux -L$(LIBDIR)
+override CFLAGS += -I../../libsepol/include -I$(INCLUDEDIR)
+LDLIBS = -L../../libsepol/src -lsepol -L../../libselinux/src -lselinux -L$(LIBDIR)
 
 all: semodule_link
 
diff -pru selinux/policycoreutils/semodule_package/Makefile selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/semodule_package/Makefile
--- selinux/policycoreutils/semodule_package/Makefile	2011-09-09 20:12:56.077662873 +0200
+++ selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/semodule_package/Makefile	2011-09-12 03:27:43.900619899 +0200
@@ -1,13 +1,13 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 INCLUDEDIR ?= $(PREFIX)/include
 BINDIR ?= $(PREFIX)/bin
-LIBDIR ?= ${PREFIX}/lib
+LIBDIR ?= $(PREFIX)/lib
 MANDIR ?= $(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = -lsepol -lselinux -L$(LIBDIR)
+override CFLAGS += -I../../libsepol/include -I$(INCLUDEDIR)
+LDLIBS = -L../../libsepol/src -lsepol -L../../libselinux/src -lselinux -L$(LIBDIR)
 
 all: semodule_package semodule_unpackage
 
diff -pru selinux/policycoreutils/sestatus/Makefile selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/sestatus/Makefile
--- selinux/policycoreutils/sestatus/Makefile	2011-09-09 20:12:56.077662873 +0200
+++ selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/sestatus/Makefile	2011-09-12 03:43:09.451314577 +0200
@@ -1,13 +1,14 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 SBINDIR ?= $(PREFIX)/sbin
-MANDIR = $(PREFIX)/share/man
+MANDIR ?= $(PREFIX)/share/man
 ETCDIR ?= $(DESTDIR)/etc
-LIBDIR ?= ${PREFIX}/lib
+LIBDIR ?= $(PREFIX)/lib
+INCLUDEDIR ?= $(PREFIX)/include
 
 CFLAGS = -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
-LDLIBS = -lselinux -L$(LIBDIR)
+override CFLAGS += -I../../libselinux/include -I$(INCLUDEDIR) -D_FILE_OFFSET_BITS=64
+LDLIBS = -L../../libselinux/src -lselinux -L$(LIBDIR)
 
 all: sestatus
 
diff -pru selinux/policycoreutils/setfiles/Makefile selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/setfiles/Makefile
--- selinux/policycoreutils/setfiles/Makefile	2011-09-09 20:12:56.078662881 +0200
+++ selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/setfiles/Makefile	2011-09-12 03:16:16.746296412 +0200
@@ -1,13 +1,14 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 SBINDIR ?= $(DESTDIR)/sbin
-MANDIR = $(PREFIX)/share/man
+MANDIR ?= $(PREFIX)/share/man
 LIBDIR ?= $(PREFIX)/lib
+INCLUDEDIR ?= $(PREFIX)/include
 AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
 
 CFLAGS = -g -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include
-LDLIBS = -lselinux -lsepol -L$(LIBDIR)
+override CFLAGS += -I../../libselinux/include -I../../libsepol/include -I$(INCLUDEDIR)
+LDLIBS = -L../../libselinux/src -lselinux -L../../libsepol/src -lsepol -L$(LIBDIR)
 
 ifeq (${AUDITH}, /usr/include/libaudit.h)
 	override CFLAGS += -DUSE_AUDIT
diff -pru selinux/policycoreutils/setsebool/Makefile selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/setsebool/Makefile
--- selinux/policycoreutils/setsebool/Makefile	2011-09-09 20:12:56.078662881 +0200
+++ selinux-12092011-git-fix-local-build-fix-load_policy-LIBDIR-v2/policycoreutils/setsebool/Makefile	2011-09-12 03:28:59.120080111 +0200
@@ -2,12 +2,12 @@
 PREFIX ?= $(DESTDIR)/usr
 INCLUDEDIR ?= $(PREFIX)/include
 SBINDIR ?= $(PREFIX)/sbin
-MANDIR = $(PREFIX)/share/man
-LIBDIR ?= ${PREFIX}/lib
+MANDIR ?= $(PREFIX)/share/man
+LIBDIR ?= $(PREFIX)/lib
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
+override CFLAGS += -I../../libselinux/include -I../../libsemanage/include -I$(INCLUDEDIR)
+LDLIBS = -L../../libsepol/src -lsepol -L../../libselinux/src -lselinux -L../../libsemanage/src -lsemanage -L$(LIBDIR)
 SETSEBOOL_OBJS = setsebool.o
 
 all: setsebool

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

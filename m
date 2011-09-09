Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p89MZAFa008431
	for <selinux@tycho.nsa.gov>; Fri, 9 Sep 2011 18:35:10 -0400
Received: from cp-out9.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p89MZ8vK021094
	for <selinux@tycho.nsa.gov>; Fri, 9 Sep 2011 22:35:08 GMT
Subject: Re: [RFC] Userspace top-level Makefile (was Re: [PATCH] Fix LIBDIR
 usage for load_policy)
From: Guido Trentalancia <guido@trentalancia.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: Eric Paris <eparis@parisplace.org>,
        SELinux Mail List
	 <selinux@tycho.nsa.gov>
Date: Sat, 10 Sep 2011 00:35:02 +0200
In-Reply-To: <4E6A8707.9080602@manicmethod.com>
References: <1315587716.2170.16.camel@vortex>
	  <1315588656.2170.26.camel@vortex>
	  <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
	  <1315590383.2170.32.camel@vortex> <1315591143.2170.36.camel@vortex>
	 <1315603187.2482.22.camel@vortex> <4E6A8707.9080602@manicmethod.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315607702.2482.28.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following patch is probably even better as it actually sorts out the
problem rather than just printing out a warning (it can still be
combined with the creation of a top-level README file):

diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/checkpolicy/Makefile selinux-09092011-local-headers/checkpolicy/Makefile
--- selinux-09092011-orig/checkpolicy/Makefile	2011-09-09 20:12:55.978662153 +0200
+++ selinux-09092011-local-headers/checkpolicy/Makefile	2011-09-10 00:21:16.242852130 +0200
@@ -12,7 +12,7 @@ YACC = bison -y
 
 CFLAGS ?= -g -Wall -Werror -Wshadow -O2 -pipe -fno-strict-aliasing
 
-override CFLAGS += -I. -I${INCLUDEDIR}
+override CFLAGS += -I. -I../libsepol/include -I${INCLUDEDIR}
 
 CHECKOBJS = y.tab.o lex.yy.o queue.o module_compiler.o parse_util.o \
 	    policy_define.o
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/checkpolicy/test/Makefile selinux-09092011-local-headers/checkpolicy/test/Makefile
--- selinux-09092011-orig/checkpolicy/test/Makefile	2011-09-09 20:12:55.980662174 +0200
+++ selinux-09092011-local-headers/checkpolicy/test/Makefile	2011-09-10 00:21:41.319968113 +0200
@@ -7,7 +7,7 @@ LIBDIR=$(PREFIX)/lib
 INCLUDEDIR ?= $(PREFIX)/include
 
 CFLAGS ?= -g -Wall -O2 -pipe
-override CFLAGS += -I$(INCLUDEDIR)
+override CFLAGS += -I../../libsepol/include -I$(INCLUDEDIR)
 
 LDLIBS=-lfl -lsepol -lselinux $(LIBDIR)/libsepol.a -L$(LIBDIR)
 
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/libselinux/src/Makefile selinux-09092011-local-headers/libselinux/src/Makefile
--- selinux-09092011-orig/libselinux/src/Makefile	2011-09-09 20:12:55.992662259 +0200
+++ selinux-09092011-local-headers/libselinux/src/Makefile	2011-09-10 00:19:29.083304085 +0200
@@ -54,7 +54,7 @@ SRCS= $(filter-out $(UNUSED_SRCS) $(GENE
 OBJS= $(patsubst %.c,%.o,$(SRCS))
 LOBJS= $(patsubst %.c,%.lo,$(SRCS))
 CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute
-override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(EMFLAGS)
+override CFLAGS += -I../include -I../../libsepol/include -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(EMFLAGS)
 RANLIB=ranlib
 
 ARCH := $(patsubst i%86,i386,$(shell uname -m))
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/libsemanage/src/Makefile selinux-09092011-local-headers/libsemanage/src/Makefile
--- selinux-09092011-orig/libsemanage/src/Makefile	2011-09-09 20:12:56.008662374 +0200
+++ selinux-09092011-local-headers/libsemanage/src/Makefile	2011-09-10 00:20:28.781620112 +0200
@@ -55,7 +55,7 @@ OBJS= $(patsubst %.c,%.o,$(SRCS)) conf-s
 LOBJS= $(patsubst %.c,%.lo,$(SRCS)) conf-scan.lo conf-parse.lo
 CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute
 
-override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE 
+override CFLAGS += -I../include -I../../libselinux/include -I../../libsepol/include -I$(INCLUDEDIR) -D_GNU_SOURCE 
 RANLIB=ranlib
 
 SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/load_policy/Makefile selinux-09092011-local-headers/policycoreutils/load_policy/Makefile
--- selinux-09092011-orig/policycoreutils/load_policy/Makefile	2011-09-09 20:12:56.035662568 +0200
+++ selinux-09092011-local-headers/policycoreutils/load_policy/Makefile	2011-09-10 00:23:15.891208602 +0200
@@ -6,7 +6,7 @@ MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+override CFLAGS += $(LDFLAGS) -I../../libselinux/include -I../../libsepol/include -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
 LDLIBS += -lsepol -lselinux -L$(PREFIX)/lib
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/newrole/Makefile selinux-09092011-local-headers/policycoreutils/newrole/Makefile
--- selinux-09092011-orig/policycoreutils/newrole/Makefile	2011-09-09 20:12:56.041662614 +0200
+++ selinux-09092011-local-headers/policycoreutils/newrole/Makefile	2011-09-10 00:23:33.847468496 +0200
@@ -22,7 +22,7 @@ VERSION = $(shell cat ../VERSION)
 
 CFLAGS ?= -Werror -Wall -W
 EXTRA_OBJS =
-override CFLAGS += -DVERSION=\"$(VERSION)\" $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+override CFLAGS += -DVERSION=\"$(VERSION)\" $(LDFLAGS) -I../../libselinux/include -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
 LDLIBS += -lselinux -L$(PREFIX)/lib
 ifeq (${PAMH}, /usr/include/security/pam_appl.h)
 	override CFLAGS += -DUSE_PAM
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/restorecond/Makefile selinux-09092011-local-headers/policycoreutils/restorecond/Makefile
--- selinux-09092011-orig/policycoreutils/restorecond/Makefile	2011-09-09 20:12:56.072662837 +0200
+++ selinux-09092011-local-headers/policycoreutils/restorecond/Makefile	2011-09-10 00:27:35.744510642 +0200
@@ -6,7 +6,7 @@ INITDIR = $(DESTDIR)/etc/rc.d/init.d
 SELINUXDIR = $(DESTDIR)/etc/selinux
 
 CFLAGS ?= -g -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
+override CFLAGS += -I../../libselinux/include -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
 LDLIBS += -lselinux -L$(PREFIX)/lib
 
 all: restorecond
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/run_init/Makefile selinux-09092011-local-headers/policycoreutils/run_init/Makefile
--- selinux-09092011-orig/policycoreutils/run_init/Makefile	2011-09-09 20:12:56.072662837 +0200
+++ selinux-09092011-local-headers/policycoreutils/run_init/Makefile	2011-09-10 00:23:55.251771687 +0200
@@ -9,7 +9,7 @@ PAMH = $(shell ls /usr/include/security/
 AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+override CFLAGS += -I../../libselinux/include -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
 LDLIBS += -lselinux -L$(PREFIX)/lib
 ifeq (${PAMH}, /usr/include/security/pam_appl.h)
 	override CFLAGS += -DUSE_PAM
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/sandbox/Makefile selinux-09092011-local-headers/policycoreutils/sandbox/Makefile
--- selinux-09092011-orig/policycoreutils/sandbox/Makefile	2011-09-09 20:12:56.073662844 +0200
+++ selinux-09092011-local-headers/policycoreutils/sandbox/Makefile	2011-09-10 00:24:11.399995764 +0200
@@ -7,7 +7,7 @@ SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 SHAREDIR ?= $(PREFIX)/share/sandbox
-override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DPACKAGE="\"policycoreutils\""
+override CFLAGS += $(LDFLAGS) -I../../libselinux/include -I$(PREFIX)/include -DPACKAGE="\"policycoreutils\""
 LDLIBS += -lselinux -lcap-ng 
 
 all: sandbox seunshare sandboxX.sh start
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/secon/Makefile selinux-09092011-local-headers/policycoreutils/secon/Makefile
--- selinux-09092011-orig/policycoreutils/secon/Makefile	2011-09-09 20:12:56.075662858 +0200
+++ selinux-09092011-local-headers/policycoreutils/secon/Makefile	2011-09-10 00:24:28.470228343 +0200
@@ -8,7 +8,7 @@ LIBDIR ?= ${PREFIX}/lib
 WARNS=-Werror -W -Wall -Wundef -Wshadow -Wpointer-arith -Wbad-function-cast -Wcast-align -Wwrite-strings -Waggregate-return -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wnested-externs -Wno-format-zero-length -Wformat-nonliteral -Wformat-security -Wfloat-equal
 VERSION = $(shell cat ../VERSION)
 CFLAGS ?= $(WARNS) -O1
-override CFLAGS += -DVERSION=\"$(VERSION)\" -I$(INCLUDEDIR) 
+override CFLAGS += -DVERSION=\"$(VERSION)\" -I../../libselinux/include -I$(INCLUDEDIR) 
 LDLIBS = -lselinux -L$(LIBDIR)
 
 all: secon
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/semodule/Makefile selinux-09092011-local-headers/policycoreutils/semodule/Makefile
--- selinux-09092011-orig/policycoreutils/semodule/Makefile	2011-09-09 20:12:56.076662865 +0200
+++ selinux-09092011-local-headers/policycoreutils/semodule/Makefile	2011-09-10 00:25:27.823003835 +0200
@@ -6,7 +6,7 @@ MANDIR = $(PREFIX)/share/man
 LIBDIR ?= ${PREFIX}/lib
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
+override CFLAGS += -I../../libsemanage/include -I$(INCLUDEDIR)
 LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
 SEMODULE_OBJS = semodule.o
 
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/semodule_deps/Makefile selinux-09092011-local-headers/policycoreutils/semodule_deps/Makefile
--- selinux-09092011-orig/policycoreutils/semodule_deps/Makefile	2011-09-09 20:12:56.076662865 +0200
+++ selinux-09092011-local-headers/policycoreutils/semodule_deps/Makefile	2011-09-10 00:26:35.478827621 +0200
@@ -6,7 +6,7 @@ LIBDIR ?= ${PREFIX}/lib
 MANDIR ?= $(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
+override CFLAGS += -I../../libsepol/include -I$(INCLUDEDIR)
 LDLIBS = $(LIBDIR)/libsepol.a
 
 all: semodule_deps
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/semodule_expand/Makefile selinux-09092011-local-headers/policycoreutils/semodule_expand/Makefile
--- selinux-09092011-orig/policycoreutils/semodule_expand/Makefile	2011-09-09 20:12:56.077662873 +0200
+++ selinux-09092011-local-headers/policycoreutils/semodule_expand/Makefile	2011-09-10 00:26:12.535555150 +0200
@@ -6,7 +6,7 @@ LIBDIR ?= ${PREFIX}/lib
 MANDIR ?= $(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
+override CFLAGS += -I../../libsepol/include -I$(INCLUDEDIR)
 LDLIBS = -lsepol -lselinux -L$(LIBDIR)
 
 all: semodule_expand
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/semodule_link/Makefile selinux-09092011-local-headers/policycoreutils/semodule_link/Makefile
--- selinux-09092011-orig/policycoreutils/semodule_link/Makefile	2011-09-09 20:12:56.077662873 +0200
+++ selinux-09092011-local-headers/policycoreutils/semodule_link/Makefile	2011-09-10 00:25:50.349285012 +0200
@@ -6,7 +6,7 @@ MANDIR ?= $(PREFIX)/share/man
 LIBDIR ?= ${PREFIX}/lib
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
+override CFLAGS += -I../../libsepol/include -I$(INCLUDEDIR)
 LDLIBS = -lsepol -lselinux -L$(LIBDIR)
 
 all: semodule_link
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/semodule_package/Makefile selinux-09092011-local-headers/policycoreutils/semodule_package/Makefile
--- selinux-09092011-orig/policycoreutils/semodule_package/Makefile	2011-09-09 20:12:56.077662873 +0200
+++ selinux-09092011-local-headers/policycoreutils/semodule_package/Makefile	2011-09-10 00:25:10.519782975 +0200
@@ -6,7 +6,7 @@ LIBDIR ?= ${PREFIX}/lib
 MANDIR ?= $(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
+override CFLAGS += -I../../libsepol/include -I$(INCLUDEDIR)
 LDLIBS = -lsepol -lselinux -L$(LIBDIR)
 
 all: semodule_package semodule_unpackage
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/sestatus/Makefile selinux-09092011-local-headers/policycoreutils/sestatus/Makefile
--- selinux-09092011-orig/policycoreutils/sestatus/Makefile	2011-09-09 20:12:56.077662873 +0200
+++ selinux-09092011-local-headers/policycoreutils/sestatus/Makefile	2011-09-10 00:24:43.633431325 +0200
@@ -6,7 +6,7 @@ ETCDIR ?= $(DESTDIR)/etc
 LIBDIR ?= ${PREFIX}/lib
 
 CFLAGS = -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
+override CFLAGS += -I../../libselinux/include -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
 LDLIBS = -lselinux -L$(LIBDIR)
 
 all: sestatus
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/setfiles/Makefile selinux-09092011-local-headers/policycoreutils/setfiles/Makefile
--- selinux-09092011-orig/policycoreutils/setfiles/Makefile	2011-09-09 20:12:56.078662881 +0200
+++ selinux-09092011-local-headers/policycoreutils/setfiles/Makefile	2011-09-10 00:22:27.735485936 +0200
@@ -6,7 +6,7 @@ LIBDIR ?= $(PREFIX)/lib
 AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
 
 CFLAGS = -g -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include
+override CFLAGS += -I../../libsepol/include -I../../libselinux/include -I$(PREFIX)/include
 LDLIBS = -lselinux -lsepol -L$(LIBDIR)
 
 ifeq (${AUDITH}, /usr/include/libaudit.h)
diff -x '*.po' -x '*.pot' -pru selinux-09092011-orig/policycoreutils/setsebool/Makefile selinux-09092011-local-headers/policycoreutils/setsebool/Makefile
--- selinux-09092011-orig/policycoreutils/setsebool/Makefile	2011-09-09 20:12:56.078662881 +0200
+++ selinux-09092011-local-headers/policycoreutils/setsebool/Makefile	2011-09-10 00:27:16.895301985 +0200
@@ -6,7 +6,7 @@ MANDIR = $(PREFIX)/share/man
 LIBDIR ?= ${PREFIX}/lib
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
+override CFLAGS += -I../../libselinux/include -I../../libsemanage/include -I$(INCLUDEDIR)
 LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
 SETSEBOOL_OBJS = setsebool.o
 

On Fri, 2011-09-09 at 17:37 -0400, Joshua Brindle wrote:
> Guido Trentalancia wrote:
> > -all install relabel clean test indent:
> > +all relabel test indent:
> >   	@for subdir in $(SUBDIRS); do \
> > -		(cd $$subdir&&  $(MAKE) $@) || exit 1; \
> > +		(cd $$subdir&&  $(MAKE) $@&&  $(MAKE) install) || exit 1; \
> > +	done
> > +	@for subdir_bin in $(SUBDIRS_BIN); do \
> > +		(cd $$subdir_bin&&  $(MAKE) $@) || exit 1; \
> > +	done
> > +
> > +install:
> > +	@for subdir in $(SUBDIRS); do \
> > +		(cd $$subdir&&  $(MAKE) install) || exit 1; \
> > +	done
> > +	@for subdir_bin in $(SUBDIRS_BIN); do \
> > +		(cd $$subdir_bin&&  $(MAKE) install) || exit 1; \
> >   	done
> >
> >   install-pywrap swigify:
> > @@ -17,6 +29,14 @@ install-pywrap swigify:
> >   		(cd $$subdir&&  $(MAKE) $@) || exit 1; \
> >   	done
> >
> 
> Nack. We can't require install in the build target and bail if it fails, this is 
> completely unfriendly to developers who don't want to install all the libraries 
> on their system during development, and those are the people using git.
> 
> If you are doing work on libselinux and you install it to your system before 
> testing it locally you can easily break your machine and have to boot from a 
> rescue disk.
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

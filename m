Subject: Re: [PATCH v6] Fix includes for userspace tools and libraries
From: Guido Trentalancia <guido@trentalancia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@redhat.com>, Eric Paris <eparis@parisplace.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Date: Sat, 17 Sep 2011 22:48:37 +0200
In-Reply-To: <1316116803.16483.106.camel@moss-pluto>
References: <1315587716.2170.16.camel@vortex>
	 <1315588656.2170.26.camel@vortex>
	 <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
	 <1315832253.17035.5.camel@moss-pluto> <1315859373.2223.19.camel@vortex>
	 <4E6E8149.30702@redhat.com> <1315917697.12522.1.camel@moss-pluto>
	 <1315931495.2248.29.camel@vortex> <1315934421.12522.46.camel@moss-pluto>
	 <1315938784.2218.14.camel@vortex> <1315939689.12522.51.camel@moss-pluto>
	 <1315941501.2218.26.camel@vortex>  <1315941958.12522.77.camel@moss-pluto>
	 <1315942469.12522.81.camel@moss-pluto> <1315944244.2218.41.camel@vortex>
	 <1315945618.2738.13.camel@localhost>  <1315951507.2218.91.camel@vortex>
	 <1316004965.26965.9.camel@moss-pluto>  <1316054641.23290.48.camel@vortex>
	 <1316091385.16483.13.camel@moss-pluto>  <1316102675.2202.23.camel@vortex>
	 <1316104531.16483.26.camel@moss-pluto>  <1316106206.2202.33.camel@vortex>
	 <1316106992.16483.35.camel@moss-pluto>  <1316107603.2202.43.camel@vortex>
	 <1316110489.16483.68.camel@moss-pluto>  <1316113928.2202.76.camel@vortex>
	 <1316116803.16483.106.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316292518.2249.61.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Stephen.

Attached below please find the latest version of the patch with your
changes introduced.

For reference, your changes were intended to add variables that define
static libraries to be used for linking. By defining the local versions
in the top-level Makefile and generic default system-wide versions in
the lower-level Makefiles, it is possible to build the whole libraries
+tools bundle from git. Otherwise, it is still possible to distribute
the separate components individually from the same tree and they will
still build properly as the lower-level Makefiles still define the
system-wide static libraries for linking.

I have therefore removed the useless make_release.sh script.

I have also documented the USE_PAM build-time option for run_init in the
top-level README file. I believe a top-level README file is very
courteous and useful for this sort of notes.

Of course, I can (re)produce a better description of the patch if
needed.

diff -pruN selinux-17092011-orig/checkpolicy/Makefile selinux-17092011-patched-sds/checkpolicy/Makefile
--- selinux-17092011-orig/checkpolicy/Makefile	2011-09-09 20:12:55.978662153 +0200
+++ selinux-17092011-patched-sds/checkpolicy/Makefile	2011-09-17 21:52:42.220843537 +0200
@@ -6,6 +6,7 @@ BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
 LIBDIR ?= $(PREFIX)/lib
 INCLUDEDIR ?= $(PREFIX)/include
+LIBSEPOLSTATIC ?= $(LIBDIR)/libsepol.a
 TARGETS = checkpolicy checkmodule
 
 YACC = bison -y
@@ -19,7 +20,7 @@ CHECKOBJS = y.tab.o lex.yy.o queue.o mod
 CHECKPOLOBJS = $(CHECKOBJS) checkpolicy.o
 CHECKMODOBJS = $(CHECKOBJS) checkmodule.o
 
-LDLIBS=$(LIBDIR)/libsepol.a -lfl
+LDLIBS=$(LIBSEPOLSTATIC) -L$(LIBDIR) -lfl
 
 GENERATED=lex.yy.c y.tab.c y.tab.h
 
diff -pruN selinux-17092011-orig/checkpolicy/test/Makefile selinux-17092011-patched-sds/checkpolicy/test/Makefile
--- selinux-17092011-orig/checkpolicy/test/Makefile	2011-09-09 20:12:55.980662174 +0200
+++ selinux-17092011-patched-sds/checkpolicy/test/Makefile	2011-09-17 22:02:20.452634304 +0200
@@ -2,14 +2,15 @@
 # Makefile for building the dispol program
 #
 PREFIX ?= $(DESTDIR)/usr
-BINDIR=$(PREFIX)/bin
-LIBDIR=$(PREFIX)/lib
+BINDIR ?= $(PREFIX)/bin
+LIBDIR ?= $(PREFIX)/lib
 INCLUDEDIR ?= $(PREFIX)/include
+LIBSEPOLSTATIC ?= $(LIBDIR)/libsepol.a
 
 CFLAGS ?= -g -Wall -O2 -pipe
 override CFLAGS += -I$(INCLUDEDIR)
 
-LDLIBS=-lfl -lsepol -lselinux $(LIBDIR)/libsepol.a -L$(LIBDIR)
+LDLIBS=-lsepol -lselinux $(LIBSEPOLSTATIC) -L$(LIBDIR) -lfl
 
 all: dispol dismod
 
diff -pruN selinux-17092011-orig/libselinux/src/Makefile selinux-17092011-patched-sds/libselinux/src/Makefile
--- selinux-17092011-orig/libselinux/src/Makefile	2011-09-17 07:03:41.139162328 +0200
+++ selinux-17092011-patched-sds/libselinux/src/Makefile	2011-09-17 21:46:07.524968539 +0200
@@ -8,6 +8,7 @@ PYPREFIX ?= $(notdir $(PYTHON))
 PREFIX ?= $(DESTDIR)/usr
 LIBDIR ?= $(PREFIX)/lib
 SHLIBDIR ?= $(DESTDIR)/lib
+LIBSEPOLSTATIC ?= $(LIBDIR)/libsepol.a
 INCLUDEDIR ?= $(PREFIX)/include
 PYLIBVER ?= $(shell $(PYTHON) -c 'import sys;print("python%d.%d" % sys.version_info[0:2])')
 PYINC ?= $(shell pkg-config --cflags $(PYPREFIX))
@@ -102,7 +103,7 @@ $(AUDIT2WHYLOBJ): audit2why.c
 	$(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED -c -o $@ $<
 
 $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux ${LIBDIR}/libsepol.a -L$(LIBDIR) -Wl,-soname,$@
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux $(LIBSEPOLSTATIC) -L$(LIBDIR) -Wl,-soname,$@
 
 %.o:  %.c policy.h
 	$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
diff -pruN selinux-17092011-orig/libsemanage/src/Makefile selinux-17092011-patched-sds/libsemanage/src/Makefile
--- selinux-17092011-orig/libsemanage/src/Makefile	2011-09-09 20:12:56.008662374 +0200
+++ selinux-17092011-patched-sds/libsemanage/src/Makefile	2011-09-17 21:22:46.020329558 +0200
@@ -87,7 +87,7 @@ $(LIBA): $(OBJS)
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -lselinux -lbz2 -lustr -L$(LIBDIR) -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -lselinux -L$(LIBDIR) -lbz2 -lustr -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
 	ln -sf $@ $(TARGET)
 
 $(LIBPC): $(LIBPC).in
diff -pruN selinux-17092011-orig/libsemanage/tests/Makefile selinux-17092011-patched-sds/libsemanage/tests/Makefile
--- selinux-17092011-orig/libsemanage/tests/Makefile	2011-09-09 20:12:56.016662432 +0200
+++ selinux-17092011-patched-sds/libsemanage/tests/Makefile	2011-09-17 22:14:10.383231543 +0200
@@ -1,19 +1,24 @@
+PREFIX ?= $(DESTDIR)/usr
+LIBDIR ?= $(PREFIX)/lib
+
+LIBSELINUXSTATIC ?= $(LIBDIR)/libselinux.a
+LIBSEPOLSTATIC ?= $(LIBDIR)/libsepol.a
+
 # Add your test source files here:
 SOURCES = $(wildcard *.c)
 
-# Point this variable to the libsemanage source directory you want to test:
-TESTSRC=../src
+# Point this variable to the libsemanage source directory:
+LIBSEMANAGESRC = ../src
 
 # Add the required external object files here:
-LIBS = ../src/libsemanage.a ../../libselinux/src/libselinux.a ../../libsepol/src/libsepol.a
+LIBS = $(LIBSEMANAGESRC)/libsemanage.a $(LIBSELINUXSTATIC) $(LIBSEPOLSTATIC)
 
 ###########################################################################
 
 EXECUTABLE = libsemanage-tests
-CC = gcc
 CFLAGS = -c -g -o0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter
-INCLUDE = -I$(TESTSRC) -I$(TESTSRC)/../include
-LDFLAGS = -lcunit -lustr -lbz2
+INCLUDE = -I$(LIBSEMANAGESRC) -I$(LIBSEMANAGESRC)/../include
+LDFLAGS = -L$(LIBDIR) -lcunit -lustr -lbz2
 OBJECTS = $(SOURCES:.c=.o) 
 
 all: $(EXECUTABLE) 
diff -pruN selinux-17092011-orig/Makefile selinux-17092011-patched-sds/Makefile
--- selinux-17092011-orig/Makefile	2011-09-09 20:12:55.977662144 +0200
+++ selinux-17092011-patched-sds/Makefile	2011-09-17 22:12:08.611333333 +0200
@@ -3,10 +3,20 @@ PYSUBDIRS=libselinux libsemanage
 DISTCLEANSUBIDRS=libselinux libsemanage
 
 ifeq ($(DEBUG),1)
-	export CFLAGS = -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror
-	export LDFLAGS = -g
+	CFLAGS += -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror
+	LDFLAGS += -g
 endif
 
+# Released components are built separately (from lower-level Makefiles) and generally they use the
+# system-wide static libraries and header files that are already installed.
+export LIBSELINUXSTATIC = $(CURDIR)/libselinux/src/libselinux.a
+export LIBSEPOLSTATIC = $(CURDIR)/libsepol/src/libsepol.a
+
+CFLAGS += -I$(CURDIR)/libselinux/include -I$(CURDIR)/libsepol/include -I$(CURDIR)/libsemanage/include
+LDFLAGS += -L$(CURDIR)/libselinux/src -L$(CURDIR)/libsepol/src -L$(CURDIR)/libsemanage/src
+export CFLAGS
+export LDFLAGS
+
 all install relabel clean test indent:
 	@for subdir in $(SUBDIRS); do \
 		(cd $$subdir && $(MAKE) $@) || exit 1; \
diff -pruN selinux-17092011-orig/policycoreutils/audit2allow/Makefile selinux-17092011-patched-sds/policycoreutils/audit2allow/Makefile
--- selinux-17092011-orig/policycoreutils/audit2allow/Makefile	2011-09-09 20:12:56.034662561 +0200
+++ selinux-17092011-patched-sds/policycoreutils/audit2allow/Makefile	2011-09-17 21:22:46.021329584 +0200
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
 
diff -pruN selinux-17092011-orig/policycoreutils/audit2why/Makefile selinux-17092011-patched-sds/policycoreutils/audit2why/Makefile
--- selinux-17092011-orig/policycoreutils/audit2why/Makefile	2011-09-09 20:12:56.035662568 +0200
+++ selinux-17092011-patched-sds/policycoreutils/audit2why/Makefile	2011-09-17 21:22:46.022329611 +0200
@@ -1,5 +1,5 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
 
diff -pruN selinux-17092011-orig/policycoreutils/load_policy/Makefile selinux-17092011-patched-sds/policycoreutils/load_policy/Makefile
--- selinux-17092011-orig/policycoreutils/load_policy/Makefile	2011-09-09 20:12:56.035662568 +0200
+++ selinux-17092011-patched-sds/policycoreutils/load_policy/Makefile	2011-09-17 21:22:46.022329611 +0200
@@ -1,13 +1,15 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 SBINDIR ?= $(DESTDIR)/sbin
 USRSBINDIR ?= $(PREFIX)/sbin
+INCLUDEDIR ?= $(PREFIX)/include
+LIBDIR ?= $(PREFIX)/lib
 MANDIR ?= $(PREFIX)/share/man
-LOCALEDIR ?= /usr/share/locale
+LOCALEDIR ?= $(PREFIX)/share/locale
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-LDLIBS += -lsepol -lselinux -L$(PREFIX)/lib
+override CFLAGS += $(LDFLAGS) -I$(INCLUDEDIR) -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+LDLIBS += -lsepol -lselinux -L$(LIBDIR)
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
diff -pruN selinux-17092011-orig/policycoreutils/mcstrans/src/Makefile selinux-17092011-patched-sds/policycoreutils/mcstrans/src/Makefile
--- selinux-17092011-orig/policycoreutils/mcstrans/src/Makefile	2011-09-09 20:12:56.040662607 +0200
+++ selinux-17092011-patched-sds/policycoreutils/mcstrans/src/Makefile	2011-09-17 22:20:21.141097699 +0200
@@ -1,34 +1,40 @@
+# Installation directories
+PREFIX ?= $(DESTDIR)/usr
+SBINDIR ?= $(DESTDIR)/sbin
+INITDIR ?= $(DESTDIR)/etc/rc.d/init.d
+
 ARCH = $(shell uname -i)
 ifeq "$(ARCH)" "x86_64"
 	# In case of 64 bit system, use these lines
-	LIBDIR=/usr/lib64
+	LIBDIR ?= $(PREFIX)/lib64
 else 
 ifeq "$(ARCH)" "i686"
 	# In case of 32 bit system, use these lines
-	LIBDIR=/usr/lib
+	LIBDIR ?= $(PREFIX)/lib
 else
 ifeq "$(ARCH)" "i386"
 	# In case of 32 bit system, use these lines
-	LIBDIR=/usr/lib
+	LIBDIR ?= $(PREFIX)/lib
+else
+	LIBDIR ?= $(PREFIX)/lib
 endif
 endif
 endif
-# Installation directories.
-PREFIX  ?= $(DESTDIR)/usr
-SBINDIR ?= $(DESTDIR)/sbin
-INITDIR ?= $(DESTDIR)/etc/rc.d/init.d
+
+LIBSEPOLSTATIC ?= $(LIBDIR)/libsepol.a
 
 PROG_SRC=mcstrans.c  mcscolor.c  mcstransd.c  mls_level.c
 PROG_OBJS= $(patsubst %.c,%.o,$(PROG_SRC))
 PROG=mcstransd
 INITSCRIPT=mcstrans
+
 CFLAGS ?= -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
 override CFLAGS += -I../include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
 
 all: $(PROG)
 
 $(PROG): $(PROG_OBJS)
-	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre $(LIBDIR)/libsepol.a
+	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux $(LIBSEPOLSTATIC) -L$(LIBDIR) -lcap -lpcre
 
 %.o:  %.c 
 	$(CC) $(CFLAGS) -fPIE -c -o $@ $<
diff -pruN selinux-17092011-orig/policycoreutils/mcstrans/utils/Makefile selinux-17092011-patched-sds/policycoreutils/mcstrans/utils/Makefile
--- selinux-17092011-orig/policycoreutils/mcstrans/utils/Makefile	2011-09-09 20:12:56.041662614 +0200
+++ selinux-17092011-patched-sds/policycoreutils/mcstrans/utils/Makefile	2011-09-17 22:20:59.192398922 +0200
@@ -5,23 +5,26 @@ BINDIR ?= $(PREFIX)/sbin
 ARCH = $(shell uname -i)
 ifeq "$(ARCH)" "x86_64"
         # In case of 64 bit system, use these lines
-        LIBDIR=/usr/lib64
+        LIBDIR ?= $(PREFIX)/lib64
 else
 ifeq "$(ARCH)" "i686"
         # In case of 32 bit system, use these lines
-        LIBDIR=/usr/lib
+        LIBDIR ?= $(PREFIX)/lib
 else
 ifeq "$(ARCH)" "i386"
         # In case of 32 bit system, use these lines
-        LIBDIR=/usr/lib
+        LIBDIR ?= $(PREFIX)/lib
+else
+	LIBDIR ?= $(PREFIX)/lib
 endif
 endif
 endif
 
+LIBSEPOLSTATIC ?= $(LIBDIR)/libsepol.a
 
 CFLAGS ?= -Wall
 override CFLAGS += -I../src -D_GNU_SOURCE
-LDLIBS += -L../src ../src/mcstrans.o ../src/mls_level.o -lselinux -lpcre $(LIBDIR)/libsepol.a
+LDLIBS += -L../src ../src/mcstrans.o ../src/mls_level.o -lselinux -L$(LIBDIR) -lpcre $(LIBSEPOLSTATIC)
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
diff -pruN selinux-17092011-orig/policycoreutils/newrole/Makefile selinux-17092011-patched-sds/policycoreutils/newrole/Makefile
--- selinux-17092011-orig/policycoreutils/newrole/Makefile	2011-09-09 20:12:56.041662614 +0200
+++ selinux-17092011-patched-sds/policycoreutils/newrole/Makefile	2011-09-17 21:22:46.023329633 +0200
@@ -1,9 +1,11 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
+INCLUDEDIR ?= $(PREFIX)/include
+LIBDIR ?= $(PREFIX)/lib
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
+override CFLAGS += -DVERSION=\"$(VERSION)\" $(LDFLAGS) -I$(INCLUDEDIR) -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+LDLIBS += -lselinux -L$(LIBDIR)
 ifeq (${PAMH}, /usr/include/security/pam_appl.h)
 	override CFLAGS += -DUSE_PAM
 	EXTRA_OBJS += hashtab.o
diff -pruN selinux-17092011-orig/policycoreutils/restorecond/Makefile selinux-17092011-patched-sds/policycoreutils/restorecond/Makefile
--- selinux-17092011-orig/policycoreutils/restorecond/Makefile	2011-09-09 20:12:56.072662837 +0200
+++ selinux-17092011-patched-sds/policycoreutils/restorecond/Makefile	2011-09-17 21:22:46.023329633 +0200
@@ -1,13 +1,15 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 SBINDIR ?= $(PREFIX)/sbin
-MANDIR = $(PREFIX)/share/man
-INITDIR = $(DESTDIR)/etc/rc.d/init.d
-SELINUXDIR = $(DESTDIR)/etc/selinux
+INCLUDEDIR ?= $(PREFIX)/include
+LIBDIR ?= $(PREFIX)/lib
+MANDIR ?= $(PREFIX)/share/man
+INITDIR ?= $(DESTDIR)/etc/rc.d/init.d
+SELINUXDIR ?= $(DESTDIR)/etc/selinux
 
 CFLAGS ?= -g -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
-LDLIBS += -lselinux -L$(PREFIX)/lib
+override CFLAGS += -I$(INCLUDEDIR) -D_FILE_OFFSET_BITS=64
+LDLIBS += -lselinux -L$(LIBDIR)
 
 all: restorecond
 
diff -pruN selinux-17092011-orig/policycoreutils/run_init/Makefile selinux-17092011-patched-sds/policycoreutils/run_init/Makefile
--- selinux-17092011-orig/policycoreutils/run_init/Makefile	2011-09-09 20:12:56.072662837 +0200
+++ selinux-17092011-patched-sds/policycoreutils/run_init/Makefile	2011-09-17 21:22:46.023329633 +0200
@@ -1,16 +1,17 @@
-
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 SBINDIR ?= $(PREFIX)/sbin
+INCLUDEDIR ?= $(PREFIX)/include
+LIBDIR ?= $(PREFIX)/lib
 MANDIR ?= $(PREFIX)/share/man
 ETCDIR ?= $(DESTDIR)/etc
-LOCALEDIR ?= /usr/share/locale
+LOCALEDIR ?= $(PREFIX)/share/locale
 PAMH = $(shell ls /usr/include/security/pam_appl.h 2>/dev/null)
 AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-LDLIBS += -lselinux -L$(PREFIX)/lib
+override CFLAGS += -I$(INCLUDEDIR) -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+LDLIBS += -lselinux -L$(LIBDIR)
 ifeq (${PAMH}, /usr/include/security/pam_appl.h)
 	override CFLAGS += -DUSE_PAM
 	LDLIBS += -lpam -lpam_misc
diff -pruN selinux-17092011-orig/policycoreutils/sandbox/Makefile selinux-17092011-patched-sds/policycoreutils/sandbox/Makefile
--- selinux-17092011-orig/policycoreutils/sandbox/Makefile	2011-09-17 07:03:41.146162385 +0200
+++ selinux-17092011-patched-sds/policycoreutils/sandbox/Makefile	2011-09-17 21:25:36.947154826 +0200
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
+INCLUDEDIR ?= $(PREFIX)/include
+LIBDIR ?= $(PREFIX)/lib
 MANDIR ?= $(PREFIX)/share/man
-LOCALEDIR ?= /usr/share/locale
+LOCALEDIR ?= $(PREFIX)/share/locale
 SHAREDIR ?= $(PREFIX)/share/sandbox
-override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DPACKAGE="\"policycoreutils\"" -Wall -Werror -Wextra
-LDLIBS += -lcgroup -lselinux -lcap-ng
+override CFLAGS += $(LDFLAGS) -I$(INCLUDEDIR) -DPACKAGE="\"policycoreutils\"" -Wall -Werror -Wextra
+LDLIBS += -lselinux -L$(LIBDIR) -lcgroup -lcap-ng
 
 all: sandbox seunshare sandboxX.sh start
 
diff -pruN selinux-17092011-orig/policycoreutils/scripts/genhomedircon.8 selinux-17092011-patched-sds/policycoreutils/scripts/genhomedircon.8
--- selinux-17092011-orig/policycoreutils/scripts/genhomedircon.8	2011-09-09 20:12:56.074662851 +0200
+++ selinux-17092011-patched-sds/policycoreutils/scripts/genhomedircon.8	2011-09-17 21:22:46.024329656 +0200
@@ -1,37 +1,21 @@
-.\" Hey, Emacs! This is an -*- nroff -*- source file.
-.\" Copyright (c) 2010 Dan Walsh <dwalsh@redhat.com>
-.\"
-.\" This is free documentation; you can redistribute it and/or
-.\" modify it under the terms of the GNU General Public License as
-.\" published by the Free Software Foundation; either version 2 of
-.\" the License, or (at your option) any later version.
-.\"
-.\" The GNU General Public License's references to "object code"
-.\" and "executables" are to be interpreted as the output of any
-.\" document formatting or typesetting system, including
-.\" intermediate and printed output.
-.\"
-.\" This manual is distributed in the hope that it will be useful,
-.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
-.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-.\" GNU General Public License for more details.
-.\"
-.\" You should have received a copy of the GNU General Public
-.\" License along with this manual; if not, write to the Free
-.\" Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139,
-.\" USA.
-.\"
-.\"
-.TH GENHOMEDIRCON "8" "May 2010" "Security Enhanced Linux" "SELinux"
+.TH GENHOMEDIRCON "8" "Sep 2011" "Security Enhanced Linux" "SELinux"
 .SH NAME
 genhomedircon \- generate SELinux file context configuration entries for user home directories
 .SH SYNOPSIS
 .B genhomedircon
-is a script that executes semodule to rebuild policy and create the
-labels for HOMEDIRS based on home directories returned by the getpw calls.
+is a script that executes
+.B semodule
+to rebuild the SELinux policy and to create the
+labels for each user home directory based on directory paths returned by calls to getpwent().
 
-This functionality is enabled via the usepasswd flag in /etc/selinux/semanage.conf.
+This functionality can be disabled by using the "usepasswd" flag in /etc/selinux/semanage.conf
+(such flag can either take the value "true" or "false" and by default it is set to "true").
 
 .SH AUTHOR
 This manual page was written by
 .I Dan Walsh <dwalsh@redhat.com>
+
+The supporting functionality in the semanage library was written by Tresys Technology.
+
+.SH "SEE ALSO"
+semodule(8), getpwent(3), getpwent_r(3)
diff -pruN selinux-17092011-orig/policycoreutils/scripts/Makefile selinux-17092011-patched-sds/policycoreutils/scripts/Makefile
--- selinux-17092011-orig/policycoreutils/scripts/Makefile	2011-09-09 20:12:56.074662851 +0200
+++ selinux-17092011-patched-sds/policycoreutils/scripts/Makefile	2011-09-17 21:22:46.024329656 +0200
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
 
@@ -11,7 +11,10 @@ install: all
 	-mkdir -p $(BINDIR)
 	install -m 755 chcat $(BINDIR)
 	install -m 755 fixfiles $(DESTDIR)/sbin
-	install -m 755 genhomedircon  $(SBINDIR)
+	@echo "#!/bin/sh" > genhomedircon
+	@echo >> genhomedircon
+	@echo "$(SBINDIR)/semodule -Bn" >> genhomedircon
+	install -m 755 genhomedircon $(SBINDIR)
 	-mkdir -p $(MANDIR)/man8
 	install -m 644 fixfiles.8 $(MANDIR)/man8/
 	install -m 644 genhomedircon.8 $(MANDIR)/man8/
diff -pruN selinux-17092011-orig/policycoreutils/secon/Makefile selinux-17092011-patched-sds/policycoreutils/secon/Makefile
--- selinux-17092011-orig/policycoreutils/secon/Makefile	2011-09-09 20:12:56.075662858 +0200
+++ selinux-17092011-patched-sds/policycoreutils/secon/Makefile	2011-09-17 21:22:46.025329687 +0200
@@ -1,9 +1,9 @@
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
diff -pruN selinux-17092011-orig/policycoreutils/semanage/Makefile selinux-17092011-patched-sds/policycoreutils/semanage/Makefile
--- selinux-17092011-orig/policycoreutils/semanage/Makefile	2011-09-09 20:12:56.075662858 +0200
+++ selinux-17092011-patched-sds/policycoreutils/semanage/Makefile	2011-09-17 21:22:46.025329687 +0200
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
 
diff -pruN selinux-17092011-orig/policycoreutils/semodule/Makefile selinux-17092011-patched-sds/policycoreutils/semodule/Makefile
--- selinux-17092011-orig/policycoreutils/semodule/Makefile	2011-09-09 20:12:56.076662865 +0200
+++ selinux-17092011-patched-sds/policycoreutils/semodule/Makefile	2011-09-17 21:22:46.025329687 +0200
@@ -2,8 +2,8 @@
 PREFIX ?= $(DESTDIR)/usr
 INCLUDEDIR ?= $(PREFIX)/include
 SBINDIR ?= $(PREFIX)/sbin
-MANDIR = $(PREFIX)/share/man
-LIBDIR ?= ${PREFIX}/lib
+MANDIR ?= $(PREFIX)/share/man
+LIBDIR ?= $(PREFIX)/lib
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -I$(INCLUDEDIR)
diff -pruN selinux-17092011-orig/policycoreutils/semodule_deps/Makefile selinux-17092011-patched-sds/policycoreutils/semodule_deps/Makefile
--- selinux-17092011-orig/policycoreutils/semodule_deps/Makefile	2011-09-09 20:12:56.076662865 +0200
+++ selinux-17092011-patched-sds/policycoreutils/semodule_deps/Makefile	2011-09-17 21:55:04.748671613 +0200
@@ -1,13 +1,14 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 INCLUDEDIR ?= $(PREFIX)/include
 BINDIR ?= $(PREFIX)/bin
-LIBDIR ?= ${PREFIX}/lib
+LIBDIR ?= $(PREFIX)/lib
+LIBSEPOLSTATIC ?= $(LIBDIR)/libsepol.a
 MANDIR ?= $(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = $(LIBDIR)/libsepol.a
+LDLIBS = $(LIBSEPOLSTATIC)
 
 all: semodule_deps
 
diff -pruN selinux-17092011-orig/policycoreutils/semodule_expand/Makefile selinux-17092011-patched-sds/policycoreutils/semodule_expand/Makefile
--- selinux-17092011-orig/policycoreutils/semodule_expand/Makefile	2011-09-09 20:12:56.077662873 +0200
+++ selinux-17092011-patched-sds/policycoreutils/semodule_expand/Makefile	2011-09-17 21:22:46.026329705 +0200
@@ -1,8 +1,8 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 INCLUDEDIR ?= $(PREFIX)/include
 BINDIR ?= $(PREFIX)/bin
-LIBDIR ?= ${PREFIX}/lib
+LIBDIR ?= $(PREFIX)/lib
 MANDIR ?= $(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
diff -pruN selinux-17092011-orig/policycoreutils/semodule_link/Makefile selinux-17092011-patched-sds/policycoreutils/semodule_link/Makefile
--- selinux-17092011-orig/policycoreutils/semodule_link/Makefile	2011-09-09 20:12:56.077662873 +0200
+++ selinux-17092011-patched-sds/policycoreutils/semodule_link/Makefile	2011-09-17 21:22:46.026329705 +0200
@@ -1,9 +1,9 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 INCLUDEDIR ?= $(PREFIX)/include
 BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
-LIBDIR ?= ${PREFIX}/lib
+LIBDIR ?= $(PREFIX)/lib
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -I$(INCLUDEDIR)
diff -pruN selinux-17092011-orig/policycoreutils/semodule_package/Makefile selinux-17092011-patched-sds/policycoreutils/semodule_package/Makefile
--- selinux-17092011-orig/policycoreutils/semodule_package/Makefile	2011-09-09 20:12:56.077662873 +0200
+++ selinux-17092011-patched-sds/policycoreutils/semodule_package/Makefile	2011-09-17 21:22:46.026329705 +0200
@@ -1,8 +1,8 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 INCLUDEDIR ?= $(PREFIX)/include
 BINDIR ?= $(PREFIX)/bin
-LIBDIR ?= ${PREFIX}/lib
+LIBDIR ?= $(PREFIX)/lib
 MANDIR ?= $(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
diff -pruN selinux-17092011-orig/policycoreutils/sepolgen-ifgen/Makefile selinux-17092011-patched-sds/policycoreutils/sepolgen-ifgen/Makefile
--- selinux-17092011-orig/policycoreutils/sepolgen-ifgen/Makefile	2011-09-17 07:03:41.148162401 +0200
+++ selinux-17092011-patched-sds/policycoreutils/sepolgen-ifgen/Makefile	2011-09-17 21:54:15.461445508 +0200
@@ -1,12 +1,13 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 BINDIR ?= $(PREFIX)/bin
-LIBDIR ?= ${PREFIX}/lib
+LIBDIR ?= $(PREFIX)/lib
+LIBSEPOLSTATIC ?= $(LIBDIR)/libsepol.a
 INCLUDEDIR ?= $(PREFIX)/include
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = $(LIBDIR)/libsepol.a
+LDLIBS = $(LIBSEPOLSTATIC)
 
 all: sepolgen-ifgen-attr-helper
 
diff -pruN selinux-17092011-orig/policycoreutils/sestatus/Makefile selinux-17092011-patched-sds/policycoreutils/sestatus/Makefile
--- selinux-17092011-orig/policycoreutils/sestatus/Makefile	2011-09-09 20:12:56.077662873 +0200
+++ selinux-17092011-patched-sds/policycoreutils/sestatus/Makefile	2011-09-17 21:22:46.026329705 +0200
@@ -1,12 +1,13 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 SBINDIR ?= $(PREFIX)/sbin
-MANDIR = $(PREFIX)/share/man
+INCLUDEDIR ?= $(PREFIX)/include
+MANDIR ?= $(PREFIX)/share/man
 ETCDIR ?= $(DESTDIR)/etc
-LIBDIR ?= ${PREFIX}/lib
+LIBDIR ?= $(PREFIX)/lib
 
-CFLAGS = -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
+CFLAGS ?= -Werror -Wall -W
+override CFLAGS += -I$(INCLUDEDIR) -D_FILE_OFFSET_BITS=64
 LDLIBS = -lselinux -L$(LIBDIR)
 
 all: sestatus
diff -pruN selinux-17092011-orig/policycoreutils/setfiles/Makefile selinux-17092011-patched-sds/policycoreutils/setfiles/Makefile
--- selinux-17092011-orig/policycoreutils/setfiles/Makefile	2011-09-09 20:12:56.078662881 +0200
+++ selinux-17092011-patched-sds/policycoreutils/setfiles/Makefile	2011-09-17 21:22:46.027329716 +0200
@@ -1,12 +1,13 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 SBINDIR ?= $(DESTDIR)/sbin
-MANDIR = $(PREFIX)/share/man
+INCLUDEDIR ?= $(PREFIX)/include
+MANDIR ?= $(PREFIX)/share/man
 LIBDIR ?= $(PREFIX)/lib
 AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
 
-CFLAGS = -g -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include
+CFLAGS ?= -g -Werror -Wall -W
+override CFLAGS += -I$(INCLUDEDIR)
 LDLIBS = -lselinux -lsepol -L$(LIBDIR)
 
 ifeq (${AUDITH}, /usr/include/libaudit.h)
diff -pruN selinux-17092011-orig/policycoreutils/setsebool/Makefile selinux-17092011-patched-sds/policycoreutils/setsebool/Makefile
--- selinux-17092011-orig/policycoreutils/setsebool/Makefile	2011-09-09 20:12:56.078662881 +0200
+++ selinux-17092011-patched-sds/policycoreutils/setsebool/Makefile	2011-09-17 21:22:46.027329716 +0200
@@ -2,8 +2,8 @@
 PREFIX ?= $(DESTDIR)/usr
 INCLUDEDIR ?= $(PREFIX)/include
 SBINDIR ?= $(PREFIX)/sbin
-MANDIR = $(PREFIX)/share/man
-LIBDIR ?= ${PREFIX}/lib
+MANDIR ?= $(PREFIX)/share/man
+LIBDIR ?= $(PREFIX)/lib
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -I$(INCLUDEDIR)
diff -pruN selinux-17092011-orig/README selinux-17092011-patched-sds/README
--- selinux-17092011-orig/README	1970-01-01 01:00:00.000000000 +0100
+++ selinux-17092011-patched-sds/README	2011-09-17 21:37:22.524214709 +0200
@@ -0,0 +1,32 @@
+INSTALLATION:
+
+Type "make" to build and then "make install" to install.
+
+---
+
+The environment variables CFLAGS and LDFLAGS can be passed to "make" to use custom compiler
+and/or linker flags (for example: CFLAGS="-O3" LDFLAGS="" make).
+
+The environment variables LIBDIR and SHLIBDIR can be passed to "make" in order to configure
+different directories for the libraries (e.g. LIBDIR=/usr/lib64 and SHLIBDIR=/usr/lib64
+on 64-bit systems).
+
+The environment variable PREFIX can be passed to "make" in order to configure an install
+prefix other than "/usr".
+
+The environment variable DESTDIR can be passed to "make" in order to configure a
+specific directory to be used as the root installation directory.
+
+Please see the Makefile(s) for other environment variables that can be used.
+
+---
+
+BUILD OPTIONS:
+
+policycoreutils/run_init:
+The run_init tool can be compiled with either PAM or shadow password authentication. Please
+edit the Makefile to suit your needs. The default is to build with PAM authentication (-DUSE_PAM).
+Support for Linux Audit (http://people.redhat.com/sgrubb/audit) should be auto-detected by the
+Makefile.
+
+---

On Thu, 2011-09-15 at 16:00 -0400, Stephen Smalley wrote:
> On Thu, 2011-09-15 at 21:12 +0200, Guido Trentalancia wrote:
> > I did hit other issues too. Lesson learned was: add -lbz2 -lustr to
> > LDLIBS in policycoreutils/{semodule,setsebool}/Makefile and replace =
> > with ?= in checkpolicy/test/Makefile
> > 
> > Unfortunately none of the above is exactly what I am looking for...
> > 
> > I am looking to install directly under the root live filesystem. So
> > DESTDIR is not going to be used in my specific case. And I need
> > LIBDIR=SHLIBDIR=/usr/lib64. Also, I'd like to first type "make" to build
> > only and then type "make install" to get things installed.
> > 
> > rm -rf /usr/include/selinux/ ; rm -rf /usr/include/semanage/ ; rm
> > -rf /usr/include/sepol/ ; rm -f /usr/lib64/libsepol.* ; rm
> > -f /usr/lib64/libsemanage.* ; CFLAGS="-O3 -march=corei7 -mtune=corei7"
> > LIBDIR=/usr/lib64 SHLIBDIR=/usr/lib64 make install
> > 
> > Works with "install" target only with latest git. So it is not possible
> > to build only first and then install.
> 
> Yes, if you want that, you'll need further changes.  But rather than
> changing the component Makefiles in a manner that won't work for
> separate builds, how about defining some top-level variables and using
> them throughout, with conditional definitions (?=) within the individual
> Makefiles so that the separate builds still work.  Like the following
> (incomplete, but gives the idea):
> 
> diff --git a/Makefile b/Makefile
> index 09c2c1e..f68a2b2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -7,6 +7,10 @@ ifeq ($(DEBUG),1)
>  	export LDFLAGS = -g
>  endif
>  
> +export LIBSEPOLSTATIC=$(CURDIR)/libsepol/src/libsepol.a

I have introduced the above in the revised patch attached to this
message, however...

> +export EXTRA_INCLUDES=-I$(CURDIR)/libsepol/include -I$(CURDIR)/libselinux/include -I$(CURDIR)/libsemanage/include
> +export EXTRA_LIBS=-L$(CURDIR)/libsepol/src -L$(CURDIR)/libselinux/src -L$(CURDIR)/libsemanage/src

I've dropped the above because it is not just being used for the
libraries, it is also used for the tools, therefore since it is widely
used, better widely defined.

>  all install relabel clean test indent:
>  	@for subdir in $(SUBDIRS); do \
>  		(cd $$subdir && $(MAKE) $@) || exit 1; \
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 7680008..4651616 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -7,7 +7,8 @@ PYPREFIX ?= $(notdir $(PYTHON))
>  # Installation directories.
>  PREFIX ?= $(DESTDIR)/usr
>  LIBDIR ?= $(PREFIX)/lib
> -SHLIBDIR ?= $(PREFIX)/lib
> +LIBSEPOLSTATIC ?= $(LIBDIR)/libsepol.a

Introduced here and elsewhere. For libsepol and also for static
libselinux as needed throughout the whole project.

> +SHLIBDIR ?= $(DESTDIR)/lib
>  INCLUDEDIR ?= $(PREFIX)/include
>  PYLIBVER ?= $(shell $(PYTHON) -c 'import sys;print("python%d.%d" % sys.version_info[0:2])')
>  PYINC ?= $(shell pkg-config --cflags $(PYPREFIX))
> @@ -54,7 +55,7 @@ SRCS= $(filter-out $(UNUSED_SRCS) $(GENERATED) audit2why.c, $(wildcard *.c))
>  OBJS= $(patsubst %.c,%.o,$(SRCS))
>  LOBJS= $(patsubst %.c,%.lo,$(SRCS))
>  CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute
> -override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(EMFLAGS)
> +override CFLAGS += -I../include -I$(INCLUDEDIR) $(EXTRA_INCLUDES) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(EMFLAGS)

Dropped (see above).

>  RANLIB=ranlib
>  
>  ARCH := $(patsubst i%86,i386,$(shell uname -m))
> @@ -102,7 +103,7 @@ $(AUDIT2WHYLOBJ): audit2why.c
>  	$(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED -c -o $@ $<
>  
>  $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)
> -	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux ${LIBDIR}/libsepol.a -L$(LIBDIR) -Wl,-soname,$@
> +	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux $(LIBSEPOLSTATIC) -L$(LIBDIR) -Wl,-soname,$@
>  
>  %.o:  %.c policy.h
>  	$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index d9120c0..44962e6 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -55,7 +55,7 @@ OBJS= $(patsubst %.c,%.o,$(SRCS)) conf-scan.o conf-parse.o
>  LOBJS= $(patsubst %.c,%.lo,$(SRCS)) conf-scan.lo conf-parse.lo
>  CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute
>  
> -override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE 
> +override CFLAGS += -I../include -I$(INCLUDEDIR) $(EXTRA_INCLUDES) -D_GNU_SOURCE 
>  RANLIB=ranlib
>  
>  SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
> @@ -87,7 +87,7 @@ $(LIBA): $(OBJS)
>  	$(RANLIB) $@
>  
>  $(LIBSO): $(LOBJS)
> -	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -lselinux -lbz2 -lustr -L$(LIBDIR) -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
> +	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -lselinux -lbz2 -lustr $(EXTRA_LIBS) -L$(LIBDIR) -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
>  	ln -sf $@ $(TARGET)
>  
>  $(LIBPC): $(LIBPC).in
> 

Thanks for the great suggestion.

By the way, I think the patch to tackle the shared library link creation
still needs to be applied. Christopher said he had an idea to improve
it, but then I've not heard anything back from him.

For reference, this was the latest version I think:

--- selinux/libselinux/src/Makefile	2011-09-09 20:12:55.992662259 +0200
+++ selinux-14092011-fix-library-double-symlink-creation/libselinux/src/Makefile	2011-09-15 10:51:50.720619457 +0200
@@ -126,7 +126,8 @@ install: all
 	install -m 755 $(LIBSO) $(SHLIBDIR)
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
-	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
+	pushd $(LIBDIR) && ln -sf $(SHLIBDIR)/$(LIBSO) $(TARGET) && popd
+	pushd $(SHLIBDIR) && ln -sf $(LIBSO) $(TARGET) && popd
 
 install-pywrap: pywrap
 	test -d $(PYLIBDIR)/site-packages/selinux || install -m 755 -d $(PYLIBDIR)/site-packages/selinux
--- selinux/libsepol/src/Makefile	2011-09-09 20:12:56.021662468 +0200
+++ selinux-14092011-fix-library-double-symlink-creation/libsepol/src/Makefile	2011-09-15 10:52:23.139869859 +0200
@@ -43,7 +43,8 @@ install: all
 	install -m 755 $(LIBSO) $(SHLIBDIR)
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
-	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
+	pushd $(LIBDIR) && ln -sf $(SHLIBDIR)/$(LIBSO) $(TARGET) && popd
+	pushd $(SHLIBDIR) && ln -sf $(LIBSO) $(TARGET) && popd
 
 relabel:
 	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
--- selinux/libsemanage/src/Makefile	2011-09-09 20:12:56.008662374 +0200
+++ selinux-14092011-fix-library-double-symlink-creation/libsemanage/src/Makefile	2011-09-15 10:53:01.131163131 +0200
@@ -139,7 +139,8 @@ install: all
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
 	test -f $(DEFAULT_SEMANAGE_CONF_LOCATION) || install -m 644 -D semanage.conf $(DEFAULT_SEMANAGE_CONF_LOCATION)
-	cd $(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
+	pushd $(LIBDIR) && ln -sf $(SHLIBDIR)/$(LIBSO) $(TARGET) && popd
+	pushd $(SHLIBDIR) && ln -sf $(LIBSO) $(TARGET) && popd
 
 install-pywrap: pywrap 
 	test -d $(PYLIBDIR)/site-packages || install -m 755 -d $(PYLIBDIR)/site-packages

If Christopher is still willing to contribute his version which
supposedly reads better, then I'd be quite happy to have that applied
instead, otherwise it doesn't matter I suppose. Similarly it's entirely
up to you to decide the details, as long as it doesn't create broken
links (as unfortunately is currently doing) I am fine with most ideas
(at the moment it creates two links, although personally speaking I
would only need the one in SHLIBDIR).

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Subject: Re: [PATCH v4] Fix includes for userspace tools and libraries (and
 possible security issue)
From: Guido Trentalancia <guido@trentalancia.com>
To: Eric Paris <eparis@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Date: Wed, 14 Sep 2011 00:05:07 +0200
In-Reply-To: <1315945618.2738.13.camel@localhost>
References: <1315587716.2170.16.camel@vortex>
	 <1315588656.2170.26.camel@vortex>
	 <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
	 <1315832253.17035.5.camel@moss-pluto> <1315859373.2223.19.camel@vortex>
	 <4E6E8149.30702@redhat.com> <1315917697.12522.1.camel@moss-pluto>
	 <1315931495.2248.29.camel@vortex> <1315934421.12522.46.camel@moss-pluto>
	 <1315938784.2218.14.camel@vortex> <1315939689.12522.51.camel@moss-pluto>
	 <1315941501.2218.26.camel@vortex>  <1315941958.12522.77.camel@moss-pluto>
	 <1315942469.12522.81.camel@moss-pluto> <1315944244.2218.41.camel@vortex>
	 <1315945618.2738.13.camel@localhost>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315951507.2218.91.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Eric !

On Tue, 2011-09-13 at 16:26 -0400, Eric Paris wrote:
> Personally, I'd like to see just 'make' at the top level dir build
> properly and I think your patches get us most of the way there without
> (further) breaking the building method that sds prefers.
> 
> If you get your best patch which does nothing but allow us to just type
> 'make' at the top level dir and it builds everything properly in place,
> I'll review and probably commit such a patch.

Yes, let's get to the point. The latest version of the patch that you
should test is attached below. Please note that it also changes the
creation of symbolic links to shared libraries (needs to be
double-checked for correctness).

diff -pruN selinux/checkpolicy/Makefile selinux-13092011/checkpolicy/Makefile
--- selinux/checkpolicy/Makefile	2011-09-09 20:12:55.978662153 +0200
+++ selinux-13092011/checkpolicy/Makefile	2011-09-13 02:58:19.314224502 +0200
@@ -19,7 +19,7 @@ CHECKOBJS = y.tab.o lex.yy.o queue.o mod
 CHECKPOLOBJS = $(CHECKOBJS) checkpolicy.o
 CHECKMODOBJS = $(CHECKOBJS) checkmodule.o
 
-LDLIBS=$(LIBDIR)/libsepol.a -lfl
+LDLIBS=../libsepol/src/libsepol.a -L$(LIBDIR) -lfl
 
 GENERATED=lex.yy.c y.tab.c y.tab.h
 
diff -pruN selinux/checkpolicy/test/Makefile selinux-13092011/checkpolicy/test/Makefile
--- selinux/checkpolicy/test/Makefile	2011-09-09 20:12:55.980662174 +0200
+++ selinux-13092011/checkpolicy/test/Makefile	2011-09-13 02:58:19.315224529 +0200
@@ -9,7 +9,7 @@ INCLUDEDIR ?= $(PREFIX)/include
 CFLAGS ?= -g -Wall -O2 -pipe
 override CFLAGS += -I$(INCLUDEDIR)
 
-LDLIBS=-lfl -lsepol -lselinux $(LIBDIR)/libsepol.a -L$(LIBDIR)
+LDLIBS=-lsepol -lselinux ../../libsepol/src/libsepol.a -L$(LIBDIR) -lfl
 
 all: dispol dismod
 
diff -pruN selinux/libselinux/src/Makefile selinux-13092011/libselinux/src/Makefile
--- selinux/libselinux/src/Makefile	2011-09-09 20:12:55.992662259 +0200
+++ selinux-13092011/libselinux/src/Makefile	2011-09-13 03:30:08.882910143 +0200
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
+	cd $(SHLIBDIR) && ln -sf $(LIBSO) $(TARGET)
 
 install-pywrap: pywrap
 	test -d $(PYLIBDIR)/site-packages/selinux || install -m 755 -d $(PYLIBDIR)/site-packages/selinux
diff -pruN selinux/libsemanage/src/Makefile selinux-13092011/libsemanage/src/Makefile
--- selinux/libsemanage/src/Makefile	2011-09-09 20:12:56.008662374 +0200
+++ selinux-13092011/libsemanage/src/Makefile	2011-09-13 03:36:55.724150908 +0200
@@ -87,7 +87,7 @@ $(LIBA): $(OBJS)
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -lselinux -lbz2 -lustr -L$(LIBDIR) -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -lselinux -L$(LIBDIR) -lbz2 -lustr -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
 	ln -sf $@ $(TARGET)
 
 $(LIBPC): $(LIBPC).in
@@ -139,7 +139,7 @@ install: all
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
 	test -f $(DEFAULT_SEMANAGE_CONF_LOCATION) || install -m 644 -D semanage.conf $(DEFAULT_SEMANAGE_CONF_LOCATION)
-	cd $(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
+	cd $(SHLIBDIR) && ln -sf $(LIBSO) $(TARGET)
 
 install-pywrap: pywrap 
 	test -d $(PYLIBDIR)/site-packages || install -m 755 -d $(PYLIBDIR)/site-packages
diff -pruN selinux/libsepol/src/Makefile selinux-13092011/libsepol/src/Makefile
--- selinux/libsepol/src/Makefile	2011-09-09 20:12:56.021662468 +0200
+++ selinux-13092011/libsepol/src/Makefile	2011-09-13 02:57:31.309865469 +0200
@@ -43,7 +43,7 @@ install: all
 	install -m 755 $(LIBSO) $(SHLIBDIR)
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
-	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
+	cd $(SHLIBDIR) && ln -sf $(LIBSO) $(TARGET)
 
 relabel:
 	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
diff -pruN selinux/Makefile selinux-13092011/Makefile
--- selinux/Makefile	2011-09-09 20:12:55.977662144 +0200
+++ selinux-13092011/Makefile	2011-09-13 02:58:19.315224529 +0200
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
diff -pruN selinux/policycoreutils/audit2allow/Makefile selinux-13092011/policycoreutils/audit2allow/Makefile
--- selinux/policycoreutils/audit2allow/Makefile	2011-09-09 20:12:56.034662561 +0200
+++ selinux-13092011/policycoreutils/audit2allow/Makefile	2011-09-13 03:04:59.631193632 +0200
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
 
diff -pruN selinux/policycoreutils/audit2why/Makefile selinux-13092011/policycoreutils/audit2why/Makefile
--- selinux/policycoreutils/audit2why/Makefile	2011-09-09 20:12:56.035662568 +0200
+++ selinux-13092011/policycoreutils/audit2why/Makefile	2011-09-13 03:01:12.676515333 +0200
@@ -1,5 +1,5 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
 
diff -pruN selinux/policycoreutils/load_policy/Makefile selinux-13092011/policycoreutils/load_policy/Makefile
--- selinux/policycoreutils/load_policy/Makefile	2011-09-09 20:12:56.035662568 +0200
+++ selinux-13092011/policycoreutils/load_policy/Makefile	2011-09-13 03:16:23.953209557 +0200
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
 
diff -pruN selinux/policycoreutils/mcstrans/src/Makefile selinux-13092011/policycoreutils/mcstrans/src/Makefile
--- selinux/policycoreutils/mcstrans/src/Makefile	2011-09-09 20:12:56.040662607 +0200
+++ selinux-13092011/policycoreutils/mcstrans/src/Makefile	2011-09-13 03:28:56.851327660 +0200
@@ -28,7 +28,7 @@ override CFLAGS += -I../include -D_GNU_S
 all: $(PROG)
 
 $(PROG): $(PROG_OBJS)
-	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre $(LIBDIR)/libsepol.a
+	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux ../../../libsepol/src/libsepol.a -L$(LIBDIR) -lcap -lpcre
 
 %.o:  %.c 
 	$(CC) $(CFLAGS) -fPIE -c -o $@ $<
diff -pruN selinux/policycoreutils/mcstrans/utils/Makefile selinux-13092011/policycoreutils/mcstrans/utils/Makefile
--- selinux/policycoreutils/mcstrans/utils/Makefile	2011-09-09 20:12:56.041662614 +0200
+++ selinux-13092011/policycoreutils/mcstrans/utils/Makefile	2011-09-13 03:27:22.371562684 +0200
@@ -21,7 +21,7 @@ endif
 
 CFLAGS ?= -Wall
 override CFLAGS += -I../src -D_GNU_SOURCE
-LDLIBS += -L../src ../src/mcstrans.o ../src/mls_level.o -lselinux -lpcre $(LIBDIR)/libsepol.a
+LDLIBS += -L../src ../src/mcstrans.o ../src/mls_level.o -lselinux -lpcre ../../../libsepol/src/libsepol.a
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
diff -pruN selinux/policycoreutils/newrole/Makefile selinux-13092011/policycoreutils/newrole/Makefile
--- selinux/policycoreutils/newrole/Makefile	2011-09-09 20:12:56.041662614 +0200
+++ selinux-13092011/policycoreutils/newrole/Makefile	2011-09-13 03:17:53.038877292 +0200
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
diff -pruN selinux/policycoreutils/restorecond/Makefile selinux-13092011/policycoreutils/restorecond/Makefile
--- selinux/policycoreutils/restorecond/Makefile	2011-09-09 20:12:56.072662837 +0200
+++ selinux-13092011/policycoreutils/restorecond/Makefile	2011-09-13 03:09:18.182096161 +0200
@@ -1,13 +1,14 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 SBINDIR ?= $(PREFIX)/sbin
-MANDIR = $(PREFIX)/share/man
-INITDIR = $(DESTDIR)/etc/rc.d/init.d
-SELINUXDIR = $(DESTDIR)/etc/selinux
+INCLUDEDIR ?= $(PREFIX)/include
+MANDIR ?= $(PREFIX)/share/man
+INITDIR ?= $(DESTDIR)/etc/rc.d/init.d
+SELINUXDIR ?= $(DESTDIR)/etc/selinux
 
 CFLAGS ?= -g -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
-LDLIBS += -lselinux -L$(PREFIX)/lib
+override CFLAGS += -I$(INCLUDEDIR) -D_FILE_OFFSET_BITS=64
+LDLIBS += -lselinux -L$(LIBDIR)
 
 all: restorecond
 
diff -pruN selinux/policycoreutils/run_init/Makefile selinux-13092011/policycoreutils/run_init/Makefile
--- selinux/policycoreutils/run_init/Makefile	2011-09-09 20:12:56.072662837 +0200
+++ selinux-13092011/policycoreutils/run_init/Makefile	2011-09-13 03:14:35.943421643 +0200
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
diff -pruN selinux/policycoreutils/sandbox/Makefile selinux-13092011/policycoreutils/sandbox/Makefile
--- selinux/policycoreutils/sandbox/Makefile	2011-09-09 20:12:56.073662844 +0200
+++ selinux-13092011/policycoreutils/sandbox/Makefile	2011-09-13 03:08:17.158649761 +0200
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
-override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DPACKAGE="\"policycoreutils\""
-LDLIBS += -lselinux -lcap-ng 
+override CFLAGS += $(LDFLAGS) -I$(INCLUDEDIR) -DPACKAGE="\"policycoreutils\""
+LDLIBS += -lselinux -L$(LIBDIR) -lcap-ng
 
 all: sandbox seunshare sandboxX.sh start
 
diff -pruN selinux/policycoreutils/scripts/Makefile selinux-13092011/policycoreutils/scripts/Makefile
--- selinux/policycoreutils/scripts/Makefile	2011-09-09 20:12:56.074662851 +0200
+++ selinux-13092011/policycoreutils/scripts/Makefile	2011-09-13 02:59:44.455859136 +0200
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
diff -pruN selinux/policycoreutils/secon/Makefile selinux-13092011/policycoreutils/secon/Makefile
--- selinux/policycoreutils/secon/Makefile	2011-09-09 20:12:56.075662858 +0200
+++ selinux-13092011/policycoreutils/secon/Makefile	2011-09-13 03:09:50.934336415 +0200
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
diff -pruN selinux/policycoreutils/semanage/Makefile selinux-13092011/policycoreutils/semanage/Makefile
--- selinux/policycoreutils/semanage/Makefile	2011-09-09 20:12:56.075662858 +0200
+++ selinux-13092011/policycoreutils/semanage/Makefile	2011-09-13 03:10:39.427692261 +0200
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
 
diff -pruN selinux/policycoreutils/semodule/Makefile selinux-13092011/policycoreutils/semodule/Makefile
--- selinux/policycoreutils/semodule/Makefile	2011-09-09 20:12:56.076662865 +0200
+++ selinux-13092011/policycoreutils/semodule/Makefile	2011-09-13 03:11:52.329224670 +0200
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
diff -pruN selinux/policycoreutils/semodule_deps/Makefile selinux-13092011/policycoreutils/semodule_deps/Makefile
--- selinux/policycoreutils/semodule_deps/Makefile	2011-09-09 20:12:56.076662865 +0200
+++ selinux-13092011/policycoreutils/semodule_deps/Makefile	2011-09-13 03:02:06.359913305 +0200
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
 override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = $(LIBDIR)/libsepol.a
+LDLIBS = ../../libsepol/src/libsepol.a
 
 all: semodule_deps
 
diff -pruN selinux/policycoreutils/semodule_expand/Makefile selinux-13092011/policycoreutils/semodule_expand/Makefile
--- selinux/policycoreutils/semodule_expand/Makefile	2011-09-09 20:12:56.077662873 +0200
+++ selinux-13092011/policycoreutils/semodule_expand/Makefile	2011-09-13 03:11:07.722900079 +0200
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
diff -pruN selinux/policycoreutils/semodule_link/Makefile selinux-13092011/policycoreutils/semodule_link/Makefile
--- selinux/policycoreutils/semodule_link/Makefile	2011-09-09 20:12:56.077662873 +0200
+++ selinux-13092011/policycoreutils/semodule_link/Makefile	2011-09-13 03:05:23.873372013 +0200
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
diff -pruN selinux/policycoreutils/semodule_package/Makefile selinux-13092011/policycoreutils/semodule_package/Makefile
--- selinux/policycoreutils/semodule_package/Makefile	2011-09-09 20:12:56.077662873 +0200
+++ selinux-13092011/policycoreutils/semodule_package/Makefile	2011-09-13 03:10:14.033504971 +0200
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
diff -pruN selinux/policycoreutils/sestatus/Makefile selinux-13092011/policycoreutils/sestatus/Makefile
--- selinux/policycoreutils/sestatus/Makefile	2011-09-09 20:12:56.077662873 +0200
+++ selinux-13092011/policycoreutils/sestatus/Makefile	2011-09-13 03:12:39.142571067 +0200
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
diff -pruN selinux/policycoreutils/setfiles/Makefile selinux-13092011/policycoreutils/setfiles/Makefile
--- selinux/policycoreutils/setfiles/Makefile	2011-09-09 20:12:56.078662881 +0200
+++ selinux-13092011/policycoreutils/setfiles/Makefile	2011-09-13 03:13:18.560856761 +0200
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
diff -pruN selinux/policycoreutils/setsebool/Makefile selinux-13092011/policycoreutils/setsebool/Makefile
--- selinux/policycoreutils/setsebool/Makefile	2011-09-09 20:12:56.078662881 +0200
+++ selinux-13092011/policycoreutils/setsebool/Makefile	2011-09-13 03:11:32.604081796 +0200
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
diff -pruN selinux/README selinux-13092011/README
--- selinux/README	1970-01-01 01:00:00.000000000 +0100
+++ selinux-13092011/README	2011-09-13 02:58:19.316224554 +0200
@@ -0,0 +1,20 @@
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

To the above you could also add the following bits in order to improve
the manual page of genhomedircon:

diff -pruN selinux/policycoreutils/scripts/genhomedircon.8 selinux-13092011/policycoreutils/scripts/genhomedircon.8
--- selinux/policycoreutils/scripts/genhomedircon.8	2011-09-09 20:12:56.074662851 +0200
+++ selinux-13092011/policycoreutils/scripts/genhomedircon.8	2011-09-13 02:57:45.412971066 +0200
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

And after that you could then review and eventually commit the patch for
the new semanage.conf(5) manual page (separate thread). The good thing
about this last one is that it does not need testing !

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

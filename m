Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6EFCZgA003688
	for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2005 11:12:35 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6EF8QkZ015254
	for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2005 15:08:26 GMT
Received: from twoface.columbia.tresys.com (twoface.columbia.tresys.com [10.1.13.32])
	by gotham.columbia.tresys.com (8.12.8/8.12.8) with ESMTP id j6EF9Bvv011952
	for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2005 11:09:11 -0400
Subject: [PATCH] Makefile fixes and cleanups for selinux-usr
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 11:09:10 -0400
Message-Id: <1121353750.11005.3.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch makes the repository able to be built with DESTDIR set and
also adds the ability to define DEBUG to get debug CFLAGS enabled for
the entire repository as well as some misc fixes and cleanups.

diff -purN -x .svn -x CVS -x 'Makefile~' -x /policy/ -x '*.y' -x '*.l' nsa/selinux-usr/checkpolicy/Makefile policy-modules/trunk/checkpolicy/Makefile
--- nsa/selinux-usr/checkpolicy/Makefile	2005-07-07 10:56:19.000000000 -0400
+++ policy-modules/trunk/checkpolicy/Makefile	2005-07-13 12:52:38.000000000 -0400
@@ -8,7 +8,7 @@ LIBDIR ?= $(PREFIX)/lib
 INCLUDEDIR ?= $(PREFIX)/include
 TARGETS = checkpolicy checkmodule
 
-CFLAGS = -g -Wall -O2 -pipe
+CFLAGS ?= -g -Wall -O2 -pipe -fno-strict-aliasing
 
 override CFLAGS += -I. -I${INCLUDEDIR}
 
@@ -16,13 +16,13 @@ CHECKOBJS = y.tab.o lex.yy.o queue.o mod
 CHECKPOLOBJS = $(CHECKOBJS) checkpolicy.o
 CHECKMODOBJS = $(CHECKOBJS) checkmodule.o
 
-LIBS=-lfl ${LIBDIR}/libsepol.a
+LDLIBS=$(LIBDIR)/libsepol.a -lfl
 
 all:  $(TARGETS)
 
-checkpolicy: $(CHECKPOLOBJS) $(LIBS)
+checkpolicy: $(CHECKPOLOBJS)
 
-checkmodule: $(CHECKMODOBJS) $(LIBS)
+checkmodule: $(CHECKMODOBJS)
 
 %.o: %.c 
 	$(CC) $(CFLAGS) -o $@ -c $<
@@ -50,5 +50,5 @@ relabel: install
 	/sbin/restorecon $(BINDIR)/checkmodule
 
 clean:
-	rm -f $(TARGETS) $(CHECKPOLOBJS) $(CHECKMODOBJS) y.tab.c y.tab.h lex.yy.c 
+	-rm -f $(TARGETS) $(CHECKPOLOBJS) $(CHECKMODOBJS) y.tab.c y.tab.h lex.yy.c 
 
diff -purN -x .svn -x CVS -x 'Makefile~' -x /policy/ -x '*.y' -x '*.l' nsa/selinux-usr/checkpolicy/test/Makefile policy-modules/trunk/checkpolicy/test/Makefile
--- nsa/selinux-usr/checkpolicy/test/Makefile	2005-07-07 10:56:20.000000000 -0400
+++ policy-modules/trunk/checkpolicy/test/Makefile	2005-07-13 12:41:19.000000000 -0400
@@ -4,21 +4,18 @@
 PREFIX ?= $(DESTDIR)/usr
 BINDIR=$(PREFIX)/bin
 LIBDIR=$(PREFIX)/lib
+INCLUDEDIR ?= $(PREFIX)/include
 
-CFLAGS = -g -Wall -O2 -pipe
-#CFLAGS = -g -Wall -O2 -pipe
-override CFLAGS += -I../../libsepol/include -I../../libsemod/include
-LDFLAGS = -g
+CFLAGS ?= -g -Wall -O2 -pipe
+override CFLAGS += -I$(INCLUDEDIR)
 
-LIBS=-lfl ../../libsepol/src/libsepol.a
-SEMOD_LIBS=../../libsemod/src/libsemod.a
+LDLIBS=-lfl -lsemod -lselinux $(LIBDIR)/libsepol.a -L$(LIBDIR)
 
 all: dispol dismod
 
-dispol: dispol.o $(LIBS)
+dispol: dispol.o
 
-dismod: dismod.o $(SEMOD_LIBS) $(LIBS)
+dismod: dismod.o
 
 clean:
-	rm -f dispol dismod *.o 
-
+	-rm -f dispol dismod *.o 

diff -purN -x .svn -x CVS -x 'Makefile~' -x /policy/ -x '*.y' -x '*.l' nsa/selinux-usr/libselinux/src/Makefile policy-modules/trunk/libselinux/src/Makefile
--- nsa/selinux-usr/libselinux/src/Makefile	2005-06-28 15:03:23.000000000 -0400
+++ policy-modules/trunk/libselinux/src/Makefile	2005-07-13 12:55:56.000000000 -0400
@@ -11,7 +11,7 @@ TARGET=libselinux.so
 LIBSO=$(TARGET).$(LIBVERSION)
 OBJS= $(patsubst %.c,%.o,$(wildcard *.c))
 LOBJS= $(patsubst %.c,%.lo,$(wildcard *.c))
-CFLAGS = -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
+CFLAGS ?= -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
 override CFLAGS += -I../include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
 RANLIB=ranlib
 
@@ -42,5 +42,5 @@ relabel:
 	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
 
 clean: 
-	rm -f $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) 
+	-rm -f $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) 
 
diff -purN -x .svn -x CVS -x 'Makefile~' -x /policy/ -x '*.y' -x '*.l' nsa/selinux-usr/libselinux/utils/Makefile policy-modules/trunk/libselinux/utils/Makefile
--- nsa/selinux-usr/libselinux/utils/Makefile	2005-02-22 11:39:52.000000000 -0500
+++ policy-modules/trunk/libselinux/utils/Makefile	2005-07-13 11:36:28.000000000 -0400
@@ -2,7 +2,7 @@
 PREFIX ?= $(DESTDIR)/usr
 BINDIR ?= $(PREFIX)/sbin
 
-CFLAGS = -Wall
+CFLAGS ?= -Wall
 override CFLAGS += -I../include -D_GNU_SOURCE
 LDLIBS += -L../src -lselinux 
 
diff -purN -x .svn -x CVS -x 'Makefile~' -x /policy/ -x '*.y' -x '*.l' nsa/selinux-usr/libsemod/src/Makefile policy-modules/trunk/libsemod/src/Makefile
--- nsa/selinux-usr/libsemod/src/Makefile	2005-07-06 13:51:19.000000000 -0400
+++ policy-modules/trunk/libsemod/src/Makefile	2005-07-13 13:13:02.000000000 -0400
@@ -2,6 +2,7 @@
 PREFIX ?= $(DESTDIR)/usr
 LIBDIR ?= $(PREFIX)/lib
 SHLIBDIR ?= $(DESTDIR)/lib
+INCLUDEDIR ?= $(PREFIX)/include
 
 DEFAULT_SEMOD_CONF_LOCATION=$(PREFIX)/share/semod/semod.conf
 
@@ -17,9 +18,10 @@ TARGET=libsemod.so
 LIBSO=$(TARGET).$(LIBVERSION)
 OBJS= $(patsubst %.c,%.o,$(wildcard *.c)) conf-scan.o conf-parse.o
 LOBJS= $(patsubst %.c,%.lo,$(wildcard *.c))
-CFLAGS = -I. -I../include -I../../libsepol/include -I../../libselinux/include -D_GNU_SOURCE -Wall -gdwarf-2 -g3 -DDEFAULT_SEMOD_CONF_LOCATION='"$(DEFAULT_SEMOD_CONF_LOCATION)"'
-LDFLAGS = -g
+CFLAGS ?= -Wall
 
+override CFLAGS += -I. -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE \
+                   -DDEFAULT_SEMOD_CONF_LOCATION='"$(DEFAULT_SEMOD_CONF_LOCATION)"'
 
 all: $(LIBA) $(LIBSO)
 
diff -purN -x .svn -x CVS -x 'Makefile~' -x /policy/ -x '*.y' -x '*.l' nsa/selinux-usr/libsepol/src/Makefile policy-modules/trunk/libsepol/src/Makefile
--- nsa/selinux-usr/libsepol/src/Makefile	2005-02-22 11:39:51.000000000 -0500
+++ policy-modules/trunk/libsepol/src/Makefile	2005-07-13 13:11:39.000000000 -0400
@@ -10,7 +10,7 @@ TARGET=libsepol.so
 LIBSO=$(TARGET).$(LIBVERSION)
 OBJS= $(patsubst %.c,%.o,$(wildcard *.c))
 LOBJS= $(patsubst %.c,%.lo,$(wildcard *.c))
-CFLAGS = -Wall
+CFLAGS ?= -Wall
 override CFLAGS += -I. -I../include -D_GNU_SOURCE
 
 all: $(LIBA) $(LIBSO)
@@ -40,5 +40,5 @@ relabel:
 	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
 
 clean: 
-	rm -f $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) 
+	-rm -f $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) 
 
diff -purN -x .svn -x CVS -x 'Makefile~' -x /policy/ -x '*.y' -x '*.l' nsa/selinux-usr/libsepol/utils/Makefile policy-modules/trunk/libsepol/utils/Makefile
--- nsa/selinux-usr/libsepol/utils/Makefile	2004-08-11 12:17:38.000000000 -0400
+++ policy-modules/trunk/libsepol/utils/Makefile	2005-07-13 12:28:34.000000000 -0400
@@ -2,7 +2,7 @@
 PREFIX ?= $(DESTDIR)/usr
 BINDIR ?= $(PREFIX)/bin
 
-CFLAGS = -Wall
+CFLAGS ?= -Wall
 override CFLAGS += -I../include
 LDLIBS += -L../src -lsepol 
 
@@ -15,7 +15,7 @@ install: all
 	install -m 755 $(TARGETS) $(BINDIR)
 
 clean:
-	rm -f $(TARGETS) *.o 
+	-rm -f $(TARGETS) *.o 
 
 relabel:
 
diff -purN -x .svn -x CVS -x 'Makefile~' -x /policy/ -x '*.y' -x '*.l' nsa/selinux-usr/Makefile policy-modules/trunk/Makefile
--- nsa/selinux-usr/Makefile	2005-07-07 10:56:19.000000000 -0400
+++ policy-modules/trunk/Makefile	2005-07-13 13:09:19.000000000 -0400
@@ -1,4 +1,9 @@
-SUBDIRS=libsepol libsemod checkpolicy libselinux policycoreutils policy
+SUBDIRS=libselinux libsepol libsemod checkpolicy policycoreutils policy
+
+ifeq ($(DEBUG),1)
+	export CFLAGS = -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow
+	export LDFLAGS = -g
+endif
 
 install: 
 	@for subdir in $(SUBDIRS); do \
diff -purN -x .svn -x CVS -x 'Makefile~' -x /policy/ -x '*.y' -x '*.l' nsa/selinux-usr/policycoreutils/audit2why/Makefile policy-modules/trunk/policycoreutils/audit2why/Makefile
--- nsa/selinux-usr/policycoreutils/audit2why/Makefile	2005-07-06 13:53:47.000000000 -0400
+++ policy-modules/trunk/policycoreutils/audit2why/Makefile	2005-07-13 13:42:22.000000000 -0400
@@ -7,9 +7,9 @@ LOCALEDIR ?= /usr/share/locale
 INCLUDEDIR ?= ${PREFIX}/include
 
 
-CFLAGS = -Werror
-override CFLAGS += -Wall -W -I$(INCLUDEDIR)
-LDLIBS += ${LIBDIR}/libsepol.a -lselinux
+CFLAGS ?= -Werror -Wall -W
+override CFLAGS += -I$(INCLUDEDIR)
+LDLIBS = ${LIBDIR}/libsepol.a -lselinux -L$(LIBDIR)
 
 TARGETS=audit2why
 
@@ -22,6 +22,6 @@ install: all
 	install -m 644 audit2why.8 $(MANDIR)/man8/
 
 clean:
-	rm -f $(TARGETS) *.o
+	-rm -f $(TARGETS) *.o
 
 relabel:
diff -purN -x .svn -x CVS -x 'Makefile~' -x /policy/ -x '*.y' -x '*.l' nsa/selinux-usr/policycoreutils/load_policy/Makefile policy-modules/trunk/policycoreutils/load_policy/Makefile
--- nsa/selinux-usr/policycoreutils/load_policy/Makefile	2005-06-28 15:03:25.000000000 -0400
+++ policy-modules/trunk/policycoreutils/load_policy/Makefile	2005-07-13 11:53:20.000000000 -0400
@@ -4,9 +4,9 @@ SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 
-CFLAGS = -Werror
-override CFLAGS += -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\"" -Wall -W
-LDLIBS += -lsepol -lselinux
+CFLAGS ?= -Werror -Wall -W
+override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+LDLIBS += -lsepol -lselinux -L$(PREFIX)/lib
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
@@ -19,7 +19,7 @@ install: all
 	install -m 644 load_policy.8 $(MANDIR)/man8/
 
 clean:
-	rm -f $(TARGETS) *.o 
+	-rm -f $(TARGETS) *.o 
 
 relabel:
 	/sbin/restorecon $(SBINDIR)/load_policy 
diff -purN -x .svn -x CVS -x 'Makefile~' -x /policy/ -x '*.y' -x '*.l' nsa/selinux-usr/policycoreutils/Makefile policy-modules/trunk/policycoreutils/Makefile
--- nsa/selinux-usr/policycoreutils/Makefile	2005-07-07 10:56:23.000000000 -0400
+++ policy-modules/trunk/policycoreutils/Makefile	2005-07-13 13:07:41.000000000 -0400
@@ -1,4 +1,4 @@
-SUBDIRS=setfiles load_policy newrole run_init restorecon audit2allow audit2why scripts po  sestatus semodule semodule_expand semodule_link semodule_package
+SUBDIRS=setfiles load_policy newrole run_init restorecon audit2allow audit2why scripts po sestatus semodule_link semodule_expand semodule
 
 all install relabel clean: 
 	@for subdir in $(SUBDIRS); do \
diff -purN -x .svn -x CVS -x 'Makefile~' -x /policy/ -x '*.y' -x '*.l' nsa/selinux-usr/policycoreutils/newrole/Makefile policy-modules/trunk/policycoreutils/newrole/Makefile
--- nsa/selinux-usr/policycoreutils/newrole/Makefile	2005-02-22 11:39:53.000000000 -0500
+++ policy-modules/trunk/policycoreutils/newrole/Makefile	2005-07-13 11:55:37.000000000 -0400
@@ -5,9 +5,9 @@ MANDIR ?= $(PREFIX)/share/man
 ETCDIR ?= $(DESTDIR)/etc
 LOCALEDIR = /usr/share/locale
 
-CFLAGS = -Werror
-override CFLAGS += -DUSE_NLS -DUSE_PAM -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\"" -Wall -W
-LDLIBS += -lselinux -lpam -lpam_misc
+CFLAGS ?= -Werror -Wall -W
+override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DUSE_PAM -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+LDLIBS += -lselinux -lpam -lpam_misc -L$(PREFIX)/lib
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
diff -purN -x .svn -x CVS -x 'Makefile~' -x /policy/ -x '*.y' -x '*.l' nsa/selinux-usr/policycoreutils/restorecon/Makefile policy-modules/trunk/policycoreutils/restorecon/Makefile
--- nsa/selinux-usr/policycoreutils/restorecon/Makefile	2005-02-22 11:39:53.000000000 -0500
+++ policy-modules/trunk/policycoreutils/restorecon/Makefile	2005-07-13 12:04:52.000000000 -0400
@@ -3,9 +3,9 @@ PREFIX ?= ${DESTDIR}/usr
 SBINDIR ?= $(DESTDIR)/sbin
 MANDIR = $(PREFIX)/share/man
 
-CFLAGS = -Werror
-override CFLAGS += -D_FILE_OFFSET_BITS=64 -Wall -W
-LDLIBS += -lselinux 
+CFLAGS ?= -Werror -Wall -W
+override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
+LDLIBS += -lselinux -L$(PREFIX)/lib
 
 all: restorecon
 
@@ -19,7 +19,7 @@ install: all
 	install -m 644 restorecon.8 $(MANDIR)/man8
 
 clean:
-	rm -f restorecon *.o 
+	-rm -f restorecon *.o 
 
 relabel: install
 	/sbin/restorecon $(SBINDIR)/restorecon
diff -purN -x .svn -x CVS -x 'Makefile~' -x /policy/ -x '*.y' -x '*.l' nsa/selinux-usr/policycoreutils/run_init/Makefile policy-modules/trunk/policycoreutils/run_init/Makefile
--- nsa/selinux-usr/policycoreutils/run_init/Makefile	2005-02-22 11:39:54.000000000 -0500
+++ policy-modules/trunk/policycoreutils/run_init/Makefile	2005-07-13 12:04:46.000000000 -0400
@@ -6,9 +6,9 @@ MANDIR ?= $(PREFIX)/share/man
 ETCDIR ?= $(DESTDIR)/etc
 LOCALEDIR ?= /usr/share/locale
 
-CFLAGS = -Werror
-override CFLAGS += -DUSE_NLS -DUSE_PAM -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\"" -Wall -W
-LDLIBS += -lselinux -lpam -lpam_misc
+CFLAGS ?= -Werror -Wall -W
+override CFLAGS += -I$(PREFIX)/include -DUSE_NLS -DUSE_PAM -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+LDLIBS += -lselinux -lpam -lpam_misc -L$(PREFIX)/lib
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
@@ -28,7 +28,7 @@ install: all
 	install -m 644 run_init.pamd $(ETCDIR)/pam.d/run_init
 
 clean:
-	rm -f $(TARGETS) *.o 
+	-rm -f $(TARGETS) *.o 
 
 relabel: install
 	/sbin/restorecon $(SBINDIR)/run_init $(SBINDIR)/open_init_pty
diff -purN -x .svn -x CVS -x 'Makefile~' -x /policy/ -x '*.y' -x '*.l' nsa/selinux-usr/policycoreutils/semodule/Makefile policy-modules/trunk/policycoreutils/semodule/Makefile
--- nsa/selinux-usr/policycoreutils/semodule/Makefile	2005-07-06 13:53:47.000000000 -0400
+++ policy-modules/trunk/policycoreutils/semodule/Makefile	2005-07-13 12:13:00.000000000 -0400
@@ -5,8 +5,9 @@ SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
 LIBDIR ?= ${PREFIX}/lib
 
-CFLAGS = -Wall -Wshadow $(DEBUG) -I$(INCLUDEDIR)
-LDLIBS = -L$(LIBDIR) -L/usr/lib -lselinux ${LIBDIR}/libsemod.a ${LIBDIR}/libsepol.a -g
+CFLAGS ?= -Werror -Wall -W
+override CFLAGS += -I$(INCLUDEDIR)
+LDLIBS = -lselinux -lsemod ${LIBDIR}/libsepol.a -L$(LIBDIR)
 SEMODULE_OBJS = semodule.o
 
 all: semodule
@@ -18,6 +19,4 @@ install: all
 	install -m 755 semodule $(SBINDIR)
 
 clean:
-	rm -f semodule *.o 
-
-relabel:
+	-rm -f semodule *.o 
diff -purN -x .svn -x CVS -x 'Makefile~' -x /policy/ -x '*.y' -x '*.l' nsa/selinux-usr/policycoreutils/semodule_expand/Makefile policy-modules/trunk/policycoreutils/semodule_expand/Makefile
--- nsa/selinux-usr/policycoreutils/semodule_expand/Makefile	2005-07-06 13:53:47.000000000 -0400
+++ policy-modules/trunk/policycoreutils/semodule_expand/Makefile	2005-07-13 12:13:05.000000000 -0400
@@ -1,23 +1,20 @@
 # Installation directories.
 PREFIX ?= ${DESTDIR}/usr
+INCLUDEDIR ?= $(PREFIX)/include
 BINDIR ?= $(PREFIX)/bin
 LIBDIR ?= ${PREFIX}/lib
-INCLUDEDIR ?= $(PREFIX)/include
 
-CFLAGS = -Wall -I$(INCLUDEDIR) $(DEBUG)
-LDLIBS += $(DEBUG) $(LIBDIR)/libsemod.a ${LIBDIR}/libsepol.a 
+CFLAGS ?= -Werror -Wall -W
+override CFLAGS += -I$(INCLUDEDIR)
+LDLIBS = -lselinux -lsemod ${LIBDIR}/libsepol.a -L$(LIBDIR)
 
 all: semodule_expand
 
 semodule_expand:  semodule_expand.o 
-	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
 
 install: all
 	-mkdir -p $(BINDIR)
 	install -m 755 semodule_expand $(BINDIR)
 
 clean:
-	rm -f semodule_expand *.o 
-
-relabel: 
-
+	-rm -f semodule_expand *.o 
diff -purN -x .svn -x CVS -x 'Makefile~' -x /policy/ -x '*.y' -x '*.l' nsa/selinux-usr/policycoreutils/semodule_link/Makefile policy-modules/trunk/policycoreutils/semodule_link/Makefile
--- nsa/selinux-usr/policycoreutils/semodule_link/Makefile	2005-07-06 13:53:47.000000000 -0400
+++ policy-modules/trunk/policycoreutils/semodule_link/Makefile	2005-07-13 12:13:23.000000000 -0400
@@ -1,22 +1,20 @@
 # Installation directories.
 PREFIX ?= ${DESTDIR}/usr
+INCLUDEDIR ?= $(PREFIX)/include
 BINDIR ?= $(PREFIX)/bin
 LIBDIR ?= ${PREFIX}/lib
-INCLUDEDIR ?= $(PREFIX)/include
 
-CFLAGS = -Wall -g -I$(INCLUDEDIR)
-LIBS= $(LIBDIR)/libsemod.a ${LIBDIR}/libsepol.a
+CFLAGS ?= -Werror -Wall -W
+override CFLAGS += -I$(INCLUDEDIR)
+LDLIBS= -lselinux -lsemod ${LIBDIR}/libsepol.a -L$(LIBDIR)
 
 all: semodule_link
 
 semodule_link:  semodule_link.o 
-	$(CC) -o $@ $^ $(LIBS)
 
 install: all
 	-mkdir -p $(BINDIR)
 	install -m 755 semodule_link $(BINDIR)
 
 clean:
-	rm -f semodule_link *.o 
-
-relabel: 
+	-rm -f semodule_link *.o 
diff -purN -x .svn -x CVS -x 'Makefile~' -x /policy/ -x '*.y' -x '*.l' nsa/selinux-usr/policycoreutils/semodule_package/Makefile policy-modules/trunk/policycoreutils/semodule_package/Makefile
--- nsa/selinux-usr/policycoreutils/semodule_package/Makefile	2005-07-06 13:53:47.000000000 -0400
+++ policy-modules/trunk/policycoreutils/semodule_package/Makefile	2005-07-13 12:12:33.000000000 -0400
@@ -1,23 +1,20 @@
 # Installation directories.
 PREFIX ?= ${DESTDIR}/usr
+INCLUDEDIR ?= $(PREFIX)/include
 BINDIR ?= $(PREFIX)/bin
 LIBDIR ?= ${PREFIX}/lib
-INCLUDEDIR ?= $(PREFIX)/include
 
-CFLAGS = -Wall -I$(INCLUDEDIR)
-LDLIBS += $(LIBDIR)/libsemod.a ${LIBDIR}/libsepol.a 
+CFLAGS ?= -Werror -Wall -W
+override CFLAGS += -I$(INCLUDEDIR)
+LDLIBS = -lselinux -lsemod ${LIBDIR}/libsepol.a -L$(LIBDIR)
 
 all: semodule_package
 
 semodule_package:  semodule_package.o 
-	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
 
 install: all
 	-mkdir -p $(BINDIR)
 	install -m 755 semodule_package $(BINDIR)
 
 clean:
-	rm -f semodule_package *.o 
-
-relabel: 
-
+	-rm -f semodule_package *.o 
diff -purN -x .svn -x CVS -x 'Makefile~' -x /policy/ -x '*.y' -x '*.l' nsa/selinux-usr/policycoreutils/sestatus/Makefile policy-modules/trunk/policycoreutils/sestatus/Makefile
--- nsa/selinux-usr/policycoreutils/sestatus/Makefile	2005-02-22 11:39:54.000000000 -0500
+++ policy-modules/trunk/policycoreutils/sestatus/Makefile	2005-07-13 12:15:22.000000000 -0400
@@ -3,15 +3,15 @@ PREFIX ?= ${DESTDIR}/usr
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
 ETCDIR ?= $(DESTDIR)/etc
+LIBDIR ?= ${PREFIX}/lib
 
-CFLAGS = -Werror
-override CFLAGS += -D_FILE_OFFSET_BITS=64 -Wall -W
-LDLIBS += -lselinux 
+CFLAGS = -Werror -Wall -W
+override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
+LDLIBS = -lselinux -L$(LIBDIR)
 
 all: sestatus
 
 sestatus:  sestatus.o 
-	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
 
 install: all
 	[ -d $(MANDIR)/man8 ] || mkdir -p $(MANDIR)/man8
diff -purN -x .svn -x CVS -x 'Makefile~' -x /policy/ -x '*.y' -x '*.l' nsa/selinux-usr/policycoreutils/setfiles/Makefile policy-modules/trunk/policycoreutils/setfiles/Makefile
--- nsa/selinux-usr/policycoreutils/setfiles/Makefile	2005-07-07 10:56:23.000000000 -0400
+++ policy-modules/trunk/policycoreutils/setfiles/Makefile	2005-07-13 12:15:55.000000000 -0400
@@ -2,17 +2,15 @@
 PREFIX ?= ${DESTDIR}/usr
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
-INCLUDEDIR = ${PREFIX}/include
-LIBDIR = ${PREFIX}/lib
+LIBDIR ?= $(PREFIX)/lib
 
-CFLAGS = -Werror
-override CFLAGS += -D_FILE_OFFSET_BITS=64 -Wall -W -I$(INCLUDEDIR)
-LDLIBS += -lselinux -lsepol -L$(LIBDIR)
+CFLAGS = -Werror -Wall -W 
+override CFLAGS += -D_FILE_OFFSET_BITS=64 -I$(PREFIX)/include
+LDLIBS = -lselinux -lsepol -L$(LIBDIR)
 
 all: setfiles
 
 setfiles:  setfiles.o 
-	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
 
 install: all
 	[ -d $(MANDIR)/man8 ] || mkdir -p $(MANDIR)/man8



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

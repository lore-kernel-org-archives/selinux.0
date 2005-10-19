Subject: [PATCH] makefile prefix fixes
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-DO5KGFRydh05R2OrQUw0"
Date: Wed, 19 Oct 2005 13:50:55 -0400
Message-Id: <1129744255.15338.11.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-DO5KGFRydh05R2OrQUw0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes prefix in recently changed Makefiles so that make
DESTDIR=somedir will work.

--=-DO5KGFRydh05R2OrQUw0
Content-Disposition: attachment; filename=1-makefile-prefix-fix.diff
Content-Type: text/x-patch; name=1-makefile-prefix-fix.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -purN -x .svn libselinux/src/Makefile /libselinux/src/Makefile
--- libselinux/src/Makefile	2005-10-13 13:33:20.000000000 -0400
+++ libselinux/src/Makefile	2005-10-17 09:52:51.000000000 -0400
@@ -23,7 +23,7 @@ $(LIBA):  $(OBJS)
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(LDFLAGS) -shared -o $@ $^ -ldl -lsepol -Wl,-soname,$(LIBSO),-z,defs
+	$(CC) $(LDFLAGS) -shared -o $@ $^ -ldl -lsepol -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs
 	ln -sf $@ $(TARGET) 
 
 %.o:  %.c policy.h
diff -purN -x .svn libselinux/utils/Makefile /libselinux/utils/Makefile
--- libselinux/utils/Makefile	2005-10-03 11:09:01.000000000 -0400
+++ libselinux/utils/Makefile	2005-10-17 09:52:50.000000000 -0400
@@ -1,10 +1,11 @@
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
+LIBDIR ?= $(PREFIX)/lib
 BINDIR ?= $(PREFIX)/sbin
 
 CFLAGS ?= -Wall
 override CFLAGS += -I../include -D_GNU_SOURCE
-LDLIBS += -L../src -lselinux 
+LDLIBS += -L../src -lselinux -lsepol -L$(LIBDIR)
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
diff -purN -x .svn libsemanage/src/Makefile /libsemanage/src/Makefile
--- libsemanage/src/Makefile	2005-10-19 12:36:40.000000000 -0400
+++ libsemanage/src/Makefile	2005-10-19 12:46:31.000000000 -0400
@@ -35,7 +35,7 @@ $(LIBA): $(OBJS)
 	ranlib $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(LDFLAGS) -shared -o $@ $^ -lsepol -lselinux -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
+	$(CC) $(LDFLAGS) -shared -o $@ $^ -lsepol -lselinux -L$(LIBDIR) -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
 	ln -sf $@ $(TARGET)
 
 conf-scan.c: conf-scan.l conf-parse.h
diff -purN -x .svn policycoreutils/audit2why/Makefile /policycoreutils/audit2why/Makefile
--- policycoreutils/audit2why/Makefile	2005-10-03 11:09:00.000000000 -0400
+++ policycoreutils/audit2why/Makefile	2005-10-17 09:52:50.000000000 -0400
@@ -9,7 +9,7 @@ INCLUDEDIR ?= ${PREFIX}/include
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = ${LIBDIR}/libsepol.a -lselinux -L$(LIBDIR)
+LDLIBS = ${LIBDIR}/libsepol.a -lselinux -lsepol -L$(LIBDIR)
 
 TARGETS=audit2why
 
diff -purN -x .svn policycoreutils/newrole/Makefile /policycoreutils/newrole/Makefile
--- policycoreutils/newrole/Makefile	2005-10-14 11:58:21.000000000 -0400
+++ policycoreutils/newrole/Makefile	2005-10-17 09:52:50.000000000 -0400
@@ -8,7 +8,7 @@ PAMH = $(shell ls /usr/include/security/
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-LDLIBS += -lselinux -L$(PREFIX)/lib
+LDLIBS += -lselinux -lsepol -L$(PREFIX)/lib
 ifeq (${PAMH}, /usr/include/security/pam_appl.h)
 	override CFLAGS += -DUSE_PAM
 	LDLIBS += -lpam -lpam_misc
diff -purN -x .svn policycoreutils/restorecon/Makefile /policycoreutils/restorecon/Makefile
--- policycoreutils/restorecon/Makefile	2005-10-03 11:09:00.000000000 -0400
+++ policycoreutils/restorecon/Makefile	2005-10-17 09:52:50.000000000 -0400
@@ -5,7 +5,7 @@ MANDIR = $(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
-LDLIBS += -lselinux -L$(PREFIX)/lib
+LDLIBS += -lselinux -lsepol -L$(PREFIX)/lib
 
 all: restorecon
 
diff -purN -x .svn policycoreutils/run_init/Makefile /policycoreutils/run_init/Makefile
--- policycoreutils/run_init/Makefile	2005-10-14 11:58:26.000000000 -0400
+++ policycoreutils/run_init/Makefile	2005-10-17 09:52:50.000000000 -0400
@@ -9,7 +9,7 @@ PAMH = $(shell ls /usr/include/security/
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-LDLIBS += -lselinux -L$(PREFIX)/lib
+LDLIBS += -lselinux -lsepol -L$(PREFIX)/lib
 ifeq (${PAMH}, /usr/include/security/pam_appl.h)
 	override CFLAGS += -DUSE_PAM
 	LDLIBS += -lpam -lpam_misc
diff -purN -x .svn policycoreutils/sestatus/Makefile /policycoreutils/sestatus/Makefile
--- policycoreutils/sestatus/Makefile	2005-10-03 11:09:01.000000000 -0400
+++ policycoreutils/sestatus/Makefile	2005-10-17 09:52:50.000000000 -0400
@@ -7,7 +7,7 @@ LIBDIR ?= ${PREFIX}/lib
 
 CFLAGS = -Werror -Wall -W
 override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
-LDLIBS = -lselinux -L$(LIBDIR)
+LDLIBS = -lselinux -lsepol -L$(LIBDIR)
 
 all: sestatus
 

--=-DO5KGFRydh05R2OrQUw0--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

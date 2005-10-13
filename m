Message-ID: <434EA0C1.7050706@diyab.net>
Date: Thu, 13 Oct 2005 14:00:33 -0400
From: Timothy <timothy@diyab.net>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Non-PAM Policycoreutils
Content-Type: multipart/mixed;
 boundary="------------080306000003050700080604"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080306000003050700080604
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

This patch against policycoreutils 1.26 will make it compile and install
correctly based on the presence of PAM.  Please apply.

Timothy,
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDTqDBSYq2KfPEK/gRA756AJ9oCl/vMApYBq/OaU3r2f7xDQ/e4wCfUAwq
45D5J2w39LVqofg29jbiAqs=
=jUzT
-----END PGP SIGNATURE-----

--------------080306000003050700080604
Content-Type: text/plain;
 name="policycoreutils-1.26-nopam.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-1.26-nopam.patch"

--- policycoreutils-1.26/newrole/Makefile	2005-07-18 09:42:21.000000000 -0400
+++ policycoreutils-1.26.slack/newrole/Makefile	2005-10-04 01:03:09.000000000 -0400
@@ -4,10 +4,18 @@
 MANDIR ?= $(PREFIX)/share/man
 ETCDIR ?= $(DESTDIR)/etc
 LOCALEDIR = /usr/share/locale
+PAMH = $(shell ls /usr/include/pam.h 2>/dev/null)
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DUSE_PAM -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-LDLIBS += -lselinux -lpam -lpam_misc -L$(PREFIX)/lib
+override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+LDLIBS += -lselinux -L$(PREFIX)/lib
+ifeq (${PAMH}, /usr/include/pam.h)
+	override CFLAGS += -DUSE_PAM
+	LDLIBS += -lpam -lpam_misc
+else
+	LDLIBS += -lcrypt
+endif
+
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
@@ -19,7 +27,10 @@
 	test -d $(MANDIR)/man1 || install -m 755 -d $(MANDIR)/man1
 	install -m 555 newrole $(BINDIR)
 	install -m 644 newrole.1 $(MANDIR)/man1/
+ifeq (${PAMH}, /usr/include/pam.h)
+	test -d $(ETCDIR)/pam.d || install -m 755 -d $(ETCDIR)/pam.d
 	install -m 644 newrole.pamd $(ETCDIR)/pam.d/newrole
+endif
 
 clean:
 	rm -f $(TARGETS) *.o 
--- policycoreutils-1.26/newrole/newrole.c	2005-07-11 15:18:42.000000000 -0400
+++ policycoreutils-1.26.slack/newrole/newrole.c	2005-10-04 00:58:45.000000000 -0400
@@ -215,6 +215,7 @@
  ************************************************************************/
 
 
+#define __USE_XOPEN
 #include <unistd.h>                         /* for getuid(), exit(), crypt() */
 #include <shadow.h>                         /* for shadow passwd functions */
 #include <string.h>                         /* for strlen(), memset() */
--- policycoreutils-1.26/run_init/Makefile	2005-07-18 09:42:21.000000000 -0400
+++ policycoreutils-1.26.slack/run_init/Makefile	2005-10-04 01:02:21.000000000 -0400
@@ -5,10 +5,17 @@
 MANDIR ?= $(PREFIX)/share/man
 ETCDIR ?= $(DESTDIR)/etc
 LOCALEDIR ?= /usr/share/locale
+PAMH = $(shell ls /usr/include/pam.h 2>/dev/null)
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -DUSE_NLS -DUSE_PAM -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-LDLIBS += -lselinux -lpam -lpam_misc -L$(PREFIX)/lib
+override CFLAGS += -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+LDLIBS += -lselinux -L$(PREFIX)/lib
+ifeq (${PAMH}, /usr/include/pam.h)
+	override CFLAGS += -DUSE_PAM
+	LDLIBS += -lpam -lpam_misc
+else
+	LDLIBS += -lcrypt
+endif
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
@@ -25,7 +32,9 @@
 	install -m 555 open_init_pty $(SBINDIR)
 	install -m 644 run_init.8 $(MANDIR)/man8/
 	install -m 644 open_init_pty.8 $(MANDIR)/man8/
+ifeq (${PAMH}, /usr/include/pam.h)
 	install -m 644 run_init.pamd $(ETCDIR)/pam.d/run_init
+endif
 
 clean:
 	-rm -f $(TARGETS) *.o 
--- policycoreutils-1.26/run_init/run_init.c	2005-01-21 07:55:20.000000000 -0500
+++ policycoreutils-1.26.slack/run_init/run_init.c	2005-10-04 00:58:20.000000000 -0400
@@ -145,6 +145,7 @@
  *
  ************************************************************************/
 
+#define __USE_XOPEN
 #include <unistd.h>                         /* for getuid(), exit(), crypt() */
 #include <shadow.h>                         /* for shadow passwd functions */
 #include <string.h>                         /* for strlen(), memset() */

--------------080306000003050700080604--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

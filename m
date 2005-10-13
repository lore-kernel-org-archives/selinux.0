Message-ID: <434EB30B.4080606@diyab.net>
Date: Thu, 13 Oct 2005 15:18:35 -0400
From: Timothy <timothy@diyab.net>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Non-PAM Policycoreutils
References: <434EA0C1.7050706@diyab.net> <1129227395.13490.8.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129227395.13490.8.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------080007020007070803090201"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080007020007070803090201
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

Stephen Smalley wrote:

> On Thu, 2005-10-13 at 14:00 -0400, Timothy wrote:
> 
>>This patch against policycoreutils 1.26 will make it compile and install
>>correctly based on the presence of PAM.  Please apply.
> 
> 
> Thanks.   However:
> 
> 
>>+PAMH = $(shell ls /usr/include/pam.h 2>/dev/null)
> 
> 
> /usr/include/pam.h is unrelated to PAM on my systems.  It is a header
> provided by the netpbm library containing a Portable Arbitrary Map image
> format definition.   PAM headers are under /usr/include/security, e.g.
> see the #include's in newrole.c or run_init.c.
> 
> Also, while not strictly necessary, it is preferable to submit patches
> generated against the sourceforge CVS tree - less likely to end up with
> rejects that way.  Anonymous pserver access is available, see
> http://sourceforge.net/cvs/?group_id=21266
> 

Fixed and tested against CVS.  New patch attached.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDTrMLSYq2KfPEK/gRA55mAJ9EfxCirzaive/if2r+EivpiogycwCeI287
DQ1d5IQQ+ErvwEaiRe31R+4=
=NWCk
-----END PGP SIGNATURE-----

--------------080007020007070803090201
Content-Type: text/plain;
 name="policycoreutils-nopam.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-nopam.patch"

--- policycoreutils-1.26/newrole/Makefile	2005-07-18 09:42:21.000000000 -0400
+++ policycoreutils-1.26.slack/newrole/Makefile	2005-10-04 01:03:09.000000000 -0400
@@ -4,10 +4,18 @@
 MANDIR ?= $(PREFIX)/share/man
 ETCDIR ?= $(DESTDIR)/etc
 LOCALEDIR = /usr/share/locale
+PAMH = $(shell ls /usr/include/security/pam_appl.h 2>/dev/null)
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DUSE_PAM -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-LDLIBS += -lselinux -lpam -lpam_misc -L$(PREFIX)/lib
+override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+LDLIBS += -lselinux -L$(PREFIX)/lib
+ifeq (${PAMH}, /usr/include/security/pam_appl.h)
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
+ifeq (${PAMH}, /usr/include/security/pam_appl.h)
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
+PAMH = $(shell ls /usr/include/security/pam_appl.h 2>/dev/null)
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -DUSE_NLS -DUSE_PAM -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-LDLIBS += -lselinux -lpam -lpam_misc -L$(PREFIX)/lib
+override CFLAGS += -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+LDLIBS += -lselinux -L$(PREFIX)/lib
+ifeq (${PAMH}, /usr/include/security/pam_appl.h)
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
+ifeq (${PAMH}, /usr/include/security/pam_appl.h)
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

--------------080007020007070803090201--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Message-ID: <434EDB86.2050702@diyab.net>
Date: Thu, 13 Oct 2005 18:11:18 -0400
From: Timothy <timothy@diyab.net>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Non-PAM Policycoreutils
References: <434EA0C1.7050706@diyab.net>	 <1129227395.13490.8.camel@moss-spartans.epoch.ncsc.mil>	 <434EB30B.4080606@diyab.net>	 <1129232343.13490.35.camel@moss-spartans.epoch.ncsc.mil>	 <434EBBDD.6040503@diyab.net> <1129233760.13490.44.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129233760.13490.44.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------020200050303000501090107"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020200050303000501090107
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

Stephen Smalley wrote:
> On Thu, 2005-10-13 at 15:56 -0400, Timothy wrote:
> 
>>The crypt defined in unistd.h is only read if __USE_XOPEN is defined so
>>it's required or make will fail for non-pam builds because the function
>>authenticate_via_shadow_passwd uses crypt.  I tried to add that define
>>to the CFLAGS in the makefile but it does not see that it is defined for
>>some reason and still errors out.
> 
> 
> Hmm...actually, since it is wrapped by the #else for USE_PAM, it isn't a
> problem to have it in the .c file, but I noticed that the man page for
> crypt(3) on my system says to define _XOPEN_SOURCE instead of directly
> defining __USE_XOPEN (features.h enables the latter when the former is
> enabled).  Note that the former only has a single leading underscore,
> unlike the latter.  Does #define'ing _XOPEN_SOURCE work for you there
> instead of __USE_XOPEN?
> 

Just _XOPEN_SOURCE caused new errors but _XOPEN_SOURCE defined to 500
works.  New patch attached.

Timothy,

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDTtuGSYq2KfPEK/gRA2etAJ43Z4KRzStnX5Z/CTd2q/VURf9PhgCffkGq
yAzwBdfbzgKWH/3WAm6Kjww=
=5PaU
-----END PGP SIGNATURE-----

--------------020200050303000501090107
Content-Type: text/plain;
 name="policycoreutils-nopam.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-nopam.patch"

--- policycoreutils/newrole/Makefile	2005-07-18 10:13:55.000000000 -0400
+++ policycoreutils-1.26.slack/newrole/Makefile	2005-10-04 02:22:03.000000000 -0400
@@ -4,10 +4,19 @@
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
+	override CFLAGS += -D_XOPEN_SOURCE=500
+	LDLIBS += -lcrypt
+endif
+
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
@@ -19,7 +28,10 @@
 	test -d $(MANDIR)/man1 || install -m 755 -d $(MANDIR)/man1
 	install -m 555 newrole $(BINDIR)
 	install -m 644 newrole.1 $(MANDIR)/man1/
+ifeq (${PAMH}, /usr/include/security/pam_appl.h)
+	test -d $(ETCDIR)/pam.d || install -m 755 -d $(ETCDIR)/pam.d
 	install -m 644 newrole.pamd $(ETCDIR)/pam.d/newrole
+endif
 
 clean:
 	rm -f $(TARGETS) *.o 
--- policycoreutils/run_init/Makefile	2005-07-18 10:13:56.000000000 -0400
+++ policycoreutils-1.26.slack/run_init/Makefile	2005-10-04 02:22:29.000000000 -0400
@@ -5,10 +5,18 @@
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
+	override CFLAGS += -D_XOPEN_SOURCE=500
+	LDLIBS += -lcrypt
+endif
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
@@ -25,7 +33,9 @@
 	install -m 555 open_init_pty $(SBINDIR)
 	install -m 644 run_init.8 $(MANDIR)/man8/
 	install -m 644 open_init_pty.8 $(MANDIR)/man8/
+ifeq (${PAMH}, /usr/include/security/pam_appl.h)
 	install -m 644 run_init.pamd $(ETCDIR)/pam.d/run_init
+endif
 
 clean:
 	-rm -f $(TARGETS) *.o 

--------------020200050303000501090107--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

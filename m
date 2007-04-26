Message-ID: <4630C59F.1070106@redhat.com>
Date: Thu, 26 Apr 2007 11:30:39 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: policycoreutils patch
Content-Type: multipart/mixed;
 boundary="------------090701040404070209030400"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090701040404070209030400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch moves audit2why to /usr/bin to match audit2allow, since both
can be used from userspace.  Also moves sepolgen-ifget to /usr/sbin,
since this is not to be run by normal users.


--------------090701040404070209030400
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude --exclude=sepolgen-1.0.8 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/audit2allow/Makefile policycoreutils-2.0.10/audit2allow/Makefile
--- nsapolicycoreutils/audit2allow/Makefile	2007-02-07 12:11:49.000000000 -0500
+++ policycoreutils-2.0.10/audit2allow/Makefile	2007-04-24 14:43:23.000000000 -0400
@@ -1,6 +1,7 @@
 # Installation directories.
 PREFIX ?= ${DESTDIR}/usr
 BINDIR ?= $(PREFIX)/bin
+SBINDIR ?= $(PREFIX)/sbin
 LIBDIR ?= $(PREFIX)/lib
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
@@ -10,7 +11,7 @@
 install: all
 	-mkdir -p $(BINDIR)
 	install -m 755 audit2allow $(BINDIR)
-	install -m 755 sepolgen-ifgen $(BINDIR)
+	install -m 755 sepolgen-ifgen $(SBINDIR)
 	-mkdir -p $(MANDIR)/man1
 	install -m 644 audit2allow.1 $(MANDIR)/man1/
 
diff --exclude-from=exclude --exclude=sepolgen-1.0.8 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/audit2why/Makefile policycoreutils-2.0.10/audit2why/Makefile
--- nsapolicycoreutils/audit2why/Makefile	2006-11-16 17:14:26.000000000 -0500
+++ policycoreutils-2.0.10/audit2why/Makefile	2007-04-24 14:43:23.000000000 -0400
@@ -1,6 +1,6 @@
 # Installation directories.
 PREFIX ?= ${DESTDIR}/usr
-BINDIR ?= $(PREFIX)/sbin
+BINDIR ?= $(PREFIX)/bin
 LIBDIR ?= ${PREFIX}/lib
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale


--------------090701040404070209030400--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

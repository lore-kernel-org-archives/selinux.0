Message-ID: <47067168.7010709@redhat.com>
Date: Fri, 05 Oct 2007 13:16:24 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: genhomedircon script 
Content-Type: multipart/mixed;
 boundary="------------070608010209000302060605"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070608010209000302060605
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Certain tools were calling genhomedircon and in certain cases
genhomedircon is handy for rebuilding the home directory mapping.

Since semodule -Bn will rebuild, added genhomedircon script that just
executes that command.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHBnFnrlYvE4MpobMRAlewAKCIEx4xXsOcfgqmmvPU+831lbULVACbB+cm
pj1mkkZoxZsZRgTjBkk4Q1s=
=SRCa
-----END PGP SIGNATURE-----

--------------070608010209000302060605
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude --exclude=sepolgen-1.0.10 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/scripts/genhomedircon policycoreutils-2.0.27/scripts/genhomedircon
--- nsapolicycoreutils/scripts/genhomedircon	1969-12-31 19:00:00.000000000 -0500
+++ policycoreutils-2.0.27/scripts/genhomedircon	2007-10-05 13:09:32.000000000 -0400
@@ -0,0 +1,2 @@
+#!/bin/sh
+/usr/sbin/semodule -Bn
diff --exclude-from=exclude --exclude=sepolgen-1.0.10 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/scripts/Makefile policycoreutils-2.0.27/scripts/Makefile
--- nsapolicycoreutils/scripts/Makefile	2007-08-23 16:52:26.000000000 -0400
+++ policycoreutils-2.0.27/scripts/Makefile	2007-10-04 10:25:50.000000000 -0400
@@ -5,12 +5,13 @@
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 
-all: fixfiles
+all: fixfiles genhomedircon
 
 install: all
 	-mkdir -p $(BINDIR)
 	install -m 755 chcat $(BINDIR)
 	install -m 755 fixfiles $(DESTDIR)/sbin
+	install -m 755 genhomedircon  $(SBINDIR)
 	-mkdir -p $(MANDIR)/man8
 	install -m 644 fixfiles.8 $(MANDIR)/man8/
 	install -m 644 chcat.8 $(MANDIR)/man8/

--------------070608010209000302060605
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iD8DBQBHBnForlYvE4MpobMRAkp1AJwI6WWSXmZYm6wwxNLTslLfQAgA5QCfeyuBXLpQ8xVk
qyTQjnfL+INPPTQ=
--------------070608010209000302060605--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

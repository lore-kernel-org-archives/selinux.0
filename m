Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9NLY3Wt012443
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2003 17:34:03 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9NLXmIS019676
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2003 21:33:48 GMT
Received: from extern.mail.waldi.eu.org (wavehammer.waldi.eu.org [82.139.196.55])
	by jazzswing.ncsc.mil  with ESMTP id h9NLXlDc019673
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2003 21:33:47 GMT
Date: Thu, 23 Oct 2003 23:33:54 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux-2
Message-ID: <20031023213354.GA23487@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--3lcZGd9BuhuYXNfi
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi folks

this patch fixes following problems:
- mark some attributes as unused
- signed vs. unsigned
- add -W -Werror to CFLAGS
files: utils/*

bastian

--=20
There are always alternatives.
		-- Spock, "The Galileo Seven", stardate 2822.3

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=libselinux-2
Content-Transfer-Encoding: quoted-printable

Index: utils/policyvers.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- utils/policyvers.c	(.../upstream/current/libselinux)	(revision 50)
+++ utils/policyvers.c	(.../trunk/libselinux)	(revision 50)
@@ -3,7 +3,7 @@
 #include <stdlib.h>
 #include <selinux/selinux.h>
=20
-int main(int argc, char **argv)=20
+int main(int argc __attribute__((unused)), char **argv)=20
 {
 	int rc;
=20
Index: utils/compute_av.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- utils/compute_av.c	(.../upstream/current/libselinux)	(revision 50)
+++ utils/compute_av.c	(.../trunk/libselinux)	(revision 50)
@@ -32,7 +32,7 @@
 	print_access_vector(tclass, avd.allowed);
 	printf("\n");
=20
-	if (avd.decided !=3D ~0) {
+	if (avd.decided !=3D ~0U) {
 		printf("decided=3D");
 		print_access_vector(tclass, avd.decided);
 		printf("\n");
@@ -44,7 +44,7 @@
 		printf("\n");
 	}
=20
-	if (avd.auditdeny !=3D ~0) {
+	if (avd.auditdeny !=3D ~0U) {
 		printf("auditdeny");
 		print_access_vector(tclass, avd.auditdeny);
 		printf("\n");
Index: utils/selinuxenabled.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- utils/selinuxenabled.c	(.../upstream/current/libselinux)	(revision 50)
+++ utils/selinuxenabled.c	(.../trunk/libselinux)	(revision 50)
@@ -3,7 +3,7 @@
 #include <stdlib.h>
 #include <selinux/selinux.h>
=20
-int main(int argc, char **argv)=20
+int main(void)=20
 {
 	return !is_selinux_enabled();
 }
Index: utils/mkdircon.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- utils/mkdircon.c	(.../upstream/current/libselinux)	(revision 50)
+++ utils/mkdircon.c	(.../trunk/libselinux)	(revision 50)
@@ -8,7 +8,7 @@
 int main(int argc, char **argv)=20
 {
 	int rc;
-	unsigned i;
+	int i;
=20
 	if (argc < 3) {
 		fprintf(stderr, "usage:  %s context dirname...\n",
Index: utils/getcon.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- utils/getcon.c	(.../upstream/current/libselinux)	(revision 50)
+++ utils/getcon.c	(.../trunk/libselinux)	(revision 50)
@@ -3,7 +3,7 @@
 #include <stdlib.h>
 #include <selinux/selinux.h>
=20
-int main(int argc, char **argv)=20
+int main(int argc __attribute__ ((unused)), char **argv)=20
 {
 	char *buf;
 	int rc;
Index: utils/getenforce.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- utils/getenforce.c	(.../upstream/current/libselinux)	(revision 50)
+++ utils/getenforce.c	(.../trunk/libselinux)	(revision 50)
@@ -3,7 +3,7 @@
 #include <stdlib.h>
 #include <selinux/selinux.h>
=20
-int main(int argc, char **argv)=20
+int main(int argc __attribute__((unused)), char **argv)=20
 {
 	int rc;
=20
Index: utils/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- utils/Makefile	(.../upstream/current/libselinux)	(revision 50)
+++ utils/Makefile	(.../trunk/libselinux)	(revision 50)
@@ -2,9 +2,9 @@
 PREFIX ?=3D $(DESTDIR)/usr
 BINDIR ?=3D $(PREFIX)/bin
=20
-CFLAGS =3D -Wall
+CFLAGS =3D -Wall -W -Werror
 override CFLAGS +=3D -I../include
-LDLIBS +=3D -L../src -lselinux=20
+LDLIBS +=3D -L../src -lselinux
=20
 TARGETS=3D$(patsubst %.c,%,$(wildcard *.c))
=20

--ikeVEW9yuYc//A+q--

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iEYEARECAAYFAj+YSUIACgkQLkAIIn9ODhFePQCgiuZkfwn8QLmrNBhaGadaEvVN
s9YAnjOtF8DOtbbWLUFayBMyvc/KP5WN
=C5lq
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

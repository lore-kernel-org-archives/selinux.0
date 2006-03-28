Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2SNHRlK022175
	for <selinux@tycho.nsa.gov>; Tue, 28 Mar 2006 18:17:27 -0500
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2SNHO5d006723
	for <selinux@tycho.nsa.gov>; Tue, 28 Mar 2006 23:17:25 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Wed, 29 Mar 2006 01:17:15 +0200
Date: Wed, 29 Mar 2006 01:17:11 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: PATCH: Add examples to man-pages
Message-Id: <20060328231709.GC8309@thorium.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--xesSdrSSBC0PokLI
Content-Type: multipart/mixed; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The patch below adds one example to the semodule man-page (because I use
it all the time while developing policy) and several examples to the
semanage man-page.=20
I tried to catch the most common use-cases, but maybe someone who has
more experience with semanage can add some more.

Thomas


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="pcu.diff"
Content-Transfer-Encoding: quoted-printable

Index: semanage/semanage.8
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/selinux/nsa/selinux-usr/policycoreutils/semanage/semanag=
e.8,v
retrieving revision 1.6
diff -u -r1.6 semanage.8
--- semanage/semanage.8	8 Mar 2006 17:16:06 -0000	1.6
+++ semanage/semanage.8	28 Mar 2006 23:03:50 -0000
@@ -75,7 +75,20 @@
 .I                \-v, \-\-verbose   =20
 verbose output
=20
+.SH EXAMPLE
+.nf
+# View SELinux user mappings
+$ semanage user -l
+# Allow joe to login as staff_u
+$ semanage login -a -s staff_u
+# Add file-context for everything under /web (used by restorecon)
+$ semanage fcontext -a -t httpd_sys_content_t '/web(/.*)?'
+# Allow Apache to listen on port 81
+$ semanage port -a -t http_port_t -p tcp 81
+.fi
+
 .SH "AUTHOR"
 This man page was written by Daniel Walsh <dwalsh@redhat.com> and
 Russell Coker <rcoker@redhat.com>.
+Examples by Thomas Bleher <ThomasBleher@gmx.de>.
=20
Index: semodule/semodule.8
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/selinux/nsa/selinux-usr/policycoreutils/semodule/semodul=
e.8,v
retrieving revision 1.2
diff -u -r1.2 semodule.8
--- semodule/semodule.8	2 Dec 2005 13:42:10 -0000	1.2
+++ semodule/semodule.8	28 Mar 2006 23:03:50 -0000
@@ -58,11 +58,12 @@
 $ semodule -i httpd.pp
 # List non-base modules.
 $ semodule -l
+# Replace all modules with the ones in the current directory
+$ semodule -b base.pp `semodule -l | awk '{print "-i " $1 ".pp"}'`
 .fi
=20
 .SH SEE ALSO
 .B checkmodule(8), semodule_package(8)
-(8),
 .SH AUTHORS
 .nf
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.

--5/uDoXvLw7AC5HRs--

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEKcP1D9qpeVMU938RAlcXAJ9UHFenEJrfgcX8kFtdTZtScWUd5wCeNRtk
VJ8yblZDLGiFtMGnTnbNbss=
=QQwL
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

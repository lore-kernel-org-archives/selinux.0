Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1E8gmRb002884
	for <selinux@tycho.nsa.gov>; Sat, 14 Feb 2004 03:42:48 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1E8glc3024915
	for <selinux@tycho.nsa.gov>; Sat, 14 Feb 2004 08:42:47 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
        by jazzband.ncsc.mil  with ESMTP id i1E8gkR0024912 for <selinux@tycho.nsa.gov>; Sat, 14 Feb 2004 08:42:47 GMT
Received: from nexus.verbum.private (dhcp024-208-187-170.columbus.rr.com [24.208.187.170])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "nexus.verbum.org", Issuer "monk.verbum.org" (verified OK))
	by monk.verbum.org (Postfix (Debian/GNU)) with ESMTP id 7ABC432A6FB
	for <selinux@tycho.nsa.gov>; Sat, 14 Feb 2004 03:45:04 -0500 (EST)
Subject: [Fwd: Bug#231561: setfiles ignores patterns beginning with a
	meta-character]
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WaceCFZGPub+rz2ukRNh"
Message-Id: <1076747890.14035.3.camel@nexus.verbum.private>
Mime-Version: 1.0
Date: Sat, 14 Feb 2004 03:38:10 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-WaceCFZGPub+rz2ukRNh
Content-Type: multipart/mixed; boundary="=-IwHYpGn0cVh/xEFVf5H5"


--=-IwHYpGn0cVh/xEFVf5H5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Here's a patch I got from a Debian user for setfiles.  It makes sense to
me.  What do you think?

--=-IwHYpGn0cVh/xEFVf5H5
Content-Disposition: inline
Content-Description: Forwarded message - Bug#231561: setfiles ignores
	patterns beginning with a meta-character
Content-Type: message/rfc822

Return-Path: <debbugs@bugs.debian.org>
X-Original-To: walters@nexus.verbum.private
Delivered-To: walters@nexus.verbum.private
Received: from localhost (nexus.verbum.private [127.0.0.1]) by
	nexus.verbum.private (Postfix) with ESMTP id 1E0F41753B8 for
	<walters@nexus.verbum.private>; Sat,  7 Feb 2004 13:19:06 -0500 (EST)
Delivered-To: walters@verbum.org
Received: from monk.debian.net [216.226.142.128] by localhost with IMAP
	(fetchmail-6.2.0) for walters@nexus.verbum.private (single-drop); Sat, 07
	Feb 2004 13:19:06 -0500 (EST)
Received: from spohr.debian.org (spohr.debian.org [128.193.0.4]) by
	monk.verbum.org (Postfix (Debian/GNU)) with ESMTP id DA11B32A6E9 for
	<walters@verbum.org>; Sat,  7 Feb 2004 08:09:58 -0500 (EST)
Received: from debbugs by spohr.debian.org with local (Exim 3.35 1
	(Debian)) id 1ApS6w-0005Do-00; Sat, 07 Feb 2004 05:03:02 -0800
X-Loop: owner@bugs.debian.org
Subject: Bug#231561: setfiles ignores patterns beginning with a
	meta-character
Reply-To: Robert Bihlmeyer <robbe@orcus.priv.at>, 231561@bugs.debian.org
Resent-From: Robert Bihlmeyer <robbe@orcus.priv.at>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Cc: Colin Walters <walters@debian.org>
Resent-Date: Sat, 07 Feb 2004 13:03:01 UTC
Resent-Message-ID: <handler.231561.B.107615847617525@bugs.debian.org>
X-Debian-PR-Message: report 231561
X-Debian-PR-Package: policycoreutils
X-Debian-PR-Keywords: patch
Received: via spool by submit@bugs.debian.org id=B.107615847617525 (code B
	ref -1); Sat, 07 Feb 2004 13:03:01 UTC
Received: (at submit) by bugs.debian.org; 7 Feb 2004 12:54:36 +0000
Received: from chello080110242202.117.11.tuwien.teleweb.at
	(hoss.orcus.priv.at) [80.110.242.202]  by spohr.debian.org with esmtp (Exim
	3.35 1 (Debian)) id 1ApRym-0004YM-00; Sat, 07 Feb 2004 04:54:36 -0800
Received: by hoss.orcus.priv.at (Postfix, from userid 1000) id A1492ECAB7;
	Sat,  7 Feb 2004 13:54:04 +0100 (CET)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
From: Robert Bihlmeyer <robbe@orcus.priv.at>
To: Debian Bug Tracking System <submit@bugs.debian.org>
X-Mailer: reportbug 2.39
Date: Sat, 07 Feb 2004 13:54:04 +0100
Message-Id: <20040207125404.A1492ECAB7@hoss.orcus.priv.at>
Delivered-To: submit@bugs.debian.org
Resent-Sender: Debian BTS <debbugs@bugs.debian.org>
X-Spam-Level: 
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on
	nexus.verbum.private
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham
	version=2.60
Content-Transfer-Encoding: quoted-printable

Package: policycoreutils
Version: 1.4-2.rb1
Severity: normal
Tags: patch

get_stem_from_spec() assumes that that the first character of a path
pattern is not a regexp meta-character. If it is, it may return a
wrong stem, preventing a match. Patch below.

For example, this pattern did not match correctly:

(/usr(/local|/X11R6)?)?/lib/lib[^/]*\.so.*	system_u:object_r:shlib_t

diff -ruN policycoreutils-1.4/setfiles/setfiles.c policycoreutils-1.4+/setf=
iles/setfiles.c
--- policycoreutils-1.4/setfiles/setfiles.c	2003-11-20 16:29:17.000000000 +=
0100
+++ policycoreutils-1.4+/setfiles/setfiles.c	2004-02-07 13:37:21.000000000 =
+0100
@@ -121,13 +121,13 @@
  * if there is no identifiable stem */
 int get_stem_from_spec(const char * const buf)
 {
-	const char *tmp =3D strchr(buf + 1, '/');
+	const char *tmp =3D strchr(buf, '/');
 	const char *ind;
=20
 	if(!tmp)
 		return 0;
=20
-	for(ind =3D buf + 1; ind < tmp; ind++)
+	for(ind =3D buf; ind < tmp; ind++)
 	{
 		if(strchr(regex_chars, (int)*ind))
 			return 0;


-- System Information:
Debian Release: testing/unstable
Architecture: i386
Kernel: Linux hoss 2.6.0-h3 #3 Tue Jan 6 20:03:18 CET 2004 i686
Locale: LANG=3Dde_AT@euro, LC_CTYPE=3Dde_AT

Versions of packages policycoreutils depends on:
ii  expect                      5.39.0-1     A program that "talks" to othe=
r pr
ii  libc6                       2.3.2.ds1-11 GNU C Library: Shared librarie=
s an
ii  libpam0g                    0.76-15      Pluggable Authentication Modul=
es l
ii  libselinux1                 1.4-0.1      SELinux shared libraries

-- no debconf information



--=-IwHYpGn0cVh/xEFVf5H5--

--=-WaceCFZGPub+rz2ukRNh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBALd5xOIkJWWp2WGURApqjAJ9XyqZmE3VQCScZPXki5kKt5wf6AACeI2zc
PWLRpStcXjR1+9dQYBDnSAo=
=1CMG
-----END PGP SIGNATURE-----

--=-WaceCFZGPub+rz2ukRNh--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

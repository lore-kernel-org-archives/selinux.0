Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0PKQ7IK007467
 for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2017 15:26:07 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 23CA8C05AA40
 for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2017 20:26:05 +0000 (UTC)
Date: Wed, 25 Jan 2017 15:26:01 -0500
From: Lokesh Mandvekar <lsm5@fedoraproject.org>
To: selinux@tycho.nsa.gov
Subject: Patch for typo fix
Message-ID: <20170125202600.th4vggl3xsjvpjnp@naruto.nanadai.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="z44xuk3nvdugo2ct"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--z44xuk3nvdugo2ct
Content-Type: multipart/mixed; boundary="nlabmdp2kog4eexd"
Content-Disposition: inline


--nlabmdp2kog4eexd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi, first patch (attached) to this list so please be gentle :)

It's just a typo fix. Is there a workflow I should be following to send
patches?

Thanks,
--=20
Lokesh
Freenode: lsm5
GPG: 0xC7C3A0DD
https://keybase.io/lsm5

--nlabmdp2kog4eexd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-libselinux-selinux_restorecon.3-man-page-typo-fix.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 04aa949c7a94000899396d20a72cd0293646eb15 Mon Sep 17 00:00:00 2001
=46rom: Lokesh Mandvekar <lsm5@fedoraproject.org>
Date: Wed, 25 Jan 2017 15:14:58 -0500
Subject: [PATCH] libselinux: selinux_restorecon.3 man page typo fix

Signed-off-by: Lokesh Mandvekar <lsm5@fedoraproject.org>
---
 libselinux/man/man3/selinux_restorecon.3 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/man/man3/selinux_restorecon.3 b/libselinux/man/man3=
/selinux_restorecon.3
index 2d8274b..d698818 100644
--- a/libselinux/man/man3/selinux_restorecon.3
+++ b/libselinux/man/man3/selinux_restorecon.3
@@ -26,7 +26,7 @@ containing a directory or file to be relabeled.
 If this is a directory and the
 .IR restorecon_flags
 .B SELINUX_RESTORECON_RECURSE
-has been set (for decending through directories), then
+has been set (for descending through directories), then
 .BR selinux_restorecon ()
 will write an SHA1 digest of the combined specfiles (see the
 .B NOTES
--=20
2.9.3


--nlabmdp2kog4eexd--

--z44xuk3nvdugo2ct
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJYiQnYAAoJEBwe3XzHw6DdK0YP/3gwcdA/SImCMaix0hTW4kaM
K4T+Vlw5Swt4KGVS5nUapSw/kj5DPM2nX48t/4MUaqcV7fE7sIe9c4CtVGo2GJOk
KtsBIxA9AFDI8LnsChJKVQiLZZYHeMe2senjJeHfwUVem17BfpGLH2ckH9JS4WnO
8Eu8RGGGQruuUtvzpmvGfTcal2+8ulu3YpCt8XU1M2ggt9k66jYQ1Irf4WkFK7+i
xWuuEdX+Sz45FWL6PjfPsxLfqVphwCAsQaku3gFQKVJU9+bbk5prpJmzi4b3TpjL
ZQ0t26NP9tb3WOx5b5TfCRyNKJVUfG1C6xm4kolfkojniFCleHYb6AdevTCGUs+U
6qJ8id9VG9+geEYmehKlYjhwKxCSWhdgfuFWj1UpReqUNyUoGN0UugnB+QKhYk+I
ucTG7SYetWBWYbMr/+dqpvGr8xlYQpV/vyxhsVtZiRXVn88ql3MgUmXlgqRwF9yY
DQ6xzzkTIJ8GcrJWPXwNQgZeBeXwGdoWjkaVAvgECk+X6x9ykpB0YIcfOGaY1uMv
enVLePd1M95G1qHjiDewFU0DxWWuiDtuWRI9G/lrq9+CTjBvfADjHWQ9nE0nsL60
hwYI3zha6shwtjCMDTKgZ6kOHHOVZPbe3mPM9B88FaXeJjoOjx5QGG0QNFwmOO3/
wyraM65/tZTK41Ag/sNL
=Wewt
-----END PGP SIGNATURE-----

--z44xuk3nvdugo2ct--

Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1MGK9dW023820
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 11:20:09 -0500 (EST)
Received: from vds-320151.amen-pro.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1MGHoZE001426
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 16:17:50 GMT
Subject: JFFS2 Extended attributes support & SELinux in handhelds
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: familiar-dev@handhelds.org, selinux@tycho.nsa.gov,
   "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: familiar@handhelds.org, handhelds@handhelds.org,
   kernel-discuss@handhelds.org, oe@handhelds.org, agruen@suse.de,
   Russell Coker <rcoker@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4HtJKJBoEZCZI4X+LsY2"
Date: Tue, 22 Feb 2005 17:17:19 +0100
Message-Id: <1109089039.4100.114.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-4HtJKJBoEZCZI4X+LsY2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I've been working in implementing extended attributes support in the
JFFS2 filesystem.

During the (short) time I worked on it, I just decided to try to bring
back the thread on SELinux in hand-held and embedded devices and see if
there's someone interested in contributing to it and collaborating to
make something out of it.

The current work is just a draft, I've started with the standard Vanilla
kernel sources plus mtd JFFS2 sources, used to patch the vanilla ones
for latest code (I'm confused on which one has the most updated tree or
if there are special differences between mtd's trees and vanilla's), and
implemented the skeleton using the reiserfs xattr code base.

Then Russell Coker commented to me that I should use the handhelds.org
kernel, so, I have the doubt on which one use, even if porting the
changes made to JFFS2 code base to vanilla sources wouldn't be
difficult, at least I suppose.

I've opened a few wiki pages for discussion and documenting until it
gets further developed:

	http://wiki.tuxedo-es.org/tuxedo/JFFS2xattr
	http://wiki.tuxedo-es.org/tuxedo/SELinuxEmbedded

In addition, having someone experienced with xattr API could be great,
as development documentation seems inexistent, among James Morris'
merged xattr consolidation code.

Thanks in advance,
Cheers.
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-4HtJKJBoEZCZI4X+LsY2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCG1sPDcEopW8rLewRAi7TAJwPqGMwWBFNHYvAk0HG8cFCYOBmBQCbBbdr
xZ4GE4PWeYT1SjggLImPL5U=
=7+r4
-----END PGP SIGNATURE-----

--=-4HtJKJBoEZCZI4X+LsY2--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

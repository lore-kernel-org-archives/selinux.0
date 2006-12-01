Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB15ZxL3024029
	for <selinux@tycho.nsa.gov>; Fri, 1 Dec 2006 00:35:59 -0500
Received: from alnrmhc11.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB15YFFt006349
	for <selinux@tycho.nsa.gov>; Fri, 1 Dec 2006 05:34:16 GMT
Subject: Re: coreutils status
From: Chris PeBenito <pebenito@gentoo.org>
To: Jim Meyering <jim@meyering.net>
Cc: James Antill <jantill@redhat.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <87venkibkl.fsf@rho.meyering.net>
References: <1158623120.31135.2.camel@gorn.pebenito.net>
	 <87venkibkl.fsf@rho.meyering.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WqTSeGb25nycE4jef7D/"
Date: Fri, 01 Dec 2006 00:33:41 -0500
Message-Id: <1164951221.10331.9.camel@gorn.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-WqTSeGb25nycE4jef7D/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-09-19 at 09:02 +0200, Jim Meyering wrote:
> Chris PeBenito <pebenito@gentoo.org> wrote:
> > What is the status of the selinux patches for coreutils going upstream?
>=20
> The code changes are mostly done, but I need more tests
> and some documentation.
>=20
> The changes are disruptive enough that they won't go in
> until after the upcoming stable release.

Any updates on this?  I don't see it in CVS, and it looks like there's
been four stable releases since the above.  Is there a patch that we can
test?

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-WqTSeGb25nycE4jef7D/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFb761vI7kLeavkkMRAq6pAJ4/ClY8vbxDwDvIIHFvxEufgufs+QCgo/wy
Bo8jw/JRopV0wrigbmZTbpI=
=bKUP
-----END PGP SIGNATURE-----

--=-WqTSeGb25nycE4jef7D/--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

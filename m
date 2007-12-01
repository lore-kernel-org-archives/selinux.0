Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lB1Lw0j8004105
	for <selinux@tycho.nsa.gov>; Sat, 1 Dec 2007 16:58:00 -0500
Received: from QMTA09.westchester.pa.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lB1Lw0IV027812
	for <selinux@tycho.nsa.gov>; Sat, 1 Dec 2007 21:58:00 GMT
Subject: Re: libsepol.expand_terule_helper: duplicate TE rule
From: Chris PeBenito <pebenito@gentoo.org>
To: Shintaro Fujiwara <shintaro.fujiwara@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <f71a82820712010015yafc65dfm21d3f21fbb264008@mail.gmail.com>
References: <f71a82820712010015yafc65dfm21d3f21fbb264008@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BuHzBJCAjHaPSbd4t52S"
Date: Sat, 01 Dec 2007 16:57:59 -0500
Message-Id: <1196546279.4808.2.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-BuHzBJCAjHaPSbd4t52S
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-12-01 at 17:15 +0900, Shintaro Fujiwara wrote:
> When I try to install apache.pp,
>=20
> libsepol.expand_terule_helper: duplicate TE rule for httpd_t
> exim_exec_t:process system_mail_t
> libsepol.expand_module: Error during expand
> libsemanage.semanage_expand_sandbox: Expand module failed
> semodule:  Failed!
>=20
> I can't find any lines concerning exim_exec_t anywhere...
> Please help.

Which distro policy are you using?

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-BuHzBJCAjHaPSbd4t52S
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQBHUdjnvI7kLeavkkMRAn9/AJ9EJkC4dUmtdlActvS3aE3uYMXmVgCbBFib
eC7J2frPJYiVr3oNdc2f7bc=
=2pht
-----END PGP SIGNATURE-----

--=-BuHzBJCAjHaPSbd4t52S--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

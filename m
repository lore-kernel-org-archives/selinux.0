Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5E9KGrT016953
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2004 05:20:16 -0400 (EDT)
Received: from sccrmhc11.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5E9K9P2000140
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2004 05:20:09 -0400 (EDT)
Subject: Re: too many sysadmfile?
From: Chris PeBenito <pebenito@gentoo.org>
To: Valdis.Kletnieks@vt.edu
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <200406140051.i5E0plBk003937@turing-police.cc.vt.edu>
References: <1086884579.19414.30.camel@gorn.pebenito.net>
	 <1086893852.4397.83.camel@moss-spartans.epoch.ncsc.mil>
	 <1086971434.19414.148.camel@gorn.pebenito.net>
	 <200406140051.i5E0plBk003937@turing-police.cc.vt.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-h94rh8ZA8j0xdQuwtoAc"
Message-Id: <1087204813.23933.150.camel@gorn.pebenito.net>
Mime-Version: 1.0
Date: Mon, 14 Jun 2004 04:20:13 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-h94rh8ZA8j0xdQuwtoAc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-06-13 at 19:51, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 11 Jun 2004 11:30:35 CDT, Chris PeBenito said:
>=20
> > How does not being able to write to bin_t files, for example, break the
> > existing usage?
>=20
> "Existing usage" includes the idea that these "should work":
>=20
> # dmesg > /tmp/foo
>=20
> or
>=20
> # vi /etc/hosts

I don't see how these would be broken.  Admin_domain() has tmp_domain(),
so /tmp/foo will be writable.  I'm not arguing that sysadmfile should be
eliminated, just reduced; /etc/hosts would still be a sysadmfile, and
therefore be writable.

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
Embedded Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-h94rh8ZA8j0xdQuwtoAc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAzW3MvI7kLeavkkMRAqcDAJ9oLOqWK2SFel/pfm8ZhySmiz78tQCdGCjk
Z5N7p1iz/oeeyhql4pCGB+g=
=U0Ic
-----END PGP SIGNATURE-----

--=-h94rh8ZA8j0xdQuwtoAc--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

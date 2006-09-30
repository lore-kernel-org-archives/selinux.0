Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8U59LKN012444
	for <selinux@tycho.nsa.gov>; Sat, 30 Sep 2006 01:09:21 -0400
Received: from rwcrmhc13.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8U58ET1019286
	for <selinux@tycho.nsa.gov>; Sat, 30 Sep 2006 05:08:15 GMT
Subject: Re: Default Mikefile in /usr/share/selinux/devel not nice
From: Chris PeBenito <pebenito@gentoo.org>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <451D8C2F.9040901@us.ibm.com>
References: <451D8C2F.9040901@us.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IEurnRicZ8NcXn9wDxVE"
Date: Sat, 30 Sep 2006 00:32:31 -0400
Message-Id: <1159590751.12161.10.camel@gorn.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-IEurnRicZ8NcXn9wDxVE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-09-29 at 16:12 -0500, Michael C Thompson wrote:
> I just discovered a nasty surprise waiting for me in the default=20
> Makefile provided by selinux-policy-devel.
>=20
> Basically, the Makefile produces, on an MLS system, a TYPE value of=20
> mls-msc (this is due to the SELINUXTYPE=3Dmls line in=20
> /etc/selinux/config). This will not 'enable_mls' for the M4FLAGS,=20
> because the Makefile in /usr/share/selinux/devel/include/ does a=20
> findstring for '-mls'.
>=20
> Dan Walsh has suggested a fix for the default Makefile, but I'm=20
> wondering why we can't just change=20
> /usr/share/selinux/devel/include/Makefile to do a $(findstring=20
> mls,$TYPE)) instead, since its not unreasonable to think that TYPE=3Dmls=20
> makes sense.

There is some confusion here, the SELINUXTYPE is not the same as TYPE in
refpolicy, it is NAME in refpolicy.  The TYPE of the Redhat MLS policy
is strict-mls.  TYPE=3Dmls does not make sense, since it does not specify
if the policy is strict or targeted.

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-IEurnRicZ8NcXn9wDxVE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFHfNfvI7kLeavkkMRAvbOAJ0Va9YHf/ZTzRyOpbkbXpXlAaOt3gCgg6zS
Vd4CiMaenBqbzQKHL1Ma4uk=
=dJhS
-----END PGP SIGNATURE-----

--=-IEurnRicZ8NcXn9wDxVE--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

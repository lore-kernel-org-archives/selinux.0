Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by localhost.localdomain (8.13.1/8.13.1) with ESMTP id k1H4OLJP006857
	for <selinux@tycho.nsa.gov>; Thu, 16 Feb 2006 23:24:21 -0500
Received: from rwcrmhc14.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1H4OJPl015244
	for <selinux@tycho.nsa.gov>; Fri, 17 Feb 2006 04:24:20 GMT
Subject: semanage non MLS breakage
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-AKmgKeATGqJYu6Jsw29P"
Date: Thu, 16 Feb 2006 23:24:18 -0500
Message-Id: <1140150258.13377.15.camel@gorn.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.ncsc.mil
List-Id: selinux@tycho.nsa.gov


--=-AKmgKeATGqJYu6Jsw29P
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

With the current sourceforge CVS, non MLS usage is broken with semanage:

# semanage login -l

Login Name                SELinux User              MLS/MCS Range

root                      root                      __default__:user_u

# semanage login -a -s staff_u pebenito
Segmentation fault


The seusers file installed from refpolicy, in the base module looks
like:

root:root:
__default__:user_u:

It doesn't work with or without the last colon.

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


--=-AKmgKeATGqJYu6Jsw29P
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD9U/yvI7kLeavkkMRAnpfAKCSPBb4SezbVRz5mcCuJa8SZtbDrwCfeq65
TnQP6ARizfS0rk9BVVdWFNM=
=J8Zb
-----END PGP SIGNATURE-----

--=-AKmgKeATGqJYu6Jsw29P--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

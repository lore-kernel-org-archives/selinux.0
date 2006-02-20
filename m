Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1K4CXgV006458
	for <selinux@tycho.nsa.gov>; Sun, 19 Feb 2006 23:12:33 -0500
Received: from rwcrmhc13.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1K4CVQp028874
	for <selinux@tycho.nsa.gov>; Mon, 20 Feb 2006 04:12:31 GMT
Subject: libselinux swig wrapper breakage
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/AUi+LdsTq44kRH0OE3K"
Date: Sun, 19 Feb 2006 23:12:25 -0500
Message-Id: <1140408745.8756.31.camel@gorn.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-/AUi+LdsTq44kRH0OE3K
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I was testing a few functions from the libselinux swig wrapper (cvs
selinux-usr) and ran in to problems:

>>> import selinux
>>> selinux.setexeccon('user_u:user_r:user_spamassassin_t')
Traceback (most recent call last):
  File "<stdin>", line 1, in ?
TypeError: argument number 1: a 'security_context_t *' is expected, 'str(us=
er_u:user_r:user_spamassassin_t)' is received
>>> selinux.getexeccon()
Segmentation fault


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


--=-/AUi+LdsTq44kRH0OE3K
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD+UGovI7kLeavkkMRAvjxAJ4pDBSw958D9P/0/i1nnZBhUH13uQCfUpi5
0Dmqa+j+7Ucrrcv8K5MSnKU=
=jmXD
-----END PGP SIGNATURE-----

--=-/AUi+LdsTq44kRH0OE3K--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

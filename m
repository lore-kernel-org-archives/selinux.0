Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2OMm0Do005790
	for <selinux@tycho.nsa.gov>; Thu, 24 Mar 2005 17:48:00 -0500 (EST)
Received: from vds-320151.amen-pro.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2OMjBQL010591
	for <selinux@tycho.nsa.gov>; Thu, 24 Mar 2005 22:45:12 GMT
Subject: [RFC] selinux-support (1.0.1) available
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: ubuntu-hardened@lists.ubuntu.com
Cc: selinux@tycho.nsa.gov, ubuntu-devel@lists.ubuntu.com,
   ubuntu-users@lists.ubuntu.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pOWNiSYB47FzLab1szJG"
Date: Thu, 24 Mar 2005 23:47:12 +0100
Message-Id: <1111704432.27644.62.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-pOWNiSYB47FzLab1szJG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I'm glad to announce the public availability of the selinux-support
(meta-)package which accomplishes the goal of installing the user-land
tools for Security-Enhanced Linux support and few configuration-related
files that will be used in a near future during the deployment of
SELinux within Ubuntu Linux.

The packages depending on selinux-support (which are subsequently
installed when installing it) are:

	* selinux-doc
	* slat
	* selinux-utils
	* libselinux1
	* libselinux1-dev
	* policycoreutils
	* libsepol1
	* checkpolicy
	* selinux-policy-default

It also provides the Python bindings for libselinux, coming from the
Hardened Gentoo project and available in the Gentoo CVS:
http://www.gentoo.org/cgi-bin/viewcvs.cgi/dev-python/python-selinux

It's available (as apt'able package) at the repository=20
http://pearls.tuxedo-es.org/selinux/debian
and more concretely in
http://pearls.tuxedo-es.org/selinux/debian/selinux-support/

Please, send back comments, suggestions, critics, etc.

I would like to thank Andrew Mitchell because of his help and comments
during it's short) development :)

Thanks, cheers.
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-pOWNiSYB47FzLab1szJG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCQ0NwDcEopW8rLewRAg24AKDI+nGNU08JBeJ3RYgc9QyGSUDDKACdHPbP
sWi+0orByzM0YjtFUCptoJY=
=nhmY
-----END PGP SIGNATURE-----

--=-pOWNiSYB47FzLab1szJG--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

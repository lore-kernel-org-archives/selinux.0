Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAOIDCIi021731
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 13:13:13 -0500 (EST)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAOIDFC8004372
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 18:13:15 GMT
Subject: Re: xen 2.0 - adding selinux permissions
From: Colin Walters <walters@verbum.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20041124154936.GB14100@lkcl.net>
References: <20041123220352.GF5146@lkcl.net>
	 <1101303556.22014.56.camel@moss-spartans.epoch.ncsc.mil>
	 <20041124150927.GP5146@lkcl.net>
	 <1101308769.22014.136.camel@moss-spartans.epoch.ncsc.mil>
	 <20041124154936.GB14100@lkcl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-N5jEXTFFjwSQuN5WuCz1"
Date: Wed, 24 Nov 2004 13:13:15 -0500
Message-Id: <1101319995.30763.11.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-N5jEXTFFjwSQuN5WuCz1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-11-24 at 15:49 +0000, Luke Kenneth Casson Leighton wrote:

>  okay, regarding the second argument to avc_has_perm(),
>  i asked the nice xen developers if it'd be possible to
>  associate a sid with each virtual machine.

When would you want a process to be able to control one Xen machine but
not another?


--=-N5jEXTFFjwSQuN5WuCz1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBpM87OIkJWWp2WGURAri0AJ0UJtWzfbYuJyT5L/hoK11+3FQO/QCfegdQ
GRhSsjbKzOXnyMrMZlnEm0E=
=4+RR
-----END PGP SIGNATURE-----

--=-N5jEXTFFjwSQuN5WuCz1--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

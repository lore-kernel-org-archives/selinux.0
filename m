Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2RGPGDo020420
	for <selinux@tycho.nsa.gov>; Sun, 27 Mar 2005 11:25:17 -0500 (EST)
Received: from vds-320151.amen-pro.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2RGOa7X002056
	for <selinux@tycho.nsa.gov>; Sun, 27 Mar 2005 16:24:37 GMT
Subject: selinux-policy-targeted (1:1.22-3) available
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: ubuntu-hardened@lists.ubuntu.com
Cc: Colin Walters <walters@verbum.org>, rcoker@redhat.com, dwalsh@redhat.com,
   selinux@tycho.nsa.gov
In-Reply-To: <1111928686.27644.249.camel@localhost.localdomain>
References: <1111884872.27644.228.camel@localhost.localdomain>
	 <1111887665.16952.22.camel@nexus.verbum.private>
	 <1111928686.27644.249.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jEY9beZ1coJEZgoMv9Qi"
Date: Sun, 27 Mar 2005 18:24:08 +0200
Message-Id: <1111940648.27644.258.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-jEY9beZ1coJEZgoMv9Qi
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

The new selinux-policy-targeted (1:1.22-3) package is available.

Some improvements have been made to the package since the 1.22-2
version, the weird configuration method is not anymore used,
post-installation script doesn't add a selinuxfs entry to
your /etc/fstab everytime you (re)install or upgrade the package...

Changes are reflected at:
http://pearls.tuxedo-es.org/selinux/ubuntu/selinux-policy-targeted/
selinux-policy-targeted_1.22-3_i386.changes

The package is available at:
http://pearls.tuxedo-es.org/selinux/ubuntu/selinux-policy-targeted/

Continue making comments, suggestions and critics ;)

I don't want to seem impatient with the SELinux deployment in Ubuntu
Linux, but the next 3 months I will have limited time, so, I want to
have at least the 75% of the work done (it's around 87% now, just some
more userland work and we are done for fine-tuning, etc), even if Breezy
is far away from us (Hoary is still not released).
By doing this quickly and before others, and as soon as we start it, as
soon as we will finish it, we gain momentum ;)

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-jEY9beZ1coJEZgoMv9Qi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCRt4oDcEopW8rLewRAntHAKDJh8XqyMPcolE+kyg/cXAAG8+GZQCg0Bzr
VWDN9iCqaBU/+MteVVPTDKE=
=cEA6
-----END PGP SIGNATURE-----

--=-jEY9beZ1coJEZgoMv9Qi--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

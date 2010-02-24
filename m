Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1OK4H40026672
	for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2010 15:04:17 -0500
Received: from mail-ew0-f209.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o1OK4Yvp002979
	for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2010 20:04:35 GMT
Received: by ewy1 with SMTP id 1so563492ewy.18
        for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2010 12:04:15 -0800 (PST)
Message-ID: <4B85862B.40502@gmail.com>
Date: Wed, 24 Feb 2010 21:03:55 +0100
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Last attempt at upstreaming semodule_disable patch.
References: <4B858311.1010003@redhat.com>
In-Reply-To: <4B858311.1010003@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig304BD167D66061394065A8F4"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig304BD167D66061394065A8F4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/24/2010 08:50 PM, Daniel J Walsh wrote:
> This patch allows you to disable/Enable policy modules.
>=20
> It never seems to get upstreamed.  :^(

This is a wonderful feature. It allows me to replace existing modules
and to easily modify existing policy.


--------------enig304BD167D66061394065A8F4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuFhjkACgkQMlxVo39jgT9qswCdEWjqQi0p1t40oqE6HbJXzlsV
1foAni4nBrW/RerG55ZgEnp6mBq0m2nV
=qofB
-----END PGP SIGNATURE-----

--------------enig304BD167D66061394065A8F4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

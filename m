Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8LEf6rT024913
	for <selinux@tycho.nsa.gov>; Tue, 21 Sep 2004 10:41:06 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8LEf5pT007420
	for <selinux@tycho.nsa.gov>; Tue, 21 Sep 2004 14:41:05 GMT
Subject: Re: File types that are not sysadmfiles...
From: Colin Walters <walters@redhat.com>
To: russell@coker.com.au
Cc: Daniel J Walsh <dwalsh@redhat.com>,
   "Christopher J. PeBenito" <cpebenito@tresys.com>,
   Joshua Brindle <method@gentoo.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <200409211508.59158.russell@coker.com.au>
References: <414DA0A7.1000708@gentoo.org>
	 <1095695627.4431.157.camel@nexus.verbum.private>
	 <414F4113.1000208@redhat.com>  <200409211508.59158.russell@coker.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cwQe3vv1swEaIu49wC64"
Date: Tue, 21 Sep 2004 10:42:24 -0400
Message-Id: <1095777744.5427.9.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-cwQe3vv1swEaIu49wC64
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-09-21 at 15:08 +1000, Russell Coker wrote:

> --- /usr/src/se/policy/domains/program/unused/hald.te   2004-09-17
> 22:01:26.000000000 +1000
> +++ ./domains/program/unused/hald.te    2004-09-20 08:47:12.000000000
> +1000
> @@ -34,11 +34,10 @@
>  allow hald_t self:capability { net_admin sys_admin };
>  can_network(hald_t)
>  can_ypbind(hald_t)
> -dbusd_client(system, hald_t)

Why did you do this?  Certainly the HAL daemon is a client of the system
bus...



--=-cwQe3vv1swEaIu49wC64
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBUD3QOIkJWWp2WGURAoc3AJ4spu4qshtahLcgWDAAha7HVgbKgACfRi7R
LVDvUiNRv4/6svscckDzQjQ=
=O8tx
-----END PGP SIGNATURE-----

--=-cwQe3vv1swEaIu49wC64--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

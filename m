Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8LFi4rT025689
	for <selinux@tycho.nsa.gov>; Tue, 21 Sep 2004 11:44:04 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8LFh5aY000665
	for <selinux@tycho.nsa.gov>; Tue, 21 Sep 2004 15:43:06 GMT
Subject: Re: File types that are not sysadmfiles...
From: Colin Walters <walters@redhat.com>
To: russell@coker.com.au
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <200409220125.36337.russell@coker.com.au>
References: <414DA0A7.1000708@gentoo.org>
	 <200409211508.59158.russell@coker.com.au>
	 <1095777744.5427.9.camel@nexus.verbum.private>
	 <200409220125.36337.russell@coker.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uo1UCmf6PoCfs5SXLQYT"
Date: Tue, 21 Sep 2004 11:45:27 -0400
Message-Id: <1095781527.5427.26.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-uo1UCmf6PoCfs5SXLQYT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-09-22 at 01:25 +1000, Russell Coker wrote:

> ifdef(`dbusd.te', `
> allow hald_t system_dbusd_t:dbus { acquire_svc };
> dbusd_client(system, hald_t)
> ')
>=20
> In the above policy in hald.te someone had made a type and put dbus.te in=
stead=20
> of dbusd.te.  As that didn't work as desired someone else apparently put=20
> dbusd_client(system, hald_t) later on in the policy.  We only need one=20
> instance of dbusd_client(system, hald_t), so now that the dbus.te bug is=20
> fixed I'm removing the extra one.

Ah ok, good catch then, thanks.


--=-uo1UCmf6PoCfs5SXLQYT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBUEyXOIkJWWp2WGURAroTAJ9QDGM63Xt6m0WjEqQMzDWADpC6agCfQ59E
YTFaEo3P+tP+zrp8uaArDoo=
=hxWg
-----END PGP SIGNATURE-----

--=-uo1UCmf6PoCfs5SXLQYT--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

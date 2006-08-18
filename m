Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7IIV8k4019954
	for <selinux@tycho.nsa.gov>; Fri, 18 Aug 2006 14:31:08 -0400
Received: from mail.and.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7IIUg02006122
	for <selinux@tycho.nsa.gov>; Fri, 18 Aug 2006 18:30:42 GMT
From: James Antill <jantill@redhat.com>
To: Jim Meyering <jim@meyering.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <87veop2a7d.fsf@rho.meyering.net>
References: <87veop2a7d.fsf@rho.meyering.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-a3nPeMYg1XnekFE3HEmp"
Date: Fri, 18 Aug 2006 14:30:55 -0400
Message-Id: <1155925855.18274.16.camel@code.and.org>
Mime-Version: 1.0
Subject: Re: cp: --preserve={context,xattr,acl}
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-a3nPeMYg1XnekFE3HEmp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-08-18 at 20:03 +0200, Jim Meyering wrote:
> Currently, upstream cp can selectively preserve a few different attribute=
s.
> From the documentation:
[...]
> The SELinux patches add "context" to the list.
> and upstream treats ACLs like "mode".
>=20
> However, with XATTR support, I may well add two more: "xattr" and "acl".
>=20
> But then there'd be overlap between --preserve=3Dxattr and --preserve=3Dc=
ontext,
> Since I presume the latter subsumes the former.  Right?
>=20
> So if both were specified on a selinux-enabled system,
> would there be any point in doing anything XATTR-specific?

 With tar I had xattr imply acl and selinux, but then they could be used
individually like: --preserve=3Dxattrs --no-preserve=3Dselinux (does generi=
c
user xattrs and acls, but not selinux context).
 Although the tar patches haven't been accepted upstream yet (they are
just before a stable release, so aren't accepting features).

--=20
James Antill <jantill@redhat.com>

--=-a3nPeMYg1XnekFE3HEmp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE5gdf11eXTEMrxtQRAnQBAJ46ybLLWvvFFPdHjiueLOZfaib6TQCeJ9IY
WViE2xKtOzmHqYwW4fxvF7Y=
=KkIi
-----END PGP SIGNATURE-----

--=-a3nPeMYg1XnekFE3HEmp--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j04FHDIi024639
	for <selinux@tycho.nsa.gov>; Tue, 4 Jan 2005 10:17:13 -0500 (EST)
Received: from ms-smtp-04.rdc-kc.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j04FHGA9000329
	for <selinux@tycho.nsa.gov>; Tue, 4 Jan 2005 15:17:16 GMT
Date: Tue, 4 Jan 2005 09:17:03 -0600
From: Greg Norris <haphazard@kc.rr.com>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: [patch] types.fc
Message-ID: <20050104151703.GA8223@yggdrasil.localdomain>
References: <20050104025950.GA5321@yggdrasil.localdomain> <200501050032.29370.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
In-Reply-To: <200501050032.29370.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 05, 2005 at 12:32:26AM +1100, Russell Coker wrote:
> You also need the same for the three lines that follow.  I posted a patch=
 at=20
> about the same time as your message which made the appropriate change.

OK, I'll keep an eye open... it doesn't seem to have gotten here yet.

> But I have been considering just moving to the locations that are used in=
=20
> Fedora.

This seems like a good idea to me.  If nothing else, it would make it=20
easier to support multiple policies in the future... should we decide to=20
do something similar to Fedora's strict/targeted scheme.  Personally, I=20
rather like their approach.


--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB2rNvgrEMyr8Cx2YRAl4AAJ9uvUwJOWHpeQD9A6Xlfgey+NJIMgCgm4cO
z/Mzv/9+9bZ6TgKbB/vlSAE=
=N5g0
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

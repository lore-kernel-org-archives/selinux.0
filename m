Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB3NOqRb025109
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 18:24:52 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB3NOpRV018022
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 23:24:51 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
        by jazzband.ncsc.mil  with ESMTP id hB3NOpta018013 for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 23:24:51 GMT
Received: from nexus.verbum.private (dhcp024-208-187-170.columbus.rr.com [24.208.187.170])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "nexus.verbum.org", Issuer "monk.verbum.org" (verified OK))
	by monk.verbum.org (Postfix (Debian/GNU)) with ESMTP id 0F7BA32A6D4
	for <selinux@tycho.nsa.gov>; Wed,  3 Dec 2003 18:25:05 -0500 (EST)
Subject: Re: "new" SELinux 2.4.22 UML kernel patch + sample Debian
	filesystem
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
In-Reply-To: <1070347847.12634.512.camel@nexus.verbum.private>
References: <1070347847.12634.512.camel@nexus.verbum.private>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-A5SewEDPuN7RwpNq3/vy"
Message-Id: <1070493685.24232.7.camel@nexus.verbum.private>
Mime-Version: 1.0
Date: Wed, 03 Dec 2003 18:21:26 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-A5SewEDPuN7RwpNq3/vy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-12-02 at 01:50, Colin Walters wrote:

> Additionally, I've created a roomy 350MB Debian sid image (which gzipped
> into just 370kb), set up with the latest Debian sid SELinux packages.=20
> It seems to work fine even in enforcing mode.  I had to disable bootlogd
> though.

Somehow I managed to upload the UML COW image instead of the actual
filesystem.  That's fixed now.

Note that the real image is 90MB, and I pay for bandwidth, so please
only download it if you are having trouble bootstrapping a root
filesystem and/or installing SELinux yourself.


--=-A5SewEDPuN7RwpNq3/vy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/zm/0OIkJWWp2WGURAjKSAKCCGBi6mWUwLiSBhAFzG45XFdZ1PgCfVKTD
+XtYU8bH2LvEOQNumOd+NU0=
=4mg9
-----END PGP SIGNATURE-----

--=-A5SewEDPuN7RwpNq3/vy--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

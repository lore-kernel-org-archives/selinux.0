Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1OKsHRb026132
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 15:54:17 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1OKqglK012232
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 20:52:43 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
	by jazzswing.ncsc.mil  with ESMTP id i1OKqgOX012219
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 20:52:42 GMT
Received: from nexus.verbum.private (rrcs-central-24-123-136-65.biz.rr.com [24.123.136.65])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "nexus.verbum.org", Issuer "monk.verbum.org" (verified OK))
	by monk.verbum.org (Postfix (Debian/GNU)) with ESMTP id 1871932A6D9
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 15:57:01 -0500 (EST)
Subject: Re: odd segfault in checkpolicy
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
In-Reply-To: <1077629291.21221.16.camel@moss-spartans.epoch.ncsc.mil>
References: <1077577191.4374.9.camel@nexus.verbum.private>
	 <1077629291.21221.16.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-E/qEvFMxelp0tb7Tm+7J"
Message-Id: <1077655600.3508.4.camel@nexus.verbum.private>
Mime-Version: 1.0
Date: Tue, 24 Feb 2004 15:46:40 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-E/qEvFMxelp0tb7Tm+7J
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-02-24 at 08:28, Stephen Smalley wrote:

> Yes.  Patch below.  Since checkpolicy is rewriting the buffer in place
> (to perform endian conversion), it needs to map the policy file
> read-write and private, rather than read-only and shared.

Ah, that makes sense.  On little-endian machines, the statement=20
   buf[i] =3D le32_to_cpu(buf[i]);
became
   buf[i] =3D buf[i];
so gcc optimized it to nothing with -O2.  But on big-endian machines, it
should have never worked, and it kind of surprises me no one has
apparently run SELinux on a big-endian machine, at least recently.



--=-E/qEvFMxelp0tb7Tm+7J
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAO7gwOIkJWWp2WGURAiX1AJ920aPfdnoBsoHOK9EOxWQcIvtUbwCggQR/
464GIOOhZ1JptTvagOGRPkE=
=iAGt
-----END PGP SIGNATURE-----

--=-E/qEvFMxelp0tb7Tm+7J--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

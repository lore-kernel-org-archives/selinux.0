Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0FM0jRb005882
	for <selinux@tycho.nsa.gov>; Thu, 15 Jan 2004 17:00:45 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0FLxZxr013900
	for <selinux@tycho.nsa.gov>; Thu, 15 Jan 2004 21:59:35 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
	by jazzswing.ncsc.mil  with ESMTP id i0FLxZYc013891
	for <selinux@tycho.nsa.gov>; Thu, 15 Jan 2004 21:59:35 GMT
Subject: Re: run_init
From: Colin Walters <walters@verbum.org>
To: Carlos =?ISO-8859-1?Q?An=EDsio?= Monteiro <monteiro@ipen.br>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4006E894.3040705@ipen.br>
References: <4006E894.3040705@ipen.br>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KL+0XjJhMZYzhAgYo+j9"
Message-Id: <1074203743.14481.3.camel@nexus.verbum.private>
Mime-Version: 1.0
Date: Thu, 15 Jan 2004 16:55:43 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-KL+0XjJhMZYzhAgYo+j9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-01-15 at 14:23, Carlos An=C3=ADsio Monteiro wrote:

> I am with problems when running the run_init utility.
>=20
> # run_init /etc/init.d/apache start
> Authenticating root.
> Password:
> execvp: File or directory not found.
> #

Do you have expect installed?  There was a bug in the Debian package
where it didn't depend on expect that I only fixed fairly recently.


--=-KL+0XjJhMZYzhAgYo+j9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBABwxfOIkJWWp2WGURAlPGAJ0S46zLO2TnONHM5Hiae2EFLXo6XACfSJzK
hbAt6DwXkHLURfxwYJ0y/6k=
=4GXt
-----END PGP SIGNATURE-----

--=-KL+0XjJhMZYzhAgYo+j9--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

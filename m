Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1FNvnRb007528
	for <selinux@tycho.nsa.gov>; Sun, 15 Feb 2004 18:57:49 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1FNvlc3009677
	for <selinux@tycho.nsa.gov>; Sun, 15 Feb 2004 23:57:47 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
        by jazzband.ncsc.mil  with ESMTP id i1FNvkR0009658 for <selinux@tycho.nsa.gov>; Sun, 15 Feb 2004 23:57:46 GMT
Subject: Re: Policy configuration question
From: Colin Walters <walters@verbum.org>
To: Ignacio Tripodi <ignaciot@unt.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <916FF28D-5FE0-11D8-8943-000393013D1A@unt.edu>
References: <916FF28D-5FE0-11D8-8943-000393013D1A@unt.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-R5+7MWqg8sREmBxZSVg3"
Message-Id: <1076888807.5934.0.camel@nexus.verbum.private>
Mime-Version: 1.0
Date: Sun, 15 Feb 2004 18:46:48 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-R5+7MWqg8sREmBxZSVg3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-02-15 at 12:58, Ignacio Tripodi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> I'm trying to tune up the policy because I'm getting many "avc: denied"=20
> log entries for almost every single command I try to run. The source=20
> context seems to be the same (system_u:system_r:local_login_t),=20

Did you add pam_selinux.so to your login and sshd PAM configuration
files?


--=-R5+7MWqg8sREmBxZSVg3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAMATnOIkJWWp2WGURAg+LAJ9HPlye7mTFAVYSiDwQzPqLY9SpfQCfWGeq
+K/uVYFhXwOsmft4ZQrH8Lk=
=czXw
-----END PGP SIGNATURE-----

--=-R5+7MWqg8sREmBxZSVg3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

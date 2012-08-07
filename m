Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q77D2nwI012681
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2012 09:02:49 -0400
Date: Tue, 7 Aug 2012 15:02:44 +0200
From: Ole Kliemann <ole@plastictree.net>
To: selinux@tycho.nsa.gov
Subject: SELinux performance depending on type count
Message-ID: <20120807130244.GE2085@telvanni>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cHMo6Wbp1wrKhbfi"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--cHMo6Wbp1wrKhbfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I read on some locations (Fedora FAQ...) that there is an overall=20
performance impact of about 7% when running with SELinux.

Does anyone know if this impact is dependent upon the number of=20
types the policy has? I would assume no: A lot of types only take=20
up memory and caching should prevent any impact on the runtime=20
performance.

But if there was a performance problem with a lot of types, at=20
what number n would it start to hit hard? And how does it=20
increase (linear, quadratic...)?

And would it be better performance-wise to run a MCS-policy with=20
say categories c0.cn than to have types c0_t, ... cn_t?

Ole

--cHMo6Wbp1wrKhbfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlAhEfQACgkQS1FjE303ERwPsQCfTACNFuc4FbgJbxIuH9P3mLOh
dugAnieuaKrjGDK2bg5prAF8BdCEByCM
=D1jg
-----END PGP SIGNATURE-----

--cHMo6Wbp1wrKhbfi--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

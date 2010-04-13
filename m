Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3DGgo5a014811
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2010 12:42:50 -0400
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o3DGhfJS011983
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2010 16:43:42 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id o3DGgb4Z094597
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2010 18:42:37 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id o3DGfaPF088438
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2010 18:41:36 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Tue, 13 Apr 2010 18:42:36 +0200
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: MLS telnet question
Message-ID: <20100413164236.GE16595@myhost.felk.cvut.cz>
References: <6235CF4DC66FD5478F0E350E17C202FF251F2BB146@HVXMSP3.us.lmco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WK3l2KTTmXPVedZ6"
In-Reply-To: <6235CF4DC66FD5478F0E350E17C202FF251F2BB146@HVXMSP3.us.lmco.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--WK3l2KTTmXPVedZ6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Benedict, Phillip M wrote:
>    The network does not carry any cipso data for evaluation by my
>    server, so I don=E2=80=99t think I can use netlabel.

You can use the fallback label feature that can assign labels statically
per remote IP.

Michal Svoboda

--WK3l2KTTmXPVedZ6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvEnvwACgkQg/fU9pp1uX5T9wCgmSJ6qnbTKQDxPWaRbT+In1uG
QxwAn3Em+3wuBH8Dnsw/w37pHxbEzi36
=g4mB
-----END PGP SIGNATURE-----

--WK3l2KTTmXPVedZ6--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

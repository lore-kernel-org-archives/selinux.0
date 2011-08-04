Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p74D6rL4017782
	for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2011 09:06:55 -0400
Received: from mail.cendio.se (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p74D6sKU019862
	for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2011 13:06:55 GMT
Message-ID: <4E3A9969.1040301@cendio.se>
Date: Thu, 04 Aug 2011 15:06:49 +0200
From: Aaron Sowry <aaron@cendio.se>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>
CC: selinux@tycho.nsa.gov
Subject: Re: SELinux policy regarding LD_LIBRARY_PATH
References: <4E3A8D16.7060807@cendio.se> <CAPzO=NympY1fiqZufFiG5OaMYTn+3JzNu2c66jr3VXHCuFH-ZQ@mail.gmail.com>
In-Reply-To: <CAPzO=NympY1fiqZufFiG5OaMYTn+3JzNu2c66jr3VXHCuFH-ZQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8528368E11FFE8EB5CCF0297"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8528368E11FFE8EB5CCF0297
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sven, Spencer,

> If the fork results in a type transition (say from sysadm_t to mozilla_=
t),
> then the environment is cleaned up (see glibc's AT_SECURE setting).
>=20
> If you do not want the environment to be cleared, allow noatsecure, lik=
e so:
>=20
> allow sysadm_t mozilla_t:process noatsecure;

Thanks for the pointers. I will take a look and let you know if I have
any further questions.

Regards,
Aaron


--------------enig8528368E11FFE8EB5CCF0297
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOOpltAAoJECw8YUUfeQL9jU8IAPvt+7cYhQQK/quaAYrPC82a
q8c1NLG2gyZO0Z6lZofo69138YnUq81N5JU8a4bTcFR5E4IkznqJgbsbrm19D5lJ
3ac6jFnYJipZXvRedTQcT4DlACcdcNCI68KtrZ+Xa1iNIN4Igs1zgRl6j0O0REnw
wNUOZvpPl3P0pNPHHeQLeBaqwZWW2ZM/PZHDkvJok/5dXuzNeM1vSLJ4gJdGscwJ
Yo8DtS3n4UZ8/6R5wwRRZCKNcPLhy1/5KLzuKv6f4ZcFPGUx0ebi7A5wONpWB1PO
sTqR/cQReBYysVYlx9qtgLt3e01I85xMDFFdaAiYUoj4vhXjgYQCuK33ynAi2nc=
=IppA
-----END PGP SIGNATURE-----

--------------enig8528368E11FFE8EB5CCF0297--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

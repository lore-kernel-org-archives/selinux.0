Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rA648OGt017267
	for <selinux@tycho.nsa.gov>; Tue, 5 Nov 2013 23:08:24 -0500
Received: from [10.0.3.42] (unknown [10.0.3.42])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.mthode.org (Postfix) with ESMTPSA id EFE7A124C8
	for <selinux@tycho.nsa.gov>; Tue,  5 Nov 2013 23:10:32 -0500 (EST)
Message-ID: <5279C0A6.2090703@mthode.org>
Date: Tue, 05 Nov 2013 22:08:06 -0600
From: Matthew Thode <mthode@mthode.org>
Reply-To: mthode@mthode.org
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: kernel function to verify rootcontext
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="mG78e2EVSAvwLtlMPk7Mn0IMTsBQShA44"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mG78e2EVSAvwLtlMPk7Mn0IMTsBQShA44
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Is there a kernel function used to verify that a rootcontext is valid
(exists and/or is formatted correctly).

--=20
-- Matthew Thode


--mG78e2EVSAvwLtlMPk7Mn0IMTsBQShA44
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSecCzAAoJECRx6z5ArFrDQJkQAJwTJ27bsr8tyLmqXlzpMlZ2
N/M1H6Z+v2Fz3AJEPc5nrSqMP3QrgGBGfHAT1LMi17TAluLig4TS7U9wDfwYjhry
VyXS9REqO7rPxZKoyAbKCX7R6b9nV/+iDljp2UJ7LDG+x//ukaIMPEtxFa0pQ6oK
TSp4ZD8Eq9JllJkm3x6ahv1ZK9MshKCD4ZB9BBxotHq7u9yu62dAapXW4H88bOXY
+IEZpyZgtEBt01SnpvZiJh9cnr61U+ud9DjJ+eASw4dl7gv0JcnDvCLLleCGnc4C
SegE+LC1cM9UDhjyj6ufoItYHoVcu0KqZS8DgvMLPwY0GJdAcpAoBrHobaEyDGHk
z4+T/2st9SY5d3xfdgIMQyiFLWyYIax/t+iq3dRe3xG5JgvsNPd+gxzNLgDqx0GX
u2CV1yG38mZKY3gvD3knUyPrc2wzTOE+yyavz4lVAwEcBa9l7g1/uk39bFj6Wl1R
lWIhfgpBZjtpjDMh/AQgt6unzwV1As+YHLD7QOVYYDLnZGI56UBLczARieQZxAQw
rLBYm+nE64CppI4UtdwuMAFQihodhg0ijdLqPVLhgeCB6+zhUAEWnUUilwjxm7q9
3YPSAIJfnwFbYBSeo3uuTwyMjhTJ/96LZB1XkrI+AnkJwITV759PzADIcKbsJEtK
m1MZQXDITyTjlsnJfUFG
=B2oJ
-----END PGP SIGNATURE-----

--mG78e2EVSAvwLtlMPk7Mn0IMTsBQShA44--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

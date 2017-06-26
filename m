Date: Mon, 26 Jun 2017 19:42:07 +0200
From: Luis Ressel <aranea@aixah.de>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: run_init messes up terminal settings
Message-ID: <20170626194207.61b3b1b7@vega.skynet.aixah.de>
In-Reply-To: <1498490551.13301.16.camel@tycho.nsa.gov>
References: <f19a1c21-5c15-cb56-9e55-08df2f66429a@debian.org>
 <1498482496.13301.2.camel@tycho.nsa.gov>
 <d5e647e7-8767-b176-e769-6a50de234af2@debian.org>
 <1498490551.13301.16.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/5dZ.R6/Zcl354_lMBavFp1O"; protocol="application/pgp-signature"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--Sig_/5dZ.R6/Zcl354_lMBavFp1O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Jun 2017 11:22:31 -0400
Stephen Smalley <sds@tycho.nsa.gov> wrote:

> for that matter, I'd like to deprecate/drop run_init entirely, but I
> guess it might be needed if not using DIRECT_INITRC=3Dy and not using
> systemd).

Indeed. run_init is needed for openrc and other init systems. Please
don't deprecate it.

Regards,
Luis Ressel

--Sig_/5dZ.R6/Zcl354_lMBavFp1O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEbPzLt4vriSGj7oj2YKkwapaNrTgFAllRR3AACgkQYKkwapaN
rTj+0hAAomAHbdmlPijzMBp3ytQfrkcQDuUDRc8Ytf5a/6L0OHV/coQ2cHPhQ6yy
Wyx8uNe7kUGf0TOQkMtZ4YgkOFjATvJAIm3bqdggqkiwokaw9gGnoxRDSBj215Ki
egRXblLd9HO2ceod5+gire+vbndEgU0xu32mYRCk0SL0HDMHP3kOuQ+S+Ow9Qarl
MSrpaattD/w+FdKGDRTBHc6TC2fyGFbyarxyYke51MgJnO9V4W9Nqfja14r7L/5e
mbj7zbT91tWg2/DTuEC8bCCiEQuGAOy00OoLh+XEsTuc++QyMkIXy2hklOYcJqlT
UxUyI8N9Uxp8r3Rh+/fGzCFpMZx0K/mLCDk4Dljk+gORv0Vmbpz7lQpn2VOyjjOT
BY3QUH1cNnI4cDCwfNOVeQaWN2PV9D/VjpuxaeOxleEtqQU5+g/rYaQ94PSQfq8S
rhXdP/SrdXnejY91UzYXDKnUMCUBXRxBQ+d6HKsXepNDfQiB3j5TOUtRUdHVA2t9
y5A/pB5IC1iXfamUKytiTZR6E9AO6wfqbNbmivQKpyurAjpqjSctVstJkgbqxxWz
TSQWMWbXHpdUfNn808M+Ul/W9tToYpc/VK9Aik/D6ZroAdMOVUrJTbMpmKuzJ8l4
8sQYyd4AnsUdzI0KNTNpH5NAUeYtwE+fZ6VZ77LRNh97gTzwIiI=
=fcse
-----END PGP SIGNATURE-----

--Sig_/5dZ.R6/Zcl354_lMBavFp1O--

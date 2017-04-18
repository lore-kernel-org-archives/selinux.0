Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3ICApIE005796
 for <selinux@tycho.nsa.gov>; Tue, 18 Apr 2017 08:10:51 -0400
Received: by mail-wr0-f172.google.com with SMTP id l28so100859220wre.0
 for <selinux@tycho.nsa.gov>; Tue, 18 Apr 2017 05:10:20 -0700 (PDT)
Received: from markus (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id o71sm18637166wrb.47.2017.04.18.05.10.18
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 18 Apr 2017 05:10:18 -0700 (PDT)
Date: Tue, 18 Apr 2017 14:10:16 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Cannot write policy to allow { relabelto }
Message-ID: <20170418121016.GE26339@markus>
References: <31ef73c8-592e-8d94-be8d-9630c4c33023@gmail.com>
 <20170418061509.GA26339@markus>
 <3255746b-643f-4b2f-3629-1afab5fe974d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="a1QUDc0q7S3U7/Jg"
In-Reply-To: <3255746b-643f-4b2f-3629-1afab5fe974d@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--a1QUDc0q7S3U7/Jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2017 at 07:03:23AM -0500, Ian Pilcher wrote:
> On 04/18/2017 01:15 AM, Dominick Grift wrote:
> > acme_nss_t needs to be associate with "can_change_object_identity" to
> > be able to change the object identity from system_u to unconfined_u
> >=20
> > typeattribute acme_nss_t can_change_object_identity;
> >=20
> > or the appropriate macro:
> >=20
> > domain_obj_id_change_exemption(acme_nss_t)
>=20
> Excellent, thank you!
>=20
> >=20
> > But there is no need to change the object identity in the first
> > place, system_u will do fine.
>=20
> I'll have to think about this.  I'm actually copying a directory tree
> from one place to another and copying the context from the source to
> destination with getfilecon() and setfilecon().

If you would be using getfilecon() then you would, most likely, not end up =
with unconfined_u as the identity

where are you copying that object to? There should be no content with type =
"cert_t" in a user home directory

>=20
> What APIs should I use if I *only* wanted to copy the type?
>=20
> --=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Ian Pilcher                                         arequipeno@gmail.com
> -------- "I grew up before Mark Zuckerberg invented friendship" --------
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--a1QUDc0q7S3U7/Jg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlj2AiQACgkQJXSOVTf5
R2nNogv/V4AiLtzyo4jBGo47wxMRD6aH6gJ55tzs9N0iInVTN6tVRgXS0sobSU0V
TzJDh5phJ5mAeqpLBIR7idKUCqX2W+OZL4+BqU/+mfEc7MwE/U9WqQtJP33lgb4B
2MZUnzn6TZhYxjk3X+KEy7xYa4OkrTBS+Z6LadjhzHdcwWLkVKYqORzHAXCD0wYg
lZrYDsQ5r3w4T0bzBmG3lbBSQuRjanXwXQHZRViZ3h+x2ORQUbaY92Mqwz//EZZB
x5EZlQYHjQkh/tPkBIMwVjWnZH+FlFgv6sdhT4Oe/8QOxaKIII9y3uwqwtCcaLCw
3Fh1uWf2yQZwLcdH/E2Z7iYXuHmZGSSNi7zEKtG5RjzIESLoEuFMkGzaQDCamomO
1TIVQJO9Q4DrqEq1EZrpcMuc7AaYI5m8OwjacfUtS/zGC9a35+WXbRfzs5dvuj65
41o1kFYKJBwzeVpY6qmvBr4/TrSWBg8uLZjfhKUzmIdnnmsNS69iW25Sgfx0Bx7m
zgYfeeEF
=a3wO
-----END PGP SIGNATURE-----

--a1QUDc0q7S3U7/Jg--

Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p526uLoC025916
	for <selinux@tycho.nsa.gov>; Thu, 2 Jun 2011 02:56:21 -0400
Received: from mail-ew0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p526uKdP013596
	for <selinux@tycho.nsa.gov>; Thu, 2 Jun 2011 06:56:20 GMT
Received: by ewy8 with SMTP id 8so209001ewy.12
        for <selinux@tycho.nsa.gov>; Wed, 01 Jun 2011 23:56:19 -0700 (PDT)
Subject: Re: Is there way to set some specific domain to have all
 permissions?
From: Dominick Grift <domg472@gmail.com>
To: Sam Gandhi <samgandhi9@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Thu, 02 Jun 2011 08:56:06 +0200
In-Reply-To: <BANLkTinrUq+CZSLkghmhu7hbA-tKc5cfzQ@mail.gmail.com>
References: <BANLkTinrUq+CZSLkghmhu7hbA-tKc5cfzQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-iHs+vtWYFjjLFPxYEtUX"
Message-ID: <1306997778.2165.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-iHs+vtWYFjjLFPxYEtUX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Wed, 2011-06-01 at 16:43 -0700, Sam Gandhi wrote:
>=20
> Example I have program myprog and rule to set it domain correctly,
> what I want to do is this domain myprog_t should be able to do
> anything.
>=20
> How would one write such a policy rule?

You could make it unconfined

optional_policy(`
 unconfined_domain(myprog_t)
')

>=20
> -Sam
>=20
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov =
with
> the words "unsubscribe selinux" without quotes as the message.

--=-iHs+vtWYFjjLFPxYEtUX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABEKAAYFAk3nNAYACgkQMlxVo39jgT8WZQCbB+5L6lF6Hp/dvZuV33+PRGFq
oKMAn3wAB4ZSBO2rBiMYhWzB46E+ThcK
=YbKn
-----END PGP SIGNATURE-----

--=-iHs+vtWYFjjLFPxYEtUX--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

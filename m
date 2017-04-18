Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3I6FErE032631
 for <selinux@tycho.nsa.gov>; Tue, 18 Apr 2017 02:15:14 -0400
Received: by mail-wr0-f170.google.com with SMTP id l28so94827196wre.0
 for <selinux@tycho.nsa.gov>; Mon, 17 Apr 2017 23:15:13 -0700 (PDT)
Received: from markus (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id b188sm13445308wmh.6.2017.04.17.23.15.10
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 17 Apr 2017 23:15:11 -0700 (PDT)
Date: Tue, 18 Apr 2017 08:15:09 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Cannot write policy to allow { relabelto }
Message-ID: <20170418061509.GA26339@markus>
References: <31ef73c8-592e-8d94-be8d-9630c4c33023@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
In-Reply-To: <31ef73c8-592e-8d94-be8d-9630c4c33023@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 17, 2017 at 05:02:14PM -0500, Ian Pilcher wrote:
> I am having a weird problem writing a policy for a service.  The service
> needs to set SELinux file contexts, so I've created a rule to allow
> this:
>=20
> allow acme_nss_t cert_t : file { read write create getattr setattr
> relabelfrom relabelto open } ;
>=20
> Despite this, I am still getting this denial:
>=20
> avc:  denied  { relabelto } for  pid=3D3561 comm=3D"update-mod-nss"
> name=3D"cert8.db" dev=3D"dm-0" ino=3D50343845
> scontext=3Dsystem_u:system_r:acme_nss_t:s0
> tcontext=3Dunconfined_u:object_r:cert_t:s0 tclass=3Dfile
>=20
> Any ideas?

acme_nss_t needs to be associate with "can_change_object_identity" to be ab=
le to change the object identity from system_u to unconfined_u

typeattribute acme_nss_t can_change_object_identity;

or the appropriate macro:

domain_obj_id_change_exemption(acme_nss_t)

But there is no need to change the object identity in the first place, syst=
em_u will do fine.

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

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlj1rugACgkQJXSOVTf5
R2kj4wv/c3Ai+kqLEHJ49GbGvVuSPTM3T0mk+YEnWF5aqO6Jx1NaXhRP46sb6YnL
WouADC2I5CEPN/imjM56vlfc4o3JfFoTqR65REc5KzUnNC3eD+puyX9MrI8Ak7Ic
Ew/K/K9/oRlw1Io8NhunK87uh410oWKP3qc/E00D6HdE7pPOKJSbIVSwioUmpxs9
igAi11a2a1EVGTdgW+LxFqGOHTm6cnXZSs0lAFKV5rUGIux0iUJ58o68LDlzYTJ1
M87nrtQjyqaz6QsyCBCKHvrMDbf/mljJoBHCk3QW6RTp0Md+MS5+asAqxwjDF0e7
lFjTnEFezcvrnjASFz/oXPHUJr4t+WGoemU6wWxQ8SCmvivh0ss4x3Fi7ABEj9Mn
tSmT0S4LFKdUFRvxYKRW1QpkpLtuL5X4jI41pQNILKlYJ721bKRAsV50/diGCGIY
WCyUZpGxLh8k1ywTUMXM5H+ntI0WDCCdIPxf62NLd/k4yBEWlgWBzWJfqf+D+z0O
UdzntFLa
=hKaS
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--

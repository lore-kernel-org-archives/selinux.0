Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3ICBhgZ006089
 for <selinux@tycho.nsa.gov>; Tue, 18 Apr 2017 08:11:43 -0400
Received: by mail-wm0-f47.google.com with SMTP id w64so54670239wma.0
 for <selinux@tycho.nsa.gov>; Tue, 18 Apr 2017 05:11:42 -0700 (PDT)
Received: from markus (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id k4sm14706314wmf.12.2017.04.18.05.11.40
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 18 Apr 2017 05:11:40 -0700 (PDT)
Date: Tue, 18 Apr 2017 14:11:38 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Cannot write policy to allow { relabelto }
Message-ID: <20170418121138.GF26339@markus>
References: <31ef73c8-592e-8d94-be8d-9630c4c33023@gmail.com>
 <20170418061509.GA26339@markus>
 <3255746b-643f-4b2f-3629-1afab5fe974d@gmail.com>
 <20170418121016.GE26339@markus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+ts6NCQ4mrNQIV8p"
In-Reply-To: <20170418121016.GE26339@markus>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--+ts6NCQ4mrNQIV8p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2017 at 02:10:16PM +0200, Dominick Grift wrote:
> On Tue, Apr 18, 2017 at 07:03:23AM -0500, Ian Pilcher wrote:
> > On 04/18/2017 01:15 AM, Dominick Grift wrote:
> > > acme_nss_t needs to be associate with "can_change_object_identity" to
> > > be able to change the object identity from system_u to unconfined_u
> > >=20
> > > typeattribute acme_nss_t can_change_object_identity;
> > >=20
> > > or the appropriate macro:
> > >=20
> > > domain_obj_id_change_exemption(acme_nss_t)
> >=20
> > Excellent, thank you!
> >=20
> > >=20
> > > But there is no need to change the object identity in the first
> > > place, system_u will do fine.
> >=20
> > I'll have to think about this.  I'm actually copying a directory tree
> > from one place to another and copying the context from the source to
> > destination with getfilecon() and setfilecon().
>=20
> If you would be using getfilecon() then you would, most likely, not end u=
p with unconfined_u as the identity

if there is a getfilecon_default() then try that instead of getfilecon()

>=20
> where are you copying that object to? There should be no content with typ=
e "cert_t" in a user home directory
>=20
> >=20
> > What APIs should I use if I *only* wanted to copy the type?
> >=20
> > --=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Ian Pilcher                                         arequipeno@gmail.com
> > -------- "I grew up before Mark Zuckerberg invented friendship" --------
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.
>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--+ts6NCQ4mrNQIV8p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlj2AnYACgkQJXSOVTf5
R2l+cAwAgdFsYMmvnqFb27qkdKUOjcTc2a3FLXi5nm8flP3yDP/fRocodGO+hHVB
qfESB/oMg4qGd3jJ2a0Lu2Ya+rOYnkEzg5NVJUn8lxTZXWYCZQKO87fCX2LCPaZY
+RWGuHpf8vL/ZjNGP5syntmtfBkXvDFGM2e98jqf2SY4bWiTXxadhGJNn0R89fGy
TB1XGYLYQXCPnNm1npsJZ41kXW107XVxoa6Bfaz7oJ8C7HzMAj6OXgVcu9A8j2pk
BgMAAOF3IZcs87ePpeLOdxhetUrQMw40KeZGEs5mGCB56N77KDXKinp+VqCDCOcN
7BINLxS5KCgk+wrr4tTiJh6ackAFY3UtNjC6dKIsHWrfr5Z1kMylSLeWXY80mhpw
do92JBmWZ1OtbBGibY8BP8jo5isQCGvNqjdwyj9sjX/2rrPSc54g05V+xIRdslws
FXXSkS7F8f0WNxay861Jxd0FM5FXtxnzJNvlbdrioJtF7fPIK+A84JgjQaTpxrPh
eSMF6LYC
=dVd4
-----END PGP SIGNATURE-----

--+ts6NCQ4mrNQIV8p--

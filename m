Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v47GOF5K023680
 for <selinux@tycho.nsa.gov>; Sun, 7 May 2017 12:24:15 -0400
Received: by mail-wm0-f53.google.com with SMTP id n198so11225476wmg.0
 for <selinux@tycho.nsa.gov>; Sun, 07 May 2017 09:24:12 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id n55sm5919603edd.65.2017.05.07.09.24.10
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 07 May 2017 09:24:10 -0700 (PDT)
Date: Sun, 7 May 2017 18:24:09 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Announcing SPAN: SELinux Policy Analysis Notebook
Message-ID: <20170507162409.GB31890@julius>
References: <EDB27428-18DD-4A40-9A1E-AE2DC9390F99@gmail.com>
 <20170506140358.GA21008@julius> <20170506161956.GA20145@julius>
 <20170506171920.GB20145@julius> <590F3B98.406@quarksecurity.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
In-Reply-To: <590F3B98.406@quarksecurity.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 07, 2017 at 11:22:00AM -0400, Joshua Brindle wrote:
> Dominick Grift wrote:
> <snip>
>=20
> > The idea is nice, unfortunately its inflexible and it has hard-referenc=
es to reference policy all-over. It has potential but it is still rough.
> >=20
>=20
> Of course, it is an analysis of a refpolicy-based policy. If you want to
> analyze a different policy (e.g., Android or home-rolled) you will have to
> change out all of the type sets, etc.
>=20
> You can't make a magic generic analysis script without knowing how key pa=
rts
> of the system work and what types are associated with those components.
>=20
>=20

Can it not be made so that we can override these ps.* file suffixes (.cil) =
and paths without the need to recompile/reinstall ipynb?

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkPSiUACgkQJXSOVTf5
R2l0swv/exKB5LI207RkymupGYslTsPOUg2M6MYQpG7sKMgYxMKoRCT06xXGROt3
peoI2ZBya4nyLLQIqWmz23i7yebkd0ZP2uwt4fnJ4l9LOYwRSXBbwgAih32CTift
lLgtHmNI/RX8O/K9acV07RAk3BPHwdQQSWwGfpOtR6uQhmDk6T3+v0nCIFcnetvp
DTRGh0ib0UHocQcyK4H5bRcAxd0dL5k14OOVIwQ4ICIxPD1UiBmnr/zO4wlpkawB
tbUJgbZZRTK+CLQhwbq0wAR+Bn3ASwFv5RMewf/eVGnsu3arGiRAsNj/zCmYueoK
03G/R7OoKMVT3/FaoOouzEpsVBnFZ3nLdaJO+9szKsDNqa4TJIyUaV9WYKD1dM8D
NW3ZwRcGnQW1yPyI4qNYHTL9fAQPfuwqNRV7pXjlXaOpMp2Cg6iHZsh8VhAGEWWZ
gPCOjgO7jOhVdLUtwACHM1Gxd3GZtjUAynD294k+YsF/RKVvttOw0dRIsOllvJYY
CYp4U8ON
=2/N9
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--

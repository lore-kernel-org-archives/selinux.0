Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v47Js200001327
 for <selinux@tycho.nsa.gov>; Sun, 7 May 2017 15:54:02 -0400
Received: by mail-wm0-f54.google.com with SMTP id m123so44834830wma.0
 for <selinux@tycho.nsa.gov>; Sun, 07 May 2017 12:53:41 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id w44sm1106532edd.53.2017.05.07.12.53.39
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 07 May 2017 12:53:39 -0700 (PDT)
Date: Sun, 7 May 2017 21:53:38 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Announcing SPAN: SELinux Policy Analysis Notebook
Message-ID: <20170507195338.GC31890@julius>
References: <EDB27428-18DD-4A40-9A1E-AE2DC9390F99@gmail.com>
 <20170506140358.GA21008@julius> <20170506161956.GA20145@julius>
 <20170506171920.GB20145@julius> <590F3B98.406@quarksecurity.com>
 <20170507154759.GA31890@julius>
 <590F78BA.5040800@quarksecurity.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
In-Reply-To: <590F78BA.5040800@quarksecurity.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 07, 2017 at 03:42:50PM -0400, Joshua Brindle wrote:
> Dominick Grift wrote:
> > On Sun, May 07, 2017 at 11:22:00AM -0400, Joshua Brindle wrote:the
> > > Dominick Grift wrote:
> > > <snip>
> > >=20
> > > > The idea is nice, unfortunately its inflexible and it has hard-refe=
rences to reference policy all-over. It has potential but it is still rough.
> > > >=20
> > > Of course, it is an analysis of a refpolicy-based policy. If you want=
 to
> > > analyze a different policy (e.g., Android or home-rolled) you will ha=
ve to
> > > change out all of the type sets, etc.
> > >=20
> > > You can't make a magic generic analysis script without knowing how ke=
y parts
> > > of the system work and what types are associated with those component=
s.
> >=20
> > What do you mean? that for example that hard-coded array of "trusted" t=
ypes. Is that not just redundant.
> >=20
>=20
> you mean the example trusted types? I'm not sure I understand your concer=
n.

Yes my mistake, that array is just an example? Anyhow it distracted me. The=
 array isnt so much an issue. The bigger issue is that i cannot easily over=
ride the ps.policy_config_source file suffixes and paths from the notebook =
(am i over looking this?)

But yes, i think these issues will eventually be addressed automatically.

It works pretty well for me now.

>=20
> > Can't i just create that array myself and use it to exlude rules with t=
ypes in that array? That was one does not have to hard-code it.
> >=20
>=20
> It is python, you can do anything you want. The example notebook
> is a starting point, anyone doing an analysis would probably make
> major changes for their analysis, which is the point. You modify
> the notebook to build a usable analysis between the starting
> policy and the policy you are analyzing.
>=20
> I've thought about trying this on an Android policy but haven't
> made it a priority.
>=20

Python is not really my thing so i will have to get used to it and explore =
my options

Its a cool module, has a few rough edges (but thats to be expected from v0.=
0.0)

> > Also with regard to hardcoding the refpolicy file system (ps.load_polic=
y_source). I mean if youre just going to `grep -r` then why do we have to a=
ssume anything there and hard code file suffixed, directory structures etc =
etc?
>=20
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkPez0ACgkQJXSOVTf5
R2mZEQwAsAcfSZ6Ne2fWKUgiZ32wDmxhIDeUYP72oyxK+W3Fwl0Xu+sruZmw0Nmw
TXLGHiTpXC/v4pfnbqtNsxKhNCIkoR6E2JmATibo45FUVCzzMuzigzQ9U0SJe5jN
E9mRJ1y4f0OxEj2XD/S0zlvvD+mqNFevNH+sqNaiV29TKIlnJk3FXMUKrG4sncYf
ddS1QBHAgpC2mBRrAF6dtVBdxrccvX50UsDXTAQM0PaVp0Yb6RceCKMovas81TEK
c5ga9NSx+z25HXFi3ryJlfMiKdfyIrwLl/a6yZpg1+RhkKsh77gIHWgbPlxMvnhd
CdePssYlg2zE2wBVQSrHqtteKjxOT3T06Haluz/uo6WaVBKYiqJAsC1qCjWklf4m
3DIucMGEZ4lYplvhkLYx4gEnHp0C0QqijWv6UXEvgqyekTTrV940eT98ofrA+pf8
qhYZ7gnTqwVt2aS+K1Gt8Y8BU98ftceUuO3v/B+8ofbxqwHk2uDZ4A2PgKXrjC6Q
8h6jr/6K
=j2O5
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--

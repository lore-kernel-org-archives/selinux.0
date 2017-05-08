Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4892qeM006402
 for <selinux@tycho.nsa.gov>; Mon, 8 May 2017 05:02:52 -0400
Received: by mail-wm0-f50.google.com with SMTP id m123so56901440wma.0
 for <selinux@tycho.nsa.gov>; Mon, 08 May 2017 01:55:59 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id c2sm3922219edc.34.2017.05.08.01.55.57
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 08 May 2017 01:55:57 -0700 (PDT)
Date: Mon, 8 May 2017 10:55:55 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Announcing SPAN: SELinux Policy Analysis Notebook
Message-ID: <20170508085555.GA3701@julius>
References: <EDB27428-18DD-4A40-9A1E-AE2DC9390F99@gmail.com>
 <20170506140358.GA21008@julius> <20170506161956.GA20145@julius>
 <20170506171920.GB20145@julius> <590F3B98.406@quarksecurity.com>
 <20170507154759.GA31890@julius>
 <590F78BA.5040800@quarksecurity.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
In-Reply-To: <590F78BA.5040800@quarksecurity.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--ibTvN161/egqYuK8
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
>=20
> > Can't i just create that array myself and use it to exlude rules with t=
ypes in that array? That was one does not have to hard-code it.
> >=20
>=20
> It is python, you can do anything you want. The example notebook is a
> starting point, anyone doing an analysis would probably make major changes
> for their analysis, which is the point. You modify the notebook to build a
> usable analysis between the starting policy and the policy you are
> analyzing.
>=20
> I've thought about trying this on an Android policy but haven't made it a
> priority.
>=20
> > Also with regard to hardcoding the refpolicy file system (ps.load_polic=
y_source). I mean if youre just going to `grep -r` then why do we have to a=
ssume anything there and hard code file suffixed, directory structures etc =
etc?
>=20
>=20

ahh.. sorry. I just noticed that it can be overriden:

p, ps, bp, bps =3D se.load_policies_from_config("policy_paths.config")

so i suppose i should be able to add that file to the notebook dir and spec=
ify my own paths.

although that still doesnt deal with any file suffixes? (.cil)

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkQMpcACgkQJXSOVTf5
R2ktbAwAgZyYANimQyDqmquTL4rJdRnO7+qnB/OOMlDG6pLcLgNucOQ3Zn9e0PjS
mE0o5a1Y2f3vPaJu1g3EK5K7/4KkpMAbFXhVKME5p5Vxq0D6ZtQ+E/zetczKo+CP
VK/VGyEhB51QO4mcnaUqox+ppqfDwzPJAhS1YCRh1RPuisff11scXgAIRGXerH3I
Z4B2PYFf+mILclC/Gj6Yy8+LUmyg6rzijbmMqFpuGWZdXW4w2nz5s5COPpXyKeOS
6PtjowKGn1Yqss5yxssRhc21RdP7NUsB2qPZeUeW7fGoF9Yeo6oS63iaCiIvaL73
/MXmknWsDf/NX5RHBNPL9+KdpeYdDWUdtrRel8i9iqHD27Fg9c9Jmj3k8ui5vXQ4
clDxmVsgVQElmc/855DJ77EaLbzoThE6KAHJEIl4uucfQTH0jhPGV0XQ69GZMcjg
4BXA6RSOb8MrjFCHLw/facLfoBtTqO/ENTJu/I4vbkJvbQNUgWXb7r3aSSTd5/p2
52Oyyz8K
=RnNZ
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--

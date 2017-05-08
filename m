Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v48JnaqF029742
 for <selinux@tycho.nsa.gov>; Mon, 8 May 2017 15:49:36 -0400
Received: by mail-wm0-f50.google.com with SMTP id u65so96937876wmu.1
 for <selinux@tycho.nsa.gov>; Mon, 08 May 2017 12:49:34 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id g24sm4039679edh.20.2017.05.08.12.49.32
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 08 May 2017 12:49:32 -0700 (PDT)
Date: Mon, 8 May 2017 21:49:31 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Announcing SPAN: SELinux Policy Analysis Notebook
Message-ID: <20170508194931.GB7367@julius>
References: <EDB27428-18DD-4A40-9A1E-AE2DC9390F99@gmail.com>
 <20170506140358.GA21008@julius> <20170506161956.GA20145@julius>
 <20170506171920.GB20145@julius> <590F3B98.406@quarksecurity.com>
 <20170507154759.GA31890@julius>
 <590F78BA.5040800@quarksecurity.com> <20170508085555.GA3701@julius>
 <20170508093229.GB3701@julius>
 <B4D29110-19AF-4378-A933-DDA41D5B2A0B@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
In-Reply-To: <B4D29110-19AF-4378-A933-DDA41D5B2A0B@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2017 at 03:36:21PM -0400, Karl MacMillan wrote:
>=20
> > On May 8, 2017, at 5:32 AM, Dominick Grift <dac.override@gmail.com> wro=
te:
> >=20
> > On Mon, May 08, 2017 at 10:55:55AM +0200, Dominick Grift wrote:
> >> On Sun, May 07, 2017 at 03:42:50PM -0400, Joshua Brindle wrote:
> >>> Dominick Grift wrote:
> >>>> On Sun, May 07, 2017 at 11:22:00AM -0400, Joshua Brindle wrote:the
> >>>>> Dominick Grift wrote:
> >>>>> <snip>
> >>>>>=20
> >>>>>> The idea is nice, unfortunately its inflexible and it has hard-ref=
erences to reference policy all-over. It has potential but it is still roug=
h.
> >>>>>>=20
> >>>>> Of course, it is an analysis of a refpolicy-based policy. If you wa=
nt to
> >>>>> analyze a different policy (e.g., Android or home-rolled) you will =
have to
> >>>>> change out all of the type sets, etc.
> >>>>>=20
> >>>>> You can't make a magic generic analysis script without knowing how =
key parts
> >>>>> of the system work and what types are associated with those compone=
nts.
> >>>>=20
> >>>> What do you mean? that for example that hard-coded array of "trusted=
" types. Is that not just redundant.
> >>>>=20
> >>>=20
> >>> you mean the example trusted types? I'm not sure I understand your co=
ncern.
> >>>=20
> >>>> Can't i just create that array myself and use it to exlude rules wit=
h types in that array? That was one does not have to hard-code it.
> >>>>=20
> >>>=20
> >>> It is python, you can do anything you want. The example notebook is a
> >>> starting point, anyone doing an analysis would probably make major ch=
anges
> >>> for their analysis, which is the point. You modify the notebook to bu=
ild a
> >>> usable analysis between the starting policy and the policy you are
> >>> analyzing.
> >>>=20
> >>> I've thought about trying this on an Android policy but haven't made =
it a
> >>> priority.
> >>>=20
> >>>> Also with regard to hardcoding the refpolicy file system (ps.load_po=
licy_source). I mean if youre just going to `grep -r` then why do we have t=
o assume anything there and hard code file suffixed, directory structures e=
tc etc?
> >>>=20
> >>>=20
> >>=20
> >> ahh.. sorry. I just noticed that it can be overriden:
> >>=20
> >> p, ps, bp, bps =3D se.load_policies_from_config("policy_paths.config")
> >>=20
> >> so i suppose i should be able to add that file to the notebook dir and=
 specify my own paths.
> >>=20
> >> although that still doesnt deal with any file suffixes? (.cil)
> >=20
> >=20
> > take for example: https://github.com/QuarkSecurity/SPAN/blob/master/spa=
n/span.py#L331 <https://github.com/QuarkSecurity/SPAN/blob/master/span/span=
=2Epy#L331>
> >=20
> > "domain" is a reference policy type attribute
> >=20
> > One should expand on the "policy_paths.config" concept and allow us, vi=
a configuration files, to override all the variables (attributes, suffixes,=
 paths, identifiers, etc)
> >=20
> > So that the variables can we adjusted without the need to reinstall/rec=
ompile a modified SPAN
> >=20
> > Or just rename to RPAN (reference policy analysis notebook)
>=20
> I think it=E2=80=99s best to think of these as having three basic layers:
>=20
> 1. Basic tools for SELinux policy analysis in Jupyter - these are usable =
for any policy and make no assumptions about the presence of any types, att=
ributes, object classes, or permissions. So things like the rule searching =
and information flow analysis fit into this group. This is a large part of =
the value of SPAN.
>=20
> 2. Higher-level policy analysis methods - these are things like the domai=
n_types method and the domain / type summaries. These make some minimal ass=
umptions about attributes like domain. I=E2=80=99ll just mention that these=
 assumptions are very minimal and have been around for a _long_ time. Domai=
n long pre-dates the reference policy, for example. More than attributes th=
is layer is tied to the Linux object classes and permissions.
>=20
> 3. Example notebooks - the two example notebooks are just that - examples=
=2E They probably provide a useful starting point, but as Josh points out, =
should simply be modified for your specific use case.
>=20
> So the question, then, is should the second layer (the higher-level polic=
y analysis methods) be made configurable. Honestly I think it would be more=
 work than just creating your own versions for a policy that breaks the ass=
umptions. To me, that=E2=80=99s the great advantage of this versus other an=
alysis tools. It=E2=80=99s so simple to create quick tools that meet your n=
eeds. And given that the vast majority of Linux and Android systems meet th=
e assumptions I think that this is a reasonable approach.

I don't think it will work with android. Some of it maybe but not all of it=
=2E for example the source functionality appends "modules" to the search pa=
th. So i suspect that will break that functionality for Android.
Thank you for giving me your opinion. At least now I know where I stand. I =
will not be able to leverage this solution to any significant extend, and t=
he notebook and its depenedencies are pretty expensive to have just for som=
ething that only works to some extent.
Atleast this inspired me to implement policy for pip and notebook in my per=
sonal security policy. So it was not all in vain.

>=20
> Thanks - Karl
>=20
> >=20
> >>=20
> >> --=20
> >> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> >> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B=
6B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7=
B6B02>
> >> Dominick Grift
> >=20
> >=20
> >=20
> > --=20
> > Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> > https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6=
B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B=
6B02>
> > Dominick Grift
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkQy8YACgkQJXSOVTf5
R2mfFAwAgcZpZQe0po9WxDdwq63vVbGIVpmqP2odRPAVIX1CmPevRfyBA/qomIh0
MlfYf9nmI27omcz4Oz65O7Jm0BPiUuJ817LovKHixcW+i4FCT//A87OjrLsKKAsC
AXvl6Cr11EGne7IqbERysm459lnGwI50Wai/LGFx8ZkxLZU+BN44IGgz5rWfqZoy
dFsiKV8C3NodKHQvtMpMCY7rQTmcNUvZxzivoXZVjxZHE0swT+kODgCxoi1YS91X
QR/SG4rSHLSYx9bYyKTc8K5yPGAKNC70qfPLn0I9XadSpFakrgtwGJyvSDahmvqE
tAszxRQkRD8RsnSqYizXh7cxZQesUco/nhr1YRLCr7yyzmTzOzlys6v2BDqoPEwJ
6afgtm9ZSa/rokxmcG+ixDrG+j23uvBXYhie3D7HlbBdNTwVQ/CPctxQEa9UfcWx
/zVwyzz03YtEB66P4vWU9jiQm0BwRW7kmYKdldclwvaSGlybtWHWo/Ci4cTagD0+
EaOIdvMr
=CnZR
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--

Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3CE7ffM013476
 for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2017 10:07:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id d79so6668014wmi.2
 for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2017 07:07:17 -0700 (PDT)
Received: from markus (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id g15sm5846691wmc.14.2017.04.12.07.07.15
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Apr 2017 07:07:15 -0700 (PDT)
Date: Wed, 12 Apr 2017 16:07:13 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH 0/2] libsepol and checkpolicy: Add ability to expand some
 attributes in binary policy
Message-ID: <20170412140713.GC3438@markus>
References: <1491933223-18277-1-git-send-email-jwcart2@tycho.nsa.gov>
 <20170412061122.GA3438@markus>
 <eabeefc3-8281-92f1-ae23-f1abbb6e56c3@tycho.nsa.gov>
 <e63b48e6-4535-972f-62bd-9ea53a9863e7@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
In-Reply-To: <e63b48e6-4535-972f-62bd-9ea53a9863e7@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2017 at 09:35:42AM -0400, James Carter wrote:
> On 04/12/2017 09:26 AM, James Carter wrote:
> > On 04/12/2017 02:11 AM, Dominick Grift wrote:
> > > On Tue, Apr 11, 2017 at 01:53:41PM -0400, James Carter wrote:
> > > > The number of type attributes included in the binary policy is beco=
mming a
> > > > performance issue in some cases.
> > > >=20
> > > > This patch set more aggressives removes attributes and gives the op=
tions to
> > > > expand and remove all auto-generated attributes and all attributes =
with fewer
> > > > than a given amount of attributes assigned.
> > > >=20
> > > > Comparison of the number of attributes remaining in the binary poli=
cy
> > > >      mls   normal  android
> > > > org  310     286     255
> > > > old  268     251     130
> > > > max  154      20      17
> > > > min  226     173     119
> > > > def  224     170      80
> > > > gen  221     170      46
> > > > u5   191     112      59
> > > >=20
> > > > Org - Number of attributes in the CIL policy
> > > > Old - Results without this patch set
> > > > Max - Remove the maximum number of attributes: "-G -X 9999"
> > > > Min - Remove the minimum number of attributes: "-X 0"
> > > > Def - The new defaults for CIL
> > > > Gen - Just removing auto-generated attributes: "-G"
> > > > U5  - Remove attributes with less than five members: "-X 5"
> > >=20
> > > I tried this with my policy:
> > >=20
> > > old defaults
> > >=20
> > > size: 949K
> > > typeattributes: 765
> > > types: 1420
> > > allow rules: 24812
> > >=20
> > > new defaults
> > >=20
> > > size: 876K
> > > typeattributes: 641
> > > types: 1418
> > > allow rules: 20998
> > >=20
> > > I cannot imagine where the difference went.. every aspect improved. I=
 expected
> > > to see some trade-offs instead here.
> > >=20
> >=20
> > I hope that the number of types going from 1420 to 1418 is a typo. I do=
n't see
> > how my patch set would remove any types, but, if it is, then that is a =
problem.
> >=20
>=20
> I should point out that in all of my testing I have not had sediff report
> any differences in allow rules. The only differences that should be seen
> with this patch set is in the attributes that a type is associated with a=
nd
> the attributes that are actually defined in the policy. Any change seen
> outside of the Types and Attribute sections of the sediff output would be=
 a
> bug.
>=20
> Jim

Never mind the two types. those were added with local modules. So thats all=
 good.

>=20
> > With your dssp1-standard policy, I see:
> > Before         : 1178K, 9938 attributes, and 534 types
> > After (default):  574K, 3209 attributes, and 534 types
> > After (-X5)    :  471K, 2206 attributes, and 534 types
> >=20
> > Jim
> >=20
> > > >=20
> > > >=20
> > > > James Carter (2):
> > > >   libsepol/cil: Add ability to expand some attributes in binary pol=
icy
> > > >   secilc: Add options to control the expansion of attributes
> > > >=20
> > > >  libsepol/cil/include/cil/cil.h     |   2 +
> > > >  libsepol/cil/src/cil.c             |  12 ++
> > > >  libsepol/cil/src/cil_binary.c      | 253 +++++++++++++++++++++++++=
++----------
> > > >  libsepol/cil/src/cil_internal.h    |   7 +-
> > > >  libsepol/cil/src/cil_post.c        |  32 +++--
> > > >  libsepol/cil/src/cil_resolve_ast.c |  25 ++--
> > > >  libsepol/src/libsepol.map.in       |   2 +
> > > >  secilc/secil2conf.c                |   2 +
> > > >  secilc/secilc.8.xml                |  10 ++
> > > >  secilc/secilc.c                    |  31 ++++-
> > > >  10 files changed, 275 insertions(+), 101 deletions(-)
> > > >=20
> > > > --
> > > > 2.7.4
> > > >=20
> > > > _______________________________________________
> > > > Selinux mailing list
> > > > Selinux@tycho.nsa.gov
> > > > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > > > To get help, send an email containing "help" to Selinux-request@tyc=
ho.nsa.gov.
> > >=20
> > >=20
> > >=20
> > > _______________________________________________
> > > Selinux mailing list
> > > Selinux@tycho.nsa.gov
> > > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > > To get help, send an email containing "help" to Selinux-request@tycho=
=2Ensa.gov.
> > >=20
> >=20
> >=20
>=20
>=20
> --=20
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency
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

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAljuNI0ACgkQJXSOVTf5
R2la+QwAkUT8VRmY0+7ZrVXOm6cBzqZVl+akO+5gsS7umC/XWpByGPCOlSQWNjsC
80nTDzqBv9SsxsYk1i6+r3PhrCcMGaRLlA5FuyFM+2Plcs29vbzbMCwaMeMQztkQ
tKcmCXnvzi54INz1cQOOkUO/6hdn8ECqU3T2PNC+Yfr6YwjqPUj0cGLZQcM/EpJI
mZFGrckbjOCa0sfNm6CgwHWZkILkHO0q1WnL2SL6TLzFGkBJc/50lw9bRLGIhdG/
ggrwXRdt9h3aEfgE828C9PkCQgA51NEfbrOaaAltiy9visVNRPnZ2kAJ0KusgHbI
ilLfmzadS+S/NaHQWwtiz7WhDimP0RzupB6cBfmDKls8c/AlSUUGeMy+MNGLOGDJ
ovibiSdTKyKhq2spHvsf2khKEMvear+OchUB68tM+YIbKuuO2uR/LgIUek0RkYAF
FRKOgGscqBjc1nVCYPj33bskn3Ijxv+fDkKCrgK8YhlF1yYKkuWE2L5MDmPsEBrH
plwSdrdf
=59tT
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--

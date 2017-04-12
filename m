Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3CKGHEW030729
 for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2017 16:16:17 -0400
Received: by mail-wm0-f44.google.com with SMTP id t189so32607478wmt.1
 for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2017 13:16:14 -0700 (PDT)
Received: from markus (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id g53sm2574734wrg.22.2017.04.12.13.16.11
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Apr 2017 13:16:12 -0700 (PDT)
Date: Wed, 12 Apr 2017 22:16:10 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH 0/2] libsepol and checkpolicy: Add ability to expand some
 attributes in binary policy
Message-ID: <20170412201610.GE3438@markus>
References: <1491933223-18277-1-git-send-email-jwcart2@tycho.nsa.gov>
 <20170412061122.GA3438@markus>
 <eabeefc3-8281-92f1-ae23-f1abbb6e56c3@tycho.nsa.gov>
 <20170412133549.GB3438@markus>
 <c9a50d53-e334-67dd-5d78-9af2b5746fe3@tycho.nsa.gov>
 <20170412191212.GD3438@markus>
 <ab05c219-1a83-df24-e90c-09fc335b0e91@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="y2zxS2PfCDLh6JVG"
In-Reply-To: <ab05c219-1a83-df24-e90c-09fc335b0e91@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--y2zxS2PfCDLh6JVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2017 at 04:07:57PM -0400, James Carter wrote:
> On 04/12/2017 03:12 PM, Dominick Grift wrote:
> > On Wed, Apr 12, 2017 at 02:20:32PM -0400, James Carter wrote:
> > > On 04/12/2017 09:35 AM, Dominick Grift wrote:
> > > > On Wed, Apr 12, 2017 at 09:26:17AM -0400, James Carter wrote:
> > > > > On 04/12/2017 02:11 AM, Dominick Grift wrote:
> > > > > > On Tue, Apr 11, 2017 at 01:53:41PM -0400, James Carter wrote:
> > > > > > > The number of type attributes included in the binary policy i=
s becomming a performance issue in some cases.
> > > > > > >=20
> > > > > > > This patch set more aggressives removes attributes and gives =
the options to expand and remove all auto-generated attributes and all attr=
ibutes with fewer than a given amount of attributes assigned.
> > > > > > >=20
> > > > > > > Comparison of the number of attributes remaining in the binar=
y policy
> > > > > > >      mls   normal  android
> > > > > > > org  310     286     255
> > > > > > > old  268     251     130
> > > > > > > max  154      20      17
> > > > > > > min  226     173     119
> > > > > > > def  224     170      80
> > > > > > > gen  221     170      46
> > > > > > > u5   191     112      59
> > > > > > >=20
> > > > > > > Org - Number of attributes in the CIL policy
> > > > > > > Old - Results without this patch set
> > > > > > > Max - Remove the maximum number of attributes: "-G -X 9999"
> > > > > > > Min - Remove the minimum number of attributes: "-X 0"
> > > > > > > Def - The new defaults for CIL
> > > > > > > Gen - Just removing auto-generated attributes: "-G"
> > > > > > > U5  - Remove attributes with less than five members: "-X 5"
> > > > > >=20
> > > > > > I tried this with my policy:
> > > > > >=20
> > > > > > old defaults
> > > > > >=20
> > > > > > size: 949K
> > > > > > typeattributes: 765
> > > > > > types: 1420
> > > > > > allow rules: 24812
> > > > > >=20
> > > > > > new defaults
> > > > > >=20
> > > > > > size: 876K
> > > > > > typeattributes: 641
> > > > > > types: 1418
> > > > > > allow rules: 20998
> > > > > >=20
> > > > > > I cannot imagine where the difference went.. every aspect impro=
ved. I expected to see some trade-offs instead here.
> > > > > >=20
> > > > >=20
> > > > > I hope that the number of types going from 1420 to 1418 is a typo=
=2E I don't
> > > > > see how my patch set would remove any types, but, if it is, then =
that is a
> > > > > problem.
> > > > >=20
> > > > > With your dssp1-standard policy, I see:
> > > > > Before         : 1178K, 9938 attributes, and 534 types
> > > > > After (default):  574K, 3209 attributes, and 534 types
> > > > > After (-X5)    :  471K, 2206 attributes, and 534 types
> > > > >=20
> > > > > Jim
> > > >=20
> > > > The test that i did was with dssp2-standard (my current work). So i=
f you want you can see for yourself on github.
> > > >=20
> > > > you can then also see that I , with dssp2-standard, still have attr=
ibutes without types associated with it
> > > >=20
> > > > At least:
> > > >=20
> > > > seinfo -a | grep adm_subj_type | grep -v service.service | wc -l
> > > > 90
> > > >=20
> > >=20
> > > Thanks, this was do to an older bug. If an attribute had already been
> > > evaluated in an expression, then cil_typeattribute_used() would not be
> > > called on it.
> > >=20
> > > So now I have for your dssp1-standard policy:
> > > Before         : 1178K, 9938 attributes, and 534 types
> > > After (default):  420K, 1621 attributes, and 534 types
> > > After (-X5)    :  275K,  248 attributes, and 534 types
> >=20
> > The above is where my dssp1 model really shines. These stats are what i=
 envisioned when I started to design it at first, I abandoned it because of=
 this bug but also because of one other fundamental limitation:
> >=20
> > namely that one cannot associate typeattributes in booleanif. Is this r=
eally something that we cannot overcome?
> >=20
>=20
> Sorry, but that would be very difficult to do in the kernel policy.
>=20
> What were you trying to accomplish with them?

It is part of the overall picture. dssp1 leverages typeattributes at the he=
art, and is very scalable due to this. The bigger the policy gets the more =
amazing the efficiency is.

A side affect of this is that everything is essentially type attributed, an=
d so if one cannot associate type attributes in booleanifs then booleanif b=
ecomes essentially useless, since all i really have is typeattributes to wo=
rk with.

I dont care about the kernel policy though. The kernel policy also cannot a=
ssociate type attributes with type attributes and that did not stop us from=
 implementing the feature in CIL

>=20
> Jim
>=20
> > >=20
> > > So now I have for your dssp2-standard policy:
> > > Before         :  918K, 772 attributes, and 1426 types
> > > After (default):  889K, 551 attributes, and 1426 types
> > > After (-X5)    :  901K, 160 attributes, and 1426 types
> > >=20
> > > And:
> > > seinfo -a policy.30 | grep adm_subj_type | grep -v service.service | =
wc -l
> > > 0
> > >=20
> > > Jim
> > >=20
> > > > >=20
> > > > > > >=20
> > > > > > >=20
> > > > > > > James Carter (2):
> > > > > > >   libsepol/cil: Add ability to expand some attributes in bina=
ry policy
> > > > > > >   secilc: Add options to control the expansion of attributes
> > > > > > >=20
> > > > > > >  libsepol/cil/include/cil/cil.h     |   2 +
> > > > > > >  libsepol/cil/src/cil.c             |  12 ++
> > > > > > >  libsepol/cil/src/cil_binary.c      | 253 +++++++++++++++++++=
++++++++----------
> > > > > > >  libsepol/cil/src/cil_internal.h    |   7 +-
> > > > > > >  libsepol/cil/src/cil_post.c        |  32 +++--
> > > > > > >  libsepol/cil/src/cil_resolve_ast.c |  25 ++--
> > > > > > >  libsepol/src/libsepol.map.in       |   2 +
> > > > > > >  secilc/secil2conf.c                |   2 +
> > > > > > >  secilc/secilc.8.xml                |  10 ++
> > > > > > >  secilc/secilc.c                    |  31 ++++-
> > > > > > >  10 files changed, 275 insertions(+), 101 deletions(-)
> > > > > > >=20
> > > > > > > --
> > > > > > > 2.7.4
> > > > > > >=20
> > > > > > > _______________________________________________
> > > > > > > Selinux mailing list
> > > > > > > Selinux@tycho.nsa.gov
> > > > > > > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > > > > > > To get help, send an email containing "help" to Selinux-reque=
st@tycho.nsa.gov.
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > _______________________________________________
> > > > > > Selinux mailing list
> > > > > > Selinux@tycho.nsa.gov
> > > > > > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > > > > > To get help, send an email containing "help" to Selinux-request=
@tycho.nsa.gov.
> > > > > >=20
> > > > >=20
> > > > >=20
> > > > > --
> > > > > James Carter <jwcart2@tycho.nsa.gov>
> > > > > National Security Agency
> > > > > _______________________________________________
> > > > > Selinux mailing list
> > > > > Selinux@tycho.nsa.gov
> > > > > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > > > > To get help, send an email containing "help" to Selinux-request@t=
ycho.nsa.gov.
> > > >=20
> > > >=20
> > > >=20
> > > > _______________________________________________
> > > > Selinux mailing list
> > > > Selinux@tycho.nsa.gov
> > > > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > > > To get help, send an email containing "help" to Selinux-request@tyc=
ho.nsa.gov.
> > > >=20
> > >=20
> > >=20
> > > --
> > > James Carter <jwcart2@tycho.nsa.gov>
> > > National Security Agency
> > > _______________________________________________
> > > Selinux mailing list
> > > Selinux@tycho.nsa.gov
> > > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > > To get help, send an email containing "help" to Selinux-request@tycho=
=2Ensa.gov.
> >=20
> >=20
> >=20
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.
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

--y2zxS2PfCDLh6JVG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAljuiwUACgkQJXSOVTf5
R2mZ+gv+KrLvE12Sf4MWgG5urbiwF1sVOTaHlHGS6pAksq0tXrny+tyZqwRpS3dV
41F7vwJWZU9te0cGsrDE6VIl1WpEVzw5oZW7ZkyrO9/sOqoIlrhb28EgfiyFaFUY
/Wf1vTbfCUKQEK4U9G7zxhYn1KVjtnWRwM+LCwgUa5F9Sh0fCl0Rl+tKtTnAK9Hr
BrNWt8Ia3AU/MJJ6e8E3ffKA347SgWeDd/vXgIPMvHR4Zi9lEvZW/OU7GKT+NTwz
fQm7NoM84XYwG+YJx8yNITyHiKEVKez9O4xnv9+29+tTcIsbUqvQgKhiUoVPPZGq
tQHmHMuA9/Zh18zTqL4ebbPJZqbM/3BloDBwpIGkaTH9JY3TcpoYTDT0fzzbPkgl
7yxBHlV89Nm3f72GEmxD7+GOABdIfevQ9LEgr43nVe6kpQrKIGbEZSDgNTh7rdaU
eKsuuv+5sCBk4cqwzcIYA7WZV+Sq6KnfzMbtGSznXRW++j3UA/sG3Lzs39mWPQzO
/wr5GLrt
=6Fwu
-----END PGP SIGNATURE-----

--y2zxS2PfCDLh6JVG--

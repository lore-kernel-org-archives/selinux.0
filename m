Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3BKTpuo013326
 for <selinux@tycho.nsa.gov>; Tue, 11 Apr 2017 16:29:51 -0400
Received: by mail-wm0-f66.google.com with SMTP id o81so2602342wmb.0
 for <selinux@tycho.nsa.gov>; Tue, 11 Apr 2017 13:29:49 -0700 (PDT)
Received: from markus (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id j185sm3819556wmg.23.2017.04.11.13.29.46
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Apr 2017 13:29:47 -0700 (PDT)
Date: Tue, 11 Apr 2017 22:29:45 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH 0/2] libsepol and checkpolicy: Add ability to expand some
 attributes in binary policy
Message-ID: <20170411202945.GE2232@markus>
References: <1491933223-18277-1-git-send-email-jwcart2@tycho.nsa.gov>
 <27297f4a-b3ab-128c-7132-41c9add686a2@tycho.nsa.gov>
 <CABXk95D0rxRZSsYO0inJLb3ZZeqLkxz9FOTR+iJBV=GQTQdPfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Uwl7UQhJk99r8jnw"
In-Reply-To: <CABXk95D0rxRZSsYO0inJLb3ZZeqLkxz9FOTR+iJBV=GQTQdPfg@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--Uwl7UQhJk99r8jnw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2017 at 08:06:07PM +0000, Jeffrey Vander Stoep wrote:
> Using this patchset with "-G" option - we no longer see preemption on
> slowpath policy lookups.

'Gen - Just removing auto-generated attributes: "-G"'

Forgive me if I am wrong but that then means that CIL will not optimize the=
 policy to deal with the expansion of these -negation rules by using type a=
ttributes instead:

example:

allow { appdomain -isolated_app } rootfs:lnk_file r_file_perms;

Maybe android just has too many of these -negation rules. or maybe CIL can =
not deal with them optimally.

Anyhow: giving us the ability to tune these things seems like a good thing =
because not all policy is created equal (android has relatively few types b=
ut way more -negation and neverallow rules than refpolicy)

ie. fewer types but the the types have way more attributes associated with =
then (without using -G) due to all the -negation going on

However I am a little worried about the "new defaults" (I should test this =
patch with dssp2-standard)

>=20
> On Tue, Apr 11, 2017 at 12:28 PM James Carter <jwcart2@tycho.nsa.gov> wro=
te:
>=20
> On 04/11/2017 01:53 PM, James Carter wrote:
> > The number of type attributes included in the binary policy is becomming
> a performance issue in some cases.
> >
> > This patch set more aggressives removes attributes and gives the options
> to expand and remove all auto-generated attributes and all attributes with
> fewer than a given amount of attributes assigned.
> >
> > Comparison of the number of attributes remaining in the binary policy
> >      mls   normal  android
> > org  310     286     255
> > old  268     251     130
> > max  154      20      17
> > min  226     173     119
> > def  224     170      80
> > gen  221     170      46
> > u5   191     112      59
> >
> > Org - Number of attributes in the CIL policy
> > Old - Results without this patch set
> > Max - Remove the maximum number of attributes: "-G -X 9999"
> > Min - Remove the minimum number of attributes: "-X 0"
> > Def - The new defaults for CIL
> > Gen - Just removing auto-generated attributes: "-G"
> > U5  - Remove attributes with less than five members: "-X 5"
> >
> >
>=20
> In case you are interested in sizes:
>=20
>         mls  normal  android
> old   2.1M   2.0M     113K
> max  68.3M  63.4M    5041K
> min   2.1M   2.0M     122K
> def   2.1M   2.0M     115K
> gen   2.2M   2.0M     136K
> u5    2.2M   2.0M     116K
>=20
> I would not recommend expanding all attributes.
>=20
> Jim
>=20
> > James Carter (2):
> >   libsepol/cil: Add ability to expand some attributes in binary policy
> >   secilc: Add options to control the expansion of attributes
> >
> >  libsepol/cil/include/cil/cil.h     |   2 +
> >  libsepol/cil/src/cil.c             |  12 ++
> >  libsepol/cil/src/cil_binary.c      | 253
> +++++++++++++++++++++++++++----------
> >  libsepol/cil/src/cil_internal.h    |   7 +-
> >  libsepol/cil/src/cil_post.c        |  32 +++--
> >  libsepol/cil/src/cil_resolve_ast.c |  25 ++--
> >  libsepol/src/libsepol.map.in       |   2 +
> >  secilc/secil2conf.c                |   2 +
> >  secilc/secilc.8.xml                |  10 ++
> >  secilc/secilc.c                    |  31 ++++-
> >  10 files changed, 275 insertions(+), 101 deletions(-)
> >
>=20
>=20
> --
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.

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

--Uwl7UQhJk99r8jnw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAljtPLUACgkQJXSOVTf5
R2nhsAwApBofm41rgiSb6jw3qyNjLhUpkGZdIKWa9xZ8whDPSJOSv6OSe8i6zWDP
kNZ9mdUN3RVub6daxJ4yMu3drTdUdNsSPF3FUkgtOQs8XECcxpbHkYHRFRMUGnXF
teP/sDwkCztsT0S9W7O7kJbeO56rcxeNMDfRTlkuh3U8kajyZ5A3sh1gN3WGdjHY
oUFB7J4iwm1yacDAVNtBethHECxBwyt129NFIvi3svzpO8ReeTt3ojep3iLSZaxd
soiFNjHtQbd2XTDhIK8mNXIzQst4vrORpDvtgmr3yab3utdu7uFcVHcTv7WDLlj0
uGilC9TtBUsHsynh/Kwh3EF9+C6P9HtnFn489ltc2sxzVwal5oj+ckC5U+RggCr9
rAJB/LA1zLkC5Yk4vQ475nphvewCPNzkIgoi+H+Tqvnmlt1tL5ZIzaep8Z5DRsg6
xHgAu/02d+DMEvLpbKVGysifFPGp9zof6zIiayj2qRNFS75UMPa3SafIxn5N2Fgt
Xq7VonVq
=FABH
-----END PGP SIGNATURE-----

--Uwl7UQhJk99r8jnw--

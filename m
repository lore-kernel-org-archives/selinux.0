Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3C6BTTQ025780
 for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2017 02:11:29 -0400
Received: by mail-wr0-f194.google.com with SMTP id o21so2590348wrb.3
 for <selinux@tycho.nsa.gov>; Tue, 11 Apr 2017 23:11:26 -0700 (PDT)
Received: from markus (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id g10sm24303482wrb.56.2017.04.11.23.11.24
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Apr 2017 23:11:24 -0700 (PDT)
Date: Wed, 12 Apr 2017 08:11:22 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH 0/2] libsepol and checkpolicy: Add ability to expand some
 attributes in binary policy
Message-ID: <20170412061122.GA3438@markus>
References: <1491933223-18277-1-git-send-email-jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
In-Reply-To: <1491933223-18277-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2017 at 01:53:41PM -0400, James Carter wrote:
> The number of type attributes included in the binary policy is becomming =
a performance issue in some cases.
>=20
> This patch set more aggressives removes attributes and gives the options =
to expand and remove all auto-generated attributes and all attributes with =
fewer than a given amount of attributes assigned.
>=20
> Comparison of the number of attributes remaining in the binary policy
>      mls   normal  android
> org  310     286     255
> old  268     251     130=20
> max  154      20      17
> min  226     173     119
> def  224     170      80
> gen  221     170      46
> u5   191     112      59=20
>=20
> Org - Number of attributes in the CIL policy=20
> Old - Results without this patch set
> Max - Remove the maximum number of attributes: "-G -X 9999"
> Min - Remove the minimum number of attributes: "-X 0"
> Def - The new defaults for CIL
> Gen - Just removing auto-generated attributes: "-G"
> U5  - Remove attributes with less than five members: "-X 5"

I tried this with my policy:

old defaults

size: 949K
typeattributes: 765
types: 1420
allow rules: 24812

new defaults

size: 876K
typeattributes: 641
types: 1418
allow rules: 20998

I cannot imagine where the difference went.. every aspect improved. I expec=
ted to see some trade-offs instead here.

>=20
>=20
> James Carter (2):
>   libsepol/cil: Add ability to expand some attributes in binary policy
>   secilc: Add options to control the expansion of attributes
>=20
>  libsepol/cil/include/cil/cil.h     |   2 +
>  libsepol/cil/src/cil.c             |  12 ++
>  libsepol/cil/src/cil_binary.c      | 253 +++++++++++++++++++++++++++----=
------
>  libsepol/cil/src/cil_internal.h    |   7 +-
>  libsepol/cil/src/cil_post.c        |  32 +++--
>  libsepol/cil/src/cil_resolve_ast.c |  25 ++--
>  libsepol/src/libsepol.map.in       |   2 +
>  secilc/secil2conf.c                |   2 +
>  secilc/secilc.8.xml                |  10 ++
>  secilc/secilc.c                    |  31 ++++-
>  10 files changed, 275 insertions(+), 101 deletions(-)
>=20
> --=20
> 2.7.4
>=20
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

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAljtxQYACgkQJXSOVTf5
R2k9gAv/f8/nQ7O+bIDO6R587SA4zIRe2XplTYcC/zSFGlaJljOIAhUci8UBCz9s
Fk+cDEusvAK7XB25T7lRjavzZQB9ymXjJSPIMcBdwd68UgxU8E2OF/rukVNCuq2Z
rVqAi07Y4kjoLiGgMFwzjULiqeWEPooc2Bw51rP1tg/vmnBHRpbrG8tGfTtNFibi
2iilBWX6A25kNFiBREGPV9q18lwV+97x6/LOKQEdYaiW9C9zlUvOmtNmULOBWPaL
ZuLBt/tarGK1D2uMMBcRmbza0gJ2wN1lLpGgLkAel3N0THgJ5efFrBqrUTBdNIjX
7CjYYXhLE7QISlMCzGDyLCyFnTqydX0aq7ICxu3oYz6wszormGKR0G/QFrLoW/ST
/X1RgroAjk/EXB74dGu3+s3XPp2P1VrUrVrFUZmPW1n62Bb5b3ubtp4PPWOukHdW
uaEEEHWjEEA7cOSBvwC6EX1HyoaP5EYKURTdZ/dR2X+2M2rYZp+TysdVfW2Ez47l
g1z2LnCb
=RrOg
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

Date: Tue, 20 Jun 2017 18:01:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH 2/3] libselinux: fix error when FORTIFY_SOURCE is already
 set
Message-ID: <20170620160128.GA1848@pks-xps>
References: <cover.1497967444.git.ps@pks.im>
 <8e3ba217e8ac1d93dc438e8ce08ae8557eb94e8f.1497967444.git.ps@pks.im>
 <1497971673.12069.7.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
In-Reply-To: <1497971673.12069.7.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2017 at 11:14:33AM -0400, Stephen Smalley wrote:
> On Tue, 2017-06-20 at 16:07 +0200, Patrick Steinhardt wrote:
> > Two makefiles of ours pass `-D_FORTIFY_SOURCE` directly to the
> > preprocessor. While this does not pose any problems when the value
> > has
> > not been previously set, it can break the build if it is part of the
> > standard build flags.
> >=20
> > Fix the issue by undefining the flag with `-Wp,-U_FORTIFY_SOURCE`
> > right
> > before redefining the value. This fixes builds with some hardened
> > compiler chains.
>=20
> I don't quite understand why the caller can't just specify their own
> CFLAGS, in which case we won't use the ones in libselinux/src/Makefile
> (except for the override CFLAGS, which don't include the FORTIFY
> options), ala:
> # We turn up security all the way to 11!
> make CFLAGS=3D"-O -Wp,-D_FORTIFY_SOURCE=3D11"
>=20
> The problem I see with your solution is that it means that if your
> hardened toolchain wants to select a higher _FORTIFY_SOURCE value in
> the future (if such a thing were to exist), we'll just undefine it and
> redefine to the lower value in our Makefiles.  If you can't just set
> CFLAGS in the caller, then perhaps the libselinux Makefile should only
> add FORTIFY options if they aren't already defined.

This does sound more reasonable than my approach, agreed. Will
change as proposed in version 2, thanks.

Patrick

>=20
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > =A0libselinux/src/Makefile=A0=A0=A0| 3 ++-
> > =A0libselinux/utils/Makefile | 3 ++-
> > =A02 files changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index 4306dd0e..010b7ffe 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -59,7 +59,8 @@ ifeq ($(COMPILER), gcc)
> > =A0EXTRA_CFLAGS =3D -fipa-pure-const -Wlogical-op -Wpacked-bitfield-
> > compat -Wsync-nand \
> > =A0	-Wcoverage-mismatch -Wcpp -Wformat-contains-nul
> > -Wnormalized=3Dnfc -Wsuggest-attribute=3Dconst \
> > =A0	-Wsuggest-attribute=3Dnoreturn -Wsuggest-attribute=3Dpure
> > -Wtrampolines -Wjump-misses-init \
> > -	-Wno-suggest-attribute=3Dpure -Wno-suggest-attribute=3Dconst
> > -Wp,-D_FORTIFY_SOURCE=3D2
> > +	-Wno-suggest-attribute=3Dpure -Wno-suggest-attribute=3Dconst \
> > +	-Wp,-U_FORTIFY_SOURCE -Wp,-D_FORTIFY_SOURCE=3D2
> > =A0else
> > =A0EXTRA_CFLAGS =3D -Wunused-command-line-argument
> > =A0endif
> > diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> > index 474ee95b..c94d7cf2 100644
> > --- a/libselinux/utils/Makefile
> > +++ b/libselinux/utils/Makefile
> > @@ -32,7 +32,8 @@ CFLAGS ?=3D -O -Wall -W -Wundef -Wformat-y2k
> > -Wformat-security -Winit-self -Wmissi
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0-Wformat-extra-args -Wformat-zero-leng=
th -Wformat=3D2
> > -Wmultichar \
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0-Woverflow -Wpointer-to-int-cast -Wpra=
gmas \
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0-Wno-missing-field-initializers -Wno-s=
ign-compare \
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0-Wno-format-nonliteral -Wframe-larger-
> > than=3D$(MAX_STACK_SIZE) -Wp,-D_FORTIFY_SOURCE=3D2 \
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0-Wno-format-nonliteral -Wframe-larger-
> > than=3D$(MAX_STACK_SIZE) \
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0-Wp,-U_FORTIFY_SOURCE -Wp,-D_FORTIFY_SOU=
RCE=3D2 \
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0-fstack-protector-all --param=3Dssp-bu=
ffer-size=3D4
> > -fexceptions \
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0-fasynchronous-unwind-tables -fdiagnos=
tics-show-option
> > -funit-at-a-time \
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0-Werror -Wno-aggregate-return -Wno-red=
undant-decls \

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAllJRtYACgkQEXxntp6r
8SwiHg//QKNMQ/cq5xCw3PTqlW4mMd9qTyoTMP5CEOB1xWHCjtSrCb0hlAeUO7WX
ZIBCnZ0BE2pyngQrxxLwDItDMwGddAk/xZ7bq3cAQBCtdfIMUJLKb6gADnMJOfST
PHWAhw7FiVIgLYSlvhZfj/dmlMuVmgXzwNXLABZTzqIfSwnF0S7ObkEOyqGitn+V
7jIKQinx8sW2NCEy03Iup3V2CQF6Il54DsdPL12YLCgYD3e8pIiiOaWJrfmOyUKF
aAvw6I42xsO+lnOhlmEIxtgKrTIyV/JosCRKFBDXl3orR20y7rCs4F9FlwxuavP1
13aq16Zfm0JUqHO6UZQe5VXWbWlFTg7Zp+oAh113jIZHTRip0pzgKHZidIFa2A3r
zhoQoDCPmPiAcOrKmSLbZUnv9INbOApTEzf30tLEEbhfdcE6sVGciRsBQyXC+wu+
uy+iXBQcEPLGz+Wn85D0giAuwT8n1oQQZQ1Rq5XFSnDMwhjBG9Z89Dgu3tTV3dxQ
aQ+xtoR9ADLjYaHcD0vvjDGO9oORrQk3Gub36ARa5AG/3oAlhuqMb+d1iXxYlFMT
+qqjVoGWhO58h7BdfVauuA/I6JgcTfFnlIndyKkpwNMIWe7FY9KwDbl2r8adJ2v0
qB7ivGEVHPMeX5WXcTEaKaQTQWkrZ+GPQcd0Nl5DcJOTGLu3gVc=
=QaJh
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--

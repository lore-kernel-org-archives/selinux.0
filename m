Date: Wed, 31 Jan 2018 12:40:24 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <20180131114024.GA13531@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180124092736.8432-1-marcus.folkesson@gmail.com>
 <20180124092736.8432-2-marcus.folkesson@gmail.com>
 <CAJfZ7=nnXg_gNqzFR1Oh7Mkr2c7Ut2Wm4Ao-ap8s5zTdcyNwHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
In-Reply-To: <CAJfZ7=nnXg_gNqzFR1Oh7Mkr2c7Ut2Wm4Ao-ap8s5zTdcyNwHg@mail.gmail.com>
Subject: Re: [PATCH v4 01/15] libsepol: build: follow standard
 semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2018 at 10:29:07PM +0100, Nicolas Iooss wrote:
> On Wed, Jan 24, 2018 at 10:27 AM, Marcus Folkesson
> <marcus.folkesson@gmail.com> wrote:
> > This patch solves the following issues:
> > - The pkg-config files generates odd paths when using DESTDIR without P=
REFIX
> > - DESTDIR is needed during compile time to compute library and header p=
aths which it should not.
> > - Installing with both DESTDIR and PREFIX set gives us odd paths
> > - Make usage of DESTDIR and PREFIX more standard
> >
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
> >  README                      | 2 +-
> >  libsepol/include/Makefile   | 4 ++--
> >  libsepol/man/Makefile       | 5 +++--
> >  libsepol/src/Makefile       | 7 +++----
> >  libsepol/src/libsepol.pc.in | 2 +-
> >  libsepol/utils/Makefile     | 4 ++--
> >  6 files changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/README b/README
> > index 7fc7b17b..174551a1 100644
> > --- a/README
> > +++ b/README
> > @@ -19,6 +19,6 @@ lacks library functions or other dependencies relied =
upon by your
> >  distribution.  If it breaks, you get to keep both pieces.
> >
> >  To install libsepol on macOS (mainly for policy analysis):
> > -cd libsepol; make DESTDIR=3D/usr/local PREFIX=3D/usr/local install
> > +cd libsepol; make PREFIX=3D/usr/local install
> >
> >  This requires GNU coreutils (brew install coreutils).
> > diff --git a/libsepol/include/Makefile b/libsepol/include/Makefile
> > index 56b7a114..ad5c34a4 100644
> > --- a/libsepol/include/Makefile
> > +++ b/libsepol/include/Makefile
> > @@ -1,6 +1,6 @@
> >  # Installation directories.
> > -PREFIX ?=3D $(DESTDIR)/usr
> > -INCDIR ?=3D $(PREFIX)/include/sepol
> > +PREFIX ?=3D /usr
> > +INCDIR =3D $(DESTDIR)$(PREFIX)/include/sepol
> >  CILDIR ?=3D ../cil
> >
> >  all:
> > diff --git a/libsepol/man/Makefile b/libsepol/man/Makefile
> > index 11924334..4f3d9fa2 100644
> > --- a/libsepol/man/Makefile
> > +++ b/libsepol/man/Makefile
> > @@ -1,6 +1,7 @@
> >  # Installation directories.
> > -MAN8DIR ?=3D $(DESTDIR)/usr/share/man/man8
> > -MAN3DIR ?=3D $(DESTDIR)/usr/share/man/man3
> > +PREFIX ?=3D /usr
> > +MAN8DIR ?=3D $(DESTDIR)$(PREFIX)/share/man/man8
> > +MAN3DIR ?=3D $(DESTDIR)$(PREFIX)/share/man/man3
> >
> >  all:
> >
> > diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> > index 819d261b..d158398f 100644
> > --- a/libsepol/src/Makefile
> > +++ b/libsepol/src/Makefile
> > @@ -1,10 +1,9 @@
> >  # Installation directories.
> > -PREFIX ?=3D $(DESTDIR)/usr
> > +PREFIX ?=3D /usr
> >  INCLUDEDIR ?=3D $(PREFIX)/include
> > -LIBDIR ?=3D $(PREFIX)/lib
> > +LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
> >  SHLIBDIR ?=3D $(DESTDIR)/lib
> >  RANLIB ?=3D ranlib
> > -LIBBASE ?=3D $(shell basename $(LIBDIR))
> >  CILDIR ?=3D ../cil
> >
> >  VERSION =3D $(shell cat ../VERSION)
> > @@ -52,7 +51,7 @@ $(LIBSO): $(LOBJS) $(LIBMAP)
> >         ln -sf $@ $(TARGET)
> >
> >  $(LIBPC): $(LIBPC).in ../VERSION
> > -       sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libd=
ir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
> > +       sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libd=
ir@:$(LIBDIR):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
> >
> >  $(LIBMAP): $(LIBMAP).in
> >  ifneq ($(DISABLE_CIL),y)
> > diff --git a/libsepol/src/libsepol.pc.in b/libsepol/src/libsepol.pc.in
> > index e52f5892..f807fec6 100644
> > --- a/libsepol/src/libsepol.pc.in
> > +++ b/libsepol/src/libsepol.pc.in
> > @@ -1,6 +1,6 @@
> >  prefix=3D@prefix@
> >  exec_prefix=3D${prefix}
> > -libdir=3D${exec_prefix}/@libdir@
> > +libdir=3D@libdir@
> >  includedir=3D@includedir@
> >
> >  Name: libsepol
>=20
> So this patch results in producing libsepol.pc with the value of
> $(DESTDIR) in libdir (because "s:@libdir@:$(LIBDIR):" in the sed
> command, and "LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib" in the Makefile). Is
> this intended? I supposed the point of these patches was to craft
> pkg-config files without references to $(DESTDIR), like the first
> version of this patch did. What did I miss?
>=20

This is a regression between v2 and v3 I think.
Maybe we should remove DESTDIR from all variables and only use it in the
install target.

e.g.
SHLIBDIR ?=3D /lib
=2E..
install:
	install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)


> Best,
> Nicolas
>=20

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlpxqyIACgkQiIBOb1ld
UjJTVw//f/eumHa0Q4tkXjitQT+IWYO9xlhuUyzz0++Se0NQun8tnApxzQJpO0s1
VLTtXbSTBUig7PZvxuOgqDvbEGNooyNJWwkW/a4XG+PEPg0Ou7r6UXFS1XCWxk2z
DSBKiJlnwkKfybvUAqGcCsIPbiapJzuGxOkuaixNNTlKssmQfe5zJa5ud13iY2Wp
ZQufuLSLG2dFPJU/fSFcY+nOd/5CZPZ9+AqV5g/b/0vxFwLStKQgoY3Fw9Ts1eCs
vOIL8aHOr/bKxI6NfPiTcxF5hGQVQ1e7D8fa3VPmZBX9pUbGbJ1bezCVtvOPkLas
7HD61HiI0Adk58xDvnyaP89TDWt59KT4dailQtBz0LR4RD4U2lyNESh8+mgSLnCT
vhH34TaCh30Hh3altnULUiAhQkoScCkghpsFdkoOLwj2Bh9XRQtsluXA50IuFHyu
cGjaLdDxUDwJhjxXP4YxCPh6Tve4rm6rheGuH2kxdUjdW0CACJNl21KgpKF/Mc+3
nIlM0zkIGqXabUi0ZouSoZ8gz+M8T/DnI5a/JHHwBLNBunyGqxslY5zG8sJo5ezp
QCgeNHNS9fwrZp9DxEN8/cHzEGXUgez5HiqjM7H8bAE5qKpUU3pdNOCXdVIOFKhQ
/tJ2e15/va3gJL/S7m07bWttv9gdo/9MWx9XXMxcBEsnPKKUhM0=
=LsZ5
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--

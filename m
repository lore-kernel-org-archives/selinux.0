Date: Fri, 19 Jan 2018 13:07:13 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <20180119120713.GA16873@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180116202327.23253-1-marcus.folkesson@gmail.com>
 <20180116202327.23253-3-marcus.folkesson@gmail.com>
 <CAJfZ7==ONcncWgfN7dOV7tFMqkasrsS9UG_+oRADWeFRdYCwxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
In-Reply-To: <CAJfZ7==ONcncWgfN7dOV7tFMqkasrsS9UG_+oRADWeFRdYCwxQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] libselinux: build: follow standard
 semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nicolas!

On Wed, Jan 17, 2018 at 11:12:56PM +0100, Nicolas Iooss wrote:
> On Tue, Jan 16, 2018 at 9:23 PM, Marcus Folkesson
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
> >  libselinux/include/Makefile     |  4 ++--
> >  libselinux/man/Makefile         |  7 ++++---
> >  libselinux/src/Makefile         | 12 +++++-------
> >  libselinux/src/libselinux.pc.in |  2 +-
> >  libselinux/utils/Makefile       |  6 ++----
> >  5 files changed, 14 insertions(+), 17 deletions(-)
> >
> > diff --git a/libselinux/include/Makefile b/libselinux/include/Makefile
> > index 757a6c9c..3b51f5ce 100644
> > --- a/libselinux/include/Makefile
> > +++ b/libselinux/include/Makefile
> > @@ -1,6 +1,6 @@
> >  # Installation directories.
> > -PREFIX ?=3D $(DESTDIR)/usr
> > -INCDIR ?=3D $(PREFIX)/include/selinux
> > +PREFIX ?=3D /usr
> > +INCDIR =3D $(DESTDIR)$(PREFIX)/include/selinux
> >
> >  all:
> >
> > diff --git a/libselinux/man/Makefile b/libselinux/man/Makefile
> > index 0643e6af..233bfaa9 100644
> > --- a/libselinux/man/Makefile
> > +++ b/libselinux/man/Makefile
> > @@ -1,7 +1,8 @@
> >  # Installation directories.
> > -MAN8DIR ?=3D $(DESTDIR)/usr/share/man/man8
> > -MAN5DIR ?=3D $(DESTDIR)/usr/share/man/man5
> > -MAN3DIR ?=3D $(DESTDIR)/usr/share/man/man3
> > +PREFIX ?=3D /usr
> > +MAN8DIR ?=3D $(DESTDIR)$(PREFIX)/share/man/man8
> > +MAN5DIR ?=3D $(DESTDIR)$(PREFIX)/share/man/man5
> > +MAN3DIR ?=3D $(DESTDIR)$(PREFIX)/share/man/man3
> >
> >  all:
> >
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index 18df75c8..18a58164 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -8,8 +8,8 @@ RUBYPREFIX ?=3D $(notdir $(RUBY))
> >  PKG_CONFIG ?=3D pkg-config
> >
> >  # Installation directories.
> > -PREFIX ?=3D $(DESTDIR)/usr
> > -LIBDIR ?=3D $(PREFIX)/lib
> > +PREFIX ?=3D /usr
> > +LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
> >  SHLIBDIR ?=3D $(DESTDIR)/lib
> >  INCLUDEDIR ?=3D $(PREFIX)/include
> >  PYINC ?=3D $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
> > @@ -19,8 +19,6 @@ PYCEXT ?=3D $(shell $(PYTHON) -c 'import imp;print([s=
 for s,m,t in imp.get_suffixe
> >  RUBYINC ?=3D $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarc=
hhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
> >  RUBYLIBS ?=3D $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir=
"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRU=
BYARG_SHARED"]')
> >  RUBYINSTALL ?=3D $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONFIG["=
vendorarchdir"]')
> > -LIBBASE ?=3D $(shell basename $(LIBDIR))
> > -LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
> >
> >  VERSION =3D $(shell cat ../VERSION)
> >  LIBVERSION =3D 1
> > @@ -148,7 +146,7 @@ $(LIBSO): $(LOBJS)
> >         ln -sf $@ $(TARGET)
> >
> >  $(LIBPC): $(LIBPC).in ../VERSION
> > -       sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libd=
ir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):; s:@PCRE_MODULE@:$(PCRE_MODU=
LE):' < $< > $@
> > +       sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libd=
ir@:$(LIBDIR):; s:@includedir@:$(INCLUDEDIR):; s:@PCRE_MODULE@:$(PCRE_MODUL=
E):' < $< > $@
> >
> >  selinuxswig_python_exception.i: ../include/selinux/selinux.h
> >         bash -e exception.sh > $@ || (rm -f $@ ; false)
> > @@ -156,8 +154,8 @@ selinuxswig_python_exception.i: ../include/selinux/=
selinux.h
> >  $(AUDIT2WHYLOBJ): audit2why.c
> >         $(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED =
-c -o $@ $<
> >
> > -$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(LIBSEPOLA)
> > -       $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(PYL=
IBS)
> > +$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)
> > +       $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(PYL=
IBS) -l:libsepol.a
>=20
> Hello,
> This change makes audit2why.so no longer being rebuilt when libsepol's
> code change. This is an issue when debugging issues in libsepol, which
> is why I added $(LIBSEPOLA) to the dependencies of $(AUDIT2WHYSO) in
> commit dcd135cc06ab ("Re-link programs after libsepol.a is updated"
> [1]).
> By the way, I like the change from using a "hardcoded" path to
> libsepol.a to telling the compiler to look into directories specified
> with option -L in LDFLAGS. This would ease the packaging a little bit,
> as it makes defining LIBSEPOLA no longer necessary (if I understood
> the changes correctly, I have not tested this point). Is there a way
> to ask the compiler for the resolved location of a static library, in
> a way which can be used to compute the value of LIBSEPOLA? ("gcc
> -Wl,--trace ..." displays it but it is not easily usable).

First of all, thank you for your review.

Actually, I do not have any "good" way to address this issue.
Is $(LIBSEPOLA) mostly used during debug/development?

What do you think about this change:

-----------------8<--------------------------------------------

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 18df75c8..b722a584 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -20,7 +20,11 @@ RUBYINC ?=3D $(shell $(RUBY) -e 'puts "-I" + RbConfig::C=
ONFIG["rubyarchhdrdir"] +
 RUBYLIBS ?=3D $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] +=
 " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYAR=
G_SHARED"]')
 RUBYINSTALL ?=3D $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONFIG["vend=
orarchdir"]')
 LIBBASE ?=3D $(shell basename $(LIBDIR))
-LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
+
+# If no specific libsepol.a is specified, fall back on LDFLAGS search path
+ifeq ($(LIBSEPOLA),)
+       LDFLAGS +=3D -l:libsepol.a
+endif

 VERSION =3D $(shell cat ../VERSION)
 LIBVERSION =3D 1

-----------------8<--------------------------------------------

This will search for libsepol.a in paths specified in LDFLAGS, but keep
the possibility to "track" a specific libsepol.a to make dependent subproje=
cts
recompile if libsepol.a is changed.

>=20
> Best regards,
> Nicolas
>=20
> [1] https://github.com/SELinuxProject/selinux/commit/dcd135cc06abd8cd662d=
2d7a896e368f09380dd2
>=20

Best regards
Marcus Folkesson

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlph32sACgkQiIBOb1ld
UjLENg/+KP/XWAE62tqZ3bgCrN7/52GEr+lKIKx71LNSe/LbnstAWjcnjbGtC32k
MF6d100JNFZQD85psxC7qVKJk5szZxnkjypImIJwM2Eta1hGSXyJ/p5MQJ/zZMif
ownWDCNhb0p7e4+nATVCAHwKEqimNrFpCU1+03CTQOciRqWeRk4Ubn3cNzeby0BV
WeiB/aEnhPHTDhEtADQjCeKfgmN2nLCNK0XCC33I6xQiIsDw9MPaabZm1+oeWdfK
YkKp2K+dpAQxRioENbPy4agr+R3VRH4ZZhMtEY0OW1K+QQ/+FZY+u1Yruy6eV+5R
+j/CmJSF2r++EYZDT68AiFgcS5g6ptzaCUcU5PNnYZ1iaoXuKQlEyFh8N93T3Xpq
D0YAfqtHyJs6fBVpg9UdoR89J2mjLQUmpd4tLXO8PytO/g59piVY8J/27jWEJiFx
lD6jPgIjEsVXKxz3lPuBkPju44RFceBqFZLCr8QiGv7/eou/fRAlm51kgLQcel3Z
JNjKhKjAptfP7Sho+ubOY1eq/Z8BDZ7zga6Vwumdt4DfEXZ203/BRaIiTna1Aju1
nQ3KsYsGSzSaAa+v5RY+uilza0deemqkgK3ZjZveEFCRxGtd6KzWQs6yELhOHCpV
hqVI2ETBun4rYDm+KkcMuf8JzLkDvpurvRgvfGBNNks5X2tnu6E=
=IPx5
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--

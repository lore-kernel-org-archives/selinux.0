Date: Tue, 23 Jan 2018 20:34:09 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <20180123193409.GB1203@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180116202327.23253-1-marcus.folkesson@gmail.com>
 <20180116202327.23253-3-marcus.folkesson@gmail.com>
 <CAJfZ7==ONcncWgfN7dOV7tFMqkasrsS9UG_+oRADWeFRdYCwxQ@mail.gmail.com>
 <20180119120713.GA16873@gmail.com>
 <c286ed2a-a228-5a2d-9457-b9033fe05fef@polytechnique.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
In-Reply-To: <c286ed2a-a228-5a2d-9457-b9033fe05fef@polytechnique.org>
Subject: Re: [PATCH v2 02/14] libselinux: build: follow standard
 semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2018 at 09:50:36PM +0100, Nicolas Iooss wrote:
> On 19/01/18 13:07, Marcus Folkesson wrote:
> > Hi Nicolas!
> >=20
> > On Wed, Jan 17, 2018 at 11:12:56PM +0100, Nicolas Iooss wrote:
> >> On Tue, Jan 16, 2018 at 9:23 PM, Marcus Folkesson
> >> <marcus.folkesson@gmail.com> wrote:
> >>> This patch solves the following issues:
> >>> - The pkg-config files generates odd paths when using DESTDIR without=
 PREFIX
> >>> - DESTDIR is needed during compile time to compute library and header=
 paths which it should not.
> >>> - Installing with both DESTDIR and PREFIX set gives us odd paths
> >>> - Make usage of DESTDIR and PREFIX more standard
> >>>
> >>> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> >>> ---
> >>>  libselinux/include/Makefile     |  4 ++--
> >>>  libselinux/man/Makefile         |  7 ++++---
> >>>  libselinux/src/Makefile         | 12 +++++-------
> >>>  libselinux/src/libselinux.pc.in |  2 +-
> >>>  libselinux/utils/Makefile       |  6 ++----
> >>>  5 files changed, 14 insertions(+), 17 deletions(-)
> >>>
> >>> diff --git a/libselinux/include/Makefile b/libselinux/include/Makefile
> >>> index 757a6c9c..3b51f5ce 100644
> >>> --- a/libselinux/include/Makefile
> >>> +++ b/libselinux/include/Makefile
> >>> @@ -1,6 +1,6 @@
> >>>  # Installation directories.
> >>> -PREFIX ?=3D $(DESTDIR)/usr
> >>> -INCDIR ?=3D $(PREFIX)/include/selinux
> >>> +PREFIX ?=3D /usr
> >>> +INCDIR =3D $(DESTDIR)$(PREFIX)/include/selinux
> >>>
> >>>  all:
> >>>
> >>> diff --git a/libselinux/man/Makefile b/libselinux/man/Makefile
> >>> index 0643e6af..233bfaa9 100644
> >>> --- a/libselinux/man/Makefile
> >>> +++ b/libselinux/man/Makefile
> >>> @@ -1,7 +1,8 @@
> >>>  # Installation directories.
> >>> -MAN8DIR ?=3D $(DESTDIR)/usr/share/man/man8
> >>> -MAN5DIR ?=3D $(DESTDIR)/usr/share/man/man5
> >>> -MAN3DIR ?=3D $(DESTDIR)/usr/share/man/man3
> >>> +PREFIX ?=3D /usr
> >>> +MAN8DIR ?=3D $(DESTDIR)$(PREFIX)/share/man/man8
> >>> +MAN5DIR ?=3D $(DESTDIR)$(PREFIX)/share/man/man5
> >>> +MAN3DIR ?=3D $(DESTDIR)$(PREFIX)/share/man/man3
> >>>
> >>>  all:
> >>>
> >>> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> >>> index 18df75c8..18a58164 100644
> >>> --- a/libselinux/src/Makefile
> >>> +++ b/libselinux/src/Makefile
> >>> @@ -8,8 +8,8 @@ RUBYPREFIX ?=3D $(notdir $(RUBY))
> >>>  PKG_CONFIG ?=3D pkg-config
> >>>
> >>>  # Installation directories.
> >>> -PREFIX ?=3D $(DESTDIR)/usr
> >>> -LIBDIR ?=3D $(PREFIX)/lib
> >>> +PREFIX ?=3D /usr
> >>> +LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
> >>>  SHLIBDIR ?=3D $(DESTDIR)/lib
> >>>  INCLUDEDIR ?=3D $(PREFIX)/include
> >>>  PYINC ?=3D $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
> >>> @@ -19,8 +19,6 @@ PYCEXT ?=3D $(shell $(PYTHON) -c 'import imp;print(=
[s for s,m,t in imp.get_suffixe
> >>>  RUBYINC ?=3D $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubya=
rchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
> >>>  RUBYLIBS ?=3D $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libd=
ir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIB=
RUBYARG_SHARED"]')
> >>>  RUBYINSTALL ?=3D $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONFIG=
["vendorarchdir"]')
> >>> -LIBBASE ?=3D $(shell basename $(LIBDIR))
> >>> -LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
> >>>
> >>>  VERSION =3D $(shell cat ../VERSION)
> >>>  LIBVERSION =3D 1
> >>> @@ -148,7 +146,7 @@ $(LIBSO): $(LOBJS)
> >>>         ln -sf $@ $(TARGET)
> >>>
> >>>  $(LIBPC): $(LIBPC).in ../VERSION
> >>> -       sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@li=
bdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):; s:@PCRE_MODULE@:$(PCRE_MO=
DULE):' < $< > $@
> >>> +       sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@li=
bdir@:$(LIBDIR):; s:@includedir@:$(INCLUDEDIR):; s:@PCRE_MODULE@:$(PCRE_MOD=
ULE):' < $< > $@
> >>>
> >>>  selinuxswig_python_exception.i: ../include/selinux/selinux.h
> >>>         bash -e exception.sh > $@ || (rm -f $@ ; false)
> >>> @@ -156,8 +154,8 @@ selinuxswig_python_exception.i: ../include/selinu=
x/selinux.h
> >>>  $(AUDIT2WHYLOBJ): audit2why.c
> >>>         $(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARE=
D -c -o $@ $<
> >>>
> >>> -$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(LIBSEPOLA)
> >>> -       $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(P=
YLIBS)
> >>> +$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)
> >>> +       $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(P=
YLIBS) -l:libsepol.a
> >>
> >> Hello,
> >> This change makes audit2why.so no longer being rebuilt when libsepol's
> >> code change. This is an issue when debugging issues in libsepol, which
> >> is why I added $(LIBSEPOLA) to the dependencies of $(AUDIT2WHYSO) in
> >> commit dcd135cc06ab ("Re-link programs after libsepol.a is updated"
> >> [1]).
> >> By the way, I like the change from using a "hardcoded" path to
> >> libsepol.a to telling the compiler to look into directories specified
> >> with option -L in LDFLAGS. This would ease the packaging a little bit,
> >> as it makes defining LIBSEPOLA no longer necessary (if I understood
> >> the changes correctly, I have not tested this point). Is there a way
> >> to ask the compiler for the resolved location of a static library, in
> >> a way which can be used to compute the value of LIBSEPOLA? ("gcc
> >> -Wl,--trace ..." displays it but it is not easily usable).
> >=20
> > First of all, thank you for your review.
> >=20
> > Actually, I do not have any "good" way to address this issue.
> > Is $(LIBSEPOLA) mostly used during debug/development?
> >=20
> > What do you think about this change:
> >=20
> > -----------------8<--------------------------------------------
> >=20
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index 18df75c8..b722a584 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -20,7 +20,11 @@ RUBYINC ?=3D $(shell $(RUBY) -e 'puts "-I" + RbConfi=
g::CONFIG["rubyarchhdrdir"] +
> >  RUBYLIBS ?=3D $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir=
"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRU=
BYARG_SHARED"]')
> >  RUBYINSTALL ?=3D $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONFIG["=
vendorarchdir"]')
> >  LIBBASE ?=3D $(shell basename $(LIBDIR))
> > -LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
> > +
> > +# If no specific libsepol.a is specified, fall back on LDFLAGS search =
path
> > +ifeq ($(LIBSEPOLA),)
> > +       LDFLAGS +=3D -l:libsepol.a
> > +endif
> >=20
> >  VERSION =3D $(shell cat ../VERSION)
> >  LIBVERSION =3D 1
> >=20
> > -----------------8<--------------------------------------------
> >=20
> > This will search for libsepol.a in paths specified in LDFLAGS, but keep
> > the possibility to "track" a specific libsepol.a to make dependent subp=
rojects
> > recompile if libsepol.a is changed.
>=20
> Adding "-l:libsepol.a" to LDFLAGS breaks compiling with "make
> 'LDFLAGS=3D-Wl,--as-needed,--no-undefined'" (which helps detecting shared
> libraries linking issues), because of two issues:
>=20
> * "LDFLAGS +=3D ..." does nothing when LDFLAGS is defined on the command
> line. This is why "override LDFLAGS +=3D ..." is used in other places in
> the Makefile.
> * After adding "override", -l:libsepol.a appears before $(AUDIT2WHYLOBJ)
> in the linker invocation, so its objects get ignored because of
> --as-needed (which is why LDLIBS exists independently of LDFLAGS).

Good points.

>=20
> This issue can be easily reproduced by running in libselinux/src the
> following command:
>=20
> make clean && make 'LDFLAGS=3D-Wl,--as-needed,--no-undefined' pywrap
>=20
> In order to address this issue, I suggest defining a new variable,
> LDLIBS_LIBSEPOLA, defined by something like:
>=20
> # If no specific libsepol.a is specified, fall back on LDFLAGS search path
> # Otherwise, as $(LIBSEPOLA) already appears in the dependencies, there
> is no need to define a value for LDLIBS_LIBSEPOLA
> ifeq ($(LIBSEPOLA),)
> 	LDLIBS_LIBSEPOLA :=3D -l:libsepol.a
> endif
>=20
> #....
>=20
> $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(LIBSEPOLA)
> 	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux
> $(LDLIBS_LIBSEPOLA) $(PYLIBS)
>=20
> What do you think of this?

That is much better. I will take this with me to v4.

Thank you!

>=20
> Best regards,
> Nicolas
>=20

Best regards
Marcus Folkesson

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlpnjiUACgkQiIBOb1ld
UjLT6g/+Kbtr8QUxcP5Rl5pVjEAGvPHiCDjEfZ2kOhtqjo/L8v+gyzMBPbdTEfwD
ByjtHVdDldc1M52PIi8z2JaPc3mRAqTP4Z3o5XM7iFX5ACl8kFAkvuqwQ39psjAn
8GgqRyuOGtjmaVNGhc78f+QeIBJQOKak6Hl+l2xCN8/geZzAs7QqIsjmw0KI8H6I
n0XYmyh70Mc4SRFoFYSmtIeZPq93flCt2yx1OqUi8mkNjRJioqHl0ofd5mj3kL28
3dGQpMAcUNE9yIEP45sR9f4Ne4Ch7cpXXQ2EeKqihZVcHAC/4H/eqM0RjbjrVlox
UHfqODzDfGlISB4BfNbSna53BKGRj/aI8g8PtJzrCz8xCmORwFoFnT6EDktn+3nP
v7xg0t6byxWDkSttFhtzYns+hcvTSU6a0CtCiqqsL7dqpuh2Jo4y4s5a2IC6maIx
mAFn1ZF0KjZwMrTzBLx7nvAgSZTKWuC9t9ttMlKFE8iv5b4m2iXSgTbfjvj090Fa
DMR3uFe2l+AU0YEOxBRhFYUTweYBEgMSWCw2mmI9xfvjn0o8gHJsHebT12t+QF+k
maXwfjAeWSqf/ofYmVJ3ayoo42cbprlL1fLBEG4gCO9tQ3xrg9Abv0fdveCvX2aB
OVJ2Y4BH+YkatkXfjQH/rgIhurETe35o767t669V1XCVvp2g7Sw=
=SLBJ
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--

Date: Wed, 24 Jan 2018 09:23:14 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: Petr Lautrbach <plautrba@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux <selinux@tycho.nsa.gov>
Message-ID: <20180124082314.GA1442@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180116202327.23253-1-marcus.folkesson@gmail.com>
 <20180116202327.23253-3-marcus.folkesson@gmail.com>
 <CAJfZ7==ONcncWgfN7dOV7tFMqkasrsS9UG_+oRADWeFRdYCwxQ@mail.gmail.com>
 <20180119120713.GA16873@gmail.com>
 <c286ed2a-a228-5a2d-9457-b9033fe05fef@polytechnique.org>
 <20180123193409.GB1203@gmail.com>
 <20180123195543.GA23980@pl-rpi.tpb.lab.eng.brq.redhat.com>
 <CAJfZ7=mrA9eGV9HBdivvtA5F0Kt2zL6-GumHAastMgJxizokcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
In-Reply-To: <CAJfZ7=mrA9eGV9HBdivvtA5F0Kt2zL6-GumHAastMgJxizokcA@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] libselinux: build: follow standard
 semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2018 at 12:00:28AM +0100, Nicolas Iooss wrote:
> On Tue, Jan 23, 2018 at 8:55 PM, Petr Lautrbach <plautrba@redhat.com> wro=
te:
> > On Tue, Jan 23, 2018 at 08:34:09PM +0100, Marcus Folkesson wrote:
> >> On Mon, Jan 22, 2018 at 09:50:36PM +0100, Nicolas Iooss wrote:
> >> > On 19/01/18 13:07, Marcus Folkesson wrote:
> >> > > Hi Nicolas!
> >> > >
> >> > > On Wed, Jan 17, 2018 at 11:12:56PM +0100, Nicolas Iooss wrote:
> >> > >> On Tue, Jan 16, 2018 at 9:23 PM, Marcus Folkesson
> >> > >> <marcus.folkesson@gmail.com> wrote:
> >> > >>> This patch solves the following issues:
> >> > >>> - The pkg-config files generates odd paths when using DESTDIR wi=
thout PREFIX
> >> > >>> - DESTDIR is needed during compile time to compute library and h=
eader paths which it should not.
> >> > >>> - Installing with both DESTDIR and PREFIX set gives us odd paths
> >> > >>> - Make usage of DESTDIR and PREFIX more standard
> >> > >>>
> >> > >>> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> >> > >>> ---
> >> > >>>  libselinux/include/Makefile     |  4 ++--
> >> > >>>  libselinux/man/Makefile         |  7 ++++---
> >> > >>>  libselinux/src/Makefile         | 12 +++++-------
> >> > >>>  libselinux/src/libselinux.pc.in |  2 +-
> >> > >>>  libselinux/utils/Makefile       |  6 ++----
> >> > >>>  5 files changed, 14 insertions(+), 17 deletions(-)
> >> > >>>
> >> > >>> diff --git a/libselinux/include/Makefile b/libselinux/include/Ma=
kefile
> >> > >>> index 757a6c9c..3b51f5ce 100644
> >> > >>> --- a/libselinux/include/Makefile
> >> > >>> +++ b/libselinux/include/Makefile
> >> > >>> @@ -1,6 +1,6 @@
> >> > >>>  # Installation directories.
> >> > >>> -PREFIX ?=3D $(DESTDIR)/usr
> >> > >>> -INCDIR ?=3D $(PREFIX)/include/selinux
> >> > >>> +PREFIX ?=3D /usr
> >> > >>> +INCDIR =3D $(DESTDIR)$(PREFIX)/include/selinux
> >> > >>>
> >> > >>>  all:
> >> > >>>
> >> > >>> diff --git a/libselinux/man/Makefile b/libselinux/man/Makefile
> >> > >>> index 0643e6af..233bfaa9 100644
> >> > >>> --- a/libselinux/man/Makefile
> >> > >>> +++ b/libselinux/man/Makefile
> >> > >>> @@ -1,7 +1,8 @@
> >> > >>>  # Installation directories.
> >> > >>> -MAN8DIR ?=3D $(DESTDIR)/usr/share/man/man8
> >> > >>> -MAN5DIR ?=3D $(DESTDIR)/usr/share/man/man5
> >> > >>> -MAN3DIR ?=3D $(DESTDIR)/usr/share/man/man3
> >> > >>> +PREFIX ?=3D /usr
> >> > >>> +MAN8DIR ?=3D $(DESTDIR)$(PREFIX)/share/man/man8
> >> > >>> +MAN5DIR ?=3D $(DESTDIR)$(PREFIX)/share/man/man5
> >> > >>> +MAN3DIR ?=3D $(DESTDIR)$(PREFIX)/share/man/man3
> >> > >>>
> >> > >>>  all:
> >> > >>>
> >> > >>> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> >> > >>> index 18df75c8..18a58164 100644
> >> > >>> --- a/libselinux/src/Makefile
> >> > >>> +++ b/libselinux/src/Makefile
> >> > >>> @@ -8,8 +8,8 @@ RUBYPREFIX ?=3D $(notdir $(RUBY))
> >> > >>>  PKG_CONFIG ?=3D pkg-config
> >> > >>>
> >> > >>>  # Installation directories.
> >> > >>> -PREFIX ?=3D $(DESTDIR)/usr
> >> > >>> -LIBDIR ?=3D $(PREFIX)/lib
> >> > >>> +PREFIX ?=3D /usr
> >> > >>> +LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
> >> > >>>  SHLIBDIR ?=3D $(DESTDIR)/lib
> >> > >>>  INCLUDEDIR ?=3D $(PREFIX)/include
> >> > >>>  PYINC ?=3D $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
> >> > >>> @@ -19,8 +19,6 @@ PYCEXT ?=3D $(shell $(PYTHON) -c 'import imp;p=
rint([s for s,m,t in imp.get_suffixe
> >> > >>>  RUBYINC ?=3D $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["=
rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
> >> > >>>  RUBYLIBS ?=3D $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG[=
"libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG=
["LIBRUBYARG_SHARED"]')
> >> > >>>  RUBYINSTALL ?=3D $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::C=
ONFIG["vendorarchdir"]')
> >> > >>> -LIBBASE ?=3D $(shell basename $(LIBDIR))
> >> > >>> -LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
> >> > >>>
> >> > >>>  VERSION =3D $(shell cat ../VERSION)
> >> > >>>  LIBVERSION =3D 1
> >> > >>> @@ -148,7 +146,7 @@ $(LIBSO): $(LOBJS)
> >> > >>>         ln -sf $@ $(TARGET)
> >> > >>>
> >> > >>>  $(LIBPC): $(LIBPC).in ../VERSION
> >> > >>> -       sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; =
s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):; s:@PCRE_MODULE@:$(PC=
RE_MODULE):' < $< > $@
> >> > >>> +       sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; =
s:@libdir@:$(LIBDIR):; s:@includedir@:$(INCLUDEDIR):; s:@PCRE_MODULE@:$(PCR=
E_MODULE):' < $< > $@
> >> > >>>
> >> > >>>  selinuxswig_python_exception.i: ../include/selinux/selinux.h
> >> > >>>         bash -e exception.sh > $@ || (rm -f $@ ; false)
> >> > >>> @@ -156,8 +154,8 @@ selinuxswig_python_exception.i: ../include/s=
elinux/selinux.h
> >> > >>>  $(AUDIT2WHYLOBJ): audit2why.c
> >> > >>>         $(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -D=
SHARED -c -o $@ $<
> >> > >>>
> >> > >>> -$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(LIBSEPOLA)
> >> > >>> -       $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinu=
x $(PYLIBS)
> >> > >>> +$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)
> >> > >>> +       $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinu=
x $(PYLIBS) -l:libsepol.a
> >> > >>
> >> > >> Hello,
> >> > >> This change makes audit2why.so no longer being rebuilt when libse=
pol's
> >> > >> code change. This is an issue when debugging issues in libsepol, =
which
> >> > >> is why I added $(LIBSEPOLA) to the dependencies of $(AUDIT2WHYSO)=
 in
> >> > >> commit dcd135cc06ab ("Re-link programs after libsepol.a is update=
d"
> >> > >> [1]).
> >> > >> By the way, I like the change from using a "hardcoded" path to
> >> > >> libsepol.a to telling the compiler to look into directories speci=
fied
> >> > >> with option -L in LDFLAGS. This would ease the packaging a little=
 bit,
> >> > >> as it makes defining LIBSEPOLA no longer necessary (if I understo=
od
> >> > >> the changes correctly, I have not tested this point). Is there a =
way
> >> > >> to ask the compiler for the resolved location of a static library=
, in
> >> > >> a way which can be used to compute the value of LIBSEPOLA? ("gcc
> >> > >> -Wl,--trace ..." displays it but it is not easily usable).
> >> > >
> >> > > First of all, thank you for your review.
> >> > >
> >> > > Actually, I do not have any "good" way to address this issue.
> >> > > Is $(LIBSEPOLA) mostly used during debug/development?
> >> > >
> >> > > What do you think about this change:
> >> > >
> >> > > -----------------8<--------------------------------------------
> >> > >
> >> > > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> >> > > index 18df75c8..b722a584 100644
> >> > > --- a/libselinux/src/Makefile
> >> > > +++ b/libselinux/src/Makefile
> >> > > @@ -20,7 +20,11 @@ RUBYINC ?=3D $(shell $(RUBY) -e 'puts "-I" + Rb=
Config::CONFIG["rubyarchhdrdir"] +
> >> > >  RUBYLIBS ?=3D $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["l=
ibdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["=
LIBRUBYARG_SHARED"]')
> >> > >  RUBYINSTALL ?=3D $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CON=
FIG["vendorarchdir"]')
> >> > >  LIBBASE ?=3D $(shell basename $(LIBDIR))
> >> > > -LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
> >> > > +
> >> > > +# If no specific libsepol.a is specified, fall back on LDFLAGS se=
arch path
> >> > > +ifeq ($(LIBSEPOLA),)
> >> > > +       LDFLAGS +=3D -l:libsepol.a
> >> > > +endif
> >> > >
> >> > >  VERSION =3D $(shell cat ../VERSION)
> >> > >  LIBVERSION =3D 1
> >> > >
> >> > > -----------------8<--------------------------------------------
> >> > >
> >> > > This will search for libsepol.a in paths specified in LDFLAGS, but=
 keep
> >> > > the possibility to "track" a specific libsepol.a to make dependent=
 subprojects
> >> > > recompile if libsepol.a is changed.
> >> >
> >> > Adding "-l:libsepol.a" to LDFLAGS breaks compiling with "make
> >> > 'LDFLAGS=3D-Wl,--as-needed,--no-undefined'" (which helps detecting s=
hared
> >> > libraries linking issues), because of two issues:
> >> >
> >> > * "LDFLAGS +=3D ..." does nothing when LDFLAGS is defined on the com=
mand
> >> > line. This is why "override LDFLAGS +=3D ..." is used in other place=
s in
> >> > the Makefile.
> >> > * After adding "override", -l:libsepol.a appears before $(AUDIT2WHYL=
OBJ)
> >> > in the linker invocation, so its objects get ignored because of
> >> > --as-needed (which is why LDLIBS exists independently of LDFLAGS).
> >>
> >> Good points.
> >>
> >> >
> >> > This issue can be easily reproduced by running in libselinux/src the
> >> > following command:
> >> >
> >> > make clean && make 'LDFLAGS=3D-Wl,--as-needed,--no-undefined' pywrap
> >> >
> >> > In order to address this issue, I suggest defining a new variable,
> >> > LDLIBS_LIBSEPOLA, defined by something like:
> >> >
> >> > # If no specific libsepol.a is specified, fall back on LDFLAGS searc=
h path
> >> > # Otherwise, as $(LIBSEPOLA) already appears in the dependencies, th=
ere
> >> > is no need to define a value for LDLIBS_LIBSEPOLA
> >> > ifeq ($(LIBSEPOLA),)
> >> >     LDLIBS_LIBSEPOLA :=3D -l:libsepol.a
> >> > endif
> >> >
> >> > #....
> >> >
> >> > $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(LIBSEPOLA)
> >> >     $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux
> >> > $(LDLIBS_LIBSEPOLA) $(PYLIBS)
> >> >
> >> > What do you think of this?
> >>
> >> That is much better. I will take this with me to v4.
> >
> > LIBDIR seems not  propagated to LDFLAGS. It means that when I
> > try to build everything using
> >
> > DESTDIR=3D/home/vagrant/build SBINDIR=3D/home/vagrant/build/usr/sbin LI=
BDIR=3D/home/vagrant/build/usr/lib64
> >
> > and without libsepol.a in standard library paths, it doesn't find libse=
pol.a
> >
> >
> > e.g. checkpolicy fails:
> >
> > cc -O2 -Werror -Wall -Wextra -Wmissing-format-attribute -Wmissing-noret=
urn -Wpointer-arith -Wshadow -Wstrict-prototypes -Wundef -Wunused -Wwrite-s=
trings -I/home/vagrant/build/usr/include -I. -o policy_define.o -c policy_d=
efine.c
> > make[1]: *** No rule to make target '/usr/lib64/libsepol.a', needed by =
'checkpolicy'.  Stop.
> >
> > Or if I had /usr/lib64/libsepol.a, checkpolicy and probably audit2why.so
> > would be linked to the system version not the version installed into
> > $DESTDIR.
> >
> > Would it make sense to propagate LIBDIR to LDFLAGS?
> >
> > Petr
>=20
> Indeed the main Makefile already performs "LDFLAGS +=3D
> -L$(DESTDIR)$(PREFIX)/lib" when DESTDIR is defined, buy this does not
> take into account cases when LIBDIR is overridden too. This can be
> updated to something like:
>=20
> LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
> LDFLAGS +=3D -L$(LIBDIR)
>=20
> And while at it, adding a default LIBSEPOLA definition there should
> not hurt too (and it is useful in the dependencies of some Makefile
> targets like python...audit2why.so). The result would be (in the main
> Makefile):
>=20
> ifneq ($(DESTDIR),)
> LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
> LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
> CFLAGS +=3D -I$(DESTDIR)$(PREFIX)/include
> LDFLAGS +=3D -L$(LIBDIR)
> export LIBSEPOLA
> export CFLAGS
> export LDFLAGS
> endif
>=20
> Would this fix your issue?

This would probably fix the issue, and I don't think it is a bad idea eithe=
r.

I will take this with me to v4 as well.

Thanks!

>=20
> Nicolas
>=20

Best regards
Marcus Folkesson

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlpoQmsACgkQiIBOb1ld
UjJZ7hAAk8TZ97mGArtIYTbopw2gUoquQqlGsqreX+9VTiXHFuf1kb9zgatR7Myp
+uEGnFBUq0XXzyRRg8rJRgAfZQYzA/c3BAf1TaXJSF14F0V91odh9YrTNpHPudVG
iEdQrz/E29ZcF9bAo33hHMKNF06QbWfSOcT0CrhlZTFZLYKujzTWgVCKYeJ/i/Jo
pBwgVAX2OnFqgJgMsSycZCWR5aGPkwN42G0N0O1lEmmdxTB5Cwf35OJmTzd5a8Q9
u3qBxhLeXT5IESgttgtPODsJymJ4UM8r4UriS5F3kkKBcQ4PVtszrvouk3T0ATyW
qX8uPK0CoBNHZN0yQCKJEn1qaVflR/lNJ1t12nHV3zy5FdI9fpKpEcakZK1u5l1W
7fmPXFJrO/FesXzep1O1msRR9O0TshkHrd71teaNxsEH8ybAJrK5I+hFNO4R7kJL
paPzZURpllToFVOJwp9kLhxl19Gexe4RwV9wPz7ebmbudF5BiqYCKjyL8UYpgBb0
d54by0DfVlSK44iYbk0gRev0md4U+2CvGRmmhTWqC9rcIcXo+oQwOmy6c8IRVZsi
wSYA6A5uMYEvfxUNnZilaGkzbwtKppp0Y4UzoqmnsGRvb/Uc6sWN2zOOP+qdSM0F
q5kH3aHPYuu9rExs/CUkhS/6KdTDnWzQBky/tY5J3Yf7j3sXowY=
=tHST
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--

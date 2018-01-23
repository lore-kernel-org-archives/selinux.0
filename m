Date: Tue, 23 Jan 2018 20:55:43 +0100
From: Petr Lautrbach <plautrba@redhat.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Nicolas Iooss <nicolas.iooss@m4x.org>, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux <selinux@tycho.nsa.gov>
Message-ID: <20180123195543.GA23980@pl-rpi.tpb.lab.eng.brq.redhat.com>
References: <marcus.folkesson@gmail.com>
 <20180116202327.23253-1-marcus.folkesson@gmail.com>
 <20180116202327.23253-3-marcus.folkesson@gmail.com>
 <CAJfZ7==ONcncWgfN7dOV7tFMqkasrsS9UG_+oRADWeFRdYCwxQ@mail.gmail.com>
 <20180119120713.GA16873@gmail.com>
 <c286ed2a-a228-5a2d-9457-b9033fe05fef@polytechnique.org>
 <20180123193409.GB1203@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
In-Reply-To: <20180123193409.GB1203@gmail.com>
Subject: Re: [PATCH v2 02/14] libselinux: build: follow standard
 semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2018 at 08:34:09PM +0100, Marcus Folkesson wrote:
> On Mon, Jan 22, 2018 at 09:50:36PM +0100, Nicolas Iooss wrote:
> > On 19/01/18 13:07, Marcus Folkesson wrote:
> > > Hi Nicolas!
> > >=20
> > > On Wed, Jan 17, 2018 at 11:12:56PM +0100, Nicolas Iooss wrote:
> > >> On Tue, Jan 16, 2018 at 9:23 PM, Marcus Folkesson
> > >> <marcus.folkesson@gmail.com> wrote:
> > >>> This patch solves the following issues:
> > >>> - The pkg-config files generates odd paths when using DESTDIR witho=
ut PREFIX
> > >>> - DESTDIR is needed during compile time to compute library and head=
er paths which it should not.
> > >>> - Installing with both DESTDIR and PREFIX set gives us odd paths
> > >>> - Make usage of DESTDIR and PREFIX more standard
> > >>>
> > >>> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > >>> ---
> > >>>  libselinux/include/Makefile     |  4 ++--
> > >>>  libselinux/man/Makefile         |  7 ++++---
> > >>>  libselinux/src/Makefile         | 12 +++++-------
> > >>>  libselinux/src/libselinux.pc.in |  2 +-
> > >>>  libselinux/utils/Makefile       |  6 ++----
> > >>>  5 files changed, 14 insertions(+), 17 deletions(-)
> > >>>
> > >>> diff --git a/libselinux/include/Makefile b/libselinux/include/Makef=
ile
> > >>> index 757a6c9c..3b51f5ce 100644
> > >>> --- a/libselinux/include/Makefile
> > >>> +++ b/libselinux/include/Makefile
> > >>> @@ -1,6 +1,6 @@
> > >>>  # Installation directories.
> > >>> -PREFIX ?=3D $(DESTDIR)/usr
> > >>> -INCDIR ?=3D $(PREFIX)/include/selinux
> > >>> +PREFIX ?=3D /usr
> > >>> +INCDIR =3D $(DESTDIR)$(PREFIX)/include/selinux
> > >>>
> > >>>  all:
> > >>>
> > >>> diff --git a/libselinux/man/Makefile b/libselinux/man/Makefile
> > >>> index 0643e6af..233bfaa9 100644
> > >>> --- a/libselinux/man/Makefile
> > >>> +++ b/libselinux/man/Makefile
> > >>> @@ -1,7 +1,8 @@
> > >>>  # Installation directories.
> > >>> -MAN8DIR ?=3D $(DESTDIR)/usr/share/man/man8
> > >>> -MAN5DIR ?=3D $(DESTDIR)/usr/share/man/man5
> > >>> -MAN3DIR ?=3D $(DESTDIR)/usr/share/man/man3
> > >>> +PREFIX ?=3D /usr
> > >>> +MAN8DIR ?=3D $(DESTDIR)$(PREFIX)/share/man/man8
> > >>> +MAN5DIR ?=3D $(DESTDIR)$(PREFIX)/share/man/man5
> > >>> +MAN3DIR ?=3D $(DESTDIR)$(PREFIX)/share/man/man3
> > >>>
> > >>>  all:
> > >>>
> > >>> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > >>> index 18df75c8..18a58164 100644
> > >>> --- a/libselinux/src/Makefile
> > >>> +++ b/libselinux/src/Makefile
> > >>> @@ -8,8 +8,8 @@ RUBYPREFIX ?=3D $(notdir $(RUBY))
> > >>>  PKG_CONFIG ?=3D pkg-config
> > >>>
> > >>>  # Installation directories.
> > >>> -PREFIX ?=3D $(DESTDIR)/usr
> > >>> -LIBDIR ?=3D $(PREFIX)/lib
> > >>> +PREFIX ?=3D /usr
> > >>> +LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
> > >>>  SHLIBDIR ?=3D $(DESTDIR)/lib
> > >>>  INCLUDEDIR ?=3D $(PREFIX)/include
> > >>>  PYINC ?=3D $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
> > >>> @@ -19,8 +19,6 @@ PYCEXT ?=3D $(shell $(PYTHON) -c 'import imp;prin=
t([s for s,m,t in imp.get_suffixe
> > >>>  RUBYINC ?=3D $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rub=
yarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
> > >>>  RUBYLIBS ?=3D $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["li=
bdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["L=
IBRUBYARG_SHARED"]')
> > >>>  RUBYINSTALL ?=3D $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONF=
IG["vendorarchdir"]')
> > >>> -LIBBASE ?=3D $(shell basename $(LIBDIR))
> > >>> -LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
> > >>>
> > >>>  VERSION =3D $(shell cat ../VERSION)
> > >>>  LIBVERSION =3D 1
> > >>> @@ -148,7 +146,7 @@ $(LIBSO): $(LOBJS)
> > >>>         ln -sf $@ $(TARGET)
> > >>>
> > >>>  $(LIBPC): $(LIBPC).in ../VERSION
> > >>> -       sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@=
libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):; s:@PCRE_MODULE@:$(PCRE_=
MODULE):' < $< > $@
> > >>> +       sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@=
libdir@:$(LIBDIR):; s:@includedir@:$(INCLUDEDIR):; s:@PCRE_MODULE@:$(PCRE_M=
ODULE):' < $< > $@
> > >>>
> > >>>  selinuxswig_python_exception.i: ../include/selinux/selinux.h
> > >>>         bash -e exception.sh > $@ || (rm -f $@ ; false)
> > >>> @@ -156,8 +154,8 @@ selinuxswig_python_exception.i: ../include/seli=
nux/selinux.h
> > >>>  $(AUDIT2WHYLOBJ): audit2why.c
> > >>>         $(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHA=
RED -c -o $@ $<
> > >>>
> > >>> -$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(LIBSEPOLA)
> > >>> -       $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $=
(PYLIBS)
> > >>> +$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)
> > >>> +       $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $=
(PYLIBS) -l:libsepol.a
> > >>
> > >> Hello,
> > >> This change makes audit2why.so no longer being rebuilt when libsepol=
's
> > >> code change. This is an issue when debugging issues in libsepol, whi=
ch
> > >> is why I added $(LIBSEPOLA) to the dependencies of $(AUDIT2WHYSO) in
> > >> commit dcd135cc06ab ("Re-link programs after libsepol.a is updated"
> > >> [1]).
> > >> By the way, I like the change from using a "hardcoded" path to
> > >> libsepol.a to telling the compiler to look into directories specified
> > >> with option -L in LDFLAGS. This would ease the packaging a little bi=
t,
> > >> as it makes defining LIBSEPOLA no longer necessary (if I understood
> > >> the changes correctly, I have not tested this point). Is there a way
> > >> to ask the compiler for the resolved location of a static library, in
> > >> a way which can be used to compute the value of LIBSEPOLA? ("gcc
> > >> -Wl,--trace ..." displays it but it is not easily usable).
> > >=20
> > > First of all, thank you for your review.
> > >=20
> > > Actually, I do not have any "good" way to address this issue.
> > > Is $(LIBSEPOLA) mostly used during debug/development?
> > >=20
> > > What do you think about this change:
> > >=20
> > > -----------------8<--------------------------------------------
> > >=20
> > > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > > index 18df75c8..b722a584 100644
> > > --- a/libselinux/src/Makefile
> > > +++ b/libselinux/src/Makefile
> > > @@ -20,7 +20,11 @@ RUBYINC ?=3D $(shell $(RUBY) -e 'puts "-I" + RbCon=
fig::CONFIG["rubyarchhdrdir"] +
> > >  RUBYLIBS ?=3D $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libd=
ir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIB=
RUBYARG_SHARED"]')
> > >  RUBYINSTALL ?=3D $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONFIG=
["vendorarchdir"]')
> > >  LIBBASE ?=3D $(shell basename $(LIBDIR))
> > > -LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
> > > +
> > > +# If no specific libsepol.a is specified, fall back on LDFLAGS searc=
h path
> > > +ifeq ($(LIBSEPOLA),)
> > > +       LDFLAGS +=3D -l:libsepol.a
> > > +endif
> > >=20
> > >  VERSION =3D $(shell cat ../VERSION)
> > >  LIBVERSION =3D 1
> > >=20
> > > -----------------8<--------------------------------------------
> > >=20
> > > This will search for libsepol.a in paths specified in LDFLAGS, but ke=
ep
> > > the possibility to "track" a specific libsepol.a to make dependent su=
bprojects
> > > recompile if libsepol.a is changed.
> >=20
> > Adding "-l:libsepol.a" to LDFLAGS breaks compiling with "make
> > 'LDFLAGS=3D-Wl,--as-needed,--no-undefined'" (which helps detecting shar=
ed
> > libraries linking issues), because of two issues:
> >=20
> > * "LDFLAGS +=3D ..." does nothing when LDFLAGS is defined on the command
> > line. This is why "override LDFLAGS +=3D ..." is used in other places in
> > the Makefile.
> > * After adding "override", -l:libsepol.a appears before $(AUDIT2WHYLOBJ)
> > in the linker invocation, so its objects get ignored because of
> > --as-needed (which is why LDLIBS exists independently of LDFLAGS).
>=20
> Good points.
>=20
> >=20
> > This issue can be easily reproduced by running in libselinux/src the
> > following command:
> >=20
> > make clean && make 'LDFLAGS=3D-Wl,--as-needed,--no-undefined' pywrap
> >=20
> > In order to address this issue, I suggest defining a new variable,
> > LDLIBS_LIBSEPOLA, defined by something like:
> >=20
> > # If no specific libsepol.a is specified, fall back on LDFLAGS search p=
ath
> > # Otherwise, as $(LIBSEPOLA) already appears in the dependencies, there
> > is no need to define a value for LDLIBS_LIBSEPOLA
> > ifeq ($(LIBSEPOLA),)
> > 	LDLIBS_LIBSEPOLA :=3D -l:libsepol.a
> > endif
> >=20
> > #....
> >=20
> > $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(LIBSEPOLA)
> > 	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux
> > $(LDLIBS_LIBSEPOLA) $(PYLIBS)
> >=20
> > What do you think of this?
>=20
> That is much better. I will take this with me to v4.

LIBDIR seems not  propagated to LDFLAGS. It means that when I
try to build everything using

DESTDIR=3D/home/vagrant/build SBINDIR=3D/home/vagrant/build/usr/sbin LIBDIR=
=3D/home/vagrant/build/usr/lib64

and without libsepol.a in standard library paths, it doesn't find libsepol.a


e.g. checkpolicy fails:

cc -O2 -Werror -Wall -Wextra -Wmissing-format-attribute -Wmissing-noreturn =
-Wpointer-arith -Wshadow -Wstrict-prototypes -Wundef -Wunused -Wwrite-strin=
gs -I/home/vagrant/build/usr/include -I. -o policy_define.o -c policy_defin=
e.c          =20
make[1]: *** No rule to make target '/usr/lib64/libsepol.a', needed by 'che=
ckpolicy'.  Stop.       =20

Or if I had /usr/lib64/libsepol.a, checkpolicy and probably audit2why.so
would be linked to the system version not the version installed into
$DESTDIR.

Would it make sense to propagate LIBDIR to LDFLAGS?

Petr

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE6FPBhIsBhc9Chk3zY6itS5gsQ3MFAlpnkzgACgkQY6itS5gs
Q3PbSw//S7b671IizPJZ8DvM0AtQIC/yumTNLCfbgI4LTik5/pxwwif+GOpZ/YB1
wymCBzVrBmCVVtzH7l0tJCdNtgaqHsnpcPNjCGp+32PSVTwOfv8duwEmQ91Rg6Nt
gz6nGFNrFRUSjY7VC7xpRf7PlRUNPcN22jqV21/pSz/5YlxJ+y2Yq/CP9T4Tc5ok
YUTKJzDODtBa5jG1SVFpa2ypPOsO7pOwaMSrnMtwRjPM6b6H5symbWmcyw7U397w
8ct7yeD/XchwJHsQ0++5+CdLWzzlEnkPbiGztJZ8bDUlGuQadNoy5rnRgqOZkrL/
mO1TSdiav792dE0O0m07ZAxBR5r6GE53cpGv5SiwLGf8nYNlDDcfAI+aVKtU3ULG
qxZUpmhaqdsIZUQEPvxxjaQdKCSygcJIEN4eGVIlqVEvD0QKaKFDiLn51w4Th7d8
9ne9MXQNdhc6m05ZtENJraMRcy819Ni696hnvVsRZfA2xMp8G3FvYal2cK1jEpy9
BM76vd+T1bJDvaksAL35J8p8gZ6hc6HDRvWEwxRYjlsqZC20kQm2y8evop+jJfYj
N1ethh1ERtjLMdSdz4dBxfbHE/5Dl6fVqPmrDTy59PDVzSxNBA2fRq83c8HPR2ow
ddYNLQNDwBLauHFpsilkYQHb4Rnx9ptyQyfZaoYL71h7ckcHKZE=
=bAwE
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

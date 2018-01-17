Date: Wed, 17 Jan 2018 17:38:06 +0100
From: Petr Lautrbach <plautrba@redhat.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Message-ID: <20180117163806.GF22270@pl-rpi.tpb.lab.eng.brq.redhat.com>
References: <marcus.folkesson@gmail.com>
 <20180116202327.23253-1-marcus.folkesson@gmail.com>
 <20180116202327.23253-9-marcus.folkesson@gmail.com>
 <20180117101135.GA22270@pl-rpi.tpb.lab.eng.brq.redhat.com>
 <20180117104358.GA18334@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SxgehGEc6vB0cZwN"
In-Reply-To: <20180117104358.GA18334@gmail.com>
Subject: Re: [PATCH v2 08/14] python: build: follow standard
 semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--SxgehGEc6vB0cZwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2018 at 11:43:58AM +0100, Marcus Folkesson wrote:
> Hi,
>=20
> On Wed, Jan 17, 2018 at 11:11:35AM +0100, Petr Lautrbach wrote:
> > On Tue, Jan 16, 2018 at 09:23:21PM +0100, Marcus Folkesson wrote:
> > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > ---
> > >  python/audit2allow/Makefile           | 10 ++++------
> > >  python/chcat/Makefile                 |  8 ++++----
> > >  python/semanage/Makefile              | 13 ++++++-------
> > >  python/sepolgen/src/sepolgen/Makefile |  3 ++-
> > >  python/sepolicy/Makefile              | 18 +++++++++---------
> > >  5 files changed, 25 insertions(+), 27 deletions(-)
> > >=20
> > > diff --git a/python/audit2allow/Makefile b/python/audit2allow/Makefile
> > > index 8db8075f..a73c8c68 100644
> > > --- a/python/audit2allow/Makefile
> > > +++ b/python/audit2allow/Makefile
> > > @@ -1,12 +1,10 @@
> > >  PYTHON ?=3D python
> > > =20
> > >  # Installation directories.
> > > -PREFIX ?=3D $(DESTDIR)/usr
> > > -BINDIR ?=3D $(PREFIX)/bin
> > > -LIBDIR ?=3D $(PREFIX)/lib
> > > -MANDIR ?=3D $(PREFIX)/share/man
> > > -LOCALEDIR ?=3D /usr/share/locale
> > > -INCLUDEDIR ?=3D $(PREFIX)/include
> > > +PREFIX ?=3D /usr
> > > +BINDIR ?=3D $(DESTDIR)$(PREFIX)/bin
> > > +LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
> > > +MANDIR ?=3D $(DESTDIR)$(PREFIX)/share/man
> > >  LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
> > > =20
> > >  CFLAGS ?=3D -Werror -Wall -W
> > > diff --git a/python/chcat/Makefile b/python/chcat/Makefile
> > > index 0fd12d6d..947734a0 100644
> > > --- a/python/chcat/Makefile
> > > +++ b/python/chcat/Makefile
> > > @@ -1,8 +1,8 @@
> > >  # Installation directories.
> > > -PREFIX ?=3D $(DESTDIR)/usr
> > > -BINDIR ?=3D $(PREFIX)/bin
> > > -MANDIR ?=3D $(PREFIX)/share/man
> > > -LOCALEDIR ?=3D $(PREFIX)/share/locale
> > > +PREFIX ?=3D /usr
> > > +BINDIR ?=3D $(DESTDIR)$(PREFIX)/bin
> > > +MANDIR ?=3D $(DESTDIR)$(PREFIX)/share/man
> > > +LOCALEDIR ?=3D $(DESTDIR)$(PREFIX)/share/locale
> > > =20
> > >  .PHONY: all
> > >  all: chcat
> > > diff --git a/python/semanage/Makefile b/python/semanage/Makefile
> > > index 132162bc..70759087 100644
> > > --- a/python/semanage/Makefile
> > > +++ b/python/semanage/Makefile
> > > @@ -1,13 +1,12 @@
> > >  PYTHON ?=3D python
> > > =20
> > >  # Installation directories.
> > > -PREFIX ?=3D $(DESTDIR)/usr
> > > -LIBDIR ?=3D $(PREFIX)/lib
> > > -SBINDIR ?=3D $(PREFIX)/sbin
> > > -MANDIR =3D $(PREFIX)/share/man
> > > -PYTHONLIBDIR ?=3D $(shell $(PYTHON) -c "from distutils.sysconfig imp=
ort *; print(get_python_lib(1))")
> > > -PACKAGEDIR ?=3D $(DESTDIR)/$(PYTHONLIBDIR)
> > > -BASHCOMPLETIONDIR ?=3D $(DESTDIR)/usr/share/bash-completion/completi=
ons
> > > +PREFIX ?=3D /usr
> > > +SBINDIR ?=3D $(DESTDIR)$(PREFIX)/sbin
> > > +MANDIR =3D $(DESTDIR)$(PREFIX)/share/man
> > > +PYTHONLIBDIR ?=3D $(shell $(PYTHON) -c "from distutils.sysconfig imp=
ort *; print(get_python_lib(prefix=3D'$(PREFIX)'))")
> > > +PACKAGEDIR ?=3D $(DESTDIR)$(PYTHONLIBDIR)
> > > +BASHCOMPLETIONDIR ?=3D $(DESTDIR)$(PREFIX)/share/bash-completion/com=
pletions
> > > =20
> > >  TARGETS=3Dsemanage
> > > =20
> > > diff --git a/python/sepolgen/src/sepolgen/Makefile b/python/sepolgen/=
src/sepolgen/Makefile
> > > index d3aa7715..2121a955 100644
> > > --- a/python/sepolgen/src/sepolgen/Makefile
> > > +++ b/python/sepolgen/src/sepolgen/Makefile
> > > @@ -1,5 +1,6 @@
> > > +PREFIX ?=3D /usr
> > >  PYTHON ?=3D python
> > > -PYTHONLIBDIR ?=3D $(shell $(PYTHON) -c "from distutils.sysconfig imp=
ort *; print(get_python_lib(1))")
> > > +PYTHONLIBDIR ?=3D $(shell $(PYTHON) -c "from distutils.sysconfig imp=
ort *; print(get_python_lib(prefix=3D'$(PREFIX)'))")
> > >  PACKAGEDIR ?=3D $(DESTDIR)/$(PYTHONLIBDIR)/sepolgen
> > > =20
> > >  all:
> > > diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
> > > index 5a56e6c8..c528ae43 100644
> > > --- a/python/sepolicy/Makefile
> > > +++ b/python/sepolicy/Makefile
> > > @@ -1,14 +1,14 @@
> > >  PYTHON ?=3D python
> > > =20
> > >  # Installation directories.
> > > -PREFIX ?=3D $(DESTDIR)/usr
> > > -LIBDIR ?=3D $(PREFIX)/lib
> > > -BINDIR ?=3D $(PREFIX)/bin
> > > -DATADIR ?=3D $(PREFIX)/share
> > > -MANDIR ?=3D $(PREFIX)/share/man
> > > -LOCALEDIR ?=3D /usr/share/locale
> > > -BASHCOMPLETIONDIR ?=3D $(DESTDIR)/usr/share/bash-completion/completi=
ons
> > > -SHAREDIR ?=3D $(PREFIX)/share/sandbox
> > > +PREFIX ?=3D /usr
> > > +LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
> > > +BINDIR ?=3D $(DESTDIR)$(PREFIX)/bin
> > > +DATADIR ?=3D $(DESTDIR)$(PREFIX)/share
> > > +MANDIR ?=3D $(DESTDIR)$(PREFIX)/share/man
> > > +LOCALEDIR ?=3D $(DESTDIR)$(PREFIX)/share/locale
> > > +BASHCOMPLETIONDIR ?=3D $(DESTDIR)$(PREFIX)/share/bash-completion/com=
pletions
> > > +SHAREDIR ?=3D $(DESTDIR)$(PREFIX)/share/sandbox
> > >  CFLAGS ?=3D -Wall -Werror -Wextra -W
> > >  override CFLAGS +=3D -DPACKAGE=3D"policycoreutils" -DSHARED -shared
> > > =20
> > > @@ -30,7 +30,7 @@ test:
> > >  	@$(PYTHON) test_sepolicy.py -v
> > > =20
> > >  install:
> > > -	$(PYTHON) setup.py install `test -n "$(DESTDIR)" && echo --root $(D=
ESTDIR)`
> > > +	$(PYTHON) setup.py install --prefix=3D$(PREFIX) `test -n "$(DESTDIR=
)$(PREFIX)" && echo --root $(DESTDIR)$(PREFIX)`
> >=20
> > --root $(DESTDIR)$(PREFIX) seems to duplicate prefix from  --prefix=3D$=
(PREFIX)
> >=20
> > $ cd python
> > $ make \
> >   DESTDIR=3D/home/build/rpmbuild/BUILDROOT/policycoreutils-2.7-99.fc28.=
20180117103354.x86_64 \
> >   LIBSEPOLA=3D/usr/lib64/libsepol.a install
> >=20
> > $ find /home/build/rpmbuild/BUILDROOT/policycoreutils-2.7-99.fc28.20180=
117103354.x86_64/usr/ -type d -name sepolicy
> > /home/build/rpmbuild/BUILDROOT/policycoreutils-2.7-99.fc28.201801171033=
54.x86_64//usr/usr/lib/python2.7/site-packages/sepolicy
> >=20
>=20
> Thank you for discovering this!
> I take it with me to v3.
>=20
> Another thing;=20
> I have tried to get rid of the LIBSEPOLA variable and instead let the
> linker look in default locations after libsepol.a.
> This to get rid of DESTDIR during compile time.
>=20
> For example:
> 	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(PYLIBS) -l:l=
ibsepol.a
>=20
> Do you think we should keep LIBSEPOLA as variable (but default to
> $(PREFIX)/lib/libsepol.a) or let it go with default path?
>=20

I think that the default LIBSEPOLA should be connected to DESTDIR as
'make DESTDIR=3D~/obj' is the documented way how to build and install
everything under a private directory.

>=20
>=20
> > >  	[ -d $(BINDIR) ] || mkdir -p $(BINDIR)
> > >  	install -m 755 sepolicy.py $(BINDIR)/sepolicy
> > >  	(cd $(BINDIR); ln -sf sepolicy sepolgen)
> > > --=20
> > > 2.15.1
> > >=20
> > >=20
>=20
>=20
> Best regards
> Marcus Folkesson
>=20
>=20

--SxgehGEc6vB0cZwN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE6FPBhIsBhc9Chk3zY6itS5gsQ3MFAlpfe+gACgkQY6itS5gs
Q3MbAw//X7+I5xI5R+Dv9Qa8DXRpjnpe1y/86BshPyuYAliKr7PGkWOH6S8taSXe
D8WEO5Bg4yY2E0k5EyLiAQSkwotkr+DGVowOjMqt2NGyqIriV+oJQEZB7BT+73DA
AeUA2N9HHB32nVu/eAGjmIue4LfhpKXE2bLjicWkpJgQoPurf3mQupOKAt6rmizX
2tWEHN6KbS6pMm71e3lIqgGkM/B+fUL0/18X0OD4Thgi1a+KNV2mB2wxmIgCY3Cq
BQ6OaQ1jMjByLqxaRNh758kRy29KjOqJnQb6GFBLrmvHiAdg0weXGNDJq7S2p1dv
VvvfZn7TRlqM8i8NPTJUoxn987ArtLJx2lxyweWrRUqY8eGl/V/eterLYWmF5YWz
P252H4xwSi4kENixdHshqwtOPslQfC93j1F0xbv81oo9+oGM5IBSqzOMleKh8orZ
pbMDP+safuvOz8NEGywOvnLCiLN/hZApzhuBPGw44cxIHF77rCp+9RGvE53zFbgT
mZFIuI0SXehA/dspBA0j+yOwC9EFWlX9oFvAyakozSbqO7jbTFZDnX14kIgiM1bC
u0nVLCJPZS3ebnimh+jwBae55p8LY4rzMTUdzbAl1cGDXgdNjrqvz4gA/dwbRKCs
caaFhGMB2BN5xDSIvwRKIb3lwMNmyhcIZCMSit8CKeSdDaUggfA=
=wjnM
-----END PGP SIGNATURE-----

--SxgehGEc6vB0cZwN--

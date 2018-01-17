Date: Wed, 17 Jan 2018 20:37:29 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Petr Lautrbach <plautrba@redhat.com>
Cc: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Message-ID: <20180117193729.GB10949@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180116202327.23253-1-marcus.folkesson@gmail.com>
 <20180116202327.23253-9-marcus.folkesson@gmail.com>
 <20180117101135.GA22270@pl-rpi.tpb.lab.eng.brq.redhat.com>
 <20180117104358.GA18334@gmail.com>
 <20180117163806.GF22270@pl-rpi.tpb.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
In-Reply-To: <20180117163806.GF22270@pl-rpi.tpb.lab.eng.brq.redhat.com>
Subject: Re: [PATCH v2 08/14] python: build: follow standard
 semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2018 at 05:38:06PM +0100, Petr Lautrbach wrote:
> On Wed, Jan 17, 2018 at 11:43:58AM +0100, Marcus Folkesson wrote:
> > Hi,
> >=20
> > On Wed, Jan 17, 2018 at 11:11:35AM +0100, Petr Lautrbach wrote:
> > > On Tue, Jan 16, 2018 at 09:23:21PM +0100, Marcus Folkesson wrote:
> > > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > > ---
> > > >  python/audit2allow/Makefile           | 10 ++++------
> > > >  python/chcat/Makefile                 |  8 ++++----
> > > >  python/semanage/Makefile              | 13 ++++++-------
> > > >  python/sepolgen/src/sepolgen/Makefile |  3 ++-
> > > >  python/sepolicy/Makefile              | 18 +++++++++---------
> > > >  5 files changed, 25 insertions(+), 27 deletions(-)
> > > >=20
> > > > diff --git a/python/audit2allow/Makefile b/python/audit2allow/Makef=
ile
> > > > index 8db8075f..a73c8c68 100644
> > > > --- a/python/audit2allow/Makefile
> > > > +++ b/python/audit2allow/Makefile
> > > > @@ -1,12 +1,10 @@
> > > >  PYTHON ?=3D python
> > > > =20
> > > >  # Installation directories.
> > > > -PREFIX ?=3D $(DESTDIR)/usr
> > > > -BINDIR ?=3D $(PREFIX)/bin
> > > > -LIBDIR ?=3D $(PREFIX)/lib
> > > > -MANDIR ?=3D $(PREFIX)/share/man
> > > > -LOCALEDIR ?=3D /usr/share/locale
> > > > -INCLUDEDIR ?=3D $(PREFIX)/include
> > > > +PREFIX ?=3D /usr
> > > > +BINDIR ?=3D $(DESTDIR)$(PREFIX)/bin
> > > > +LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
> > > > +MANDIR ?=3D $(DESTDIR)$(PREFIX)/share/man
> > > >  LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
> > > > =20
> > > >  CFLAGS ?=3D -Werror -Wall -W
> > > > diff --git a/python/chcat/Makefile b/python/chcat/Makefile
> > > > index 0fd12d6d..947734a0 100644
> > > > --- a/python/chcat/Makefile
> > > > +++ b/python/chcat/Makefile
> > > > @@ -1,8 +1,8 @@
> > > >  # Installation directories.
> > > > -PREFIX ?=3D $(DESTDIR)/usr
> > > > -BINDIR ?=3D $(PREFIX)/bin
> > > > -MANDIR ?=3D $(PREFIX)/share/man
> > > > -LOCALEDIR ?=3D $(PREFIX)/share/locale
> > > > +PREFIX ?=3D /usr
> > > > +BINDIR ?=3D $(DESTDIR)$(PREFIX)/bin
> > > > +MANDIR ?=3D $(DESTDIR)$(PREFIX)/share/man
> > > > +LOCALEDIR ?=3D $(DESTDIR)$(PREFIX)/share/locale
> > > > =20
> > > >  .PHONY: all
> > > >  all: chcat
> > > > diff --git a/python/semanage/Makefile b/python/semanage/Makefile
> > > > index 132162bc..70759087 100644
> > > > --- a/python/semanage/Makefile
> > > > +++ b/python/semanage/Makefile
> > > > @@ -1,13 +1,12 @@
> > > >  PYTHON ?=3D python
> > > > =20
> > > >  # Installation directories.
> > > > -PREFIX ?=3D $(DESTDIR)/usr
> > > > -LIBDIR ?=3D $(PREFIX)/lib
> > > > -SBINDIR ?=3D $(PREFIX)/sbin
> > > > -MANDIR =3D $(PREFIX)/share/man
> > > > -PYTHONLIBDIR ?=3D $(shell $(PYTHON) -c "from distutils.sysconfig i=
mport *; print(get_python_lib(1))")
> > > > -PACKAGEDIR ?=3D $(DESTDIR)/$(PYTHONLIBDIR)
> > > > -BASHCOMPLETIONDIR ?=3D $(DESTDIR)/usr/share/bash-completion/comple=
tions
> > > > +PREFIX ?=3D /usr
> > > > +SBINDIR ?=3D $(DESTDIR)$(PREFIX)/sbin
> > > > +MANDIR =3D $(DESTDIR)$(PREFIX)/share/man
> > > > +PYTHONLIBDIR ?=3D $(shell $(PYTHON) -c "from distutils.sysconfig i=
mport *; print(get_python_lib(prefix=3D'$(PREFIX)'))")
> > > > +PACKAGEDIR ?=3D $(DESTDIR)$(PYTHONLIBDIR)
> > > > +BASHCOMPLETIONDIR ?=3D $(DESTDIR)$(PREFIX)/share/bash-completion/c=
ompletions
> > > > =20
> > > >  TARGETS=3Dsemanage
> > > > =20
> > > > diff --git a/python/sepolgen/src/sepolgen/Makefile b/python/sepolge=
n/src/sepolgen/Makefile
> > > > index d3aa7715..2121a955 100644
> > > > --- a/python/sepolgen/src/sepolgen/Makefile
> > > > +++ b/python/sepolgen/src/sepolgen/Makefile
> > > > @@ -1,5 +1,6 @@
> > > > +PREFIX ?=3D /usr
> > > >  PYTHON ?=3D python
> > > > -PYTHONLIBDIR ?=3D $(shell $(PYTHON) -c "from distutils.sysconfig i=
mport *; print(get_python_lib(1))")
> > > > +PYTHONLIBDIR ?=3D $(shell $(PYTHON) -c "from distutils.sysconfig i=
mport *; print(get_python_lib(prefix=3D'$(PREFIX)'))")
> > > >  PACKAGEDIR ?=3D $(DESTDIR)/$(PYTHONLIBDIR)/sepolgen
> > > > =20
> > > >  all:
> > > > diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
> > > > index 5a56e6c8..c528ae43 100644
> > > > --- a/python/sepolicy/Makefile
> > > > +++ b/python/sepolicy/Makefile
> > > > @@ -1,14 +1,14 @@
> > > >  PYTHON ?=3D python
> > > > =20
> > > >  # Installation directories.
> > > > -PREFIX ?=3D $(DESTDIR)/usr
> > > > -LIBDIR ?=3D $(PREFIX)/lib
> > > > -BINDIR ?=3D $(PREFIX)/bin
> > > > -DATADIR ?=3D $(PREFIX)/share
> > > > -MANDIR ?=3D $(PREFIX)/share/man
> > > > -LOCALEDIR ?=3D /usr/share/locale
> > > > -BASHCOMPLETIONDIR ?=3D $(DESTDIR)/usr/share/bash-completion/comple=
tions
> > > > -SHAREDIR ?=3D $(PREFIX)/share/sandbox
> > > > +PREFIX ?=3D /usr
> > > > +LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
> > > > +BINDIR ?=3D $(DESTDIR)$(PREFIX)/bin
> > > > +DATADIR ?=3D $(DESTDIR)$(PREFIX)/share
> > > > +MANDIR ?=3D $(DESTDIR)$(PREFIX)/share/man
> > > > +LOCALEDIR ?=3D $(DESTDIR)$(PREFIX)/share/locale
> > > > +BASHCOMPLETIONDIR ?=3D $(DESTDIR)$(PREFIX)/share/bash-completion/c=
ompletions
> > > > +SHAREDIR ?=3D $(DESTDIR)$(PREFIX)/share/sandbox
> > > >  CFLAGS ?=3D -Wall -Werror -Wextra -W
> > > >  override CFLAGS +=3D -DPACKAGE=3D"policycoreutils" -DSHARED -shared
> > > > =20
> > > > @@ -30,7 +30,7 @@ test:
> > > >  	@$(PYTHON) test_sepolicy.py -v
> > > > =20
> > > >  install:
> > > > -	$(PYTHON) setup.py install `test -n "$(DESTDIR)" && echo --root $=
(DESTDIR)`
> > > > +	$(PYTHON) setup.py install --prefix=3D$(PREFIX) `test -n "$(DESTD=
IR)$(PREFIX)" && echo --root $(DESTDIR)$(PREFIX)`
> > >=20
> > > --root $(DESTDIR)$(PREFIX) seems to duplicate prefix from  --prefix=
=3D$(PREFIX)
> > >=20
> > > $ cd python
> > > $ make \
> > >   DESTDIR=3D/home/build/rpmbuild/BUILDROOT/policycoreutils-2.7-99.fc2=
8.20180117103354.x86_64 \
> > >   LIBSEPOLA=3D/usr/lib64/libsepol.a install
> > >=20
> > > $ find /home/build/rpmbuild/BUILDROOT/policycoreutils-2.7-99.fc28.201=
80117103354.x86_64/usr/ -type d -name sepolicy
> > > /home/build/rpmbuild/BUILDROOT/policycoreutils-2.7-99.fc28.2018011710=
3354.x86_64//usr/usr/lib/python2.7/site-packages/sepolicy
> > >=20
> >=20
> > Thank you for discovering this!
> > I take it with me to v3.
> >=20
> > Another thing;=20
> > I have tried to get rid of the LIBSEPOLA variable and instead let the
> > linker look in default locations after libsepol.a.
> > This to get rid of DESTDIR during compile time.
> >=20
> > For example:
> > 	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(PYLIBS) -l=
:libsepol.a
> >=20
> > Do you think we should keep LIBSEPOLA as variable (but default to
> > $(PREFIX)/lib/libsepol.a) or let it go with default path?
> >=20
>=20
> I think that the default LIBSEPOLA should be connected to DESTDIR as
> 'make DESTDIR=3D~/obj' is the documented way how to build and install
> everything under a private directory.
>=20

I can see why it may seems like a good idea. But..
What i object to is that:

- DESTDIR should not be part of the compile stage according to the GNU
  Coding Standard [1]. It is only part of the install stage.

- The current usage of PREFIX and DESTDIR is not working as expected.
  For example, this does not compile at all:
  	make DESTDIR=3D/tmp/myroot PREFIX=3D/selinux install

- All components does not compile with 'make DESTDIR=3D~/obj'. For
  example libselinux:
 	make DESTDIR=3D/tmp/obj install
	cd libselinux
	make clean
	make DESTDIR=3D/tmp/obj

  It all depends on running from the top Makefile

- 'make DESTDIR=3D~/obj' from the top Makefile still works in the case of
  these patches.


I really think as much as possible should follow standards. And it would
be really nice if we could make it work with SELinux.

I will come up with a v3 later tonight including fixes for your input. But =
I let
the LIBSEPOLA be 'as is' until I have heard your (and others of cause) thou=
ghs about it.


Thanks

[1] https://www.gnu.org/prep/standards/html_node/DESTDIR.html




> >=20
> >=20
> > > >  	[ -d $(BINDIR) ] || mkdir -p $(BINDIR)
> > > >  	install -m 755 sepolicy.py $(BINDIR)/sepolicy
> > > >  	(cd $(BINDIR); ln -sf sepolicy sepolgen)
> > > > --=20
> > > > 2.15.1
> > > >=20
> > > >=20
> >=20
> >=20
> > Best regards
> > Marcus Folkesson
> >=20
> >=20


Best regards
Marcus Folkesson


--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlpfpfEACgkQiIBOb1ld
UjKeWBAAoOrXqJltdlVShqNSduftiZWYT06RX8jSMOoGM7ag6Qad6sXnzqns0TUp
QMJC6LexiDdeieoaD2koakJcjck4VaEXVw02R+bMm/OLGGaXCuC0gOZrDP3CctgA
xcL5KPqQJfkH6u7rH0/xtXsZhOCba1O6bdCVakfGFHyYMkfrSc/ufuFy8UKM5uCT
/hSzAdxE0ULfbb2A/DWlEhXs89C21UtbPIvj2tWPVEVwXaIHYrLhTpOHoUkrLnRZ
vhDlHXNKj6q3E/GfsMc9dlnS+vS7Pc7bSbOsYvIiz3NgqNKOuPOAwxz8itzsZtoZ
b/DCVgvoKBMCb6DXgr85biHGkIEJ5N4/cD8F7vJlTIQGO7qkvji2bfZcU7zZRJ+h
4u52X0XK/d6sApkzAH07h2FEIl8ZuPdj9FjvECSNyPt7WdHiRXwIjYTKzs/joLtP
/wwlPGklj7+vQz0vDLpNzF79Z9dxIRdT+Wmdw7mqg1d6pW1L+mUSjOvA5DNvHIX1
vs62T9b8UwdtydChqWhFiYIpE46aAXJqY09/k9j7lAEAtehdwwmP7BIq/SpYRaq2
/bUtexV9QfpLOSXqqkJwIv0eA8ZJwJmRiIU6uv6qhX8JlfTKLiXdSz56ReAXix/W
uZOGHcK5oZrPaziyJO57n1Wxa+8Pep14AdfK875QJ5BOqETKgB0=
=f4nj
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--

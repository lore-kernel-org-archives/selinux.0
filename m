Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0NJN7Mr008572
 for <selinux@tycho.nsa.gov>; Tue, 23 Jan 2018 14:23:07 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC07.oob.disa.mil (Postfix) with SMTP id 3zQyr86RRxz29Nn1
 for <selinux@tycho.nsa.gov>; Tue, 23 Jan 2018 19:23:04 +0000 (UTC)
Received: from UPBD19PA11.eemsg.mil (unknown [192.168.18.17])
 by UPDCF3IC07.oob.disa.mil (Postfix) with ESMTP id 3zQyr70zX4z1x08Z
 for <selinux@tycho.nsa.gov>; Tue, 23 Jan 2018 19:23:03 +0000 (UTC)
Received: by mail-lf0-f66.google.com with SMTP id f3so2037627lfe.4
 for <selinux@tycho.nsa.gov>; Tue, 23 Jan 2018 11:23:02 -0800 (PST)
Date: Tue, 23 Jan 2018 20:22:51 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Petr Lautrbach <plautrba@redhat.com>
Cc: selinux@tycho.nsa.gov
Message-ID: <20180123192251.GA1203@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180121214617.8975-1-marcus.folkesson@gmail.com>
 <20180121214617.8975-9-marcus.folkesson@gmail.com>
 <20180123102446.GA19889@pl-rpi.tpb.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
In-Reply-To: <20180123102446.GA19889@pl-rpi.tpb.lab.eng.brq.redhat.com>
Subject: Re: [PATCH v3 08/14] python: build: follow standard
 semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Petr,

On Tue, Jan 23, 2018 at 11:24:47AM +0100, Petr Lautrbach wrote:
> On Sun, Jan 21, 2018 at 10:46:11PM +0100, Marcus Folkesson wrote:
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
> >  python/audit2allow/Makefile           | 17 ++++++++++-------
> >  python/chcat/Makefile                 |  8 ++++----
> >  python/semanage/Makefile              | 11 +++++------
> >  python/sepolgen/src/sepolgen/Makefile |  3 ++-
> >  python/sepolicy/Makefile              | 18 +++++++++---------
> >  5 files changed, 30 insertions(+), 27 deletions(-)
> >=20
> > diff --git a/python/audit2allow/Makefile b/python/audit2allow/Makefile
> > index 8db8075f..d1d4ca8d 100644
> > --- a/python/audit2allow/Makefile
> > +++ b/python/audit2allow/Makefile
> > @@ -1,19 +1,22 @@
> >  PYTHON ?=3D python
> > =20
> >  # Installation directories.
> > -PREFIX ?=3D $(DESTDIR)/usr
> > -BINDIR ?=3D $(PREFIX)/bin
> > -LIBDIR ?=3D $(PREFIX)/lib
> > -MANDIR ?=3D $(PREFIX)/share/man
> > -LOCALEDIR ?=3D /usr/share/locale
> > -INCLUDEDIR ?=3D $(PREFIX)/include
> > -LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
> > +PREFIX ?=3D /usr
> > +BINDIR ?=3D $(DESTDIR)$(PREFIX)/bin
> > +LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
> > +MANDIR ?=3D $(DESTDIR)$(PREFIX)/share/man
> > =20
> >  CFLAGS ?=3D -Werror -Wall -W
> > =20
> > +# If no specific libsepol.a is specified, fall back on LDFLAGS search =
path
> > +ifeq ($(LIBSEPOLA),)
> > +       LDFLAGS +=3D -l:libsepol.a
> > +endif
> > +
> >  all: audit2why sepolgen-ifgen-attr-helper
> > =20
> >  sepolgen-ifgen-attr-helper: sepolgen-ifgen-attr-helper.o $(LIBSEPOLA)
> > +	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
> > =20
> >  audit2why:
> >  	ln -sf audit2allow audit2why
> > diff --git a/python/chcat/Makefile b/python/chcat/Makefile
> > index 0fd12d6d..947734a0 100644
> > --- a/python/chcat/Makefile
> > +++ b/python/chcat/Makefile
> > @@ -1,8 +1,8 @@
> >  # Installation directories.
> > -PREFIX ?=3D $(DESTDIR)/usr
> > -BINDIR ?=3D $(PREFIX)/bin
> > -MANDIR ?=3D $(PREFIX)/share/man
> > -LOCALEDIR ?=3D $(PREFIX)/share/locale
> > +PREFIX ?=3D /usr
> > +BINDIR ?=3D $(DESTDIR)$(PREFIX)/bin
> > +MANDIR ?=3D $(DESTDIR)$(PREFIX)/share/man
> > +LOCALEDIR ?=3D $(DESTDIR)$(PREFIX)/share/locale
> > =20
> >  .PHONY: all
> >  all: chcat
> > diff --git a/python/semanage/Makefile b/python/semanage/Makefile
> > index 132162bc..0218222d 100644
> > --- a/python/semanage/Makefile
> > +++ b/python/semanage/Makefile
> > @@ -1,13 +1,12 @@
> >  PYTHON ?=3D python
> > =20
> >  # Installation directories.
> > -PREFIX ?=3D $(DESTDIR)/usr
> > -LIBDIR ?=3D $(PREFIX)/lib
> > -SBINDIR ?=3D $(PREFIX)/sbin
> > -MANDIR =3D $(PREFIX)/share/man
> > -PYTHONLIBDIR ?=3D $(shell $(PYTHON) -c "from distutils.sysconfig impor=
t *; print(get_python_lib(1))")
> > +PREFIX ?=3D /usr
> > +SBINDIR ?=3D $(DESTDIR)$(PREFIX)/sbin
> > +MANDIR =3D $(DESTDIR)$(PREFIX)/share/man
> > +PYTHONLIBDIR ?=3D $(shell $(PYTHON) -c "from distutils.sysconfig impor=
t *; print(get_python_lib(prefix=3D'$(PREFIX)'))")
>=20
> Note that this change move paths for modules from platform-specific to
> platform-shared:
>=20
> - /home/vagrant/build/usr/lib64/python3.6/site-packages/seobject.py
> + /home/vagrant/build/usr/lib/python3.6/site-packages/seobject.py
>=20
> I think it's a good change given that there's only pure python
> modules, but it would be good to document it in the commit message.
>=20
>=20

I will split up the logical changes and make it to a seperate commit in
v4.

Thanks you!

> >  PACKAGEDIR ?=3D $(DESTDIR)/$(PYTHONLIBDIR)
> > -BASHCOMPLETIONDIR ?=3D $(DESTDIR)/usr/share/bash-completion/completions
> > +BASHCOMPLETIONDIR ?=3D $(DESTDIR)$(PREFIX)/share/bash-completion/compl=
etions
> > =20
> >  TARGETS=3Dsemanage
> > =20
> > diff --git a/python/sepolgen/src/sepolgen/Makefile b/python/sepolgen/sr=
c/sepolgen/Makefile
> > index d3aa7715..2121a955 100644
> > --- a/python/sepolgen/src/sepolgen/Makefile
> > +++ b/python/sepolgen/src/sepolgen/Makefile
> > @@ -1,5 +1,6 @@
> > +PREFIX ?=3D /usr
> >  PYTHON ?=3D python
> > -PYTHONLIBDIR ?=3D $(shell $(PYTHON) -c "from distutils.sysconfig impor=
t *; print(get_python_lib(1))")
> > +PYTHONLIBDIR ?=3D $(shell $(PYTHON) -c "from distutils.sysconfig impor=
t *; print(get_python_lib(prefix=3D'$(PREFIX)'))")
> >  PACKAGEDIR ?=3D $(DESTDIR)/$(PYTHONLIBDIR)/sepolgen
> > =20
> >  all:
> > diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
> > index 5a56e6c8..1c02ee06 100644
> > --- a/python/sepolicy/Makefile
> > +++ b/python/sepolicy/Makefile
> > @@ -1,14 +1,14 @@
> >  PYTHON ?=3D python
> > =20
> >  # Installation directories.
> > -PREFIX ?=3D $(DESTDIR)/usr
> > -LIBDIR ?=3D $(PREFIX)/lib
> > -BINDIR ?=3D $(PREFIX)/bin
> > -DATADIR ?=3D $(PREFIX)/share
> > -MANDIR ?=3D $(PREFIX)/share/man
> > -LOCALEDIR ?=3D /usr/share/locale
> > -BASHCOMPLETIONDIR ?=3D $(DESTDIR)/usr/share/bash-completion/completions
> > -SHAREDIR ?=3D $(PREFIX)/share/sandbox
> > +PREFIX ?=3D /usr
> > +LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
> > +BINDIR ?=3D $(DESTDIR)$(PREFIX)/bin
> > +DATADIR ?=3D $(DESTDIR)$(PREFIX)/share
> > +MANDIR ?=3D $(DESTDIR)$(PREFIX)/share/man
> > +LOCALEDIR ?=3D $(DESTDIR)$(PREFIX)/share/locale
> > +BASHCOMPLETIONDIR ?=3D $(DESTDIR)$(PREFIX)/share/bash-completion/compl=
etions
> > +SHAREDIR ?=3D $(DESTDIR)$(PREFIX)/share/sandbox
> >  CFLAGS ?=3D -Wall -Werror -Wextra -W
> >  override CFLAGS +=3D -DPACKAGE=3D"policycoreutils" -DSHARED -shared
> > =20
> > @@ -30,7 +30,7 @@ test:
> >  	@$(PYTHON) test_sepolicy.py -v
> > =20
> >  install:
> > -	$(PYTHON) setup.py install `test -n "$(DESTDIR)" && echo --root $(DES=
TDIR)`
> > +	$(PYTHON) setup.py install --prefix=3D$(PREFIX) `test -n "$(DESTDIR)"=
 && echo --root $(DESTDIR)`
> >  	[ -d $(BINDIR) ] || mkdir -p $(BINDIR)
> >  	install -m 755 sepolicy.py $(BINDIR)/sepolicy
> >  	(cd $(BINDIR); ln -sf sepolicy sepolgen)
> > --=20
> > 2.15.1
> >=20
> >=20


Best regards
Marcus Folkesson



--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlpni4YACgkQiIBOb1ld
UjKv8g/+PQYjPiqClbYVylyYVI/33yV3DJ542C6MrIl+p3KnhixuyE6znnQG36rG
vYxqBODf5RQNqZq13WEz8+81FUa5w9o2bDPLuXhAoTvCvG3/5tCr7nenUlsd3JgY
KnrqcZIT2b3bsVhd1KbKMcu0ADJTFRWbFJ2iskWeu/h1L/Lynfd3QOgfLvBjy2Xb
pIEE09u4NvNnWB2OybO8xzICiowVqYowmx4wy/kSiVNtnqm8qDbIREIBjdXezq23
Qo4BIUPkdIV++WhRHCFTF4FAwIvzWcrKyCR5Bjz84svhgm0pckkKGZjDmkWdksSX
V0+9eDH//ItqTIZCWdJxlWxXkedBk6yDKsIG9W69AWw/YMj7qalK0IyIUTGs1ywJ
wNGfC8Os/1x3EyttywyDoxi3mcSVcIWoxKhStL8PAhDzV0YVjsfeY2ygMmCtwbNC
BM2uOjsXi3reOBTBIsBi4/edgAvcU1u0oF2YVc/70BRhZGayAPXojeOZkXDkhv27
baTi/DLMxCTHd39ttFiNdMZLuYT1HrmmgqBf8oiMsr9WhuGtwEm3/PTmVm9A7q+X
0FqCtuJVR0Ar9AnQCNuntLc7HVfxaB95Ay6++DJkbHv/ncBgQP5ZBx8gFbsAWank
/kuj2F4aj6uPuJn4iQz8J9BBzC7xUsTwT0xxZN+FnFX1m+7tX1Y=
=/EE2
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--

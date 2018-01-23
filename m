Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0NAPU42024327
 for <selinux@tycho.nsa.gov>; Tue, 23 Jan 2018 05:25:30 -0500
Date: Tue, 23 Jan 2018 11:24:47 +0100
From: Petr Lautrbach <plautrba@redhat.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: selinux@tycho.nsa.gov
Message-ID: <20180123102446.GA19889@pl-rpi.tpb.lab.eng.brq.redhat.com>
References: <marcus.folkesson@gmail.com>
 <20180121214617.8975-1-marcus.folkesson@gmail.com>
 <20180121214617.8975-9-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
In-Reply-To: <20180121214617.8975-9-marcus.folkesson@gmail.com>
Subject: Re: [PATCH v3 08/14] python: build: follow standard
 semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2018 at 10:46:11PM +0100, Marcus Folkesson wrote:
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  python/audit2allow/Makefile           | 17 ++++++++++-------
>  python/chcat/Makefile                 |  8 ++++----
>  python/semanage/Makefile              | 11 +++++------
>  python/sepolgen/src/sepolgen/Makefile |  3 ++-
>  python/sepolicy/Makefile              | 18 +++++++++---------
>  5 files changed, 30 insertions(+), 27 deletions(-)
>=20
> diff --git a/python/audit2allow/Makefile b/python/audit2allow/Makefile
> index 8db8075f..d1d4ca8d 100644
> --- a/python/audit2allow/Makefile
> +++ b/python/audit2allow/Makefile
> @@ -1,19 +1,22 @@
>  PYTHON ?=3D python
> =20
>  # Installation directories.
> -PREFIX ?=3D $(DESTDIR)/usr
> -BINDIR ?=3D $(PREFIX)/bin
> -LIBDIR ?=3D $(PREFIX)/lib
> -MANDIR ?=3D $(PREFIX)/share/man
> -LOCALEDIR ?=3D /usr/share/locale
> -INCLUDEDIR ?=3D $(PREFIX)/include
> -LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
> +PREFIX ?=3D /usr
> +BINDIR ?=3D $(DESTDIR)$(PREFIX)/bin
> +LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
> +MANDIR ?=3D $(DESTDIR)$(PREFIX)/share/man
> =20
>  CFLAGS ?=3D -Werror -Wall -W
> =20
> +# If no specific libsepol.a is specified, fall back on LDFLAGS search pa=
th
> +ifeq ($(LIBSEPOLA),)
> +       LDFLAGS +=3D -l:libsepol.a
> +endif
> +
>  all: audit2why sepolgen-ifgen-attr-helper
> =20
>  sepolgen-ifgen-attr-helper: sepolgen-ifgen-attr-helper.o $(LIBSEPOLA)
> +	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
> =20
>  audit2why:
>  	ln -sf audit2allow audit2why
> diff --git a/python/chcat/Makefile b/python/chcat/Makefile
> index 0fd12d6d..947734a0 100644
> --- a/python/chcat/Makefile
> +++ b/python/chcat/Makefile
> @@ -1,8 +1,8 @@
>  # Installation directories.
> -PREFIX ?=3D $(DESTDIR)/usr
> -BINDIR ?=3D $(PREFIX)/bin
> -MANDIR ?=3D $(PREFIX)/share/man
> -LOCALEDIR ?=3D $(PREFIX)/share/locale
> +PREFIX ?=3D /usr
> +BINDIR ?=3D $(DESTDIR)$(PREFIX)/bin
> +MANDIR ?=3D $(DESTDIR)$(PREFIX)/share/man
> +LOCALEDIR ?=3D $(DESTDIR)$(PREFIX)/share/locale
> =20
>  .PHONY: all
>  all: chcat
> diff --git a/python/semanage/Makefile b/python/semanage/Makefile
> index 132162bc..0218222d 100644
> --- a/python/semanage/Makefile
> +++ b/python/semanage/Makefile
> @@ -1,13 +1,12 @@
>  PYTHON ?=3D python
> =20
>  # Installation directories.
> -PREFIX ?=3D $(DESTDIR)/usr
> -LIBDIR ?=3D $(PREFIX)/lib
> -SBINDIR ?=3D $(PREFIX)/sbin
> -MANDIR =3D $(PREFIX)/share/man
> -PYTHONLIBDIR ?=3D $(shell $(PYTHON) -c "from distutils.sysconfig import =
*; print(get_python_lib(1))")
> +PREFIX ?=3D /usr
> +SBINDIR ?=3D $(DESTDIR)$(PREFIX)/sbin
> +MANDIR =3D $(DESTDIR)$(PREFIX)/share/man
> +PYTHONLIBDIR ?=3D $(shell $(PYTHON) -c "from distutils.sysconfig import =
*; print(get_python_lib(prefix=3D'$(PREFIX)'))")

Note that this change move paths for modules from platform-specific to
platform-shared:

- /home/vagrant/build/usr/lib64/python3.6/site-packages/seobject.py
+ /home/vagrant/build/usr/lib/python3.6/site-packages/seobject.py

I think it's a good change given that there's only pure python
modules, but it would be good to document it in the commit message.


>  PACKAGEDIR ?=3D $(DESTDIR)/$(PYTHONLIBDIR)
> -BASHCOMPLETIONDIR ?=3D $(DESTDIR)/usr/share/bash-completion/completions
> +BASHCOMPLETIONDIR ?=3D $(DESTDIR)$(PREFIX)/share/bash-completion/complet=
ions
> =20
>  TARGETS=3Dsemanage
> =20
> diff --git a/python/sepolgen/src/sepolgen/Makefile b/python/sepolgen/src/=
sepolgen/Makefile
> index d3aa7715..2121a955 100644
> --- a/python/sepolgen/src/sepolgen/Makefile
> +++ b/python/sepolgen/src/sepolgen/Makefile
> @@ -1,5 +1,6 @@
> +PREFIX ?=3D /usr
>  PYTHON ?=3D python
> -PYTHONLIBDIR ?=3D $(shell $(PYTHON) -c "from distutils.sysconfig import =
*; print(get_python_lib(1))")
> +PYTHONLIBDIR ?=3D $(shell $(PYTHON) -c "from distutils.sysconfig import =
*; print(get_python_lib(prefix=3D'$(PREFIX)'))")
>  PACKAGEDIR ?=3D $(DESTDIR)/$(PYTHONLIBDIR)/sepolgen
> =20
>  all:
> diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
> index 5a56e6c8..1c02ee06 100644
> --- a/python/sepolicy/Makefile
> +++ b/python/sepolicy/Makefile
> @@ -1,14 +1,14 @@
>  PYTHON ?=3D python
> =20
>  # Installation directories.
> -PREFIX ?=3D $(DESTDIR)/usr
> -LIBDIR ?=3D $(PREFIX)/lib
> -BINDIR ?=3D $(PREFIX)/bin
> -DATADIR ?=3D $(PREFIX)/share
> -MANDIR ?=3D $(PREFIX)/share/man
> -LOCALEDIR ?=3D /usr/share/locale
> -BASHCOMPLETIONDIR ?=3D $(DESTDIR)/usr/share/bash-completion/completions
> -SHAREDIR ?=3D $(PREFIX)/share/sandbox
> +PREFIX ?=3D /usr
> +LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
> +BINDIR ?=3D $(DESTDIR)$(PREFIX)/bin
> +DATADIR ?=3D $(DESTDIR)$(PREFIX)/share
> +MANDIR ?=3D $(DESTDIR)$(PREFIX)/share/man
> +LOCALEDIR ?=3D $(DESTDIR)$(PREFIX)/share/locale
> +BASHCOMPLETIONDIR ?=3D $(DESTDIR)$(PREFIX)/share/bash-completion/complet=
ions
> +SHAREDIR ?=3D $(DESTDIR)$(PREFIX)/share/sandbox
>  CFLAGS ?=3D -Wall -Werror -Wextra -W
>  override CFLAGS +=3D -DPACKAGE=3D"policycoreutils" -DSHARED -shared
> =20
> @@ -30,7 +30,7 @@ test:
>  	@$(PYTHON) test_sepolicy.py -v
> =20
>  install:
> -	$(PYTHON) setup.py install `test -n "$(DESTDIR)" && echo --root $(DESTD=
IR)`
> +	$(PYTHON) setup.py install --prefix=3D$(PREFIX) `test -n "$(DESTDIR)" &=
& echo --root $(DESTDIR)`
>  	[ -d $(BINDIR) ] || mkdir -p $(BINDIR)
>  	install -m 755 sepolicy.py $(BINDIR)/sepolicy
>  	(cd $(BINDIR); ln -sf sepolicy sepolgen)
> --=20
> 2.15.1
>=20
>=20

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE6FPBhIsBhc9Chk3zY6itS5gsQ3MFAlpnDWkACgkQY6itS5gs
Q3NZzA/+IWz97ik0D2bbkSgyY++0PD6nDDKokd085oZO8wfvUd3+mnwRuwVDQFhq
zd1uLOCMFjCbequekuEgLgbdCJFd0NtY8aqFH0IiqnWfCTQor/thfHtEqv04cKeo
SGfejdx+LCjXx9iP5nwCSCgkOPp6EsIilqnAVlMynwCsyz4woQU+q/6gsyfB9e5I
BCVqdssjYh9Q2M0daqwseUvMta56NsBmgxME+pw+IBI3rXln3JUNTpbMsFaUmgbe
fNVraWItC0bJ8hhTH6efqfhDY66dgxY6c8LxwnG9SiuTBQqnDmnzU0MkG7keOmJU
xfcT7/hSEnPY6MGXjqir4CLFMx04HW/w69QU22Mr+I4awnXzFx90A0hBJEToPWmR
lGZfWGskKBWYHRxFLSVUQgQkh3c2lmkW3KOOvRNtMvVX5427Y7ydXi8v2NxaKczx
BCr3UsKGpXFw1h4Z5k8ZPWK9qTpNdcgexomCRhEWv5ZfXkGfSJUmak5n9GOXww1Z
qjg4HD+n6KQJs9EhE9J0Ms0BJwDA/SZS7KJ6Ofw0xVfayalSCuoaacBZV1MMFxFz
iZS0+3vPiKgJRWni0VFNNkncICtsruDMNoFXdPK8HGU3tiCt0wcGvh3fAUZECQB9
OVkTf4IZjGEEdVdakVt6MTz9rQbfMekMLP38m+CrP+A7FKKaSg4=
=8cdu
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--

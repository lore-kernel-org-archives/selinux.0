Date: Wed, 17 Jan 2018 11:11:35 +0100
From: Petr Lautrbach <plautrba@redhat.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Message-ID: <20180117101135.GA22270@pl-rpi.tpb.lab.eng.brq.redhat.com>
References: <marcus.folkesson@gmail.com>
 <20180116202327.23253-1-marcus.folkesson@gmail.com>
 <20180116202327.23253-9-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
In-Reply-To: <20180116202327.23253-9-marcus.folkesson@gmail.com>
Subject: Re: [PATCH v2 08/14] python: build: follow standard
 semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 09:23:21PM +0100, Marcus Folkesson wrote:
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  python/audit2allow/Makefile           | 10 ++++------
>  python/chcat/Makefile                 |  8 ++++----
>  python/semanage/Makefile              | 13 ++++++-------
>  python/sepolgen/src/sepolgen/Makefile |  3 ++-
>  python/sepolicy/Makefile              | 18 +++++++++---------
>  5 files changed, 25 insertions(+), 27 deletions(-)
>=20
> diff --git a/python/audit2allow/Makefile b/python/audit2allow/Makefile
> index 8db8075f..a73c8c68 100644
> --- a/python/audit2allow/Makefile
> +++ b/python/audit2allow/Makefile
> @@ -1,12 +1,10 @@
>  PYTHON ?=3D python
> =20
>  # Installation directories.
> -PREFIX ?=3D $(DESTDIR)/usr
> -BINDIR ?=3D $(PREFIX)/bin
> -LIBDIR ?=3D $(PREFIX)/lib
> -MANDIR ?=3D $(PREFIX)/share/man
> -LOCALEDIR ?=3D /usr/share/locale
> -INCLUDEDIR ?=3D $(PREFIX)/include
> +PREFIX ?=3D /usr
> +BINDIR ?=3D $(DESTDIR)$(PREFIX)/bin
> +LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
> +MANDIR ?=3D $(DESTDIR)$(PREFIX)/share/man
>  LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
> =20
>  CFLAGS ?=3D -Werror -Wall -W
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
> index 132162bc..70759087 100644
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
> -PACKAGEDIR ?=3D $(DESTDIR)/$(PYTHONLIBDIR)
> -BASHCOMPLETIONDIR ?=3D $(DESTDIR)/usr/share/bash-completion/completions
> +PREFIX ?=3D /usr
> +SBINDIR ?=3D $(DESTDIR)$(PREFIX)/sbin
> +MANDIR =3D $(DESTDIR)$(PREFIX)/share/man
> +PYTHONLIBDIR ?=3D $(shell $(PYTHON) -c "from distutils.sysconfig import =
*; print(get_python_lib(prefix=3D'$(PREFIX)'))")
> +PACKAGEDIR ?=3D $(DESTDIR)$(PYTHONLIBDIR)
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
> index 5a56e6c8..c528ae43 100644
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
> +	$(PYTHON) setup.py install --prefix=3D$(PREFIX) `test -n "$(DESTDIR)$(P=
REFIX)" && echo --root $(DESTDIR)$(PREFIX)`

--root $(DESTDIR)$(PREFIX) seems to duplicate prefix from  --prefix=3D$(PRE=
FIX)

$ cd python
$ make \
  DESTDIR=3D/home/build/rpmbuild/BUILDROOT/policycoreutils-2.7-99.fc28.2018=
0117103354.x86_64 \
  LIBSEPOLA=3D/usr/lib64/libsepol.a install

$ find /home/build/rpmbuild/BUILDROOT/policycoreutils-2.7-99.fc28.201801171=
03354.x86_64/usr/ -type d -name sepolicy
/home/build/rpmbuild/BUILDROOT/policycoreutils-2.7-99.fc28.20180117103354.x=
86_64//usr/usr/lib/python2.7/site-packages/sepolicy


>  	[ -d $(BINDIR) ] || mkdir -p $(BINDIR)
>  	install -m 755 sepolicy.py $(BINDIR)/sepolicy
>  	(cd $(BINDIR); ln -sf sepolicy sepolgen)
> --=20
> 2.15.1
>=20
>=20

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE6FPBhIsBhc9Chk3zY6itS5gsQ3MFAlpfIVEACgkQY6itS5gs
Q3NNxA//T5GWKu8Z838QgnM5795C7OpIiF6qpydUnoRymV1rije5yTK/bMSm5P49
TTffBx+SpRfXDTjqEz9EvgS8HLGYbLqiHnrHo73rRFOMXOg1vF9IkFrYmkQ9JS4+
wKLYuqptoFUk/gvTPIZSe7+O3wN71aCaP5Bx10Ydc2AADh3q/fGteAv0xeL/t/Ps
CwZ2OkP+0DRhjYFVTXcqM49pEiBSDJPDwkJTiKITZczaQyzAvSTbuGMUyvbVJE4O
XWl6bD/qJM8Dnd9/2mRwpXAqpO21TRhqkvTrxzL8RcwX1Fcjv0eBDST+YQZKKWwM
XTr7f0iQs0+t5tfep36bxWw/gtacJqEllENQksDvCwctJC5meLllmfdjSLwaKHIl
+h39vWGwPn3xAw32LL2hOUQfSK4pmZrC+bcoFYEjXQ4QznYCNqLJPxsmrUVgRSVN
lWJcj53VKY1vsJNvq8/A3gA3oxyat1hRkkBiWN3Mjun1TcPfww5JI7SjVwMB3Ll7
9//lJ3WNaCF51C6CC483nrnlJ2qrTvjJuf3l+4+j3bDvoyHkYSfzZNk2S3AjJ3/j
vPNjSDaI38grlUsgSgBY1uoZQWBIYe4bh6BKfxwINEGVKF8/3eE+6f55jwPG3W7S
nPnWjME7npcKVPtZxVDoOiLL6sZSB+sb7HXnSr2EsMf7W4M4b08=
=xgx7
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

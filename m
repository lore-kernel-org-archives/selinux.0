Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2EJUGEY016018
 for <selinux@tycho.nsa.gov>; Wed, 14 Mar 2018 15:30:16 -0400
Date: Wed, 14 Mar 2018 20:30:03 +0100
From: Petr Lautrbach <plautrba@redhat.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux@tycho.nsa.gov
Message-ID: <20180314193002.GA9676@workstation>
References: <20180311221527.7626-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
In-Reply-To: <20180311221527.7626-1-nicolas.iooss@m4x.org>
Subject: Re: [PATCH v2 1/1] libselinux,
 libsemanage: Replace PYSITEDIR with PYTHONLIBDIR
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 11, 2018 at 11:15:27PM +0100, Nicolas Iooss wrote:
> libselinux and libsemanage Makefiles invoke site.getsitepackages() in
> order to get the path to the directory /usr/lib/pythonX.Y/site-packages
> that matches the Python interpreter chosen with $(PYTHON). This method
> is incompatible with Python virtual environments, as described in
> https://github.com/pypa/virtualenv/issues/355#issuecomment-10250452 .
> This issue has been opened for more than 5 years.
>=20
> On the contrary python/semanage/ and python/sepolgen/ Makefiles use
> distutils.sysconfig.get_python_lib() in order to get the site-packages
> path into a variable named PYTHONLIBDIR. This way of computing
> PYTHONLIBDIR is compatible with virtual environments and gives the same
> result as PYSITEDIR.
>=20
> As PYTHONLIBDIR works in more cases than PYSITEDIR, make libselinux and
> libsemanage Makefiles use it. And as native code is installed (as part
> of the SWIG wrapper), use "plat_specific=3D1" in order to use /usr/lib64
> on systems which distinguish /usr/lib64 from /usr/lib.
>=20
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Looks good to me. Thanks!

https://github.com/SELinuxProject/selinux/pull/86

Acked-by: Petr Lautrbach <plautrba@redhat.com>


> ---
> v2: add plat_specific=3D1
>=20
>  .travis.yml              |  5 +----
>  libselinux/src/Makefile  | 10 +++++-----
>  libsemanage/src/Makefile |  8 ++++----
>  3 files changed, 10 insertions(+), 13 deletions(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 0312e996e333..63c7a544aa45 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -96,9 +96,6 @@ before_script:
>    - export PKG_CONFIG_PATH=3D"/opt/python/$($PYTHON -c 'import sys;print=
("%d.%d.%d" % sys.version_info[:3])')/lib/pkgconfig"
>    # PyPy does not provide a config file for pkg-config nor a pypy-c.so
>    - if echo "$PYVER" | grep -q pypy ; then export PYINC=3D-I$($PYTHON -c=
 'import sys;print(sys.prefix)')/include PYLIBS=3D ; fi
> -  # Python virtualenvs do not support "import site; print(site.getsitepa=
ckages()[0]"
> -  # cf. https://github.com/pypa/virtualenv/issues/355#issuecomment-10250=
452
> -  - export PYSITEDIR=3D"/usr/lib/$($PYTHON -c 'import sys;print("python%=
d.%d" % sys.version_info[:2])')/site-packages"
> =20
>    # Find the Ruby executable with version $RUBYLIBVER
>    - export RUBY=3D"$(ls -d -1 "$HOME/.rvm/rubies/ruby-$RUBYLIBVER"*/bin/=
ruby | head -n 1)"
> @@ -126,7 +123,7 @@ script:
>    # Set up environment variables for the tests
>    - export LD_LIBRARY_PATH=3D"$DESTDIR/usr/lib:$DESTDIR/lib"
>    - export PATH=3D"$DESTDIR/usr/sbin:$DESTDIR/usr/bin:$DESTDIR/sbin:$DES=
TDIR/bin:$PATH"
> -  - export PYTHONPATH=3D"$DESTDIR$PYSITEDIR"
> +  - export PYTHONPATH=3D"$DESTDIR$($PYTHON -c "from distutils.sysconfig =
import *;print(get_python_lib(prefix=3D'/usr'))")"
>    - export RUBYLIB=3D"$DESTDIR/$($RUBY -e 'puts RbConfig::CONFIG["vendor=
libdir"]'):$DESTDIR/$($RUBY -e 'puts RbConfig::CONFIG["vendorarchdir"]')"
> =20
>    # Show variables (to help debugging issues)
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 18588da586bf..8af04aab0ec2 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -14,7 +14,7 @@ SHLIBDIR ?=3D /lib
>  INCLUDEDIR ?=3D $(PREFIX)/include
>  PYINC ?=3D $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
>  PYLIBS ?=3D $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
> -PYSITEDIR ?=3D $(shell $(PYTHON) -c 'import site; print(site.getsitepack=
ages()[0])')
> +PYTHONLIBDIR ?=3D $(shell $(PYTHON) -c "from distutils.sysconfig import =
*; print(get_python_lib(plat_specific=3D1, prefix=3D'$(PREFIX)'))")
>  PYCEXT ?=3D $(shell $(PYTHON) -c 'import imp;print([s for s,m,t in imp.g=
et_suffixes() if t =3D=3D imp.C_EXTENSION][0])')
>  RUBYINC ?=3D $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchh=
drdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
>  RUBYLIBS ?=3D $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"]=
 + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBY=
ARG_SHARED"]')
> @@ -191,10 +191,10 @@ install: all
>  	ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(=
TARGET)
> =20
>  install-pywrap: pywrap
> -	test -d $(DESTDIR)$(PYSITEDIR)/selinux || install -m 755 -d $(DESTDIR)$=
(PYSITEDIR)/selinux
> -	install -m 755 $(SWIGSO) $(DESTDIR)$(PYSITEDIR)/_selinux$(PYCEXT)
> -	install -m 755 $(AUDIT2WHYSO) $(DESTDIR)$(PYSITEDIR)/selinux/audit2why$=
(PYCEXT)
> -	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYSITEDIR)/selinux/__init__.py
> +	test -d $(DESTDIR)$(PYTHONLIBDIR)/selinux || install -m 755 -d $(DESTDI=
R)$(PYTHONLIBDIR)/selinux
> +	install -m 755 $(SWIGSO) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
> +	install -m 755 $(AUDIT2WHYSO) $(DESTDIR)$(PYTHONLIBDIR)/selinux/audit2w=
hy$(PYCEXT)
> +	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.=
py
> =20
>  install-rubywrap: rubywrap
>  	test -d $(DESTDIR)$(RUBYINSTALL) || install -m 755 -d $(DESTDIR)$(RUBYI=
NSTALL)=20
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index e98d8760acb7..dea751e5b436 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -13,7 +13,7 @@ LIBDIR ?=3D $(PREFIX)/lib
>  INCLUDEDIR ?=3D $(PREFIX)/include
>  PYINC ?=3D $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
>  PYLIBS ?=3D $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
> -PYSITEDIR ?=3D $(shell $(PYTHON) -c 'import site; print(site.getsitepack=
ages()[0])')
> +PYTHONLIBDIR ?=3D $(shell $(PYTHON) -c "from distutils.sysconfig import =
*; print(get_python_lib(plat_specific=3D1, prefix=3D'$(PREFIX)'))")
>  PYCEXT ?=3D $(shell $(PYTHON) -c 'import imp;print([s for s,m,t in imp.g=
et_suffixes() if t =3D=3D imp.C_EXTENSION][0])')
>  RUBYINC ?=3D $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchh=
drdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
>  RUBYLIBS ?=3D $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"]=
 + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBY=
ARG_SHARED"]')
> @@ -142,9 +142,9 @@ install: all
>  	cd $(DESTDIR)$(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
> =20
>  install-pywrap: pywrap=20
> -	test -d $(DESTDIR)$(PYSITEDIR) || install -m 755 -d $(DESTDIR)$(PYSITED=
IR)
> -	install -m 755 $(SWIGSO) $(DESTDIR)$(PYSITEDIR)/_semanage$(PYCEXT)
> -	install -m 644 semanage.py $(DESTDIR)$(PYSITEDIR)
> +	test -d $(DESTDIR)$(PYTHONLIBDIR) || install -m 755 -d $(DESTDIR)$(PYTH=
ONLIBDIR)
> +	install -m 755 $(SWIGSO) $(DESTDIR)$(PYTHONLIBDIR)/_semanage$(PYCEXT)
> +	install -m 644 semanage.py $(DESTDIR)$(PYTHONLIBDIR)
> =20
> =20
>  install-rubywrap: rubywrap
> --=20
> 2.16.0
>=20
>=20

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAlqpeDIACgkQviIJHj72
InXNuw//Wnk4WiWN30uISjP9lLh5DvkWaWS+WEK34sfqTo+XIc/QQHFpO+aWDzgq
pTQZKg1evEGxNQpX1pYpXdUDG0sdpJgS8U+qb2CHb27X++qY9/cHoTzd+4UHp2qp
GiUFBJcimb+tUOk4qws4g5qkSiPdlyY4xyxrSYXZZ/99WwjK6oWts7uhwvEQ06LH
TCQdMvYn/eeXGAtOUCJmPuYtwNp8jrXU4VP8tumYY/dFLTyDF6az84jEukTMaA9T
KM4cUe9xmqJ8fdTWHh7UKC/rJiRebiQ2MXAA39x9HJEqdXY/BgA77782Y3JNEuMh
YFDpBwOZ8YNl/y6lfxuQ/wVJQ7IIiWMMtNAb/1uQxpqt1rURr2qDMWs56itCyuVk
25EguBlUkC5OO7MsdvbaZJ/rYzSLL5HYcK7fwdDWsC+Ivyul6C8EqJpHuC5CNUQJ
ctNW99EJgZXIyLyFd42plnpQ3q+AcxFMREm9C2PAwKBFNoUHwsAm5UYS4EcCsvV4
pBiGSLgnEELM8XBuk6xQf0SBYnr+ZqrXzwBA3subB9yeZWt13cdJ5yoS5mjSaaE6
2nyYYb6opGqyobfW26Qn5JxQexWZkmgK3plfq6DoKDW2swll6nqFOouN4tW3PDNM
Vm/pyonnbVI1RSmpDS8SfDN4/Fw4wrRBcUhRgSR/b63sBYiuVmY=
=idan
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--

Date: Fri, 9 Mar 2018 15:39:13 +0100
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux <selinux@tycho.nsa.gov>
Message-ID: <20180309143913.GB3849@workstation>
References: <20180305221611.19964-1-nicolas.iooss@m4x.org>
 <fde35f5b-92f0-5707-5af4-6e2ced3af8f6@tycho.nsa.gov>
 <408e7eeb-2e44-4487-a976-775df79197c8@tycho.nsa.gov>
 <CAJfZ7==qgVM0KwHdSJ2z7E4iifTx-CPjT3ikFfX4iorG6vOAXw@mail.gmail.com>
 <20180309122556.GA3849@workstation>
 <7b11fb39-1d8d-c500-c6ca-30f7eb2e42cd@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
In-Reply-To: <7b11fb39-1d8d-c500-c6ca-30f7eb2e42cd@tycho.nsa.gov>
Subject: Re: [PATCH 1/1] libselinux,
 libsemanage: Replace PYSITEDIR with PYTHONLIBDIR
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2018 at 08:55:11AM -0500, Stephen Smalley wrote:
> On 03/09/2018 07:25 AM, Petr Lautrbach wrote:
> > On Thu, Mar 08, 2018 at 10:19:26PM +0100, Nicolas Iooss wrote:
> >> On Thu, Mar 8, 2018 at 8:34 PM, Stephen Smalley <sds@tycho.nsa.gov> wr=
ote:
> >>> On 03/06/2018 04:19 PM, Stephen Smalley wrote:
> >>>> On 03/05/2018 05:16 PM, Nicolas Iooss wrote:
> >>>>> libselinux and libsemanage Makefiles invoke site.getsitepackages() =
in
> >>>>> order to get the path to the directory /usr/lib/pythonX.Y/site-pack=
ages
> >>>>> that matches the Python interpreter chosen with $(PYTHON). This met=
hod
> >>>>> is incompatible with Python virtual environments, as described in
> >>>>> https://github.com/pypa/virtualenv/issues/355#issuecomment-10250452=
 .
> >>>>> This issue has been opened for more than 5 years.
> >>>>>
> >>>>> On the contrary python/semanage/ and python/sepolgen/ Makefiles use
> >>>>> distutils.sysconfig.get_python_lib() in order to get the site-packa=
ges
> >>>>> path into a variable named PYTHONLIBDIR. This way of computing
> >>>>> PYTHONLIBDIR is compatible with virtual environments and gives the =
same
> >>>>> result as PYSITEDIR.
> >>>>>
> >>>>> As PYTHONLIBDIR works in more cases than PYSITEDIR, make libselinux=
 and
> >>>>> libsemanage Makefiles use it.
> >>>>
> >>>> On Fedora x86_64, this changes the install location from /usr/lib64 =
to /usr/lib.
> >>>
> >>> That said I agree we ought to be consistent, and it does seem that we=
 are not currently.
> >>> I'm just not sure what the best fix is in this case and the impact on=
 distro packagers.
> >>
> >> Good point. I have read
> >> https://marc.info/?l=3Dselinux&m=3D151670320132614&w=3D2 too quickly (=
and
> >> missed "given that there's only pure python modules"). This message
> >> suggests that doing using get_python_lib(plat_specific=3D1) would keep
> >> /usr/lib64 on Fedora (unfortunately I only have access to Debian,
> >> Ubuntu and Arch Linux systems right now so I am not able to test).
> >=20
> > On Fedora Rawhide:
> >=20
> >>>> get_python_lib()
> > '/usr/lib/python3.6/site-packages'
> >>>> get_python_lib(plat_specific=3D1)
> > '/usr/lib64/python3.6/site-packages'
> >>>> get_python_lib(prefix=3D'/usr/local')
> > '/usr/local/lib/python3.6/site-packages'
> >>>> get_python_lib(prefix=3D'/usr/local', plat_specific=3D1)
> > '/usr/local/lib64/python3.6/site-packages'
> >=20
> >=20
> >> And
> >> to be consistent, I suggest naming the variable differently from
> >> PYTHONLIBDIR. For example:
> >>
> >> PYTHONPLATLIBDIR ?=3D $(shell $(PYTHON) -c "from distutils.sysconfig
> >> import *; print(get_python_lib(plat_specific=3D1, prefix=3D'$(PREFIX)'=
))")
> >>
> >> ... or PYPLATLIBDIR if PYTHONPLATLIBDIR is too long. Or we also can
> >> keep the name PYSITEDIR while changing its definition, in order to
> >> minimize the impact. What would be acceptable?
> >>
> >=20
> > Given that libselinux and libsemanage provides only extension SWIG gene=
rated
> > modules I'd just set plat_specific=3D1 and use PYTHONLIBDIR in this cas=
e.
>=20
> Looking at the Fedora packages (on 27), I see that:
>=20
> 1) libselinux-python{3} and libsemanage-python{3} puts all of their files=
 under /usr/lib64
> 2) policycoreutils-python puts sepolicy under /usr/lib but the rest (e.g.=
 seobject, sepolgen) under /usr/lib64
>=20
> Meanwhile, a "make LIBDIR=3D/usr/lib64 SHLIBDIR=3D/lib64 install install-=
pywrap relabel" from selinux userspace (as per the README) installs the lib=
selinux and libsemanage python modules under /usr/lib64 (the same as the Fe=
dora packages) but all of the former policycoreutils ones (now python/*) un=
der /usr/lib, and this seems to have been a change as part of Marcus' recen=
t patch series (python: build: move modules from platform-specific to platf=
orm-shared).
>=20
> So is Fedora also going to move all of the policycoreutils-python modules=
 to /usr/lib (maybe this has already happened in rawhide)?

Yes. Everything from python/ will be moved to /usr/lib to follow the Marcus
change. Currently, It's not in Fedora as I haven't rebased packages yet but=
 it should
happen soon in F28 and Rawhide.




--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAlqinIoACgkQviIJHj72
InWlHRAAgo3FWQGY1wNHyWvN1IQhBuCVolcQImjQexHaN78PEH6xoVnN2GsYa7G/
eRkPMzUtp9KXYy0c1qkefttKGJUseGq7emfYVpGo2T7sdAReR5jpEdaKz47TZvTE
7rzPj2Ww74M23rkEhACHtGj2tRzWxmorl968Qqx6Eag6jWi/+qsf3wTgiU42HJO3
qIJkVEUUaQxdoA2D+C0Tbgtfr0MUvpxWmKtqJy5b3pSFdlxdFTpEmB8VxMYoPcBo
wONZ2wZsUujhyy367tFsPBw4+ieeOC7nhuRDq9pnkSzd69Ei9ZtjS02eMLGjYJYn
o01nUoCFSe1wonEzCFpFPPkh+WVtSWrsm2r8I0O0QLi9fJNDnMCQuD1Da/2kr82g
FjMDIG8wyIEwYxPxN4izecm8wrzMUt80o1l3+Kjv14myQ1TEW08PgKxShQypt8yY
AAamJ4fct4qEwWZ2UYuTqq1BIgXPc1bmXAXxTEnakVhKnVuIB+ttxAEUGyR3gl7K
fVAruUKVDwo81VSkC3AifyODeOnNPwe4DuS3Rs6YnDnskdCTqgT7/nMtwsxHBvHB
nu3qcBWRr+1gw9iBeSbgxoUA2ALmL9yOdovi6SLajfShTIv74pdnECai0Ngj1pfx
NDDKG8DBuZIPe4TXFLMpIlaUcvAx8DoRFaRJuQFlyYGf2A6HdzU=
=h9BH
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--

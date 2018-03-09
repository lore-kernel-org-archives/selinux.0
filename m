Date: Fri, 9 Mar 2018 13:25:56 +0100
From: Petr Lautrbach <plautrba@redhat.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>
Message-ID: <20180309122556.GA3849@workstation>
References: <20180305221611.19964-1-nicolas.iooss@m4x.org>
 <fde35f5b-92f0-5707-5af4-6e2ced3af8f6@tycho.nsa.gov>
 <408e7eeb-2e44-4487-a976-775df79197c8@tycho.nsa.gov>
 <CAJfZ7==qgVM0KwHdSJ2z7E4iifTx-CPjT3ikFfX4iorG6vOAXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
In-Reply-To: <CAJfZ7==qgVM0KwHdSJ2z7E4iifTx-CPjT3ikFfX4iorG6vOAXw@mail.gmail.com>
Subject: Re: [PATCH 1/1] libselinux,
 libsemanage: Replace PYSITEDIR with PYTHONLIBDIR
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 08, 2018 at 10:19:26PM +0100, Nicolas Iooss wrote:
> On Thu, Mar 8, 2018 at 8:34 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 03/06/2018 04:19 PM, Stephen Smalley wrote:
> >> On 03/05/2018 05:16 PM, Nicolas Iooss wrote:
> >>> libselinux and libsemanage Makefiles invoke site.getsitepackages() in
> >>> order to get the path to the directory /usr/lib/pythonX.Y/site-packag=
es
> >>> that matches the Python interpreter chosen with $(PYTHON). This method
> >>> is incompatible with Python virtual environments, as described in
> >>> https://github.com/pypa/virtualenv/issues/355#issuecomment-10250452 .
> >>> This issue has been opened for more than 5 years.
> >>>
> >>> On the contrary python/semanage/ and python/sepolgen/ Makefiles use
> >>> distutils.sysconfig.get_python_lib() in order to get the site-packages
> >>> path into a variable named PYTHONLIBDIR. This way of computing
> >>> PYTHONLIBDIR is compatible with virtual environments and gives the sa=
me
> >>> result as PYSITEDIR.
> >>>
> >>> As PYTHONLIBDIR works in more cases than PYSITEDIR, make libselinux a=
nd
> >>> libsemanage Makefiles use it.
> >>
> >> On Fedora x86_64, this changes the install location from /usr/lib64 to=
 /usr/lib.
> >
> > That said I agree we ought to be consistent, and it does seem that we a=
re not currently.
> > I'm just not sure what the best fix is in this case and the impact on d=
istro packagers.
>=20
> Good point. I have read
> https://marc.info/?l=3Dselinux&m=3D151670320132614&w=3D2 too quickly (and
> missed "given that there's only pure python modules"). This message
> suggests that doing using get_python_lib(plat_specific=3D1) would keep
> /usr/lib64 on Fedora (unfortunately I only have access to Debian,
> Ubuntu and Arch Linux systems right now so I am not able to test).

On Fedora Rawhide:

>>> get_python_lib()
'/usr/lib/python3.6/site-packages'
>>> get_python_lib(plat_specific=3D1)
'/usr/lib64/python3.6/site-packages'
>>> get_python_lib(prefix=3D'/usr/local')
'/usr/local/lib/python3.6/site-packages'
>>> get_python_lib(prefix=3D'/usr/local', plat_specific=3D1)
'/usr/local/lib64/python3.6/site-packages'


> And
> to be consistent, I suggest naming the variable differently from
> PYTHONLIBDIR. For example:
>=20
> PYTHONPLATLIBDIR ?=3D $(shell $(PYTHON) -c "from distutils.sysconfig
> import *; print(get_python_lib(plat_specific=3D1, prefix=3D'$(PREFIX)'))")
>=20
> ... or PYPLATLIBDIR if PYTHONPLATLIBDIR is too long. Or we also can
> keep the name PYSITEDIR while changing its definition, in order to
> minimize the impact. What would be acceptable?
>

Given that libselinux and libsemanage provides only extension SWIG generated
modules I'd just set plat_specific=3D1 and use PYTHONLIBDIR in this case.


> Cheers,
> Nicolas
>=20

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAlqifU0ACgkQviIJHj72
InXx7g//TyCx+ahwQhGWclCpG/1UNiqb1C9OAGnzpnY12t89DnQoUk9xzjJaRQA+
/bvpLBECMbL5SmlxNCxgBvfQes71kyVLkLCxglgc9Gxz/k7iP3QNVuxrGIb8A2or
QJ6GBePpA5tiV2pWy9pXWFNZE/VM9pDml5ZCeih0RObnyNU73qlqWX6cNxm6fyy1
XelExjaDNIWKD4iTMCl948tRWms7f7Lp41GPnzTKB3Lh3/TfvM2z+5lnJSLp4/Ap
PrvSz3a4w3n9TjykFdoU2XY5L74SbOahIVk9BqK4Hiy14X5PNAIzVNFBt7iJQQ4H
kh1MxKOzM6YDg7+aye69cs4vNRxW2FnwRsdW/ydODXtyIzkySVSof8mapFxPo1z0
Zf5eFEXjf9kPvpJ61ivA2RXYc5E6tjvaa4hR0UmxNx9YivDY8d44CdUB1o/6tIH/
UHl8Po+ZfY+fsXYg3FS+Efwj9FkW9GnYFFAGILovTJd46h1e6jIpRNxouDE0op/U
YDeGiyvPgOAuLKA8lSIOvs+56wLwouYvcJsX77cgFzaShswoK9GvffViIcpS3WI4
dvsgWCphPYjzbMGBwTulQyofscSnCqw91BZS5hxiaKykBVaZm+PxZ7l/KLliMBJW
X4R9pnpNjN6OjBqgQd3pQsoVOz14UHSosECZGjuPUnTLkk35I3o=
=fGGJ
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--

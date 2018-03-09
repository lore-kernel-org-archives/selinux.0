Date: Fri, 9 Mar 2018 22:02:52 +0100
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
Message-ID: <20180309210251.GA14257@workstation>
References: <20180305221611.19964-1-nicolas.iooss@m4x.org>
 <fde35f5b-92f0-5707-5af4-6e2ced3af8f6@tycho.nsa.gov>
 <408e7eeb-2e44-4487-a976-775df79197c8@tycho.nsa.gov>
 <CAJfZ7==qgVM0KwHdSJ2z7E4iifTx-CPjT3ikFfX4iorG6vOAXw@mail.gmail.com>
 <20180309122556.GA3849@workstation>
 <7b11fb39-1d8d-c500-c6ca-30f7eb2e42cd@tycho.nsa.gov>
 <20180309143913.GB3849@workstation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
In-Reply-To: <20180309143913.GB3849@workstation>
Subject: Re: [PATCH 1/1] libselinux,
 libsemanage: Replace PYSITEDIR with PYTHONLIBDIR
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2018 at 03:39:13PM +0100, Petr Lautrbach wrote:
> On Fri, Mar 09, 2018 at 08:55:11AM -0500, Stephen Smalley wrote:
> > On 03/09/2018 07:25 AM, Petr Lautrbach wrote:
> > > On Thu, Mar 08, 2018 at 10:19:26PM +0100, Nicolas Iooss wrote:
> > >> On Thu, Mar 8, 2018 at 8:34 PM, Stephen Smalley <sds@tycho.nsa.gov> =
wrote:
> > >>> On 03/06/2018 04:19 PM, Stephen Smalley wrote:
> > >>>> On 03/05/2018 05:16 PM, Nicolas Iooss wrote:
> > >>>>> libselinux and libsemanage Makefiles invoke site.getsitepackages(=
) in
> > >>>>> order to get the path to the directory /usr/lib/pythonX.Y/site-pa=
ckages
> > >>>>> that matches the Python interpreter chosen with $(PYTHON). This m=
ethod
> > >>>>> is incompatible with Python virtual environments, as described in
> > >>>>> https://github.com/pypa/virtualenv/issues/355#issuecomment-102504=
52 .
> > >>>>> This issue has been opened for more than 5 years.
> > >>>>>
> > >>>>> On the contrary python/semanage/ and python/sepolgen/ Makefiles u=
se
> > >>>>> distutils.sysconfig.get_python_lib() in order to get the site-pac=
kages
> > >>>>> path into a variable named PYTHONLIBDIR. This way of computing
> > >>>>> PYTHONLIBDIR is compatible with virtual environments and gives th=
e same
> > >>>>> result as PYSITEDIR.
> > >>>>>
> > >>>>> As PYTHONLIBDIR works in more cases than PYSITEDIR, make libselin=
ux and
> > >>>>> libsemanage Makefiles use it.
> > >>>>
> > >>>> On Fedora x86_64, this changes the install location from /usr/lib6=
4 to /usr/lib.
> > >>>
> > >>> That said I agree we ought to be consistent, and it does seem that =
we are not currently.
> > >>> I'm just not sure what the best fix is in this case and the impact =
on distro packagers.
> > >>
> > >> Good point. I have read
> > >> https://marc.info/?l=3Dselinux&m=3D151670320132614&w=3D2 too quickly=
 (and
> > >> missed "given that there's only pure python modules"). This message
> > >> suggests that doing using get_python_lib(plat_specific=3D1) would ke=
ep
> > >> /usr/lib64 on Fedora (unfortunately I only have access to Debian,
> > >> Ubuntu and Arch Linux systems right now so I am not able to test).
> > >=20
> > > On Fedora Rawhide:
> > >=20
> > >>>> get_python_lib()
> > > '/usr/lib/python3.6/site-packages'
> > >>>> get_python_lib(plat_specific=3D1)
> > > '/usr/lib64/python3.6/site-packages'
> > >>>> get_python_lib(prefix=3D'/usr/local')
> > > '/usr/local/lib/python3.6/site-packages'
> > >>>> get_python_lib(prefix=3D'/usr/local', plat_specific=3D1)
> > > '/usr/local/lib64/python3.6/site-packages'
> > >=20
> > >=20
> > >> And
> > >> to be consistent, I suggest naming the variable differently from
> > >> PYTHONLIBDIR. For example:
> > >>
> > >> PYTHONPLATLIBDIR ?=3D $(shell $(PYTHON) -c "from distutils.sysconfig
> > >> import *; print(get_python_lib(plat_specific=3D1, prefix=3D'$(PREFIX=
)'))")
> > >>
> > >> ... or PYPLATLIBDIR if PYTHONPLATLIBDIR is too long. Or we also can
> > >> keep the name PYSITEDIR while changing its definition, in order to
> > >> minimize the impact. What would be acceptable?
> > >>
> > >=20
> > > Given that libselinux and libsemanage provides only extension SWIG ge=
nerated
> > > modules I'd just set plat_specific=3D1 and use PYTHONLIBDIR in this c=
ase.
> >=20
> > Looking at the Fedora packages (on 27), I see that:
> >=20
> > 1) libselinux-python{3} and libsemanage-python{3} puts all of their fil=
es under /usr/lib64
> > 2) policycoreutils-python puts sepolicy under /usr/lib but the rest (e.=
g. seobject, sepolgen) under /usr/lib64
> >=20
> > Meanwhile, a "make LIBDIR=3D/usr/lib64 SHLIBDIR=3D/lib64 install instal=
l-pywrap relabel" from selinux userspace (as per the README) installs the l=
ibselinux and libsemanage python modules under /usr/lib64 (the same as the =
Fedora packages) but all of the former policycoreutils ones (now python/*) =
under /usr/lib, and this seems to have been a change as part of Marcus' rec=
ent patch series (python: build: move modules from platform-specific to pla=
tform-shared).
> >=20
> > So is Fedora also going to move all of the policycoreutils-python modul=
es to /usr/lib (maybe this has already happened in rawhide)?
>=20
> Yes. Everything from python/ will be moved to /usr/lib to follow the Marc=
us
> change. Currently, It's not in Fedora as I haven't rebased packages yet b=
ut it should
> happen soon in F28 and Rawhide.
>=20

A test policycoreutils build based on latest changes can be found in my
plautrba/selinux-fedora COPR repo [1]

$ rpm -qpl python2-policycoreutils-2.7-99.fc29.20180309170801.x86_64.rpm py=
thon3-policycoreutils-2.7-99.fc29.20180309170801.x86_64.rpm | grep /usr/lib=
64/ | wc -l
0

$ rpm -qpl python2-policycoreutils-2.7-99.fc29.20180309170801.x86_64.rpm py=
thon3-policycoreutils-2.7-99.fc29.20180309170801.x86_64.rpm | grep /usr/lib=
/ | wc -l =20
349


[1] https://copr.fedorainfracloud.org/coprs/build/726366/

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAlqi9nMACgkQviIJHj72
InVwRQ/+J6QTB/lgdb0GokgDkg+CkrKYUGwc6vaCJzgMQNO0YE615RW4Vwlnf3ci
f6REPq1F8ALssdxY3PGpyNTdS/BqQrTI5cR4aSUAt/KHEhXWgSMSIbxyjAJKqGMK
OvvNZci12h48ElIjhl5hEQpDaWH7KiuhykY/Y5dkBZ4JbFz8jRbEkva3YLFjghDO
FHapWcBxPjMslpflllZakNKXp/T6sJfIPx6OzJoVcYAETbThn/CsDTr115DTBjZ8
1VmUX7JSNLyhEASr0q/MclCq5o8RWAtIFeEayeRePnAJzCF1usQ996P+MOrvPICt
g+ieQr3NY8ldZPhG3wf+Emps8oj+ytJASJmHXrm1lDkqaiLuVM0l+U4X9PFTe3MN
SRfVzEV5uDRAjDVihlbsz1RFM8bv9nKxdord8/0dRPSo3kb5V7fj2KxdsrUdThl/
W8+Cc0OXkwDBSHolF3ojlC98YrO7yBJoz7BlN4D7Z48KalVSLpU9AbcENwvpFeML
cOk2l1ToDJ+HUcbSHJESZw+afJdIh/qW2oCcc7BbqU+UF2l9ZHIN03v28L6O5BkC
bhC+tAaa2kxkK9F0APeVBTcqlwRaPIMSXpW0boEZOF8Dm51/oRmYu1b8kNEbd3sk
AheL/fyAXtubsPldV6CJSnTewx9l9X3IrsgTw+OryW/YOiTRYEY=
=Eu7f
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--

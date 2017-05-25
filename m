Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4PA7wq0023709
 for <selinux@tycho.nsa.gov>; Thu, 25 May 2017 06:07:58 -0400
Received: by mail-wm0-f51.google.com with SMTP id e127so97378804wmg.1
 for <selinux@tycho.nsa.gov>; Thu, 25 May 2017 03:07:53 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id y53sm3642015edd.14.2017.05.25.03.07.51
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 25 May 2017 03:07:51 -0700 (PDT)
Date: Thu, 25 May 2017 12:07:49 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Fedora COPR repositories with builds of latest code
Message-ID: <20170525100749.GE12190@julius.enp8s0.d30>
References: <b95f2f22-9280-2448-9fd2-cede379bff8d@redhat.com>
 <20170524143316.GD1910@julius.enp8s0.d30>
 <20170524145330.GE1910@julius.enp8s0.d30>
 <1495658455.3489.7.camel@tycho.nsa.gov>
 <20170525054450.GA12190@julius.enp8s0.d30>
 <915f219f-5975-bf6f-e151-c29c826e8c9e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3XA6nns4nE4KvaS/"
In-Reply-To: <915f219f-5975-bf6f-e151-c29c826e8c9e@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2017 at 11:40:49AM +0200, Petr Lautrbach wrote:
> On 05/25/2017 07:44 AM, Dominick Grift wrote:
> > On Wed, May 24, 2017 at 04:40:55PM -0400, Stephen Smalley wrote:
> > > On Wed, 2017-05-24 at 16:53 +0200, Dominick Grift wrote:
> > > > On Wed, May 24, 2017 at 04:33:16PM +0200, Dominick Grift wrote:
> > > > > On Wed, May 24, 2017 at 04:22:08PM +0200, Petr Lautrbach wrote:
> > > > > > For the motivation see
> > > > > > https://marc.info/?l=3Dselinux&m=3D149435307518336&w=3D2
> > > > >=20
> > > > > Thanks! I enabled the one with Fedora patches because i need
> > > > > python3 support for setools4
> > > > >=20
> > > > > This should allow me to enable extended_socket_class functionality
> > > > > and test it.
> > > > >=20
> > > > > I hope this repository will be maintained consistently so that it
> > > > > can be useful
> > > >=20
> > > > I just enabled the extended_socket_class capability and in seinfo --
> > > > polcap -x it currently shows up as "redhat1":
> > > >=20
> > > > # seinfo --polcap -x
> > > >=20
> > > > Polcap: 3
> > > >     policycap network_peer_controls;
> > > >     policycap open_perms;
> > > >     policycap redhat1;
> > > >=20
> > > > I know the redhat1 polcap is re-used but not sure if this expected =
to
> > > > return like that...
> > >=20
> > > Maybe setools4 hasn't been rebuilt to use the updated libsepol, or has
> > > its own internal table of the policy capability string names?
> >=20
> > thanks , yes thats the case (former)
>=20
> I will update scripts to rebuild setools together with selinux sources and
> provide setools builds in copr repos

Thank you
>=20
> >=20
> > >=20
> > > >=20
> > > > >=20
> > > > > >=20
> > > > > > I've restarted building of Fedora packages based on latest
> > > > > > SELinux userspace code in Fedora COPR. Packages are built using
> > > > > > the https://gitlab.com/bachradsusi/selinux-rpm project.
> > > > > >=20
> > > > > > There is a new selinux.spec [1] file which allows to build all
> > > > > > Fedora packages from one src.rpm and Makefile which makes the
> > > > > > process simple.
> > > > > >=20
> > > > > > Currently there are two COPR projects:
> > > > > >=20
> > > > > > * https://copr.fedorainfracloud.org/coprs/plautrba/selinux-fedo=
ra
> > > > > > /
> > > > > >=20
> > > > > > This is built with Python3 support based on Fedora patches which
> > > > > > are rebased against latest upstream code.
> > > > > >=20
> > > > > >=20
> > > > > > * https://copr.fedorainfracloud.org/coprs/plautrba/selinux-SELi=
nu
> > > > > > xProject/
> > > > > >=20
> > > > > > This is based on pure upstream sources and without Python 3.
> > > > > >=20
> > > > > >=20
> > > > > > Currently I run copr builds manually but the plan is to make it
> > > > > > fully automated.
> > > > > >=20
> > > > > >=20
> > > > > > Let me know if you find it useful or if you have ideas, comments
> > > > > > and so on.
> > > > > >=20
> > > > > >=20
> > > > > > [1] https://gitlab.com/bachradsusi/selinux-rpm/blob/master/seli=
nu
> > > > > > x.spec
> > > > > >=20
> > > > > >=20
> > > > > > Thanks,
> > > > > >=20
> > > > > > Petr
> > > > >=20
> > > > > --=20
> > > > > Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B
> > > > > 6B02
> > > > > https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1=
D2C7B6
> > > > > B02
> > > > > Dominick Grift
> > > >=20
> > > >=20
> > > >=20
> >=20
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkmrPEACgkQJXSOVTf5
R2nGBAv+OFPy+TPp1+/VBZf84lBsDTK2MCjE18mGdqKDEcLZ3SOStMNIVb6VFlaT
0U7Z3MaNkzg+KBp5ARvi107cZDUsW/aEcws+1PeHjoTO4GV6eOhT9jMRP1vTDXAn
T/cVb+sjQKW0BTOqhtOKBfFGTdYCEtzuMDqLScffhRIXzmTuXw+nmxjUMNeRlbPX
IZ3pTp6Za9CKEFljRVlN23ykcqqVNQKXkWGhVkBu1z/j2xpx4XtFwhKzWVjruHjZ
q5lxbbWIjyi6FvMh6wMjfN8OGWhLLQMMcpI8UbQL3ePDyRb0D4Bq9BGEl/GL/9Uk
c/z26fCBrnq1amrCpsGiE8JeiNrItvpPR8miOvS34ytW5h6WtWh7Jy4awNYsmZC2
y+6mCKQvlTh2kV88lwUWqjQTURHyMk9Uxk54DY6Sgy6I2VueRMQT7Sxyx332mIsO
vkmCfW5lY4/tr7o8SQjXJVMXCnhBY2IsMsObma/XSMV7KnUxxwbT9sW9FMExiXrx
jtLS1UcI
=+Ho8
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--

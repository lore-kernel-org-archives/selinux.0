Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4OErgDW004584
 for <selinux@tycho.nsa.gov>; Wed, 24 May 2017 10:53:42 -0400
Received: by mail-wm0-f52.google.com with SMTP id 7so66728593wmo.1
 for <selinux@tycho.nsa.gov>; Wed, 24 May 2017 07:53:35 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id s45sm1532630edb.64.2017.05.24.07.53.31
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 24 May 2017 07:53:32 -0700 (PDT)
Date: Wed, 24 May 2017 16:53:30 +0200
From: Dominick Grift <dac.override@gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Fedora COPR repositories with builds of latest code
Message-ID: <20170524145330.GE1910@julius.enp8s0.d30>
References: <b95f2f22-9280-2448-9fd2-cede379bff8d@redhat.com>
 <20170524143316.GD1910@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xA/XKXTdy9G3iaIz"
In-Reply-To: <20170524143316.GD1910@julius.enp8s0.d30>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--xA/XKXTdy9G3iaIz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2017 at 04:33:16PM +0200, Dominick Grift wrote:
> On Wed, May 24, 2017 at 04:22:08PM +0200, Petr Lautrbach wrote:
> > For the motivation see
> > https://marc.info/?l=3Dselinux&m=3D149435307518336&w=3D2
>=20
> Thanks! I enabled the one with Fedora patches because i need python3 supp=
ort for setools4
>=20
> This should allow me to enable extended_socket_class functionality and te=
st it.
>=20
> I hope this repository will be maintained consistently so that it can be =
useful

I just enabled the extended_socket_class capability and in seinfo --polcap =
-x it currently shows up as "redhat1":

# seinfo --polcap -x

Polcap: 3
   policycap network_peer_controls;
   policycap open_perms;
   policycap redhat1;

I know the redhat1 polcap is re-used but not sure if this expected to retur=
n like that...

>=20
> >=20
> > I've restarted building of Fedora packages based on latest
> > SELinux userspace code in Fedora COPR. Packages are built using
> > the https://gitlab.com/bachradsusi/selinux-rpm project.
> >=20
> > There is a new selinux.spec [1] file which allows to build all
> > Fedora packages from one src.rpm and Makefile which makes the
> > process simple.
> >=20
> > Currently there are two COPR projects:
> >=20
> > * https://copr.fedorainfracloud.org/coprs/plautrba/selinux-fedora/
> >=20
> > This is built with Python3 support based on Fedora patches which
> > are rebased against latest upstream code.
> >=20
> >=20
> > * https://copr.fedorainfracloud.org/coprs/plautrba/selinux-SELinuxProje=
ct/
> >=20
> > This is based on pure upstream sources and without Python 3.
> >=20
> >=20
> > Currently I run copr builds manually but the plan is to make it
> > fully automated.
> >=20
> >=20
> > Let me know if you find it useful or if you have ideas, comments and so=
 on.
> >=20
> >=20
> > [1] https://gitlab.com/bachradsusi/selinux-rpm/blob/master/selinux.spec
> >=20
> >=20
> > Thanks,
> >=20
> > Petr
>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--xA/XKXTdy9G3iaIz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlklnmYACgkQJXSOVTf5
R2l40wv+Oj1rQGwiMxJYQIbHz55e2FEWPJXyy9IulniCK192LKrmqvZI6vwfFiUD
MTJdcYpegSSCNSNlxUrWYvZg05h+kK5V3A5gZ125OGzvg3gNziOjeWaNUJ4Xsv43
moBLkfo6c4ZRmLu/PEJfUjhzgL2NVNjKnURLTQbgW81F6Zy9Gf5kmCzjgbtJQhTm
vGzIw/5KVqQYHcGWZGD4cZVkk3DuJ1zBXLGi6X+kHaZqbT1JLyoX+T8JmCADisdt
5b66eyny6HSvNyQ9DRneyckUFKWNbIltoVS9aik2xBu/oRgM6QIusP7iBHdV9YUy
xfTIalZMPWalweEWyydA4soPgjU5lECUbUqwP9GAGTW1VIzbs4czHJwM3Q0p/aKq
cwOGorMqQvoboPIQYQQJlsbKDm/8t/XfsJPbd7BMDugWDKojbB3/ZRuzlRTPrzKD
upP9u5It8/af/SKpvEldjcX0sNRZh9klA9V/I6ioWPGxM5u1gINT5H7k53xsodrz
ZeOVq/F3
=Zgbs
-----END PGP SIGNATURE-----

--xA/XKXTdy9G3iaIz--

Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4P5j1VS016596
 for <selinux@tycho.nsa.gov>; Thu, 25 May 2017 01:45:01 -0400
Received: by mail-wm0-f50.google.com with SMTP id b84so81103566wmh.0
 for <selinux@tycho.nsa.gov>; Wed, 24 May 2017 22:44:54 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id g24sm1601355edh.20.2017.05.24.22.44.51
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 24 May 2017 22:44:52 -0700 (PDT)
Date: Thu, 25 May 2017 07:44:50 +0200
From: Dominick Grift <dac.override@gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Fedora COPR repositories with builds of latest code
Message-ID: <20170525054450.GA12190@julius.enp8s0.d30>
References: <b95f2f22-9280-2448-9fd2-cede379bff8d@redhat.com>
 <20170524143316.GD1910@julius.enp8s0.d30>
 <20170524145330.GE1910@julius.enp8s0.d30>
 <1495658455.3489.7.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
In-Reply-To: <1495658455.3489.7.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2017 at 04:40:55PM -0400, Stephen Smalley wrote:
> On Wed, 2017-05-24 at 16:53 +0200, Dominick Grift wrote:
> > On Wed, May 24, 2017 at 04:33:16PM +0200, Dominick Grift wrote:
> > > On Wed, May 24, 2017 at 04:22:08PM +0200, Petr Lautrbach wrote:
> > > > For the motivation see
> > > > https://marc.info/?l=3Dselinux&m=3D149435307518336&w=3D2
> > >=20
> > > Thanks! I enabled the one with Fedora patches because i need
> > > python3 support for setools4
> > >=20
> > > This should allow me to enable extended_socket_class functionality
> > > and test it.
> > >=20
> > > I hope this repository will be maintained consistently so that it
> > > can be useful
> >=20
> > I just enabled the extended_socket_class capability and in seinfo --
> > polcap -x it currently shows up as "redhat1":
> >=20
> > # seinfo --polcap -x
> >=20
> > Polcap: 3
> > =A0=A0=A0policycap network_peer_controls;
> > =A0=A0=A0policycap open_perms;
> > =A0=A0=A0policycap redhat1;
> >=20
> > I know the redhat1 polcap is re-used but not sure if this expected to
> > return like that...
>=20
> Maybe setools4 hasn't been rebuilt to use the updated libsepol, or has
> its own internal table of the policy capability string names?

thanks , yes thats the case (former)

>=20
> >=20
> > >=20
> > > >=20
> > > > I've restarted building of Fedora packages based on latest
> > > > SELinux userspace code in Fedora COPR. Packages are built using
> > > > the https://gitlab.com/bachradsusi/selinux-rpm project.
> > > >=20
> > > > There is a new selinux.spec [1] file which allows to build all
> > > > Fedora packages from one src.rpm and Makefile which makes the
> > > > process simple.
> > > >=20
> > > > Currently there are two COPR projects:
> > > >=20
> > > > * https://copr.fedorainfracloud.org/coprs/plautrba/selinux-fedora
> > > > /
> > > >=20
> > > > This is built with Python3 support based on Fedora patches which
> > > > are rebased against latest upstream code.
> > > >=20
> > > >=20
> > > > * https://copr.fedorainfracloud.org/coprs/plautrba/selinux-SELinu
> > > > xProject/
> > > >=20
> > > > This is based on pure upstream sources and without Python 3.
> > > >=20
> > > >=20
> > > > Currently I run copr builds manually but the plan is to make it
> > > > fully automated.
> > > >=20
> > > >=20
> > > > Let me know if you find it useful or if you have ideas, comments
> > > > and so on.
> > > >=20
> > > >=20
> > > > [1] https://gitlab.com/bachradsusi/selinux-rpm/blob/master/selinu
> > > > x.spec
> > > >=20
> > > >=20
> > > > Thanks,
> > > >=20
> > > > Petr
> > >=20
> > > --=A0
> > > Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8=A0=A002D5 3B6C 5F1D 2C7B
> > > 6B02
> > > https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7=
B6
> > > B02
> > > Dominick Grift
> >=20
> >=20
> >=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkmb04ACgkQJXSOVTf5
R2mlEgv/aCuQ2V2OURLuhdZ8Uf3+CHT2kIB/+VM8UDhR2/xqzFZa3+YuEeJV6SDh
AkGuCQEq/bYH0948MU/hyZw3KWdaf7a0cmXCxrUdNBE1OcfmGYiuA6btEdCvGuaI
pF2ZYXf0hnjxMXnPL7DzeW6tZtR2tV27mL8QH+n0fTkk7MsH+ios8DT0soPSWKK8
hGCiP9bu6kNgMiqVSnB0H9VXacyDYkWSrfOmV9yvSwgCnMrOXFMhnijRXORZpV7e
/AjNU8wEssa0U+TF8EM4SgMkzE7c9dJSoTlAaiWKC1G53NbJ5+ET8M3E7RxTmFd0
H+h4CblxJpJ7QVRs+aP7Dmoi5JK2NxnsaPH4Oo1lzZ3gqEnR8UCuJ+JvAPU7r9iw
8wwu60z9dIpgfulYlzimE3XbWWpO2cv0RYNiBbIZoyortUzUXwzr6A044vZPVfyI
xUaBvVLMQPKIYPpahVOyBHQBmMPlc2ShbI7S4fME99Sy3I8VX2b54ZZWjjncZ6t+
nkYkjuL3
=ijHH
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--

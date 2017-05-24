Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4OEXXX4029558
 for <selinux@tycho.nsa.gov>; Wed, 24 May 2017 10:33:33 -0400
Received: by mail-wm0-f51.google.com with SMTP id 7so66186569wmo.1
 for <selinux@tycho.nsa.gov>; Wed, 24 May 2017 07:33:22 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id f38sm1085670edd.10.2017.05.24.07.33.18
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 24 May 2017 07:33:18 -0700 (PDT)
Date: Wed, 24 May 2017 16:33:16 +0200
From: Dominick Grift <dac.override@gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Fedora COPR repositories with builds of latest code
Message-ID: <20170524143316.GD1910@julius.enp8s0.d30>
References: <b95f2f22-9280-2448-9fd2-cede379bff8d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
In-Reply-To: <b95f2f22-9280-2448-9fd2-cede379bff8d@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2017 at 04:22:08PM +0200, Petr Lautrbach wrote:
> For the motivation see
> https://marc.info/?l=3Dselinux&m=3D149435307518336&w=3D2

Thanks! I enabled the one with Fedora patches because i need python3 suppor=
t for setools4

This should allow me to enable extended_socket_class functionality and test=
 it.

I hope this repository will be maintained consistently so that it can be us=
eful

>=20
> I've restarted building of Fedora packages based on latest
> SELinux userspace code in Fedora COPR. Packages are built using
> the https://gitlab.com/bachradsusi/selinux-rpm project.
>=20
> There is a new selinux.spec [1] file which allows to build all
> Fedora packages from one src.rpm and Makefile which makes the
> process simple.
>=20
> Currently there are two COPR projects:
>=20
> * https://copr.fedorainfracloud.org/coprs/plautrba/selinux-fedora/
>=20
> This is built with Python3 support based on Fedora patches which
> are rebased against latest upstream code.
>=20
>=20
> * https://copr.fedorainfracloud.org/coprs/plautrba/selinux-SELinuxProject/
>=20
> This is based on pure upstream sources and without Python 3.
>=20
>=20
> Currently I run copr builds manually but the plan is to make it
> fully automated.
>=20
>=20
> Let me know if you find it useful or if you have ideas, comments and so o=
n.
>=20
>=20
> [1] https://gitlab.com/bachradsusi/selinux-rpm/blob/master/selinux.spec
>=20
>=20
> Thanks,
>=20
> Petr

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlklmakACgkQJXSOVTf5
R2lIzgwAsbysWlopQvoSAEE66IXh/2Vb56HQNXOUuejfu2fOFLZSxvHFX9dpdk5e
Zg2DKPzOdqZk8/145n5hea96H0BMTRr0q76lvohAMx40SHcWxPErMuL6iCJ+vk0y
fxi6HsXukqxl5ebv9bmGDmlLbIpnYg7hcW8x/OYS94toTdoN31JADsCM83zk9I24
OK4fShUQqi/md5O2ubhew5TjYyeVqCipwCj7tQcqzBk1BNuvbbNhpOF4iRykRKXF
2McSNBYh4hUT67AoeeZ0J+9goL/oxaZGBURtbyKpPEQv1X6M4wXkDjsU4N72gYqr
DjbWBWT4Dpi3NiriCtDT2RweMtpM+FI7LDxMAfKkoZ1E+gJVJM9Gx95cjuWKensu
Z+7wPFea5sfBDvWltjWk0OYYn3Vt1N9DwMp74x3RunTs0/RTaJghAFDl8kn4UryH
/aNd40Zo/3w6Eest2qvwUO0EhXkpM8ZXqm6FNfEIFdxIRB/WxOMs/lG36x2pEvPf
L7d8bzJl
=eZ3f
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--

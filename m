Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0VLZbOi014855
 for <selinux@tycho.nsa.gov>; Wed, 31 Jan 2018 16:35:37 -0500
Received: by mail-wm0-f50.google.com with SMTP id f71so1922595wmf.0
 for <selinux@tycho.nsa.gov>; Wed, 31 Jan 2018 13:35:29 -0800 (PST)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id q11sm9549896edj.64.2018.01.31.13.35.26
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 31 Jan 2018 13:35:26 -0800 (PST)
Date: Wed, 31 Jan 2018 22:35:24 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20180131213524.GB4618@julius.enp8s0.d30>
References: <20180131205656.GA4618@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
In-Reply-To: <20180131205656.GA4618@julius.enp8s0.d30>
Subject: Re: CIL: should this work?
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2018 at 09:56:56PM +0100, Dominick Grift wrote:
> I have a template (blockabstract): foo.bar.template
>=20
> in another module i want to inherit that like this:
>=20
> (in foo
>     (block baz
>     (blockinherit bar.template)))
>=20
> This does not seem to work fully.

nvm i think my template is faulty

>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlpyNpgACgkQJXSOVTf5
R2nynAv8Dw1ypWTELtdHWI3+F8+eTkZI3KN75DC7eP/EU3kUDg7QTjky4TlAgPTM
VZ3I2Mm9ywghhzXc0ngwiVl3+7MhYH+6R8hS58thbAJcXfQJVy7riqEL+IlBI6Cl
jiiH81a4tDz+Chn56Guoc1x/c29ZaJF+wHb6Ny+RyO8XkTYB0o4OJLUCqmLGStor
vyZH65EHIsE799G22eQErppJJ5gsnLIIxsgqlmFBIOG29S+3HdxbzK72OSugDtl5
qI0OnLjGhgML3hWpBY6yAv4yIDIgQvT0uyseDrdftwPXvUoQ28NzOw6dNFdSWR5G
JY0UkA2VxgeMxhy2oPhbU6D9Gb7bv7GknqwF22CHZml6Z8r6/a/2KlNrEajdF7Ao
kW7k2pjWXjxhWfnsEobOrUj/EiJY7oroA7UnlVENDWqcF9WtiJX3YzvFF77kTtgh
366Ww75mU3YpEETARpZX+gPRfJMUqnYPr7o3cKf8+4xmnJy8p9U5eTbM3E2bwg5K
AvjDxDyW
=JOIF
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--

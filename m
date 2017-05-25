Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4P5nST1016714
 for <selinux@tycho.nsa.gov>; Thu, 25 May 2017 01:49:28 -0400
Received: by mail-wm0-f43.google.com with SMTP id e127so92445345wmg.1
 for <selinux@tycho.nsa.gov>; Wed, 24 May 2017 22:49:23 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id w15sm3256232edw.27.2017.05.24.22.49.21
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 24 May 2017 22:49:21 -0700 (PDT)
Date: Thu, 25 May 2017 07:49:19 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: ioctl help
Message-ID: <20170525054919.GB12190@julius.enp8s0.d30>
References: <20170524120854.GA1910@julius.enp8s0.d30>
 <1495656704.3489.4.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
In-Reply-To: <1495656704.3489.4.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2017 at 04:11:44PM -0400, Stephen Smalley wrote:
> On Wed, 2017-05-24 at 14:08 +0200, Dominick Grift wrote:
> > I was looking again at ioctl whitelisting, and excuse me if I
> > overlooked some documentation, but I am having a hard time
> > implementing this.
> > what I did was I just wanted to basically test blacklisting a single
> > ioctl (no particular one)
> >=20
> > So i looked into androids sepolicy and just picked a semi-random
> > ioctl from their "https://android.googlesource.com/platform/system/se
> > policy/+/master/public/ioctl_defines"
> >=20
> > for example: PHONE_CAPABILITIES_CHECK 0x40087182
> >=20
> > However the xpermissions statement only allows 0x0000 to 0xFFFF when
> > i tried: (xpermission alg_socket_ioctl (ioctl alg_socket (not
> > (0x40087182))))
> >=20
> > My question is how do i convert these to something i can use with the
> > xpermission statement in CIL, and why can seandroid sepolicy get away
> > with using 0x12345678 where i have to use 0x1234? I could not find
> > any scripts that converts these in the android tree.
>=20
> FWIW, I added a simple test of ioctl whitelisting to the selinux-
> testsuite, although that was done in source policy and depends on the
> binary module format support for xperms.
>=20
> With regard to your question though, only the low 16 bits of the ioctl
> value (the type/driver and number/function fields) are actually used;
> the upper 16 bits encode the direction (read/write) and size of any
> argument to the ioctl and are therefore not relevant for whitelisting.
> So you can just use 0x7182.  checkpolicy just ignores the upper bits,
> which I guess is convenient so that they can use ioctl macro lists
> generated from kernel header definitions, and Android builds by using
> checkpolicy -C to convert policy.conf to CIL.

Thanks. I considered that but then I thought I saw various different ioctls=
 with the same last 16 bits so that got me confused

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkmcFsACgkQJXSOVTf5
R2lxKgv/f1bcGwHMnnHzqMmpU0LQzgKQakwAdSaP/CpST85Wfgaajl033fsE/FSG
v+rGiXz0N6YM0iHT5l0OESHYED+EXoSK32VXpptaBNv5+XDP+nXrnHvQnW2jph5X
Pl0BEL2udFy5k0eP+HbeFlr6BMqxvrwW6QvQ7PR0Q9oXs/NJlMn340R+UJvVmRtX
L47RQ/nw26XGr+T4lyM1tjP6cdV6nML5kzAa26JRlXOP+/YwpLdBNO4Jna6T265z
NxFme+Kmmc7tmsJFd0LEfqwLiLzCe2IQUxT1s6zegmmS7xRNjfqff5tgAR4qAthj
r/+cgYjUgDxaffTRkJTsu3zSPujoPAu+KPOZa6zBzNqbFyTRhsX6tooopK9BQrlm
NSQNtHncrcqbeHBO5kF7/nYmNGmLYwvZDvT0ydmWbQjJl5wpWZrzqjKbjoe8RooL
XlFYJ/eUMcf1EBowB2wT6wtpM680+fpISaOO8Hrl7K0wOdeX6IIWuwI2zX6UTxS9
ai2jWVPH
=ecOy
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--

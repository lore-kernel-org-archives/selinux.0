Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4P9K4WH022321
 for <selinux@tycho.nsa.gov>; Thu, 25 May 2017 05:20:04 -0400
Received: by mail-wm0-f44.google.com with SMTP id e127so96375974wmg.1
 for <selinux@tycho.nsa.gov>; Thu, 25 May 2017 02:19:58 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id c12sm5678239eda.55.2017.05.25.02.19.55
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 25 May 2017 02:19:55 -0700 (PDT)
Date: Thu, 25 May 2017 11:19:54 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: ioctl help
Message-ID: <20170525091954.GD12190@julius.enp8s0.d30>
References: <20170524120854.GA1910@julius.enp8s0.d30>
 <1495656704.3489.4.camel@tycho.nsa.gov>
 <20170525054919.GB12190@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
In-Reply-To: <20170525054919.GB12190@julius.enp8s0.d30>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2017 at 07:49:19AM +0200, Dominick Grift wrote:
> On Wed, May 24, 2017 at 04:11:44PM -0400, Stephen Smalley wrote:
> > On Wed, 2017-05-24 at 14:08 +0200, Dominick Grift wrote:
> > > I was looking again at ioctl whitelisting, and excuse me if I
> > > overlooked some documentation, but I am having a hard time
> > > implementing this.
> > > what I did was I just wanted to basically test blacklisting a single
> > > ioctl (no particular one)
> > >=20
> > > So i looked into androids sepolicy and just picked a semi-random
> > > ioctl from their "https://android.googlesource.com/platform/system/se
> > > policy/+/master/public/ioctl_defines"
> > >=20
> > > for example: PHONE_CAPABILITIES_CHECK 0x40087182
> > >=20
> > > However the xpermissions statement only allows 0x0000 to 0xFFFF when
> > > i tried: (xpermission alg_socket_ioctl (ioctl alg_socket (not
> > > (0x40087182))))
> > >=20
> > > My question is how do i convert these to something i can use with the
> > > xpermission statement in CIL, and why can seandroid sepolicy get away
> > > with using 0x12345678 where i have to use 0x1234? I could not find
> > > any scripts that converts these in the android tree.
> >=20
> > FWIW, I added a simple test of ioctl whitelisting to the selinux-
> > testsuite, although that was done in source policy and depends on the
> > binary module format support for xperms.
> >=20
> > With regard to your question though, only the low 16 bits of the ioctl
> > value (the type/driver and number/function fields) are actually used;
> > the upper 16 bits encode the direction (read/write) and size of any
> > argument to the ioctl and are therefore not relevant for whitelisting.
> > So you can just use 0x7182.  checkpolicy just ignores the upper bits,
> > which I guess is convenient so that they can use ioctl macro lists
> > generated from kernel header definitions, and Android builds by using
> > checkpolicy -C to convert policy.conf to CIL.
>=20
> Thanks. I considered that but then I thought I saw various different ioct=
ls with the same last 16 bits so that got me confused

With the above in mind, how should i interpret the following

define(`CHIOEXCHANGE', `0x401c6302')
define(`CM_IOCSPTS', `0x40086302')

is "0x6203" CHIOEXCHANGE, is it CM_IOCSPTS, or are the two the same with ex=
ception of direction and/or size

>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkmobYACgkQJXSOVTf5
R2nGZQv+MXnIdZ0ikIOhyctIWI7jgPNqG25BEdStD0hJxGq4PLPQedEvyC9QP8JS
losG9uX+xAyuA/uNzrVQWmzmt6VuT3SAgXPWXJM1YflSdH94orYYGUz2fbB3oJmo
iWO5Sj06p8gaiftIoDo9mk5Tg1dYYWxp0gPilJCaI0PIr6pBZmml12ew8HnRL23J
Gp6OdhZKQKF7OkrCDVKlcv/wKDaNnCSYgV81IxXA41yMFg20LLB0OQ+ozQn16PNg
w1g0GCg+K0aOf2l617puVBCNU+GruNnJpTg4YjHq3H3Jsic1taI6Mgamz7jH8akF
p4Nn1TOUAnTIjYzbGDnNUckpPTN5cZZvEL5ASrLv15nBDWJHOCF1kGotqrFp+9ae
nWQm36gLHQIJpNuifakjXy4uuz8wpPZwmWe+bVMgKmjjM08VGrnBTaH3ULukBBVU
IVE6rmz4p6zqv4H3ss5m6GBNnk6qOr13pZv29E08ikdqgpffjN4JJK0TafjApUAL
Ly32s6wQ
=dVB+
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--

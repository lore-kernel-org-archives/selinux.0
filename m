Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4OC91Ml032566
 for <selinux@tycho.nsa.gov>; Wed, 24 May 2017 08:09:01 -0400
Received: by mail-lf0-f50.google.com with SMTP id a5so52708749lfh.2
 for <selinux@tycho.nsa.gov>; Wed, 24 May 2017 05:08:59 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id d38sm1083774edb.26.2017.05.24.05.08.55
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 24 May 2017 05:08:56 -0700 (PDT)
Date: Wed, 24 May 2017 14:08:54 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: ioctl help
Message-ID: <20170524120854.GA1910@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I was looking again at ioctl whitelisting, and excuse me if I overlooked so=
me documentation, but I am having a hard time implementing this.
what I did was I just wanted to basically test blacklisting a single ioctl =
(no particular one)

So i looked into androids sepolicy and just picked a semi-random ioctl from=
 their "https://android.googlesource.com/platform/system/sepolicy/+/master/=
public/ioctl_defines"

for example: PHONE_CAPABILITIES_CHECK 0x40087182

However the xpermissions statement only allows 0x0000 to 0xFFFF when i trie=
d: (xpermission alg_socket_ioctl (ioctl alg_socket (not (0x40087182))))

My question is how do i convert these to something i can use with the xperm=
ission statement in CIL, and why can seandroid sepolicy get away with using=
 0x12345678 where i have to use 0x1234? I could not find any scripts that c=
onverts these in the android tree.

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkld9IACgkQJXSOVTf5
R2kudwv9GRyl82xzTfHEHCOAQLfuZd9Q5VtR10zIHDaDEDrgw0crH2KSUXPHxv2z
yVN3Bs3h/D/Vue30uc/7UL68otgf7OO3IICpxUwPk9g9sCY2zz6SXLLnKxEk3z7L
eO1VqjFNDE0OZY2/Q3X3Yar/dSpQPo/CvvoTGNq4y1MxQ3xkK3+tR6Phu7ngP21r
af8vAhzYsRpY6SitmHppJ80nlN9lPAC6ghiX6xPbOiqIYWfTV5qsIJE76etn9Y7O
d5NpPEyBFMx+pmM6GGHEvusGuo2jWue26GQHi9VGwxA66VXZQK8f70ms5X+yZvDH
tqhbMMf87GYv9XeegwdQzKJs8EzzPNTVIiWzm1IFP/gvqrINsYa69Rm3ArOBscsv
DQLVr6VfbD9DPZ3ICWfTlXkTcXUpFhMq+JTRbU74ZcBzRn/6acjzBNhE5+32SIDv
/7/RGUk9TRgHfSr7Lt8/M7bw3odbYrMF/Ra2RFDOr8yf8s65FvRPXnUy00tbPtwV
glIdFSTg
=uBJB
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--

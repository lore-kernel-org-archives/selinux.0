Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v57Hc6hX010209
 for <selinux@tycho.nsa.gov>; Wed, 7 Jun 2017 13:38:06 -0400
Received: by mail-wm0-f41.google.com with SMTP id 7so123128438wmo.1
 for <selinux@tycho.nsa.gov>; Wed, 07 Jun 2017 10:37:50 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id w26sm1146556edw.28.2017.06.07.10.37.43
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 07 Jun 2017 10:37:44 -0700 (PDT)
Date: Wed, 7 Jun 2017 19:37:42 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: icmp and rawip socket
Message-ID: <20170607173742.GA739@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Was it intentional to add icmp_socket class? Because this use to be rawip_s=
ocket. rawip_socket includes more than just icmp (IGMP/OSPF) but still I th=
ought that the extended socket classes only applied to what is otherwise ge=
neric "socket"

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlk4OeIACgkQJXSOVTf5
R2kzSQv8D282MXVP6BWtYg80F6Zq8m8mmM2Eo/bLAblVQNcFUZjMKSSzGrG1c8m7
VNDZt8IxHiLvAxdlUDL+yHCUpyfMoo2XeWXgf2bX2LWQvjFXfbODb2UJjqT1NY7Z
+4YuyaRnRwY1S7qSnRoDcbbqDLyDk8aNdHqR15B1HtnbbmZhmOU0Z+MnN76sGOuC
N8b8fGzDO3PgxMJeYhmZSdwCBnxG9IqV1slgG3fKtN7OLsROCqaswCkCinw0YcMt
jrvzk5omXT4OjaErpyeegUJjk4NAnZ/EX4koZ8r9ewHH5ROy1NkXHmsuGX1ezaWw
RMM499gCbxAtU/iGnP1K9N5lyiKqt+pmspO8Ci5BginawAYUuDeddJp9Nj8kBcdF
kkTZKtK9CImFmMys7bi06nOYQn5cRAznu2f69z9eujV24+E08t6W1/yuSiNIIPQ8
Js0PzCr0lHrlNaB9q2HfKwm3SdYfBylnR2LpFHktaZKhMayRaNJywzEkJ62InGpx
d059JIam
=Y0Iw
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--

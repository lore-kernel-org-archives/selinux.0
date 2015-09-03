Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t839mnJx032138
 for <selinux@tycho.nsa.gov>; Thu, 3 Sep 2015 05:48:49 -0400
Received: by wicge5 with SMTP id ge5so67553762wic.0
 for <selinux@tycho.nsa.gov>; Thu, 03 Sep 2015 02:48:46 -0700 (PDT)
Received: from x250 (84-245-28-90.dsl.cambrium.nl. [84.245.28.90])
 by smtp.gmail.com with ESMTPSA id ne7sm8069404wic.12.2015.09.03.02.48.46
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Thu, 03 Sep 2015 02:48:46 -0700 (PDT)
Date: Thu, 3 Sep 2015 11:48:44 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: secilc: in segfault
Message-ID: <20150903094844.GA18832@x250>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Anyone tried "secilc test/in_test.cil" lately? It dumps core here.

$ secilc test/in_test.cil
Segmentation fault (core dumped)

--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJV6Bd4AAoJENAR6kfG5xmcbUYL/0RSgITQv2T2I2USu66gBNRv
DvMLclfxrp/YwN4g05K0fmBCgJWoBCRttcG4kRJDmlnBGbhXR1+2sngsrd2XlqgW
OT5NbkdG6ucEJqeNm6RDkLwnxDe5vYIcjE+fAwBiXi83qwSpAaaBIFdOCwXsUPgW
mK210As9iPjn+r6M9OjElduGNQIxjhD/lMTmonoKG1R1Yy6ajHutZQqycd3SS6yM
abg1h8oGYZrUxncC2FPL8fkRRbJa6JwQmf7Ig4+XPE1trbxs+cne+a6jKpsxdBB2
OdxtBJHbB4HU3k5nc4vvY9OJ8nm7/YVPs5hfKTSogyspmYlfn/1Es+E/tSwP4flt
Q9EySEC8LDic9Q3h0Yttwli3PvPS9rBAR2qnTcvuRr4EZGanXAC8cLaxBczpOrPP
FbyqB3DDBxsE+R9tTM9Yc+jeUvFShUA6fvuLGSA9weFoQj4hD5s2gCxSaMnYNRsf
TwabRhPBAiL9yUjKd+pnC25jZt5R3/mng2lTR5maKQ==
=WhN+
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--

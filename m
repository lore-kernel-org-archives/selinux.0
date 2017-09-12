Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8CDpj69020131
 for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2017 09:51:45 -0400
Received: by mail-wm0-f45.google.com with SMTP id 189so16270148wmh.1
 for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2017 06:38:42 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id l50sm548119eda.80.2017.09.12.06.38.36
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Sep 2017 06:38:37 -0700 (PDT)
Date: Tue, 12 Sep 2017 15:38:35 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20170912133835.GA5111@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Subject: with extended_socket_class should be still be seeing
 "socket"?
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have extended socket class polcap enabled but i am still seeing "socket" =
class events and i was wondering whether that is to be expected?

avc:  denied  { create } for  pid=3D10484 comm=3D"nethogs" scontext=3Dwheel=
=2Eid:sysadm.role:nethogs.subj:s0 tcontext=3Dwheel.id:sysadm.role:nethogs.s=
ubj:s0 tclass=3Dsocket permissive=3D0

This seems to be common to processes that also create (and map! [1]) "packe=
t_socket" sockets (tcpdump/nethogs)

[1] avc:  denied  { map } for  pid=3D10525 comm=3D"nethogs" path=3D"socket:=
[56040]" dev=3D"sockfs" ino=3D56040 scontext=3Dwheel.id:sysadm.role:nethogs=
=2Esubj:s0 tcontext=3Dwheel.id:sysadm.role:nethogs.subj:s0 tclass=3Dpacket_=
socket permissive=3D0

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlm341cACgkQJXSOVTf5
R2nWRQv/eBL7VcxsSv1+u7ml3QEDl1Wd+XmTdwZkcmRBMSg1SwE6Hyis/P/l5JAC
v1D/lByVVAyrOTMZoagd8Z9U0FNo5EJ8e+PW69NeprM9N0gw1Z9S/6M1PIg+gs5r
Rra9nCfkH8glLmuwIjvrAp5r5lMLRb93PjvVPkDRmArBshgLh3AXcRTj11kHGBjO
t9Hm/SjzKPj1nQ4ggcPZTqw2Fj272M0sXOYF+VsKsyJmCnkTh1i8q5EhFj7tnl6q
dZQ4tmpYkoV03VydS3u6Hvd+ss9AumEdNsF/Kl3EZNf+HPoGzHq+tY24hvssof4C
Os6R54hRxXTTMd1HvOcr02Tuagjnvk2RZS7zDpH6CDXFQKr+xnOK1VTNZ8d50/fc
e0z17m/z19vj1jzKwlyw6wPTVw6yjmyCzk/eOLRnwebGAY24V3SrvkxLhS9mVIRt
SF0g/DEvhTbgjexf75R003lG8gHPqfH/tlfrSfbkHhJsKDxntvKPo2XYUI67DDC4
umgGBb2O
=+8Ng
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--

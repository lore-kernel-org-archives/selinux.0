Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1S9RF84004814
 for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2018 04:27:15 -0500
Received: by mail-wm0-f42.google.com with SMTP id z81so3585139wmb.4
 for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2018 01:27:12 -0800 (PST)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id q6sm1397179edb.60.2018.02.28.01.27.10
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 28 Feb 2018 01:27:10 -0800 (PST)
Date: Wed, 28 Feb 2018 10:27:08 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20180228092708.GA28719@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Subject: Linux 4.16 cap_sys_module
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Since Linux 4.16 (to atleast RC2) user space started to excessively trigger=
 cap_sys_module

Here is one example of such and event:

type=3DSYSCALL msg=3Daudit(02/27/2018 08:06:40.017:74) : arch=3Dx86_64 sysc=
all=3Dioctl success=3Dno exit=3DENOTTY(Inappropriate ioctl for device) a0=
=3D0x2 a1=3DTCGETS a2=3D0x7fff2d89f8f0 a3=3D0x55ba203a9010 items=3D0 ppid=
=3D1 pid=3D423 auid=3Dunset uid=3Droot gid=3Droot euid=3Droot suid=3Droot f=
suid=3Droot egid=3Droot sgid=3Droot fsgid=3Droot tty=3D(none) ses=3Dunset c=
omm=3Dsystemd-user-se exe=3D/usr/lib/systemd/systemd-user-sessions subj=3Ds=
ys.id:sys.role:user_sessions.subj:s0 key=3D(null)
type=3DAVC msg=3Daudit(02/27/2018 08:06:40.017:74) : avc:  denied  { sys_mo=
dule } for  pid=3D423 comm=3Dsystemd-user-se capability=3Dsys_module  scont=
ext=3Dsys.id:sys.role:user_sessions.subj:s0 tcontext=3Dsys.id:sys.role:user=
_sessions.subj:s0 tclass=3Dcapability permissive=3D1
type=3DAVC msg=3Daudit(02/27/2018 08:06:40.017:74) : avc:  denied  { module=
_request } for  pid=3D423 comm=3Dsystemd-user-se kmod=3D6E65746465762D80E72=
A05257F scontext=3Dsys.id:sys.role:user_sessions.subj:s0 tcontext=3Dsys.id:=
sys.role:sys.isid:s0 tclass=3Dsystem permissive=3D1

Any idea what causes this and how to fix it?

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlqWdegACgkQJXSOVTf5
R2lAsAv+LxAyMnlewtct6UIrP4yFIjdvWiL+tBDndbv3km/zSCckfrUoyc6Kj6vx
MwfZMJgZph+k9Fxzc4yOE3ups6D2K7BuSiztc9hoQN26MRmmRmleBu8upcWJ5xmd
+2DV2t9ekJmqIY/3TohYi1kmOru9lHwZP0P/uNVdkhdHqhSgO1fi0Dfy1wyBCWNd
+3wO4t46B2PjvN6pRwgasDXFBoO1us9ukNdqyWq4jzFpTrDQ3KnDqYaT4c7oImzm
a8HmJBv+gzBDhCP3E3HkFe5zcp3YXu7OHvIm3Hwom7RZ12lQQ8Tlb2LBrx/aX3v5
9LtJJRu83jn+9fJ3HwikWx56siU4lYXEOJ/x/5zLA/SdUsQLlJOzP7wyZlZMREqp
h04C1yaUpjZTymfSd4H2LWABUkBzuA5HmyWoCSVqq7JAKJBSnzKfe1xQlDG2MMDb
5I3hElHBQ/Obrh0gTlBWWjYl+YwGyIq7OSD8a2UbR/Qx9921cPun/Iep7AaGbNnv
W9VgpGFz
=zTYK
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

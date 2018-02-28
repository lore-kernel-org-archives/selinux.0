Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1S9rOjD013094
 for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2018 04:53:24 -0500
Received: by mail-wm0-f44.google.com with SMTP id x7so3827878wmc.0
 for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2018 01:53:20 -0800 (PST)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id w41sm1545019edd.32.2018.02.28.01.53.18
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 28 Feb 2018 01:53:18 -0800 (PST)
Date: Wed, 28 Feb 2018 10:53:17 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20180228095317.GB28719@julius.enp8s0.d30>
References: <20180228092708.GA28719@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
In-Reply-To: <20180228092708.GA28719@julius.enp8s0.d30>
Subject: Re: Linux 4.16 cap_sys_module
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2018 at 10:27:08AM +0100, Dominick Grift wrote:
> Since Linux 4.16 (to atleast RC2) user space started to excessively trigg=
er cap_sys_module
>=20
> Here is one example of such and event:
>=20
> type=3DSYSCALL msg=3Daudit(02/27/2018 08:06:40.017:74) : arch=3Dx86_64 sy=
scall=3Dioctl success=3Dno exit=3DENOTTY(Inappropriate ioctl for device) a0=
=3D0x2 a1=3DTCGETS a2=3D0x7fff2d89f8f0 a3=3D0x55ba203a9010 items=3D0 ppid=
=3D1 pid=3D423 auid=3Dunset uid=3Droot gid=3Droot euid=3Droot suid=3Droot f=
suid=3Droot egid=3Droot sgid=3Droot fsgid=3Droot tty=3D(none) ses=3Dunset c=
omm=3Dsystemd-user-se exe=3D/usr/lib/systemd/systemd-user-sessions subj=3Ds=
ys.id:sys.role:user_sessions.subj:s0 key=3D(null)
> type=3DAVC msg=3Daudit(02/27/2018 08:06:40.017:74) : avc:  denied  { sys_=
module } for  pid=3D423 comm=3Dsystemd-user-se capability=3Dsys_module  sco=
ntext=3Dsys.id:sys.role:user_sessions.subj:s0 tcontext=3Dsys.id:sys.role:us=
er_sessions.subj:s0 tclass=3Dcapability permissive=3D1
> type=3DAVC msg=3Daudit(02/27/2018 08:06:40.017:74) : avc:  denied  { modu=
le_request } for  pid=3D423 comm=3Dsystemd-user-se kmod=3D6E65746465762D80E=
72A05257F scontext=3Dsys.id:sys.role:user_sessions.subj:s0 tcontext=3Dsys.i=
d:sys.role:sys.isid:s0 tclass=3Dsystem permissive=3D1
>=20
> Any idea what causes this and how to fix it?

For reference: https://github.com/fedora-selinux/selinux-policy/commit/2c13=
be1fb543c51935785e7a43b798a9f35f5aa0#comments

>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlqWfAkACgkQJXSOVTf5
R2nN7Qv7BIGqPmVB7mh18Ezpra6MQXzE7DxMqmNWONozEb54h515z4Uy+ZMKlQad
PF03UpU6iGXcYjXRkUz4ghoevfWW+9w27lmwgJM6GB1zZz9QdDOFxCl/pL4hKQii
Eri4ydopCTvSltgA2MT09s1fd8s1KztZ3E/eTCtz03+1SUCtaZNvxmdCinIcnlFo
nmpllKm8t3rMHq8EPYv+4U7MRMKIPnsPcZQLIQgSsVY41+ZCJF+J5jY5KuC14aat
6vwjZGpmOYiDaLp0T9a8k/W8V3mUsPmYmp9RNGnCAvdix1IdKfz8TMgB5n67VTgT
k4l6M8+S5BTFlCJlUIXZfMTlkxOrz6oYRLbm5LNDfhIiua+FBtgoFmFj0sITata+
TY3L0t+ahcTI+63ZP2KB0ZTQgn6Vfv10Pj5ithtqycisWBLN3QbFDZxFNk9KuJZP
67iSnM9C+ARv5nn40v9LVmwEn9dpYPx7IYnPaAM0zb0Qx5QP3b1z8GFR+qzXx5pn
uCcA0ArU
=Wxsn
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--

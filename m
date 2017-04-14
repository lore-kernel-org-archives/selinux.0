Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3EEw5u8014720
 for <selinux@tycho.nsa.gov>; Fri, 14 Apr 2017 10:58:05 -0400
Received: by mail-wm0-f54.google.com with SMTP id u2so66445665wmu.0
 for <selinux@tycho.nsa.gov>; Fri, 14 Apr 2017 07:58:03 -0700 (PDT)
Received: from markus (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id 33sm2674354wrd.40.2017.04.14.07.58.01
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 14 Apr 2017 07:58:01 -0700 (PDT)
Date: Fri, 14 Apr 2017 16:57:59 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: let's revert e3cab998b48ab293a9962faf9779d70ca339c65d
Message-ID: <20170414145759.GA7980@markus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Bear with me please, because i might not fully grasp the issue (i received =
help with diagnosing this issue):

This commit causes issues (and is, i think, a lousy hack): e3cab998b48ab293=
a9962faf9779d70ca339c65d

The commit causes entities to "think" that SELinux is disabled after "mount=
 -o remount,ro /sys/fs/selinux

It is "neat" to be able to make processes "think" that selinux is disabled =
on a selinux enabled system but not if it break anything

The above results in the following:

Systemd services that have ProtectKernelTunables=3Dyes set in their respect=
ive service units, think that SELinux is disabled.

However we have found that some of these services actually rely on SELinux =
to ensure proper labeling.

So we have the option to make people aware that if you set ProtectKernelTun=
ables=3Dyes that then the process cannot be SELinux-aware properly, or we c=
an just get rid of the commit above and just accept that process know that =
SELinux is enabled.

Actual bug that caused me to look into this: systemd-localed selinux awaren=
ess is broken due it having ProtectKernelTunables=3Dyes in its service unit


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAljw43MACgkQJXSOVTf5
R2naPwv/Zwe1UcyX/9NwFRQknhjwW7SVSpJ1rEEC3gyddyVaxz9GY0Aaxn9UTtvk
4cMJaQ43mo2gboORKrTYBeenYZRlWAFQPoVgSB/Gz9+Ab1miBGea2+V54XRnbC/x
ooxVwju8mmZUvL5k9+t+Ti/MWc2dpX7jMb+tx/R7juLfqOQ2m6kTmHMmnNYj0F7V
5+I7hX1QtGUn/cLlhO0mwoO5JXPmE6SVOUp7AX3mfGDVYz9Ugiy0ieR5kLOskrL8
ndleJ0X7rU4n5LlMupkwsqj3IWPyXhUk3CHMuIacPb6MM4twdooxECrl0CSJTXdl
BLCoSojXO1vrhXxCof6LRIAT7KT5lhqQv2NJ5Y1BBRFMCYK2EdfMtWB/xnQYnp5f
bgPZKaH76n143UbRAUIzx6uYLjyH/LRQf3ZQJ6nk/bsHaXEI9bhxJumrLNqzlAEY
7pHj8/EIINPL8hLfjI8wZwulDMg0tU0D4c7mN/94KcUyGyADy6DGi6IhH2REZ8pT
Bf6bxypC
=4BLL
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--

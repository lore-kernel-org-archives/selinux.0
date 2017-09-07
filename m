Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8795lug001102
 for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2017 05:05:48 -0400
Received: by mail-wr0-f169.google.com with SMTP id k20so9188387wre.4
 for <selinux@tycho.nsa.gov>; Thu, 07 Sep 2017 02:05:41 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id j5sm2041549edd.54.2017.09.07.02.05.36
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Sep 2017 02:05:36 -0700 (PDT)
Date: Thu, 7 Sep 2017 11:05:34 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20170907090534.GA1813@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Subject: pam_selinux and systemd
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

pam_selinux requirements are generally pretty simple: its used to associate=
 a context with a login shell.

With systemd things have becomes a bit more complicated.

systemd uses pam_selinux to associate a context with both a login shell (vi=
a container-shell@.service) as well as with a systemd --user instance.

Ideally one would not associate a login shell context with a systemd --user=
 instance because a systemd --user instance needs permissions that do not m=
ake sense for a login shell to have.

I am not aware of any way to make pam_selinux associate a context based on =
variable like for example: if its a login shell then associate this context=
 , and if its a systemd --user instance then associate that context

This is an issue for me currently because if users are allowed to "host-she=
ll" (machinectl shell .host) then they are able to open a shell with the co=
ntext of the systemd --user instance and escape their shell restrictions

For now I can just block host-shell access with polkit but I am trying to f=
igure out what it would take to address this challenge with pam_selinux

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlmxC9sACgkQJXSOVTf5
R2nAJAv/QwpTWDAKeQzrzXiOwH6EW0DQlUfxjc6vN9D6gwiY/wjFmF2pZuhXOtPD
q0p0rWkp9qSIb/DvpAq8gmzamsZf5Ul9EZVD7woW7TT6Tq8bg5mwkUuoHy2MLkhk
u7qmbzX/a6Kh0cILclLTmvsy5f/ZkvLZkIOCnIq9KsMXsualJ+A0bFlJGBXilMoa
54eGdMoZQ7lsbUtIqo6aJyeYr0NbXEhGZ49zHYpueqbGREwensYq0GeNLdCfSBXf
Ef+X292b60QIqu70ZroJCNp8nBw3F8HA3ARGcWu4FSeq/6pKRe6Qd7P4nZIn1nT4
8ErpG8krt1lIiq/jB5L0QLpwus0yMqcCqn1E7fkfaoD99V6FlvBPVUKwR1vh7OqH
z7McArWoVDkDJINLRD/hbhNkvc+M7QW/Wbg0PxqZ4N0i8XQ3UYvtaF8qROnEJDaI
ezFx+gci2GPpsHHaVEYY4PswiXPKC93v4LzGfj6qLKQrYSmFpi727/tFGqdT49vk
YeCkEdo7
=jTw0
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--

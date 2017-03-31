Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2VC9VRU021052
 for <selinux@tycho.nsa.gov>; Fri, 31 Mar 2017 08:09:31 -0400
Received: by mail-wr0-f181.google.com with SMTP id w43so102939081wrb.0
 for <selinux@tycho.nsa.gov>; Fri, 31 Mar 2017 05:09:10 -0700 (PDT)
Received: from t450.enp8s0.d30 (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id
 g13sm2657715wmd.28.2017.03.31.05.09.07 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 31 Mar 2017 05:09:07 -0700 (PDT)
Date: Fri, 31 Mar 2017 14:09:05 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: userspace object manager confused
Message-ID: <20170331120905.GA5699@t450.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I vaguely recall that we discussed this issue or at least that i mentioned =
it here but i can't recall the outcome if any:

So today on my rawhide system i noticed that i somehow forgot to add suppor=
t for the smc_socket class (i suspect that is part of the extended socket c=
lass patches)

I added the class (which i suppose is unordered like the othe extended sock=
et classes) but as soon as I loaded up the policy with the new unordered sm=
c_socket class the system became unusable.

This is because the dbus object manager became confused due to my adding a =
new (unordered) class at runtime, and that the dbus class was no longer wor=
king.

Modern systems heavily rely on dbus at the heart and so it is undesire-able=
 that this happens.

A reboot clears this issue up but adding (unordered) classes at runtime sho=
uld not cause these issues i suspect

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAljeRt0ACgkQJXSOVTf5
R2nodwwAtoI3a5Vruy0rrM2RE/eyeJMnE1K/UW43kED7Vqaps1C45EZXrwkm8EM0
fS6UdIIBlK1ADpjrVo8y+3dqU046C45q0Vczv+pEzw8hQe3V84vd9GqrcrZH9Lsb
eXhxTdcaiy315AGg7BdSpZ0OPv7+qw/WGu1tQ4YR6Q7JKvQrgkba7UyqOdUKxpAL
kmF103Sfv4JiDZao0BiSzGPYpOqxfW3AUdUQvKR1rgcrWmvoVYMFbn0vpbd3t1jL
HW//eEqoj0DSxQ3U/S9nJm7XkYyaZFuBGmdKDwdNTpGBOMmkUsEYRwtdu2mc6swL
L84C4wwqugWPF/yJbcc+oYgW82w6gwykBqF+8lmOLh5erPXXkFfV+HZXcqK+Xsjv
7OoINvmZcoHySAv4LYwKej42d+0iVGwHOnaE4LF3pGCedk1Nw1XDNR3WeKVubPIn
Vic4RNwiQEYLkJJy7jFgkHGeTZylN8RAaLwGwQIA92jvqD7r84RXfev6RFeDMSd0
LDvmiPfx
=ZQ8N
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--

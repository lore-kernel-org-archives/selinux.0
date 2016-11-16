Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAGHxpMA005305
 for <selinux@tycho.nsa.gov>; Wed, 16 Nov 2016 12:59:53 -0500
Received: by mail-wm0-f47.google.com with SMTP id g23so255919911wme.1
 for <selinux@tycho.nsa.gov>; Wed, 16 Nov 2016 09:59:48 -0800 (PST)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id c202sm13107001wme.1.2016.11.16.09.59.46
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Nov 2016 09:59:46 -0800 (PST)
To: selinux@tycho.nsa.gov
From: Dominick Grift <dac.override@gmail.com>
Subject: what is the purpose of security initial sid?
Message-ID: <61dffb53-5ce0-bde4-9c3e-d40f8eda5efb@gmail.com>
Date: Wed, 16 Nov 2016 18:59:36 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fESKEUCIcl8lGmLUWgrmtF67Ejc10xQr8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fESKEUCIcl8lGmLUWgrmtF67Ejc10xQr8
Content-Type: multipart/mixed; boundary="QMbPJPobHBDr84Boncm1oA5Jp4PQVKCq1";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <61dffb53-5ce0-bde4-9c3e-d40f8eda5efb@gmail.com>
Subject: what is the purpose of security initial sid?

--QMbPJPobHBDr84Boncm1oA5Jp4PQVKCq1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


I forgot that add the genfscon's for selinuxfs and securityfs and the
selinux filesystem ended up associated with the context associated with
the unlabeled initial sid.

Why did the security initial sid not kick in instead of unlabeled?

If the security isid is not there to ensure selinuxfs is labeled
appropriately then what is it there for?

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--QMbPJPobHBDr84Boncm1oA5Jp4PQVKCq1--

--fESKEUCIcl8lGmLUWgrmtF67Ejc10xQr8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYLJ6NAAoJECV0jlU3+UdpuboL+wYyZJbB4Wh8eJ7NqNrPxPpB
K3M6Nn6XzN0YORk7m7az9Y69dVymVLpG40PvEiStrgDjuYg1swpGZeM2uGm1aFt0
SJpaSEbHhX6BuOWOCX14lMu4SqKEF9apdGSFvE2yM9XejZ4c8a1jjldT3sh5W9Hh
zAQvS8Ta2Yx7nWt1dTR2s/KJa7s66v03U4RzjUhA4h3EVohy1quJKePfDRrpwho9
8V72JYZZyh/RkuEmgyLpkTAZLznAINBFFRb6/U/RHCV/8MTlEB4Q10YeQY4pokMy
HwrBIBGScbAsLd6XKzcaFk/bBTCxWZSMj53bnLsZgXYwz4qlUzcAie8glqVqmx1s
XTv/UCwVy+GHN4Ji2HhL98sE+4knC80L/OCK84owFMOHsgBYjJajNzJqXbOSXLMx
sFgCStC0BvVbk53kXP6471A51jw+wTxssr5JV6jG7Xr2DHfwWXb79FNDmAB1BUca
CaUnFgKTzJe3KbrceSPyzHZI0TEiT2vGm6sTQfhZFQ==
=Nr/g
-----END PGP SIGNATURE-----

--fESKEUCIcl8lGmLUWgrmtF67Ejc10xQr8--

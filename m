Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAFCKDdg010318
 for <selinux@tycho.nsa.gov>; Tue, 15 Nov 2016 07:20:13 -0500
Received: by mail-wm0-f65.google.com with SMTP id a20so25320915wme.2
 for <selinux@tycho.nsa.gov>; Tue, 15 Nov 2016 04:20:09 -0800 (PST)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id m145sm4002823wma.3.2016.11.15.04.20.07
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Nov 2016 04:20:07 -0800 (PST)
To: selinux@tycho.nsa.gov
From: Dominick Grift <dac.override@gmail.com>
Subject: load_policy fails to load policy with ENOENT
Message-ID: <ea84ceb6-d481-9ba2-8649-638f9c6690e6@gmail.com>
Date: Tue, 15 Nov 2016 13:19:57 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="B3iWwx5KdGBhc54UvVjIjIGfb8MXaWalV"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B3iWwx5KdGBhc54UvVjIjIGfb8MXaWalV
Content-Type: multipart/mixed; boundary="oJS4FcLxUwRCdcimxgkjodh2s9uBPkRTn";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <ea84ceb6-d481-9ba2-8649-638f9c6690e6@gmail.com>
Subject: load_policy fails to load policy with ENOENT

--oJS4FcLxUwRCdcimxgkjodh2s9uBPkRTn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I finished porting dssp-base to dssp1-base, however when i try testing
it load_policy fails with ENOENT.

Even though load_policy returns error status the policy seems to be
loaded, except that it is not (or so it seems). When i reboot the system
freezes for whatever reason. Whether it is due to systemd refusing due
to load_policy failure or anything else i am not sure.

I have double checked the policy.

1. secilc has no problems with it
2. the initial sids are declared and ordered
3. the classes are there (and the linux classes are ordered)

I cannot think of anything that might cause this and i am looking for
suggestions.

It is easy to reproduce:

1. git clone https://github.com/DefenSec/dssp1-base.git
2. cd dssp1-base
3. secilc `ls *.cil`
4. seinfo policy.30
5. mv /etc/selinux/targeted/policy/policy.30
/etc/selinux/targeted/policy/policy.30.ori
6. cp policy.30 /etc/selinux/targeted/policy/
7. setenforce 0
8. load_policy
9. sestatus, seinfo, ps uaxZ

I have also uploaded a demo:

https://youtu.be/8NCME9dLZd4

Suggestions and help are appreciated

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--oJS4FcLxUwRCdcimxgkjodh2s9uBPkRTn--

--B3iWwx5KdGBhc54UvVjIjIGfb8MXaWalV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYKv1yAAoJECV0jlU3+Udps5oMAKsDttUdzFmkw7S0jxuk4UJ/
OYnER5hTXhHtFo49lZ7qxLQ5hcKLsFl67tk8SVsvCH8oo8MgYWzz5EMMviceIbDb
RTUT5BIYOFzY2AnQFVElKDk39snasrgEvm9jlCwehRRNln09YP5xv8Gq7Tig4V7j
AY+HpdYvdug68xQ1gWoGzBSW2ShafNKhS5sOYRK5WJvaXTN9EBw2aM/Ft1JvHSAr
Ed56y11+AhK0cghhIVevTyckUXYM+0BSQfZfDW2z3S7FryiQkq0JT7FprGPDotEi
KEG4XbYOc1nHlom0tYB2cHcs1njtYNEObdhz0N5Cpf1wyFhqv2Dzs+OIHBfw16/Z
HDEcpng1plVXB5FngpVeN5xlZcQZc24h88nluQ7xTvz6w1jezA6EfNqBPUctB7yY
fwwK8pMtTXYP4QhQB9SS8BYSYZX+O7vbFPUAV/X5UBT7TJaPtropXfloQPVP0AiZ
Rz/ATT3BmI+fCtFRtEOmLZHh7OTAqDrmlzUCOh6oDA==
=yr4Z
-----END PGP SIGNATURE-----

--B3iWwx5KdGBhc54UvVjIjIGfb8MXaWalV--

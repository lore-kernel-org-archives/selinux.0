Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA9CeGrJ020390
 for <selinux@tycho.nsa.gov>; Wed, 9 Nov 2016 07:40:16 -0500
Received: by mail-wm0-f65.google.com with SMTP id u144so28976086wmu.0
 for <selinux@tycho.nsa.gov>; Wed, 09 Nov 2016 04:40:12 -0800 (PST)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id bj1sm21261628wjc.17.2016.11.09.04.40.10
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Nov 2016 04:40:11 -0800 (PST)
To: selinux@tycho.nsa.gov
From: Dominick Grift <dac.override@gmail.com>
Subject: [SECILC] does not seem to filter redundant attributes and rules
Message-ID: <a1c00b1d-c5fd-981e-489a-591f3bff3407@gmail.com>
Date: Wed, 9 Nov 2016 13:40:00 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Tn9aMe8OdL2QnPTWt6H4CF0VgMl70Ib2d"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Tn9aMe8OdL2QnPTWt6H4CF0VgMl70Ib2d
Content-Type: multipart/mixed; boundary="Oljf4OfJsNqj3A0tu0d1QauWHVfdfFV9l";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <a1c00b1d-c5fd-981e-489a-591f3bff3407@gmail.com>
Subject: [SECILC] does not seem to filter redundant attributes and rules

--Oljf4OfJsNqj3A0tu0d1QauWHVfdfFV9l
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I am in the process of a DSSP rewrite, taking a different approach this
time.

However I encountered something that seems suboptimal:

SECILC seems to not filter redundant attributes and rules

Example i have a type attribute and it has rules associated with it.
However, the type attribute is not associated with any types.

I was hoping that SECILC would be smart enough to determine that it
might as well filter both the type attribute as well as the rules
associated with it.

To reproduce:

git clone https://github.com/DefenSec/dssp1-base.git
cd dssp1-base
secilc `ls *.cil`
sesearch -ASCT -s lib.ld_so.read_files_subj_type_attribute policy.30
seinfo -xalib.ld_so.read_files_subj_type_attribute policy.30


Am i expecting the impossible by expecting SECILC to be smart enough to
determine that something is redundant, and that it can be filtered out
until it becomes applicable?

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--Oljf4OfJsNqj3A0tu0d1QauWHVfdfFV9l--

--Tn9aMe8OdL2QnPTWt6H4CF0VgMl70Ib2d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYIxklAAoJECV0jlU3+UdpXQoL/jj1OXvO9bWaph3XYDKVBB7k
qB6LpzgQiYMUjOLgXS0Iw2UhsjdoEYu2lEqI9I1lOlJXoohzguU73rOyxN7lD4WW
7a/HeBkUrY/wInQzHKYAoGUBQQ4cCkzeWh6unH5DL6jF0K1n00TVMA+zbBQ5ZhIx
ELpiw2/aNTO/xxLra2tD0kYCarnvBzG6WYX075FAXE9CORKVRjlMfvvmtjJ570Wz
KJamF3YZwp0M5trW/sqqvuTUO5jQkO9UZGC5uBCavt1dik57cSmte0Q7FTz2CwrC
YSSisVb7iim2oLEjmkQp1v4mLArTwalcHf5eEwa9rB3+aB4crtZgY+9Limyr6V8K
eKHMd6YRqXC7m+LHIf0tkPq61jMmrl/iVHkk+2v9y82dLR34ybz/RAhQd3udXbk7
YhJVTZ/wbCY1wkPhRJNgxKs7QT8TRpCWcJjk4c7GkxJ3H/Lz5LyZfMOyUjh7GLY4
Krro5b1rov3E2+99OGtR07PPqefYIIa2c0dFaHkAig==
=SG0n
-----END PGP SIGNATURE-----

--Tn9aMe8OdL2QnPTWt6H4CF0VgMl70Ib2d--

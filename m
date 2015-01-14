Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0EB3og5002721
 for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2015 06:03:50 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 34921AD1A
 for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2015 11:03:36 +0000 (UTC)
Date: Wed, 14 Jan 2015 12:03:34 +0100
From: Johannes Segitz <jsegitz@suse.com>
To: selinux@tycho.nsa.gov
Subject: ebitmap: map size does not match my size on s390x
Message-ID: <20150114110334.GA24984@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

running sepolgen-ifgen fails on s390x. It fails because calling=20
# sepolgen-ifgen-attr-helper /sys/fs/selinux/policy /tmp/tmpsSrJj3
gives:
libsepol.policydb_index_others: security:  7 users, 47 roles, 3156 types, 2=
01 bools
libsepol.policydb_index_others: security: 1 sens, 1024 cats
libsepol.policydb_index_others: security:  83 classes, 59401 rules, 9799 co=
nd rules
security: ebitmap: map size 1400 does not match my size 64 (high bit was 15=
45)
error(s) encountered while parsing configuration

I use version 2.3 of the userspace tools on SLE 12 with kernel 3.12.28. The
policy is based on Fedoras policy with some extension for SUSE
(f85b52d1c6805e9b0a8bd2a4a4332e66e4b52c00 for the base policy and=20
627644e1bb9c6f851c2466ab6e0eec7607f472cd for contrib). This combination
works fine on other architectures, only s390x shows this behavior. I did
not work on s390x before so I don't know if this ever worked.

The message comes from libsepol/src/ebitmap.c:361. Could this be a
endianness issue?

Best regards
Johannes
--
Johannes Segitz                                        SUSE Security Team
GPG Key E7C81FA0       EE16 6BCE AD56 E034 BFB3  3ADD 7BF7 29D5 E7C8 1FA0
SUSE LINUX GmbH        Maxfeldstra=DFe 5            90409 N=FCrnberg, Germa=
ny
GF: Felix Imend=F6rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu, Grah=
am Norton, HRB 21284 (AG N=FCrnberg)

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUtk0GAAoJELwn3Z0sxP1m7PsQALdmOyNS3Qli0qCYbuMVzlTW
faW30Ui+JpP5u0j1zaE7UTTJv3e+MqBzgR5elTtp6vOuX4fxko0c9oIraeKubUMf
Ib2Ed9gapu9V+QUxgeeVtjXqExEQTDIJe47h1BToBeazoJ7Os5IDHNS6qjaZOjdA
aKm8HpLvj0WoziERNxyGo/OPGFybMBeRuc2bW6+y2QaSwgIDFClabdzbNKRVUM34
SkccIQY60s+sWLNk8QanAmkOH8AlxY3uV0Ax5PLDOres4A76gbI2ND89fc3QbyHQ
mOsSuHNEtKuy4MXWissvV5oCNgz2JG9Nn45Pul0BsYFeIjEpIwlnGcKhmF3kIYwr
Qth6YH0YIXBk14toyoAFYBfmKYR2vrbqBjvjy+Rn4v8g5qN422jLW0lYDgbZlHc4
5wsWtW/K1huoWT3g29qM3POwRBXyPmlmgKBacOOFf04odbqpi5am1YSqfGujQY67
1cptlxxtDpUSG4T+PHwQKUADUlSwRbWgZYMDDBeE5aknbG3otZQRyeNYL/7wMQa3
yiMSjVes30OXKNEIn61Pl9DwQDF3W/Xb6j+9FsqjMSnKi5NxtKXupb+pqrmMUooG
wUHJwP5Et2ZtUZDhTfmGBaXoflF5c4hHNoOJtIjzt9E+LPn1UifCQexKtuDhRDl/
pGXC05uNbzrTLsVL+BTe
=QEDn
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--

Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w6JGHx7d010540
 for <selinux@tycho.nsa.gov>; Thu, 19 Jul 2018 12:17:59 -0400
To: selinux@tycho.nsa.gov, refpolicy <refpolicy@oss.tresys.com>
From: Lukas Vrabec <lvrabec@redhat.com>
Message-ID: <11ce07ad-6001-f686-29be-202c9062730e@redhat.com>
Date: Thu, 19 Jul 2018 18:17:46 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fzo1aHnbONvjmEL7z38Aas0Us5cHgibWV"
Subject: map permission in can_exec() but not in domain_transition_pattern()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fzo1aHnbONvjmEL7z38Aas0Us5cHgibWV
Content-Type: multipart/mixed; boundary="eB31dNDZvMqXW4AualvLwHkZiXAJbMYI5";
 protected-headers="v1"
From: Lukas Vrabec <lvrabec@redhat.com>
To: selinux@tycho.nsa.gov, refpolicy <refpolicy@oss.tresys.com>
Message-ID: <11ce07ad-6001-f686-29be-202c9062730e@redhat.com>
Subject: map permission in can_exec() but not in domain_transition_pattern()

--eB31dNDZvMqXW4AualvLwHkZiXAJbMYI5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi All,

I found one thing in refpolicy which I don't completely understand.

In "policy/support/misc_patterns.spt" there is definition of
"domain_transition_pattern" and this contains line:
allow $1 $2:file { getattr open read execute };

There is missing map permission.

However in "policy/support/misc_macros.spt" there is definition of
"can_exec" and it contains allow rule:
define(`can_exec',`allow $1 $2:file { mmap_exec_file_perms ioctl lock
execute_no_trans };')

There is a mmap_exec_file_perms which contains:
define(`mmap_exec_file_perms',`{ getattr open map read execute ioctl }')

Map is present in can_exec().

So for domain transitions we don't allow map permission from calling
domain on binary type but in can_exec macro there is map permission.

I think this is a bug and in "domain_transition_pattern" there should be
this line:
allow $1 $2:file { getattr open read execute map };

instead of:
allow $1 $2:file { getattr open read execute };

Am I right or missing something?

Thanks for help!
Lukas.

--=20
Lukas Vrabec
Software Engineer, Security Technologies
Red Hat, Inc.


--eB31dNDZvMqXW4AualvLwHkZiXAJbMYI5--

--fzo1aHnbONvjmEL7z38Aas0Us5cHgibWV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE3wrP3ArXoyYgAS7LRyAaxC8pzgYFAltQuaoACgkQRyAaxC8p
zgbIrwf9G0fYEYCka8NTeIVmlBIfigR2/9pS/v9CY268pRRfI1UFgvZr1+3WlOx1
ckD7WuV0/gI2qP4klJbsJ+NrtFjg2p/9XTVVnftZO9lYlu4OQOMM1nSDoDnsqfaa
3BStqRQIybeniD/s+nIgqgyxvXcSvptQubWho33DfQgBVEfsNABH65KfTsUwxHrS
9LYhlTax5IOBrxKLmyoQMjB1kWwbqdTw3sWtX353Xa1qIh7fynnoGscpu40bqO20
OnUNPjZB2kB+iTmuJLxcwZ+vewaFEG+1Grp/ZJyezBDdPLWcprmnvcVKeNcHRfKt
zHiApPw6TGURnpv3cVOzWKvHNFXthg==
=61DY
-----END PGP SIGNATURE-----

--fzo1aHnbONvjmEL7z38Aas0Us5cHgibWV--

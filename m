Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0CKALTt017968
 for <selinux@tycho.nsa.gov>; Sun, 12 Jan 2014 15:10:21 -0500
Received: from gentp.lnet (gentp.lnet [IPv6:::1])
 by gentp.lnet (Postfix) with ESMTP id 06FE2261237
 for <selinux@tycho.nsa.gov>; Sun, 12 Jan 2014 21:10:18 +0100 (CET)
Date: Sun, 12 Jan 2014 21:10:05 +0100
From: Luis Ressel <aranea@aixah.de>
To: selinux@tycho.nsa.gov
Subject: Re: Waiting for programs to stop
Message-ID: <20140112211005.29df3f4a@gentp.lnet>
In-Reply-To: <70061389380178@web5j.yandex.ru>
References: <70061389380178@web5j.yandex.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/Y4er0+CUtc=iMxSTsigtSFW"; protocol="application/pgp-signature"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--Sig_/Y4er0+CUtc=iMxSTsigtSFW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Jan 2014 20:56:18 +0200
Victor Porton <porton@narod.ru> wrote:

> I remind that we discuss sandboxing of untrusted programs.
>=20
> My application needs to receive a signal when ALL direct and indirect
> children of a process (including this process itself) started in a
> sandbox exit (it should work even when they call setsid()).
>=20
> Can this be done with the current kernel?


This is completely unrelated to SELinux, so please don't discuss it on
this list. Have a look into cgroups ("notify_on_release").


--=20
Luis Ressel <aranea@aixah.de>
GPG fpr: F08D 2AF6 655E 25DE 52BC  E53D 08F5 7F90 3029 B5BD

--Sig_/Y4er0+CUtc=iMxSTsigtSFW
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQJ8BAEBCgBmBQJS0vapXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRBMjU3MDBFQTc5QkYzMkY4NEQzMTFGNDlD
NzE4OTFBNkEwRUZCN0U5AAoJEMcYkaag77fpJe8QAK5AtOYP42UipKj3mMDxfymj
VsJA4Zzb8ESydCO2agzHbiyo+07gzavTrZLFWt7BEFdGWS5Zbvr3EfXYiJmGVfxT
R9dXkToTGoclr00N5a9a3/JTR96ZR2eLKGiAs0X4Zd4c9b+rc14VFv3IWRBD1iwA
moTEpZPNM2t6n4tfKZMo6IaDHHHcB/M7IAmONY8oEnHjSRW0ecpUkaF6nODEQOmm
RbfxFoh69xfFN20/g57EuSZUgsuxGSBT7UDEPwoCXNnDxPlTi5IVUK3jweNyux0Y
i9jtjEYA2TAd6oBplc3S8GxsZM0UBMz30KxynwSyESYexdRdR1m+TbZtzojkYOGs
iases6xia2htSBkoLNPobmXkZzrp5f2ByHWldP1/NhTyeSk5AGxOza7ngjWtpXKl
pMtrCefSUz78XG07G0TSKzHRVfIpNH3TVNmG15ReOAjGab2/g/BlL7b4fRqpwl3j
UyHIJW282SjNiVfgpwlYnirdk4YXlvlANJ/v8cQBzDIVRW1x8uq6jMZXBDeX2LSS
e0O5VVHGYb2ciBSmW0WBS4YEMX/ig3k2T7igPzM7Yiwm788eS89/0JV1PoAHFAWh
T4MeBo+Vbo7LvBeeM1SNXq6ula28mrQOZO5SCsx7qpoVWKWKpHjpx0liaU7JDxn0
KcMHwpLJWnm6BKFBrWvm
=VIpU
-----END PGP SIGNATURE-----

--Sig_/Y4er0+CUtc=iMxSTsigtSFW--

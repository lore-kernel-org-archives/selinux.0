Subject: [patch] allow hald to read selinux config
From: Colin Walters <walters@verbum.org>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wzfepVrs1CgxtVGMwbvD"
Date: Sat, 23 Oct 2004 15:05:52 -0400
Message-Id: <1098558352.8447.33.camel@x-infinity.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-wzfepVrs1CgxtVGMwbvD
Content-Type: multipart/mixed; boundary="=-sJ2QqvMSvnFQ50jgKKnR"


--=-sJ2QqvMSvnFQ50jgKKnR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This patch is needed because HAL 0.4.0 now determines whether or not
SELinux is enabled, and if it is applies the removable media context to
mounted filesystems.=20



--=-sJ2QqvMSvnFQ50jgKKnR
Content-Disposition: attachment; filename=hald-read-selconfig.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=hald-read-selconfig.patch; charset=UTF-8

LS0tIHBvbGljeS0xLjE3LjMzL2RvbWFpbnMvcHJvZ3JhbS91bnVzZWQvaGFsZC50ZX4JMjAwNC0x
MC0xOSAxNjowMzo1OC4wMDAwMDAwMDAgLTA0MDANCisrKyBwb2xpY3ktMS4xNy4zMy9kb21haW5z
L3Byb2dyYW0vdW51c2VkL2hhbGQudGUJMjAwNC0xMC0yMyAxNTowMjozMC44Nzc2NDk1NjAgLTA0
MDANCkBAIC02MCw3ICs2MCw3IEBADQogYWxsb3cgaGFsZF90IHVzYmZzX3Q6ZGlyIHNlYXJjaDsN
CiBhbGxvdyBoYWxkX3QgdXNiZnNfdDpmaWxlIHsgZ2V0YXR0ciByZWFkIH07DQogYWxsb3cgaGFs
ZF90IGJpbl90Omxua19maWxlIHJlYWQ7DQotZG9udGF1ZGl0IGhhbGRfdCBzZWxpbnV4X2NvbmZp
Z190OmRpciB7IHNlYXJjaCB9Ow0KK3JfZGlyX2ZpbGUoaGFsZF90LCB7IHNlbGludXhfY29uZmln
X3QgZGVmYXVsdF9jb250ZXh0X3QgfSApDQogYWxsb3cgaGFsZF90IGluaXRyY190OmRidXMgeyBz
ZW5kX21zZyB9Ow0KIGFsbG93IGluaXRyY190IGhhbGRfdDpkYnVzIHsgc2VuZF9tc2cgfTsNCiBh
bGxvdyBoYWxkX3QgZXRjX3J1bnRpbWVfdDpmaWxlIHJ3X2ZpbGVfcGVybXM7DQo=


--=-sJ2QqvMSvnFQ50jgKKnR--

--=-wzfepVrs1CgxtVGMwbvD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBequQOIkJWWp2WGURAmz0AJ9xthAySXpqIRZMh5yvRjw7AbsxtACfWD9z
tpiA7cHrSWWPk18d4UhFGrE=
=DsLg
-----END PGP SIGNATURE-----

--=-wzfepVrs1CgxtVGMwbvD--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

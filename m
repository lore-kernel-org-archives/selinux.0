Subject: [patch] give userspace_objmgr access to default_context_t
From: Colin Walters <walters@verbum.org>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-H9O8yztSvLHPZVs9s+QB"
Date: Sat, 23 Oct 2004 14:40:43 -0400
Message-Id: <1098556843.8447.30.camel@x-infinity.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-H9O8yztSvLHPZVs9s+QB
Content-Type: multipart/mixed; boundary="=-JNalDgbJ6+J6mx93Ot56"


--=-JNalDgbJ6+J6mx93Ot56
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Most userspace object managers (e.g. D-BUS) will need access to default
contexts files.  I think these used to just be selinux_config_t but seem
to have switched recently.

I noticed two domains, updfstab and udev are both likely candidates for
the userspace_objmgr attribute, since they have this:

domains/program/updfstab.te:r_dir_file(updfstab_t, { selinux_config_t file_=
context_t default_context_t } )

Right now neither of them get security decisions, but it doesn't seem
unlikely in the future.

--=-JNalDgbJ6+J6mx93Ot56
Content-Disposition: attachment; filename=userspace-objmgr-contexts.patch
Content-Type: text/x-patch; name=userspace-objmgr-contexts.patch; charset=UTF-8
Content-Transfer-Encoding: base64

LS0tIHBvbGljeS0xLjE3LjMzL2RvbWFpbnMvbWlzYy91c2Vyc3BhY2Vfb2JqbWdyLnRlCTIwMDQt
MTAtMTkgMTY6MDM6NTguMDAwMDAwMDAwIC0wNDAwDQorKysgcG9saWN5LmhhY2tlZC9kb21haW5z
L21pc2MvdXNlcnNwYWNlX29iam1nci50ZQkyMDA0LTEwLTIzIDE0OjMxOjI3Ljg2NTg3MDAwMCAt
MDQwMA0KQEAgLTYsOCArNiw4IEBADQogY2FuX2dldGNvbih1c2Vyc3BhY2Vfb2JqbWdyKQ0KICMg
R2V0IHNlY3VyaXR5IGRlY2lzaW9ucyB2aWEgc2VsaW51eGZzLg0KIGNhbl9nZXRzZWN1cml0eSh1
c2Vyc3BhY2Vfb2JqbWdyKQ0KLSMgUmVhZCAvZXRjL3NlbGludXgvY29uZmlnLg0KLXJfZGlyX2Zp
bGUodXNlcnNwYWNlX29iam1nciwgc2VsaW51eF9jb25maWdfdCkNCisjIFJlYWQgL2V0Yy9zZWxp
bnV4DQorcl9kaXJfZmlsZSh1c2Vyc3BhY2Vfb2JqbWdyLCB7IHNlbGludXhfY29uZmlnX3QgZGVm
YXVsdF9jb250ZXh0X3QgfSkNCiAjIFJlY2VpdmUgbm90aWZpY2F0aW9ucyBvZiBwb2xpY3kgcmVs
b2FkcyBhbmQgZW5mb3JjaW5nIHN0YXR1cyBjaGFuZ2VzLg0KIGFsbG93IHVzZXJzcGFjZV9vYmpt
Z3Igc2VsZjpuZXRsaW5rX3NlbGludXhfc29ja2V0IHsgY3JlYXRlIGJpbmQgcmVhZCB9Ow0KIA0K



--=-JNalDgbJ6+J6mx93Ot56--

--=-H9O8yztSvLHPZVs9s+QB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBeqWrOIkJWWp2WGURArV9AJkBQdasSmoUJAj8iTdAtbA5eOjf2QCaA1wy
EbnAYX5ufKu72aGhfFRisMc=
=ZNa6
-----END PGP SIGNATURE-----

--=-H9O8yztSvLHPZVs9s+QB--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

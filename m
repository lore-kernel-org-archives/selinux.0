Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l916kf73031020
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2007 02:46:41 -0400
Received: from mail.and.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l916keq5013377
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2007 06:46:40 GMT
Received: from localhost ([127.0.0.1])
	by mail.and.org with esmtp (Exim 4.66)
	(envelope-from <jantill@redhat.com>)
	id 1IcF36-0001Sd-G1
	for selinux@tycho.nsa.gov; Mon, 01 Oct 2007 02:46:37 -0400
Subject: [PATCH] ustr cleanups (policyrep branch)
From: James Antill <jantill@redhat.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xz7pTDk2ASYonZrCPBNQ"
Date: Mon, 01 Oct 2007 02:46:36 -0400
Message-Id: <1191221196.29631.44.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-xz7pTDk2ASYonZrCPBNQ
Content-Type: multipart/mixed; boundary="=-asJPtwJ/5S/V8SrbVr0C"


--=-asJPtwJ/5S/V8SrbVr0C
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


 Here are two cleanups for ustr usage within libsemanage on the
policyrep branch.

 The first is a corner case where you have two or more replacements in
the "replace_all" function of genhomedircon, previously one of those
multiple replacements (in theory) could fail due to malloc() returning
NULL and that would be missed. The fix probably makes the free test more
readable too.

 The second is that semanage_is_prefix() was previously defined by
calling ustr functions (inefficiently, even), and so had to allocate a
ustr to do it's work ... the fix just calls strncmp() directly.

--=20
James Antill <jantill@redhat.com>

--=-asJPtwJ/5S/V8SrbVr0C
Content-Disposition: inline; filename=selinux-semanage-policyrep-ustr-cleanups.patch
Content-Type: text/x-patch; name=selinux-semanage-policyrep-ustr-cleanups.patch;
	charset=UTF-8
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2JyYW5jaGVzL3BvbGljeXJlcC9saWJzZW1hbmFnZS9zcmMvZ2VuaG9tZWRp
cmNvbi5jIGIvYnJhbmNoZXMvcG9saWN5cmVwL2xpYnNlbWFuYWdlL3NyYy9nZW5ob21lZGlyY29u
LmMNCmluZGV4IDY4ZGVkYzguLmY0Y2MxNmIgMTAwNjQ0DQotLS0gYS9icmFuY2hlcy9wb2xpY3ly
ZXAvbGlic2VtYW5hZ2Uvc3JjL2dlbmhvbWVkaXJjb24uYw0KKysrIGIvYnJhbmNoZXMvcG9saWN5
cmVwL2xpYnNlbWFuYWdlL3NyYy9nZW5ob21lZGlyY29uLmMNCkBAIC0zMjIsNyArMzIyLDcgQEAg
c3RhdGljIHNlbWFuYWdlX2xpc3RfdCAqbWFrZV90ZW1wbGF0ZShnZW5ob21lZGlyY29uX3NldHRp
bmdzX3QgKiBzLA0KIHN0YXRpYyBVc3RyICpyZXBsYWNlX2FsbChjb25zdCBjaGFyICpzdHIsIGNv
bnN0IHJlcGxhY2VtZW50X3BhaXJfdCAqIHJlcGwpDQogew0KIAlVc3RyICpyZXR2YWwgPSBVU1RS
X05VTEw7DQotCWludCBpLCBudW1fcmVwbGFjZWQgPSAwOw0KKwlpbnQgaTsNCiANCiAJaWYgKCFz
dHIgfHwgIXJlcGwpDQogCQlnb3RvIGRvbmU7DQpAQCAtMzMwLDEwICszMzAsMTAgQEAgc3RhdGlj
IFVzdHIgKnJlcGxhY2VfYWxsKGNvbnN0IGNoYXIgKnN0ciwgY29uc3QgcmVwbGFjZW1lbnRfcGFp
cl90ICogcmVwbCkNCiAJCWdvdG8gZG9uZTsNCiANCiAJZm9yIChpID0gMDsgcmVwbFtpXS5zZWFy
Y2hfZm9yOyBpKyspIHsNCi0JCW51bV9yZXBsYWNlZCArPSB1c3RyX3JlcGxhY2VfY3N0cigmcmV0
dmFsLCByZXBsW2ldLnNlYXJjaF9mb3IsDQotCQkJCQkJICByZXBsW2ldLnJlcGxhY2Vfd2l0aCwg
MCk7DQorCQl1c3RyX3JlcGxhY2VfY3N0cigmcmV0dmFsLCByZXBsW2ldLnNlYXJjaF9mb3IsDQor
CQkJCSAgcmVwbFtpXS5yZXBsYWNlX3dpdGgsIDApOw0KIAl9DQotCWlmICghbnVtX3JlcGxhY2Vk
KQ0KKwlpZiAodXN0cl9lbm9tZW0ocmV0dmFsKSkNCiAJCXVzdHJfc2NfZnJlZSgmcmV0dmFsKTsN
CiANCiAgICAgICBkb25lOg0KZGlmZiAtLWdpdCBhL2JyYW5jaGVzL3BvbGljeXJlcC9saWJzZW1h
bmFnZS9zcmMvdXRpbGl0aWVzLmMgYi9icmFuY2hlcy9wb2xpY3lyZXAvbGlic2VtYW5hZ2Uvc3Jj
L3V0aWxpdGllcy5jDQppbmRleCA2YTk5N2U5Li4zNDlhNGJlIDEwMDY0NA0KLS0tIGEvYnJhbmNo
ZXMvcG9saWN5cmVwL2xpYnNlbWFuYWdlL3NyYy91dGlsaXRpZXMuYw0KKysrIGIvYnJhbmNoZXMv
cG9saWN5cmVwL2xpYnNlbWFuYWdlL3NyYy91dGlsaXRpZXMuYw0KQEAgLTYwLDIyICs2MCwxNCBA
QCBjaGFyICpzZW1hbmFnZV9maW5kdmFsKGNoYXIgKmZpbGUsIGNoYXIgKnZhciwgY2hhciAqZGVs
aW0pDQogDQogaW50IHNlbWFuYWdlX2lzX3ByZWZpeChjb25zdCBjaGFyICpzdHIsIGNvbnN0IGNo
YXIgKnByZWZpeCkNCiB7DQotCWludCByZXR2YWw7DQotCVVzdHIgKnVzdHIgPSBVU1RSX05VTEw7
DQotDQogCWlmICghc3RyKSB7DQogCQlyZXR1cm4gRkFMU0U7DQogCX0NCiAJaWYgKCFwcmVmaXgp
IHsNCiAJCXJldHVybiBUUlVFOw0KIAl9DQotCWlmICghKHVzdHIgPSB1c3RyX2R1cF9jc3RyKHN0
cikpKSB7DQotCQlyZXR1cm4gRkFMU0U7DQotCX0NCi0JcmV0dmFsID0gKHVzdHJfc3JjaF9jc3Ry
X2Z3ZCh1c3RyLCAwLCBwcmVmaXgpID09IDEpOw0KLQl1c3RyX3NjX2ZyZWUoJnVzdHIpOw0KIA0K
LQlyZXR1cm4gcmV0dmFsOw0KKwlyZXR1cm4gc3RybmNtcChzdHIsIHByZWZpeCwgc3RybGVuKHBy
ZWZpeCkpID09IDA7DQogfQ0KIA0KIGNoYXIgKnNlbWFuYWdlX3NwbGl0X29uX3NwYWNlKGNvbnN0
IGNoYXIgKnN0cikNCg==


--=-asJPtwJ/5S/V8SrbVr0C--

--=-xz7pTDk2ASYonZrCPBNQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD4DBQBHAJfM11eXTEMrxtQRAmcaAJdLoTzQjvNWv04vumIdLHqJgdm7AKDGsnOr
rOG1XoDitagW243+pfebIA==
=JSvL
-----END PGP SIGNATURE-----

--=-xz7pTDk2ASYonZrCPBNQ--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

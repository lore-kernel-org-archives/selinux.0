Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6HKiHu5001928
	for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2008 16:44:17 -0400
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6HKiGDU001357
	for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2008 20:44:17 GMT
Received: by ug-out-1314.google.com with SMTP id m3so849418ugc.15
        for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2008 13:44:16 -0700 (PDT)
Subject: Patch: selinux-policy: concept: let users relabel their
	user_home_t files to user_tmp_t and vice versa.
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-A+TN+fiWFRfCqsa3yXMm"
Date: Thu, 17 Jul 2008 22:44:13 +0200
Message-Id: <1216327453.11883.46.camel@sulphur.notebook.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-A+TN+fiWFRfCqsa3yXMm
Content-Type: multipart/mixed; boundary="=-vCEEaU+GmEu3XTSGv5fn"


--=-vCEEaU+GmEu3XTSGv5fn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Attached you will find a concept patch that should allow users to
relabel $1_home_t to $1_tmp_t and vice versa.

I was testing the patch program and noticed that it wanted to relabel a
file on my desktop from user_tmp_t to user_home_t:

[domg472@sulphur Desktop]$ patch -p0 < test.patch
patching file ktalk.te
patch: **** Can't set security context on file ktalk.te : Permission
denied
[domg472@sulphur Desktop]$ less ktalk.te
[domg472@sulphur Desktop]$ ls -alZ | grep ktalk.te*
drwxr-xr-x  domg472 domg472 domg472:object_r:user_home_t
-rw-rw-r--  domg472 domg472 domg472:object_r:user_tmp_t      ktalk.te
-rw-rw-r--  domg472 domg472 domg472:object_r:user_tmp_t
ktalk.te.rej

I suspect patch moves file objects from /tmp to ~/Desktop in this
scenario, and therefore the file object has a wrong type.=20
type=3DAVC msg=3Daudit(1216322317.253:231): avc:  denied  { relabelfrom }
for  pid=3D26588 comm=3D"patch" name=3D"ktalk.te" dev=3Ddm-1 ino=3D1827227
scontext=3Ddomg472:staff_r:staff_t:s0-s0:c0.c1023
tcontext=3Ddomg472:object_r:user_tmp_t:s0 tclass=3Dfile


--=20
Dominick Grift <domg472@gmail.com>

--=-vCEEaU+GmEu3XTSGv5fn
Content-Disposition: attachment; filename=user_home_t_and_user_tmp_t.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=user_home_t_and_user_tmp_t.patch; charset=UTF-8

SW5kZXg6IC9ob21lL2RvbWc0NzIvV29ya3NwYWNlL3JlZnBvbGljeV90cnVuay9wb2xpY3kvbW9k
dWxlcy9zeXN0ZW0vdXNlcmRvbWFpbi5pZg0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KLS0tIC9ob21lL2RvbWc0NzIv
V29ya3NwYWNlL3JlZnBvbGljeV90cnVuay9wb2xpY3kvbW9kdWxlcy9zeXN0ZW0vdXNlcmRvbWFp
bi5pZgkocmV2aXNpb24gMjc1OCkNCisrKyAvaG9tZS9kb21nNDcyL1dvcmtzcGFjZS9yZWZwb2xp
Y3lfdHJ1bmsvcG9saWN5L21vZHVsZXMvc3lzdGVtL3VzZXJkb21haW4uaWYJKHdvcmtpbmcgY29w
eSkNCkBAIC0yNjMsNiArMjYzLDcgQEANCiANCiAJIyBmdWxsIGNvbnRyb2wgb2YgdGhlIGhvbWUg
ZGlyZWN0b3J5DQogCWFsbG93ICQxX3QgJDFfaG9tZV90OmZpbGUgZW50cnlwb2ludDsNCisJYWxs
b3cgJDFfdCAkMV9ob21lX3Q6ZGlyX2ZpbGVfY2xhc3Nfc2V0IHsgcmVsYWJlbHRvIHJlbGFiZWxm
cm9tIH07DQogCW1hbmFnZV9kaXJzX3BhdHRlcm4oJDFfdCx7ICQxX2hvbWVfZGlyX3QgJDFfaG9t
ZV90IH0sJDFfaG9tZV90KQ0KIAltYW5hZ2VfZmlsZXNfcGF0dGVybigkMV90LHsgJDFfaG9tZV9k
aXJfdCAkMV9ob21lX3QgfSwkMV9ob21lX3QpDQogCW1hbmFnZV9sbmtfZmlsZXNfcGF0dGVybigk
MV90LHsgJDFfaG9tZV9kaXJfdCAkMV9ob21lX3QgfSwkMV9ob21lX3QpDQpAQCAtMzc1LDExICsz
NzYsMTcgQEANCiAJdHlwZSAkMV90bXBfdCwgJDFfZmlsZV90eXBlOw0KIAlmaWxlc190bXBfZmls
ZSgkMV90bXBfdCkNCiANCisJYWxsb3cgJDFfdCAkMV90bXBfdDpkaXJfZmlsZV9jbGFzc19zZXQg
eyByZWxhYmVsdG8gcmVsYWJlbGZyb20gfTsNCiAJbWFuYWdlX2RpcnNfcGF0dGVybigkMV90LCQx
X3RtcF90LCQxX3RtcF90KQ0KIAltYW5hZ2VfZmlsZXNfcGF0dGVybigkMV90LCQxX3RtcF90LCQx
X3RtcF90KQ0KIAltYW5hZ2VfbG5rX2ZpbGVzX3BhdHRlcm4oJDFfdCwkMV90bXBfdCwkMV90bXBf
dCkNCiAJbWFuYWdlX3NvY2tfZmlsZXNfcGF0dGVybigkMV90LCQxX3RtcF90LCQxX3RtcF90KQ0K
IAltYW5hZ2VfZmlmb19maWxlc19wYXR0ZXJuKCQxX3QsJDFfdG1wX3QsJDFfdG1wX3QpDQorCXJl
bGFiZWxfZGlyc19wYXR0ZXJuKCQxX3QsJDFfdG1wX3QsJDFfdG1wX3QpDQorCXJlbGFiZWxfZmls
ZXNfcGF0dGVybigkMV90LCQxX3RtcF90LCQxX3RtcF90KQ0KKwlyZWxhYmVsX2xua19maWxlc19w
YXR0ZXJuKCQxX3QsJDFfdG1wX3QsJDFfdG1wX3QpDQorCXJlbGFiZWxfc29ja19maWxlc19wYXR0
ZXJuKCQxX3QsJDFfdG1wX3QsJDFfdG1wX3QpDQorCXJlbGFiZWxfZmlmb19maWxlc19wYXR0ZXJu
KCQxX3QsJDFfdG1wX3QsJDFfdG1wX3QpDQogCWZpbGVzX3RtcF9maWxldHJhbnMoJDFfdCwgJDFf
dG1wX3QsIHsgZGlyIGZpbGUgbG5rX2ZpbGUgc29ja19maWxlIGZpZm9fZmlsZSB9KQ0KICcpDQog
DQo=


--=-vCEEaU+GmEu3XTSGv5fn--

--=-A+TN+fiWFRfCqsa3yXMm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkh/rxwACgkQL00QnzrVtlxX+wCfbA6tw1fntwib9v3HhQVBObMt
WmsAn1Bw3xyvTWNIzNd4rBnh6s3hogNd
=A5Hn
-----END PGP SIGNATURE-----

--=-A+TN+fiWFRfCqsa3yXMm--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7TGjPAa016315
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2007 12:45:25 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7TGjNPw026681
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2007 16:45:23 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1) with ESMTP id l7TGi3L6022206
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2007 12:44:03 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1/Submit) id l7TGi3JN022205
	for selinux@tycho.nsa.gov; Wed, 29 Aug 2007 12:44:03 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7SK8i3x005167
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 16:08:44 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7SK8hp9016118
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 20:08:43 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l7SK8gpH001348
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 16:08:42 -0400
Received: from lacrosse.corp.redhat.com (lacrosse.corp.redhat.com [172.16.52.154])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l7SK8gTs018573
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 16:08:42 -0400
Received: from myware66.akkadia.org (vpn-14-1.rdu.redhat.com [10.11.14.1])
	by lacrosse.corp.redhat.com (8.12.11.20060308/8.11.6) with ESMTP id l7SK8fVZ026891
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 16:08:41 -0400
Message-ID: <46D480C4.4000801@redhat.com>
Date: Tue, 28 Aug 2007 13:08:36 -0700
From: Ulrich Drepper <drepper@redhat.com>
MIME-Version: 1.0
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: libsepol optimization
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9D8567B8394F8B277522DA31"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9D8567B8394F8B277522DA31
Content-Type: multipart/mixed;
 boundary="------------000300010906010200050200"

This is a multi-part message in MIME format.
--------------000300010906010200050200
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

First in a serious or changes proposed for libsepol.

The first is a little patch which shrinks the DSO by 4.3%.  The
next_entry and put_entry functions are marked inline.  These are not
good candidates, the code is too big.  I bet without inlining them the
code actually runs faster because the i-cache isn't so polluted.  Plus
the savings in memory of course.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------000300010906010200050200
Content-Type: text/plain;
 name="d-libsepol-uninline"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="d-libsepol-uninline"

ZGlmZiAtZHVycCBsaWJzZXBvbC0yLjAuNy9zcmMvcHJpdmF0ZS5oIGxpYnNlcG9sLTIuMC43
LW5ldy9zcmMvcHJpdmF0ZS5oCi0tLSBsaWJzZXBvbC0yLjAuNy9zcmMvcHJpdmF0ZS5oCTIw
MDctMDgtMjMgMTM6NTI6NDUuMDAwMDAwMDAwIC0wNzAwCisrKyBsaWJzZXBvbC0yLjAuNy1u
ZXcvc3JjL3ByaXZhdGUuaAkyMDA3LTA4LTI4IDEyOjI2OjQ2LjAwMDAwMDAwMCAtMDcwMApA
QCAtNyw2ICs3LDcgQEAKICNpbmNsdWRlIDxieXRlc3dhcC5oPgogI2luY2x1ZGUgPGVuZGlh
bi5oPgogI2luY2x1ZGUgPGVycm5vLmg+CisjaW5jbHVkZSA8ZHNvLmg+CiAKICNpZiBfX0JZ
VEVfT1JERVIgPT0gX19MSVRUTEVfRU5ESUFOCiAjZGVmaW5lIGNwdV90b19sZTE2KHgpICh4
KQpAQCAtNDEsNTIgKzQyLDYgQEAgZXh0ZXJuIHN0cnVjdCBwb2xpY3lkYl9jb21wYXRfaW5m
byAqcG9saQogCQkJCQkJCSAgIHVuc2lnbmVkIGludCB0eXBlKTsKIAogLyogUmVhZGluZyBm
cm9tIGEgcG9saWN5ICJmaWxlIi4gKi8KLXN0YXRpYyBpbmxpbmUgaW50IG5leHRfZW50cnko
dm9pZCAqYnVmLCBzdHJ1Y3QgcG9saWN5X2ZpbGUgKmZwLCBzaXplX3QgYnl0ZXMpCi17Ci0J
c2l6ZV90IG5yZWFkOwotCi0Jc3dpdGNoIChmcC0+dHlwZSkgewotCWNhc2UgUEZfVVNFX1NU
RElPOgotCQlucmVhZCA9IGZyZWFkKGJ1ZiwgYnl0ZXMsIDEsIGZwLT5mcCk7Ci0JCWlmIChu
cmVhZCAhPSAxKQotCQkJcmV0dXJuIC0xOwotCQlicmVhazsKLQljYXNlIFBGX1VTRV9NRU1P
Ulk6Ci0JCWlmIChieXRlcyA+IGZwLT5sZW4pCi0JCQlyZXR1cm4gLTE7Ci0JCW1lbWNweShi
dWYsIGZwLT5kYXRhLCBieXRlcyk7Ci0JCWZwLT5kYXRhICs9IGJ5dGVzOwotCQlmcC0+bGVu
IC09IGJ5dGVzOwotCQlicmVhazsKLQlkZWZhdWx0OgotCQlyZXR1cm4gLTE7Ci0JfQotCXJl
dHVybiAwOwotfQotCi1zdGF0aWMgaW5saW5lIHNpemVfdCBwdXRfZW50cnkoY29uc3Qgdm9p
ZCAqcHRyLCBzaXplX3Qgc2l6ZSwgc2l6ZV90IG4sCi0JCQkgICAgICAgc3RydWN0IHBvbGlj
eV9maWxlICpmcCkKLXsKLQlzaXplX3QgYnl0ZXMgPSBzaXplICogbjsKLQotCXN3aXRjaCAo
ZnAtPnR5cGUpIHsKLQljYXNlIFBGX1VTRV9TVERJTzoKLQkJcmV0dXJuIGZ3cml0ZShwdHIs
IHNpemUsIG4sIGZwLT5mcCk7Ci0JY2FzZSBQRl9VU0VfTUVNT1JZOgotCQlpZiAoYnl0ZXMg
PiBmcC0+bGVuKSB7Ci0JCQllcnJubyA9IEVOT1NQQzsKLQkJCXJldHVybiAwOwotCQl9Ci0K
LQkJbWVtY3B5KGZwLT5kYXRhLCBwdHIsIGJ5dGVzKTsKLQkJZnAtPmRhdGEgKz0gYnl0ZXM7
Ci0JCWZwLT5sZW4gLT0gYnl0ZXM7Ci0JCXJldHVybiBuOwotCWNhc2UgUEZfTEVOOgotCQlm
cC0+bGVuICs9IGJ5dGVzOwotCQlyZXR1cm4gbjsKLQlkZWZhdWx0OgotCQlyZXR1cm4gMDsK
LQl9Ci0JcmV0dXJuIDA7Ci19CitleHRlcm4gaW50IG5leHRfZW50cnkodm9pZCAqYnVmLCBz
dHJ1Y3QgcG9saWN5X2ZpbGUgKmZwLCBzaXplX3QgYnl0ZXMpIGhpZGRlbjsKK2V4dGVybiBz
aXplX3QgcHV0X2VudHJ5KGNvbnN0IHZvaWQgKnB0ciwgc2l6ZV90IHNpemUsIHNpemVfdCBu
LAorCQkgICAgICAgIHN0cnVjdCBwb2xpY3lfZmlsZSAqZnApIGhpZGRlbjsKZGlmZiAtZHVy
cCBsaWJzZXBvbC0yLjAuNy9zcmMvc2VydmljZXMuYyBsaWJzZXBvbC0yLjAuNy1uZXcvc3Jj
L3NlcnZpY2VzLmMKLS0tIGxpYnNlcG9sLTIuMC43L3NyYy9zZXJ2aWNlcy5jCTIwMDctMDgt
MjMgMTM6NTI6NDUuMDAwMDAwMDAwIC0wNzAwCisrKyBsaWJzZXBvbC0yLjAuNy1uZXcvc3Jj
L3NlcnZpY2VzLmMJMjAwNy0wOC0yOCAxMjoyNTo1OC4wMDAwMDAwMDAgLTA3MDAKQEAgLTky
Nyw2ICs5MjcsNTggQEAgc3RhdGljIGludCBjb252ZXJ0X2NvbnRleHQoc2Vwb2xfc2VjdXJp
dAogCXJldHVybiByYzsKIH0KIAorLyogUmVhZGluZyBmcm9tIGEgcG9saWN5ICJmaWxlIi4g
Ki8KK2ludCBoaWRkZW4gbmV4dF9lbnRyeSh2b2lkICpidWYsIHN0cnVjdCBwb2xpY3lfZmls
ZSAqZnAsIHNpemVfdCBieXRlcykKK3sKKwlzaXplX3QgbnJlYWQ7CisKKwlzd2l0Y2ggKGZw
LT50eXBlKSB7CisJY2FzZSBQRl9VU0VfU1RESU86CisJCW5yZWFkID0gZnJlYWQoYnVmLCBi
eXRlcywgMSwgZnAtPmZwKTsKKworCQlpZiAobnJlYWQgIT0gMSkKKwkJCXJldHVybiAtMTsK
KwkJYnJlYWs7CisJY2FzZSBQRl9VU0VfTUVNT1JZOgorCQlpZiAoYnl0ZXMgPiBmcC0+bGVu
KQorCQkJcmV0dXJuIC0xOworCQltZW1jcHkoYnVmLCBmcC0+ZGF0YSwgYnl0ZXMpOworCQlm
cC0+ZGF0YSArPSBieXRlczsKKwkJZnAtPmxlbiAtPSBieXRlczsKKwkJYnJlYWs7CisJZGVm
YXVsdDoKKwkJcmV0dXJuIC0xOworCX0KKwlyZXR1cm4gMDsKK30KKworc2l6ZV90IGhpZGRl
biBwdXRfZW50cnkoY29uc3Qgdm9pZCAqcHRyLCBzaXplX3Qgc2l6ZSwgc2l6ZV90IG4sCisJ
CQlzdHJ1Y3QgcG9saWN5X2ZpbGUgKmZwKQoreworCXNpemVfdCBieXRlcyA9IHNpemUgKiBu
OworCisJc3dpdGNoIChmcC0+dHlwZSkgeworCWNhc2UgUEZfVVNFX1NURElPOgorCQlyZXR1
cm4gZndyaXRlKHB0ciwgc2l6ZSwgbiwgZnAtPmZwKTsKKwljYXNlIFBGX1VTRV9NRU1PUlk6
CisJCWlmIChieXRlcyA+IGZwLT5sZW4pIHsKKwkJCWVycm5vID0gRU5PU1BDOworCQkJcmV0
dXJuIDA7CisJCX0KKworCQltZW1jcHkoZnAtPmRhdGEsIHB0ciwgYnl0ZXMpOworCQlmcC0+
ZGF0YSArPSBieXRlczsKKwkJZnAtPmxlbiAtPSBieXRlczsKKwkJcmV0dXJuIG47CisJY2Fz
ZSBQRl9MRU46CisJCWZwLT5sZW4gKz0gYnl0ZXM7CisJCXJldHVybiBuOworCWRlZmF1bHQ6
CisJCXJldHVybiAwOworCX0KKwlyZXR1cm4gMDsKK30KKwogLyoKICAqIFJlYWQgYSBuZXcg
c2V0IG9mIGNvbmZpZ3VyYXRpb24gZGF0YSBmcm9tIAogICogYSBwb2xpY3kgZGF0YWJhc2Ug
YmluYXJ5IHJlcHJlc2VudGF0aW9uIGZpbGUuCg==
--------------000300010906010200050200--

--------------enig9D8567B8394F8B277522DA31
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG1IDE2ijCOnn/RHQRAjgNAJ9RLA7dsBD7OtsGTrA69aRosEq99gCeLMA6
qsCYB6PRh/1vVoKHSqUP8KA=
=EV3u
-----END PGP SIGNATURE-----

--------------enig9D8567B8394F8B277522DA31--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA05336
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 14:58:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA24611
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 18:56:39 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id SAA24607 for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 18:56:38 GMT
Received: from localhost (sds@localhost)
	by raven.gw.tislabs.com (8.11.6/8.11.6) with ESMTP id g8OIw0b04642
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 14:58:00 -0400 (EDT)
Date: Tue, 24 Sep 2002 14:58:00 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: <selinux@tycho.nsa.gov>
Subject: [patch] Fix bug in persistent label mapping code
Message-ID: <Pine.GSO.4.33.0209241456070.4584-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1032893880=:4584"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-1032893880=:4584
Content-Type: TEXT/PLAIN; charset=US-ASCII


The attached patch, also committed to the sourceforge CVS tree,
fixes a bug in the persistent label mapping code when writing to the
mapping files.  To apply, save the patch to ~/psid_write.patch, cd lsm-2.4
&& patch -p1 < ~/psid_write.patch.  Then rebuild your kernel.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-851401618-1032893880=:4584
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="psid_write.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0209241458000.4584@raven>
Content-Description: 
Content-Disposition: attachment; filename="psid_write.patch"

SW5kZXg6IGxzbS0yLjQvc2VjdXJpdHkvc2VsaW51eC9wc2lkLmMNCj09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0NClJDUyBmaWxlOiAvY3Zzcm9vdC9zZWxpbnV4
L25zYS9sc20tMi40L3NlY3VyaXR5L3NlbGludXgvcHNpZC5jLHYNCnJldHJp
ZXZpbmcgcmV2aXNpb24gMS40DQpkaWZmIC11IC1yMS40IHBzaWQuYw0KLS0t
IGxzbS0yLjQvc2VjdXJpdHkvc2VsaW51eC9wc2lkLmMJMjMgQXVnIDIwMDIg
MTg6MzE6NDggLTAwMDAJMS40DQorKysgbHNtLTIuNC9zZWN1cml0eS9zZWxp
bnV4L3BzaWQuYwkyNCBTZXAgMjAwMiAxODo0OTozNiAtMDAwMA0KQEAgLTUy
LDcgKzUyLDE0IEBADQogfQ0KIHN0YXRpYyBpbmxpbmUgc3NpemVfdCB3cml0
ZV9hYnMoc3RydWN0IGZpbGUgKmZwLCBjb25zdCBjaGFyICpidWYsIHNpemVf
dCBsZW4sIGxvZmZfdCBvZmYpIA0KIHsNCi0gIHJldHVybiBmcC0+Zl9vcC0+
d3JpdGUoZnAsIGJ1ZiwgbGVuLCAmb2ZmKTsNCisJdW5zaWduZWQgbG9uZyBs
aW1pdDsNCisJc3NpemVfdCByYzsNCisNCisJbGltaXQgPSBjdXJyZW50LT5y
bGltW1JMSU1JVF9GU0laRV0ucmxpbV9jdXI7DQorCWN1cnJlbnQtPnJsaW1b
UkxJTUlUX0ZTSVpFXS5ybGltX2N1ciA9IFJMSU1fSU5GSU5JVFk7DQorCXJj
ID0gZnAtPmZfb3AtPndyaXRlKGZwLCBidWYsIGxlbiwgJm9mZik7DQorCWN1
cnJlbnQtPnJsaW1bUkxJTUlUX0ZTSVpFXS5ybGltX2N1ciA9IGxpbWl0Ow0K
KwlyZXR1cm4gcmM7DQogfQ0KIA0KIA0KQEAgLTQ0NSw2ICs0NTIsMTAgQEAN
CiAJY2hhciAqY2J1ZjsNCiAJaW50IHJjID0gMDsNCiANCisJLyogSW5pdGlh
bGl6ZSB0aGUgcm9vdCBkaXJlY3RvcnkgU0lEIGJlZm9yZSB0aGUgbG9va3Vw
Lg0KKwkgICBUaGlzIHdpbGwgYmUgY2hhbmdlZCBkb3duIGJlbG93IG9uY2Ug
d2Uga25vdyB0aGUgcmVhbCBTSUQuICovDQorCWlub2RlX3NlY3VyaXR5X3Nl
dF9zaWQoc2ItPnNfcm9vdC0+ZF9pbm9kZSwgU0VDSU5JVFNJRF9GSUxFKTsN
CisNCiAJRFBSSU5URigicHNpZGZpbGVzX2luaXQ6ICBsb29raW5nIHVwICVz
XG4iLCBQU0VDX1NFQ0RJUik7DQogCWRpciA9IGxvb2t1cF9vbmVfbGVuKFBT
RUNfU0VDRElSLCBzYi0+c19yb290LCBzdHJsZW4oUFNFQ19TRUNESVIpKTsN
CiAJcmMgPSBQVFJfRVJSKGRpcik7DQpAQCAtNDk1LDcgKzUwNiw3IEBADQog
DQogCQkJZHB1dChkaXIpOw0KIA0KLQkJCXJjID0gc2VjdXJpdHlfZnNfc2lk
KChjaGFyICopa2Rldm5hbWUoc2ItPnNfZGV2KSwgDQorCQkJcmMgPSBzZWN1
cml0eV9mc19zaWQoKGNoYXIgKilrZGV2bmFtZSh0b19rZGV2X3Qoc2ItPnNf
ZGV2KSksIA0KIAkJCQkJICAgICAmZnNfc2lkLCAmZmlsZV9zaWQpOw0KIAkJ
CWlmIChyYykgDQogCQkJCWdvdG8gYmFkOw0KQEAgLTU4OSw3ICs2MDAsNyBA
QA0KIAkJICovDQogCQlEUFJJTlRGKCJwc2lkZmlsZXNfaW5pdDogIGluaXRp
YWxpemluZyBsYWJlbGluZyBmaWxlc1xuIik7DQogDQotCQlyYyA9IHNlY3Vy
aXR5X2ZzX3NpZCgoY2hhciopa2Rldm5hbWUoc2ItPnNfZGV2KSwgDQorCQly
YyA9IHNlY3VyaXR5X2ZzX3NpZCgoY2hhciopa2Rldm5hbWUodG9fa2Rldl90
KHNiLT5zX2RldikpLCANCiAJCQkJICAgICAmZnNfc2lkLCAmZmlsZV9zaWQp
Ow0KIAkJaWYgKHJjKQ0KIAkJCWdvdG8gYmFkOw0KQEAgLTEwMTcsNiArMTAy
OCw3IEBADQogCQkgICAgICAgaW5vZGUtPmlfaW5vICogc2l6ZW9mKHBzaWRf
dCkpOw0KIAlzZXRfZnMob2xkX2ZzKTsNCiAJaWYgKHJjIDwgMCkgew0KKwkJ
cHJpbnRrKCJzaWRfdG9fcHNpZDogIHdyaXRlX2FicyBmYWlsZWQsIHJjPSVk
IChkZXY9JXMgaW5vPSVsZCksIG9mZnNldCAlbGRcbiIsIC1yYywga2Rldm5h
bWUodG9fa2Rldl90KGlub2RlLT5pX2RldikpLCBpbm9kZS0+aV9pbm8sIGlu
b2RlLT5pX2lubyAqIHNpemVvZihwc2lkX3QpKTsNCiAJCXBzaWR0YWJfcHV0
KHNic2VjLCB0KTsNCiAJCXJldHVybiByYzsNCiAJfQ0K
---559023410-851401618-1032893880=:4584--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

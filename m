Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA01966
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2001 10:14:03 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA27693
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2001 15:13:19 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id PAA27689
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2001 15:13:19 GMT
Received: from localhost (sds@localhost)
	by raven.gw.tislabs.com (8.11.6/8.11.6) with ESMTP id fBBFDj018011
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2001 10:13:45 -0500 (EST)
Date: Tue, 11 Dec 2001 10:13:45 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH] Bug fix for selinux_file_send_sigiotask
Message-ID: <Pine.GSO.4.33.0112111010370.13843-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-684387517-1008083625=:13843"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-684387517-1008083625=:13843
Content-Type: TEXT/PLAIN; charset=US-ASCII


The attached patch fixes a bug in the selinux_file_send_sigiotask hook
function that calls the AVC with an uninitialized AVC audit structure.  It
also fixes a minor unrelated error.  To apply, save it to
~/module.patch, change to your lsm directory, and run
'patch -p1 < ~/module.patch'.  Then rebuild the kernel.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-684387517-1008083625=:13843
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="module.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0112111013450.13843@raven>
Content-Description: 
Content-Disposition: attachment; filename="module.patch"

SW5kZXg6IGxzbS9zZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMNCmRpZmYgLXUg
bHNtL3NlY3VyaXR5L3NlbGludXgvaG9va3MuYzoxLjEgbHNtL3NlY3VyaXR5
L3NlbGludXgvaG9va3MuYzoxLjINCi0tLSBsc20vc2VjdXJpdHkvc2VsaW51
eC9ob29rcy5jOjEuMQlGcmkgRGVjICA3IDEzOjQ2OjM1IDIwMDENCisrKyBs
c20vc2VjdXJpdHkvc2VsaW51eC9ob29rcy5jCVR1ZSBEZWMgMTEgMTE6MDE6
MTYgMjAwMQ0KQEAgLTIzMjUsNyArMjMyNSw2IEBADQogCQkJCSAgICAgICBp
bnQgZmQsIGludCByZWFzb24pDQogew0KICAgICAgICAgc3RydWN0IGZpbGUg
KmZpbGU7DQotCWF2Y19hdWRpdF9kYXRhX3QgYWQ7DQogCWFjY2Vzc192ZWN0
b3JfdCBwZXJtOw0KIAlzdHJ1Y3QgdGFza19zZWN1cml0eV9zdHJ1Y3QgKnRz
ZWM7DQogCXN0cnVjdCBmaWxlX3NlY3VyaXR5X3N0cnVjdCAqZnNlYzsNCkBA
IC0yMzU5LDggKzIzNTgsOCBAQA0KIAkJYnJlYWs7DQogCX0NCiANCi0JcmV0
dXJuIGF2Y19oYXNfcGVybV9hdWRpdChmc2VjLT5mb3duX3NpZCwgdHNlYy0+
c2lkLCANCi0JCQkJICBTRUNDTEFTU19QUk9DRVNTLCBwZXJtLCAmYWQpOw0K
KwlyZXR1cm4gYXZjX2hhc19wZXJtKGZzZWMtPmZvd25fc2lkLCB0c2VjLT5z
aWQsIA0KKwkJCSAgICBTRUNDTEFTU19QUk9DRVNTLCBwZXJtKTsNCiB9DQog
DQogc3RhdGljIGludCBzZWxpbnV4X2ZpbGVfcmVjZWl2ZShzdHJ1Y3QgZmls
ZSAqZmlsZSkNCkluZGV4OiBsc20vc2VjdXJpdHkvc2VsaW51eC9zZWxpbnV4
X3BsdWcuaA0KZGlmZiAtdSBsc20vc2VjdXJpdHkvc2VsaW51eC9zZWxpbnV4
X3BsdWcuaDoxLjEgbHNtL3NlY3VyaXR5L3NlbGludXgvc2VsaW51eF9wbHVn
Lmg6MS4yDQotLS0gbHNtL3NlY3VyaXR5L3NlbGludXgvc2VsaW51eF9wbHVn
Lmg6MS4xCUZyaSBEZWMgIDcgMTM6NDY6MzYgMjAwMQ0KKysrIGxzbS9zZWN1
cml0eS9zZWxpbnV4L3NlbGludXhfcGx1Zy5oCU1vbiBEZWMgMTAgMTQ6NDU6
MzYgMjAwMQ0KQEAgLTE3NSw3ICsxNzUsNyBAQA0KIC8qIFJhbmdlIG9mIHBv
cnQgbnVtYmVycyB1c2VkIHRvIGF1dG9tYXRpY2FsbHkgYmluZC4NCiAgICBO
ZWVkIHRvIGRldGVybWluZSB3aGV0aGVyIHdlIHNob3VsZCBwZXJmb3JtIGEg
bmFtZV9iaW5kIA0KICAgIHBlcm1pc3Npb24gY2hlY2sgYmV0d2VlbiB0aGUg
c29ja2V0IGFuZCB0aGUgcG9ydCBudW1iZXIuICovDQotI2lmZGVmIE1PRFVM
RQ0KKyNpZm5kZWYgTU9EVUxFDQogI2RlZmluZSBpcF9sb2NhbF9wb3J0X3Jh
bmdlXzAgc3lzY3RsX2xvY2FsX3BvcnRfcmFuZ2VbMF0NCiAjZGVmaW5lIGlw
X2xvY2FsX3BvcnRfcmFuZ2VfMSBzeXNjdGxfbG9jYWxfcG9ydF9yYW5nZVsx
XQ0KICNlbHNlDQo=
---559023410-684387517-1008083625=:13843--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

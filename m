Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA18243
	for <selinux@tycho.nsa.gov>; Thu, 20 Dec 2001 10:21:14 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA23470
	for <selinux@tycho.nsa.gov>; Thu, 20 Dec 2001 15:20:58 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id PAA23466
	for <selinux@tycho.nsa.gov>; Thu, 20 Dec 2001 15:20:58 GMT
Received: from localhost (sds@localhost)
	by raven.gw.tislabs.com (8.11.6/8.11.6) with ESMTP id fBKFKlm23102
	for <selinux@tycho.nsa.gov>; Thu, 20 Dec 2001 10:20:47 -0500 (EST)
Date: Thu, 20 Dec 2001 10:20:47 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH] Bug fix for ipc_precondition calls
Message-ID: <Pine.GSO.4.33.0112201019450.16420-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-824023566-1008861647=:16420"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-824023566-1008861647=:16420
Content-Type: TEXT/PLAIN; charset=US-ASCII


The attached patch fixes several calls to the ipc_precondition function in
the SELinux module.  To apply, save the patch to ~/ipc.patch, cd to your
lsm directory and run 'patch -p1 < ipc.patch'.  Then rebuild the kernel.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-824023566-1008861647=:16420
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ipc.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0112201020470.16420@raven>
Content-Description: 
Content-Disposition: attachment; filename="ipc.patch"

SW5kZXg6IGxzbS9zZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMNCmRpZmYgLXUg
bHNtL3NlY3VyaXR5L3NlbGludXgvaG9va3MuYzoxLjUgbHNtL3NlY3VyaXR5
L3NlbGludXgvaG9va3MuYzoxLjYNCi0tLSBsc20vc2VjdXJpdHkvc2VsaW51
eC9ob29rcy5jOjEuNQlXZWQgRGVjIDE5IDEwOjQ1OjAyIDIwMDENCisrKyBs
c20vc2VjdXJpdHkvc2VsaW51eC9ob29rcy5jCVRodSBEZWMgMjAgMDk6MTk6
MzAgMjAwMQ0KQEAgLTM0ODEsNyArMzQ4MSw3IEBADQogCXJjID0gdGFza19w
cmVjb25kaXRpb24oY3VycmVudCk7DQogCWlmIChyYyA8PSAwKQ0KIAkJcmV0
dXJuIHJjOw0KLQlyYyA9IGlwY19wcmVjb25kaXRpb24obXNxLT5xX3Blcm0u
c2VjdXJpdHksIFNFQ0NMQVNTX01TR1EpOw0KKwlyYyA9IGlwY19wcmVjb25k
aXRpb24oJm1zcS0+cV9wZXJtLCBTRUNDTEFTU19NU0dRKTsNCiAJaWYgKHJj
IDw9IDApDQogCQlyZXR1cm4gcmM7DQogDQpAQCAtMzU0Miw3ICszNTQyLDcg
QEANCiAJcmMgPSB0YXNrX3ByZWNvbmRpdGlvbihjdXJyZW50KTsNCiAJaWYg
KHJjIDw9IDApDQogCQlyZXR1cm4gcmM7DQotCXJjID0gaXBjX3ByZWNvbmRp
dGlvbihtc3EtPnFfcGVybS5zZWN1cml0eSwgU0VDQ0xBU1NfTVNHUSk7DQor
CXJjID0gaXBjX3ByZWNvbmRpdGlvbigmbXNxLT5xX3Blcm0sIFNFQ0NMQVNT
X01TR1EpOw0KIAlpZiAocmMgPD0gMCkNCiAJCXJldHVybiByYzsNCiAJcmMg
PSBtc2dfcHJlY29uZGl0aW9uKG1zZyk7DQpAQCAtMzYwNiw3ICszNjA2LDcg
QEANCiAJcmMgPSB0YXNrX3ByZWNvbmRpdGlvbih0YXJnZXQpOw0KIAlpZiAo
cmMgPD0gMCkNCiAJCXJldHVybiByYzsNCi0JcmMgPSBpcGNfcHJlY29uZGl0
aW9uKG1zcS0+cV9wZXJtLnNlY3VyaXR5LCBTRUNDTEFTU19NU0dRKTsNCisJ
cmMgPSBpcGNfcHJlY29uZGl0aW9uKCZtc3EtPnFfcGVybSwgU0VDQ0xBU1Nf
TVNHUSk7DQogCWlmIChyYyA8PSAwKQ0KIAkJcmV0dXJuIHJjOw0KIAlyYyA9
IG1zZ19wcmVjb25kaXRpb24obXNnKTsNCkBAIC0zNjg1LDcgKzM2ODUsNyBA
QA0KIAlyYyA9IHRhc2tfcHJlY29uZGl0aW9uKGN1cnJlbnQpOw0KIAlpZiAo
cmMgPD0gMCkNCiAJCXJldHVybiByYzsNCi0JcmMgPSBpcGNfcHJlY29uZGl0
aW9uKHNocC0+c2htX3Blcm0uc2VjdXJpdHksIFNFQ0NMQVNTX1NITSk7DQor
CXJjID0gaXBjX3ByZWNvbmRpdGlvbigmc2hwLT5zaG1fcGVybSwgU0VDQ0xB
U1NfU0hNKTsNCiAJaWYgKHJjIDw9IDApDQogCQlyZXR1cm4gcmM7DQogDQpA
QCAtMzc5OCw3ICszNzk4LDcgQEANCiAJcmMgPSB0YXNrX3ByZWNvbmRpdGlv
bihjdXJyZW50KTsNCiAJaWYgKHJjIDw9IDApDQogCQlyZXR1cm4gcmM7DQot
CXJjID0gaXBjX3ByZWNvbmRpdGlvbihzbWEtPnNlbV9wZXJtLnNlY3VyaXR5
LCBTRUNDTEFTU19TRU0pOw0KKwlyYyA9IGlwY19wcmVjb25kaXRpb24oJnNt
YS0+c2VtX3Blcm0sIFNFQ0NMQVNTX1NFTSk7DQogCWlmIChyYyA8PSAwKQ0K
IAkJcmV0dXJuIHJjOw0KIA0K
---559023410-824023566-1008861647=:16420--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

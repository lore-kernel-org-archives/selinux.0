Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA25379
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2001 10:26:27 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA04400
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2001 14:25:03 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA04395
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2001 14:25:02 GMT
Received: from localhost by clipper.gw.tislabs.com (8.9.3/8.9.1) with SMTP id KAA19120
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2001 10:25:38 -0400 (EDT)
Date: Thu, 6 Sep 2001 10:25:38 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Bug fix for file alloc_security hook call
Message-ID: <Pine.SOL.3.95.1010906102335.12491G-200000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-5916492-999721568=:8103"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-5916492-999721568=:8103
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.SOL.3.95.1010906102335.12491I@clipper.gw.tislabs.com>


The attached patch fixes a bug in the LSM kernel patch
that was causing the security attributes on struct file
objects to be immediately clobbered after allocation
(and a memory leak).  To apply, save the patch to file_table.patch,
change to the lsm directory and run 'patch -p1 < file_table.patch'.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-5916492-999721568=:8103
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="file_table.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.3.95.1010905162608.8103m@clipper.gw.tislabs.com>
Content-Description: 

SW5kZXg6IGxzbS9mcy9maWxlX3RhYmxlLmMNCmRpZmYgLXUgbHNtL2ZzL2Zp
bGVfdGFibGUuYzoxLjMgbHNtL2ZzL2ZpbGVfdGFibGUuYzoxLjQNCi0tLSBs
c20vZnMvZmlsZV90YWJsZS5jOjEuMwlXZWQgSnVuIDEzIDEyOjIwOjI4IDIw
MDENCisrKyBsc20vZnMvZmlsZV90YWJsZS5jCVdlZCBTZXAgIDUgMTY6MTI6
NDEgMjAwMQ0KQEAgLTQxLDEzICs0MSwxMyBAQA0KIAkJbGlzdF9kZWwoJmYt
PmZfbGlzdCk7DQogCQlmaWxlc19zdGF0Lm5yX2ZyZWVfZmlsZXMtLTsNCiAJ
bmV3X29uZToNCisJCW1lbXNldChmLCAwLCBzaXplb2YoKmYpKTsNCiAJCWlm
IChzZWN1cml0eV9vcHMtPmZpbGVfb3BzLT5hbGxvY19zZWN1cml0eShmKSkg
ew0KIAkJCWxpc3RfYWRkKCZmLT5mX2xpc3QsICZmcmVlX2xpc3QpOw0KIAkJ
CWZpbGVzX3N0YXQubnJfZnJlZV9maWxlcysrOw0KIAkJCWZpbGVfbGlzdF91
bmxvY2soKTsNCiAJCQlyZXR1cm4gTlVMTDsNCiAJCX0NCi0JCW1lbXNldChm
LCAwLCBzaXplb2YoKmYpKTsNCiAJCWF0b21pY19zZXQoJmYtPmZfY291bnQs
MSk7DQogCQlmLT5mX3ZlcnNpb24gPSArK2V2ZW50Ow0KIAkJZi0+Zl91aWQg
PSBjdXJyZW50LT5mc3VpZDsNCg==
---559023410-5916492-999721568=:8103--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

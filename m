Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA25073
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 12:24:51 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA19234
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 16:23:22 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id QAA19230 for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 16:23:22 GMT
Date: Fri, 12 Jul 2002 12:24:39 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Debian User <rogelio@evoworks.evoserve.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] atuomatic type transitions for pts in devfs
In-Reply-To: <3D2C4F46.1040408@evoworks.evoserve.com>
Message-ID: <Pine.GSO.4.33.0207121220350.28541-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-5916492-1026490923=:28541"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-5916492-1026490923=:28541
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.33.0207121222161.28541@raven>


The attached patch is a slightly revised version of your patch that has
been merged into our tree for future releases.  It has also been committed
to the sourceforge CVS tree.  Thanks for contributing.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




---559023410-5916492-1026490923=:28541
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="lsm-2.4-devfspts.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0207121222030.28541@raven>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="lsm-2.4-devfspts.patch"

SW5kZXg6IHNlY3VyaXR5L3NlbGludXgvaG9va3MuYw0KPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQ0KUkNTIGZpbGU6IC9jdnNyb290L3NlbGludXgvbnNhL2xz
bS0yLjQvc2VjdXJpdHkvc2VsaW51eC9ob29rcy5jLHYNCnJldHJpZXZpbmcg
cmV2aXNpb24gMS4xMw0KZGlmZiAtdSAtcjEuMTMgaG9va3MuYw0KLS0tIHNl
Y3VyaXR5L3NlbGludXgvaG9va3MuYwk1IEp1bCAyMDAyIDExOjA2OjM3IC0w
MDAwCTEuMTMNCisrKyBzZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMJMTIgSnVs
IDIwMDIgMTU6MTM6MTUgLTAwMDANCkBAIC0xMyw2ICsxMyw4IEBADQogICoJ
aXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMg
TGljZW5zZSBhcyBwdWJsaXNoZWQgYnkNCiAgKgl0aGUgRnJlZSBTb2Z0d2Fy
ZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNl
LCBvcg0KICAqCShhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24u
DQorICoNCisgKiBbSnVsIDIwMDIsIFJvZ2VsaW8gTS4gU2VycmFubyBKci5d
IEFkZGVkIHR5cGUgdHJhbnNpdGlvbnMgZm9yIHB0cyBpbiBkZXZmcy4NCiAg
Ki8gDQogDQogI2luY2x1ZGUgPGxpbnV4L2NvbmZpZy5oPg0KQEAgLTY4OSw3
ICs2OTEsNyBAQA0KIHsNCiAJc3RydWN0IHN1cGVyYmxvY2tfc2VjdXJpdHlf
c3RydWN0ICpzYnNlYyA9IE5VTEw7IA0KIAlzdHJ1Y3QgaW5vZGVfc2VjdXJp
dHlfc3RydWN0ICppc2VjID0gaW5vZGUtPmlfc2VjdXJpdHk7DQotCXNlY3Vy
aXR5X2lkX3Qgc2lkOw0KKwlzZWN1cml0eV9pZF90IHNpZCwgZGV2ZnNfcHRz
X3NpZDsNCiAJY2hhciAqYnVmZmVyLCAqcGF0aDsNCiAJc3RydWN0IGRlbnRy
eSAqZGVudHJ5Ow0KIAlpbnQgcmM7DQpAQCAtNzc5LDEwICs3ODEsMjIgQEAN
CiAJCQkJcGF0aCA9IGF2Y19kX3BhdGgoZGVudHJ5LCBidWZmZXIsDQogCQkJ
CQkJICBQQUdFX1NJWkUpOw0KIAkJCQlpZiAocGF0aCkgew0KLQkJCQkJcmMg
PSBzZWN1cml0eV9nZW5mc19zaWQoaW5vZGUtPmlfc2ItPnNfdHlwZS0+bmFt
ZSwNCi0JCQkJCQkJCXBhdGgsIA0KLQkJCQkJCQkJaXNlYy0+c2NsYXNzLA0K
LQkJCQkJCQkJJnNpZCk7DQorCQkJCQlpZiAoIXN0cmNtcChpbm9kZS0+aV9z
Yi0+c190eXBlLT5uYW1lLA0KKwkJCQkJCSAgICAiZGV2ZnMiKSAmJiANCisJ
CQkJCSAgICAhbWVtY21wKHBhdGgsICIvcHRzLyIsIDUpKSB7DQorCQkJCQkJ
cmMgPSBzZWN1cml0eV9nZW5mc19zaWQoImRldmZzIiwgIi9wdHMiLCBTRUND
TEFTU19ESVIsICZkZXZmc19wdHNfc2lkKTsNCisJCQkJCQlpZiAoIXJjKSAN
CisJCQkJCQkgIHJjID0gc2VjdXJpdHlfdHJhbnNpdGlvbl9zaWQoDQorCQkJ
CQkJCSAgaXNlYy0+dGFza19zaWQsIA0KKwkJCQkJCQkgIGRldmZzX3B0c19z
aWQsIA0KKwkJCQkJCQkgIGlzZWMtPnNjbGFzcywNCisJCQkJCQkJICAmc2lk
KTsNCisJCQkJCX0gZWxzZSB7DQorCQkJCQkJcmMgPSBzZWN1cml0eV9nZW5m
c19zaWQoaW5vZGUtPmlfc2ItPnNfdHlwZS0+bmFtZSwNCisJCQkJCQkJCQlw
YXRoLCANCisJCQkJCQkJCQlpc2VjLT5zY2xhc3MsDQorCQkJCQkJCQkJJnNp
ZCk7DQorCQkJCQl9DQogCQkJCQlpZiAoIXJjKQ0KIAkJCQkJCWlzZWMtPnNp
ZCA9IHNpZDsNCiAJCQkJfQ0K
---559023410-5916492-1026490923=:28541--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

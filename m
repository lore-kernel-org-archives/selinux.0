Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA00268
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2001 09:36:50 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA15819
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2001 14:36:45 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA15815
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2001 14:36:44 GMT
Date: Tue, 4 Dec 2001 09:36:08 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: <selinux@tycho.nsa.gov>
Subject: [PATCH] AVC auditing changes
In-Reply-To: <1007474267.2028.0.camel@jsmith.org>
Message-ID: <Pine.GSO.4.33.0112040932210.28408-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-684387517-1007476568=:28408"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-684387517-1007476568=:28408
Content-Type: TEXT/PLAIN; charset=US-ASCII


I've attached a patch that implements the changes to the AVC auditing
code that I mentioned in my previous message (only impose ratelimit if
enforcing, put each audit message on a single line).  To apply, save
the attachment to ~/avc.patch, cd selinux, and run 'patch -p1 <
~/avc.patch'.  Then rebuild the LSM kernel with the SELinux module.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




---559023410-684387517-1007476568=:28408
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="avc.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0112040936080.28408@raven>
Content-Description: 
Content-Disposition: attachment; filename="avc.patch"

SW5kZXg6IHNlbGludXgvbW9kdWxlL3NlbGludXhfcGx1Zy9hdmMuYw0KZGlm
ZiAtdSBzZWxpbnV4L21vZHVsZS9zZWxpbnV4X3BsdWcvYXZjLmM6MS4xMCBz
ZWxpbnV4L21vZHVsZS9zZWxpbnV4X3BsdWcvYXZjLmM6MS4xMg0KLS0tIHNl
bGludXgvbW9kdWxlL3NlbGludXhfcGx1Zy9hdmMuYzoxLjEwCU1vbiBOb3Yg
MTIgMjM6MDc6MjMgMjAwMQ0KKysrIHNlbGludXgvbW9kdWxlL3NlbGludXhf
cGx1Zy9hdmMuYwlUdWUgTm92IDI3IDExOjI3OjM4IDIwMDENCkBAIC0xNTcs
NyArMTU3LDYgQEANCiAJc2VjdXJpdHlfY29udGV4dF90IHNjb250ZXh0Ow0K
IAlfX3UzMiBzY29udGV4dF9sZW47DQogCQ0KLQlwcmludGsoIlxuICAgIik7
DQogIAlyYyA9IHNlY3VyaXR5X3NpZF90b19jb250ZXh0KHNzaWQsICZzY29u
dGV4dCwgJnNjb250ZXh0X2xlbik7DQogCWlmIChyYykNCiAJCXByaW50aygi
c3NpZD0lZCIsIHNzaWQpOwkJDQpAQCAtMTY2LDcgKzE2NSw2IEBADQogCQlr
ZnJlZShzY29udGV4dCk7DQogCX0NCiANCi0JcHJpbnRrKCJcbiAgIik7DQog
CXJjID0gc2VjdXJpdHlfc2lkX3RvX2NvbnRleHQodHNpZCwgJnNjb250ZXh0
LCAmc2NvbnRleHRfbGVuKTsNCiAJaWYgKHJjKQ0KIAkJcHJpbnRrKCIgdHNp
ZD0lZCIsIHRzaWQpOw0KQEAgLTE3NCw4ICsxNzIsNyBAQA0KIAkJcHJpbnRr
KCIgdGNvbnRleHQ9JXMiLCBzY29udGV4dCk7DQogCQlrZnJlZShzY29udGV4
dCk7DQogCX0NCi0JcHJpbnRrKCJcbiAgIik7DQotCXByaW50aygiIHRjbGFz
cz0lc1xuIiwgY2xhc3NfdG9fc3RyaW5nW3RjbGFzc10pOw0KKwlwcmludGso
IiB0Y2xhc3M9JXMiLCBjbGFzc190b19zdHJpbmdbdGNsYXNzXSk7DQogfQ0K
IA0KIA0KQEAgLTU0Nyw2ICs1NDQsNyBAQA0KICAqIENvcGllZCBmcm9tIG5l
dC9jb3JlL3V0aWxzLmM6bmV0X3JhdGVsaW1pdCBhbmQgbW9kaWZpZWQgZm9y
DQogICogdXNlIGJ5IHRoZSBBVkMgYXVkaXQgZmFjaWxpdHkuDQogICovDQor
DQogaW50IGF2Y19tc2dfY29zdCA9IDUqSFo7DQogaW50IGF2Y19tc2dfYnVy
c3QgPSAxMCo1KkhaOw0KIA0KQEAgLTU4Myw2ICs1ODEsMjggQEANCiB9DQog
DQogDQorI2lmZGVmIENPTkZJR19TRUNVUklUWV9TRUxJTlVYX0RFVkVMT1AN
CisNCitzdGF0aWMgaW5saW5lIGludCBjaGVja19hdmNfcmF0ZWxpbWl0KHZv
aWQpICANCit7DQorCWlmIChhdmNfZGVidWdfYWx3YXlzX2FsbG93KQ0KKwkJ
LyogSWYgcGVybWlzc2l2ZSwgdGhlbiBuZXZlciBzdXBwcmVzcyBtZXNzYWdl
cy4gKi8NCisJCXJldHVybiAxOw0KKwllbHNlDQorCQlyZXR1cm4gYXZjX3Jh
dGVsaW1pdCgpOw0KK30NCisNCisjZWxzZQ0KKw0KK3N0YXRpYyBpbmxpbmUg
aW50IGNoZWNrX2F2Y19yYXRlbGltaXQodm9pZCkgIA0KK3sNCisJcmV0dXJu
IGF2Y19yYXRlbGltaXQoKTsNCit9DQorDQorI2VuZGlmDQorDQorDQorDQog
LyoNCiAgKiBBdWRpdCB0aGUgZ3JhbnRpbmcgb3IgZGVuaWFsIG9mIHBlcm1p
c3Npb25zLg0KICAqLw0KQEAgLTU5Nyw3ICs2MTcsNyBAQA0KIHsNCiAJY2hh
ciAqcDsNCiANCi0JaWYgKCFhdmNfcmF0ZWxpbWl0KCkpDQorCWlmICghY2hl
Y2tfYXZjX3JhdGVsaW1pdCgpKQ0KIAkJcmV0dXJuOw0KIA0KIAlwcmludGso
IlxuYXZjOiAgJXMgIiwgZGVuaWVkID8gImRlbmllZCIgOiAiZ3JhbnRlZCIp
Ow0KQEAgLTczOSw3ICs3NTksOSBAQA0KIAkJCWJyZWFrOw0KIAkJfQ0KIAl9
DQorCXByaW50aygiICIpOw0KIAlhdmNfZHVtcF9xdWVyeShzc2lkLCB0c2lk
LCB0Y2xhc3MpOw0KKwlwcmludGsoIlxuIik7DQogfQ0KIA0KIA0K
---559023410-684387517-1007476568=:28408--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

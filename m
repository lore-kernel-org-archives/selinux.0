Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA24545
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 09:33:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA11365
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 13:31:54 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA11361
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 13:31:54 GMT
Received: from localhost (sds@localhost)
	by raven.gw.tislabs.com (8.11.6/8.11.6) with ESMTP id g3GDX6117835
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 09:33:06 -0400 (EDT)
Date: Tue, 16 Apr 2002 09:33:06 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: <selinux@tycho.nsa.gov>
Subject: [patch] Bug fix for AVC
Message-ID: <Pine.GSO.4.33.0204160931380.14669-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1804928587-1018963986=:14669"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1804928587-1018963986=:14669
Content-Type: TEXT/PLAIN; charset=US-ASCII


The attached patch fixes a bug in the AVC that can produce deadlock on SMP
machines.  To apply, cd lsm-2.4 (or lsm-2.5) && patch -p0 <
~/avc_lock.patch.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-1804928587-1018963986=:14669
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="avc_lock.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0204160933060.14669@raven>
Content-Description: 
Content-Disposition: attachment; filename="avc_lock.patch"

SW5kZXg6IHNlY3VyaXR5L3NlbGludXgvYXZjLmMNCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0NClJDUyBmaWxlOiAvY3ZzL2xzbS9sc20vc2VjdXJpdHkvc2Vs
aW51eC9hdmMuYyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuNA0KcmV0cmll
dmluZyByZXZpc2lvbiAxLjUNCmRpZmYgLXUgLXIxLjQgLXIxLjUNCi0tLSBz
ZWN1cml0eS9zZWxpbnV4L2F2Yy5jCTIwMDIvMDIvMDQgMTc6NTQ6MDkJMS40
DQorKysgc2VjdXJpdHkvc2VsaW51eC9hdmMuYwkyMDAyLzA0LzE2IDEyOjEx
OjE0CTEuNQ0KQEAgLTIxOCw4ICsyMTgsOSBAQA0KIHsNCiAJaW50ICAgICAg
ICAgICAgIGksIGNoYWluX2xlbiwgbWF4X2NoYWluX2xlbiwgc2xvdHNfdXNl
ZDsNCiAJYXZjX25vZGVfdCAgICAgKm5vZGU7DQorCXVuc2lnbmVkIGxvbmcJ
ZmxhZ3M7DQogDQotCXNwaW5fbG9jaygmYXZjX2xvY2spOw0KKwlzcGluX2xv
Y2tfaXJxc2F2ZSgmYXZjX2xvY2ssZmxhZ3MpOw0KIA0KIAlzbG90c191c2Vk
ID0gMDsNCiAJbWF4X2NoYWluX2xlbiA9IDA7DQpAQCAtMjM3LDcgKzIzOCw3
IEBADQogCQl9DQogCX0NCiANCi0Jc3Bpbl91bmxvY2soJmF2Y19sb2NrKTsN
CisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmYXZjX2xvY2ssZmxhZ3MpOw0K
IA0KIAlwcmludGsoIlxuJXMgYXZjOiAgJWQgZW50cmllcyBhbmQgJWQvJWQg
YnVja2V0cyB1c2VkLCBsb25nZXN0IGNoYWluIGxlbmd0aCAlZFxuIiwNCiAJ
ICAgICAgIHRhZywgYXZjX2NhY2hlLmFjdGl2ZU5vZGVzLCBzbG90c191c2Vk
LCBBVkNfQ0FDSEVfU0xPVFMsIG1heF9jaGFpbl9sZW4pOw0KQEAgLTg3NCw4
ICs4NzUsOSBAQA0KIHsNCiAJYXZjX25vZGVfdCAgICAgKm5vZGU7CQ0KIAlp
bnQgaTsNCisJdW5zaWduZWQgbG9uZyBmbGFnczsNCiANCi0Jc3Bpbl9sb2Nr
KCZhdmNfbG9jayk7DQorCXNwaW5fbG9ja19pcnFzYXZlKCZhdmNfbG9jayxm
bGFncyk7DQogDQogCWlmIChzc2lkID09IFNFQ1NJRF9XSUxEIHx8IHRzaWQg
PT0gU0VDU0lEX1dJTEQpIHsNCiAJCS8qIGFwcGx5IHRvIGFsbCBtYXRjaGlu
ZyBub2RlcyAqLw0KQEAgLTg5Nyw3ICs4OTksNyBAQA0KIAkJfQ0KIAl9DQog
DQotCXNwaW5fdW5sb2NrKCZhdmNfbG9jayk7DQorCXNwaW5fdW5sb2NrX2ly
cXJlc3RvcmUoJmF2Y19sb2NrLGZsYWdzKTsNCiANCiAJcmV0dXJuIDA7DQog
fQ0KQEAgLTkyMiw2ICs5MjQsNyBAQA0KIAlhdmNfY2FsbGJhY2tfbm9kZV90
ICpjOw0KIAlhY2Nlc3NfdmVjdG9yX3QgdHJldGFpbmVkID0gMCwgY3JldGFp
bmVkID0gMDsNCiAJaW50IHJjOw0KKwl1bnNpZ25lZCBsb25nIGZsYWdzOw0K
IA0KIAkvKg0KIAkgKiB0cnlfcmV2b2tlIG9ubHkgcmVtb3ZlcyBwZXJtaXNz
aW9ucyBmcm9tIHRoZSBjYWNoZQ0KQEAgLTk1NiwxMCArOTU5LDEwIEBADQog
CQkqb3V0X3JldGFpbmVkID0gdHJldGFpbmVkOw0KIAl9DQogDQotCXNwaW5f
bG9jaygmYXZjX2xvY2spOw0KKwlzcGluX2xvY2tfaXJxc2F2ZSgmYXZjX2xv
Y2ssZmxhZ3MpOw0KIAlpZiAoc2Vxbm8gPiBhdmNfY2FjaGUubGF0ZXN0X25v
dGlmKQ0KIAkJYXZjX2NhY2hlLmxhdGVzdF9ub3RpZiA9IHNlcW5vOw0KLQlz
cGluX3VubG9jaygmYXZjX2xvY2spOw0KKwlzcGluX3VubG9ja19pcnFyZXN0
b3JlKCZhdmNfbG9jayxmbGFncyk7DQogCQ0KIAlyZXR1cm4gMDsNCiB9DQpA
QCAtMTAyMSwxMCArMTAyNCwxMSBAQA0KIAlpbnQgcmM7DQogCWF2Y19ub2Rl
X3QgICAgICpub2RlLCAqdG1wOw0KIAlpbnQgICAgICAgICAgICAgaTsNCisJ
dW5zaWduZWQgbG9uZyBmbGFnczsNCiANCiAJYXZjX2hhc2hfZXZhbCgicmVz
ZXQiKTsNCiANCi0Jc3Bpbl9sb2NrKCZhdmNfbG9jayk7DQorCXNwaW5fbG9j
a19pcnFzYXZlKCZhdmNfbG9jayxmbGFncyk7DQogDQogCWZvciAoaSA9IDA7
IGkgPCBBVkNfQ0FDSEVfU0xPVFM7IGkrKykgew0KIAkJbm9kZSA9IGF2Y19j
YWNoZS5zbG90c1tpXTsNCkBAIC0xMDQ0LDcgKzEwNDgsNyBAQA0KIAl9DQog
CWF2Y19jYWNoZS5scnVfaGludCA9IDA7DQogDQotCXNwaW5fdW5sb2NrKCZh
dmNfbG9jayk7DQorCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmF2Y19sb2Nr
LGZsYWdzKTsNCiANCiAJZm9yIChpID0gMDsgaSA8IEFWQ19OU1RBVFM7IGkr
KykNCiAJCWF2Y19jYWNoZV9zdGF0c1tpXSA9IDA7DQpAQCAtMTA1OCwxMCAr
MTA2MiwxMCBAQA0KIAkJfQ0KIAl9DQogDQotCXNwaW5fbG9jaygmYXZjX2xv
Y2spOw0KKwlzcGluX2xvY2tfaXJxc2F2ZSgmYXZjX2xvY2ssZmxhZ3MpOw0K
IAlpZiAoc2Vxbm8gPiBhdmNfY2FjaGUubGF0ZXN0X25vdGlmKQ0KIAkJYXZj
X2NhY2hlLmxhdGVzdF9ub3RpZiA9IHNlcW5vOw0KLQlzcGluX3VubG9jaygm
YXZjX2xvY2spOwkNCisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmYXZjX2xv
Y2ssZmxhZ3MpOwkNCiANCiAJcmV0dXJuIDA7DQogfQ0K
---559023410-1804928587-1018963986=:14669--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

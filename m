Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA17868
	for <selinux@tycho.nsa.gov>; Tue, 30 Oct 2001 10:21:16 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA25935
	for <selinux@tycho.nsa.gov>; Tue, 30 Oct 2001 15:20:42 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id PAA25931
	for <selinux@tycho.nsa.gov>; Tue, 30 Oct 2001 15:20:42 GMT
Received: from localhost (sds@localhost)
	by raven.gw.tislabs.com (8.11.6/8.11.6) with ESMTP id f9UFKX210017
	for <selinux@tycho.nsa.gov>; Tue, 30 Oct 2001 10:20:33 -0500 (EST)
Date: Tue, 30 Oct 2001 10:20:33 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH] Bug fix for load_policy
Message-ID: <Pine.GSO.4.33.0110301016270.4537-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1903590565-1004455233=:4537"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1903590565-1004455233=:4537
Content-Type: TEXT/PLAIN; charset=US-ASCII


When the SELinux module is in permissive mode, a bug in the
convert_contexts function used by the load_policy function can leave the
SID table in an inconsistent state when users, roles, or types are
removed from the policy on a running system.  The attached patch fixes
this bug.  To apply, save the attached patch to ~/services.patch, cd
selinux, and run 'patch -p1 < services.patch'.  Then, rebuild the
LSM-patched kernel with the built-in SELinux security module.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-1903590565-1004455233=:4537
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="services.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0110301020330.4537@raven>
Content-Description: 
Content-Disposition: attachment; filename="services.patch"

SW5kZXg6IHNlbGludXgvbW9kdWxlL3NlbGludXhfcGx1Zy9zcy9zZXJ2aWNl
cy5jDQpkaWZmIC11IHNlbGludXgvbW9kdWxlL3NlbGludXhfcGx1Zy9zcy9z
ZXJ2aWNlcy5jOjEuOSBzZWxpbnV4L21vZHVsZS9zZWxpbnV4X3BsdWcvc3Mv
c2VydmljZXMuYzoxLjEwDQotLS0gc2VsaW51eC9tb2R1bGUvc2VsaW51eF9w
bHVnL3NzL3NlcnZpY2VzLmM6MS45CVdlZCBTZXAgMTIgMTE6MzI6MTMgMjAw
MQ0KKysrIHNlbGludXgvbW9kdWxlL3NlbGludXhfcGx1Zy9zcy9zZXJ2aWNl
cy5jCVR1ZSBPY3QgMzAgMDk6NDM6MjggMjAwMQ0KQEAgLTkwOCw4ICs5MDgs
MTkgQEANCiANCiAJLyogQ2hlY2sgdGhlIHZhbGlkaXR5IG9mIHRoZSBuZXcg
Y29udGV4dC4gKi8NCiAJaWYgKCFwb2xpY3lkYl9jb250ZXh0X2lzdmFsaWQo
YXJncy0+bmV3cCwgYykpIHsNCisjaWZkZWYgQ09ORklHX0ZMQVNLX0RFVkVM
T1ANCisJCWlmIChhdmNfZGVidWdfYWx3YXlzX2FsbG93KSB7DQorCQkJY29u
dGV4dF9zdHJ1Y3RfdG9fc3RyaW5nKCZvbGRjLCAmcywgJmxlbik7DQorCQkJ
cHJpbnRmKCJzZWN1cml0eTogIGNvbnRleHQgJXMgaXMgaW52YWxpZFxuIiwg
cyk7DQorCQkJZnJlZShzKTsNCisJCX0gZWxzZSB7DQorCQkJcmMgPSAtRUlO
VkFMOw0KKwkJCWdvdG8gYmFkOw0KKwkJfQ0KKyNlbHNlDQogCQlyYyA9IC1F
SU5WQUw7DQogCQlnb3RvIGJhZDsNCisjZW5kaWYNCiAJfQ0KIA0KIAljb250
ZXh0X2Rlc3Ryb3koJm9sZGMpOw0KQEAgLTkxOCwxNiArOTI5LDcgQEANCiAg
ICAgICBiYWQ6DQogCWNvbnRleHRfc3RydWN0X3RvX3N0cmluZygmb2xkYywg
JnMsICZsZW4pOw0KIAljb250ZXh0X2Rlc3Ryb3koJm9sZGMpOw0KLSNpZmRl
ZiBDT05GSUdfRkxBU0tfREVWRUxPUA0KLQlpZiAoYXZjX2RlYnVnX2Fsd2F5
c19hbGxvdykgew0KLQkJcHJpbnRmKCJzZWN1cml0eTogIGNvbnRleHQgJXMg
aXMgaW52YWxpZFxuIiwgcyk7DQotCQlyYyA9IDA7DQotCX0gZWxzZSB7DQot
CQlwcmludGYoInNlY3VyaXR5OiAgaW52YWxpZGF0aW5nIGNvbnRleHQgJXNc
biIsIHMpOw0KLQl9DQotI2Vsc2UNCiAJcHJpbnRmKCJzZWN1cml0eTogIGlu
dmFsaWRhdGluZyBjb250ZXh0ICVzXG4iLCBzKTsNCi0jZW5kaWYNCiAJZnJl
ZShzKTsNCiAJcmV0dXJuIHJjOw0KIH0NCg==
---559023410-1903590565-1004455233=:4537--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

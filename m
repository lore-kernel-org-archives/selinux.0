Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA08251
	for <selinux@tycho.nsa.gov>; Mon, 22 Oct 2001 15:29:02 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA22187
	for <selinux@tycho.nsa.gov>; Mon, 22 Oct 2001 19:27:05 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id TAA22183
	for <selinux@tycho.nsa.gov>; Mon, 22 Oct 2001 19:27:04 GMT
Received: from localhost (sds@localhost)
	by raven.gw.tislabs.com (8.11.6/8.11.6) with ESMTP id f9MJRsj23364
	for <selinux@tycho.nsa.gov>; Mon, 22 Oct 2001 15:27:54 -0400 (EDT)
Date: Mon, 22 Oct 2001 15:27:54 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH] Missing getscheduler hook
Message-ID: <Pine.GSO.4.33.0110221520470.11349-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-579758561-1003778874=:11349"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-579758561-1003778874=:11349
Content-Type: TEXT/PLAIN; charset=US-ASCII


The attached patch adds a getscheduler hook function to the SELinux
security module.  This hook function was previously missing due to an
oversight.  To apply, save the attachment to ~/module.patch, change to the
selinux directory and run 'patch -p1 < module.patch'.  Then rebuild and
reinstall the LSM kernel with the SELinux module.  Thanks to David Wheeler
for reporting a problem with running mozilla that ultimately led
to the discovery of this bug.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-579758561-1003778874=:11349
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="module.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0110221527540.11349@raven>
Content-Description: 
Content-Disposition: attachment; filename="module.patch"

SW5kZXg6IHNlbGludXgvbW9kdWxlL3NlbGludXhfcGx1Zy9ob29rcy5jDQpk
aWZmIC11IHNlbGludXgvbW9kdWxlL3NlbGludXhfcGx1Zy9ob29rcy5jOjEu
NTUgc2VsaW51eC9tb2R1bGUvc2VsaW51eF9wbHVnL2hvb2tzLmM6MS41OA0K
LS0tIHNlbGludXgvbW9kdWxlL3NlbGludXhfcGx1Zy9ob29rcy5jOjEuNTUJ
VGh1IE9jdCAxMSAxNzo0MDowNyAyMDAxDQorKysgc2VsaW51eC9tb2R1bGUv
c2VsaW51eF9wbHVnL2hvb2tzLmMJVHVlIE9jdCAyMyAwMToxNDo0NiAyMDAx
DQpAQCAtNDM3LDkgKzQzNyw3IEBADQogCQlyZXR1cm4gMDsgLyogY3VycmVu
dGx5IGluaXRpYWxpemluZyAqLw0KIA0KIAlpZiAoKHN0cmNtcChzYi0+c190
eXBlLT5uYW1lLCAiZXh0MiIpID09IDApIHx8DQotCSAgICAoc3RyY21wKHNi
LT5zX3R5cGUtPm5hbWUsICJ1ZnMiKSA9PSAwKSB8fA0KLQkgICAgKHN0cmNt
cChzYi0+c190eXBlLT5uYW1lLCAic3lzdiIpID09IDApIHx8DQotCSAgICAo
c3RyY21wKHNiLT5zX3R5cGUtPm5hbWUsICJ2NyIpID09IDApIHx8DQorCSAg
ICAoc3RyY21wKHNiLT5zX3R5cGUtPm5hbWUsICJleHQzIikgPT0gMCkgfHwN
CiAJICAgIChzdHJjbXAoc2ItPnNfdHlwZS0+bmFtZSwgInJlaXNlcmZzIikg
PT0gMCkpIHsNCiAJCS8qIFBTSURzIG9ubHkgd29yayBmb3IgcGVyc2lzdGVu
dCBmaWxlIHN5c3RlbXMgd2l0aA0KIAkJICAgcGVyc2lzdGVudCBpbm9kZSBu
dW1iZXJzLiAqLw0KQEAgLTIzMzgsOCArMjMzNiw3IEBADQogDQogCQkJaWYg
KChmaWxlLT5mX2ZsYWdzICYgT19BUFBFTkQpICYmICEoYXJnICYgT19BUFBF
TkQpKSB7DQogCQkJCWVyciA9IGZpbGVfaGFzX3Blcm0oY3VycmVudCwgZmls
ZSxGSUxFX19XUklURSk7DQotCQkJCWlmIChlcnIpDQotCQkJCQlicmVhazsN
CisJCQkJYnJlYWs7DQogCQkJfQ0KIAkJCS8qIGZhbGwgdGhyb3VnaCAqLw0K
IAkgICAgICAgIGNhc2UgRl9TRVRPV046DQpAQCAtMjUzMCw2ICsyNTI3LDEx
IEBADQogCXJldHVybiB0YXNrX2hhc19wZXJtKGN1cnJlbnQsIHAsIFBST0NF
U1NfX1NFVFNDSEVEKTsNCiB9DQogDQorc3RhdGljIGludCBzZWxpbnV4X3Rh
c2tfZ2V0c2NoZWR1bGVyKHN0cnVjdCB0YXNrX3N0cnVjdCAqcCkNCit7DQor
CXJldHVybiB0YXNrX2hhc19wZXJtKGN1cnJlbnQsIHAsIFBST0NFU1NfX0dF
VFNDSEVEKTsNCit9DQorDQogc3RhdGljIGludCBzZWxpbnV4X3Rhc2tfa2ls
bChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIHN0cnVjdCBzaWdpbmZvICppbmZv
LCBpbnQgc2lnKQ0KIHsNCiAJYWNjZXNzX3ZlY3Rvcl90IHBlcm07DQpAQCAt
NDE5MCw5ICs0MTkyLDEwIEBADQogCXNldG5pY2U6CXNlbGludXhfdGFza19z
ZXRuaWNlLA0KIAlzZXRybGltaXQ6CXNlbGludXhfdGFza19zZXRybGltaXQs
DQogCXNldHNjaGVkdWxlcjoJc2VsaW51eF90YXNrX3NldHNjaGVkdWxlciwN
CisJZ2V0c2NoZWR1bGVyOglzZWxpbnV4X3Rhc2tfZ2V0c2NoZWR1bGVyLA0K
IAlraWxsOgkJc2VsaW51eF90YXNrX2tpbGwsDQotCXByY3RsOgkJc2VsaW51
eF90YXNrX3ByY3RsLA0KIAl3YWl0OgkJc2VsaW51eF90YXNrX3dhaXQsDQor
CXByY3RsOgkJc2VsaW51eF90YXNrX3ByY3RsLA0KIAlrbW9kX3NldF9sYWJl
bDoJc2VsaW51eF90YXNrX2ttb2Rfc2V0X2xhYmVsLA0KIH07DQogDQpAQCAt
NDI5OSw4ICs0MzAyLDggQEANCiAJY2Fwc2V0X2NoZWNrOgkgICAgICAgIHNl
bGludXhfY2Fwc2V0X2NoZWNrLA0KIAljYXBzZXRfc2V0OgkgICAgICAgIHNl
bGludXhfY2Fwc2V0X3NldCwJDQogCWFjY3Q6CQkJc2VsaW51eF9hY2N0LA0K
LQljYXBhYmxlOiAgICAgICAgICAgICAgICBzZWxpbnV4X2NhcGFibGUsDQog
CXN5c2N0bDoJCQlzZWxpbnV4X3N5c2N0bCwNCisJY2FwYWJsZTogICAgICAg
ICAgICAgICAgc2VsaW51eF9jYXBhYmxlLA0KIAlzeXNfc2VjdXJpdHk6ICAg
ICAgICAgICBzZWxpbnV4X3N5c19zZWN1cml0eSwNCiAJc3dhcG9uOgkJCXNl
bGludXhfc3dhcG9uLA0KIAlzd2Fwb2ZmOgkJc2VsaW51eF9zd2Fwb2ZmLA0K
QEAgLTQzMjAsOSArNDMyMyw5IEBADQogCXNvY2tldF9vcHM6CQkmc2VsaW51
eF9zb2NrZXRfb3BzLA0KIAlza2Jfb3BzOgkJJnNlbGludXhfc2tiX29wcywN
CiAJaXBfb3BzOgkJCSZzZWxpbnV4X2lwX29wcywNCisJbmV0ZGV2X29wczoJ
CSZzZWxpbnV4X25ldGRldl9vcHMsDQogCW1vZHVsZV9vcHM6CQkmc2VsaW51
eF9tb2R1bGVfb3BzLA0KIAlpcGNfb3BzOgkJJnNlbGludXhfaXBjX29wcywN
Ci0JbmV0ZGV2X29wczoJCSZzZWxpbnV4X25ldGRldl9vcHMsDQogCW1zZ19t
c2dfb3BzOgkJJnNlbGludXhfbXNnX21zZ19vcHMsDQogCW1zZ19xdWV1ZV9v
cHM6CQkmc2VsaW51eF9tc2dfcXVldWVfb3BzLA0KIAlzaG1fb3BzOgkJJnNl
bGludXhfc2htX29wcywNCg==
---559023410-579758561-1003778874=:11349--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

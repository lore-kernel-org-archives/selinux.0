Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA05832
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 15:25:48 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA26234
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 19:24:00 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id TAA26230 for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 19:24:00 GMT
Received: from localhost (sds@localhost)
	by raven.gw.tislabs.com (8.11.6/8.11.6) with ESMTP id g8OJPhx06071
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 15:25:43 -0400 (EDT)
Date: Tue, 24 Sep 2002 15:25:42 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: <selinux@tycho.nsa.gov>
Subject: [patch] Check sys_tty_config for KDSKB(S)?ENT ioctls (e.g. loadkeys)
Message-ID: <Pine.GSO.4.33.0209241513290.4584-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-959030623-1032895542=:4584"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-959030623-1032895542=:4584
Content-Type: TEXT/PLAIN; charset=US-ASCII


The attached patch, also committed to the sourceforge CVS tree, changes
the SELinux file_ioctl hook function to check the CAP_SYS_TTY_CONFIG
capability and the corresponding sys_tty_config capability permission when
the KDSKBENT or KDSKBSENT ioctls are used.  In combination with an
appropriate policy (e.g. removing sys_tty_config permission from
policy/macros/user_macros.te), this change addresses the concern raised by
an earlier message by Russell Coker, see
http://marc.theaimsgroup.com/?l=selinux&m=103122430232003&w=2.  It may be
desirable to also place some of the other console ioctls under similar
control.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-959030623-1032895542=:4584
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="kdskbent.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0209241525420.4584@raven>
Content-Description: 
Content-Disposition: attachment; filename="kdskbent.patch"

SW5kZXg6IGxzbS0yLjQvc2VjdXJpdHkvc2VsaW51eC9ob29rcy5jDQo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2c3Jvb3Qvc2VsaW51
eC9uc2EvbHNtLTIuNC9zZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMsdg0KcmV0
cmlldmluZyByZXZpc2lvbiAxLjE4DQpkaWZmIC11IC1yMS4xOCBob29rcy5j
DQotLS0gbHNtLTIuNC9zZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMJMjQgU2Vw
IDIwMDIgMTc6NTE6NTYgLTAwMDAJMS4xOA0KKysrIGxzbS0yLjQvc2VjdXJp
dHkvc2VsaW51eC9ob29rcy5jCTI0IFNlcCAyMDAyIDE5OjA2OjQ4IC0wMDAw
DQpAQCAtMzcsNiArMzcsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9maWxlLmg+
DQogI2luY2x1ZGUgPGxpbnV4L2V4dDJfZnMuaD4NCiAjaW5jbHVkZSA8bGlu
dXgvcHJvY19mcy5oPg0KKyNpbmNsdWRlIDxsaW51eC9rZC5oPg0KICNpbmNs
dWRlIDxuZXQvaWNtcC5oPg0KICNpbmNsdWRlIDxuZXQvaXAuaD4JCS8qIGZv
ciBzeXNjdGxfbG9jYWxfcG9ydF9yYW5nZVtdICovDQogI2luY2x1ZGUgPG5l
dC90Y3AuaD4JCS8qIHN0cnVjdCBvcl9jYWxsYWJsZSB1c2VkIGluIHNvY2tf
cmN2X3NrYiAqLw0KQEAgLTIzMTMsNiArMjMxNCwxMiBAQA0KIAkJLyogZmFs
bCB0aHJvdWdoICovDQogCQljYXNlIEZJT0FTWU5DOg0KIAkJCWVycm9yID0g
ZmlsZV9oYXNfcGVybShjdXJyZW50LCBmaWxlLCAwKTsNCisJCQlicmVhazsN
CisNCisJICAgICAgICBjYXNlIEtEU0tCRU5UOg0KKwkgICAgICAgIGNhc2Ug
S0RTS0JTRU5UOg0KKwkJICAJaWYgKCFjYXBhYmxlKENBUF9TWVNfVFRZX0NP
TkZJRykpDQorCQkJCWVycm9yID0gLUVQRVJNOw0KIAkJCWJyZWFrOw0KIA0K
IAkJLyogZGVmYXVsdCBjYXNlIGFzc3VtZXMgdGhhdCB0aGUgY29tbWFuZCB3
aWxsIGdvDQo=
---559023410-959030623-1032895542=:4584--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

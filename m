Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA05956
	for <selinux@tycho.nsa.gov>; Mon, 9 Sep 2002 07:48:38 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA00495
	for <selinux@tycho.nsa.gov>; Mon, 9 Sep 2002 11:46:54 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id LAA00491 for <selinux@tycho.nsa.gov>; Mon, 9 Sep 2002 11:46:53 GMT
Received: from localhost (sds@localhost)
	by raven.gw.tislabs.com (8.11.6/8.11.6) with ESMTP id g89BmRG21837
	for <selinux@tycho.nsa.gov>; Mon, 9 Sep 2002 07:48:27 -0400 (EDT)
Date: Mon, 9 Sep 2002 07:48:27 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: <selinux@tycho.nsa.gov>
Subject: [patch] Fix constraint evaluation
Message-ID: <Pine.GSO.4.33.0209090746190.21204-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-684387517-1031572000=:21204"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-684387517-1031572000=:21204
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.33.0209090746531.21204@raven>


The attached patch (also committed to the sourceforge CVS tree) fixes a
bug in the constraint evaluation code of the security server.  This bug
is _not_ triggered by the set of constraints in the example policy
configuration, but could be triggered if you have customized your
constraints.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-684387517-1031572000=:21204
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="constrainteval.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0209090746400.21204@raven>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="constrainteval.patch"

SW5kZXg6IGxzbS0yLjQvc2VjdXJpdHkvc2VsaW51eC9zcy9zZXJ2aWNlcy5j
DQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2c3Jvb3Qv
c2VsaW51eC9uc2EvbHNtLTIuNC9zZWN1cml0eS9zZWxpbnV4L3NzL3NlcnZp
Y2VzLmMsdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjcNCmRpZmYgLXUgLXIx
Ljcgc2VydmljZXMuYw0KLS0tIGxzbS0yLjQvc2VjdXJpdHkvc2VsaW51eC9z
cy9zZXJ2aWNlcy5jCTUgSnVsIDIwMDIgMTE6MDY6MzcgLTAwMDAJMS43DQor
KysgbHNtLTIuNC9zZWN1cml0eS9zZWxpbnV4L3NzL3NlcnZpY2VzLmMJNiBT
ZXAgMjAwMiAxOToyNDoyNSAtMDAwMA0KQEAgLTEwNCw4ICsxMDQsMTYgQEAN
CiAJCQl2YWwxID0gYy0+dHlwZTsNCiAJCWVsc2UgDQogCQkJcmV0dXJuIDA7
DQotCQkNCi0JCXJldHVybiBlYml0bWFwX2dldF9iaXQoJmV4cHItPm5hbWVz
LCB2YWwxIC0gMSk7DQorDQorCQlzd2l0Y2ggKGV4cHItPm9wKSB7DQorCQlj
YXNlIENFWFBSX0VROg0KKwkJCXJldHVybiBlYml0bWFwX2dldF9iaXQoJmV4
cHItPm5hbWVzLCB2YWwxIC0gMSk7DQorCQljYXNlIENFWFBSX05FUToNCisJ
CQlyZXR1cm4gIWViaXRtYXBfZ2V0X2JpdCgmZXhwci0+bmFtZXMsIHZhbDEg
LSAxKTsNCisJCWRlZmF1bHQ6DQorCQkJcmV0dXJuIDA7DQorCQl9DQorCQly
ZXR1cm4gMDsNCiAJZGVmYXVsdDoNCiAJCXJldHVybiAwOw0KIAl9DQo=
---559023410-684387517-1031572000=:21204--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA08809
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2001 13:04:22 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA02121
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2001 17:03:06 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id RAA02117
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2001 17:03:05 GMT
Received: from localhost by clipper.gw.tislabs.com (8.9.3/8.9.1) with SMTP id NAA07583
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2001 13:03:55 -0400 (EDT)
Date: Fri, 24 Aug 2001 13:03:55 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Bug fix for sys_acct
Message-ID: <Pine.SOL.3.95.1010824130117.1386R-200000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1144747756-998672520=:1386"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1144747756-998672520=:1386
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.SOL.3.95.1010824130205.1386U@clipper.gw.tislabs.com>


I've attached a bug fix patch for lsm/kernel/acct.c.
Thanks to Lachlan McIlroy for noticing this bug and
mentioning it on the linux-security-module mailing list.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




---559023410-1144747756-998672520=:1386
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="acct.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.3.95.1010824130200.1386S@clipper.gw.tislabs.com>
Content-Description: acct.patch

SW5kZXg6IGxzbS9rZXJuZWwvYWNjdC5jDQpkaWZmIC11IGxzbS9rZXJuZWwv
YWNjdC5jOjEuMiBsc20va2VybmVsL2FjY3QuYzoxLjMNCi0tLSBsc20va2Vy
bmVsL2FjY3QuYzoxLjIJTW9uIEp1biAxMSAxNjoyOTowOSAyMDAxDQorKysg
bHNtL2tlcm5lbC9hY2N0LmMJRnJpIEF1ZyAyNCAwOToyOTo1OCAyMDAxDQpA
QCAtMjEzLDcgKzIxMyw4IEBADQogb3V0Og0KIAlyZXR1cm4gZXJyb3I7DQog
b3V0X2VycjoNCi0JZmlscF9jbG9zZShmaWxlLCBOVUxMKTsNCisJaWYgKGZp
bGUpDQorCQlmaWxwX2Nsb3NlKGZpbGUsIE5VTEwpOw0KIAlnb3RvIG91dDsN
CiB9DQogDQo=
---559023410-1144747756-998672520=:1386--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

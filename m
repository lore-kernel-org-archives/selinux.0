Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA13438
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2001 12:13:55 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA24497
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2001 16:13:31 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id QAA24493
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2001 16:13:30 GMT
Received: from localhost by clipper.gw.tislabs.com (8.9.3/8.9.1) with SMTP id MAA09395
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2001 12:13:27 -0400 (EDT)
Date: Tue, 4 Sep 2001 12:13:26 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Fix for selinux_ip_postroute hook
Message-ID: <Pine.SOL.3.95.1010904120820.319L-200000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1251336619-999619829=:319"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1251336619-999619829=:319
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.SOL.3.95.1010904121110.319O@clipper.gw.tislabs.com>


I've attached a patch for selinux/module/selinux_plug/hooks.c that
fixes a bug in the selinux_ip_postroute hook that was causing the 
copy of multicast or broadcast packets destined for local processes to 
be dropped.  To apply this patch, save it to hooks.patch, change to the
selinux directory, and run 'patch -p1 < hooks.patch'.  This patch
will be included in the next release.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-1251336619-999619829=:319
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="hooks.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.3.95.1010904121029.319M@clipper.gw.tislabs.com>
Content-Description: 

SW5kZXg6IHNlbGludXgvbW9kdWxlL3NlbGludXhfcGx1Zy9ob29rcy5jDQpk
aWZmIC11IHNlbGludXgvbW9kdWxlL3NlbGludXhfcGx1Zy9ob29rcy5jOjEu
MTIyIHNlbGludXgvbW9kdWxlL3NlbGludXhfcGx1Zy9ob29rcy5jOjEuMTIz
DQotLS0gc2VsaW51eC9tb2R1bGUvc2VsaW51eF9wbHVnL2hvb2tzLmM6MS4x
MjIJRnJpIEF1ZyAzMSAxMDoxNzozMiAyMDAxDQorKysgc2VsaW51eC9tb2R1
bGUvc2VsaW51eF9wbHVnL2hvb2tzLmMJRnJpIEF1ZyAzMSAxNDoyMjowNCAy
MDAxDQpAQCAtMjY4Miw5ICsyNjgyLDcgQEANCiAJfQ0KIA0KIAlpZiAoc2sg
PT0gTlVMTCkgew0KLQkJcHJpbnRrKCJzZWxpbnV4X2lwX3Bvc3Ryb3V0ZTog
c2sgaXMgbnVsbFxuIik7DQotLyogCQluZl9kdW1wX3NrYihQRl9JTkVULCBz
a2IpOyAqLw0KLQkJcmV0dXJuIE5GX0RST1A7DQorCQlyZXR1cm4gTkZfQUND
RVBUOw0KIAl9DQogCXNvY2sgPSBzay0+c29ja2V0Ow0KIA0K
---559023410-1251336619-999619829=:319--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA22142
	for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2001 14:00:57 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA01965
	for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2001 17:59:13 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id RAA01961
	for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2001 17:59:12 GMT
Received: from localhost (sds@localhost)
	by raven.gw.tislabs.com (8.11.6/8.11.6) with ESMTP id f93I0EW03432
	for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2001 14:00:16 -0400 (EDT)
Date: Wed, 3 Oct 2001 14:00:14 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH] Bug fix for the dummy and SELinux netlink_send hooks
Message-ID: <Pine.GSO.4.33.0110031351540.2339-300000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-758783491-1002131552=:2339"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-758783491-1002131552=:2339
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.33.0110031353031.2339@raven>


The attached patches fix a bug that occurs in netlink_send hook functions
for both the dummy security module and the SELinux security module.  This
bug causes incorrect permission denials for netlink messages.  Thanks to
James Morris for finding this bug.  To apply the first patch, save it to
'lsm-netlink.patch', change to the lsm directory and run 'patch -p1 <
~/lsm-netlink.patch'.  To apply the second patch, save it to
'selinux-netlink.patch', change to the selinux directory, and run
'patch -p1 < ~/selinux-netlink.patch'.  Then, rebuild and reinstall the
kernel in the usual way.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




---559023410-758783491-1002131552=:2339
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="lsm-netlink.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0110031352320.2339@raven>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="lsm-netlink.patch"

SW5kZXg6IGxzbS9zZWN1cml0eS9kdW1teS5jDQpkaWZmIC11IGxzbS9zZWN1
cml0eS9kdW1teS5jOjEuNCBsc20vc2VjdXJpdHkvZHVtbXkuYzoxLjYNCi0t
LSBsc20vc2VjdXJpdHkvZHVtbXkuYzoxLjQJRnJpIFNlcCAyOCAxMToxNDoy
NiAyMDAxDQorKysgbHNtL3NlY3VyaXR5L2R1bW15LmMJV2VkIE9jdCAgMyAx
MzozNzo1NyAyMDAxDQpAQCAtMTM1LDcgKzEzNSw3IEBADQogc3RhdGljIGlu
dCBkdW1teV9uZXRsaW5rX3NlbmQgKHN0cnVjdCBza19idWZmICpza2IpDQog
ew0KIAlpZiAoY3VycmVudC0+ZXVpZCA9PSAwKQ0KLQkJTkVUTElOS19DQiAo
c2tiKS5lZmZfY2FwID0gQ0FQX05FVF9BRE1JTjsNCisJCWNhcF9yYWlzZSAo
TkVUTElOS19DQiAoc2tiKS5lZmZfY2FwLCBDQVBfTkVUX0FETUlOKTsNCiAJ
ZWxzZQ0KIAkJTkVUTElOS19DQiAoc2tiKS5lZmZfY2FwID0gMDsNCiAJcmV0
dXJuIDA7DQo=
---559023410-758783491-1002131552=:2339
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="selinux-netlink.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0110031352321.2339@raven>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="selinux-netlink.patch"

SW5kZXg6IHNlbGludXgvbW9kdWxlL3NlbGludXhfcGx1Zy9ob29rcy5jDQpk
aWZmIC11IHNlbGludXgvbW9kdWxlL3NlbGludXhfcGx1Zy9ob29rcy5jOjEu
MTQwIHNlbGludXgvbW9kdWxlL3NlbGludXhfcGx1Zy9ob29rcy5jOjEuMTQy
DQotLS0gc2VsaW51eC9tb2R1bGUvc2VsaW51eF9wbHVnL2hvb2tzLmM6MS4x
NDAJRnJpIFNlcCAyOCAxMToyMjoyMSAyMDAxDQorKysgc2VsaW51eC9tb2R1
bGUvc2VsaW51eF9wbHVnL2hvb2tzLmMJV2VkIE9jdCAgMyAxMzozOTo0MSAy
MDAxDQpAQCAtMTY5NSw3ICsxNjk1LDcgQEANCiBzdGF0aWMgaW50IHNlbGlu
dXhfbmV0bGlua19zZW5kKHN0cnVjdCBza19idWZmICpza2IpICANCiB7DQog
CWlmIChjYXBhYmxlKENBUF9ORVRfQURNSU4pKQ0KLQkJTkVUTElOS19DQihz
a2IpLmVmZl9jYXAgPSBDQVBfTkVUX0FETUlOOw0KKwkJY2FwX3JhaXNlIChO
RVRMSU5LX0NCIChza2IpLmVmZl9jYXAsIENBUF9ORVRfQURNSU4pOw0KIAll
bHNlDQogCQlORVRMSU5LX0NCKHNrYikuZWZmX2NhcCA9IDA7DQogCXJldHVy
biAwOw0K
---559023410-758783491-1002131552=:2339--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA05092
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 14:49:13 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA24071
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 18:47:26 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id SAA24067 for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 18:47:25 GMT
Received: from localhost (sds@localhost)
	by raven.gw.tislabs.com (8.11.6/8.11.6) with ESMTP id g8OImYi03932
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 14:48:34 -0400 (EDT)
Date: Tue, 24 Sep 2002 14:48:34 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: <selinux@tycho.nsa.gov>
Subject: [patch] Fix bug in extsocket_sendmsg
Message-ID: <Pine.GSO.4.33.0209241446340.23277-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-630072926-1032893314=:23277"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-630072926-1032893314=:23277
Content-Type: TEXT/PLAIN; charset=US-ASCII


The attached patch (also committed to the sourceforge CVS tree) fixes a
bug in the extsocket_sendmsg function when sendmsg is called on a TCP
socket that is not yet connected.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-630072926-1032893314=:23277
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="sendmsg.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0209241448341.23277@raven>
Content-Description: 
Content-Disposition: attachment; filename="sendmsg.patch"

SW5kZXg6IGxzbS0yLjQvc2VjdXJpdHkvc2VsaW51eC9leHRzb2NrZXQuaA0K
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KUkNTIGZpbGU6IC9jdnNyb290L3Nl
bGludXgvbnNhL2xzbS0yLjQvc2VjdXJpdHkvc2VsaW51eC9leHRzb2NrZXQu
aCx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMS4xLjINCmRpZmYgLXUgLXIx
LjEuMS4yIGV4dHNvY2tldC5oDQotLS0gbHNtLTIuNC9zZWN1cml0eS9zZWxp
bnV4L2V4dHNvY2tldC5oCTIzIEF1ZyAyMDAyIDE3OjI1OjEwIC0wMDAwCTEu
MS4xLjINCisrKyBsc20tMi40L3NlY3VyaXR5L3NlbGludXgvZXh0c29ja2V0
LmgJMjQgU2VwIDIwMDIgMTg6NDI6NTcgLTAwMDANCkBAIC0yOTgsNyArMjk4
LDcgQEANCiAJCS8qIFRoZSBvbmx5IHBvc3NpYmxlIGRlc3RpbmF0aW9uIGlz
IHRoZSBjb25uZWN0ZWQgcGVlci4gKi8NCiAJCWlmIChkc29fc2lkICYmIGRz
b19zaWQgIT0gaXNlYy0+cGVlcl9zaWQpIA0KIAkJCXJldHVybiAtRUFDQ0VT
Ow0KLQkJaWYgKGlzZWMtPnNjbGFzcyA9PSBTRUNDTEFTU19UQ1BfU09DS0VU
KSB7DQorCQlpZiAoaXNlYy0+c2NsYXNzID09IFNFQ0NMQVNTX1RDUF9TT0NL
RVQgJiYgaXNlYy0+Y29ubl9wZXJtKSB7DQogCQkJLyogUmV2YWxpZGF0ZSB0
aGUgY29ubmVjdGlvbiBwZXJtaXNzaW9uLiAqLw0KIAkJCWVyciA9IGF2Y19o
YXNfcGVybV9hdWRpdChpc2VjLT5zaWQsIGlzZWMtPnBlZXJfc2lkLA0KIAkJ
CQkJCSBpc2VjLT5zY2xhc3MsIGlzZWMtPmNvbm5fcGVybSwgDQo=
---559023410-630072926-1032893314=:23277--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

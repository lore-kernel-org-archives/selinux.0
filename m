Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA05939
	for <selinux@tycho.nsa.gov>; Mon, 9 Sep 2002 07:46:38 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA25101
	for <selinux@tycho.nsa.gov>; Mon, 9 Sep 2002 11:45:20 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id LAA25097
	for <selinux@tycho.nsa.gov>; Mon, 9 Sep 2002 11:45:19 GMT
Received: from localhost (sds@localhost)
	by raven.gw.tislabs.com (8.11.6/8.11.6) with ESMTP id g89BjiP21813
	for <selinux@tycho.nsa.gov>; Mon, 9 Sep 2002 07:45:44 -0400 (EDT)
Date: Mon, 9 Sep 2002 07:45:44 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: <selinux@tycho.nsa.gov>
Subject: [patch] Fix audit output for name_bind permission check
Message-ID: <Pine.GSO.4.33.0209090737370.21204-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-959030623-1031571534=:21204"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-959030623-1031571534=:21204
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.33.0209090742591.21204@raven>


The attached patch (also committed to the sourceforge CVS tree) fixes the
audit output for the name_bind permission check, eliminating a duplicate
ntohs() call.  To apply, save this patch to ~/auditport.patch, cd lsm-2.4
and patch -p1 < ~/auditport.patch.  Then rebuild your kernel.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-959030623-1031571534=:21204
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="auditport.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0209090738540.21204@raven>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="auditport.patch"

SW5kZXg6IGxzbS0yLjQvc2VjdXJpdHkvc2VsaW51eC9hdmMuYw0KPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQ0KUkNTIGZpbGU6IC9jdnNyb290L3NlbGludXgv
bnNhL2xzbS0yLjQvc2VjdXJpdHkvc2VsaW51eC9hdmMuYyx2DQpyZXRyaWV2
aW5nIHJldmlzaW9uIDEuNw0KZGlmZiAtdSAtcjEuNyBhdmMuYw0KLS0tIGxz
bS0yLjQvc2VjdXJpdHkvc2VsaW51eC9hdmMuYwkzIEp1biAyMDAyIDEzOjQ2
OjUxIC0wMDAwCTEuNw0KKysrIGxzbS0yLjQvc2VjdXJpdHkvc2VsaW51eC9h
dmMuYwk2IFNlcCAyMDAyIDE5OjI0OjA5IC0wMDAwDQpAQCAtNzM1LDkgKzcz
NSw5IEBADQogCQkJCXByaW50aygiIGRhZGRyPSVkLiVkLiVkLiVkIiwgDQog
CQkJCSAgICAgICBOSVBRVUFEKGEtPnUubmV0LmRhZGRyKSk7DQogCQkJCWlm
IChhLT51Lm5ldC5wb3J0KQ0KLQkJCQkJcHJpbnRrKCIgZGVzdD0lZCIsIG50
b2hzKGEtPnUubmV0LnBvcnQpKTsNCisJCQkJCXByaW50aygiIGRlc3Q9JWQi
LCBhLT51Lm5ldC5wb3J0KTsNCiAJCQl9IGVsc2UgaWYgKGEtPnUubmV0LnBv
cnQpDQotCQkJCXByaW50aygiIHBvcnQ9JWQiLCBudG9ocyhhLT51Lm5ldC5w
b3J0KSk7DQorCQkJCXByaW50aygiIHBvcnQ9JWQiLCBhLT51Lm5ldC5wb3J0
KTsNCiAJCQlpZiAoYS0+dS5uZXQuc2tiKSB7DQogCQkJCXN0cnVjdCBza19i
dWZmICpza2IgPSBhLT51Lm5ldC5za2I7DQogDQo=
---559023410-959030623-1031571534=:21204--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

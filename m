Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA28134
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 13:33:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA12083
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 17:31:49 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id RAA12079
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 17:31:49 GMT
Received: from localhost (sds@localhost)
	by raven.gw.tislabs.com (8.11.6/8.11.6) with ESMTP id g3NHXNN14372
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 13:33:23 -0400 (EDT)
Date: Tue, 23 Apr 2002 13:33:23 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: <selinux@tycho.nsa.gov>
Subject: [patch] avoid deadlock in task_setscheduler
Message-ID: <Pine.GSO.4.33.0204231329550.3983-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-824023566-1019583079=:3983"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-824023566-1019583079=:3983
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.33.0204231331321.3983@raven>


The attached patch addresses a deadlock in the task_setscheduler hook,
which is called with the run queue lock held.  To apply, cd lsm-2.4 &&
patch -p1 < ~/setscheduler.patch.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-824023566-1019583079=:3983
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="setscheduler.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0204231331190.3983@raven>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="setscheduler.patch"

SW5kZXg6IGxzbS0yLjQvc2VjdXJpdHkvc2VsaW51eC9hdmMuYw0KZGlmZiAt
dSBsc20tMi40L3NlY3VyaXR5L3NlbGludXgvYXZjLmM6MS41IGxzbS0yLjQv
c2VjdXJpdHkvc2VsaW51eC9hdmMuYzoxLjYNCi0tLSBsc20tMi40L3NlY3Vy
aXR5L3NlbGludXgvYXZjLmM6MS41CVR1ZSBBcHIgMTYgMDg6MTE6MTQgMjAw
Mg0KKysrIGxzbS0yLjQvc2VjdXJpdHkvc2VsaW51eC9hdmMuYwlUdWUgQXBy
IDIzIDEwOjM5OjUzIDIwMDINCkBAIC02MTgsNiArNjE4LDkgQEANCiB7DQog
CWNoYXIgKnA7DQogDQorCWlmIChhICYmIGEtPnR5cGUgPT0gQVZDX0FVRElU
X0RBVEFfRE9OVEFVRElUKQ0KKwkJcmV0dXJuOw0KKw0KIAlpZiAoIWNoZWNr
X2F2Y19yYXRlbGltaXQoKSkNCiAJCXJldHVybjsNCiANCkluZGV4OiBsc20t
Mi40L3NlY3VyaXR5L3NlbGludXgvaG9va3MuYw0KZGlmZiAtdSBsc20tMi40
L3NlY3VyaXR5L3NlbGludXgvaG9va3MuYzoxLjU0IGxzbS0yLjQvc2VjdXJp
dHkvc2VsaW51eC9ob29rcy5jOjEuNTUNCi0tLSBsc20tMi40L3NlY3VyaXR5
L3NlbGludXgvaG9va3MuYzoxLjU0CU1vbiBBcHIgMjIgMTE6MDk6MTcgMjAw
Mg0KKysrIGxzbS0yLjQvc2VjdXJpdHkvc2VsaW51eC9ob29rcy5jCVR1ZSBB
cHIgMjMgMTA6Mzk6NTMgMjAwMg0KQEAgLTI2NTgsNyArMjY1OCwyNSBAQA0K
IA0KIHN0YXRpYyBpbnQgc2VsaW51eF90YXNrX3NldHNjaGVkdWxlcihzdHJ1
Y3QgdGFza19zdHJ1Y3QgKnAsIGludCBwb2xpY3ksIHN0cnVjdCBzY2hlZF9w
YXJhbSAqbHApDQogew0KLQlyZXR1cm4gdGFza19oYXNfcGVybShjdXJyZW50
LCBwLCBQUk9DRVNTX19TRVRTQ0hFRCk7DQorCWF2Y19hdWRpdF9kYXRhX3Qg
YWQ7DQorCXN0cnVjdCB0YXNrX3NlY3VyaXR5X3N0cnVjdCAqdHNlYzEsICp0
c2VjMjsNCisJaW50IHJjOw0KKw0KKwlyYyA9IHRhc2tfcHJlY29uZGl0aW9u
KGN1cnJlbnQpOw0KKwlpZiAocmMgPD0gMCkNCisJCXJldHVybiByYzsNCisJ
cmMgPSB0YXNrX3ByZWNvbmRpdGlvbihwKTsNCisJaWYgKHJjIDw9IDApDQor
CQlyZXR1cm4gcmM7DQorCXRzZWMxID0gY3VycmVudC0+c2VjdXJpdHk7DQor
CXRzZWMyID0gcC0+c2VjdXJpdHk7DQorDQorCS8qIE5vIGF1ZGl0aW5nIGZy
b20gdGhlIHNldHNjaGVkdWxlciBob29rLCBzaW5jZSB0aGUgcnVucXVldWUg
bG9jaw0KKwkgICBpcyBoZWxkIGFuZCB0aGUgc3lzdGVtIHdpbGwgZGVhZGxv
Y2sgaWYgd2UgdHJ5IHRvIGxvZyBhbiBhdWRpdA0KKwkgICBtZXNzYWdlLiAq
Lw0KKwlBVkNfQVVESVRfREFUQV9JTklUKCZhZCwgRE9OVEFVRElUKTsNCisJ
cmV0dXJuIGF2Y19oYXNfcGVybV9yZWZfYXVkaXQodHNlYzEtPnNpZCwgdHNl
YzItPnNpZCwgDQorCQkJCSAgICAgIFNFQ0NMQVNTX1BST0NFU1MsIFBST0NF
U1NfX1NFVFNDSEVELCAmdHNlYzItPmF2Y3IsICZhZCk7DQogfQ0KIA0KIHN0
YXRpYyBpbnQgc2VsaW51eF90YXNrX2dldHNjaGVkdWxlcihzdHJ1Y3QgdGFz
a19zdHJ1Y3QgKnApDQpJbmRleDogbHNtLTIuNC9zZWN1cml0eS9zZWxpbnV4
L2luY2x1ZGUvbGludXgvZmxhc2svYXZjLmgNCmRpZmYgLXUgbHNtLTIuNC9z
ZWN1cml0eS9zZWxpbnV4L2luY2x1ZGUvbGludXgvZmxhc2svYXZjLmg6MS4x
IGxzbS0yLjQvc2VjdXJpdHkvc2VsaW51eC9pbmNsdWRlL2xpbnV4L2ZsYXNr
L2F2Yy5oOjEuMg0KLS0tIGxzbS0yLjQvc2VjdXJpdHkvc2VsaW51eC9pbmNs
dWRlL2xpbnV4L2ZsYXNrL2F2Yy5oOjEuMQlGcmkgRGVjICA3IDA5OjMyOjU5
IDIwMDENCisrKyBsc20tMi40L3NlY3VyaXR5L3NlbGludXgvaW5jbHVkZS9s
aW51eC9mbGFzay9hdmMuaAlUdWUgQXByIDIzIDEwOjM5OjUzIDIwMDINCkBA
IC03Miw2ICs3Miw3IEBADQogI2RlZmluZSBBVkNfQVVESVRfREFUQV9ORVQg
IDINCiAjZGVmaW5lIEFWQ19BVURJVF9EQVRBX0NBUCAgMw0KICNkZWZpbmUg
QVZDX0FVRElUX0RBVEFfSVBDICA0DQorI2RlZmluZSBBVkNfQVVESVRfREFU
QV9ET05UQVVESVQgNSAvKiBuZXZlciBhdWRpdCB0aGlzIHBlcm1pc3Npb24g
Y2hlY2sgKi8NCiAJdW5pb24gCXsNCiAJCXN0cnVjdCB7DQogCQkJc3RydWN0
IGRlbnRyeSAqZGVudHJ5Ow0K
---559023410-824023566-1019583079=:3983--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

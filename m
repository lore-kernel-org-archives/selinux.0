Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA05553
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 08:29:55 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA19507
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 12:28:24 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id MAA19503 for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 12:28:24 GMT
Received: from localhost (sds@localhost)
	by raven.gw.tislabs.com (8.11.6/8.11.6) with ESMTP id g6FCTCH01761
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 08:29:12 -0400 (EDT)
Date: Mon, 15 Jul 2002 08:29:12 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: <selinux@tycho.nsa.gov>
Subject: [patch] general_file_read_access
Message-ID: <Pine.GSO.4.33.0207150826100.29432-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-33463914-1026736152=:29432"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-33463914-1026736152=:29432
Content-Type: TEXT/PLAIN; charset=US-ASCII


The attached patch (also committed to the sourceforge CVS tree) fixes an
error in the general_file_read_access macro that was introduced when the
base_file_read_access macro was defined.  By using 'domain' instead of
'$1', the macro was applying base_file_read_access to every domain rather
than the parameter domain.  To apply, save the patch to ~/file_read.patch,
cd selinux && patch -p0 < ~/file_read.patch.  Then rebuild and reload your
policy.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-33463914-1026736152=:29432
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="file_read.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0207150829120.29432@raven>
Content-Description: 
Content-Disposition: attachment; filename="file_read.patch"

SW5kZXg6IHBvbGljeS9tYWNyb3MvZ2xvYmFsX21hY3Jvcy50ZQ0KPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQ0KUkNTIGZpbGU6IC9jdnNyb290L3NlbGludXgv
bnNhL3NlbGludXgvcG9saWN5L21hY3Jvcy9nbG9iYWxfbWFjcm9zLnRlLHYN
CnJldHJpZXZpbmcgcmV2aXNpb24gMS40DQpkaWZmIC11IC1yMS40IGdsb2Jh
bF9tYWNyb3MudGUNCi0tLSBwb2xpY3kvbWFjcm9zL2dsb2JhbF9tYWNyb3Mu
dGUJOCBKdWwgMjAwMiAxMjoxNzowMCAtMDAwMAkxLjQNCisrKyBwb2xpY3kv
bWFjcm9zL2dsb2JhbF9tYWNyb3MudGUJMTUgSnVsIDIwMDIgMTI6MjQ6MjUg
LTAwMDANCkBAIC02NDIsNyArNjQyLDcgQEANCiAjIEdldCBhdHRyaWJ1dGVz
IG9mIGZpbGUgc3lzdGVtcy4NCiBhbGxvdyAkMSBmc190eXBlOmZpbGVzeXN0
ZW0gZ2V0YXR0cjsNCiANCi1iYXNlX2ZpbGVfcmVhZF9hY2Nlc3MoZG9tYWlu
KQ0KK2Jhc2VfZmlsZV9yZWFkX2FjY2VzcygkMSkNCiANCiAjIFJlYWQgZGly
ZWN0b3JpZXMgYW5kIGZpbGVzIHdpdGggdGhlIHJlYWRhYmxlX3QgdHlwZS4N
CiAjIFRoaXMgdHlwZSBpcyBhIGdlbmVyYWwgdHlwZSBmb3IgIndvcmxkIi1y
ZWFkYWJsZSBmaWxlcy4NCg==
---559023410-33463914-1026736152=:29432--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

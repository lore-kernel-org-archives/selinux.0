Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA12938
	for <selinux@tycho.nsa.gov>; Thu, 19 Sep 2002 09:48:58 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA13495
	for <selinux@tycho.nsa.gov>; Thu, 19 Sep 2002 13:47:28 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA13491
	for <selinux@tycho.nsa.gov>; Thu, 19 Sep 2002 13:47:26 GMT
Date: Thu, 19 Sep 2002 09:48:30 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: setfiles buglet
In-Reply-To: <200209182132.25322.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0209190939590.8887-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-684387517-1032442896=:8887"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-684387517-1032442896=:8887
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.33.0209190942181.8887@raven>


On Wed, 18 Sep 2002, Russell Coker wrote:

> I think that either the documentation should mention that running in single
> user mode is a good idea (something I should have done when writing the man
> page), or it should stat the files again before changing the permissions
> (which still probably won't be flawless so changing the documentation is
> probably necessary).

I'd agree that running setfiles in single user mode is preferable.
However, to reduce the likelihood of this problem occurring on a live
system, the attached patch modifies setfiles to stat the file again and
verify that the file still exists with the same inode number.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-684387517-1032442896=:8887
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="setfiles.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0209190941360.8887@raven>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="setfiles.patch"

SW5kZXg6IHNlbGludXgvc2V0ZmlsZXMvc2V0ZmlsZXMuYw0KPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQ0KUkNTIGZpbGU6IC9jdnMvbHNtL3NlbGludXgvc2V0
ZmlsZXMvc2V0ZmlsZXMuYyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMTMN
CmRpZmYgLXUgLXIxLjEzIHNldGZpbGVzLmMNCi0tLSBzZWxpbnV4L3NldGZp
bGVzL3NldGZpbGVzLmMJMjAwMi8wNy8wOSAxNjoxODo1OAkxLjEzDQorKysg
c2VsaW51eC9zZXRmaWxlcy9zZXRmaWxlcy5jCTIwMDIvMDkvMTkgMTM6Mzc6
MTENCkBAIC0xNDksMTIgKzE0OSwyOSBAQA0KIHN0YXRpYyBmaWxlX3NwZWNf
dCAqZmlsZV9zcGVjX2FkZChpbm9fdCBpbm8sIGludCBzcGVjaW5kLCBjb25z
dCBjaGFyICpmaWxlKQ0KIHsNCiAJZmlsZV9zcGVjX3QgKnByZXZmbCwgKmZs
Ow0KLQlpbnQgaCwgbm9fY29uZmxpY3Q7DQorCWludCBoLCBub19jb25mbGlj
dCwgcmV0Ow0KKwlzdHJ1Y3Qgc3RhdCBzYjsNCiANCiAJaCA9IChpbm8gKyAo
aW5vID4+IEhBU0hfQklUUykpICYgSEFTSF9NQVNLOw0KIAlmb3IgKHByZXZm
bCA9ICZmbF9oZWFkW2hdLCBmbCA9IGZsX2hlYWRbaF0ubmV4dDsgZmw7DQog
CSAgICAgcHJldmZsID0gZmwsIGZsID0gZmwtPm5leHQpIHsNCiAJCWlmIChp
bm8gPT0gZmwtPmlubykgew0KKwkJCXJldCA9IGxzdGF0KGZsLT5maWxlLCAm
c2IpOw0KKwkJCWlmIChyZXQgPCAwIHx8IHNiLnN0X2lubyAhPSBpbm8pIHsN
CisJCQkJZmwtPnNwZWNpbmQgPSBzcGVjaW5kOw0KKwkJCQlmcmVlKGZsLT5m
aWxlKTsNCisJCQkJZmwtPmZpbGUgPSBtYWxsb2Moc3RybGVuKGZpbGUpICsg
MSk7DQorCQkJCWlmICghZmwtPmZpbGUpIHsNCisJCQkJCWZwcmludGYoc3Rk
ZXJyLA0KKwkJCQkJCSIlczogIGluc3VmZmljaWVudCBtZW1vcnkgZm9yIGZp
bGUgbGFiZWwgZW50cnkgZm9yICVzXG4iLA0KKwkJCQkJCXByb2duYW1lLCBm
aWxlKTsNCisJCQkJCXJldHVybiBOVUxMOw0KKwkJCQl9DQorCQkJCXN0cmNw
eShmbC0+ZmlsZSwgZmlsZSk7DQorCQkJCXJldHVybiBmbDsNCisNCisJCQl9
DQorDQogCQkJaWYgKGZsYXNrX2VuYWJsZWQpIA0KIAkJCQlub19jb25mbGlj
dCA9IChzcGVjW2ZsLT5zcGVjaW5kXS5zaWQgPT0gc3BlY1tzcGVjaW5kXS5z
aWQpOw0KIAkJCWVsc2UNCg==
---559023410-684387517-1032442896=:8887--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA05679
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 09:12:40 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA01376
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 13:11:12 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id NAA01372 for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 13:11:12 GMT
Date: Wed, 10 Jul 2002 09:12:21 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: audit bug in fd handling
In-Reply-To: <20020710074550.C3E6D106@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0207100909500.26546-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-824023566-1026306741=:26546"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-824023566-1026306741=:26546
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Wed, 10 Jul 2002, Russell Coker wrote:

> It seems that when a file handle open read/write is inherited by a domain
> that is permitted read access only, an error about write access will be
> logged - even if there is a dontaudit rule!

The attached patch (also committed to the sourceforge CVS tree) fixes this
bug in the auditdeny logic.  To apply, save the patch to
~/auditdeny.patch, cd lsm-2.4, and patch -p0 < ~/auditdeny.patch.  Then,
rebuild your kernel.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-824023566-1026306741=:26546
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="auditdeny.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0207100912210.26546@raven>
Content-Description: 
Content-Disposition: attachment; filename="auditdeny.patch"

SW5kZXg6IHNlY3VyaXR5L3NlbGludXgvaW5jbHVkZS9saW51eC9mbGFzay9h
dmMuaA0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KUkNTIGZpbGU6IC9jdnNy
b290L3NlbGludXgvbnNhL2xzbS0yLjQvc2VjdXJpdHkvc2VsaW51eC9pbmNs
dWRlL2xpbnV4L2ZsYXNrL2F2Yy5oLHYNCnJldHJpZXZpbmcgcmV2aXNpb24g
MS4zDQpkaWZmIC11IC1yMS4zIGF2Yy5oDQotLS0gc2VjdXJpdHkvc2VsaW51
eC9pbmNsdWRlL2xpbnV4L2ZsYXNrL2F2Yy5oCTMgSnVuIDIwMDIgMTM6NDY6
NTEgLTAwMDAJMS4zDQorKysgc2VjdXJpdHkvc2VsaW51eC9pbmNsdWRlL2xp
bnV4L2ZsYXNrL2F2Yy5oCTEwIEp1bCAyMDAyIDEzOjAzOjUyIC0wMDAwDQpA
QCAtMjE0LDYgKzIxNCw3IEBADQogCXVuc2lnbmVkIGxvbmcJZmxhZ3M7DQog
CXN0cnVjdCBhdmNfZW50cnkgZW50cnk7DQogCV9fdTMyIHNlcW5vOw0KKwlh
Y2Nlc3NfdmVjdG9yX3QgZGVuaWVkOw0KIA0KIAlzcGluX2xvY2tfaXJxc2F2
ZSgmYXZjX2xvY2ssIGZsYWdzKTsNCiAJYXZjX2NhY2hlX3N0YXRzX2luY3Io
QVZDX0VOVFJZX0xPT0tVUFMpOw0KQEAgLTI1NCw5ICsyNTUsMTEgQEANCiAJ
CWFlID0gYWVyZWYtPmFlOw0KIAl9DQogDQotCWlmICghcmVxdWVzdGVkIHx8
IChyZXF1ZXN0ZWQgJiBhZS0+YWxsb3dlZCkgIT0gcmVxdWVzdGVkKSB7DQot
CQlpZiAoIXJlcXVlc3RlZCB8fCAocmVxdWVzdGVkICYgYWUtPmF1ZGl0ZGVu
eSkpDQotCQkJYXZjX2F1ZGl0KHNzaWQsIHRzaWQsIHRjbGFzcywgcmVxdWVz
dGVkICYgfihhZS0+YWxsb3dlZCksIGFlLA0KKwlkZW5pZWQgPSByZXF1ZXN0
ZWQgJiB+KGFlLT5hbGxvd2VkKTsNCisNCisJaWYgKCFyZXF1ZXN0ZWQgfHwg
ZGVuaWVkKSB7DQorCQlpZiAoIXJlcXVlc3RlZCB8fCAoZGVuaWVkICYgYWUt
PmF1ZGl0ZGVueSkpDQorCQkJYXZjX2F1ZGl0KHNzaWQsIHRzaWQsIHRjbGFz
cywgZGVuaWVkLCBhZSwNCiAJCQkJICBBVkNfQVVESVRERU5ZLCBhdWRpdGRh
dGEpOw0KICNpZmRlZiBDT05GSUdfU0VDVVJJVFlfU0VMSU5VWF9ERVZFTE9Q
DQogCQlpZiAoYXZjX2RlYnVnX2Fsd2F5c19hbGxvdykgew0K
---559023410-824023566-1026306741=:26546--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA21591
	for <selinux@tycho.nsa.gov>; Mon, 22 Apr 2002 13:12:17 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA10055
	for <selinux@tycho.nsa.gov>; Mon, 22 Apr 2002 17:10:33 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id RAA10051
	for <selinux@tycho.nsa.gov>; Mon, 22 Apr 2002 17:10:32 GMT
Date: Mon, 22 Apr 2002 13:11:59 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: nested {}
In-Reply-To: <20020420100126.B49DC19141@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204221311260.20305-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1019495519=:20305"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-1019495519=:20305
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Sat, 20 Apr 2002, Russell Coker wrote:

> I would like to be able to do { file devfile_class_set } but such things
> currently don't work because checkpolicy doesn't like nested {}.
>
> Could this be changed?

So, you want something like the attached patch?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-851401618-1019495519=:20305
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="parse.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0204221311590.20305@raven>
Content-Description: 
Content-Disposition: attachment; filename="parse.patch"

SW5kZXg6IG1vZHVsZS9jaGVja3BvbGljeS9wb2xpY3lfcGFyc2UueQ0KPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQ0KUkNTIGZpbGU6IC9jdnMvbHNtL3NlbGlu
dXgvbW9kdWxlL2NoZWNrcG9saWN5L3BvbGljeV9wYXJzZS55LHYNCnJldHJp
ZXZpbmcgcmV2aXNpb24gMS4xMQ0KZGlmZiAtdSAtcjEuMTEgcG9saWN5X3Bh
cnNlLnkNCi0tLSBtb2R1bGUvY2hlY2twb2xpY3kvcG9saWN5X3BhcnNlLnkJ
MjAwMi8wMy8wNyAxMzowOTozNwkxLjExDQorKysgbW9kdWxlL2NoZWNrcG9s
aWN5L3BvbGljeV9wYXJzZS55CTIwMDIvMDQvMjIgMTc6MDg6MzMNCkBAIC00
NTMsNyArNDUzLDcgQEANCiAJCQk7DQogbmFtZXMgICAgICAgICAgIAk6IGlk
ZW50aWZpZXINCiAJCQl7IGlmIChpbnNlcnRfc2VwYXJhdG9yKDApKSByZXR1
cm4gLTE7IH0NCi0JCQl8ICd7JyBpZGVudGlmaWVyX2xpc3QgJ30nDQorCQkJ
fCBuZXN0ZWRfaWRfc2V0DQogCQkJeyBpZiAoaW5zZXJ0X3NlcGFyYXRvcigw
KSkgcmV0dXJuIC0xOyB9DQogCQkJfCBhc3Rlcmlzaw0KICAgICAgICAgICAg
ICAgICAgICAgICAgIHsgaWYgKGluc2VydF9pZCgiKiIsIDApKSByZXR1cm4g
LTE7IA0KQEAgLTQ2MSw3ICs0NjEsNyBAQA0KIAkJCXwgdGlsZGUgaWRlbnRp
Zmllcg0KICAgICAgICAgICAgICAgICAgICAgICAgIHsgaWYgKGluc2VydF9p
ZCgifiIsIDApKSByZXR1cm4gLTE7DQogCQkJICBpZiAoaW5zZXJ0X3NlcGFy
YXRvcigwKSkgcmV0dXJuIC0xOyB9DQotCQkJfCB0aWxkZSAneycgaWRlbnRp
Zmllcl9saXN0ICd9Jw0KKwkJCXwgdGlsZGUgbmVzdGVkX2lkX3NldA0KIAkg
CQl7IGlmIChpbnNlcnRfaWQoIn4iLCAwKSkgcmV0dXJuIC0xOyANCiAJCQkg
IGlmIChpbnNlcnRfc2VwYXJhdG9yKDApKSByZXR1cm4gLTE7IH0NCiAJCQk7
DQpAQCAtNDg2LDYgKzQ4NiwxMiBAQA0KIGlkZW50aWZpZXJfbGlzdAkJOiBp
ZGVudGlmaWVyDQogCQkJfCBpZGVudGlmaWVyX2xpc3QgaWRlbnRpZmllcg0K
IAkJCTsNCituZXN0ZWRfaWRfc2V0ICAgICAgICAgICA6ICd7JyBuZXN0ZWRf
aWRfbGlzdCAnfScNCisgICAgICAgICAgICAgICAgICAgICAgICA7DQorbmVz
dGVkX2lkX2xpc3QgICAgICAgICAgOiBuZXN0ZWRfaWRfZWxlbWVudCB8IG5l
c3RlZF9pZF9saXN0IG5lc3RlZF9pZF9lbGVtZW50DQorICAgICAgICAgICAg
ICAgICAgICAgICAgOw0KK25lc3RlZF9pZF9lbGVtZW50ICAgICAgIDogaWRl
bnRpZmllciB8IG5lc3RlZF9pZF9zZXQNCisgICAgICAgICAgICAgICAgICAg
ICAgICA7DQogaWRlbnRpZmllcgkJOiBJREVOVElGSUVSDQogCQkJeyBpZiAo
aW5zZXJ0X2lkKHl5dGV4dCwwKSkgcmV0dXJuIC0xOyB9DQogCQkJOw0K
---559023410-851401618-1019495519=:20305--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

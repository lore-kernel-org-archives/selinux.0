Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA05739
	for <selinux@tycho.nsa.gov>; Thu, 28 Mar 2002 16:47:57 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA23591
	for <selinux@tycho.nsa.gov>; Thu, 28 Mar 2002 21:46:52 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id VAA23582 for <selinux@tycho.nsa.gov>; Thu, 28 Mar 2002 21:46:49 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 34AF492452
	for <selinux@tycho.nsa.gov>; Fri, 29 Mar 2002 08:47:45 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 974D7237BF
	for <selinux@tycho.nsa.gov>; Thu, 28 Mar 2002 22:47:37 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: setfiles - patch
Date: Thu, 28 Mar 2002 22:47:37 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_DVDP6ZQO51R86QMWUM8J"
Message-Id: <20020328214737.974D7237BF@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_DVDP6ZQO51R86QMWUM8J
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I've attached a little patch for setfiles which allows "-" to be specified 
instead of a file system name to make it read file names from stdin.

Stephen, if you include this in your source tree then please send me a patch 
of the way you do it so my next patch will apply cleanly.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--------------Boundary-00=_DVDP6ZQO51R86QMWUM8J
Content-Type: text/x-diff;
  charset="us-ascii";
  name="selinux.diff"
Content-Transfer-Encoding: base64
Content-Description: selinux.diff
Content-Disposition: attachment; filename="selinux.diff"

LS0tIHNlbGludXgtc21hbGwtMjAwMjAzMTQwOS5vcmlnL3NldGZpbGVzL3NldGZpbGVzLmMKKysr
IHNlbGludXgtc21hbGwtMjAwMjAzMTQwOS9zZXRmaWxlcy9zZXRmaWxlcy5jCkBAIC0xNyw2ICsx
Nyw3IEBACiAgKiAtZCAgIFNob3cgd2hhdCBzcGVjaWZpY2F0aW9uIG1hdGNoZWQgZWFjaCBmaWxl
LgogICogLW4JRG8gbm90IGNoYW5nZSBhbnkgZmlsZSBsYWJlbHMuCiAgKiAtdglTaG93IGNoYW5n
ZXMgaW4gZmlsZSBsYWJlbHMuICAKKyAqIC1tICAgRG9uJ3Qgd2FybiBhYm91dCBubyBtYXRjaGVz
LgogICogLVIgICBSZWNyZWF0ZSB0aGUgcGVyc2lzdGVudCBsYWJlbCBtYXBwaW5ncyBmcm9tIHNj
cmF0Y2guCiAgKiAgICAgIE11c3QgcmVib290IHRvIHRha2UgYWZmZWN0LgogICogc3BlY19maWxl
CVRoZSBzcGVjaWZpY2F0aW9uIGZpbGUuCkBAIC02NCw2ICs2NSw3IEBACiAjaW5jbHVkZSA8ZnNf
c2VjdXJlLmg+CiAjaW5jbHVkZSA8c3MuaD4KICNpbmNsdWRlICJwc2lkLmgiCisjaW5jbHVkZSA8
bGltaXRzLmg+CiAKIHN0cnVjdCBwc2lkdGFiICpwc2lkczsKIApAQCAtNzYsNiArNzgsNyBAQAog
ICogQ29tbWFuZC1saW5lIG9wdGlvbnMuCiAgKi8KIHN0YXRpYyBpbnQgY2hhbmdlID0gMTsKK3N0
YXRpYyBpbnQgd2Fybl9ub19tYXRjaCA9IDE7CiBzdGF0aWMgaW50IGRlYnVnID0gMDsKIHN0YXRp
YyBpbnQgdmVyYm9zZSA9IDA7CiBzdGF0aWMgaW50IHJlc2V0ID0gMDsKQEAgLTQ1NSwxMSArNDU4
LDE0IEBACiAJc3RydWN0IHN0YXQgc2I7CiAKIAkvKiBQcm9jZXNzIGFueSBvcHRpb25zLiAqLwot
CXdoaWxlICgob3B0ID0gZ2V0b3B0KGFyZ2MsIGFyZ3YsICJkbnZSIikpID4gMCkgeworCXdoaWxl
ICgob3B0ID0gZ2V0b3B0KGFyZ2MsIGFyZ3YsICJkbW52UiIpKSA+IDApIHsKIAkJc3dpdGNoIChv
cHQpIHsKIAkJY2FzZSAnZCc6CiAJCQlkZWJ1ZyA9IDE7CiAJCQlicmVhazsKKwkJY2FzZSAnbSc6
CisJCQl3YXJuX25vX21hdGNoID0gMDsKKwkJCWJyZWFrOwogCQljYXNlICduJzoKIAkJCWNoYW5n
ZSA9IDA7CiAJCQlicmVhazsKQEAgLTcwMCw2ICs3MDYsMzQgQEAKIAkJCX0KIAkJfQogCQkKKwkJ
aWYoIXN0cmNtcChhcmd2W29wdGluZF0sICItIikpCisJCXsKKwkJCWNoYXIgYnVmW1BBVEhfTUFY
XTsKKwkJCXdoaWxlKGZnZXRzKGJ1Ziwgc2l6ZW9mKGJ1ZiksIHN0ZGluKSkKKwkJCXsKKwkJCQlz
dHJ1Y3Qgc3RhdCBzYjsKKwkJCQlzdHJ0b2soYnVmLCAiXHJcbiIpOworCQkJCWlmKHN0YXQoYnVm
LCAmc2IpKQorCQkJCQlmcHJpbnRmKHN0ZGVyciwgIkZpbGUgJXMgbm90IGZvdW5kLlxuIiwgYnVm
KTsKKwkJCQllbHNlCisJCQkJeworCQkJCQlpbnQgZmxhZzsKKwkJCQkJc3dpdGNoKHNiLnN0X21v
ZGUpCisJCQkJCXsKKwkJCQkJY2FzZSBTX0lGRElSOgorCQkJCQkJZmxhZyA9IEZUV19EOworCQkJ
CQlicmVhazsKKwkJCQkJY2FzZSBTX0lGTE5LOgorCQkJCQkJZmxhZyA9IEZUV19TTDsKKwkJCQkJ
YnJlYWs7CisJCQkJCWRlZmF1bHQ6CisJCQkJCQlmbGFnID0gRlRXX0Y7CisJCQkJCX0KKwkJCQkJ
YXBwbHlfc3BlYyhidWYsICZzYiwgZmxhZywgTlVMTCk7CisJCQkJfQorCQkJfQorCQl9CisJCWVs
c2UKIAkJLyogV2FsayB0aGUgZmlsZSB0cmVlLCBjYWxsaW5nIGFwcGx5X3NwZWMgb24gZWFjaCBm
aWxlLiAqLwogCQlpZiAobmZ0dwogCQkgICAgKGFyZ3Zbb3B0aW5kXSwgYXBwbHlfc3BlYywgMTAy
NCwKQEAgLTcyMyw2ICs3NTcsNyBAQAogCQlmaWxlX3NwZWNfZGVzdHJveSgpOwogCX0KIAorCWlm
KHdhcm5fbm9fbWF0Y2gpCiAJZm9yIChpID0gMDsgaSA8IG5zcGVjOyBpKyspIHsKIAkJaWYgKHNw
ZWNbaV0ubWF0Y2hlcyA9PSAwKSB7CiAJCQlpZiAoc3BlY1tpXS50eXBlX3N0cikgewo=

--------------Boundary-00=_DVDP6ZQO51R86QMWUM8J--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

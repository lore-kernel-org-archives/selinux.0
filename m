Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m15KDj99029432
	for <selinux@tycho.nsa.gov>; Tue, 5 Feb 2008 15:13:45 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m15KDiZ4003930
	for <selinux@tycho.nsa.gov>; Tue, 5 Feb 2008 20:13:44 GMT
Subject: matchpathcon flags
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-vN7E7840gH31gT0lKdtr"
Date: Tue, 05 Feb 2008 15:02:36 -0500
Message-Id: <1202241756.7533.78.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-vN7E7840gH31gT0lKdtr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I was trying to disable matchpathcon's validation of file contexts
because I wanted to be able use it in a python script to match against a
file_contexts that didn't have valid contexts on the running system
(file_contexts were standard, system was mcs).  However, explicitly
clearing MATCHPATHCON_VALIDATE still resulted in errors both on stable
and trunk.  Is this the way the flag is intended to work?

I've attached a modified utils/matchpathcon.c that I used for testing
the lib (I wanted to make sure it was the lib and not the python
wrapper).  I was trying to test fcglob matches vs the original
matchpathcon "fcregex".  So I was doing

./matchpathcon -f file_contexts.orig/file_contexts -V /bin/bash

with and without -V (the file_contexts is in the fcglob refpolicy
branch).  On stable it always reports invalid context (and invalid
argument) and on trunk it always reports invalid argument.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--=-vN7E7840gH31gT0lKdtr
Content-Disposition: attachment; filename=matchpathcon.c
Content-Type: text/x-csrc; name=matchpathcon.c; charset=us-ascii
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHVuaXN0ZC5oPg0KI2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3RkbGli
Lmg+DQojaW5jbHVkZSA8Z2V0b3B0Lmg+DQojaW5jbHVkZSA8ZXJybm8uaD4NCiNpbmNsdWRlIDxz
dHJpbmcuaD4NCiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4NCiNpbmNsdWRlIDxzeXMvc3RhdC5oPg0K
I2luY2x1ZGUgPHN5cy9lcnJuby5oPg0KI2luY2x1ZGUgPHNlbGludXgvc2VsaW51eC5oPg0KDQp2
b2lkIHVzYWdlKGNvbnN0IGNoYXIgKnByb2duYW1lKQ0Kew0KCWZwcmludGYoc3RkZXJyLA0KCQki
dXNhZ2U6ICAlcyBbLU5dIFstbl0gWy1mIGZpbGVfY29udGV4dHNdIFstcCBwcmVmaXhdIFstVl0g
cGF0aC4uLlxuIiwNCgkJcHJvZ25hbWUpOw0KCWV4aXQoMSk7DQp9DQoNCmludCBwcmludG1hdGNo
cGF0aGNvbihjaGFyICpwYXRoLCBpbnQgaGVhZGVyLCBpbnQgbW9kZSkNCnsNCgljaGFyICpidWY7
DQoJaW50IHJjID0gbWF0Y2hwYXRoY29uKHBhdGgsIG1vZGUsICZidWYpOw0KCWlmIChyYyA8IDAp
IHsNCgkJZnByaW50ZihzdGRlcnIsICJtYXRjaHBhdGhjb24oJXMpIGZhaWxlZDogJXNcbiIsIHBh
dGgsDQoJCQlzdHJlcnJvcihlcnJubykpOw0KCQlyZXR1cm4gMTsNCgl9DQoJaWYgKGhlYWRlcikN
CgkJcHJpbnRmKCIlc1x0JXNcbiIsIHBhdGgsIGJ1Zik7DQoJZWxzZQ0KCQlwcmludGYoIiVzXG4i
LCBidWYpOw0KDQoJZnJlZWNvbihidWYpOw0KCXJldHVybiAwOw0KfQ0KDQppbnQgbWFpbihpbnQg
YXJnYywgY2hhciAqKmFyZ3YpDQp7DQoJaW50IGksIGluaXQgPSAwOw0KCWludCBoZWFkZXIgPSAx
LCBvcHQ7DQoJaW50IGVycm9yID0gMDsNCgl1bnNpZ25lZCBpbnQgZmxhZ3MgPSAwOw0KDQoJaWYg
KGFyZ2MgPCAyKQ0KCQl1c2FnZShhcmd2WzBdKTsNCg0KCXdoaWxlICgob3B0ID0gZ2V0b3B0KGFy
Z2MsIGFyZ3YsICJObmY6cDpWIikpID4gMCkgew0KCQlzd2l0Y2ggKG9wdCkgew0KCQljYXNlICdu
JzoNCgkJCWhlYWRlciA9IDA7DQoJCQlicmVhazsNCgkJY2FzZSAnVic6DQoJCQlmbGFncyB8PSBN
QVRDSFBBVEhDT05fVkFMSURBVEU7DQoJCQlicmVhazsNCgkJY2FzZSAnTic6DQoJCQlmbGFncyB8
PSBNQVRDSFBBVEhDT05fTk9UUkFOUzsNCgkJCWJyZWFrOw0KCQljYXNlICdmJzoNCgkJCWlmIChp
bml0KSB7DQoJCQkJZnByaW50ZihzdGRlcnIsDQoJCQkJCSIlczogIC1mIGFuZCAtcCBhcmUgZXhj
bHVzaXZlXG4iLA0KCQkJCQlhcmd2WzBdKTsNCgkJCQlleGl0KDEpOw0KCQkJfQ0KCQkJaW5pdCA9
IDE7DQoJCQlpZiAobWF0Y2hwYXRoY29uX2luaXQob3B0YXJnKSkgew0KCQkJCWZwcmludGYoc3Rk
ZXJyLA0KCQkJCQkiRXJyb3Igd2hpbGUgcHJvY2Vzc2luZyAlczogICVzXG4iLA0KCQkJCQlvcHRh
cmcsDQoJCQkJCWVycm5vID8gc3RyZXJyb3IoZXJybm8pIDogImludmFsaWQiKTsNCgkJCQlleGl0
KDEpOw0KCQkJfQ0KCQkJYnJlYWs7DQoJCWNhc2UgJ3AnOg0KCQkJaWYgKGluaXQpIHsNCgkJCQlm
cHJpbnRmKHN0ZGVyciwNCgkJCQkJIiVzOiAgLWYgYW5kIC1wIGFyZSBleGNsdXNpdmVcbiIsDQoJ
CQkJCWFyZ3ZbMF0pOw0KCQkJCWV4aXQoMSk7DQoJCQl9DQoJCQlpbml0ID0gMTsNCgkJCWlmICht
YXRjaHBhdGhjb25faW5pdF9wcmVmaXgoTlVMTCwgb3B0YXJnKSkgew0KCQkJCWZwcmludGYoc3Rk
ZXJyLA0KCQkJCQkiRXJyb3Igd2hpbGUgcHJvY2Vzc2luZyAlczogICVzXG4iLA0KCQkJCQlvcHRh
cmcsDQoJCQkJCWVycm5vID8gc3RyZXJyb3IoZXJybm8pIDogImludmFsaWQiKTsNCgkJCQlleGl0
KDEpOw0KCQkJfQ0KCQkJYnJlYWs7DQoJCWRlZmF1bHQ6DQoJCQl1c2FnZShhcmd2WzBdKTsNCgkJ
fQ0KCX0NCg0KCXNldF9tYXRjaHBhdGhjb25fZmxhZ3MoZmxhZ3MpOw0KDQoJZm9yIChpID0gb3B0
aW5kOyBpIDwgYXJnYzsgaSsrKSB7DQoJCWludCBtb2RlID0gMDsNCgkJc3RydWN0IHN0YXQgYnVm
Ow0KCQlpZiAobHN0YXQoYXJndltpXSwgJmJ1ZikgPT0gMCkNCgkJCW1vZGUgPSBidWYuc3RfbW9k
ZTsNCg0KCQllcnJvciArPSBwcmludG1hdGNocGF0aGNvbihhcmd2W2ldLCBoZWFkZXIsIG1vZGUp
Ow0KCX0NCgltYXRjaHBhdGhjb25fZmluaSgpOw0KCXJldHVybiBlcnJvcjsNCn0NCg==


--=-vN7E7840gH31gT0lKdtr--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

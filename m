Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h761EBHa024378
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2003 21:14:11 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h761CuFB023280
	for <selinux@tycho.nsa.gov>; Wed, 6 Aug 2003 01:12:56 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
	by jazzswing.ncsc.mil  with ESMTP id h761CtGD023277
	for <selinux@tycho.nsa.gov>; Wed, 6 Aug 2003 01:12:55 GMT
Subject: [patch] initrd Makefile target
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-Jswaac1lU7xHkoaA3XvE"
Message-Id: <1060132448.678.13.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: 05 Aug 2003 20:14:08 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Jswaac1lU7xHkoaA3XvE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Please consider this patch for inclusion into the new api policy.  It
creates a initrd target in the policy Makefile.  By default it creates
/boot/initrd-$(KV) where KV defaults to `uname -r`.  However a user may
be creating an initrd for a newly installed kernel, so that obviously
could be overridden on the commandline:

make initrd KV=2.6.0-test3


 Makefile |   12 ++++++++++++
 1 files changed, 12 insertions(+)


-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer, SELinux
Hardened Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-Jswaac1lU7xHkoaA3XvE
Content-Disposition: attachment; filename=Makefile-initrd.diff
Content-Type: text/x-patch; name=Makefile-initrd.diff; charset=ISO-8859-1
Content-Transfer-Encoding: base64

ZGlmZiAtdXIgY3ZzL01ha2VmaWxlIHBvbGljeS1kZXYvTWFrZWZpbGUNCi0tLSBjdnMvTWFrZWZp
bGUJMjAwMy0wOC0wNCAyMjoyOTowMC4wMDAwMDAwMDAgLTA1MDANCisrKyBwb2xpY3ktZGV2L01h
a2VmaWxlCTIwMDMtMDgtMDUgMTk6NDQ6NDUuMDAwMDAwMDAwIC0wNTAwDQpAQCAtMyw2ICszLDcg
QEANCiAjDQogIyBUYXJnZXRzOg0KICMgDQorIyBpbml0cmQgIC0gY29tcGlsZSBhbmQgaW5zdGFs
bCB0aGUgcG9saWN5IGNvbmZpZ3VyYXRpb24sIGFuZCBjcmVhdGUgYSBwb2xpY3kgaW5pdHJkLg0K
ICMgaW5zdGFsbCAtIGNvbXBpbGUgYW5kIGluc3RhbGwgdGhlIHBvbGljeSBjb25maWd1cmF0aW9u
Lg0KICMgbG9hZCAgICAtIGNvbXBpbGUsIGluc3RhbGwsIGFuZCBsb2FkIHRoZSBwb2xpY3kgY29u
ZmlndXJhdGlvbi4NCiAjIHJlbG9hZCAgLSBjb21waWxlLCBpbnN0YWxsLCBhbmQgbG9hZC9yZWxv
YWQgdGhlIHBvbGljeSBjb25maWd1cmF0aW9uLg0KQEAgLTEyLDYgKzEzLDE0IEBADQogIyBUaGUg
ZGVmYXVsdCB0YXJnZXQgaXMgJ2luc3RhbGwnLg0KICMNCiANCisjIGluaXRyZCBvcHRpb25zDQor
TUtJTklUUkQgPSAvc2Jpbi9ta2luaXRyZA0KKyMga2VybmVsIHZlcnNpb24sIGRlZmF1bHRzIHRv
IGN1cnJlbnQgcnVubmluZyBrZXJuZWwNCitLViA9ICQoc2hlbGwgdW5hbWUgLXIpDQorSU5JVFJE
ID0gL2Jvb3QvaW5pdHJkLSQoS1YpDQorIyBleHRyYSBvcHRpb25zDQorRVhUUkFPUFQgPSANCisN
CiAjIFNldCB0byB5IGlmIE1MUyBpcyBlbmFibGVkIGluIHRoZSBtb2R1bGUuDQogTUxTPW4NCiAN
CkBAIC02Myw2ICs3Miw5IEBADQogDQogbG9hZDogdG1wL2xvYWQNCiANCitpbml0cmQ6ICQoTE9B
RFBBVEgpDQorCSQoTUtJTklUUkQpICQoRVhUUkFPUFQpICQoSU5JVFJEKSAkKEtWKQ0KKw0KIHBv
bGljeS5jb25mOiAkKFBPTElDWUZJTEVTKSANCiAJbWtkaXIgLXAgdG1wDQogCWNhdCAkXiA+ICRA
DQo=

--=-Jswaac1lU7xHkoaA3XvE--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

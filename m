Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBM0d7Rb019819
	for <selinux@tycho.nsa.gov>; Sun, 21 Dec 2003 19:39:07 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBM0d6pn021860
	for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2003 00:39:06 GMT
Received: from chris.pebenito.dhs.org (c-24-15-24-15.client.comcast.net [24.15.24.15])
        by jazzband.ncsc.mil  with ESMTP id hBM0d5ab021857 for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2003 00:39:06 GMT
Subject: var_run_domain enhancement
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-YgnwEQS06pj4QakYEJPM"
Message-Id: <1072053545.13701.7.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: Sun, 21 Dec 2003 18:39:05 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-YgnwEQS06pj4QakYEJPM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached is a patch to add an optional second argument to the
var_run_domain macro.  It makes it possible to specify the classes to
use, and if $2 isn't specified, it defaults to file so current usages
don't break.  This is useful if a daemon puts a sock_file in /var/run,
instead of a pid file, for example.

macros/global_macros.te |   10 ++++++++--
1 files changed, 8 insertions(+), 2 deletions(-)

-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
Embedded Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-YgnwEQS06pj4QakYEJPM
Content-Description: 
Content-Disposition: attachment; filename=var-run.diff
Content-Type: text/x-patch; charset=ISO-8859-1
Content-Transfer-Encoding: base64

ZGlmZiAtdXJOIHBvbGljeS0xLjQub3JpZy9tYWNyb3MvZ2xvYmFsX21hY3Jvcy50ZSBwb2xpY3kt
MS40L21hY3Jvcy9nbG9iYWxfbWFjcm9zLnRlDQotLS0gcG9saWN5LTEuNC5vcmlnL21hY3Jvcy9n
bG9iYWxfbWFjcm9zLnRlCTIwMDMtMTItMDEgMDk6Mjc6NTAuMDAwMDAwMDAwIC0wNjAwDQorKysg
cG9saWN5LTEuNC9tYWNyb3MvZ2xvYmFsX21hY3Jvcy50ZQkyMDAzLTEyLTIxIDE4OjI1OjM0LjAw
MDAwMDAwMCAtMDYwMA0KQEAgLTI3NywxMSArMjc3LDE3IEBADQogJylkbmwNCiANCiAjIGFsbG93
IGEgZG9tYWluIHRvIGNyZWF0ZSBpdHMgb3duIGZpbGVzIHVuZGVyIC92YXIvcnVuIGFuZCB0byBj
cmVhdGUgZmlsZXMNCi0jIGluIGRpcmVjdG9yaWVzIHRoYXQgYXJlIGNyZWF0ZWQgZm9yIGl0LiAg
Rm9yIHNvY2tfZmlsZSBldGMgeW91IG5lZWQgdG8gYWRkDQotIyB5b3VyIG93biBydWxlcw0KKyMg
aW4gZGlyZWN0b3JpZXMgdGhhdCBhcmUgY3JlYXRlZCBmb3IgaXQuICAkMiBpcyBhbiBvcHRpb25h
bCBsaXN0IG9mIA0KKyMgY2xhc3NlcyB0byB1c2U7IGRlZmF1bHQgaXMgZmlsZS4NCiBkZWZpbmUo
YHZhcl9ydW5fZG9tYWluJywgYA0KIHR5cGUgJDFfdmFyX3J1bl90IGFsaWFzIHZhcl9ydW5fJDFf
dCwgZmlsZV90eXBlLCBzeXNhZG1maWxlLCBwaWRmaWxlOw0KKw0KK2lmZWxzZShgJDInLCBgJywg
YA0KIGZpbGVfdHlwZV9hdXRvX3RyYW5zKCQxX3QsIHZhcl9ydW5fdCwgJDFfdmFyX3J1bl90LCBm
aWxlKQ0KKycsIGANCitmaWxlX3R5cGVfYXV0b190cmFucygkMV90LCB2YXJfcnVuX3QsICQxX3Zh
cl9ydW5fdCwgJDIpDQorJykNCisNCiBhbGxvdyAkMV90ICQxX3Zhcl9ydW5fdDpkaXIgcndfZGly
X3Blcm1zOw0KICcpDQogDQo=

--=-YgnwEQS06pj4QakYEJPM--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

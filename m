Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7IKMtcS023508
	for <selinux@tycho.nsa.gov>; Fri, 18 Aug 2006 16:22:55 -0400
Received: from web51511.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k7IKMT02024175
	for <selinux@tycho.nsa.gov>; Fri, 18 Aug 2006 20:22:29 GMT
Message-ID: <20060818202254.70133.qmail@web51511.mail.yahoo.com>
Date: Fri, 18 Aug 2006 13:22:54 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Don't send statistics to audit logs
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-910988990-1155932574=:69495"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-910988990-1155932574=:69495
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,

The attached patch changes libselinux to send statistics to syslog instead of the
audit logs.

Thanks,
-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-910988990-1155932574=:69495
Content-Type: application/octet-stream; name="libselinux-1.30.20-avc-syslog.patch"
Content-Transfer-Encoding: base64
Content-Description: 778356493-libselinux-1.30.20-avc-syslog.patch
Content-Disposition: attachment; filename="libselinux-1.30.20-avc-syslog.patch"

ZGlmZiAtdXIgbGlic2VsaW51eC0xLjMwLjIwLm9yaWcvc3JjL2F2Yy5jIGxp
YnNlbGludXgtMS4zMC4yMC9zcmMvYXZjLmMKLS0tIGxpYnNlbGludXgtMS4z
MC4yMC5vcmlnL3NyYy9hdmMuYwkyMDA2LTA4LTA2IDA4OjIwOjM5LjAwMDAw
MDAwMCAtMDQwMAorKysgbGlic2VsaW51eC0xLjMwLjIwL3NyYy9hdmMuYwky
MDA2LTA4LTA2IDA4OjQ0OjI0LjAwMDAwMDAwMCAtMDQwMApAQCAtMTUsNiAr
MTUsNyBAQAogI2luY2x1ZGUgPHN0cmluZy5oPgogI2luY2x1ZGUgPHVuaXN0
ZC5oPgogI2luY2x1ZGUgPHN0ZGludC5oPgorI2luY2x1ZGUgPHN5c2xvZy5o
PgogI2luY2x1ZGUgPHNlbGludXgvZmxhc2suaD4KICNpbmNsdWRlICJzZWxp
bnV4X2ludGVybmFsLmgiCiAjaW5jbHVkZSA8c2VsaW51eC9hdmMuaD4KQEAg
LTMzMSw3ICszMzIsNyBAQAogCWF2Y19nZXRfbG9jayhhdmNfbG9jayk7CiAJ
c2lkdGFiX3NpZF9zdGF0cygmYXZjX3NpZHRhYiwgYXZjX2F1ZGl0X2J1Ziwg
QVZDX0FVRElUX0JVRlNJWkUpOwogCWF2Y19yZWxlYXNlX2xvY2soYXZjX2xv
Y2spOwotCWF2Y19sb2coIiVzIiwgYXZjX2F1ZGl0X2J1Zik7CisJc3lzbG9n
KExPR19JTkZPLCAiJXMiLCBhdmNfYXVkaXRfYnVmKTsKIAlhdmNfcmVsZWFz
ZV9sb2NrKGF2Y19sb2dfbG9jayk7CiB9CiAKQEAgLTM2MCw3ICszNjEsNyBA
QAogCiAJYXZjX3JlbGVhc2VfbG9jayhhdmNfbG9jayk7CiAKLQlhdmNfbG9n
KCIlczogICVkIEFWIGVudHJpZXMgYW5kICVkLyVkIGJ1Y2tldHMgdXNlZCwg
IgorCXN5c2xvZyhMT0dfSU5GTywgIiVzOiAgJWQgQVYgZW50cmllcyBhbmQg
JWQvJWQgYnVja2V0cyB1c2VkLCAiCiAJCSJsb25nZXN0IGNoYWluIGxlbmd0
aCAlZFxuIiwgYXZjX3ByZWZpeCwKIAkJYXZjX2NhY2hlLmFjdGl2ZV9ub2Rl
cywKIAkJc2xvdHNfdXNlZCwgQVZDX0NBQ0hFX1NMT1RTLCBtYXhfY2hhaW5f
bGVuKTsK

--0-910988990-1155932574=:69495--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

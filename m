Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA14476
	for <selinux@tycho.nsa.gov>; Sat, 19 Jan 2002 13:23:24 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA25917
	for <selinux@tycho.nsa.gov>; Sat, 19 Jan 2002 18:22:46 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id SAA25913
	for <selinux@tycho.nsa.gov>; Sat, 19 Jan 2002 18:22:43 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id CA57192749
	for <selinux@tycho.nsa.gov>; Sun, 20 Jan 2002 05:23:16 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id E8C9B907
	for <selinux@tycho.nsa.gov>; Sat, 19 Jan 2002 19:23:03 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: <selinux@tycho.nsa.gov>
Subject: ppp security settings
Date: Sat, 19 Jan 2002 19:23:03 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_F2777D4HT68RC89PZXE1"
Message-Id: <20020119182303.E8C9B907@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_F2777D4HT68RC89PZXE1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I have attached a patch against the latest selinux-small for pppd settings 
(granting access to /dev/ppp by the program /usr/sbin/pppd).

Also I have added settings for /dev/vc/* (devfs equivalent of /dev/tty[0-9]+) 
and /dev/pts/*.

Also I have added dhclient to the domain dhcpc_exec_t and made appropriate 
changes for it's config files.

Let me know if I'm doing anything stupid here.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--------------Boundary-00=_F2777D4HT68RC89PZXE1
Content-Type: text/x-diff;
  charset="us-ascii";
  name="d"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="d"

LS0tIHNlbGludXgtc21hbGwtMjAwMjAxMTcxOC5vcmlnL3BvbGljeS9yYmFjCisrKyBzZWxpbnV4
LXNtYWxsLTIwMDIwMTE3MTgvcG9saWN5L3JiYWMKQEAgLTIxLDYgKzIxLDcgQEAKICMgc3lzdGVt
X3IgaXMgdGhlIHJvbGUgb2Ygc3lzdGVtIHByb2Nlc3Nlcy4KICMKIHJvbGUgc3lzdGVtX3IgdHlw
ZXMgeworCXBwcGRfdAogCWtlcm5lbF90CiAJa21vZF90CiAJYW55X3NvY2tldF90CkBAIC04NSw2
ICs4Niw3IEBACiAjIHVzZXJfciBpcyB0aGUgcm9sZSBmb3IgdW5wcml2aWxlZ2VkIHVzZXJzLgog
Iwogcm9sZSB1c2VyX3IgdHlwZXMgeworCXBwcGRfdAogCXVzZXJfdCAKIAlwYXNzd2RfdAkKIAl1
dGVtcHRlcl90CkBAIC0xMTIsNiArMTE0LDcgQEAKICMgc3lzYWRtX3IgaXMgdGhlIHJvbGUgZm9y
IHRoZSBzeXN0ZW0gYWRtaW5pc3RyYXRvci4KICMKIHJvbGUgc3lzYWRtX3IgdHlwZXMgeyAKKwlw
cHBkX3QKIAlzeXNhZG1fdAogCWlmY29uZmlnX3QKIAlmc2FkbV90Ci0tLSBzZWxpbnV4LXNtYWxs
LTIwMDIwMTE3MTgub3JpZy9wb2xpY3kvZG9tYWlucy9zeXN0ZW0vcHBwZC50ZQorKysgc2VsaW51
eC1zbWFsbC0yMDAyMDExNzE4L3BvbGljeS9kb21haW5zL3N5c3RlbS9wcHBkLnRlCkBAIC0wLDAg
KzEsMzMgQEAKKyMKKyMgQXV0aG9yczogIFJ1c3NlbGwgQ29rZXIKKyMKKworIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjCisjCisjIFJ1bGVzIGZvciB0aGUgcHBwZF90IGRvbWFpbiwg
ZXQgYWwuCisjCisjIHBwcGRfdCBpcyB0aGUgZG9tYWluIGZvciB0aGUgcHBwZCBwcm9ncmFtLgor
IyBwcHBkX2V4ZWNfdCBpcyB0aGUgdHlwZSBvZiB0aGUgcHBwZCBleGVjdXRhYmxlLgorIyBwcHBk
X2tleV90IGlzIHRoZSB0eXBlIG9mIHRoZSBzc2ggcHJpdmF0ZSBrZXkgZmlsZXMKKyMKK3R5cGUg
cHBwZF90LCBkb21haW4sIHByaXZ1c2VyLCBwcml2cm9sZSwgcHJpdmxvZywgcHJpdm93bmVyOwor
dHlwZSBwcHBkX2V4ZWNfdCwgZmlsZV90eXBlLCBleGVjX3R5cGUsIHN5c2FkbWZpbGU7Cit0eXBl
IHBwcGRfa2V5X3QsIGZpbGVfdHlwZSwgc3lzYWRtZmlsZTsKKworIyBVc2UgdGhlIG5ldHdvcmsu
CitjYW5fbmV0d29yayhwcHBkX3QpCisKKyMgVXNlIGNhcGFiaWxpdGllcy4KK2FsbG93IHBwcGRf
dCBzZWxmOmNhcGFiaWxpdHkgeyBmb3duZXIgZnNldGlkIHN5c190dHlfY29uZmlnIGRhY19vdmVy
cmlkZSBuZXRfYmluZF9zZXJ2aWNlIH07CisKKyMgQ3JlYXRlIC92YXIvcnVuL3BwcGQucGlkCit0
eXBlIHBwcGRfdmFyX3J1bl90LCBmaWxlX3R5cGUsIHN5c2FkbWZpbGUsIHBpZGZpbGU7CitmaWxl
X3R5cGVfYXV0b190cmFucyhwcHBkX3QsIHZhcl9ydW5fdCwgcHBwZF92YXJfcnVuX3QpCisKKyMg
QWNjZXNzIGtleSBmaWxlcworYWxsb3cgcHBwZF90IHBwcGRfa2V5X3Q6ZmlsZSByd19maWxlX3Bl
cm1zOworCisjIFJ1biBwcHBkIGluIHBwcGRfdCBieSBkZWZhdWx0Citkb21haW5fYXV0b190cmFu
cyh7IHVzZXJfdCBzeXNhZG1fdCB9LCBwcHBkX2V4ZWNfdCwgcHBwZF90KQorCithbGxvdyBwcHBk
X3QgbmV0X2RldmljZV90OmNocl9maWxlIHJ3X2ZpbGVfcGVybXM7Ci0tLSBzZWxpbnV4LXNtYWxs
LTIwMDIwMTE3MTgub3JpZy9wb2xpY3kvZGV2ZnNfY29udGV4dHMKKysrIHNlbGludXgtc21hbGwt
MjAwMjAxMTcxOC9wb2xpY3kvZGV2ZnNfY29udGV4dHMKQEAgLTI3LDYgKzI3LDggQEAKIC9yYW5k
b20JCQlzeXN0ZW1fdTpvYmplY3RfcjpyYW5kb21fZGV2aWNlX3QKIC91cmFuZG9tCQlzeXN0ZW1f
dTpvYmplY3RfcjpyYW5kb21fZGV2aWNlX3QKIC90dHkJCQlzeXN0ZW1fdTpvYmplY3RfcjpkZXZ0
dHlfdAorL3ZjCQkJc3lzdGVtX3U6b2JqZWN0X3I6ZGV2dHR5X3QKKy9wdHMJCQlzeXN0ZW1fdTpv
YmplY3RfcjpkZXZ0dHlfdAogL3Njc2kJLWMJCXN5c3RlbV91Om9iamVjdF9yOmZpeGVkX2Rpc2tf
ZGV2aWNlX3QKIC9zY3NpCS1iCQlzeXN0ZW1fdTpvYmplY3RfcjpmaXhlZF9kaXNrX2RldmljZV90
CiAvaWRlCS1jCQlzeXN0ZW1fdTpvYmplY3RfcjpmaXhlZF9kaXNrX2RldmljZV90CkBAIC0zOSw1
ICs0MSw2IEBACiAvZmxvcHB5CS1iCQlzeXN0ZW1fdTpvYmplY3RfcjpyZW1vdmFibGVfZGV2aWNl
X3QKIC9ydGMJCQlzeXN0ZW1fdTpvYmplY3RfcjpjbG9ja19kZXZpY2VfdAogL3B0bXgJCQlzeXN0
ZW1fdTpvYmplY3RfcjpwdG14X3QKKy9wcHAJCQlzeXN0ZW1fdTpvYmplY3RfcjpuZXRfZGV2aWNl
X3QKIAogIyBGTEFTSwotLS0gc2VsaW51eC1zbWFsbC0yMDAyMDExNzE4Lm9yaWcvc2V0ZmlsZXMv
ZmlsZV9jb250ZXh0cworKysgc2VsaW51eC1zbWFsbC0yMDAyMDExNzE4L3NldGZpbGVzL2ZpbGVf
Y29udGV4dHMKQEAgLTE3Nyw2ICsxNzcsOCBAQAogL2V0Yy9uYW1lZC5jb25mICAgICAgIAkJc3lz
dGVtX3U6b2JqZWN0X3I6bmFtZWRfY29uZl90CiAvZXRjL21ydGcofC8uKikJCQlzeXN0ZW1fdTpv
YmplY3RfcjpldGNfbXJ0Z190CiAvZXRjL2RoY3BjLioofC8uKikJCXN5c3RlbV91Om9iamVjdF9y
OmV0Y19kaGNwY190CisvZXRjL2RoY2xpZW50LmNvbmYJCXN5c3RlbV91Om9iamVjdF9yOmV0Y19k
aGNwY190CisvZXRjL2RoY2xpZW50LXNjcmlwdAkJc3lzdGVtX3U6b2JqZWN0X3I6ZXRjX2RoY3Bj
X3QKIAogIwogIyAvbGliCkBAIC0yMzIsNiArMjM0LDcgQEAKIC9zYmluL2lwCQkJc3lzdGVtX3U6
b2JqZWN0X3I6bmV0dXRpbHNfZXhlY190CiAvc2Jpbi9hcnBpbmcJCQlzeXN0ZW1fdTpvYmplY3Rf
cjpuZXR1dGlsc19leGVjX3QKIC9zYmluL2RoY3BjZAkJCXN5c3RlbV91Om9iamVjdF9yOmRoY3Bj
X2V4ZWNfdAorL3NiaW4vZGhjbGllbnQuKgkJc3lzdGVtX3U6b2JqZWN0X3I6ZGhjcGNfZXhlY190
CiAvc2Jpbi9pcGNoYWlucwkJCXN5c3RlbV91Om9iamVjdF9yOmlwY2hhaW5zX2V4ZWNfdAogL3Ni
aW4vaXBjaGFpbnMtcmVzdG9yZQkJc3lzdGVtX3U6b2JqZWN0X3I6aXBjaGFpbnNfZXhlY190CiAv
c2Jpbi9pcGNoYWlucy1zYXZlCQlzeXN0ZW1fdTpvYmplY3RfcjppcGNoYWluc19leGVjX3QKQEAg
LTM1Nyw2ICszNjAsNyBAQAogL3Vzci9zYmluL25hbWVkICAgICAgIAkJc3lzdGVtX3U6b2JqZWN0
X3I6bmFtZWRfZXhlY190CiAvdXNyL3NiaW4vY2hlY2twYwkJc3lzdGVtX3U6b2JqZWN0X3I6Y2hl
Y2twY19leGVjX3QKIC91c3Ivc2Jpbi9pcGNoYWlucwkJc3lzdGVtX3U6b2JqZWN0X3I6aXBjaGFp
bnNfZXhlY190CisvdXNyL3NiaW4vcHBwZAkJCXN5c3RlbV91Om9iamVjdF9yOnBwcGRfZXhlY190
CiAKICMKICMgL3Vzci9YMTFSNi9iaW4K

--------------Boundary-00=_F2777D4HT68RC89PZXE1--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA25968
	for <selinux@tycho.nsa.gov>; Sun, 25 Aug 2002 20:36:43 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA27628
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 00:35:35 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id AAA27622
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 00:35:33 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id CF82292494
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 10:36:38 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id AB4DB7494
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 02:36:26 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: cardmgr.te patch
Date: Mon, 26 Aug 2002 01:58:41 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_TXBF64ZF688ED6RT1FE8"
Message-Id: <20020826003626.AB4DB7494@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_TXBF64ZF688ED6RT1FE8
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Subject: 

The attached patch against the latest release allows the administrator to run 
"cardctl eject", allows cardmgr to create device nodes when it wants to 
(should look into the possibility of changing the way cardmgr works), and 
allows dpkg to stop and start the card manager for upgrades.

It works for me and it's based on what works for Brian.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.



--------------Boundary-00=_TXBF64ZF688ED6RT1FE8
Content-Type: text/x-diff;
  charset="us-ascii";
  name="card.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="card.diff"

ZGlmZiAtcnVOIC90bXAvc2VsaW51eC9wb2xpY3kvZG9tYWlucy9wcm9ncmFtL2NhcmRtZ3IudGUg
Li9kb21haW5zL3Byb2dyYW0vY2FyZG1nci50ZQotLS0gL3RtcC9zZWxpbnV4L3BvbGljeS9kb21h
aW5zL3Byb2dyYW0vY2FyZG1nci50ZQkyMDAyLTA4LTIxIDIwOjIyOjQzLjAwMDAwMDAwMCArMDIw
MAorKysgLi9kb21haW5zL3Byb2dyYW0vY2FyZG1nci50ZQkyMDAyLTA4LTI1IDE4OjU4OjE2LjAw
MDAwMDAwMCArMDIwMApAQCAtOSw5ICs5LDEyIEBACiAjCiB0eXBlIGNhcmRtZ3JfdCwgZG9tYWlu
LCBwcml2bG9nOwogcm9sZSBzeXN0ZW1fciB0eXBlcyBjYXJkbWdyX3Q7Cityb2xlIHN5c2FkbV9y
IHR5cGVzIGNhcmRtZ3JfdDsKIGV2ZXJ5X2RvbWFpbihjYXJkbWdyX3QpCiB0eXBlIGNhcmRtZ3Jf
ZXhlY190LCBmaWxlX3R5cGUsIHN5c2FkbWZpbGUsIGV4ZWNfdHlwZTsKIGRvbWFpbl9hdXRvX3Ry
YW5zKGluaXRyY190LCBjYXJkbWdyX2V4ZWNfdCwgY2FyZG1ncl90KQordHlwZSBjYXJkY3RsX2V4
ZWNfdCwgZmlsZV90eXBlLCBzeXNhZG1maWxlLCBleGVjX3R5cGU7Citkb21haW5fYXV0b190cmFu
cyhzeXNhZG1fdCwgY2FyZGN0bF9leGVjX3QsIGNhcmRtZ3JfdCkKIHR5cGVfdHJhbnNpdGlvbiBp
bml0X3QgY2FyZG1ncl9leGVjX3Q6cHJvY2VzcyBjYXJkbWdyX3Q7CiAKICMgVXNlIGNhcGFiaWxp
dGllcyAobmV0X2FkbWluIGZvciByb3V0ZSksIHNldHVpZCBmb3IgY2FyZGN0bApAQCAtMjYsMTEg
KzI5LDEyIEBACiAjIGZvciAvZXRjL3Jlc29sdi5jb25mCiBmaWxlX3R5cGVfYXV0b190cmFucyhj
YXJkbWdyX3QsIGV0Y190LCByZXNvbHZfY29uZl90KQogCisjIGFsbG93IGNhcmRtZ3IgdG8gd3Jp
dGUgdG8gdGhlIHN5c2FkbSB0ZXJtaW5hbCAob3RoZXJ3aXNlIGl0IHdpbGwgbm90IHN0YXJ0KQor
YWxsb3cgY2FyZG1ncl90IHsgc3lzYWRtX3R0eV9kZXZpY2VfdCBzeXNhZG1fZGV2cHRzX3QgfTpj
aHJfZmlsZSB7IHJlYWQgd3JpdGUgfTsKKwogIyBDcmVhdGUgcGlkIGZpbGUgYW5kIHRlbXBvcmFy
eSBibG9jayBhbmQgY2hhcmFjdGVyIGRldmljZSBub2RlcwogdHlwZSBjYXJkbWdyX3Zhcl9ydW5f
dCwgZmlsZV90eXBlLCBzeXNhZG1maWxlLCBwaWRmaWxlOwotZmlsZV90eXBlX2F1dG9fdHJhbnMo
Y2FyZG1ncl90LCB7IHZhcl9ydW5fdCBkZXZmc190IH0sIGNhcmRtZ3JfdmFyX3J1bl90KQotYWxs
b3cgY2FyZG1ncl90IGNhcmRtZ3JfdmFyX3J1bl90OnsgY2hyX2ZpbGUgYmxrX2ZpbGUgfSBjcmVh
dGVfZmlsZV9wZXJtczsKLXR5cGVfdHJhbnNpdGlvbiBjYXJkbWdyX3QgeyB2YXJfcnVuX3QgZGV2
ZnNfdCB9OnsgY2hyX2ZpbGUgYmxrX2ZpbGUgfSBjYXJkbWdyX3Zhcl9ydW5fdDsKK2ZpbGVfdHlw
ZV9hdXRvX3RyYW5zKGNhcmRtZ3JfdCwgeyB2YXJfcnVuX3QgZGV2aWNlX3QgfSwgY2FyZG1ncl92
YXJfcnVuX3QsIHsgYmxrX2ZpbGUgY2hyX2ZpbGUgZmlsZSB9KQogCiAjIENyZWF0ZSBzdGFiIGZp
bGUuCiB0eXBlIGNhcmRtZ3JfdmFyX2xpYl90LCBmaWxlX3R5cGUsIHN5c2FkbWZpbGU7CmRpZmYg
LXJ1TiAvdG1wL3NlbGludXgvcG9saWN5L2RvbWFpbnMvcHJvZ3JhbS9kcGtnLnRlIC4vZG9tYWlu
cy9wcm9ncmFtL2Rwa2cudGUKLS0tIC90bXAvc2VsaW51eC9wb2xpY3kvZG9tYWlucy9wcm9ncmFt
L2Rwa2cudGUJMjAwMi0wOC0yMSAyMDoyMjo0NC4wMDAwMDAwMDAgKzAyMDAKKysrIC4vZG9tYWlu
cy9wcm9ncmFtL2Rwa2cudGUJMjAwMi0wOC0yNiAwMTowNDowNC4wMDAwMDAwMDAgKzAyMDAKQEAg
LTQwLDcgKzQwLDcgQEAKIGlmZGVmKGBjYXJkbWdyLnRlJywgYAogYWxsb3cgY2FyZG1ncl90IGRw
a2dfdDpmZCB1c2U7CiBhbGxvdyBjYXJkbWdyX3QgZHBrZ190OmZpZm9fZmlsZSB3cml0ZTsKLWRv
bWFpbl9hdXRvX3RyYW5zKGRwa2dfdCwgY2FyZG1ncl9leGVjX3QsIGNhcmRtZ3JfdCkKK2RvbWFp
bl9hdXRvX3RyYW5zKGRwa2dfdCwgeyBjYXJkY3RsX2V4ZWNfdCBjYXJkbWdyX2V4ZWNfdCB9LCBj
YXJkbWdyX3QpCiAnKQogaWZkZWYoYG5ldHNjYXBlLnRlJywgYAogIyBoYXRlIHRvIGRvIHRoaXMs
IGZvciBuZXRzY2FwZSBpbnN0YWxsIHNjcmlwdHMKZGlmZiAtcnVOIC90bXAvc2VsaW51eC9wb2xp
Y3kvZmlsZV9jb250ZXh0cy9wcm9ncmFtL2NhcmRtZ3IuZmMgLi9maWxlX2NvbnRleHRzL3Byb2dy
YW0vY2FyZG1nci5mYwotLS0gL3RtcC9zZWxpbnV4L3BvbGljeS9maWxlX2NvbnRleHRzL3Byb2dy
YW0vY2FyZG1nci5mYwkyMDAyLTA2LTI4IDIwOjE0OjExLjAwMDAwMDAwMCArMDIwMAorKysgLi9m
aWxlX2NvbnRleHRzL3Byb2dyYW0vY2FyZG1nci5mYwkyMDAyLTA4LTI1IDE4OjU1OjAzLjAwMDAw
MDAwMCArMDIwMApAQCAtMSw1ICsxLDUgQEAKICMgY2FyZG1ncgogL3NiaW4vY2FyZG1ncgkJCXN5
c3RlbV91Om9iamVjdF9yOmNhcmRtZ3JfZXhlY190Ci0vc2Jpbi9jYXJkY3RsCQkJc3lzdGVtX3U6
b2JqZWN0X3I6Y2FyZG1ncl9leGVjX3QKKy9zYmluL2NhcmRjdGwJCQlzeXN0ZW1fdTpvYmplY3Rf
cjpjYXJkY3RsX2V4ZWNfdAogL3Zhci9ydW4vc3RhYgkJCXN5c3RlbV91Om9iamVjdF9yOmNhcmRt
Z3JfdmFyX3J1bl90CiAvZXRjL2FwbS9ldmVudC5kL3BjbWNpYQkJc3lzdGVtX3U6b2JqZWN0X3I6
Y2FyZG1ncl9leGVjX3QK

--------------Boundary-00=_TXBF64ZF688ED6RT1FE8--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

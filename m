Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA25970
	for <selinux@tycho.nsa.gov>; Sun, 25 Aug 2002 20:36:44 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id AAA20334
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 00:35:03 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id AAA20324 for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 00:35:01 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id D7DB492495
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 10:36:38 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id D4EB974CA
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 02:36:26 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: postfix patch
Date: Mon, 26 Aug 2002 02:04:53 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_58CFE0SZKVF3LWJEEHN3"
Message-Id: <20020826003626.D4EB974CA@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_58CFE0SZKVF3LWJEEHN3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I've attached a patch for the postfix policy that fixes two spurious 
warnings, one potential situation where the policy could fail to compile, and 
a typo in merging changes into cvs.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--------------Boundary-00=_58CFE0SZKVF3LWJEEHN3
Content-Type: text/x-diff;
  charset="us-ascii";
  name="postfix.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="postfix.diff"

ZGlmZiAtcnVOIC90bXAvc2VsaW51eC9wb2xpY3kvZG9tYWlucy9wcm9ncmFtL3Bvc3RmaXgudGUg
Li9kb21haW5zL3Byb2dyYW0vcG9zdGZpeC50ZQotLS0gL3RtcC9zZWxpbnV4L3BvbGljeS9kb21h
aW5zL3Byb2dyYW0vcG9zdGZpeC50ZQkyMDAyLTA4LTIxIDIwOjIyOjQ1LjAwMDAwMDAwMCArMDIw
MAorKysgLi9kb21haW5zL3Byb2dyYW0vcG9zdGZpeC50ZQkyMDAyLTA4LTI0IDIxOjQxOjE3LjAw
MDAwMDAwMCArMDIwMApAQCAtMTI4LDcgKzEyOSwxMCBAQAogCiBwb3N0Zml4X3NlcnZlcl9kb21h
aW4obG9jYWwsIGAsIG10YV9kZWxpdmVyeV9hZ2VudCcpCiBjYW5fbmV0d29yayhwb3N0Zml4X2xv
Y2FsX3QpCitpZmRlZihgcHJvY21haWwudGUnLCBgCiBkb21haW5fYXV0b190cmFuc19yZWFkKHBv
c3RmaXhfbG9jYWxfdCwgcHJvY21haWxfZXhlY190LCBwcm9jbWFpbF90KQorZG9udGF1ZGl0IHBy
b2NtYWlsX3QgcG9zdGZpeF9sb2NhbF90OnRjcF9zb2NrZXQgeyByZWFkIHdyaXRlIH07CisnKQog
YWxsb3cgcG9zdGZpeF9sb2NhbF90IHsgZXRjX2FsaWFzZXNfdCB9OmZpbGUgcl9maWxlX3Blcm1z
OwogYWxsb3cgcG9zdGZpeF9sb2NhbF90IHNlbGY6Zmlmb19maWxlIHJ3X2ZpbGVfcGVybXM7CiBh
bGxvdyBwb3N0Zml4X2xvY2FsX3QgcG9zdGZpeF9zcG9vbF90OmRpciByX2Rpcl9wZXJtczsKZGlm
ZiAtcnVOIC90bXAvc2VsaW51eC9wb2xpY3kvZmlsZV9jb250ZXh0cy9wcm9ncmFtL3Bvc3RmaXgu
ZmMgLi9maWxlX2NvbnRleHRzL3Byb2dyYW0vcG9zdGZpeC5mYwotLS0gL3RtcC9zZWxpbnV4L3Bv
bGljeS9maWxlX2NvbnRleHRzL3Byb2dyYW0vcG9zdGZpeC5mYwkyMDAyLTA4LTIyIDE0OjU1OjUz
LjAwMDAwMDAwMCArMDIwMAorKysgLi9maWxlX2NvbnRleHRzL3Byb2dyYW0vcG9zdGZpeC5mYwky
MDAyLTA4LTI0IDIyOjU2OjI3LjAwMDAwMDAwMCArMDIwMApAQCAtMzEsNyArMzEsNiBAQAogL3Zh
ci9zcG9vbC9wb3N0Zml4L3BpZC8uKglzeXN0ZW1fdTpvYmplY3Rfcjpwb3N0Zml4X3Zhcl9ydW5f
dAogL3Zhci9zcG9vbC9wb3N0Zml4L3ByaXZhdGUoLy4qKT8gc3lzdGVtX3U6b2JqZWN0X3I6cG9z
dGZpeF9wcml2YXRlX3QKIC92YXIvc3Bvb2wvcG9zdGZpeC9wdWJsaWMoLy4qKT8gc3lzdGVtX3U6
b2JqZWN0X3I6cG9zdGZpeF9wdWJsaWNfdAotL3Zhci9zcG9vbC9wb3N0Zml4L2RlZmVyKHJlZCko
Ly4qKT8gc3lzdGVtX3U6b2JqZWN0X3I6cG9zdGZpeF9zcG9vbF90CisvdmFyL3Nwb29sL3Bvc3Rm
aXgvZGVmZXIocmVkKT8oLy4qKT8gc3lzdGVtX3U6b2JqZWN0X3I6cG9zdGZpeF9zcG9vbF90CiAv
dmFyL3Nwb29sL3Bvc3RmaXgvYm91bmNlKC8uKik/IHN5c3RlbV91Om9iamVjdF9yOnBvc3RmaXhf
c3Bvb2xfYm91bmNlX3QKIC92YXIvc3Bvb2wvcG9zdGZpeC9mbHVzaCgvLiopPyBzeXN0ZW1fdTpv
YmplY3Rfcjpwb3N0Zml4X3Nwb29sX2ZsdXNoX3QKLQpkaWZmIC1ydU4gL3RtcC9zZWxpbnV4L3Bv
bGljeS9tYWNyb3MvcHJvZ3JhbS9tdGFfbWFjcm9zLnRlIC4vbWFjcm9zL3Byb2dyYW0vbXRhX21h
Y3Jvcy50ZQotLS0gL3RtcC9zZWxpbnV4L3BvbGljeS9tYWNyb3MvcHJvZ3JhbS9tdGFfbWFjcm9z
LnRlCTIwMDItMDgtMjEgMjA6MjI6NDcuMDAwMDAwMDAwICswMjAwCisrKyAuL21hY3Jvcy9wcm9n
cmFtL210YV9tYWNyb3MudGUJMjAwMi0wOC0yNCAyMzo0MToxOS4wMDAwMDAwMDAgKzAyMDAKQEAg
LTU2LDYgKzU2LDEwIEBACiAnLCBgCiAjIFJlYWQgdXNlciB0ZW1wb3JhcnkgZmlsZXMuCiBhbGxv
dyAkMV9tYWlsX3QgJDFfdG1wX3Q6ZmlsZSB7IHJlYWQgZ2V0YXR0ciB9OworaWZkZWYoYHBvc3Rm
aXgudGUnLCBgCisjIHBvc3RmaXggYXNrcyBmb3IgYXBwZW5kIGFjY2VzcyBidXQgZG9lcyBub3Qg
bmVlZCBpdAorZG9udGF1ZGl0ICQxX21haWxfdCAkMV90bXBfdDpmaWxlIGFwcGVuZDsKKycpCiBh
bGxvdyBtdGFfdXNlcl9hZ2VudCAkMV90bXBfdDpmaWxlIHsgcmVhZCBnZXRhdHRyIH07CiAKICMg
V3JpdGUgdG8gdGhlIHVzZXIgZG9tYWluIHR0eS4K

--------------Boundary-00=_58CFE0SZKVF3LWJEEHN3--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

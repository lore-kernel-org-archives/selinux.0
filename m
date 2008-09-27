Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8RFuNVu005477
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2008 11:56:23 -0400
Received: from mail.asahi-net.or.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8RFuD1t010870
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2008 15:56:22 GMT
Message-ID: <48DE5718.2050404@kaigai.gr.jp>
Date: Sun, 28 Sep 2008 00:54:00 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Dominick Grift <domg472@gmail.com>, KaiGai Kohei <kaigai@ak.jp.nec.com>,
        selinux@tycho.nsa.gov
Subject: Re: How to find SELinux policy type?
References: <alpine.LRH.1.10.0809240910240.32319@tundra.namei.org>	 <48D98748.6090408@ak.jp.nec.com> <9546.1222400049@turing-police.cc.vt.edu>	 <48DC5C16.9040607@ak.jp.nec.com>	 <1222421896.24783.7.camel@sulphur.notebook.internal>	 <48DCB88E.3080503@kaigai.gr.jp> <1222425714.24783.13.camel@sulphur.notebook.internal> <48DCE45B.3040900@kaigai.gr.jp>
In-Reply-To: <48DCE45B.3040900@kaigai.gr.jp>
Content-Type: multipart/mixed;
 boundary="------------040502060208040907080506"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040502060208040907080506
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

> Dan,
> 
> Could you add the following policy into F9 updates?
> It is already merged into upstream policy, but I cannot find it
> at selinux-policy-3.3.1-91.
> 
> --- at modules/system/libraries.te ---
> optional_policy(`
>         postgresql_loadable_module(lib_t)
>         postgresql_loadable_module(textrel_shlib_t)
> ')
> --------------------------------------

Thanks, I confirmed it is fixed at selinux-policy-3.3.1-95.fc9.

But what I pointed out is incomplete. :(
Could you apply the attached patch towards the 3.3.1 series policy?
It allows userdomains and httpd_t to connect SE-PostgreSQL.
(No need to say, it compatible to upstream refpolicy.)

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--------------040502060208040907080506
Content-Type: application/octect-stream;
 name="serefpolicy-sepostgresql-fix-3.3.1.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="serefpolicy-sepostgresql-fix-3.3.1.patch"

ZGlmZiAtcHJOVTMgc2VyZWZwb2xpY3ktMy4zLjEub3JpZy9wb2xpY3kvbW9kdWxlcy9zZXJ2
aWNlcy9hcGFjaGUuaWYgc2VyZWZwb2xpY3ktMy4zLjEuZml4ZWQvcG9saWN5L21vZHVsZXMv
c2VydmljZXMvYXBhY2hlLmlmCi0tLSBzZXJlZnBvbGljeS0zLjMuMS5vcmlnL3BvbGljeS9t
b2R1bGVzL3NlcnZpY2VzL2FwYWNoZS5pZgkyMDA4LTA5LTI4IDAwOjI3OjMyLjAwMDAwMDAw
MCArMDkwMAorKysgc2VyZWZwb2xpY3ktMy4zLjEuZml4ZWQvcG9saWN5L21vZHVsZXMvc2Vy
dmljZXMvYXBhY2hlLmlmCTIwMDgtMDktMjggMDA6NDM6MzAuMDAwMDAwMDAwICswOTAwCkBA
IC0xNzAsNiArMTcwLDE0IEBAIHRlbXBsYXRlKGBhcGFjaGVfY29udGVudF90ZW1wbGF0ZScs
YAogCScpCiAKIAlvcHRpb25hbF9wb2xpY3koYAorCQlwb3N0Z3Jlc3FsX3VucHJpdl9jbGll
bnQoaHR0cGRfJDFfc2NyaXB0X3QpCisKKwkJdHVuYWJsZV9wb2xpY3koYGh0dHBkX2VuYWJs
ZV9jZ2kgJiYgaHR0cGRfY2FuX25ldHdvcmtfY29ubmVjdF9kYicsYAorCQkJcG9zdGdyZXNx
bF90Y3BfY29ubmVjdChodHRwZF8kMV9zY3JpcHRfdCkKKwkJJykKKwknKQorCisJb3B0aW9u
YWxfcG9saWN5KGAKIAkJbnNjZF9zb2NrZXRfdXNlKGh0dHBkXyQxX3NjcmlwdF90KQogCScp
CiAnKQpkaWZmIC1wck5VMyBzZXJlZnBvbGljeS0zLjMuMS5vcmlnL3BvbGljeS9tb2R1bGVz
L3NlcnZpY2VzL2FwYWNoZS50ZSBzZXJlZnBvbGljeS0zLjMuMS5maXhlZC9wb2xpY3kvbW9k
dWxlcy9zZXJ2aWNlcy9hcGFjaGUudGUKLS0tIHNlcmVmcG9saWN5LTMuMy4xLm9yaWcvcG9s
aWN5L21vZHVsZXMvc2VydmljZXMvYXBhY2hlLnRlCTIwMDgtMDktMjggMDA6Mjc6MzIuMDAw
MDAwMDAwICswOTAwCisrKyBzZXJlZnBvbGljeS0zLjMuMS5maXhlZC9wb2xpY3kvbW9kdWxl
cy9zZXJ2aWNlcy9hcGFjaGUudGUJMjAwOC0wOS0yOCAwMDo0NToyMy4wMDAwMDAwMDAgKzA5
MDAKQEAgLTU4OCw2ICs1ODgsNyBAQCB0dW5hYmxlX3BvbGljeShgaHR0cGRfY2FuX25ldHdv
cmtfY29ubmVjCiBvcHRpb25hbF9wb2xpY3koYAogCSMgQWxsb3cgaHR0cGQgdG8gd29yayB3
aXRoIHBvc3RncmVzcWwKIAlwb3N0Z3Jlc3FsX3N0cmVhbV9jb25uZWN0KGh0dHBkX3QpCisJ
cG9zdGdyZXNxbF91bnByaXZfY2xpZW50KGh0dHBkX3QpCiAnKQogCiBvcHRpb25hbF9wb2xp
Y3koYApkaWZmIC1wck5VMyBzZXJlZnBvbGljeS0zLjMuMS5vcmlnL3BvbGljeS9tb2R1bGVz
L3N5c3RlbS91bmNvbmZpbmVkLmlmIHNlcmVmcG9saWN5LTMuMy4xLmZpeGVkL3BvbGljeS9t
b2R1bGVzL3N5c3RlbS91bmNvbmZpbmVkLmlmCi0tLSBzZXJlZnBvbGljeS0zLjMuMS5vcmln
L3BvbGljeS9tb2R1bGVzL3N5c3RlbS91bmNvbmZpbmVkLmlmCTIwMDgtMDktMjggMDA6Mjc6
MzIuMDAwMDAwMDAwICswOTAwCisrKyBzZXJlZnBvbGljeS0zLjMuMS5maXhlZC9wb2xpY3kv
bW9kdWxlcy9zeXN0ZW0vdW5jb25maW5lZC5pZgkyMDA4LTA5LTI4IDAwOjQxOjQzLjAwMDAw
MDAwMCArMDkwMApAQCAtOTUsNiArOTUsMTAgQEAgaW50ZXJmYWNlKGB1bmNvbmZpbmVkX2Rv
bWFpbl9ub2F1ZGl0JyxgCiAJJykKIAogCW9wdGlvbmFsX3BvbGljeShgCisJCXBvc3RncmVz
cWxfdW5jb25maW5lZCgkMSkKKwknKQorCisJb3B0aW9uYWxfcG9saWN5KGAKIAkJc2V1dGls
X2NyZWF0ZV9iaW5fcG9saWN5KCQxKQogCQlzZXV0aWxfcmVsYWJlbHRvX2Jpbl9wb2xpY3ko
JDEpCiAJJykKZGlmZiAtcHJOVTMgc2VyZWZwb2xpY3ktMy4zLjEub3JpZy9wb2xpY3kvbW9k
dWxlcy9zeXN0ZW0vdXNlcmRvbWFpbi5pZiBzZXJlZnBvbGljeS0zLjMuMS5maXhlZC9wb2xp
Y3kvbW9kdWxlcy9zeXN0ZW0vdXNlcmRvbWFpbi5pZgotLS0gc2VyZWZwb2xpY3ktMy4zLjEu
b3JpZy9wb2xpY3kvbW9kdWxlcy9zeXN0ZW0vdXNlcmRvbWFpbi5pZgkyMDA4LTA5LTI4IDAw
OjI3OjMyLjAwMDAwMDAwMCArMDkwMAorKysgc2VyZWZwb2xpY3ktMy4zLjEuZml4ZWQvcG9s
aWN5L21vZHVsZXMvc3lzdGVtL3VzZXJkb21haW4uaWYJMjAwOC0wOS0yOCAwMDo0MDo1NS4w
MDAwMDAwMDAgKzA5MDAKQEAgLTEyMjgsNiArMTIyOCwxMCBAQCB0ZW1wbGF0ZShgdXNlcmRv
bV91bnByaXZfdXNlcl90ZW1wbGF0ZScsCiAJJykKIAogCW9wdGlvbmFsX3BvbGljeShgCisJ
CXBvc3RncmVzcWxfdXNlcmRvbV90ZW1wbGF0ZSgkMSwkMV90LCQxX3IpCisJJykKKworCW9w
dGlvbmFsX3BvbGljeShgCiAJCWphdmFfcGVyX3JvbGVfdGVtcGxhdGUoJDEsICQxX3QsICQx
X3IpCiAJJykKIApAQCAtMTM4OSw2ICsxMzkzLDEwIEBAIHRlbXBsYXRlKGB1c2VyZG9tX2Fk
bWluX3VzZXJfdGVtcGxhdGUnLGAKIAlzZXV0aWxfbWFuYWdlX2Jpbl9wb2xpY3koJDFfdCkK
IAogCW9wdGlvbmFsX3BvbGljeShgCisJCXBvc3RncmVzcWxfdW5jb25maW5lZCgkMV90KQor
CScpCisKKwlvcHRpb25hbF9wb2xpY3koYAogCQl1c2VyaGVscGVyX2V4ZWMoJDFfdCkKIAkn
KQogJykK
--------------040502060208040907080506--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

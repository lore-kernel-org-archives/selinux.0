Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA26011
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 09:44:54 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA28377
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 13:43:08 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id NAA28373
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 13:43:06 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id E0A2C9245A
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 23:44:49 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 96E39D297
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 15:44:40 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: named.te
Date: Tue, 23 Apr 2002 15:44:40 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_GUW0ZJM5DFMGT36EPXFP"
Message-Id: <20020423134440.96E39D297@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_GUW0ZJM5DFMGT36EPXFP
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

Here's my latest BIND policy.
/var/named(|/.*)                system_u:object_r:named_conf_t
/var/cache/bind(|/.*)           system_u:object_r:named_cache_t
/etc/named.conf                 system_u:object_r:named_conf_t
/etc/bind(|/.*)                 system_u:object_r:named_zone_t
/etc/bind/named.conf            system_u:object_r:named_conf_t
/usr/sbin/named.*               system_u:object_r:named_exec_t

It supports secondary domains and has a comment mentioning how to allow 
updates to primary zones.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--------------Boundary-00=_GUW0ZJM5DFMGT36EPXFP
Content-Type: text/plain;
  charset="us-ascii";
  name="named.te"
Content-Transfer-Encoding: base64
Content-Description: named.te
Content-Disposition: attachment; filename="named.te"

IwojIEF1dGhvcjogIFl1aWNoaSBOYWthbXVyYSA8eW5ha2FtQG9yaS5oaXRhY2hpLXNrLmNvLmpw
PgojCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKIwojIFJ1bGVzIGZvciB0aGUg
bmFtZWRfdCBkb21haW4uCiMKCiNuYW1lZF90IGlzIGdlbmVyYWwgZG9tYWluIGxhYmVsIGFuZCBj
YW4gY29tbXVuaWNhdGUgd2l0aCBzeXNsb2cuCnR5cGUgbmFtZWRfdCwgZG9tYWluLCBwcml2bG9n
Owpyb2xlIHN5c3RlbV9yIHR5cGVzIG5hbWVkX3Q7CmV2ZXJ5X2RvbWFpbihuYW1lZF90KQojIG5k
Y190IGlzIHRoZSBkb21haW4gZm9yIHRoZW5kYyBwcm9ncmFtCnR5cGUgbmRjX3QsIGRvbWFpbiwg
cHJpdmxvZzsKcm9sZSBzeXNhZG1fciB0eXBlcyBuZGNfdDsKCiNBIHR5cGUgZm9yIC91c3Ivc2Jp
bi9uYW1lZAp0eXBlIG5hbWVkX2V4ZWNfdCwgZmlsZV90eXBlLHN5c2FkbWZpbGUsIGV4ZWNfdHlw
ZTsKZG9tYWluX2F1dG9fdHJhbnMoaW5pdHJjX3QsIG5hbWVkX2V4ZWNfdCwgbmFtZWRfdCkKdHlw
ZV90cmFuc2l0aW9uIGluaXRfdCBuYW1lZF9leGVjX3Q6cHJvY2VzcyBuYW1lZF90OwoKY2FuX2V4
ZWMobmFtZWRfdCwgbmFtZWRfZXhlY190KQoKIyBBIHR5cGUgZm9yIGNvbmZpZ3VyYXRpb24gZmls
ZXMgb2YgbmFtZWQuCnR5cGUgbmFtZWRfY29uZl90LCBmaWxlX3R5cGUsc3lzYWRtZmlsZTsKCiMg
Zm9yIHByaW1hcnkgem9uZSBmaWxlcwp0eXBlIG5hbWVkX3pvbmVfdCwgZmlsZV90eXBlLCBzeXNh
ZG1maWxlOwoKIyBmb3Igc2Vjb25kYXJ5IHpvbmUgZmlsZXMKdHlwZSBuYW1lZF9jYWNoZV90LCBm
aWxlX3R5cGUsIHN5c2FkbWZpbGU7CgojIEEgdHlwZSBmb3IgZmlsZXMgaW4gL3Zhci9ydW4gc3Bl
Y2lmaWMgdG8gbmFtZWQKdHlwZSBuYW1lZF92YXJfcnVuX3QsIGZpbGVfdHlwZSwgc3lzYWRtZmls
ZSwgcGlkZmlsZTsKCiMgVXNlIGNhcGFiaWxpdGllcy4gU3VycGx1cyBjYXBhYmlsaXRpZXMgbWF5
IGJlIGFsbG93ZWQuCmFsbG93IG5hbWVkX3QgbmFtZWRfdDpjYXBhYmlsaXR5IHsgc2V0dWlkIHNl
dGdpZCBuZXRfYmluZF9zZXJ2aWNlIH07CgojIEluaGVyaXQgYW5kIHVzZSBkZXNjcmlwdG9ycyBm
cm9tIGluaXQuCmFsbG93IG5hbWVkX3QgaW5pdF90OmZkIGluaGVyaXRfZmRfcGVybXM7CgojTmFt
ZWQgY2FuIHVzZSBuZXR3b3JrCmNhbl9uZXR3b3JrKG5hbWVkX3QpCiMgYWxsb3cgVURQIHRyYW5z
ZmVyIHRvL2Zyb20gYW55IHByb2dyYW0KY2FuX3VkcF9zZW5kKGRvbWFpbiwgbmFtZWRfdCkKY2Fu
X3VkcF9zZW5kKG5hbWVkX3QsIGRvbWFpbikKCiMgQmluZCB0byB0aGUgbmFtZWQgcG9ydC4KYWxs
b3cgbmFtZWRfdCBuYW1lZF9wb3J0X3Q6dWRwX3NvY2tldCBuYW1lX2JpbmQ7CgoKIyBBbGxvdyBu
YW1lZF90IHRvIHB1dCBhIHBpZCBmaWxlIGluIC92YXIvcnVuCmZpbGVfdHlwZV9hdXRvX3RyYW5z
KG5hbWVkX3QsIHZhcl9ydW5fdCwgbmFtZWRfdmFyX3J1bl90KQoKI25hbWVkIGNhbiBhcHBlbmQg
dG8gbG9nIGZpbGVzLgphbGxvdyBuYW1lZF90IHZhcl9sb2dfdDpmaWxlIHJhX2ZpbGVfcGVybXM7
CgojcmVhZCBjb25maWd1cmF0aW9uIGZpbGVzCmFsbG93IG5hbWVkX3QgbmFtZWRfY29uZl90OmZp
bGUgcl9maWxlX3Blcm1zOwoKI3JlYWQgem9uZSBmaWxlcyAtIGNoYW5nZSB0aGlzIHRvIHJ3XyBm
b3IgdGhlIGRpciBhbmQgY3JlYXRlXyBmb3IgdGhlIGZpbGUgdG8KIyBlbmFibGUgZG9tYWluIGF1
dG8gdXBkYXRlcy4KYWxsb3cgbmFtZWRfdCBuYW1lZF96b25lX3Q6ZGlyIHJfZGlyX3Blcm1zOwph
bGxvdyBuYW1lZF90IG5hbWVkX3pvbmVfdDpmaWxlIHJfZmlsZV9wZXJtczsKCiN3cml0ZSBjYWNo
ZSBmb3Igc2Vjb25kYXJ5IHpvbmVzCmFsbG93IG5hbWVkX3QgbmFtZWRfY2FjaGVfdDpkaXIgcndf
ZGlyX3Blcm1zOwphbGxvdyBuYW1lZF90IG5hbWVkX2NhY2hlX3Q6ZmlsZSBjcmVhdGVfZmlsZV9w
ZXJtczsKCnVzZXNfYXV0aGJpbmQobmFtZWRfdCkKCiNBIHR5cGUgZm9yIC91c3Ivc2Jpbi9uZGMK
dHlwZSBuZGNfZXhlY190LCBmaWxlX3R5cGUsc3lzYWRtZmlsZSwgZXhlY190eXBlOwpkb21haW5f
YXV0b190cmFucyhzeXNhZG1fdCwgbmRjX2V4ZWNfdCwgbmRjX3QpCnVzZXNfc2hsaWIobmRjX3Qp
CgphbGxvdyBuZGNfdCBldGNfdDpkaXIgcl9kaXJfcGVybXM7CmFsbG93IG5kY190IHNlbGY6dW5p
eF9zdHJlYW1fc29ja2V0IGNyZWF0ZV9zdHJlYW1fc29ja2V0X3Blcm1zOwphbGxvdyBuZGNfdCBz
ZWxmOnVuaXhfc3RyZWFtX3NvY2tldCBjb25uZWN0OwphbGxvdyBuZGNfdCBzZWxmOmNhcGFiaWxp
dHkgZGFjX292ZXJyaWRlOwphbGxvdyBuZGNfdCBuYW1lZF92YXJfcnVuX3Q6c29ja19maWxlIHJ3
X2ZpbGVfcGVybXM7CmFsbG93IG5kY190IG5hbWVkX3Q6dW5peF9zdHJlYW1fc29ja2V0IGNvbm5l
Y3R0bzsK

--------------Boundary-00=_GUW0ZJM5DFMGT36EPXFP--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA10504
	for <selinux@tycho.nsa.gov>; Fri, 29 Mar 2002 18:00:56 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA20051
	for <selinux@tycho.nsa.gov>; Fri, 29 Mar 2002 22:59:51 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id WAA20047 for <selinux@tycho.nsa.gov>; Fri, 29 Mar 2002 22:59:48 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id AA1F692452
	for <selinux@tycho.nsa.gov>; Sat, 30 Mar 2002 10:00:38 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 8333428706
	for <selinux@tycho.nsa.gov>; Sat, 30 Mar 2002 00:00:26 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: dictd and gatekeeper sample policy
Date: Sat, 30 Mar 2002 00:00:26 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_QWBRMFCAKWKI0IIP01O8"
Message-Id: <20020329230026.8333428706@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_QWBRMFCAKWKI0IIP01O8
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

Here's the file_contexts data:
/var/lib/dictd(|/.*)            system_u:object_r:var_lib_dictd_t
/etc/gatekeeper.ini             system_u:object_r:etc_gatekeeper_t
/etc/dictd.conf                 system_u:object_r:etc_dictd_t
/usr/sbin/gk                    system_u:object_r:gatekeeper_exec_t
/usr/sbin/dictd                 system_u:object_r:dictd_exec_t

The dictd policy (for the dictionary daemon) is fully tested and works well.

The gatekeeper policy (for the Open H.323 gate keeper) is not complete as I 
don't have it fully working.  I'm including it so that anyone else who wants 
to play with GK will have half the work done for them.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--------------Boundary-00=_QWBRMFCAKWKI0IIP01O8
Content-Type: text/plain;
  charset="us-ascii";
  name="dictd.te"
Content-Transfer-Encoding: base64
Content-Description: dictd.te
Content-Disposition: attachment; filename="dictd.te"

IwojIEF1dGhvcnM6ICBSdXNzZWxsIENva2VyIDxydXNzZWxsQGNva2VyLmNvbS5hdT4KIwoKIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCiMKIyBSdWxlcyBmb3IgdGhlIGRpY3RkX3Qg
ZG9tYWluLgojCiMgZGljdGRfZXhlY190IGlzIHRoZSB0eXBlIG9mIHRoZSBkaWN0ZCBleGVjdXRh
YmxlLgojCnR5cGUgZGljdGRfdCwgZG9tYWluLCBwcml2bG9nOwp0eXBlIGRpY3RkX2V4ZWNfdCwg
ZmlsZV90eXBlLCBzeXNhZG1maWxlLCBleGVjX3R5cGU7CnR5cGUgdmFyX2xpYl9kaWN0ZF90LCBm
aWxlX3R5cGUsIHN5c2FkbWZpbGU7CnR5cGUgZXRjX2RpY3RkX3QsIGZpbGVfdHlwZSwgc3lzYWRt
ZmlsZTsKCnJvbGUgc3lzdGVtX3IgdHlwZXMgZGljdGRfdDsKCmFsbG93IGRpY3RkX3QgaW5pdF90
OnByb2Nlc3Mgc2lnY2hsZDsKCiMgVHlwZSBmb3IgZmlsZXMgY3JlYXRlZCBkdXJpbmcgZXhlY3V0
aW9uIG9mIGRpY3RkZC4KI2ZpbGVfdHlwZV9hdXRvX3RyYW5zKGRpY3RkX3QsIHZhcl9ydW5fdCwg
ZGljdGRfdmFyX3J1bl90KQoKIyBJbmhlcml0IGFuZCB1c2UgZGVzY3JpcHRvcnMgZnJvbSBpbml0
LgphbGxvdyBkaWN0ZF90IGluaXRfdDpmZCBpbmhlcml0X2ZkX3Blcm1zOwoKIyBnZXQgaW5mbyBm
cm9tIC9wcm9jCiNhbGxvdyBkaWN0ZF90IHByb2NfdDpmaWxlIHJfZmlsZV9wZXJtczsKI2FsbG93
IGRpY3RkX3QgcHJvY190OmRpciByX2Rpcl9wZXJtczsKCiMgcHRocmVhZHMgd2FudHMgdG8ga25v
dyB0aGUga2VybmVsIHZlcnNpb24KI2FsbG93IGRpY3RkX3Qgc3lzY3RsX2tlcm5lbF90OmRpciBy
X2Rpcl9wZXJtczsKI2FsbG93IGRpY3RkX3Qgc3lzY3RsX2tlcm5lbF90OmZpbGUgcl9maWxlX3Bl
cm1zOwoKIyByZWFkIGNvbmZpZyBmaWxlcwphbGxvdyBkaWN0ZF90IHsgZXRjX3QgZXRjX2RpY3Rk
X3QgfTp7IGZpbGUgbG5rX2ZpbGUgfSByX2ZpbGVfcGVybXM7Cgpkb21haW5fYXV0b190cmFucyhp
bml0cmNfdCwgZGljdGRfZXhlY190LCBkaWN0ZF90KQoKYWxsb3cgZGljdGRfdCB7IHJvb3RfdCBl
dGNfdCB2YXJfbGliX2RpY3RkX3QgfTpkaXIgcl9kaXJfcGVybXM7CmFsbG93IGRpY3RkX3QgdmFy
X2xpYl9kaWN0ZF90OmZpbGUgcl9maWxlX3Blcm1zOwoKdXNlc19zaGxpYihkaWN0ZF90KQphbGxv
dyBkaWN0ZF90IHVzcl90OmZpbGUgcl9maWxlX3Blcm1zOwphbGxvdyBkaWN0ZF90IHZhcl9saWJf
dDpkaXIgcl9kaXJfcGVybXM7CgphbGxvdyBkaWN0ZF90IHNlbGY6cHJvY2VzcyB7IHNldHBnaWQg
Zm9yayBzaWdjaGxkIH07CiNhbGxvdyBkaWN0ZF90IHNlbGY6Zmlmb19maWxlIHJ3X2ZpbGVfcGVy
bXM7CgphbGxvdyBkaWN0ZF90IG51bGxfZGV2aWNlX3Q6Y2hyX2ZpbGUgcndfZmlsZV9wZXJtczsK
CmFsbG93IGRpY3RkX3QgZGljdF9wb3J0X3Q6dGNwX3NvY2tldCBuYW1lX2JpbmQ7CgphbGxvdyBk
aWN0ZF90IGRldnR0eV90OmNocl9maWxlIHJ3X2ZpbGVfcGVybXM7CgphbGxvdyBkaWN0ZF90IHNl
bGY6dW5peF9zdHJlYW1fc29ja2V0IGNyZWF0ZV9zdHJlYW1fc29ja2V0X3Blcm1zOwoKY2FuX25l
dHdvcmsoZGljdGRfdCkKCmFsbG93IGRpY3RkX3QgZnNfdDpmaWxlc3lzdGVtIGdldGF0dHI7Cg==

--------------Boundary-00=_QWBRMFCAKWKI0IIP01O8
Content-Type: text/plain;
  charset="us-ascii";
  name="gatekeeper.te"
Content-Transfer-Encoding: base64
Content-Description: gatekeeper.te
Content-Disposition: attachment; filename="gatekeeper.te"

IwojIEF1dGhvcnM6ICBSdXNzZWxsIENva2VyIDxydXNzZWxsQGNva2VyLmNvbS5hdT4KIwoKIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCiMKIyBSdWxlcyBmb3IgdGhlIGdhdGVrZWVw
ZXJfdCBkb21haW4uCiMKIyBnYXRla2VlcGVyX2V4ZWNfdCBpcyB0aGUgdHlwZSBvZiB0aGUgZ2sg
ZXhlY3V0YWJsZS4KIwp0eXBlIGdhdGVrZWVwZXJfdCwgZG9tYWluLCBwcml2bG9nOwp0eXBlIGdh
dGVrZWVwZXJfZXhlY190LCBmaWxlX3R5cGUsIHN5c2FkbWZpbGUsIGV4ZWNfdHlwZTsKdHlwZSBn
YXRla2VlcGVyX3Zhcl9ydW5fdCwgZmlsZV90eXBlLCBzeXNhZG1maWxlOwp0eXBlIGV0Y19nYXRl
a2VlcGVyX3QsIGZpbGVfdHlwZSwgc3lzYWRtZmlsZTsKCnJvbGUgc3lzdGVtX3IgdHlwZXMgZ2F0
ZWtlZXBlcl90OwoKYWxsb3cgZ2F0ZWtlZXBlcl90IGluaXRfdDpwcm9jZXNzIHNpZ2NobGQ7Cgoj
IFR5cGUgZm9yIGZpbGVzIGNyZWF0ZWQgZHVyaW5nIGV4ZWN1dGlvbiBvZiBnYXRla2VlcGVyZC4K
I3R5cGUgZXRjX2dhdGVrZWVwZXJfdCwgZmlsZV90eXBlLCBzeXNhZG1maWxlOwpmaWxlX3R5cGVf
YXV0b190cmFucyhnYXRla2VlcGVyX3QsIHZhcl9ydW5fdCwgZ2F0ZWtlZXBlcl92YXJfcnVuX3Qp
CgojIEluaGVyaXQgYW5kIHVzZSBkZXNjcmlwdG9ycyBmcm9tIGluaXQuCmFsbG93IGdhdGVrZWVw
ZXJfdCBpbml0X3Q6ZmQgaW5oZXJpdF9mZF9wZXJtczsKCiMgVXNlIHRoZSBuZXR3b3JrLgpjYW5f
bmV0d29yayhnYXRla2VlcGVyX3QpCmFsbG93IGdhdGVrZWVwZXJfdCBzZWxmOnVuaXhfc3RyZWFt
X3NvY2tldCBjcmVhdGVfc29ja2V0X3Blcm1zOwoKIyBVc2UgY2FwYWJpbGl0aWVzCiNhbGxvdyBn
YXRla2VlcGVyX3Qgc2VsZjpjYXBhYmlsaXR5IHsgbmV0X3JhdyB9OwoKIyBnZXQgaW5mbyBmcm9t
IC9wcm9jCmFsbG93IGdhdGVrZWVwZXJfdCBwcm9jX3Q6ZmlsZSByX2ZpbGVfcGVybXM7CmFsbG93
IGdhdGVrZWVwZXJfdCBwcm9jX3Q6ZGlyIHJfZGlyX3Blcm1zOwoKIyBwdGhyZWFkcyB3YW50cyB0
byBrbm93IHRoZSBrZXJuZWwgdmVyc2lvbgphbGxvdyBnYXRla2VlcGVyX3Qgc3lzY3RsX2tlcm5l
bF90OmRpciByX2Rpcl9wZXJtczsKYWxsb3cgZ2F0ZWtlZXBlcl90IHN5c2N0bF9rZXJuZWxfdDpm
aWxlIHJfZmlsZV9wZXJtczsKCiMgcmVhZCBjb25maWcgZmlsZXMKYWxsb3cgZ2F0ZWtlZXBlcl90
IHsgZXRjX3QgZXRjX2dhdGVrZWVwZXJfdCB9OnsgZmlsZSBsbmtfZmlsZSB9IHJfZmlsZV9wZXJt
czsKCmRvbWFpbl9hdXRvX3RyYW5zKGluaXRyY190LCBnYXRla2VlcGVyX2V4ZWNfdCwgZ2F0ZWtl
ZXBlcl90KQoKYWxsb3cgZ2F0ZWtlZXBlcl90IHsgcm9vdF90IGV0Y190IH06ZGlyIHJfZGlyX3Bl
cm1zOwp1c2VzX3NobGliKGdhdGVrZWVwZXJfdCkKYWxsb3cgZ2F0ZWtlZXBlcl90IHVzcl90OmZp
bGUgcl9maWxlX3Blcm1zOwphbGxvdyBnYXRla2VlcGVyX3Qgc2Jpbl90OmRpciByX2Rpcl9wZXJt
czsKCmFsbG93IGdhdGVrZWVwZXJfdCBzZWxmOnByb2Nlc3MgeyBzZXRzY2hlZCBzaWduYWwgZm9y
ayB9OwphbGxvdyBnYXRla2VlcGVyX3Qgc2VsZjpmaWZvX2ZpbGUgcndfZmlsZV9wZXJtczsKCmFs
bG93IGdhdGVrZWVwZXJfdCBudWxsX2RldmljZV90OmNocl9maWxlIHJ3X2ZpbGVfcGVybXM7Cgoj
IHRoaXMgaXMgY3JhcCwgZ2sgd2FudHMgdG8gY3JlYXRlIHN5bWxpbmtzIGluIC9ldGMgZXZlcnkg
dGltZSBpdCBzdGFydHMgYW5kCiMgcmVtb3ZlIHRoZW0gd2hlbiBpdCBleGl0cy4KYWxsb3cgZ2F0
ZWtlZXBlcl90IGV0Y190OmRpciByd19kaXJfcGVybXM7CmFsbG93IGdhdGVrZWVwZXJfdCBldGNf
dDpsbmtfZmlsZSBjcmVhdGVfZmlsZV9wZXJtczsK

--------------Boundary-00=_QWBRMFCAKWKI0IIP01O8--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA29991
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 10:16:01 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA26661
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 15:14:58 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id PAA26657 for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 15:14:56 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id B57A992443
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 02:15:56 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 79E0965C
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 16:15:49 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: my latest effort at a devfsd policy
Date: Thu, 21 Mar 2002 16:15:49 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_D2XBG023FVY8SDT29P0U"
Message-Id: <20020321151549.79E0965C@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_D2XBG023FVY8SDT29P0U
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

Tell me what you think.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--------------Boundary-00=_D2XBG023FVY8SDT29P0U
Content-Type: text/plain;
  charset="us-ascii";
  name="devfsd.te"
Content-Transfer-Encoding: base64
Content-Description: devfsd.te
Content-Disposition: attachment; filename="devfsd.te"

IwojIEF1dGhvcjogIFJ1c3NlbGwgQ29rZXIgPHJ1c3NlbGxAY29rZXIuY29tLmF1PgojCgojIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKIwojIFJ1bGVzIGZvciB0aGUgZGV2ZnNkX3Qg
ZG9tYWluLgojCnR5cGUgZGV2ZnNkX3QsIGRvbWFpbiwgcHJpdmxvZzsKdHlwZSBkZXZmc2RfZXhl
Y190LCBmaWxlX3R5cGUsIHN5c2FkbWZpbGUsIGV4ZWNfdHlwZTsKCnJvbGUgc3lzdGVtX3IgdHlw
ZXMgZGV2ZnNkX3Q7CgojIEluaGVyaXQgYW5kIHVzZSBkZXNjcmlwdG9ycyBmcm9tIGluaXQuCmFs
bG93IGRldmZzZF90IGluaXRfdDpmZCBpbmhlcml0X2ZkX3Blcm1zOwphbGxvdyBkZXZmc2RfdCBp
bml0X3Q6cHJvY2VzcyBzaWdjaGxkOwoKYWxsb3cgZGV2ZnNkX3QgZGV2ZnNkX3Q6cHJvY2VzcyBm
b3JrOwoKIyBDcmVhdGUgcGlkIGZpbGUuCnR5cGUgZGV2ZnNkX3Zhcl9ydW5fdCwgZmlsZV90eXBl
LCBzeXNhZG1maWxlLCBwaWRmaWxlOwpmaWxlX3R5cGVfYXV0b190cmFucyhkZXZmc2RfdCwgdmFy
X3J1bl90LCBkZXZmc2RfdmFyX3J1bl90KQoKIyBSdW4gL3NiaW4vbW9kcHJvYmUKZG9tYWluX2F1
dG9fdHJhbnMoZGV2ZnNkX3QsIGluc21vZF9leGVjX3QsIGluc21vZF90KQoKYWxsb3cgZGV2ZnNk
X3QgZGV2ZnNkX3Q6Y2FwYWJpbGl0eSBjaG93bjsKCiMgYWxsb3cgZGV2ZnNkIHRvIGNoYW5nZSBh
bnkgb2JqZWN0IGZyb20gdHlwZSBkZXZmc2RfdCB0byBhbnkgb3RoZXIgdHlwZQojIGFsc28gYWxs
b3cgdG8gdW5saW5rCmFsbG93IGRldmZzZF90IGRldmZzX3Q6ZGlyX2ZpbGVfY2xhc3Nfc2V0IHsg
Z2V0YXR0ciBzZXRhdHRyIHJlbGFiZWxmcm9tIHVubGluayB9OyAKIyBhbGxvdyBkZXZmc2QgdG8g
Z2V0IGFuZCBzZXQgYXR0cmlidXRlcyBvZiBhbnkgZGV2aWNlIG5vZGUgYW5kIHRvIGNoYW5nZSB0
aGUKIyB0eXBlIHRvIGFueSBkZXZpY2UgdHlwZQphbGxvdyBkZXZmc2RfdCBhbGxfZGV2aWNlX3R5
cGVzOmRpcl9maWxlX2NsYXNzX3NldCB7IGdldGF0dHIgc2V0YXR0ciByZWxhYmVsdG8gfTsgCmFs
bG93IGRldmZzZF90IGFsbF9kZXZpY2VfdHlwZXM6ZGlyIHJfZGlyX3Blcm1zOwphbGxvdyBkZXZm
c2RfdCB7IGRldnB0c190IHByaW50ZXJfdCB9OmRpcl9maWxlX2NsYXNzX3NldCB7IGdldGF0dHIg
c2V0YXR0ciByZWxhYmVsdG8gfTsgCmFsbG93IGRldmZzZF90IHsgZGV2cHRzX3QgcHJpbnRlcl90
IH06ZGlyIHJfZGlyX3Blcm1zOwoKIyBhbGxvdyBhbGwgZGV2aWNlcyB0byBiZSB1bmRlciBkZXZm
c190CmFsbG93IGRvbWFpbiBkZXZmc190OmZpbGVzeXN0ZW0gYXNzb2NpYXRlOwoKIyBhbGxvdyBj
b250ZXh0IGxvb2t1cHMKYWxsb3cgZGV2ZnNkX3Qgc2VjdXJpdHlfdDpzZWN1cml0eSBjb250ZXh0
X3RvX3NpZDsKCiMgYWxsb3cgYW55b25lIHRvIHJlYWQgZGV2ZnMKYWxsb3cgZG9tYWluIGRldmZz
X3Q6ZGlyIHJfZGlyX3Blcm1zOwphbGxvdyBkb21haW4gZGV2ZnNfdDpsbmtfZmlsZSByX2ZpbGVf
cGVybXM7CgojIGFsbG93IHRoZSBwZXJtaXNzaW9ucyBhbmQgc3ltbGlua3MgdG8gYmUgZG9uZQph
bGxvdyBkZXZmc2RfdCBkZXZmc190Omxua19maWxlIGNyZWF0ZV9maWxlX3Blcm1zOwphbGxvdyBk
ZXZmc2RfdCBkZXZmc190OmRpciByd19kaXJfcGVybXM7CmFsbG93IGRldmZzZF90IGRldmZzX3Q6
Y2hyX2ZpbGUgcl9maWxlX3Blcm1zOwpkb21haW5fYXV0b190cmFucyhpbml0cmNfdCwgZGV2ZnNk
X2V4ZWNfdCwgZGV2ZnNkX3QpCnVzZXNfc2hsaWIoZGV2ZnNkX3QpCg==

--------------Boundary-00=_D2XBG023FVY8SDT29P0U--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6FKj7Ha020104
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 16:45:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6FKj6H5005414
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 20:45:06 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
        by jazzband.ncsc.mil  with ESMTP id h6FKj6RX005409 for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 20:45:06 GMT
Subject: [patch] a few small new macros for global_macros.te
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Cc: Russell Coker <russell@coker.com.au>
Content-Type: multipart/mixed; boundary="=-SMBnHRmuROc0VcfY94a9"
Message-Id: <1058301863.14211.3.camel@columbia>
Mime-Version: 1.0
Date: 15 Jul 2003 16:44:23 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-SMBnHRmuROc0VcfY94a9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I noticed a lot of .te files were repeatedly specifying access to etc_t
and etc_runtime_t.  So I created 
a macro normal_config_file_access for that.  Also while the domain_trans
macro is useful, it doesn't allow for #! scripts, since the file has to
be read.  So there's a new macro domain_trans_read.

This patch is needed for my spamassassin policies.


--=-SMBnHRmuROc0VcfY94a9
Content-Disposition: attachment; filename=global-macros.patch
Content-Type: text/plain; name=global-macros.patch; charset=UTF-8
Content-Transfer-Encoding: base64

LS0tIHNlbGludXgtcG9saWN5LTEuMC5vcmlnL21hY3Jvcy9nbG9iYWxfbWFjcm9zLnRlDQorKysg
c2VsaW51eC1wb2xpY3ktMS4wL21hY3Jvcy9nbG9iYWxfbWFjcm9zLnRlDQpAQCAtMzAzLDYgKzMw
MywxMSBAQA0KIGFsbG93ICQzICQyOmZpbGUgZW50cnlwb2ludDsNCiAnKQ0KIA0KK2RlZmluZShg
ZG9tYWluX3RyYW5zX3JlYWQnLGANCitkb21haW5fdHJhbnMoJDEsJDIsJDMpDQorYWxsb3cgJDEg
JDI6ZmlsZSByZWFkOw0KKycpDQorDQogIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
DQogIw0KICMgZG9tYWluX2F1dG9fdHJhbnMocGFyZW50X2RvbWFpbiwgcHJvZ3JhbV90eXBlLCBj
aGlsZF9kb21haW4pDQpAQCAtNzc2LDYgKzc4MSwyMiBAQA0KIGFsbG93ICQxIHNiaW5fdDpub3Rk
ZXZmaWxlX2NsYXNzX3NldCByX2ZpbGVfcGVybXM7DQogJykNCiANCisjIFJlYWQgbW9zdCB0eXBp
Y2FsIHN0dWZmIGluIC9ldGMuDQorZGVmaW5lKGBub3JtYWxfY29uZmlnX2ZpbGVfcmVhZF9hY2Nl
c3MnLGANCityX2Rpcl9maWxlKCQxLCBldGNfdCkNCithbGxvdyAkMSBldGNfcnVudGltZV90Onsg
ZmlsZSBsbmtfZmlsZSB9IHJfZmlsZV9wZXJtczsNCithbGxvdyAkMSByZXNvbHZfY29uZl90Onsg
ZmlsZSBsbmtfZmlsZSB9IHJfZmlsZV9wZXJtczsNCithbGxvdyAkMSBsZF9zb19jYWNoZV90OmZp
bGUgcl9maWxlX3Blcm1zOw0KKycpDQorDQorIyBSZWFkIGFjY2VzcyB0byBhbG1vc3QgYWxsIG9m
IC9ldGMuDQorZGVmaW5lKGBleHRlbmRlZF9jb25maWdfZmlsZV9yZWFkX2FjY2VzcycsYA0KK25v
cm1hbF9jb25maWdfZmlsZV9yZWFkX2FjY2VzcygkMSkNCithbGxvdyAkMSBldGNfYWxpYXNlc190
OnsgZmlsZSBsbmtfZmlsZSB9IHJfZmlsZV9wZXJtczsNCithbGxvdyAkMSBldGNfbWFpbF90OmRp
ciByX2Rpcl9wZXJtczsNCithbGxvdyAkMSBldGNfbWFpbF90OnsgZmlsZSBsbmtfZmlsZSB9IHJf
ZmlsZV9wZXJtczsNCisnKQ0KKw0KICMNCiAjIGdlbmVyYWxfZmlsZV9yZWFkX2FjY2Vzcyhkb21h
aW4pDQogIw0KQEAgLTg1OSwxNSArODgwLDkgQEANCiAnKQ0KIGFsbG93ICQxIGJvb3RfdDpsbmtf
ZmlsZSByZWFkOw0KIA0KLSMgUmVhZCAvZXRjLg0KLWFsbG93ICQxIGV0Y190OmRpciByX2Rpcl9w
ZXJtczsNCi1hbGxvdyAkMSBldGNfdDpub3RkZXZmaWxlX2NsYXNzX3NldCByX2ZpbGVfcGVybXM7
DQotYWxsb3cgJDEgZXRjX3J1bnRpbWVfdDp7IGZpbGUgbG5rX2ZpbGUgfSByX2ZpbGVfcGVybXM7
DQotYWxsb3cgJDEgZXRjX2FsaWFzZXNfdDp7IGZpbGUgbG5rX2ZpbGUgfSByX2ZpbGVfcGVybXM7
DQotYWxsb3cgJDEgZXRjX21haWxfdDpkaXIgcl9kaXJfcGVybXM7DQotYWxsb3cgJDEgZXRjX21h
aWxfdDp7IGZpbGUgbG5rX2ZpbGUgfSByX2ZpbGVfcGVybXM7DQotYWxsb3cgJDEgcmVzb2x2X2Nv
bmZfdDp7IGZpbGUgbG5rX2ZpbGUgfSByX2ZpbGVfcGVybXM7DQotYWxsb3cgJDEgbGRfc29fY2Fj
aGVfdDpmaWxlIHJfZmlsZV9wZXJtczsNCisjIFJlYWQgL2V0Yw0KK25vcm1hbF9jb25maWdfZmls
ZV9yZWFkX2FjY2VzcygkMSkNCitleHRlbmRlZF9jb25maWdfZmlsZV9yZWFkX2FjY2VzcygkMSkN
CiANCiAjIFJlYWQgL2xpYi4NCiBhbGxvdyAkMSBsaWJfdDpkaXIgcl9kaXJfcGVybXM7DQo=

--=-SMBnHRmuROc0VcfY94a9--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

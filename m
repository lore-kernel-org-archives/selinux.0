Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5N1bbrT013144
	for <selinux@tycho.nsa.gov>; Tue, 22 Jun 2004 21:37:38 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5N1bY9A002920
	for <selinux@tycho.nsa.gov>; Wed, 23 Jun 2004 01:37:34 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i5N1bae1003160
	for <selinux@tycho.nsa.gov>; Tue, 22 Jun 2004 21:37:36 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.64.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i5N1bZ025494
	for <selinux@tycho.nsa.gov>; Tue, 22 Jun 2004 21:37:35 -0400
Received: from [172.16.67.52] (optimus-prime.boston.redhat.com [172.16.67.52])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id i5N1bX8A000992
	for <selinux@tycho.nsa.gov>; Tue, 22 Jun 2004 21:37:33 -0400
Subject: Re: generic pam authentication
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
In-Reply-To: <Pine.LNX.4.44.0406221926580.13825-100000@cirrus.av8.net>
References: <Pine.LNX.4.44.0406221926580.13825-100000@cirrus.av8.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0hDekVUg2C3BPJL61X77"
Date: Tue, 22 Jun 2004 21:36:28 -0400
Message-Id: <1087954588.17038.173.camel@optimus-prime.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-0hDekVUg2C3BPJL61X77
Content-Type: multipart/mixed; boundary="=-gnP87oAeCJWtNeoyxZFZ"


--=-gnP87oAeCJWtNeoyxZFZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Ok, here is a first cut at this.  Instead of having a uses_pam macro, I
realized that the existing attributes "auth", "auth_chkpwd", and
"auth_write" were conceptually what I want, except they only work with
pam_unix.   All the attributes did before was grant various privileges
to read/write shadow_t or exec unix_chkpwd.  At a higher level, I think
it makes sense to simply extend the meaning of those attributes to allow
the permissions corresponding to the pam stack.

What this patch does is move most of the relevant permissions inside
pam.te.  Additionally, I started on generic permissions for Kerberos
authentication, which seems to work for GSSAPI+ssh and passwd (with
pam_krb5 in the password stack).



--=-gnP87oAeCJWtNeoyxZFZ
Content-Disposition: attachment; filename=auth-generic-pam.patch
Content-Type: text/x-patch; name=auth-generic-pam.patch; charset=UTF-8
Content-Transfer-Encoding: base64

KiBhZGRlZCBmaWxlcw0KDQogICAge2FyY2h9L3BvbGljeS9wb2xpY3ktLW1haW4vcG9saWN5LS1t
YWluLS0wL3Jvb3RAYXJlYTYxNC5uZXQtLW1vbmsvcGF0Y2gtbG9nL3BhdGNoLTgNCg0KKiBtb2Rp
ZmllZCBmaWxlcw0KDQotLS0gb3JpZy9kb21haW5zL3Byb2dyYW0va2VyYmVyb3MudGUNCisrKyBt
b2QvZG9tYWlucy9wcm9ncmFtL2tlcmJlcm9zLnRlDQpAQCAtODgsMTcgKzg4LDMgQEANCiAjIEFs
bG93IHVzZXIgcHJvZ3JhbXMgdG8gdGFsayB0byBLREMNCiBhbGxvdyBrcmI1a2RjX3QgdXNlcmRv
bWFpbjp1ZHBfc29ja2V0IHsgcmVjdmZyb20gfTsNCiBhbGxvdyB1c2VyZG9tYWluIGtyYjVrZGNf
dDp1ZHBfc29ja2V0IHsgcmVjdmZyb20gfTsNCi0NCi1pZmRlZihgc3NoLnRlJywgYA0KLSMNCi0j
IFJ1bGVzIGZvciBPcGVuU1NIIHNzaGQgc2VydmVyIGFuZCBzc2ggY2xpZW50IGNvbXBpbGVkDQot
IyB3aXRoIEtlcmJlcm9zIHN1cHBvcnQNCi0jIHNlZSBhbHNvIG1hY3Jvcy9wcm9ncmFtL3NzaF9t
YWNyb3MudGUNCi1hbGxvdyBrcmI1a2RjX3Qgc3NoZF90OnVkcF9zb2NrZXQgeyByZWN2ZnJvbSB9
Ow0KLWFsbG93IHNzaGRfdCBrcmI1a2RjX3Q6dWRwX3NvY2tldCB7IHJlY3Zmcm9tIH07DQotYWxs
b3cgc3NoZF90IGtyYjVfa2V5dGFiX3Q6ZmlsZSB7IGxvY2sgcmVhZCB9Ow0KLQ0KLSMgc3NoZCBk
ZXN0cm95cyBraW5pdC1jcmVhdGVkIHRpY2tldHMgb24gZXhpdA0KLQ0KLWFsbG93IHNzaGRfdCB0
bXBfdDpmaWxlIHsgZ2V0YXR0ciByZWFkIHdyaXRlIH07DQotJykNCg0KDQotLS0gb3JpZy9kb21h
aW5zL3Byb2dyYW0vcGFtLnRlDQorKysgbW9kL2RvbWFpbnMvcHJvZ3JhbS9wYW0udGUNCkBAIC0z
NCwzICszNCw0MSBAQA0KIA0KIGFsbG93IHBhbV90IGxvY2FsX2xvZ2luX3Q6ZmQgeyB1c2UgfTsN
CiBkb250YXVkaXQgcGFtX3QgcGFtX3Q6Y2FwYWJpbGl0eSB7IHN5c190dHlfY29uZmlnIH07DQor
DQorIyMgcGFtX3VuaXgNCisjIGF1dGgNCithbGxvdyBhdXRoIHNoYWRvd190OmZpbGUgeyBnZXRh
dHRyIHJlYWQgfTsNCisjIGF1dGhfY2hrcHdkDQoraWZkZWYoYGNoa3B3ZC50ZScsYA0KK2RvbWFp
bl9hdXRvX3RyYW5zKGF1dGhfY2hrcHdkLCBjaGtwd2RfZXhlY190LCBzeXN0ZW1fY2hrcHdkX3Qp
DQorcm9sZSBzeXN0ZW1fciB0eXBlcyBzeXN0ZW1fY2hrcHdkX3Q7DQorJykNCitkb250YXVkaXQg
YXV0aF9jaGtwd2Qgc2hhZG93X3Q6ZmlsZSB7IGdldGF0dHIgcmVhZCB9Ow0KK2FsbG93IGF1dGhf
Y2hrcHdkIHNiaW5fdDpkaXIgc2VhcmNoOw0KKw0KKyMgYXV0aF93cml0ZQ0KK2FsbG93IGF1dGhf
d3JpdGUgeyBldGNfdCBzaGFkb3dfdCB9OmZpbGUgeyByZWxhYmVsZnJvbSByZWxhYmVsdG8gfTsN
CisNCisjIyBwYW1fa3JiNQ0KK2lmZGVmKGBrZXJiZXJvcy50ZScsYA0KKw0KKyMgYXV0aCwgYXV0
aF9jaGtwd2QNCitkZWZpbmUoYGtlcmJlcm9zX2F1dGhfcHJpdnMnLGANCithbGxvdyAkMSBrcmI1
X2NvbmZfdDpmaWxlIHsgZ2V0YXR0ciByZWFkIH07DQorZG9udGF1ZGl0ICQxIGtyYjVfY29uZl90
OmZpbGUgeyB3cml0ZSB9Ow0KK2FsbG93ICQxIG5ldF9jb25mX3Q6ZmlsZSB7IGdldGF0dHIgcmVh
ZCB9Ow0KK2Nhbl9uZXR3b3JrKCQxKQ0KK2Nhbl90Y3BfY29ubmVjdCgkMSwga2VyYmVyb3NfcG9y
dF90KQ0KK2Nhbl91ZHBfc2VuZCgkMSwga2VyYmVyb3NfcG9ydF90KQ0KK2FsbG93ICQxIHVyYW5k
b21fZGV2aWNlX3Q6Y2hyX2ZpbGUgeyBnZXRhdHRyIHJlYWQgfTsNCisnKQ0KK2tlcmJlcm9zX2F1
dGhfcHJpdnMoYXV0aCkNCitrZXJiZXJvc19hdXRoX3ByaXZzKGF1dGhfY2hrcHdkKQ0KKw0KKyMg
YXV0aF93cml0ZQ0KK2tlcmJlcm9zX2F1dGhfcHJpdnMoYXV0aF93cml0ZSkNCitjYW5fdGNwX2Nv
bm5lY3QoYXV0aF93cml0ZSwga2VyYmVyb3NfYWRtaW5fcG9ydF90KQ0KK2Nhbl91ZHBfc2VuZChh
dXRoX3dyaXRlLCBrZXJiZXJvc19hZG1pbl9wb3J0X3QpDQorDQorJykNCisNCg0KDQotLS0gb3Jp
Zy9kb21haW5zL3Byb2dyYW0vcGFzc3dkLnRlDQorKysgbW9kL2RvbWFpbnMvcHJvZ3JhbS9wYXNz
d2QudGUNCkBAIC02Niw3ICs2Niw2IEBADQogYmFzZV9wYXNzd2RfZG9tYWluKCQxLCBgYXV0aF93
cml0ZSwgcHJpdm93bmVyJykNCiAjIFVwZGF0ZSAvZXRjL3NoYWRvdyBhbmQgL2V0Yy9wYXNzd2QN
CiBmaWxlX3R5cGVfYXV0b190cmFucygkMV90LCBldGNfdCwgc2hhZG93X3QsIGZpbGUpDQotYWxs
b3cgJDFfdCB7IGV0Y190IHNoYWRvd190IH06ZmlsZSB7IHJlbGFiZWxmcm9tIHJlbGFiZWx0byB9
Ow0KIGNhbl9zZXRmc2NyZWF0ZSgkMV90KQ0KICcpDQogDQoNCg0KLS0tIG9yaWcvZG9tYWlucy9w
cm9ncmFtL3NzaC50ZQ0KKysrIG1vZC9kb21haW5zL3Byb2dyYW0vc3NoLnRlDQpAQCAtMjIxLDYg
KzIyMSwxMCBAQA0KIGRvbnRhdWRpdCBzc2hkX3Qga3JiNV9jb25mX3Q6ZmlsZSB7IHdyaXRlIH07
DQogYWxsb3cgc3NoZF90IGtyYjVfY29uZl90OmZpbGUgeyBnZXRhdHRyIHJlYWQgfTsNCiANCitp
ZmRlZihga2VyYmVyb3MudGUnLGANCithbGxvdyBzc2hkX3Qga3JiNV9rZXl0YWJfdDpmaWxlIHsg
bG9jayByZWFkIH07DQorJykNCisNCiAjIHNzaF9rZXlnZW5fdCBpcyB0aGUgdHlwZSBvZiB0aGUg
c3NoLWtleWdlbiBwcm9ncmFtIHdoZW4gcnVuIGF0IGluc3RhbGwgdGltZQ0KICMgYW5kIGJ5IHN5
c2FkbV90DQogZGFlbW9uX2Jhc2VfZG9tYWluKHNzaF9rZXlnZW4pDQoNCg0KLS0tIG9yaWcvbWFj
cm9zL3Byb2dyYW0vY2hrcHdkX21hY3Jvcy50ZQ0KKysrIG1vZC9tYWNyb3MvcHJvZ3JhbS9jaGtw
d2RfbWFjcm9zLnRlDQpAQCAtMjIsMTIgKzIyLDcgQEANCiBjYW5fZ2V0Y29uKCQxX2Noa3B3ZF90
KQ0KIGNhbl95cGJpbmQoJDFfY2hrcHdkX3QpDQogIyBUcmFuc2l0aW9uIGZyb20gdGhlIHVzZXIg
ZG9tYWluIHRvIHRoaXMgZG9tYWluLg0KLWlmZWxzZSgkMSwgc3lzdGVtLCBgDQotZG9tYWluX2F1
dG9fdHJhbnMoYXV0aF9jaGtwd2QsIGNoa3B3ZF9leGVjX3QsIHN5c3RlbV9jaGtwd2RfdCkNCi1y
b2xlIHN5c3RlbV9yIHR5cGVzIHN5c3RlbV9jaGtwd2RfdDsNCi1kb250YXVkaXQgYXV0aF9jaGtw
d2Qgc2hhZG93X3Q6ZmlsZSB7IGdldGF0dHIgcmVhZCB9Ow0KLWFsbG93IGF1dGhfY2hrcHdkIHNi
aW5fdDpkaXIgc2VhcmNoOw0KLScsIGANCitpZmVsc2UoJDEsIHN5c3RlbSwgYCcsIGANCiBkb21h
aW5fYXV0b190cmFucygkMV90LCBjaGtwd2RfZXhlY190LCAkMV9jaGtwd2RfdCkNCiBhbGxvdyAk
MV90IHNiaW5fdDpkaXIgc2VhcmNoOw0KIA0KDQoNCg0K


--=-gnP87oAeCJWtNeoyxZFZ--

--=-0hDekVUg2C3BPJL61X77
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA2N6cOIkJWWp2WGURAok6AJ0WYiOxwqlyftP5i33dY83JVetOZwCfUZPB
3c4JNbQQ804HrzmbAkdanag=
=5BwB
-----END PGP SIGNATURE-----

--=-0hDekVUg2C3BPJL61X77--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

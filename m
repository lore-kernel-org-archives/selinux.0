Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8EMtLrT013923
	for <selinux@tycho.nsa.gov>; Tue, 14 Sep 2004 18:55:22 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8EMsQJe014722
	for <selinux@tycho.nsa.gov>; Tue, 14 Sep 2004 22:54:26 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.10) with ESMTP id i8EMtMkn005569
	for <selinux@tycho.nsa.gov>; Tue, 14 Sep 2004 18:55:22 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i8EMtLr24916
	for <selinux@tycho.nsa.gov>; Tue, 14 Sep 2004 18:55:21 -0400
Subject: [patch] add proc_fs attribute
From: Colin Walters <walters@redhat.com>
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EUxgdZbUSL6lJeuHnsAO"
Date: Tue, 14 Sep 2004 18:56:43 -0400
Message-Id: <1095202603.8379.27.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-EUxgdZbUSL6lJeuHnsAO
Content-Type: multipart/mixed; boundary="=-mQgWRijVq8rED1mw8Ef7"


--=-mQgWRijVq8rED1mw8Ef7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

The attached patch should fix this denial:

audit(1095188105.721:0): avc:  denied  { read }
for  pid=3D2789 exe=3D/sbin/mdadm name=3Dmdstat dev=3Dproc ino=3D-268435080
scontext=3Duser_u:system_r:unconfined_t
tcontext=3Dsystem_u:object_r:proc_mdstat_t tclass=3Dfile


--=-mQgWRijVq8rED1mw8Ef7
Content-Disposition: attachment; filename=policy-procfs-unconfined.patch
Content-Type: text/x-patch; name=policy-procfs-unconfined.patch; charset=UTF-8
Content-Transfer-Encoding: base64

LS0tIHBvbGljeS0xLjE3LjE1L2F0dHJpYi50ZX4JMjAwNC0wOS0xNCAwOToxODoyNy4wMDAwMDAw
MDAgLTA0MDANCisrKyBwb2xpY3ktMS4xNy4xNS9hdHRyaWIudGUJMjAwNC0wOS0xNCAxODoyMjow
NC41ODY2MzA4MTYgLTA0MDANCkBAIC0yMDksNiArMjA5LDEwIEBADQogIyBmaWxlcywgc29ja2V0
cywgb3IgcGlwZXMgdW5kZXIgL2Rldi4NCiBhdHRyaWJ1dGUgZGV2X2ZzOw0KIA0KKyMgVGhlIHBy
b2NfZnMgYXR0cmlidXRlIGlkZW50aWZpZXMgYWxsIHR5cGVzIHRoYXQgbWF5IGJlIGFzc2lnbmVk
IHRvDQorIyBmaWxlcyB1bmRlciAvcHJvYy4NCithdHRyaWJ1dGUgcHJvY19mczsNCisNCiAjIFRo
ZSBzeXNhZG1maWxlIGF0dHJpYnV0ZSBpZGVudGlmaWVzIGFsbCB0eXBlcyBhc3NpZ25lZCB0byBm
aWxlcyANCiAjIHRoYXQgc2hvdWxkIGJlIGNvbXBsZXRlbHkgYWNjZXNzaWJsZSB0byBhZG1pbmlz
dHJhdG9ycy4gIEl0IGlzIHVzZWQNCiAjIGluIFRFIHJ1bGVzIHRvIGdyYW50IHN1Y2ggYWNjZXNz
IGZvciBhZG1pbmlzdHJhdG9yIGRvbWFpbnMuDQotLS0gcG9saWN5LTEuMTcuMTUvbWFjcm9zL2ds
b2JhbF9tYWNyb3MudGV+CTIwMDQtMDktMTQgMTg6MTg6MzAuMzU4MTk4NDg4IC0wNDAwDQorKysg
cG9saWN5LTEuMTcuMTUvbWFjcm9zL2dsb2JhbF9tYWNyb3MudGUJMjAwNC0wOS0xNCAxODoyMzo0
Mi42MzY3MjQ5MzYgLTA0MDANCkBAIC01NTMsNyArNTUzLDcgQEANCiAjIHBzZXVkbyBmaWxlc3lz
dGVtIHR5cGVzIHRoYXQgYXJlIGFwcGxpZWQgdG8gYm90aCB0aGUgZmlsZXN5c3RlbQ0KICMgYW5k
IGl0cyBmaWxlcy4NCiBhbGxvdyAkMSB7IHVubGFiZWxlZF90IGZzX3R5cGUgfTpkaXJfZmlsZV9j
bGFzc19zZXQgKjsNCi1hbGxvdyAkMSB7IHByb2Nfa21zZ190IHByb2Nfa2NvcmVfdCB9OiBmaWxl
ICo7DQorYWxsb3cgJDEgeyBwcm9jX2ZzIH06IGZpbGUgKjsNCiANCiAjIEZvciAvcHJvYy9waWQN
CiByX2Rpcl9maWxlKCQxLGRvbWFpbikNCi0tLSBwb2xpY3ktMS4xNy4xNS90eXBlcy9wcm9jZnMu
dGV+CTIwMDQtMDktMTQgMDk6MTg6MjcuMDAwMDAwMDAwIC0wNDAwDQorKysgcG9saWN5LTEuMTcu
MTUvdHlwZXMvcHJvY2ZzLnRlCTIwMDQtMDktMTQgMTg6MjI6NDAuMTQ4MjI0NjMyIC0wNDAwDQpA
QCAtMTIsMTAgKzEyLDEwIEBADQogIyBwcm9jX2ttc2dfdCBpcyB0aGUgdHlwZSBvZiAvcHJvYy9r
bXNnLg0KICMgcHJvY19rY29yZV90IGlzIHRoZSB0eXBlIG9mIC9wcm9jL2tjb3JlLg0KICMNCi10
eXBlIHByb2NfdCwgZnNfdHlwZSwgcm9vdF9kaXJfdHlwZTsNCi10eXBlIHByb2Nfa21zZ190Ow0K
LXR5cGUgcHJvY19rY29yZV90Ow0KLXR5cGUgcHJvY19tZHN0YXRfdDsNCit0eXBlIHByb2NfdCwg
ZnNfdHlwZSwgcHJvY19mcywgcm9vdF9kaXJfdHlwZTsNCit0eXBlIHByb2Nfa21zZ190LCBwcm9j
X2ZzOw0KK3R5cGUgcHJvY19rY29yZV90LCBwcm9jX2ZzOw0KK3R5cGUgcHJvY19tZHN0YXRfdCwg
cHJvY19mczsNCiANCiAjDQogIyBzeXNjdGxfdCBpcyB0aGUgdHlwZSBvZiAvcHJvYy9zeXMuDQo=


--=-mQgWRijVq8rED1mw8Ef7--

--=-EUxgdZbUSL6lJeuHnsAO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBR3cqOIkJWWp2WGURAvw8AJ4hB3BKe26qDULbbWPWkk3aKPoDhQCfUqK9
C96GUu7Jvt3nSJl/PAi+FpE=
=DzfQ
-----END PGP SIGNATURE-----

--=-EUxgdZbUSL6lJeuHnsAO--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

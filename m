Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2PKuERb019023
	for <selinux@tycho.nsa.gov>; Thu, 25 Mar 2004 15:56:14 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2PKuDFV017195
	for <selinux@tycho.nsa.gov>; Thu, 25 Mar 2004 20:56:13 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id i2PKuC36017187 for <selinux@tycho.nsa.gov>; Thu, 25 Mar 2004 20:56:12 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i2PKuCWA019221
	for <selinux@tycho.nsa.gov>; Thu, 25 Mar 2004 15:56:12 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.64.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i2PKuBj21340
	for <selinux@tycho.nsa.gov>; Thu, 25 Mar 2004 15:56:11 -0500
Received: from nexus.verbum.private (nexus.boston.redhat.com [172.16.67.53])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id i2PKuBhP030715
	for <selinux@tycho.nsa.gov>; Thu, 25 Mar 2004 15:56:11 -0500
Subject: synaptics touchpad fixes
From: Colin Walters <walters@redhat.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-47CUwf8J+BB9uVFsMdKc"
Message-Id: <1080247909.4542.116.camel@nexus.verbum.private>
Mime-Version: 1.0
Date: Thu, 25 Mar 2004 15:51:49 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-47CUwf8J+BB9uVFsMdKc
Content-Type: multipart/mixed; boundary="=-81QOLbz96yncIFPBVs4j"


--=-81QOLbz96yncIFPBVs4j
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

The synaptics touchpad driver in XFree needs access to
/dev/input/event0.  Policy already defines an event_device_t type, but
that type isn't set in types.fc, and the xserver also needs access to
it.  Patch attached.



--=-81QOLbz96yncIFPBVs4j
Content-Disposition: attachment; filename=syntaptics.patch
Content-Type: text/x-patch; name=syntaptics.patch; charset=UTF-8
Content-Transfer-Encoding: base64

LS0tIG1hY3Jvcy9wcm9ncmFtL3hzZXJ2ZXJfbWFjcm9zLnRlfgkyMDA0LTAzLTI0IDE1OjQyOjA0
LjAwMDAwMDAwMCAtMDUwMA0KKysrIG1hY3Jvcy9wcm9ncmFtL3hzZXJ2ZXJfbWFjcm9zLnRlCTIw
MDQtMDMtMjUgMTU6MTE6MjcuODMwMjY4MjE2IC0wNTAwDQpAQCAtMjI0LDYgKzIyNCw5IEBADQog
DQogIyBVc2UgdGhlIG1vdXNlLg0KIGFsbG93ICQxX3hzZXJ2ZXJfdCBtb3VzZV9kZXZpY2VfdDpj
aHJfZmlsZSByd19maWxlX3Blcm1zOw0KKyMgQWxsb3cgeHNlcnZlciB0byByZWFkIGV2ZW50cyAt
IHRoZSBzeW5hcHRpY3MgdG91Y2hwYWQNCisjIGRyaXZlciByZWFkcyByYXcgZXZlbnRzDQorYWxs
b3cgJDFfeHNlcnZlcl90IGV2ZW50X2RldmljZV90OmNocl9maWxlIHJ3X2ZpbGVfcGVybXM7DQog
DQogYWxsb3cgJDFfeHNlcnZlcl90IHZhcl9saWJfdDpkaXIgc2VhcmNoOw0KIHJ3X2Rpcl9jcmVh
dGVfZmlsZSgkMV94c2VydmVyX3QsIHZhcl9saWJfeGtiX3QpDQotLS0gZmlsZV9jb250ZXh0cy90
eXBlcy5mY34JMjAwNC0wMy0yNCAxMToyMzoxNS4wMDAwMDAwMDAgLTA1MDANCisrKyBmaWxlX2Nv
bnRleHRzL3R5cGVzLmZjCTIwMDQtMDMtMjUgMTU6MDk6NDEuMjE5NDc1NTIwIC0wNTAwDQpAQCAt
MTcwLDYgKzE3MCw3IEBADQogL3U/ZGV2L2xvZ2libQkJLWMJc3lzdGVtX3U6b2JqZWN0X3I6bW91
c2VfZGV2aWNlX3QNCiAvdT9kZXYvLiptb3VzZS4qCQktYwlzeXN0ZW1fdTpvYmplY3Rfcjptb3Vz
ZV9kZXZpY2VfdA0KIC91P2Rldi9pbnB1dC8uKm1vdXNlLioJLWMJc3lzdGVtX3U6b2JqZWN0X3I6
bW91c2VfZGV2aWNlX3QNCisvdT9kZXYvaW5wdXQvZXZlbnQuKgktYwlzeXN0ZW1fdTpvYmplY3Rf
cjpldmVudF9kZXZpY2VfdA0KIC91P2Rldi9pbnB1dC9taWNlCQktYwlzeXN0ZW1fdTpvYmplY3Rf
cjptb3VzZV9kZXZpY2VfdA0KIC91P2Rldi9pbnB1dC9qcy4qCQktYwlzeXN0ZW1fdTpvYmplY3Rf
cjptb3VzZV9kZXZpY2VfdA0KIC91P2Rldi9wdG14CQktYwlzeXN0ZW1fdTpvYmplY3RfcjpwdG14
X3QNCg==

--=-81QOLbz96yncIFPBVs4j--

--=-47CUwf8J+BB9uVFsMdKc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAY0ZlOIkJWWp2WGURAvcHAJ4wp3B62Ib2WnDWA2nAaz35MWr8ZgCeJsjL
HxDNFk5jYm7kmdKtEdW+tnY=
=SGvR
-----END PGP SIGNATURE-----

--=-47CUwf8J+BB9uVFsMdKc--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7KGUKrT005217
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 12:30:20 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7KGTc4v019334
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 16:29:38 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i7KGUJe1026728
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 12:30:19 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i7KGUEa29606
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 12:30:14 -0400
Received: from [172.16.83.126] (vpn83-126.boston.redhat.com [172.16.83.126])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id i7KGUEtL024159
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 12:30:14 -0400
Subject: little libselinux patch to display errno
From: Colin Walters <walters@redhat.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OTPVoMtpqfbWOqb//XGo"
Date: Fri, 20 Aug 2004 12:31:05 -0400
Message-Id: <1093019465.9495.14.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-OTPVoMtpqfbWOqb//XGo
Content-Type: multipart/mixed; boundary="=-/0NcbsItvEU9nzKHqfOj"


--=-/0NcbsItvEU9nzKHqfOj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Here's a little patch to libselinux which causes it to print=20
strerror(errno) if the AVC netlink socket can't be opened.  I wasn't
sure if there was a reason just the numeric value of errno was printed,
so I kept it.


--=-/0NcbsItvEU9nzKHqfOj
Content-Disposition: attachment; filename=libselinux-avc-errno.patch
Content-Type: text/x-patch; name=libselinux-avc-errno.patch; charset=UTF-8
Content-Transfer-Encoding: base64

LS0tIGxpYnNlbGludXgtMS4xNi9zcmMvYXZjLmN+CTIwMDQtMDgtMDUgMDk6NTk6MDUuMDAwMDAw
MDAwIC0wNDAwDQorKysgbGlic2VsaW51eC0xLjE2L3NyYy9hdmMuYwkyMDA0LTA4LTIwIDEyOjE4
OjQ3LjM1MzEzNjMwNCAtMDQwMA0KQEAgLTE4MCw3ICsxODAsOCBAQA0KIA0KICAgcmMgPSBhdmNf
bmV0bGlua19vcGVuKGF2Y191c2luZ190aHJlYWRzKTsNCiAgIGlmIChyYyA8IDApIHsNCi0gICAg
YXZjX2xvZygiJXM6ICBjYW4ndCBvcGVuIG5ldGxpbmsgc29ja2V0OiAlZFxuIiwgYXZjX3ByZWZp
eCwgZXJybm8pOw0KKyAgICBhdmNfbG9nKCIlczogIGNhbid0IG9wZW4gbmV0bGluayBzb2NrZXQ6
ICVkICglcylcbiIsIGF2Y19wcmVmaXgsDQorCSAgICBlcnJubywgc3RyZXJyb3IoZXJybm8pKTsN
CiAgICAgZ290byBvdXQ7DQogICB9DQogICBpZiAoYXZjX3VzaW5nX3RocmVhZHMpIHsNCg==


--=-/0NcbsItvEU9nzKHqfOj--

--=-OTPVoMtpqfbWOqb//XGo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBJidIOIkJWWp2WGURAt+EAJ9qt86vZL7S6pCZESC6i9hrtMOVMACfRcHV
HaGYa1cFsiwXkDVvolbBmu8=
=8G47
-----END PGP SIGNATURE-----

--=-OTPVoMtpqfbWOqb//XGo--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

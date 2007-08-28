Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7TGjRgU016325
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2007 12:45:27 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7TGjNPw026682
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2007 16:45:23 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1) with ESMTP id l7TGi3tH022214
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2007 12:44:03 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1/Submit) id l7TGi3TC022213
	for selinux@tycho.nsa.gov; Wed, 29 Aug 2007 12:44:03 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7SLqTg4012367
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 17:52:29 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7SLqSp9005451
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 21:52:28 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l7SLqRxB023879
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 17:52:27 -0400
Received: from lacrosse.corp.redhat.com (lacrosse.corp.redhat.com [172.16.52.154])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l7SLqRd7005438
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 17:52:27 -0400
Received: from myware66.akkadia.org (vpn-14-1.rdu.redhat.com [10.11.14.1])
	by lacrosse.corp.redhat.com (8.12.11.20060308/8.11.6) with ESMTP id l7SLqQPY019465
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 17:52:26 -0400
Message-ID: <46D49915.9020403@redhat.com>
Date: Tue, 28 Aug 2007 14:52:21 -0700
From: Ulrich Drepper <drepper@redhat.com>
MIME-Version: 1.0
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: catch errors
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB48EC915A89F552DDFA169AC"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB48EC915A89F552DDFA169AC
Content-Type: multipart/mixed;
 boundary="------------050903040609070609000102"

This is a multi-part message in MIME format.
--------------050903040609070609000102
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Given the buffer overflow which has been fixed recently I think it's
worthwhile adding to debug features.  It's using the same technology as
glibc's _FORTIFY_SOURCE functionality.  I would unconditionally define
DEBUG, in most cases the compiler can figure out there is no problem.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96

--------------050903040609070609000102
Content-Type: text/plain;
 name="d-libsepol-chk"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="d-libsepol-chk"

ZGlmZiAtZHVycCBsaWJzZXBvbC0yLjAuNy9zcmMvcHJpdmF0ZS5oIGxpYnNlcG9sLTIuMC43
LWNoay9zcmMvcHJpdmF0ZS5oCi0tLSBsaWJzZXBvbC0yLjAuNy9zcmMvcHJpdmF0ZS5oCTIw
MDctMDgtMjggMTQ6NDM6MzYuMDAwMDAwMDAwIC0wNzAwCisrKyBsaWJzZXBvbC0yLjAuNy1j
aGsvc3JjL3ByaXZhdGUuaAkyMDA3LTA4LTI4IDE0OjQ3OjI2LjAwMDAwMDAwMCAtMDcwMApA
QCAtNDUsMyArNDUsMTMgQEAgZXh0ZXJuIHN0cnVjdCBwb2xpY3lkYl9jb21wYXRfaW5mbyAq
cG9saQogZXh0ZXJuIGludCBuZXh0X2VudHJ5KHZvaWQgKmJ1Ziwgc3RydWN0IHBvbGljeV9m
aWxlICpmcCwgc2l6ZV90IGJ5dGVzKSBoaWRkZW47CiBleHRlcm4gc2l6ZV90IHB1dF9lbnRy
eShjb25zdCB2b2lkICpwdHIsIHNpemVfdCBzaXplLCBzaXplX3QgbiwKIAkJICAgICAgICBz
dHJ1Y3QgcG9saWN5X2ZpbGUgKmZwKSBoaWRkZW47CisKKyNpZmRlZiBERUJVRworIyBpZiBf
X0dOVUNfXyA+IDQgfHwgKF9fR05VQ19fID09IDQgJiYgX19HTlVDX01JTk9SID49IDEpCisj
ICBkZWZpbmUgbmV4dF9lbnRyeShidWYsIGZwLCBieXRlcykgXAorICAoeyBzaXplX3QgX2J5
dGVzID0gYnl0ZXM7IFwKKyAgICAgX19idWlsdGluX29iamVjdF9zaXplIChidWYsIDApICE9
IChzaXplX3QpIC0xICYmIHNpemVvZiAoYnVmKSA8IF9ieXRlcyBcCisgICAgID8gKGFib3J0
ICgpLCAtMSkgXAorICAgICA6IG5leHRfZW50cnkgKGJ1ZiwgZnAsIF9ieXRlcyk7IH0pCisj
IGVuZGlmCisjZW5kaWYK
--------------050903040609070609000102--

--------------enigB48EC915A89F552DDFA169AC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG1JkV2ijCOnn/RHQRAqH1AJ4hpNDHm2tbze1cSGP24JBa9a8NmQCgsHMy
EttTY1kBwbkRZYoOOIC3fiA=
=ZO2y
-----END PGP SIGNATURE-----

--------------enigB48EC915A89F552DDFA169AC--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

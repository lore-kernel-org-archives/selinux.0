Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6RKOSrT005527
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 16:24:28 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6RKORup017824
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 20:24:27 GMT
Subject: Re: distcc policy
From: Colin Walters <walters@redhat.com>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: selinux@tycho.nsa.gov, russell@coker.com.au
In-Reply-To: <1080449956.11635.32.camel@gorn.pebenito.net>
References: <1080449956.11635.32.camel@gorn.pebenito.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EfgZ6wSpguqyV+D/Xw22"
Date: Tue, 27 Jul 2004 16:24:20 -0400
Message-Id: <1090959860.19104.41.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-EfgZ6wSpguqyV+D/Xw22
Content-Type: multipart/mixed; boundary="=-cE4AjkVpPDJSyq9AjCqF"


--=-cE4AjkVpPDJSyq9AjCqF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-03-27 at 22:59 -0600, Chris PeBenito wrote:
> Here's a policy for distccd, the distributed compiler daemon.  Its been
> in heavy use in Gentoo for a while.

Hi,

I needed the attached patch to make this work.



--=-cE4AjkVpPDJSyq9AjCqF
Content-Disposition: attachment; filename=distcc.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=distcc.patch; charset=UTF-8

LS0tIC9ob21lL3dhbHRlcnMvZGlzdGNjLnRlCTIwMDQtMDctMjcgMTM6MjU6MjMuNzcxMTcxMjg4
IC0wNDAwDQorKysgZGlzdGNjLnRlCTIwMDQtMDctMjcgMTY6MjI6NTMuMTI4MjIyOTM2IC0wNDAw
DQpAQCAtNSw2ICs1LDcgQEANCiANCiBkYWVtb25fZG9tYWluKGRpc3RjY2QpDQogY2FuX25ldHdv
cmsoZGlzdGNjZF90KQ0KK2xvZ19kb21haW4oZGlzdGNjZCkNCiB0bXBfZG9tYWluKGRpc3RjY2Qp
DQogDQogdHlwZSBkaXN0Y2NkX3BvcnRfdCwgcG9ydF90eXBlOw0KQEAgLTE2LDYgKzE3LDcgQEAN
CiANCiAjIGNvbXBpbGVyIHN0dWZmDQogYWxsb3cgZGlzdGNjZF90IHsgYmluX3Qgc2Jpbl90IH06
ZGlyIHsgc2VhcmNoIGdldGF0dHIgfTsNCithbGxvdyBkaXN0Y2NkX3QgeyBiaW5fdCBzYmluX3Qg
fTpsbmtfZmlsZSB7IGdldGF0dHIgcmVhZCB9Ow0KIGNhbl9leGVjKGRpc3RjY2RfdCxiaW5fdCkN
CiBjYW5fZXhlYyhkaXN0Y2NkX3QsbGliX3QpDQogDQo=


--=-cE4AjkVpPDJSyq9AjCqF--

--=-EfgZ6wSpguqyV+D/Xw22
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBBrn0OIkJWWp2WGURArPNAJoCNMcQH+WRITS2MfFYc+7ivOVbCgCfdciv
Rze/31Fk2q5V2gi70Eg5YiU=
=4uEp
-----END PGP SIGNATURE-----

--=-EfgZ6wSpguqyV+D/Xw22--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

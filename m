Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8931DrT009071
	for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 23:01:13 -0400 (EDT)
Received: from sccrmhc12.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8931Dfe012907
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 03:01:13 GMT
Subject: Re: for bootsplash to operate correctly...
From: Chris PeBenito <pebenito@gentoo.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040908224108.GJ7717@lkcl.net>
References: <20040908224108.GJ7717@lkcl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rkCujWRjyXggAENwRid9"
Message-Id: <1094698870.14648.19.camel@gorn.pebenito.net>
Mime-Version: 1.0
Date: Wed, 08 Sep 2004 23:01:11 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-rkCujWRjyXggAENwRid9
Content-Type: multipart/mixed; boundary="=-Yz6WSPhy2lbal15POTyw"


--=-Yz6WSPhy2lbal15POTyw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-09-08 at 18:41, Luke Kenneth Casson Leighton wrote:
> ... i hacked in the three following permissions:
>=20
> # this is to allow splash to write to /proc/splash
> allow initrc_t proc_t:file { write };

> # this is for fbmngplay to do err... *clueless*
> allow initrc_t self:capability { sys_admin };
>=20
> i look forward to one day writing a policy for the bootsplash
> package :)
>=20

I threw together a bootsplash policy several months ago to get the
Gentoo LiveCD going.  I always forget about it since I only use
bootsplash on the LiveCD.  I didn't encounter that sys_admin capability
that you have, but it might be a result of the bootsplash setings.  We
probably should label /proc/splash differently, now that I think about
it.

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
Embedded Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-Yz6WSPhy2lbal15POTyw
Content-Disposition: attachment; filename=bootsplash.fc
Content-Type: text/plain; name=bootsplash.fc; charset=iso-8859-1
Content-Transfer-Encoding: base64

L3NiaW4vZmJyZXNvbHV0aW9uCS0tCXN5c3RlbV91Om9iamVjdF9yOmJvb3RzcGxhc2hfZXhlY190
DQovc2Jpbi9mYnRydWV0eXBlLnN0YXRpYwktLQlzeXN0ZW1fdTpvYmplY3Rfcjpib290c3BsYXNo
X2V4ZWNfdA0K

--=-Yz6WSPhy2lbal15POTyw
Content-Disposition: attachment; filename=bootsplash.te
Content-Type: text/plain; name=bootsplash.te; charset=iso-8859-1
Content-Transfer-Encoding: base64

I0RFU0MgYm9vdHNwbGFzaCAtIEJvb3RzcGxhc2ggc2NyZWVuDQojDQojIEF1dGhvcjogQ2hyaXMg
UGVCZW5pdG8gPHBlYmVuaXRvQGdlbnRvby5vcmc+DQojDQoNCnR5cGUgYm9vdHNwbGFzaF90LCBk
b21haW47DQp0eXBlIGJvb3RzcGxhc2hfZXhlY190LCBmaWxlX3R5cGUsIGV4ZWNfdHlwZTsNCg0K
cm9sZSBzeXN0ZW1fciB0eXBlcyBib290c3BsYXNoX3Q7DQoNCnVzZXNfc2hsaWIoYm9vdHNwbGFz
aF90KQ0KZG9tYWluX2F1dG9fdHJhbnMoaW5pdHJjX3QsIGJvb3RzcGxhc2hfZXhlY190LCBib290
c3BsYXNoX3QpDQoNCmFsbG93IGJvb3RzcGxhc2hfdCBpbml0X3Q6ZmQgdXNlOw0KYWxsb3cgaW5p
dHJjX3QgcHJvY190OmZpbGUgd3JpdGU7DQoNCmFsbG93IGJvb3RzcGxhc2hfdCBmcmFtZWJ1Zl9k
ZXZpY2VfdDpjaHJfZmlsZSB7IHJlYWQgd3JpdGUgaW9jdGwgfTsNCmFsbG93IGJvb3RzcGxhc2hf
dCBjb25zb2xlX2RldmljZV90OmNocl9maWxlIHsgcmVhZCB3cml0ZSB9Ow0KYWxsb3cgYm9vdHNw
bGFzaF90IHR0eV9kZXZpY2VfdDpjaHJfZmlsZSB7IHJlYWQgd3JpdGUgfTsNCg==

--=-Yz6WSPhy2lbal15POTyw--

--=-rkCujWRjyXggAENwRid9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBP8d2vI7kLeavkkMRAlmBAJoD9vTFO+CKXkRP1ZaG52HJtzlgxwCgrJkM
FGBvNW2kPfmdgbWKMgsn1Xg=
=zzK2
-----END PGP SIGNATURE-----

--=-rkCujWRjyXggAENwRid9--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2TFlJRb004964
	for <selinux@tycho.nsa.gov>; Mon, 29 Mar 2004 10:47:20 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2TFeSpx011888
	for <selinux@tycho.nsa.gov>; Mon, 29 Mar 2004 15:47:06 GMT
Received: from gorn.pebenito.dhs.org (c-24-15-25-98.client.comcast.net [24.15.25.98])
        by jazzband.ncsc.mil  with ESMTP id i2T5c536006055 for <selinux@tycho.nsa.gov>; Mon, 29 Mar 2004 05:38:06 GMT
Subject: libselinux/policyvers
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DF4pD7MfDXOKpi7RtrEf"
Message-Id: <1080538678.11635.53.camel@gorn.pebenito.net>
Mime-Version: 1.0
Date: Sun, 28 Mar 2004 23:37:59 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-DF4pD7MfDXOKpi7RtrEf
Content-Type: multipart/mixed; boundary="=-HSNptksGBwocpCG/sAoa"


--=-HSNptksGBwocpCG/sAoa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Attached is a suggested patch for libselinux/src/policyvers.c.  It adds
an errno check when the open() for /selinux/policyvers fails.  If its
ENOENT, it returns the default policy version, for the case that its a
older kernel that doesn't have policyvers on selinuxfs.  Otherwise, it
returns -1, so the caller can know that its actually failed, rather than
returning a possibly incorrect policy version.

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

--=-HSNptksGBwocpCG/sAoa
Content-Disposition: attachment; filename=libselinux-errno.diff
Content-Type: text/x-patch; name=libselinux-errno.diff; charset=ISO-8859-1
Content-Transfer-Encoding: base64

SW5kZXg6IHNyYy9wb2xpY3l2ZXJzLmMNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NClJDUyBmaWxlOiAvY3Zzcm9vdC9z
ZWxpbnV4L25zYS9zZWxpbnV4LXVzci9saWJzZWxpbnV4L3NyYy9wb2xpY3l2ZXJzLmMsdg0KcmV0
cmlldmluZyByZXZpc2lvbiAxLjINCmRpZmYgLXUgLXIxLjIgcG9saWN5dmVycy5jDQotLS0gc3Jj
L3BvbGljeXZlcnMuYwkxMiBEZWMgMjAwMyAxNTo1MDoxMSAtMDAwMAkxLjINCisrKyBzcmMvcG9s
aWN5dmVycy5jCTI5IE1hciAyMDA0IDA0OjI0OjI0IC0wMDAwDQpAQCAtMjAsOCArMjAsMTIgQEAN
CiANCiAJc25wcmludGYocGF0aCwgc2l6ZW9mIHBhdGgsICIlcy9wb2xpY3l2ZXJzIiwgc2VsaW51
eF9tbnQpOw0KIAlmZCA9IG9wZW4ocGF0aCwgT19SRE9OTFkpOw0KLQlpZiAoZmQgPCAwKQ0KLQkJ
cmV0dXJuIHZlcnM7DQorCWlmIChmZCA8IDApIHsNCisJCWlmIChlcnJubyA9PSBFTk9FTlQpDQor
CQkJcmV0dXJuIHZlcnM7DQorCQllbHNlDQorCQkJcmV0dXJuIC0xOw0KKwl9DQogCW1lbXNldChi
dWYsIDAsIHNpemVvZiBidWYpOw0KIAlyZXQgPSByZWFkKGZkLCBidWYsIHNpemVvZiBidWYtMSk7
DQogCWNsb3NlKGZkKTsNCg==

--=-HSNptksGBwocpCG/sAoa--

--=-DF4pD7MfDXOKpi7RtrEf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAZ7Y0vI7kLeavkkMRAq/GAJ4ucU+pglJWwET2A8OisJ5yjdg4SQCdHgCL
1MFAwLiJb32DJt6iP/cstMk=
=ciSW
-----END PGP SIGNATURE-----

--=-DF4pD7MfDXOKpi7RtrEf--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

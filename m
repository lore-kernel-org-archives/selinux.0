Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBM039Rb019704
	for <selinux@tycho.nsa.gov>; Sun, 21 Dec 2003 19:03:09 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBM02vpn021212
	for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2003 00:02:58 GMT
Received: from chris.pebenito.dhs.org (c-24-15-24-15.client.comcast.net [24.15.24.15])
        by jazzband.ncsc.mil  with ESMTP id hBM02vab021209 for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2003 00:02:57 GMT
Subject: Re: sshd subsystems
From: Chris PeBenito <pebenito@gentoo.org>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <200312212226.50352.russell@coker.com.au>
References: <1071982130.10602.6.camel@chris.pebenito.net>
	 <200312212226.50352.russell@coker.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BjW+Xm8LXzLe69Q+NjYz"
Message-Id: <1072051372.13606.9.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: Sun, 21 Dec 2003 18:02:52 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-BjW+Xm8LXzLe69Q+NjYz
Content-Type: multipart/mixed; boundary="=-OjA+s7GpPe5a/Qf8hNol"


--=-OjA+s7GpPe5a/Qf8hNol
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-12-21 at 05:26, Russell Coker wrote:
> On Sun, 21 Dec 2003 15:48, Chris PeBenito <pebenito@gentoo.org> wrote:
> > I've been trying to decide what would be the best way to deal with sshd
> > subsystems (sftp-server for example).  Right now they can't be used
> > because of their label (transition to unpriv_userdomain domain is denie=
d
> > for one).  The simplest way to fix it would be to label the sftp-server
> > binary as shell_exec_t.  I was also thinking about using a
> > sshd_subsys_exec_t or something similar instead, and add the appropriat=
e
> > policy.  Any thoughts?
>=20
> The latter sounds like the correct option.  Please send me a patch when y=
ou=20
> have working policy.

Ok, this ended up not being as complex.  If you sftp in, it still at one
point exec's the user's shell, so it transitions ok.  After the shell
exec's, it seems to exec the subsystem executable.  So the executable
just has to be an executable type.  So I added the couple lines to make
subsystem servers be executable by unpriv_userdomain.  The file contexts
may need to be tweaked, but the first one is where Gentoo puts
sftp-server.

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

--=-OjA+s7GpPe5a/Qf8hNol
Content-Disposition: attachment; filename=sshd-subsys.diff
Content-Type: text/x-patch; name=sshd-subsys.diff; charset=iso-8859-1
Content-Transfer-Encoding: base64

ZGlmZiAtdXJOIHBvbGljeS0xLjQub3JpZy9kb21haW5zL3Byb2dyYW0vc3NoLnRlIHBvbGljeS0x
LjQvZG9tYWlucy9wcm9ncmFtL3NzaC50ZQ0KLS0tIHBvbGljeS0xLjQub3JpZy9kb21haW5zL3By
b2dyYW0vc3NoLnRlCTIwMDMtMTEtMjUgMDg6NDM6MDAuMDAwMDAwMDAwIC0wNjAwDQorKysgcG9s
aWN5LTEuNC9kb21haW5zL3Byb2dyYW0vc3NoLnRlCTIwMDMtMTItMjEgMTc6MTg6NTAuMDAwMDAw
MDAwIC0wNjAwDQpAQCAtOCw4ICs4LDEwIEBADQogDQogIyBzc2hkX2V4ZWNfdCBpcyB0aGUgdHlw
ZSBvZiB0aGUgc3NoZCBleGVjdXRhYmxlLg0KICMgc3NoZF9rZXlfdCBpcyB0aGUgdHlwZSBvZiB0
aGUgc3NoIHByaXZhdGUga2V5IGZpbGVzDQorIyBzc2hkX3N1YnN5c19leGVjX3QgaXMgdGhlIHR5
cGUgb2Ygc3NoZCBzdWJzeXN0ZW0gZXhlY3V0YWJsZXMuDQogdHlwZSBzc2hkX2V4ZWNfdCwgZmls
ZV90eXBlLCBleGVjX3R5cGUsIHN5c2FkbWZpbGU7DQogdHlwZSBzc2hkX2tleV90LCBmaWxlX3R5
cGUsIHN5c2FkbWZpbGU7DQordHlwZSBzc2hkX3N1YnN5c19leGVjX3QsIGZpbGVfdHlwZSwgZXhl
Y190eXBlLCBzeXNhZG1maWxlOw0KIA0KIHR5cGUgc3NoX3BvcnRfdCwgcG9ydF90eXBlOw0KIA0K
QEAgLTEyOSw2ICsxMzEsMTAgQEANCiBzc2hkX3Byb2dyYW1fZG9tYWluKHNzaGQpDQogc3NoZF9z
cGF3bl9kb21haW4oc3NoZCwgdW5wcml2X3VzZXJkb21haW4sIHVzZXJwdHlfdHlwZSkNCiANCisj
IGZvciBzc2hkIHN1YnN5c3RlbXMsIHN1Y2ggYXMgc2Z0cC1zZXJ2ZXIuDQorY2FuX2V4ZWModW5w
cml2X3VzZXJkb21haW4sc3NoZF9zdWJzeXNfZXhlY190KQ0KK2FsbG93IHNzaGRfdCBzc2hkX3N1
YnN5c19leGVjX3Q6ZmlsZSBnZXRhdHRyOw0KKw0KIGlmZGVmKGB1c2VfeF9wb3J0cycsIGANCiAj
IGZvciBYIGZvcndhcmRpbmcNCiBhbGxvdyBzc2hkX3QgeHNlcnZlcl9wb3J0X3Q6dGNwX3NvY2tl
dCBuYW1lX2JpbmQ7DQpkaWZmIC11ck4gcG9saWN5LTEuNC5vcmlnL2ZpbGVfY29udGV4dHMvcHJv
Z3JhbS9zc2guZmMgcG9saWN5LTEuNC9maWxlX2NvbnRleHRzL3Byb2dyYW0vc3NoLmZjDQotLS0g
cG9saWN5LTEuNC5vcmlnL2ZpbGVfY29udGV4dHMvcHJvZ3JhbS9zc2guZmMJMjAwMy0xMS0xOSAx
NDoxNToyNS4wMDAwMDAwMDAgLTA2MDANCisrKyBwb2xpY3ktMS40L2ZpbGVfY29udGV4dHMvcHJv
Z3JhbS9zc2guZmMJMjAwMy0xMi0yMSAxNzoyNToyNy4wMDAwMDAwMDAgLTA2MDANCkBAIC05LDMg
KzksNiBAQA0KIC9yb290L1wuc3NoKC8uKik/CQlzeXN0ZW1fdTpvYmplY3RfcjpzeXNhZG1faG9t
ZV9zc2hfdA0KIC9ob21lL1teL10rL1wuc3NoKC8uKik/CQlzeXN0ZW1fdTpvYmplY3Rfcjp1c2Vy
X2hvbWVfc3NoX3QNCiAvaG9tZS9qYWRtaW4vXC5zc2goLy4qKT8Jc3lzdGVtX3U6b2JqZWN0X3I6
c3RhZmZfaG9tZV9zc2hfdA0KKyMgc3Vic3lzdGVtcw0KKy91c3IvbGliL21pc2Mvc2Z0cC1zZXJ2
ZXIgLS0Jc3lzdGVtX3U6b2JqZWN0X3I6c3NoZF9zdWJzeXNfZXhlY190DQorL3Vzci9saWJleGVj
L29wZW5zc2gvc2Z0cC1zZXJ2ZXIgLS0gc3lzdGVtX3U6b2JqZWN0X3I6c3NoZF9zdWJzeXNfZXhl
Y190DQo=

--=-OjA+s7GpPe5a/Qf8hNol--

--=-BjW+Xm8LXzLe69Q+NjYz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/5jSsvI7kLeavkkMRAv0jAJ4+5/ZZaTcutYhy7yuD1COv2+g5QACgqsOV
Wn+9a4MtKA+enF6okHUwGaY=
=ogbb
-----END PGP SIGNATURE-----

--=-BjW+Xm8LXzLe69Q+NjYz--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

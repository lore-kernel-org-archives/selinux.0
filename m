Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBM5OgRb020455
	for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2003 00:24:43 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBM5Nojx004610
	for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2003 05:23:50 GMT
Received: from chris.pebenito.dhs.org (c-24-15-24-15.client.comcast.net [24.15.24.15])
	by jazzswing.ncsc.mil  with ESMTP id hBM5NoSR004607
	for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2003 05:23:50 GMT
Subject: Re: sshd subsystems
From: Chris PeBenito <pebenito@gentoo.org>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <200312221302.49764.russell@coker.com.au>
References: <1071982130.10602.6.camel@chris.pebenito.net>
	 <200312212226.50352.russell@coker.com.au>
	 <1072051372.13606.9.camel@chris.pebenito.net>
	 <200312221302.49764.russell@coker.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dX0rc5BjIJBQ380W7dRA"
Message-Id: <1072070680.14178.3.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: Sun, 21 Dec 2003 23:24:40 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-dX0rc5BjIJBQ380W7dRA
Content-Type: multipart/mixed; boundary="=-I17N84w++gxt+UELNQcF"


--=-I17N84w++gxt+UELNQcF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-12-21 at 20:02, Russell Coker wrote:=20
> > Ok, this ended up not being as complex.  If you sftp in, it still at on=
e
> > point exec's the user's shell, so it transitions ok.  After the shell
> > exec's, it seems to exec the subsystem executable.  So the executable
> > just has to be an executable type.  So I added the couple lines to make
>=20
> Why not just label the sftp executable as bin_t then?

I thought that some might want a specific type since sftp-server is off
in an odd place.  But I'm not attached to that, and bin_t would probably
be better.

subsystems as bin_t:

domains/program/ssh.te       |    3 +++
file_contexts/program/ssh.fc |    3 +++
2 files changed, 6 insertions(+)


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

--=-I17N84w++gxt+UELNQcF
Content-Disposition: attachment; filename=sshd-subsys.diff
Content-Type: text/x-patch; name=sshd-subsys.diff; charset=iso-8859-1
Content-Transfer-Encoding: base64

ZGlmZiAtdXJOIHBvbGljeS0xLjQub3JpZy9kb21haW5zL3Byb2dyYW0vc3NoLnRlIHBvbGljeS0x
LjQvZG9tYWlucy9wcm9ncmFtL3NzaC50ZQ0KLS0tIHBvbGljeS0xLjQub3JpZy9kb21haW5zL3By
b2dyYW0vc3NoLnRlCTIwMDMtMTEtMjUgMDg6NDM6MDAuMDAwMDAwMDAwIC0wNjAwDQorKysgcG9s
aWN5LTEuNC9kb21haW5zL3Byb2dyYW0vc3NoLnRlCTIwMDMtMTItMjEgMjM6MDg6MjkuMDAwMDAw
MDAwIC0wNjAwDQpAQCAtMTI5LDYgKzEyOSw5IEBADQogc3NoZF9wcm9ncmFtX2RvbWFpbihzc2hk
KQ0KIHNzaGRfc3Bhd25fZG9tYWluKHNzaGQsIHVucHJpdl91c2VyZG9tYWluLCB1c2VycHR5X3R5
cGUpDQogDQorIyBmb3Igc3NoZCBzdWJzeXN0ZW1zLCBzdWNoIGFzIHNmdHAtc2VydmVyLg0KK2Fs
bG93IHNzaGRfdCBiaW5fdDpmaWxlIGdldGF0dHI7DQorDQogaWZkZWYoYHVzZV94X3BvcnRzJywg
YA0KICMgZm9yIFggZm9yd2FyZGluZw0KIGFsbG93IHNzaGRfdCB4c2VydmVyX3BvcnRfdDp0Y3Bf
c29ja2V0IG5hbWVfYmluZDsNCmRpZmYgLXVyTiBwb2xpY3ktMS40Lm9yaWcvZmlsZV9jb250ZXh0
cy9wcm9ncmFtL3NzaC5mYyBwb2xpY3ktMS40L2ZpbGVfY29udGV4dHMvcHJvZ3JhbS9zc2guZmMN
Ci0tLSBwb2xpY3ktMS40Lm9yaWcvZmlsZV9jb250ZXh0cy9wcm9ncmFtL3NzaC5mYwkyMDAzLTEx
LTE5IDE0OjE1OjI1LjAwMDAwMDAwMCAtMDYwMA0KKysrIHBvbGljeS0xLjQvZmlsZV9jb250ZXh0
cy9wcm9ncmFtL3NzaC5mYwkyMDAzLTEyLTIxIDIzOjA3OjI4LjAwMDAwMDAwMCAtMDYwMA0KQEAg
LTksMyArOSw2IEBADQogL3Jvb3QvXC5zc2goLy4qKT8JCXN5c3RlbV91Om9iamVjdF9yOnN5c2Fk
bV9ob21lX3NzaF90DQogL2hvbWUvW14vXSsvXC5zc2goLy4qKT8JCXN5c3RlbV91Om9iamVjdF9y
OnVzZXJfaG9tZV9zc2hfdA0KIC9ob21lL2phZG1pbi9cLnNzaCgvLiopPwlzeXN0ZW1fdTpvYmpl
Y3RfcjpzdGFmZl9ob21lX3NzaF90DQorIyBzdWJzeXN0ZW1zDQorL3Vzci9saWIvbWlzYy9zZnRw
LXNlcnZlciAtLQlzeXN0ZW1fdTpvYmplY3RfcjpiaW5fdA0KKy91c3IvbGliZXhlYy9vcGVuc3No
L3NmdHAtc2VydmVyIC0tIHN5c3RlbV91Om9iamVjdF9yOmJpbl90DQo=

--=-I17N84w++gxt+UELNQcF--

--=-dX0rc5BjIJBQ380W7dRA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/5oAYvI7kLeavkkMRAuTJAJ467OKIH1pE6aq9bz5oH6Hokq1uGwCfbwAi
H7N9UCga3ff8Fa19IL3uTKw=
=np3i
-----END PGP SIGNATURE-----

--=-dX0rc5BjIJBQ380W7dRA--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i932l3rT010841
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 22:47:03 -0400 (EDT)
Received: from sccrmhc13.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i932junE006420
	for <selinux@tycho.nsa.gov>; Sun, 3 Oct 2004 02:45:56 GMT
Subject: ssh_macros diff
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OLy/jBmRVzs9DdZKT5dd"
Date: Sat, 02 Oct 2004 22:46:12 -0400
Message-Id: <1096771573.7227.5.camel@chris.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-OLy/jBmRVzs9DdZKT5dd
Content-Type: multipart/mixed; boundary="=-rryz6JNYa6SgMx3ffVyV"


--=-rryz6JNYa6SgMx3ffVyV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Heres a patch that moves the ifdef ssh-agent block out of the ifdef
xdm.te block, since ssh-agent doesn't require X.

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


--=-rryz6JNYa6SgMx3ffVyV
Content-Disposition: attachment; filename=ssh_macros.te.diff
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=ssh_macros.te.diff; charset=ISO-8859-1

SW5kZXg6IG1hY3Jvcy9wcm9ncmFtL3NzaF9tYWNyb3MudGUNCj09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NClJDUyBmaWxl
OiAvY3Zzcm9vdC9zZWxpbnV4L25zYS9zZWxpbnV4LXVzci9wb2xpY3kvbWFjcm9zL3Byb2dyYW0v
c3NoX21hY3Jvcy50ZSx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMTcNCmRpZmYgLXUgLXIxLjE3
IHNzaF9tYWNyb3MudGUNCi0tLSBtYWNyb3MvcHJvZ3JhbS9zc2hfbWFjcm9zLnRlCTEgT2N0IDIw
MDQgMTY6MTQ6MDEgLTAwMDAJMS4xNw0KKysrIG1hY3Jvcy9wcm9ncmFtL3NzaF9tYWNyb3MudGUJ
MyBPY3QgMjAwNCAwMjo0Mzo0NSAtMDAwMA0KQEAgLTE0NCw2ICsxNDQsMTAgQEANCiAnKQ0KICcp
ZG5sIGVuZCBpZiB4c2VydmVyDQogDQoraWZkZWYoYHNzaC1hZ2VudC50ZScsIGANCitzc2hfYWdl
bnRfZG9tYWluKCQxKQ0KKycpZG5sIGVuZCBpZiBzc2hfYWdlbnQudGUNCisNCiBpZmRlZihgeGRt
LnRlJywgYA0KICMgc2hvdWxkIGJlIGFibGUgdG8gcmVtb3ZlIHRoZXNlIHR3byBsYXRlcg0KIGFs
bG93ICQxX3NzaF90IHhkbV94c2VydmVyX3RtcF90OnNvY2tfZmlsZSB7IHJlYWQgd3JpdGUgfTsN
CkBAIC0xNTQsMTAgKzE1OCw2IEBADQogYWxsb3cgJDFfc3NoX3QgeGRtX3hzZXJ2ZXJfdG1wZnNf
dDpmaWxlIHJlYWQ7DQogYWxsb3cgJDFfc3NoX3Qga3JiNV9jb25mX3Q6ZmlsZSB7IGdldGF0dHIg
cmVhZCB9Ow0KIGRvbnRhdWRpdCAkMV9zc2hfdCBrcmI1X2NvbmZfdDpmaWxlIHsgd3JpdGUgfTsN
Ci0NCi1pZmRlZihgc3NoLWFnZW50LnRlJywgYA0KLXNzaF9hZ2VudF9kb21haW4oJDEpDQotJylk
bmwgZW5kIGlmIHNzaF9hZ2VudC50ZQ0KICcpZG5sIGVuZCBpZiB4ZG0udGUNCiAnKWRubCBlbmQg
aWYgc2luZ2xlX3VzZXJkb21haW4NCiAnKWRubCBlbmQgbWFjcm8gZGVmaW5pdGlvbg0K


--=-rryz6JNYa6SgMx3ffVyV--

--=-OLy/jBmRVzs9DdZKT5dd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBX2f0vI7kLeavkkMRApnSAJ4jN9XAfQ3Sf69boUoYeVZfzuIxiQCeJSja
0s/mdFi2Q5yCwzkaETiOlD0=
=tn6Z
-----END PGP SIGNATURE-----

--=-OLy/jBmRVzs9DdZKT5dd--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

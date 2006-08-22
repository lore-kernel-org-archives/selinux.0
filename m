Subject: Bug in restorecon for symlinks in root dir
From: Erich Schubert <erich@debian.org>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-c0GWOO6LNFkb+ClTeWVj"
Date: Tue, 22 Aug 2006 02:17:21 +0200
Message-Id: <1156205841.22905.33.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-c0GWOO6LNFkb+ClTeWVj
Content-Type: multipart/mixed; boundary="=-9hLX5aXQhtMLfU6VpW5U"


--=-9hLX5aXQhtMLfU6VpW5U
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,
restorecon has a bug for symlinks in the root directory, such
as /vmlinuz
or the /lib64 -> /lib symlink found on all debian amd64 systems.

The bug arises in the way the containing directories "realname" is found
for symlinks. Basically, the directory name is split by overwriting the
last / character with a \0 char; then calling realname(3) on the first
component, then joining them again.
For obvious reasons, this doesn't work for filenames such as /lib64; but
it only affects symlinks (thats why "restorecon /etc" works fine).
The easiest workaround is to use "restorecon //lib64"

Attached is a patch to fix this bug. It's untested yet, but I guess
you'll review it anyway. And it's a very easy thing, it's got to
work. ;-)

best regards,
Erich Schubert
--=20
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
     This one's tricky. You have to use imaginary numbers, like     //\
                      eleventeen... --- Hobbes                      V_/_
          Die St=E4rke eines Menschen kann man daran messen,
              wie er mit seinen Schw=E4chen fertig wird!

--=-9hLX5aXQhtMLfU6VpW5U
Content-Disposition: attachment; filename=restorecon-fix-for-symlinks-in-root.diff
Content-Type: text/x-patch; name=restorecon-fix-for-symlinks-in-root.diff;
	charset=ISO-8859-15
Content-Transfer-Encoding: base64

LS0tIHBvbGljeWNvcmV1dGlscy0xLjMwLjI2Lm9yaWcvcmVzdG9yZWNvbi9yZXN0b3JlY29uLmMN
CisrKyBwb2xpY3ljb3JldXRpbHMtMS4zMC4yNi9yZXN0b3JlY29uL3Jlc3RvcmVjb24uYw0KQEAg
LTE3OCw3ICsxNzgsMTAgQEANCiAJCQlyZXR1cm4gMTsNCiAJCX0NCiAJCWZpbGVfc2VwID0gc3Ry
cmNocih0bXBfcGF0aCwgJy8nKTsNCi0JCWlmIChmaWxlX3NlcCkgew0KKwkJaWYgKGZpbGVfc2Vw
ID09IHRtcF9wYXRoKSB7DQorCQkJZmlsZV9zZXArKzsNCisJCQlwID0gc3RyY3B5KHBhdGgsIi8i
KTsNCisJCX0gZWxzZSBpZiAoZmlsZV9zZXApIHsNCiAJCQkqZmlsZV9zZXAgPSAwOw0KIAkJCWZp
bGVfc2VwKys7DQogCQkJcCA9IHJlYWxwYXRoKHRtcF9wYXRoLCBwYXRoKTsNCg==


--=-9hLX5aXQhtMLfU6VpW5U--

--=-c0GWOO6LNFkb+ClTeWVj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE6k0QntB470s6E1wRAoEUAJwOQJH5oKvKNY6XSc95rCVNFiErLwCfVBVK
2v0UJJREAlyDumdVaDISFMI=
=LoFm
-----END PGP SIGNATURE-----

--=-c0GWOO6LNFkb+ClTeWVj--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

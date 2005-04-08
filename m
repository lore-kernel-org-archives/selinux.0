Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j380NMue001459
	for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2005 20:23:22 -0400 (EDT)
Received: from rwcrmhc14.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j380KjEI000082
	for <selinux@tycho.nsa.gov>; Fri, 8 Apr 2005 00:20:45 GMT
Subject: setfiles segfault
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Mg/MnSpgld19tBnToMN3"
Date: Thu, 07 Apr 2005 20:20:07 -0400
Message-Id: <1112919608.2991.31.camel@chris.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Mg/MnSpgld19tBnToMN3
Content-Type: multipart/mixed; boundary="=-h6ZLemDJMINortr7HHyt"


--=-h6ZLemDJMINortr7HHyt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On the current setfiles, if you do altroot, and you point it at an empty
directory, it segfaults:

gorn setfiles # ./setfiles /etc/security/selinux/file_contexts -d -r /tmp/e=
mpty/ /tmp/empty/
./setfiles:  labeling files, pretending /tmp/empty is /
./setfiles:  labeling files under /tmp/empty/
Segmentation fault
gorn setfiles # touch /tmp/empty/foo
gorn setfiles # ./setfiles /etc/security/selinux/file_contexts -d -r /tmp/e=
mpty/ /tmp/empty/
./setfiles:  labeling files, pretending /tmp/empty is /
./setfiles:  labeling files under /tmp/empty/
./setfiles:  /tmp/empty/foo matched by system_u:object_r:default_t
matchpathcon_filespec_eval:  hash table stats: 1 elements, 1/65536 buckets =
used, longest chain length 1
./setfiles:  Done.

As evidenced above, the altroot directory does not match the root
directory correctly.  Any trailing /'s are stripped by the time the path
gets used in the match() call, which is correct.  But then if there is
an altroot, the name pointer is advanced by the length of the root path
string to strip off the altroot path, for matching.  This works in all
cases, except for the root directory, which becomes an empty string
since the path is the same as the altroot path.  Since the lstat() in
the function uses the true path, it succeeds, but the
matchpathcon_index() fails, leaving the hashtable empty (fl_head is
null).  Then when we get back to main and do the
matchpathcon_filespec_destroy(), the function tries to free a null
pointer, causing the segfault.

The attached patch fixes this condition, by checking if the name is an
empty string.  I initially considered concatenating on a / in this case,
rather then the current implementation, but this won't work since all
the strings are const.  It also removes buf from the function, as it
seems redundant, since the one operation done to buf is also done to
name, and buf is just a copy of name.  This patch is against sourceforge
cvs.

 setfiles.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

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


--=-h6ZLemDJMINortr7HHyt
Content-Disposition: attachment; filename=setfiles-altroot-rootdir.diff
Content-Type: text/x-patch; name=setfiles-altroot-rootdir.diff; charset=ISO-8859-1
Content-Transfer-Encoding: base64

SW5kZXg6IHNldGZpbGVzL3NldGZpbGVzLmMNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NClJDUyBmaWxlOiAvY3Zzcm9v
dC9zZWxpbnV4L25zYS9zZWxpbnV4LXVzci9wb2xpY3ljb3JldXRpbHMvc2V0ZmlsZXMvc2V0Zmls
ZXMuYyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMjcNCmRpZmYgLXUgLXIxLjI3IHNldGZpbGVz
LmMNCi0tLSBzZXRmaWxlcy9zZXRmaWxlcy5jCTE2IE1hciAyMDA1IDE1OjM5OjMzIC0wMDAwCTEu
MjcNCisrKyBzZXRmaWxlcy9zZXRmaWxlcy5jCTggQXByIDIwMDUgMDA6MDk6NDggLTAwMDANCkBA
IC0xNjQsNyArMTY0LDYgQEANCiB7DQogCWludCByZXQ7DQogCWNvbnN0IGNoYXIgKmZ1bGxuYW1l
ID0gbmFtZTsNCi0JY29uc3QgY2hhciAqYnVmID0gbmFtZTsNCiANCiAJLyogZnVsbG5hbWUgd2ls
bCBiZSB0aGUgcmVhbCBmaWxlIHRoYXQgZ2V0cyBsYWJlbGVkDQogCSAqIG5hbWUgd2lsbCBiZSB3
aGF0IGlzIG1hdGNoZWQgaW4gdGhlIHBvbGljeSAqLw0KQEAgLTE3NSw3ICsxNzQsNiBAQA0KIAkJ
CXJldHVybiAtMTsNCiAJCX0NCiAJCW5hbWUgKz0gcm9vdHBhdGhsZW47DQotCQlidWYgKz0gcm9v
dHBhdGhsZW47DQogCX0NCiANCiAJaWYgKGV4Y2x1ZGVDdHIgPiAwKSB7DQpAQCAtMTkwLDcgKzE4
OCwxMSBAQA0KIAkJcmV0dXJuIC0xOw0KIAl9DQogDQotCXJldHVybiBtYXRjaHBhdGhjb25faW5k
ZXgoYnVmLCBzYi0+c3RfbW9kZSwgY29uKTsNCisJaWYocm9vdHBhdGggIT0gTlVMTCAmJiBuYW1l
WzBdPT0nXDAnKQ0KKwkJLyogdGhpcyBpcyBhY3R1YWxseSB0aGUgcm9vdCBkaXIgb2YgdGhlIGFs
dCByb290ICovDQorCQlyZXR1cm4gbWF0Y2hwYXRoY29uX2luZGV4KCIvIiwgc2ItPnN0X21vZGUs
IGNvbik7DQorCWVsc2UNCisJCXJldHVybiBtYXRjaHBhdGhjb25faW5kZXgobmFtZSwgc2ItPnN0
X21vZGUsIGNvbik7DQogfQ0KIA0KIHZvaWQgdXNhZ2UoY29uc3QgY2hhciAqIGNvbnN0IG5hbWUp
DQo=


--=-h6ZLemDJMINortr7HHyt--

--=-Mg/MnSpgld19tBnToMN3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCVc43vI7kLeavkkMRAg61AKCPeQnds9iQ0zxfyC78ngUmWkMAzQCgnFSG
1LsWNbtJTMUdyMdzowsU/B8=
=FYW4
-----END PGP SIGNATURE-----

--=-Mg/MnSpgld19tBnToMN3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA31TWXZ011593
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 20:29:32 -0500 (EST)
Received: from sccrmhc11.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA31SB8r020660
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 01:28:11 GMT
Subject: Re: What policy is the system running?
From: Chris PeBenito <pebenito@gentoo.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <4187DEA1.8080407@redhat.com>
References: <4187DEA1.8080407@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JlGfgFZgdidC4vBVJ5AJ"
Date: Tue, 02 Nov 2004 20:28:26 -0500
Message-Id: <1099445306.5178.4.camel@chris.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-JlGfgFZgdidC4vBVJ5AJ
Content-Type: multipart/mixed; boundary="=-uesHT+D2LfYHZsWgf/G0"


--=-uesHT+D2LfYHZsWgf/G0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-11-02 at 14:23 -0500, Daniel J Walsh wrote:
> We have been doing some work on sestatus and selinuxconfig type tools=20
> to  be able to tell us about the current running system.=20
> We have a problem in that we can not tell which policy is currently=20
> running on the system (strict, targeted, mls, ...)

Since I've been trying out the MLS stuff, I cooked up a patch for
sestatus to display that the kernel is compiled with MLS.  I also put it
on the "disabled" output, for the case that someone accidentally
compiles a MLS kernel, and wonders why their policy won't load.

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


--=-uesHT+D2LfYHZsWgf/G0
Content-Disposition: attachment; filename=sestatus-mls.diff
Content-Type: text/x-patch; name=sestatus-mls.diff; charset=ISO-8859-1
Content-Transfer-Encoding: base64

SW5kZXg6IHNlc3RhdHVzLmMNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NClJDUyBmaWxlOiAvdmFyL2N2c3Jvb3QvZ2Vu
dG9vLXByb2plY3RzL2hhcmRlbmVkL3BvbGljeWNvcmV1dGlscy1leHRyYS9zcmMvc2VzdGF0dXMu
Yyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMjENCmRpZmYgLXUgLXIxLjIxIHNlc3RhdHVzLmMN
Ci0tLSBzZXN0YXR1cy5jCTI3IEF1ZyAyMDA0IDIzOjQzOjQ3IC0wMDAwCTEuMjENCisrKyBzZXN0
YXR1cy5jCTMgTm92IDIwMDQgMDE6MTc6MzAgLTAwMDANCkBAIC0yMDEsMTAgKzIwMSwxOCBAQA0K
IA0KIAlzd2l0Y2gocmMpIHsNCiAJCWNhc2UgMToNCi0JCQlwcmludGYoImVuYWJsZWRcbiIpOw0K
KwkJCWlmKGlzX3NlbGludXhfbWxzX2VuYWJsZWQoKSkNCisJCQkJcHJpbnRmKCJlbmFibGVkLCBN
TFNcbiIpOw0KKwkJCWVsc2UNCisJCQkJcHJpbnRmKCJlbmFibGVkXG4iKTsNCisNCiAJCQlicmVh
azsNCiAJCWNhc2UgMDoNCi0JCQlwcmludGYoImRpc2FibGVkXG4iKTsNCisJCQlpZihpc19zZWxp
bnV4X21sc19lbmFibGVkKCkpDQorCQkJCXByaW50ZigiZGlzYWJsZWQsIE1MU1xuIik7DQorCQkJ
ZWxzZQ0KKwkJCQlwcmludGYoImRpc2FibGVkXG4iKTsNCisNCiAJCQlyZXR1cm4gMDsNCiAJCQli
cmVhazsNCiAJCWRlZmF1bHQ6DQo=


--=-uesHT+D2LfYHZsWgf/G0--

--=-JlGfgFZgdidC4vBVJ5AJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBiDQ5vI7kLeavkkMRApMvAJsEQoKKLkSSRzhjT0spUNcF0EARyQCgnAFP
aHm3GQV86RMLjURbj4mAH4I=
=FjY+
-----END PGP SIGNATURE-----

--=-JlGfgFZgdidC4vBVJ5AJ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Subject: [patch] allow users of tmp_domain to read /usr/tmp
From: Colin Walters <walters@verbum.org>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-U1fRGsAqUtKFHUpBnjHe"
Date: Wed, 12 Jan 2005 16:27:25 -0500
Message-Id: <1105565245.4415.29.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-U1fRGsAqUtKFHUpBnjHe
Content-Type: multipart/mixed; boundary="=-LeDWl+nJLxwYihFlzai4"


--=-LeDWl+nJLxwYihFlzai4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

On Fedora at least, /usr/tmp is a symlink to /var/tmp.  Users of
tmp_domain get write access to tmp_t:dir, so I think it makes sense to
automatically grant access to tmp_t:lnk_file as well, so that programs
which refer to /usr/tmp work.  This should be safe since as discussed
earlier no non-unconfined domain can create tmp_t:lnk_file.

This came up on the #fedora-selinux channel where a user was trying to
get their CGI script to work.





--=-LeDWl+nJLxwYihFlzai4
Content-Disposition: attachment; filename=tmp-domain-usr-tmp.patch
Content-Type: text/x-patch; name=tmp-domain-usr-tmp.patch; charset=UTF-8
Content-Transfer-Encoding: base64

LS0tIHBvbGljeS0xLjIxLjEvbWFjcm9zL2dsb2JhbF9tYWNyb3MudGV+CTIwMDUtMDEtMTIgMTY6
MTk6MTYuMDAwMDAwMDAwIC0wNTAwDQorKysgcG9saWN5LTEuMjEuMS9tYWNyb3MvZ2xvYmFsX21h
Y3Jvcy50ZQkyMDA1LTAxLTEyIDE2OjIwOjU0LjAwMDAwMDAwMCAtMDUwMA0KQEAgLTQwOSw2ICs0
MDksNyBAQA0KIGlmZWxzZSgkMywgYCcsDQogYGZpbGVfdHlwZV9hdXRvX3RyYW5zKCQxX3QsIHRt
cF90LCAkMV90bXBfdCwgYHsgZmlsZSBkaXIgfScpJywNCiBgZmlsZV90eXBlX2F1dG9fdHJhbnMo
JDFfdCwgdG1wX3QsICQxX3RtcF90LCBgJDMnKScpDQorYWxsb3cgJDFfdCB0bXBfdDpsbmtfZmls
ZSB7IGdldGF0dHIgcmVhZCB9Ow0KICcpDQogDQogZGVmaW5lKGB0bXBmc19kb21haW4nLCBgDQo=


--=-LeDWl+nJLxwYihFlzai4--

--=-U1fRGsAqUtKFHUpBnjHe
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB5ZY9OIkJWWp2WGURAtbJAKCElcr0N0EDkhcsjBaM4Cc0uhgeLgCfaL06
I0Kc0TomGoMsNTJUN886COE=
=4OIv
-----END PGP SIGNATURE-----

--=-U1fRGsAqUtKFHUpBnjHe--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m71DsepN006185
	for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2008 09:54:40 -0400
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m71DsdbZ023271
	for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2008 13:54:39 GMT
Received: by nf-out-0910.google.com with SMTP id b21so506050nfd.4
        for <selinux@tycho.nsa.gov>; Fri, 01 Aug 2008 06:54:38 -0700 (PDT)
Subject: [refpolicy patch] Add Git daemon domain.
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LNlCrr9cxfWiZ2C5BSY8"
Date: Fri, 01 Aug 2008 15:54:37 +0200
Message-Id: <1217598877.5371.19.camel@sulphur.notebook.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-LNlCrr9cxfWiZ2C5BSY8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Here is my Git daemon domain policy. It works fine but it is not perfect
yet as far as i can tell, and it could use some testing.

Please have a look. Comments and suggestion are welcome.

https://bugzilla.redhat.com/attachment.cgi?id=3D313195

--=20
Dominick Grift <domg472@gmail.com>

--=-LNlCrr9cxfWiZ2C5BSY8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiTFZsACgkQL00QnzrVtlwduwCgx9dkm5GnjkcAHBNBYrIL4vYX
whwAmwZr7DMsuMdsrVtSew5CC+WpZy/Z
=M6Za
-----END PGP SIGNATURE-----

--=-LNlCrr9cxfWiZ2C5BSY8--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

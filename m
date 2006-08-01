Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k71HRP5H030569
	for <selinux@tycho.nsa.gov>; Tue, 1 Aug 2006 13:27:25 -0400
Received: from mail.and.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k71HRJvL001866
	for <selinux@tycho.nsa.gov>; Tue, 1 Aug 2006 17:27:20 GMT
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by mail.and.org with esmtp (Exim 4.62)
	(envelope-from <jantill@redhat.com>)
	id 1G7y1Z-0003n9-GA
	for selinux@tycho.nsa.gov; Tue, 01 Aug 2006 13:27:21 -0400
Subject: gnuTAR support for SELinux context (beta)
From: James Antill <jantill@redhat.com>
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-owwodnQ/m1Bj7bpGiLGm"
Date: Tue, 01 Aug 2006 13:27:20 -0400
Message-Id: <1154453240.2103.27.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-owwodnQ/m1Bj7bpGiLGm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


 This is just a quick note to let you know that we've got beta
packages[1] for creating/extracting tar archives with SELinux context in
them (note that these packages are also based on rawhide, so will have
other changes).
 This should be able to extract any archives you've previously made with
star.

 You can create archives with just selinux context information by using
--selinux, or with full xattr support using --xattrs. In a similar vein
you can ignore any selinux context information by using --no-selinux
when you extract, or --no-xattrs to ignore all xattr information.

[1] http://people.redhat.com/jantill/

--=20
James Antill <jantill@redhat.com>

--=-owwodnQ/m1Bj7bpGiLGm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQBEz47411eXTEMrxtQRAnFpAJ9TE3jm/WCrG2LxqtTVCRZ50YcuTwCff46q
FalsF6kM0MkAU2RmWiHC3Jg=
=mQUy
-----END PGP SIGNATURE-----

--=-owwodnQ/m1Bj7bpGiLGm--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

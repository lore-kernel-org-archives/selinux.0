Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4BHUdWO015802
	for <selinux@tycho.nsa.gov>; Thu, 11 May 2006 13:30:39 -0400
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4BHUck1003420
	for <selinux@tycho.nsa.gov>; Thu, 11 May 2006 17:30:38 GMT
Received: from turing-police.cc.vt.edu (localhost [127.0.0.1])
	by turing-police.cc.vt.edu (8.13.7.PreAlpha0/8.13.7.PreAlpha0) with ESMTP id k4BHUc13006509
	for <selinux@tycho.nsa.gov>; Thu, 11 May 2006 13:30:38 -0400
Message-Id: <200605111730.k4BHUc13006509@turing-police.cc.vt.edu>
To: selinux@tycho.nsa.gov
Subject: textrel_shlib_t
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1147368638_2474P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Thu, 11 May 2006 13:30:38 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1147368638_2474P
Content-Type: text/plain; charset=us-ascii

(And yes, I *know* I can just chcon the sucker into submission...)

I have a 3rd-party shared library, for which I have source. It's
throwing a execmod AVC that can be worked around with textrel_shlib_t.

What in the source code causes this, and what's a good fix?  I'd
like to create a patch and push it upstream so it will Just Work for
others....


--==_Exmh_1147368638_2474P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEY3S+cC3lWbTT17ARAr7PAJ9Clmc081G8lWKmLtsOf0quI1xVhgCgu5Jp
FfHmn3qphqB7X7OZEe9QkDA=
=R+gC
-----END PGP SIGNATURE-----

--==_Exmh_1147368638_2474P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

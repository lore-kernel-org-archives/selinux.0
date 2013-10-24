Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OF2fsv032267
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:02:41 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OF2bP6007351
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:02:38 -0400
Message-ID: <5269368D.1050201@redhat.com>
Date: Thu, 24 Oct 2013 11:02:37 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 56/74] Fix customized of fcontext and booleans to return
Content-Type: multipart/mixed;
 boundary="------------050303040706050204050508"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050303040706050204050508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Customized output was wrong in semanage extract.


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpNowACgkQrlYvE4MpobPHtwCeJpFqobKzeOBFk03r00Dro5le
jlIAnjGPerQvUDdVLTM8/7TADDy46ZQm
=emRq
-----END PGP SIGNATURE-----

--------------050303040706050204050508
Content-Type: text/x-patch;
 name="0056-Fix-customized-of-fcontext-and-booleans-to-return-pr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0056-Fix-customized-of-fcontext-and-booleans-to-return-pr.pa";
 filename*1="tch"


--------------050303040706050204050508--

Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MEtHXM014186
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:55:17 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0MEtE3X016257
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:55:15 -0500
Message-ID: <50FEA849.4010201@redhat.com>
Date: Tue, 22 Jan 2013 09:55:05 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 63/84] libselinux: Use ENOTSUP instead of EOPNOTSUPP for
Content-Type: multipart/mixed;
 boundary="------------020501090202020600010609"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020501090202020600010609
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD+qEkACgkQrlYvE4MpobP4BQCgoc9VOznuwXSsi2n5O2lPGpRI
k34AoNuCXMLQAgrMBULVDmcIEJ7NMqME
=cT7L
-----END PGP SIGNATURE-----

--------------020501090202020600010609
Content-Type: text/x-patch;
 name="0063-libselinux-Use-ENOTSUP-instead-of-EOPNOTSUPP-for-get.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0063-libselinux-Use-ENOTSUP-instead-of-EOPNOTSUPP-for-get.pa";
 filename*1="tch"


--------------020501090202020600010609--

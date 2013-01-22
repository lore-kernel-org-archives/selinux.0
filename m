Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MEdm8N011301
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:39:49 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0MEdkhT009686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:39:46 -0500
Message-ID: <50FEA4B1.4040708@redhat.com>
Date: Tue, 22 Jan 2013 09:39:45 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 20/84] libselinux: do not leak mmapfd
Content-Type: multipart/mixed;
 boundary="------------090506070803070408030809"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090506070803070408030809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD+pLEACgkQrlYvE4MpobMDkwCggqdjNp0RXwZas3OvbO4KNXzx
wrsAniIGWv+xvvVrJVSfBDG0miRHKWFA
=R3E7
-----END PGP SIGNATURE-----

--------------090506070803070408030809
Content-Type: text/x-patch;
 name="0020-libselinux-do-not-leak-mmapfd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0020-libselinux-do-not-leak-mmapfd.patch"


--------------090506070803070408030809--

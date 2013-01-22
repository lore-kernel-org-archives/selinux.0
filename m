Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MFGBVB018029
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 10:16:11 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0MFG9Fu005462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 10:16:09 -0500
Message-ID: <50FEA97E.9050208@redhat.com>
Date: Tue, 22 Jan 2013 10:00:14 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 82/84] libselinux: optimize set*con functions
Content-Type: multipart/mixed;
 boundary="------------090906030004030802080208"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090906030004030802080208
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD+qX4ACgkQrlYvE4MpobO9VQCffAy0N7x2NCiln61Tv6gPLIcp
UtMAnjGJa+ex95zTiFB0j73P+yh3IaeJ
=6rZI
-----END PGP SIGNATURE-----

--------------090906030004030802080208
Content-Type: text/x-patch;
 name="0082-libselinux-optimize-set-con-functions.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0082-libselinux-optimize-set-con-functions.patch"


--------------090906030004030802080208--

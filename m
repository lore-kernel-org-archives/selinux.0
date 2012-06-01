Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q51I7PXo009439
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 14:07:27 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q51I7KXW003725
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 14:07:23 -0400
Message-ID: <4FC8FBA0.3010408@redhat.com>
Date: Fri, 01 Jun 2012 13:28:00 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 77/90] Allow matchpathcon to use multiple prefixes and test
Content-Type: multipart/mixed;
 boundary="------------010508020603050306010901"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010508020603050306010901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/I+6AACgkQrlYvE4MpobONTwCfYxX5SNV2+hHvDy90ljfs3oRL
GZMAn3vAzZnRqJKEL/EG3usgcM+bx1mj
=uFgV
-----END PGP SIGNATURE-----

--------------010508020603050306010901
Content-Type: text/x-patch;
 name="0077-Allow-matchpathcon-to-use-multiple-prefixes-and-test.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0077-Allow-matchpathcon-to-use-multiple-prefixes-and-test.pa";
 filename*1="tch"


--------------010508020603050306010901--

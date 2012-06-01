Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q51I5aLA009238
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 14:05:36 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q51I5WNb023123
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 14:05:34 -0400
Message-ID: <4FC8FC20.7080503@redhat.com>
Date: Fri, 01 Jun 2012 13:30:08 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 82/90] Optimize expand_filename_trans() function
Content-Type: multipart/mixed;
 boundary="------------080105040502000508000206"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080105040502000508000206
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/I/CAACgkQrlYvE4MpobMAxQCgkB0Na6PfHbE5ewqXnPjraUfi
VhwAoIVlEsiApylaOKnod/f9E9Uc0lkL
=TzM4
-----END PGP SIGNATURE-----

--------------080105040502000508000206
Content-Type: text/x-patch;
 name="0082-Optimize-expand_filename_trans-function-part2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0082-Optimize-expand_filename_trans-function-part2.patch"


--------------080105040502000508000206--

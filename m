Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q3NKlPCq026022
	for <selinux@tycho.nsa.gov>; Mon, 23 Apr 2012 16:47:25 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q3NKlO3j019126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Mon, 23 Apr 2012 16:47:25 -0400
Message-ID: <4F95BFDB.7070506@redhat.com>
Date: Mon, 23 Apr 2012 16:47:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 49/49] libsepol: allocate enough space to hold filename in
Content-Type: multipart/mixed;
 boundary="------------050701030808000208040206"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050701030808000208040206
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+Vv9sACgkQrlYvE4MpobOE9gCg2G1dwcOlmyEeIPjx1VEPIqWU
ii4AoIHWZbQ8T/TKxrMlniWeG/bzfxQN
=l3eh
-----END PGP SIGNATURE-----

--------------050701030808000208040206
Content-Type: text/x-patch;
 name="0049-libsepol-allocate-enough-space-to-hold-filename-in-t.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0049-libsepol-allocate-enough-space-to-hold-filename-in-t.pa";
 filename*1="tch"


--------------050701030808000208040206--

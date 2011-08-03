Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p73KnNSU007363
	for <selinux@tycho.nsa.gov>; Wed, 3 Aug 2011 16:49:23 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p73KnM1I005997
	for <selinux@tycho.nsa.gov>; Wed, 3 Aug 2011 20:49:22 GMT
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p73KnM2k027338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 3 Aug 2011 16:49:22 -0400
Message-ID: <4E39B451.8040309@redhat.com>
Date: Wed, 03 Aug 2011 16:49:21 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 007/155] libselinux: support new python3 functions
Content-Type: multipart/mixed;
 boundary="------------010505070107090308010308"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010505070107090308010308
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.


Also had Dave Malcolm review and tested on python, python3 and python3.2

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk45tFEACgkQrlYvE4MpobPq0QCdEj1A7G6Gt4GKxlPiFXf7GhWS
WzsAoNjJ74HK3UBpzcwNDkzMcMR93mD9
=ivUI
-----END PGP SIGNATURE-----

--------------010505070107090308010308
Content-Type: text/plain;
 name="0007-libselinux-support-new-python3-functions.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0007-libselinux-support-new-python3-functions.patch"


--------------010505070107090308010308--

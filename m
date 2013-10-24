Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OExjV5031533
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:59:45 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OExhIg003716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:59:43 -0400
Message-ID: <526935DE.4050202@redhat.com>
Date: Thu, 24 Oct 2013 10:59:42 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 51/74] If a user specifies a module to add that does not exist
Content-Type: multipart/mixed;
 boundary="------------090402090205090509090007"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090402090205090509090007
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Improve error handling in semanage to not rely on the library to report
errors, but give better user feedback.

   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpNd4ACgkQrlYvE4MpobNYnwCg3BSmrit6DZhn9WLbwZNSVJRK
CXsAn2hv1X0s6Sa4joQY3RfobquIcoWH
=2OCW
-----END PGP SIGNATURE-----

--------------090402090205090509090007
Content-Type: text/x-patch;
 name="0051-If-a-user-specifies-a-module-to-add-that-does-not-ex.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0051-If-a-user-specifies-a-module-to-add-that-does-not-ex.pa";
 filename*1="tch"


--------------090402090205090509090007--

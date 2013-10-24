Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OEvRJG031174
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:57:27 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OEvPrn002820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:57:26 -0400
Message-ID: <52693554.9090409@redhat.com>
Date: Thu, 24 Oct 2013 10:57:24 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 48/74] Fix bug in logger.
Content-Type: multipart/mixed;
 boundary="------------020705040903060709080102"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020705040903060709080102
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

semanage was blowing up on platforms that did not support audit, this patch
fixes this.

   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpNVQACgkQrlYvE4MpobN0NQCeIh3a1Xu9FtmeBLbqRj9b9for
Vu0AoKzY600g0RSwqUUXEDWx3bx7hmpp
=GbaH
-----END PGP SIGNATURE-----

--------------020705040903060709080102
Content-Type: text/x-patch;
 name="0048-Fix-bug-in-logger.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0048-Fix-bug-in-logger.patch"


--------------020705040903060709080102--

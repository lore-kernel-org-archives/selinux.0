Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pBJLUpWP027526
	for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2011 16:30:51 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id pBJLUo6s010829
	for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2011 21:30:50 GMT
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pBJLUnWh000542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2011 16:30:49 -0500
Message-ID: <4EEFAD09.7040508@redhat.com>
Date: Mon, 19 Dec 2011 16:30:49 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 24/25] libselinux - correct selabel invalid context logging
Content-Type: multipart/mixed;
 boundary="------------040502020704090805020002"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040502020704090805020002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7vrQgACgkQrlYvE4MpobNqFwCg1a/hr6EIDZDRRKeB82uDP2I2
ATYAoOfh4Gg3yCnLkLUvWZETac9AbbXI
=Us7a
-----END PGP SIGNATURE-----

--------------040502020704090805020002
Content-Type: text/plain;
 name="0024-libselinux-correct-selabel-invalid-context-logging.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0024-libselinux-correct-selabel-invalid-context-logging.patc";
 filename*1="h"


--------------040502020704090805020002--

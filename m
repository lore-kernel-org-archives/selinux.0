Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RF7hPd024574
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:07:43 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q2RF7gYw000746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:07:42 -0400
Message-ID: <4F71D7BD.3060702@redhat.com>
Date: Tue, 27 Mar 2012 11:07:41 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 21/73] libselinux: Fix const-correctness
Content-Type: multipart/mixed;
 boundary="------------000804050102080001010905"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000804050102080001010905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9x170ACgkQrlYvE4MpobN0UACdGvQKtlSiMHoxOeRiplBRMvGg
T0EAoIRsajjXWEoPAkbMTHwjIWFF6UOg
=IJcf
-----END PGP SIGNATURE-----

--------------000804050102080001010905
Content-Type: text/x-patch;
 name="0021-libselinux-Fix-const-correctness.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0021-libselinux-Fix-const-correctness.patch"


--------------000804050102080001010905--

Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MFrAIq022347
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 10:53:10 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0MFr8LZ029808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 10:53:08 -0500
Message-ID: <50FEA9CE.2010309@redhat.com>
Date: Tue, 22 Jan 2013 10:01:34 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 81/84] sepolgen: Use refpolicy_makefile() instead of
Content-Type: multipart/mixed;
 boundary="------------000600000405050203070908"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000600000405050203070908
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD+qcwACgkQrlYvE4MpobOcYgCcCfuNeUoFMt11tXrUtYVqplQK
kpIAoOg/PkKUzXNCE85L+/MjuvcRs5Oe
=BhJJ
-----END PGP SIGNATURE-----

--------------000600000405050203070908
Content-Type: text/x-patch;
 name="0081-sepolgen-Use-refpolicy_makefile-instead-of-hardcodin.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0081-sepolgen-Use-refpolicy_makefile-instead-of-hardcodin.pa";
 filename*1="tch"


--------------000600000405050203070908--

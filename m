Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q51J2doh014492
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 15:02:39 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q51J2T81027560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 15:02:38 -0400
Message-ID: <4FC8FBFF.3090406@redhat.com>
Date: Fri, 01 Jun 2012 13:29:35 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 81/90] Optimize expand_filename_trans() function
Content-Type: multipart/mixed;
 boundary="------------010307020405080603000902"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010307020405080603000902
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/I+/8ACgkQrlYvE4MpobOwKQCgsLKH/MsX9f1vUi+YHHDdp3Ss
qaIAoNdvd2qRVzkZK+jhlssF3qT9UFLo
=ZSiY
-----END PGP SIGNATURE-----

--------------010307020405080603000902
Content-Type: text/x-patch;
 name="0081-Optimize-expand_filename_trans-function-part1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0081-Optimize-expand_filename_trans-function-part1.patch"


--------------010307020405080603000902--

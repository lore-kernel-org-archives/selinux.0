Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q51I84KF009893
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 14:08:05 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q51I80cD006860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 14:08:03 -0400
Message-ID: <4FC8FAC7.1040302@redhat.com>
Date: Fri, 01 Jun 2012 13:24:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 64/90] Fix semanage dontaudit off to work correctly
Content-Type: multipart/mixed;
 boundary="------------050609050600060902060205"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050609050600060902060205
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/I+scACgkQrlYvE4MpobNgEQCfcjDvdvIPomSim0QHhO7Y6zFD
/r0AoMxIbM3/MjbVCwfdST6Fwrk3Zoqk
=KQoB
-----END PGP SIGNATURE-----

--------------050609050600060902060205
Content-Type: text/x-patch;
 name="0064-Fix-semanage-dontaudit-off-to-work-correctly.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0064-Fix-semanage-dontaudit-off-to-work-correctly.patch"


--------------050609050600060902060205--

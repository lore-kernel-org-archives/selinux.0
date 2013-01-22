Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MEuROA014384
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:56:27 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0MEuOQi001545
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:56:25 -0500
Message-ID: <50FEA897.1050506@redhat.com>
Date: Tue, 22 Jan 2013 09:56:23 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 68/84] checkpolicy: Fix errors found by coverity
Content-Type: multipart/mixed;
 boundary="------------050804040306030709010006"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050804040306030709010006
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD+qJcACgkQrlYvE4MpobOgugCgs+NS9UBi7v166LH92M1YEo2F
+qIAn3iO6qi2Gz9UQK2hFgWpG08v1QJs
=cVTn
-----END PGP SIGNATURE-----

--------------050804040306030709010006
Content-Type: text/x-patch;
 name="0068-checkpolicy-Fix-errors-found-by-coverity.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0068-checkpolicy-Fix-errors-found-by-coverity.patch"


--------------050804040306030709010006--

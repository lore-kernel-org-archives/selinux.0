Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RFbrAC027877
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:37:53 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q2RFbqhg011627
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:37:52 -0400
Message-ID: <4F71DECF.5000409@redhat.com>
Date: Tue, 27 Mar 2012 11:37:51 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 61/73] sepolgen: fix detection of policy loads
Content-Type: multipart/mixed;
 boundary="------------050904030508050202040202"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050904030508050202040202
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9x3s8ACgkQrlYvE4MpobNUJACeL7ekNNgdvXjYk5hi4bjeyGgz
bD4Anj0QYt+Lj979BMj3gaCh5Yq4tqWq
=HGXN
-----END PGP SIGNATURE-----

--------------050904030508050202040202
Content-Type: text/x-patch;
 name="0061-sepolgen-fix-detection-of-policy-loads.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0061-sepolgen-fix-detection-of-policy-loads.patch"


--------------050904030508050202040202--

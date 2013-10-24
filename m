Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OFBSbe000955
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:11:30 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OFBSOD029114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:11:29 -0400
Message-ID: <526938A0.60701@redhat.com>
Date: Thu, 24 Oct 2013 11:11:28 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 68/74] setfiles should always return -1 on failures.
Content-Type: multipart/mixed;
 boundary="------------040908080704070605020407"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040908080704070605020407
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Our QE team was complaining about getting random exist codes from setfiles,
this consolidates the exit error code to be -1.
   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpOKAACgkQrlYvE4MpobOaZQCfVaTcm6MFBM1PRLr8v9KbmUDr
WF4An0vO0xOV4tiGphXN7mXdRJjormux
=QPV1
-----END PGP SIGNATURE-----

--------------040908080704070605020407
Content-Type: text/x-patch;
 name="0068-setfiles-should-always-return-1-on-failures.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0068-setfiles-should-always-return-1-on-failures.patch"


--------------040908080704070605020407--

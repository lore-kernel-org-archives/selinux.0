Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OFCec7001064
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:12:40 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OFCc3F021832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:12:38 -0400
Message-ID: <526938E5.1050404@redhat.com>
Date: Thu, 24 Oct 2013 11:12:37 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 72/74] Mount sys before trying to mount selinuxfs
Content-Type: multipart/mixed;
 boundary="------------020108050601040100020400"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020108050601040100020400
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpOOUACgkQrlYvE4MpobPL2gCffKt7IyVr1brOg0uc+WVB0+S6
/ewAn0mIvqaX3yHGlZyeCVze/jMmwyH2
=xpz0
-----END PGP SIGNATURE-----

--------------020108050601040100020400
Content-Type: text/x-patch;
 name="0072-Mount-sys-before-trying-to-mount-selinuxfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0072-Mount-sys-before-trying-to-mount-selinuxfs.patch"


--------------020108050601040100020400--

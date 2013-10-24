Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OEun3V031110
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:56:49 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OEulGL004704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:56:47 -0400
Message-ID: <5269352F.402@redhat.com>
Date: Thu, 24 Oct 2013 10:56:47 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 47/74] Add new FILE_STRING constands
Content-Type: multipart/mixed;
 boundary="------------040803080300070501050907"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040803080300070501050907
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch is being added to add new constants for translation between file
types and short strings, needed for new sepolicy tool chain.

   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpNS4ACgkQrlYvE4MpobMBVACfQW+KcmCqF626I6+3BepZHhVh
DkIAn0z38PaHmZy4pH8/AFLToYkD5z7b
=fvmG
-----END PGP SIGNATURE-----

--------------040803080300070501050907
Content-Type: text/x-patch;
 name="0047-Add-new-FILE_STRING-constands.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0047-Add-new-FILE_STRING-constands.patch"


--------------040803080300070501050907--

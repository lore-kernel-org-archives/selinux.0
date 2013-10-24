Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OErXe6030777
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:53:33 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OErVlJ019340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:53:32 -0400
Message-ID: <5269346B.3080405@redhat.com>
Date: Thu, 24 Oct 2013 10:53:31 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 43/74] Add test script for testing semanage functionality.
Content-Type: multipart/mixed;
 boundary="------------060705020302060404030305"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060705020302060404030305
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

THis is a python script to test the semanage command, currently must be run as
root on the host machine.

   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpNGsACgkQrlYvE4MpobMG7gCdHXqaK9gmvepU/hxE4f33XDJj
v18AoLZ3lxhrZIA3p9dOBUiwsZ0lTHrD
=2irj
-----END PGP SIGNATURE-----

--------------060705020302060404030305
Content-Type: text/x-patch;
 name="0043-Add-test-script-for-testing-semanage-functionality.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0043-Add-test-script-for-testing-semanage-functionality.patc";
 filename*1="h"


--------------060705020302060404030305--

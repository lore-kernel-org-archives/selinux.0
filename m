Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8FJcr49019831
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 15:38:53 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p8FJcpBx000762
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 19:38:52 GMT
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p8FJch5H023976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 15:38:43 -0400
Message-ID: <4E725442.5000407@redhat.com>
Date: Thu, 15 Sep 2011 15:38:42 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 29/67] policycoreutils: restorecon: Always check return code
Content-Type: multipart/mixed;
 boundary="------------040805030307010507010807"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040805030307010507010807
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5yVEIACgkQrlYvE4MpobPnDgCeLJ+2tDou34px2EYbS46HyP5K
l40AoKyRBpUa64iE9VSJ+kdfx5PAsK7p
=zSIU
-----END PGP SIGNATURE-----

--------------040805030307010507010807
Content-Type: text/plain;
 name="0029-policycoreutils-restorecon-Always-check-return-code-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0029-policycoreutils-restorecon-Always-check-return-code-.pa";
 filename*1="tch"


--------------040805030307010507010807--

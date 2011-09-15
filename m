Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8FKLHBF024209
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 16:21:17 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p8FKLGt7011427
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 20:21:17 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p8FJIsqB007610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 15:18:54 -0400
Message-ID: <4E724F9D.1000107@redhat.com>
Date: Thu, 15 Sep 2011 15:18:53 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 67/67] libsemanage: fix semanage_store_access_check calling
Content-Type: multipart/mixed;
 boundary="------------000707040704060501000905"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000707040704060501000905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5yT50ACgkQrlYvE4MpobNnVACgyU2kqA3Tzl2yw+NDnGxCW65b
E6UAn0mOISwAq6JRxB7uqpR5kRCcNFpz
=/8tI
-----END PGP SIGNATURE-----

--------------000707040704060501000905
Content-Type: text/plain;
 name="0067-libsemanage-fix-semanage_store_access_check-calling-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0067-libsemanage-fix-semanage_store_access_check-calling-.pa";
 filename*1="tch"


--------------000707040704060501000905--

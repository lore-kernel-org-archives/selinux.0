Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7PKbjcu001697
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 16:37:45 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7PKbhp0002533
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 20:37:44 GMT
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7PKbhVF004564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 16:37:43 -0400
Message-ID: <4E56B296.3090303@redhat.com>
Date: Thu, 25 Aug 2011 16:37:42 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 42/77] policycoreutils: restorecon: Always check return code
Content-Type: multipart/mixed;
 boundary="------------080105030502000506090106"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080105030502000506090106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5WspYACgkQrlYvE4MpobNFCgCgvAPufQjW7RiDY5BTBvXUyzxs
1okAn2N4+Bs2pcxK6+fZYSYCqoDpTnvr
=r8jn
-----END PGP SIGNATURE-----

--------------080105030502000506090106
Content-Type: text/plain;
 name="0042-policycoreutils-restorecon-Always-check-return-code-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0042-policycoreutils-restorecon-Always-check-return-code-.pa";
 filename*1="tch"


--------------080105030502000506090106--

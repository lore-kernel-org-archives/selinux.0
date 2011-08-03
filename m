Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p73L3m3U009105
	for <selinux@tycho.nsa.gov>; Wed, 3 Aug 2011 17:03:48 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p73L3lv1023604
	for <selinux@tycho.nsa.gov>; Wed, 3 Aug 2011 21:03:47 GMT
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p73L3kCl023115
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 3 Aug 2011 17:03:46 -0400
Message-ID: <4E39B7B2.3040604@redhat.com>
Date: Wed, 03 Aug 2011 17:03:46 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 049/155] policycoreutils: semanage: verify ports < 65536
Content-Type: multipart/mixed;
 boundary="------------000602050305070005020004"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000602050305070005020004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk45t7EACgkQrlYvE4MpobOmtQCfdRTU8ZpxDTo8xdKozLfPF5RE
X5wAnRkNL5Pi+TYAH8eIk2IMbXfRgIRA
=7Eyb
-----END PGP SIGNATURE-----

--------------000602050305070005020004
Content-Type: text/plain;
 name="0049-policycoreutils-semanage-verify-ports-65536.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0049-policycoreutils-semanage-verify-ports-65536.patch"


--------------000602050305070005020004--

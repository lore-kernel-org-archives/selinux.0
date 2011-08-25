Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7PKn0kH002987
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 16:49:00 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7PKmwEJ005366
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 20:48:59 GMT
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7PKmw9r020104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 16:48:58 -0400
Message-ID: <4E56B539.8070803@redhat.com>
Date: Thu, 25 Aug 2011 16:48:57 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 65/77] policycoreutils: sandbox: trap sigterm to make sure
Content-Type: multipart/mixed;
 boundary="------------000409000003050003020004"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000409000003050003020004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5WtTkACgkQrlYvE4MpobOnzACfU3UZN1x4c5edKq2v/CheBgPc
Vd4An0xpWJG6zxPtLOpKadGB+/AV8mhz
=gG+X
-----END PGP SIGNATURE-----

--------------000409000003050003020004
Content-Type: text/plain;
 name="0065-policycoreutils-sandbox-trap-sigterm-to-make-sure-sa.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0065-policycoreutils-sandbox-trap-sigterm-to-make-sure-sa.pa";
 filename*1="tch"


--------------000409000003050003020004--

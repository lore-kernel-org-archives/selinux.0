Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7BEirgk001248
	for <selinux@tycho.nsa.gov>; Thu, 11 Aug 2011 10:44:53 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7BEipTk012345
	for <selinux@tycho.nsa.gov>; Thu, 11 Aug 2011 14:44:52 GMT
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7BEipM7001210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 11 Aug 2011 10:44:51 -0400
Message-ID: <4E43EAE1.4090308@redhat.com>
Date: Thu, 11 Aug 2011 10:44:49 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 43/96] policycoreutils: semanage: return sooner to save CPU
Content-Type: multipart/mixed;
 boundary="------------000306040004040809020003"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000306040004040809020003
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5D6uEACgkQrlYvE4MpobNikACghbO42W/s/61JdE6c2opgTtl0
eOMAoJacXCR0mfqhBHh+IDyRBmmGHDyg
=obRd
-----END PGP SIGNATURE-----

--------------000306040004040809020003
Content-Type: text/plain;
 name="0043-policycoreutils-semanage-return-sooner-to-save-CPU-t.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0043-policycoreutils-semanage-return-sooner-to-save-CPU-t.pa";
 filename*1="tch"


--------------000306040004040809020003--

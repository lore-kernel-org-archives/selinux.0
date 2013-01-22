Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MEnk74012893
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:49:46 -0500
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0MEnie4026464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:49:44 -0500
Message-ID: <50FEA707.8040508@redhat.com>
Date: Tue, 22 Jan 2013 09:49:43 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 44/84] libselinux: audit2why: do not leak on multiple init()
Content-Type: multipart/mixed;
 boundary="------------060506000808040601000704"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060506000808040601000704
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD+pwcACgkQrlYvE4MpobO59ACgyG+G5Hzb4m4yVgrK5CFDMko6
YGUAoLOV4Fu5a3pwDl/pToMWpAXTa264
=mN91
-----END PGP SIGNATURE-----

--------------060506000808040601000704
Content-Type: text/x-patch;
 name="0044-libselinux-audit2why-do-not-leak-on-multiple-init-ca.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0044-libselinux-audit2why-do-not-leak-on-multiple-init-ca.pa";
 filename*1="tch"


--------------060506000808040601000704--

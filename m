Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MEpYT4013372
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:51:34 -0500
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0MEpXsW031384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:51:33 -0500
Message-ID: <50FEA774.1010101@redhat.com>
Date: Tue, 22 Jan 2013 09:51:32 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 49/84] policycoreutils: semanage: Fix handling of boolean_sub
Content-Type: multipart/mixed;
 boundary="------------090807090806000801080108"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090807090806000801080108
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD+p3QACgkQrlYvE4MpobNBJQCghtBgyWIGeBRAs6I2yh+90T9d
XEIAn2SkJ3s/+jJGH6x4WhADdHCexwm4
=rnjh
-----END PGP SIGNATURE-----

--------------090807090806000801080108
Content-Type: text/x-patch;
 name="0049-policycoreutils-semanage-Fix-handling-of-boolean_sub.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0049-policycoreutils-semanage-Fix-handling-of-boolean_sub.pa";
 filename*1="tch"


--------------090807090806000801080108--

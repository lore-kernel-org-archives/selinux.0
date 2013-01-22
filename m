Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MEtjdQ014244
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:55:45 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0MEthWu002578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:55:43 -0500
Message-ID: <50FEA86E.2060109@redhat.com>
Date: Tue, 22 Jan 2013 09:55:42 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 65/84] libsemange: redo genhomedircon minuid
Content-Type: multipart/mixed;
 boundary="------------060903000207090408050306"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060903000207090408050306
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD+qG4ACgkQrlYvE4MpobOFdwCbBwhiA6yGJgmg0HWxXhQ449n5
QjIAnRockaqesiZD78vyzUDJzcS7sn0w
=WbvM
-----END PGP SIGNATURE-----

--------------060903000207090408050306
Content-Type: text/x-patch;
 name="0065-libsemange-redo-genhomedircon-minuid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0065-libsemange-redo-genhomedircon-minuid.patch"


--------------060903000207090408050306--

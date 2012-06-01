Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q51I51Pa009116
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 14:05:02 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q51I4toW008439
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 14:05:00 -0400
Message-ID: <4FC8FB24.1010001@redhat.com>
Date: Fri, 01 Jun 2012 13:25:56 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 70/90] Fix restorecon to return errors when bad paths are
Content-Type: multipart/mixed;
 boundary="------------060902060108060903000606"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060902060108060903000606
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/I+yQACgkQrlYvE4MpobNZ3QCeLvgI4rxT1IZMg34LoIK+xocj
B0wAn2ViHmI8qVYbRw7pIze1qXwUo1H9
=OJ+3
-----END PGP SIGNATURE-----

--------------060902060108060903000606
Content-Type: text/x-patch;
 name="0070-Fix-restorecon-to-return-errors-when-bad-paths-are-g.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0070-Fix-restorecon-to-return-errors-when-bad-paths-are-g.pa";
 filename*1="tch"


--------------060902060108060903000606--

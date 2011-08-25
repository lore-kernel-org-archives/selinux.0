Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7PJpakQ031433
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 15:51:36 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7PJpZKm021956
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 19:51:35 GMT
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7PJpYs9020905
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 15:51:35 -0400
Message-ID: <4E56A7C5.7050804@redhat.com>
Date: Thu, 25 Aug 2011 15:51:33 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 01/77] libselinux: python wrapper makefile changes
Content-Type: multipart/mixed;
 boundary="------------040904000608000509010508"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040904000608000509010508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.

This will allow you to build libsemanage with


make pywrap

or

make PYTHON=/usr/bin/python3 pywrap

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5Wp8UACgkQrlYvE4MpobOzKACgoCuQ+XGx2OabNuj24YgROr0Z
alAAnArB1cvKEOLp/hhpYOp40Y0UFfoh
=umm1
-----END PGP SIGNATURE-----

--------------040904000608000509010508
Content-Type: text/plain;
 name="0001-libselinux-python-wrapper-makefile-changes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-libselinux-python-wrapper-makefile-changes.patch"


--------------040904000608000509010508--

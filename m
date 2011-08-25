Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7PJu5qU031707
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 15:56:05 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7PJu4KV023343
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 19:56:04 GMT
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7PJu4Qn000463
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 15:56:04 -0400
Message-ID: <4E56A8D3.5030002@redhat.com>
Date: Thu, 25 Aug 2011 15:56:03 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 06/77] libsemanage: python wrapper makefile changes
Content-Type: multipart/mixed;
 boundary="------------010108080601090809010904"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010108080601090809010904
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.

Allow you to build with just

make pywrap

or

make PYTHON=/usr/bin/python3 pywrap
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5WqNMACgkQrlYvE4MpobPbdgCeN6l5jdZx4+S88V6+1JTMTF+h
kNYAoLKtXZw6h9zJJEFw0pmVl1AUV9Qz
=2Oab
-----END PGP SIGNATURE-----

--------------010108080601090809010904
Content-Type: text/plain;
 name="0006-libsemanage-python-wrapper-makefile-changes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0006-libsemanage-python-wrapper-makefile-changes.patch"


--------------010108080601090809010904--

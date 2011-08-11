Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7BELDQK031724
	for <selinux@tycho.nsa.gov>; Thu, 11 Aug 2011 10:21:19 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7BELICo008439
	for <selinux@tycho.nsa.gov>; Thu, 11 Aug 2011 14:21:18 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7BELILN025048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 11 Aug 2011 10:21:18 -0400
Message-ID: <4E43E55C.7080200@redhat.com>
Date: Thu, 11 Aug 2011 10:21:16 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 15/96] libsemanage: print error debug info for buggy fc files
Content-Type: multipart/mixed;
 boundary="------------090200060104010909070605"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090200060104010909070605
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.

Needed for debugging bugs in fc files.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5D5VwACgkQrlYvE4MpobPtwQCgvhJIPn24N7xxwxme15iaJ7q6
SicAoOcO9GzN9CXFEPeNNhsvsNFj15CY
=TjaP
-----END PGP SIGNATURE-----

--------------090200060104010909070605
Content-Type: text/plain;
 name="0015-libsemanage-print-error-debug-info-for-buggy-fc-file.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0015-libsemanage-print-error-debug-info-for-buggy-fc-file.pa";
 filename*1="tch"


--------------090200060104010909070605--

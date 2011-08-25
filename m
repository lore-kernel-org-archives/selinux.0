Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7PJrg2T031552
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 15:53:42 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7PJrfKV022888
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 19:53:41 GMT
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7PJrebT031562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 15:53:41 -0400
Message-ID: <4E56A844.2060705@redhat.com>
Date: Thu, 25 Aug 2011 15:53:40 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 02/77] libselinux: move realpath helper to matchpathcon
Content-Type: multipart/mixed;
 boundary="------------090301010409050304010501"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090301010409050304010501
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.

This bug helped cause us to slip Fedora 16, since Anaconda was using
matchpathcon("//lib64")

Since we have moved to file context subs for lib64 and /usr/lib64
matchpathcon needs to reapath input.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5WqEQACgkQrlYvE4MpobOobQCcDBqiWx7yickEY2YbGjoOr22W
yygAn1+n06fD1ADpQkp3Dn13YGkpCxQw
=g6IJ
-----END PGP SIGNATURE-----

--------------090301010409050304010501
Content-Type: text/plain;
 name="0002-libselinux-move-realpath-helper-to-matchpathcon-libr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-libselinux-move-realpath-helper-to-matchpathcon-libr.pa";
 filename*1="tch"


--------------090301010409050304010501--

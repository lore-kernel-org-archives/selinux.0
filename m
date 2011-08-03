Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p73KmXFk007304
	for <selinux@tycho.nsa.gov>; Wed, 3 Aug 2011 16:48:33 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p73KmVv1021108
	for <selinux@tycho.nsa.gov>; Wed, 3 Aug 2011 20:48:32 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p73KmVnG025690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 3 Aug 2011 16:48:31 -0400
Message-ID: <4E39B41E.8060801@redhat.com>
Date: Wed, 03 Aug 2011 16:48:30 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 006/155] libselinux: do not check fcontext duplicates on use
Content-Type: multipart/mixed;
 boundary="------------050301020404070409050302"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050301020404070409050302
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk45tB4ACgkQrlYvE4MpobNbVwCgpzlYBRsKdMJ2+MTRcR/JTEt4
VmIAoJjd8nTHf9WyoIJDrs61wl5XaWkM
=MfbT
-----END PGP SIGNATURE-----

--------------050301020404070409050302
Content-Type: text/plain;
 name="0006-libselinux-do-not-check-fcontext-duplicates-on-use.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0006-libselinux-do-not-check-fcontext-duplicates-on-use.patc";
 filename*1="h"


--------------050301020404070409050302--

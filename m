Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pA1Jmvhi031733
	for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2011 15:48:57 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id pA1JmuOe027973
	for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2011 19:48:56 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pA1JmuLP027449
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2011 15:48:56 -0400
Message-ID: <4EB04D27.1050904@redhat.com>
Date: Tue, 01 Nov 2011 15:48:55 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 58/63] libselinux: audit2why: close fd on enomem
Content-Type: multipart/mixed;
 boundary="------------090801050408070005000207"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090801050408070005000207
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6wTScACgkQrlYvE4MpobMPQgCgjyzjUcuKFuUpoo+mLMn9vUFH
UksAoJ0Ki8Fdj5AZ9Dg4aj60GXcVbiJR
=Xlmv
-----END PGP SIGNATURE-----

--------------090801050408070005000207
Content-Type: text/plain;
 name="0058-libselinux-audit2why-close-fd-on-enomem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0058-libselinux-audit2why-close-fd-on-enomem.patch"


--------------090801050408070005000207--

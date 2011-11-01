Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pA1Jopgq032015
	for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2011 15:50:52 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id pA1JopOe028433
	for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2011 19:50:51 GMT
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pA1JopIN028473
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2011 15:50:51 -0400
Message-ID: <4EB04D9A.4010806@redhat.com>
Date: Tue, 01 Nov 2011 15:50:50 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 42/63] policycoreutils: do not leak memory in restore
Content-Type: multipart/mixed;
 boundary="------------000707010707010502040204"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000707010707010502040204
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6wTZoACgkQrlYvE4MpobMqJQCeM0OyCipkgTjcZylEqP+PydGw
B+wAnjU5scJEUPQsqqFCcah9+uI19MdY
=V7hF
-----END PGP SIGNATURE-----

--------------000707010707010502040204
Content-Type: text/plain;
 name="0042-policycoreutils-do-not-leak-memory-in-restore.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0042-policycoreutils-do-not-leak-memory-in-restore.patch"


--------------000707010707010502040204--

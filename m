Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q51I5Yq6009208
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 14:05:34 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q51I5WNF023123
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 14:05:33 -0400
Message-ID: <4FC8FB35.9020004@redhat.com>
Date: Fri, 01 Jun 2012 13:26:13 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 71/90] asprintf return code must be checked
Content-Type: multipart/mixed;
 boundary="------------060709030904090402000605"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060709030904090402000605
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/I+zQACgkQrlYvE4MpobPSOACfZkEz4xM4K7E5r9r0NdVZkVrl
h20An3CQKqJe3EGHw/IjWRiCiKzTzis4
=m7em
-----END PGP SIGNATURE-----

--------------060709030904090402000605
Content-Type: text/x-patch;
 name="0071-asprintf-return-code-must-be-checked.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0071-asprintf-return-code-must-be-checked.patch"


--------------060709030904090402000605--

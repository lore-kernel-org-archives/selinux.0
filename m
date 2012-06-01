Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q51J4q0T014856
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 15:04:52 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q51J4oeS028429
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 15:04:51 -0400
Message-ID: <4FC91252.2010500@redhat.com>
Date: Fri, 01 Jun 2012 15:04:50 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 25/90] libselinux: Fix bug in hidden_def FIXME
Content-Type: multipart/mixed;
 boundary="------------010201090703000200030406"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010201090703000200030406
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

We used the wrong name for the function in the hidden_def call, this patch
fixes the name.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/JElIACgkQrlYvE4MpobMw7ACggh5d5xJIgJwLLOXlos8QrzGv
v4QAn2e0juy4ZIfDTR0OG5eqJBeeF24i
=40gU
-----END PGP SIGNATURE-----

--------------010201090703000200030406
Content-Type: text/x-patch;
 name="0025-libselinux-Fix-bug-in-hidden_def-FIXME.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0025-libselinux-Fix-bug-in-hidden_def-FIXME.patch"


--------------010201090703000200030406--

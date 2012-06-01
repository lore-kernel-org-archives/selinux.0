Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q51I51PY009116
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 14:05:01 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q51I4toU008439
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 14:04:59 -0400
Message-ID: <4FC8FB73.8050403@redhat.com>
Date: Fri, 01 Jun 2012 13:27:15 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 75/90] Fixfiles needs to tell restorecon to ignore missing
Content-Type: multipart/mixed;
 boundary="------------020902040403010003030702"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020902040403010003030702
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/I+3MACgkQrlYvE4MpobNNQACg6CXWgr8v1DY6kdMmJ3HCtnV1
7LsAnjmxrcah+2K+q9ozoBfvXtKCOJIl
=K61K
-----END PGP SIGNATURE-----

--------------020902040403010003030702
Content-Type: text/x-patch;
 name="0075-Fixfiles-needs-to-tell-restorecon-to-ignore-missing-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0075-Fixfiles-needs-to-tell-restorecon-to-ignore-missing-.pa";
 filename*1="tch"


--------------020902040403010003030702--

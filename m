Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RF5cTX024326
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:05:38 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q2RF5bPr026770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:05:37 -0400
Message-ID: <4F71D741.3060809@redhat.com>
Date: Tue, 27 Mar 2012 11:05:37 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 17/73] sepolgen: audit.py Dont crash if empty data is passed
Content-Type: multipart/mixed;
 boundary="------------090207090305020804040501"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090207090305020804040501
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.


If you pass output from a log file that does not include any avc's
audit2allow will crash.  This patch fixes this problem.

ausearch -m avc -ts recent | audit2allow

If there was no AVC's recently, we do not want the python to crash.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9x10EACgkQrlYvE4MpobNJqACgl9Iny1pmGGMKSypaCEJt320m
T5cAn3BwldGDPQ7Hpf9FWF/j1IbuIRkx
=NXL5
-----END PGP SIGNATURE-----

--------------090207090305020804040501
Content-Type: text/x-patch;
 name="0017-sepolgen-audit.py-Dont-crash-if-empty-data-is-passed.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0017-sepolgen-audit.py-Dont-crash-if-empty-data-is-passed.pa";
 filename*1="tch"


--------------090207090305020804040501--

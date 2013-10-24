Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OEwsAG031426
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:58:54 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OEwqah014600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:58:52 -0400
Message-ID: <526935AB.40908@redhat.com>
Date: Thu, 24 Oct 2013 10:58:51 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 50/74] Only list disabled modules if the user ask for
Content-Type: multipart/mixed;
 boundary="------------080105000503070403090807"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080105000503070403090807
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpNasACgkQrlYvE4MpobPriQCgvRroK9q4XtV16isW96I8EWtP
514AoIAmQgnCyT6tuDii0ONWvxqFe2Xq
=VURR
-----END PGP SIGNATURE-----

--------------080105000503070403090807
Content-Type: text/x-patch;
 name="0050-Only-list-disabled-modules-if-the-user-ask-for-local.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0050-Only-list-disabled-modules-if-the-user-ask-for-local.pa";
 filename*1="tch"


--------------080105000503070403090807--

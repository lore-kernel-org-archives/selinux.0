Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q51I7Os4009438
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 14:07:27 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q51I7KXO003725
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 14:07:23 -0400
Message-ID: <4FC8F841.9070203@redhat.com>
Date: Fri, 01 Jun 2012 13:13:37 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 28/90] policycoreutils: Make restorecon return 0 when a file
Content-Type: multipart/mixed;
 boundary="------------090007000904060207030301"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090007000904060207030301
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/I+EEACgkQrlYvE4MpobPwgwCgp0ym0Y+cTvqmyIbahDIn3vl/
PRAAn2PUn46PyJyEj+qhe0stomsyemxN
=E8cF
-----END PGP SIGNATURE-----

--------------090007000904060207030301
Content-Type: text/x-patch;
 name="0028-policycoreutils-Make-restorecon-return-0-when-a-file.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0028-policycoreutils-Make-restorecon-return-0-when-a-file.pa";
 filename*1="tch"


--------------090007000904060207030301--

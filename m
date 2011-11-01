Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pA1JpCGp032063
	for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2011 15:51:12 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id pA1JpAHs001788
	for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2011 19:51:11 GMT
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pA1JpA5H028570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2011 15:51:10 -0400
Message-ID: <4EB04DAD.1090903@redhat.com>
Date: Tue, 01 Nov 2011 15:51:09 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 43/63] policycoreutils: setfiles: close /proc/mounts file
Content-Type: multipart/mixed;
 boundary="------------090908010807090504070502"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090908010807090504070502
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6wTa0ACgkQrlYvE4MpobPKtwCfe4LhQOVD/KWKPCaJg2Bra/OW
Jv4An0oOS3RQNJvffP+LwuDLi+GNdrGn
=tGA0
-----END PGP SIGNATURE-----

--------------090908010807090504070502
Content-Type: text/plain;
 name="0043-policycoreutils-setfiles-close-proc-mounts-file-when.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0043-policycoreutils-setfiles-close-proc-mounts-file-when.pa";
 filename*1="tch"


--------------090908010807090504070502--

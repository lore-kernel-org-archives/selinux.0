Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RFhMeR028663
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:43:22 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q2RFhLWp012504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:43:21 -0400
Message-ID: <4F71E018.3080607@redhat.com>
Date: Tue, 27 Mar 2012 11:43:20 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 70/73] policycoreutils -- Only run setfiles if we found Only
 run setfiles if we found read-write filesystems to run it on
Content-Type: multipart/mixed;
 boundary="------------050900040101000504030702"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050900040101000504030702
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9x4BgACgkQrlYvE4MpobM5MACgpL4b1zAOeXUEaRlXrHYU9xMv
Ie4Anj6fcLr527A0AMEoVXs6yUkFiFbx
=LOaA
-----END PGP SIGNATURE-----

--------------050900040101000504030702
Content-Type: text/x-patch;
 name="0070-policycoreutils-Only-run-setfiles-if-we-found-read-w.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0070-policycoreutils-Only-run-setfiles-if-we-found-read-w.pa";
 filename*1="tch"


--------------050900040101000504030702--

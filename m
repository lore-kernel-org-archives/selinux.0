Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pBJLQiea026970
	for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2011 16:26:44 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id pBJLQX9S010876
	for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2011 21:26:43 GMT
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pBJLQWkb026926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2011 16:26:32 -0500
Message-ID: <4EEFAC08.90708@redhat.com>
Date: Mon, 19 Dec 2011 16:26:32 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 14/25] policycoreutils: sandbox: FIXME Add back in .
Content-Type: multipart/mixed;
 boundary="------------060501050906060406010808"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060501050906060406010808
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

In order to handle properly the display on boot the sandbox init
script has to source the functions file.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7vrAgACgkQrlYvE4MpobNUvACeIgvywd0Coty4TqjbL4Nh6229
Vs8AnjNPWGU549YreEDNTzU96mtUmKFK
=KHfr
-----END PGP SIGNATURE-----

--------------060501050906060406010808
Content-Type: text/plain;
 name="0014-policycoreutils-sandbox-FIXME-Add-back-in-.-function.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0014-policycoreutils-sandbox-FIXME-Add-back-in-.-function.pa";
 filename*1="tch"


--------------060501050906060406010808--

Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OEG4Js027332
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:16:04 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OEG1dK014150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:16:01 -0400
Message-ID: <52692BA0.8060000@redhat.com>
Date: Thu, 24 Oct 2013 10:16:00 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 30/74] Handle audit2allow and audit2why with the same
Content-Type: multipart/mixed;
 boundary="------------090105000301080708040807"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090105000301080708040807
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch makes audit2allow and audit2why the same executable rather then
shipping a script for audit2why.

   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpK6AACgkQrlYvE4MpobP0PgCgu0DHfFJAlFHAsaX2jwm3bp4s
Fu4Anirsw1VbNIVplyA1e15U/QZRq/dh
=f6/M
-----END PGP SIGNATURE-----

--------------090105000301080708040807
Content-Type: text/x-patch;
 name="0030-Handle-audit2allow-and-audit2why-with-the-same-execu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0030-Handle-audit2allow-and-audit2why-with-the-same-execu.pa";
 filename*1="tch"


--------------090105000301080708040807--

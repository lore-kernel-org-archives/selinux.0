Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RFf5J3028411
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:41:06 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q2RFf4Aj006296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:41:05 -0400
Message-ID: <4F71DF90.3000601@redhat.com>
Date: Tue, 27 Mar 2012 11:41:04 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 67/73] policycoreutils -- fix ftbfs with hardening flags fix
 ftbfs with hardening flags
Content-Type: multipart/mixed;
 boundary="------------090504070000030509050105"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090504070000030509050105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9x35AACgkQrlYvE4MpobNXGQCdFi6vWHoo+cQRVVVr3b1h0cdg
ux4Anixs2AoSXDxZhsYpW37K+FrhfprV
=IBlq
-----END PGP SIGNATURE-----

--------------090504070000030509050105
Content-Type: text/x-patch;
 name="0067-policycoreutils-fix-ftbfs-with-hardening-flags.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0067-policycoreutils-fix-ftbfs-with-hardening-flags.patch"


--------------090504070000030509050105--

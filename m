Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OF6KXl032736
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:06:20 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OF6IWP015574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:06:18 -0400
Message-ID: <52693769.4070707@redhat.com>
Date: Thu, 24 Oct 2013 11:06:17 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 64/74] Fix error when policy does not match the system.
Content-Type: multipart/mixed;
 boundary="------------030105080802010102090701"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030105080802010102090701
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpN2kACgkQrlYvE4MpobNvUwCeIny+stGme6c9j78MYVpCeCej
z6UAn0fs9zonBY4nLzs56+c575g/FDgp
=aXRf
-----END PGP SIGNATURE-----

--------------030105080802010102090701
Content-Type: text/x-patch;
 name="0064-Fix-error-when-policy-does-not-match-the-system.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0064-Fix-error-when-policy-does-not-match-the-system.patch"


--------------030105080802010102090701--

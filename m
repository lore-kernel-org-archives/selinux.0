Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MF0vSH015806
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 10:00:57 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0MF0lRO003104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 10:00:53 -0500
Message-ID: <50FEA997.9070509@redhat.com>
Date: Tue, 22 Jan 2013 10:00:39 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 83/84] sepolgen: understand role attributes
Content-Type: multipart/mixed;
 boundary="------------080404010908010108030606"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080404010908010108030606
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD+qZcACgkQrlYvE4MpobPdUgCfbrKolS3XRNBoraZ8Ga4CIgmU
Di8An1IJbiGLLki4ZQYViMlVi3K+X3Zh
=FEfg
-----END PGP SIGNATURE-----

--------------080404010908010108030606
Content-Type: text/x-patch;
 name="0083-sepolgen-understand-role-attributes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0083-sepolgen-understand-role-attributes.patch"


--------------080404010908010108030606--

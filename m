Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MEwdBd015010
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:58:39 -0500
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0MEwbU7007732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:58:37 -0500
Message-ID: <50FEA91C.6090003@redhat.com>
Date: Tue, 22 Jan 2013 09:58:36 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 76/84] libsepol: constraint queue overflow
Content-Type: multipart/mixed;
 boundary="------------010207090306090103040508"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010207090306090103040508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEUEARECAAYFAlD+qRsACgkQrlYvE4MpobNAJQCfXxdwKy8Ljd261gCf71EkwDJ2
iMIAl1vZLP7tZJcsuAg+13Dwg8u/h8s=
=vMA2
-----END PGP SIGNATURE-----

--------------010207090306090103040508
Content-Type: text/x-patch;
 name="0076-libsepol-constraint-queue-overflow.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0076-libsepol-constraint-queue-overflow.patch"


--------------010207090306090103040508--

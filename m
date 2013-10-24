Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OF5Y9m032642
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:05:34 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OF5WZ8017792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:05:32 -0400
Message-ID: <5269373C.4080408@redhat.com>
Date: Thu, 24 Oct 2013 11:05:32 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 62/74] Return the type aliases.
Content-Type: multipart/mixed;
 boundary="------------050602090407070300080504"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050602090407070300080504
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

We want to extract alias data via sepolicy commands.

   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpNzwACgkQrlYvE4MpobODsACg6N54j4yxszPdVWhK7euHOPku
z24An0SAr5e67nuHjszImE18WfXUpMI2
=EpcB
-----END PGP SIGNATURE-----

--------------050602090407070300080504
Content-Type: text/x-patch;
 name="0062-Return-the-type-aliases.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0062-Return-the-type-aliases.patch"


--------------050602090407070300080504--

Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9SJim1V012956
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2013 15:44:48 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9SJijKn018096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2013 15:44:46 -0400
Message-ID: <526EBEAB.9010200@redhat.com>
Date: Mon, 28 Oct 2013 15:44:43 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 03/17] Make sure userdel cleans up after itself in test
Content-Type: multipart/mixed;
 boundary="------------030609040805060700010506"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030609040805060700010506
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

usedel in the semanage test suite was not cleaning up the directory.
   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJuvqsACgkQrlYvE4MpobPdggCeORQCfWVa/1WDNso/TmSZCbBU
Vs4AmwX7JQefy3efJjpu9620quI+quE+
=Lky2
-----END PGP SIGNATURE-----

--------------030609040805060700010506
Content-Type: text/x-patch;
 name="0003-Make-sure-userdel-cleans-up-after-itself-in-test.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0003-Make-sure-userdel-cleans-up-after-itself-in-test.patch"


--------------030609040805060700010506--

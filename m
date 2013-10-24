Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OENP2U028282
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:23:25 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OENOgL018097
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:23:24 -0400
Message-ID: <52692D5B.8090706@redhat.com>
Date: Thu, 24 Oct 2013 10:23:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 36/74] Handle cleanup of locks properly
Content-Type: multipart/mixed;
 boundary="------------000205040605050606070104"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000205040605050606070104
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

restorecond has a leak which this patch fixes.
   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpLVsACgkQrlYvE4MpobMgqQCfTl70Fex73ucohJBQokMvKaZP
aV8AoM4Cu3rCbvbyKVArZBWJM+j1Qoqu
=5CDU
-----END PGP SIGNATURE-----

--------------000205040605050606070104
Content-Type: text/x-patch;
 name="0036-Handle-cleanup-of-locks-properly.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0036-Handle-cleanup-of-locks-properly.patch"


--------------000205040605050606070104--

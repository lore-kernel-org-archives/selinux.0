Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9ODkJB1023490
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:46:19 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9ODkH8I004787
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:46:17 -0400
Message-ID: <526924A7.4040902@redhat.com>
Date: Thu, 24 Oct 2013 09:46:15 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 07/74] Add selinux_set_policy_root sets an alternate policy
Content-Type: multipart/mixed;
 boundary="------------060801080503040006050203"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060801080503040006050203
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Need to specify alternate root for SELinux policy so other tools can generate
information and might be good for testing.


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpJKcACgkQrlYvE4MpobP4QACg5TDj/ZyRdwKgR/q0JIaHvb7f
cMgAoLVpyYH6QOvhtg+lk4YE4SNFi6OU
=5ymd
-----END PGP SIGNATURE-----

--------------060801080503040006050203
Content-Type: text/x-patch;
 name="0007-Add-selinux_set_policy_root-sets-an-alternate-policy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0007-Add-selinux_set_policy_root-sets-an-alternate-policy.pa";
 filename*1="tch"


--------------060801080503040006050203--

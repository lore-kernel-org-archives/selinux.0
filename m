Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MEvJWX014609
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:57:19 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0MEvHpO007296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:57:17 -0500
Message-ID: <50FEA8CC.1090102@redhat.com>
Date: Tue, 22 Jan 2013 09:57:16 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 71/84] libselinux: Fix errors found by coverity
Content-Type: multipart/mixed;
 boundary="------------040109010605080601040501"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040109010605080601040501
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD+qMwACgkQrlYvE4MpobMp3ACg4O8sSfQFrdQQB2G05rkCoEv3
zJ8An1Pd9poUBbguOOYoNBlydf/XSqTk
=9X+a
-----END PGP SIGNATURE-----

--------------040109010605080601040501
Content-Type: text/x-patch;
 name="0071-libselinux-Fix-errors-found-by-coverity.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0071-libselinux-Fix-errors-found-by-coverity.patch"


--------------040109010605080601040501--

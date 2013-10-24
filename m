Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OF18fY032026
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:01:08 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OF169v023294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:01:06 -0400
Message-ID: <52693631.4060804@redhat.com>
Date: Thu, 24 Oct 2013 11:01:05 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 53/74] Return the level when looking at the customized changes
Content-Type: multipart/mixed;
 boundary="------------040003060704040603060503"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040003060704040603060503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

semanage user -l -C was not reporting initial level which we want to capture
in extract.

   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpNjEACgkQrlYvE4MpobOHPQCffycM9PLrK9760+Ces2m7Wxgw
GsAAoN2OC47v2JAolIVVFeaopSxFlYvY
=n2vW
-----END PGP SIGNATURE-----

--------------040003060704040603060503
Content-Type: text/x-patch;
 name="0053-Return-the-level-when-looking-at-the-customized-chan.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0053-Return-the-level-when-looking-at-the-customized-chan.pa";
 filename*1="tch"


--------------040003060704040603060503--

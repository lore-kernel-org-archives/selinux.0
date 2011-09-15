Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8FK3HPr022666
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 16:03:17 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8FK3GHA021494
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 20:03:16 GMT
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p8FK3FAo023341
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 16:03:15 -0400
Message-ID: <4E725A02.30504@redhat.com>
Date: Thu, 15 Sep 2011 16:03:14 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 58/67] policycoreutils: semanage: FIXME If you do a semanage
Content-Type: multipart/mixed;
 boundary="------------030102000205060903010506"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030102000205060903010506
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.

The previous patch gave the wrong args.  Verified in RHEL6 testing.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5yWgIACgkQrlYvE4MpobPC+wCgtzLap8APd5Sqkjk88TCDcUeB
yfEAoJPRQOWjUlzhY8w+WAeD/+RlkXlz
=0hd+
-----END PGP SIGNATURE-----

--------------030102000205060903010506
Content-Type: text/plain;
 name="0058-policycoreutils-semanage-FIXME-If-you-do-a-semanage-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0058-policycoreutils-semanage-FIXME-If-you-do-a-semanage-.pa";
 filename*1="tch"


--------------030102000205060903010506--

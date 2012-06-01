Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q51J28Z5014435
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 15:02:08 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q51J27Ar020258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 15:02:07 -0400
Message-ID: <4FC911AE.3030608@redhat.com>
Date: Fri, 01 Jun 2012 15:02:06 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 16/90] policycoreutils: mcstransd: write a pid file FIXME
Content-Type: multipart/mixed;
 boundary="------------090600070803000805070300"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090600070803000805070300
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Should be revoked, first time we ran within systemd we needed a pid file to
run properly, but adding the -f patch allows us to run mcstransd without
forking, and systemd can handle this.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/JEa4ACgkQrlYvE4MpobOPpACgtl2VlqjHBroa6NXPAzXsM7nt
tgQAn267F2KS4+SejwoWPNoLYvq9MsvP
=1WTz
-----END PGP SIGNATURE-----

--------------090600070803000805070300
Content-Type: text/x-patch;
 name="0016-policycoreutils-mcstransd-write-a-pid-file-FIXME.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0016-policycoreutils-mcstransd-write-a-pid-file-FIXME.patch"


--------------090600070803000805070300--

Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q51J0L3I014097
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 15:00:25 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q51J0N5w020771
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 15:00:23 -0400
Message-ID: <4FC91147.7030905@redhat.com>
Date: Fri, 01 Jun 2012 15:00:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 11/90] policycoreutils: FIXME Change restorecon to just
Content-Type: multipart/mixed;
 boundary="------------000803000907030400030905"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000803000907030400030905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

This patch allows us to use restorecon on MCS Separated File Systems or MLS
Environments,  Basically allows a user to check his type enforcement.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/JEUcACgkQrlYvE4MpobPhaQCgpoKqgm3A5xB4kFqhNfejVZA5
t3cAnRkRptde8RvdrgKu4Sx7v/4D6o9l
=gm1n
-----END PGP SIGNATURE-----

--------------000803000907030400030905
Content-Type: text/x-patch;
 name="0011-policycoreutils-FIXME-Change-restorecon-to-just-chan.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0011-policycoreutils-FIXME-Change-restorecon-to-just-chan.pa";
 filename*1="tch"


--------------000803000907030400030905--

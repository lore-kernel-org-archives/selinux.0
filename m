Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OF1wkD032167
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:01:58 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OF1tQk007157
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:01:55 -0400
Message-ID: <52693662.2040108@redhat.com>
Date: Thu, 24 Oct 2013 11:01:54 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 55/74] Make sure file equivalance target and source do not
 end
Content-Type: multipart/mixed;
 boundary="------------030701000305060903030208"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030701000305060903030208
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Do error checking on equivalence that end in "/"
   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpNmIACgkQrlYvE4MpobPAUACfUortCjaWusvEwbvUQWLsiw5v
Ri0AnirAgfmXOIg0/addE3/xw1JVmG7u
=/KAj
-----END PGP SIGNATURE-----

--------------030701000305060903030208
Content-Type: text/x-patch;
 name="0055-Make-sure-file-equivalance-target-and-source-do-not-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0055-Make-sure-file-equivalance-target-and-source-do-not-.pa";
 filename*1="tch"


--------------030701000305060903030208--

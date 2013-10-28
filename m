Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9SJkZlC013117
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2013 15:46:35 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9SJkWV6019267
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2013 15:46:32 -0400
Message-ID: <526EBF17.1030500@redhat.com>
Date: Mon, 28 Oct 2013 15:46:31 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 04/17] libsepol: V1 Allow constraint denials to be determined.
Content-Type: multipart/mixed;
 boundary="------------090804060404060605060107"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090804060404060605060107
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Updated patch from Richard Haines with changes suggest by Stephen Smalley. I
also broke the other fixes to libselinux, sepolgen and audit2allow into
separate patches.
   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJuvxcACgkQrlYvE4MpobNO/QCfdAx+OyMSgt/OV9cYtfA9oQY6
t/IAn2c7MZbi2P9Kt063X31XdLU6Onxn
=wMCC
-----END PGP SIGNATURE-----

--------------090804060404060605060107
Content-Type: text/x-patch;
 name="0004-libsepol-V1-Allow-constraint-denials-to-be-determine.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0004-libsepol-V1-Allow-constraint-denials-to-be-determine.pa";
 filename*1="tch"


--------------090804060404060605060107--

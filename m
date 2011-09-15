Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8FK0OqF022184
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 16:00:24 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8FK0NHA020908
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 20:00:23 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p8FK0Nex011985
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 16:00:23 -0400
Message-ID: <4E725955.1060009@redhat.com>
Date: Thu, 15 Sep 2011 16:00:21 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 54/67] policycoreutils: semanage: FIXME: Dont print heading
Content-Type: multipart/mixed;
 boundary="------------070707070600020105080506"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070707070600020105080506
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.

If you tell semanage to list the contents of an object and the list is
empty, we should not print the header.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5yWVUACgkQrlYvE4MpobO7xACfc6CoyyNxGsDOSxebO4MnpkGr
0w8AnAzaEkRV2731Myu0Lg7Q4zpSgr/A
=acAj
-----END PGP SIGNATURE-----

--------------070707070600020105080506
Content-Type: text/plain;
 name="0054-policycoreutils-semanage-FIXME-Dont-print-heading-if.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0054-policycoreutils-semanage-FIXME-Dont-print-heading-if.pa";
 filename*1="tch"


--------------070707070600020105080506--

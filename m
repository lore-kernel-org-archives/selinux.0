Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MExum7015317
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 10:00:00 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0MExw87008281
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:59:58 -0500
Message-ID: <50FEA96D.9010106@redhat.com>
Date: Tue, 22 Jan 2013 09:59:57 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 81/84] sepolgen: Use refpolicy_makefile() instead of
Content-Type: multipart/mixed;
 boundary="------------080205020305020809000205"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080205020305020809000205
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD+qW0ACgkQrlYvE4MpobMppgCgllokC9JlKMIIVi268GpNOMwQ
tMYAoIlt0xy6uKJVCGXRub0F8NBN6Wzj
=eRTo
-----END PGP SIGNATURE-----

--------------080205020305020809000205
Content-Type: text/x-patch;
 name="0081-sepolgen-Use-refpolicy_makefile-instead-of-hardcodin.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0081-sepolgen-Use-refpolicy_makefile-instead-of-hardcodin.pa";
 filename*1="tch"


--------------080205020305020809000205--

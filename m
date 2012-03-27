Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RFnH3j029150
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:49:23 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q2RFnMbP015140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:49:22 -0400
Message-ID: <4F71E181.80300@redhat.com>
Date: Tue, 27 Mar 2012 11:49:21 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 41/73] policycoreutils: mcstransd: write a pid file FIXME
Content-Type: multipart/mixed;
 boundary="------------070305050706000803070906"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070305050706000803070906
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

systemd expects a pid file to be written by unit services.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9x4YEACgkQrlYvE4MpobPLGwCgverG61aQYgrYV3P5BCISw+QO
ZP4An3ahmMsngAp0CxVDDbIirCGdLdzY
=wQig
-----END PGP SIGNATURE-----

--------------070305050706000803070906
Content-Type: text/x-patch;
 name="0041-policycoreutils-mcstransd-write-a-pid-file-FIXME.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0041-policycoreutils-mcstransd-write-a-pid-file-FIXME.patch"


--------------070305050706000803070906--

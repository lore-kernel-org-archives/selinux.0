Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9ODkqEJ023564
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:46:52 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9ODkou5004955
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:46:50 -0400
Message-ID: <526924C9.8070001@redhat.com>
Date: Thu, 24 Oct 2013 09:46:49 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 08/74] Add selinux_systemd_contexts_path
Content-Type: multipart/mixed;
 boundary="------------050309020504080402050506"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050309020504080402050506
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Systemd needs some default contexts specified.

   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpJMkACgkQrlYvE4MpobNOIgCgqVRbslYSW4sLMWaWCjdmLyf0
yREAoKzIEcASqCnMsEBzymdcD2KaZ2kF
=a2TL
-----END PGP SIGNATURE-----

--------------050309020504080402050506
Content-Type: text/x-patch;
 name="0008-Add-selinux_systemd_contexts_path.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0008-Add-selinux_systemd_contexts_path.patch"


--------------050309020504080402050506--

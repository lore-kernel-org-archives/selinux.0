Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9SJnAgL013395
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2013 15:49:11 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9SJn8rD020610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2013 15:49:08 -0400
Message-ID: <526EBFB3.3070200@redhat.com>
Date: Mon, 28 Oct 2013 15:49:07 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 05/17] Change audit2why to return constraint information on
Content-Type: multipart/mixed;
 boundary="------------010609010408000409060300"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010609010408000409060300
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Patch to retrieve constraint information from libsepol into audit2why
   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJuv7MACgkQrlYvE4MpobMuqgCdESvYlp8B3ao+UlK9/8SU8ID7
uJIAnRCl2oij+YAUHQtF52dmlWxbaKd3
=W/Vc
-----END PGP SIGNATURE-----

--------------010609010408000409060300
Content-Type: text/x-patch;
 name="0005-Change-audit2why-to-return-constraint-information-on.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0005-Change-audit2why-to-return-constraint-information-on.pa";
 filename*1="tch"


--------------010609010408000409060300--

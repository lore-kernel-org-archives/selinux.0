Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OEBu4e027070
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:11:56 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OEBs7q022974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:11:55 -0400
Message-ID: <52692AAA.5010003@redhat.com>
Date: Thu, 24 Oct 2013 10:11:54 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 28/74] Need to set the locale to current locale
Content-Type: multipart/mixed;
 boundary="------------050807060307010904060406"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050807060307010904060406
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Python requires code to set the locale variable.

   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpKqoACgkQrlYvE4MpobNGyQCfaIAVs8121uD9Y0y4OwMtk0kO
+EQAn2rI4fJBD52IL5fWrC3HijUMXh1h
=o1Fh
-----END PGP SIGNATURE-----

--------------050807060307010904060406
Content-Type: text/x-patch;
 name="0028-Need-to-set-the-locale-to-current-locale.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0028-Need-to-set-the-locale-to-current-locale.patch"


--------------050807060307010904060406--

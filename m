Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q51I9x8W010372
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 14:10:00 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q51I9r1c004559
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 14:09:57 -0400
Message-ID: <4FC8FCB3.5000707@redhat.com>
Date: Fri, 01 Jun 2012 13:32:35 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 89/90] libselinux: libsemanage: do not set soname needlessly
Content-Type: multipart/mixed;
 boundary="------------090404080208070706090406"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090404080208070706090406
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/I/LMACgkQrlYvE4MpobPIHQCgx3oOeOmfDeovNMQGZnUcsfLg
3YcAoJdHqjczg/cjXqzTWg4D7MQ+0PAX
=Pc6O
-----END PGP SIGNATURE-----

--------------090404080208070706090406
Content-Type: text/x-patch;
 name="0089-libselinux-libsemanage-do-not-set-soname-needlessly.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0089-libselinux-libsemanage-do-not-set-soname-needlessly.pat";
 filename*1="ch"


--------------090404080208070706090406--

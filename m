Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9PJiHl2005457
	for <selinux@tycho.nsa.gov>; Fri, 25 Oct 2013 15:44:17 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9PJiD4s027114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 25 Oct 2013 15:44:14 -0400
Message-ID: <526ACA09.6080505@redhat.com>
Date: Fri, 25 Oct 2013 15:44:09 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: Michal Trunecka patch to allow restorecon to accept {}
Content-Type: multipart/mixed;
 boundary="------------090007000207080104010209"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090007000207080104010209
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJqygkACgkQrlYvE4MpobMaUACeO27DcUNzft1wOIcxQZ0L8O09
M5gAoLMadAN6eQ2kSnhlJVaKVPRdczTN
=jDWw
-----END PGP SIGNATURE-----

--------------090007000207080104010209
Content-Type: text/x-patch;
 name="0006-Michal-Trunecka-patch-to-allow-restorecon-to-accept-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0006-Michal-Trunecka-patch-to-allow-restorecon-to-accept-.pa";
 filename*1="tch"


--------------090007000207080104010209--

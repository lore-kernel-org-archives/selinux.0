Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9ODutWn024658
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:56:55 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9ODuqkq009466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:56:53 -0400
Message-ID: <52692723.1080508@redhat.com>
Date: Thu, 24 Oct 2013 09:56:51 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 16/74] Fix label substituion to work with the equiv path of
Content-Type: multipart/mixed;
 boundary="------------080000080104000804060104"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080000080104000804060104
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

File equivalance was not being handled correctly if the equivalence was to /

   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpJyMACgkQrlYvE4MpobPKAQCfZe5FNcG0h/VJ3Jn3AHIKMjAJ
iOgAoM4qXXnTQSClash12LvNwPV4mJjI
=9Bhr
-----END PGP SIGNATURE-----

--------------080000080104000804060104
Content-Type: text/x-patch;
 name="0016-Fix-label-substituion-to-work-with-the-equiv-path-of.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0016-Fix-label-substituion-to-work-with-the-equiv-path-of.pa";
 filename*1="tch"


--------------080000080104000804060104--

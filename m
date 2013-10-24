Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9ODxgs7024935
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:59:42 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9ODxE1n015909
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:59:14 -0400
Message-ID: <526927B1.4030404@redhat.com>
Date: Thu, 24 Oct 2013 09:59:13 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 19/74] Fix handling of temporary file in sefcontext_compile.c
Content-Type: multipart/mixed;
 boundary="------------040504080806020909010907"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040504080806020909010907
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

We had a potential race condition when handling sefcontext_compiled content.
   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpJ7EACgkQrlYvE4MpobNCmQCdHZh0LoPrShRFQRhD2XHkviUu
bfQAoIxMzz8XjwlX7QM3Zh3x+dMXxUWO
=bnTv
-----END PGP SIGNATURE-----

--------------040504080806020909010907
Content-Type: text/x-patch;
 name="0019-Fix-handling-of-temporary-file-in-sefcontext_compile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0019-Fix-handling-of-temporary-file-in-sefcontext_compile.pa";
 filename*1="tch"


--------------040504080806020909010907--

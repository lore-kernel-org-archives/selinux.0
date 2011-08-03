Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p73L165I008823
	for <selinux@tycho.nsa.gov>; Wed, 3 Aug 2011 17:01:07 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p73L15v1022915
	for <selinux@tycho.nsa.gov>; Wed, 3 Aug 2011 21:01:06 GMT
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p73L15Js022587
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 3 Aug 2011 17:01:05 -0400
Message-ID: <4E39B710.3090709@redhat.com>
Date: Wed, 03 Aug 2011 17:01:04 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 040/155] policycoreutils: setfiles: use glob to handle ~ and
Content-Type: multipart/mixed;
 boundary="------------080405090905050103090409"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080405090905050103090409
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk45txAACgkQrlYvE4MpobPoRQCfWj1Hhlo6FDfxUmmq+iLj+kam
eDQAoOXFBcvkKG/5HmHpyoCYqQ5TJSbt
=qNvE
-----END PGP SIGNATURE-----

--------------080405090905050103090409
Content-Type: text/plain;
 name="0040-policycoreutils-setfiles-use-glob-to-handle-and-.-in.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0040-policycoreutils-setfiles-use-glob-to-handle-and-.-in.pa";
 filename*1="tch"


--------------080405090905050103090409--

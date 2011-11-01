Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pA1L3i18003882
	for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2011 17:03:44 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id pA1L3ggV013728
	for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2011 21:03:43 GMT
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pA1L3g6S017594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2011 17:03:42 -0400
Message-ID: <4EB05EAC.7000706@redhat.com>
Date: Tue, 01 Nov 2011 17:03:40 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 16/63] policycoreutils: semanage: FIXME set modified
Content-Type: multipart/mixed;
 boundary="------------030109090007040107070102"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030109090007040107070102
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

Yes I think I was trying to allow an admin to set a bunch of booleans
from a file, but I later added -i and -o options, which would seem to
be a better way to handle many changes at once.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6wXqwACgkQrlYvE4MpobNyRACfb3ESarN5v0vd83ZG541Cldco
ZtsAoLHzzGe6nePvFFESJMJprjbmzAdC
=bEOJ
-----END PGP SIGNATURE-----

--------------030109090007040107070102
Content-Type: text/plain;
 name="0016-policycoreutils-semanage-FIXME-set-modified-correctl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0016-policycoreutils-semanage-FIXME-set-modified-correctl.pa";
 filename*1="tch"


--------------030109090007040107070102--

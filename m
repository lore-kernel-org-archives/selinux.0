Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7BEaUfb000465
	for <selinux@tycho.nsa.gov>; Thu, 11 Aug 2011 10:36:30 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7BEaTCo011985
	for <selinux@tycho.nsa.gov>; Thu, 11 Aug 2011 14:36:29 GMT
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7BEaTCS030868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 11 Aug 2011 10:36:29 -0400
Message-ID: <4E43E8EB.3020802@redhat.com>
Date: Thu, 11 Aug 2011 10:36:27 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 28/96] policycoreutils: setfiles: use glob to handle ~ and
 .
Content-Type: multipart/mixed;
 boundary="------------080408040403010305080006"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080408040403010305080006
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5D6OsACgkQrlYvE4MpobNjVACgxTutXesruAIl55/JesILZQc3
eG4AoMm0TYw4uH3ozJXZWrUsM+yNb1Y7
=U9vp
-----END PGP SIGNATURE-----

--------------080408040403010305080006
Content-Type: text/plain;
 name="0028-policycoreutils-setfiles-use-glob-to-handle-and-.-in.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0028-policycoreutils-setfiles-use-glob-to-handle-and-.-in.pa";
 filename*1="tch"


--------------080408040403010305080006--

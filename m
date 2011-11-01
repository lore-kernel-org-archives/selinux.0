Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pA1Jkfrm031495
	for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2011 15:46:45 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id pA1JkiHs000948
	for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2011 19:46:44 GMT
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pA1JkiRY029253
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2011 15:46:44 -0400
Message-ID: <4EB04CA3.3000801@redhat.com>
Date: Tue, 01 Nov 2011 15:46:43 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 52/63] libselinux: maintain mode even if umask is tighter
Content-Type: multipart/mixed;
 boundary="------------070504010603060502050503"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070504010603060502050503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6wTKMACgkQrlYvE4MpobPpWgCgnI66Ll1IyYpHiCZPXjU21SyE
L/QAoM4IhpyH+mdtaBGwBMRDalceaJvT
=ERJ9
-----END PGP SIGNATURE-----

--------------070504010603060502050503
Content-Type: text/plain;
 name="0052-libselinux-maintain-mode-even-if-umask-is-tighter.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0052-libselinux-maintain-mode-even-if-umask-is-tighter.patch"


--------------070504010603060502050503--

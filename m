Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pA1JnI6M031791
	for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2011 15:49:18 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id pA1JnHOe028074
	for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2011 19:49:17 GMT
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pA1JnHCx027543
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2011 15:49:17 -0400
Message-ID: <4EB04D3C.40100@redhat.com>
Date: Tue, 01 Nov 2011 15:49:16 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 59/63] policycoreutils: setfiles: fix use before initialized
Content-Type: multipart/mixed;
 boundary="------------000706090308080307010702"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000706090308080307010702
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6wTTwACgkQrlYvE4MpobOHkACgzA83IE7Rd2jGbe39XK8jAzFy
R9EAoJex9vXf9gO7PD2BQ+qPlRAtxXcg
=K6t+
-----END PGP SIGNATURE-----

--------------000706090308080307010702
Content-Type: text/plain;
 name="0059-policycoreutils-setfiles-fix-use-before-initialized.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0059-policycoreutils-setfiles-fix-use-before-initialized.pat";
 filename*1="ch"


--------------000706090308080307010702--

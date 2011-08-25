Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7PKenVm002020
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 16:40:49 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7PKemp0003153
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 20:40:48 GMT
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7PKemNX005999
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 16:40:48 -0400
Message-ID: <4E56B34F.1080503@redhat.com>
Date: Thu, 25 Aug 2011 16:40:47 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 48/77] policycoreutils: sandbox: check for paths up front
Content-Type: multipart/mixed;
 boundary="------------080101010406030003060203"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080101010406030003060203
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.

Need this so that we can ship sandbox command without X.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5Ws08ACgkQrlYvE4MpobPkegCeNlt2z/dSuRDDiOffwmUORHk0
IfcAoIQadmmT+x4fCNet2n5+28J+l1zT
=EWyr
-----END PGP SIGNATURE-----

--------------080101010406030003060203
Content-Type: text/plain;
 name="0048-policycoreutils-sandbox-check-for-paths-up-front.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0048-policycoreutils-sandbox-check-for-paths-up-front.patch"


--------------080101010406030003060203--

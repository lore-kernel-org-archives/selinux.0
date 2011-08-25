Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7PKiHOc002361
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 16:44:17 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7PKiFEJ004591
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 20:44:16 GMT
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7PKiFMd026076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 16:44:15 -0400
Message-ID: <4E56B41E.9050601@redhat.com>
Date: Thu, 25 Aug 2011 16:44:14 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 54/77] policycoreutils: sandbox: use dbus-launch
Content-Type: multipart/mixed;
 boundary="------------080608040205080600070908"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080608040205080600070908
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.


This allows us to cleanup better.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5WtB4ACgkQrlYvE4MpobPe8ACgkxpLo0vJE0OC1Qrra90Z1v5A
Py4AoLc3MQsQ7SOz1LuZ06cMPTnCLEuE
=SB5t
-----END PGP SIGNATURE-----

--------------080608040205080600070908
Content-Type: text/plain;
 name="0054-policycoreutils-sandbox-use-dbus-launch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0054-policycoreutils-sandbox-use-dbus-launch.patch"


--------------080608040205080600070908--

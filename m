Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RFbCKc027769
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:37:12 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q2RFbBSi023037
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:37:11 -0400
Message-ID: <4F71DEA7.60101@redhat.com>
Date: Tue, 27 Mar 2012 11:37:11 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 59/73] libselinux: take security_deny_unknown into account
Content-Type: multipart/mixed;
 boundary="------------000806070900070908050006"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000806070900070908050006
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9x3qcACgkQrlYvE4MpobPMHQCfQNYb92qZUhdHdqixuvci1j7k
x38An0SShIol3KqjISaujnpn1gZa7fhA
=B990
-----END PGP SIGNATURE-----

--------------000806070900070908050006
Content-Type: text/x-patch;
 name="0059-libselinux-take-security_deny_unknown-into-account.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0059-libselinux-take-security_deny_unknown-into-account.patc";
 filename*1="h"


--------------000806070900070908050006--

Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pB5JVg8L000428
	for <selinux@tycho.nsa.gov>; Mon, 5 Dec 2011 14:31:42 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id pB5JVfTV010317
	for <selinux@tycho.nsa.gov>; Mon, 5 Dec 2011 19:31:41 GMT
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pB5JVfBP030516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Mon, 5 Dec 2011 14:31:41 -0500
Message-ID: <4EDD1C1B.5010400@redhat.com>
Date: Mon, 05 Dec 2011 14:31:39 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 24/48] checkpolicy: allow ~ in filename transition rules
Content-Type: multipart/mixed;
 boundary="------------020601010208000402000507"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020601010208000402000507
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7dHBsACgkQrlYvE4MpobPvcwCfbt418fRVA8n9+n/SZMy0RwP/
TZcAoNq7PcdLCGu+RCsZsw7BGYNAl5Tr
=TQX9
-----END PGP SIGNATURE-----

--------------020601010208000402000507
Content-Type: text/plain;
 name="0024-checkpolicy-allow-in-filename-transition-rules.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0024-checkpolicy-allow-in-filename-transition-rules.patch"


--------------020601010208000402000507--

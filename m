Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9SJqq7V013877
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2013 15:52:56 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9SJqsAu009208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2013 15:52:54 -0400
Message-ID: <526EC096.109@redhat.com>
Date: Mon, 28 Oct 2013 15:52:54 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 09/17] Have sepolgen return additional constraint information
Content-Type: multipart/mixed;
 boundary="------------090901030901030002010508"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090901030901030002010508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch allows sepolgen to also display the constraint information.
   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJuwJUACgkQrlYvE4MpobMrsACfbtdHjC53/DrMF1itoktLp+Tx
5WsAnR7fu93pNYhnIBJRUkfHid+yw/tZ
=/iGt
-----END PGP SIGNATURE-----

--------------090901030901030002010508
Content-Type: text/x-patch;
 name="0009-Have-sepolgen-return-additional-constraint-informati.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0009-Have-sepolgen-return-additional-constraint-informati.pa";
 filename*1="tch"


--------------090901030901030002010508--

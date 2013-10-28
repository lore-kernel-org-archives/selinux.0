Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9SJq65n013834
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2013 15:52:06 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9SJq3PU015968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2013 15:52:04 -0400
Message-ID: <526EC062.5040306@redhat.com>
Date: Mon, 28 Oct 2013 15:52:02 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 08/17] Have audit2allow output additional constraint
Content-Type: multipart/mixed;
 boundary="------------020508060409050903010709"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020508060409050903010709
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch puts out the constraint information with audit2allow output.

   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJuwGIACgkQrlYvE4MpobMPDwCdHbqUtFuDd6JETLSE5I9Ghtgf
33wAmgNEnS8ADFbNnYmb4xlpf+1CK/wK
=cqz2
-----END PGP SIGNATURE-----

--------------020508060409050903010709
Content-Type: text/x-patch;
 name="0008-Have-audit2allow-output-additional-constraint-inform.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0008-Have-audit2allow-output-additional-constraint-inform.pa";
 filename*1="tch"


--------------020508060409050903010709--

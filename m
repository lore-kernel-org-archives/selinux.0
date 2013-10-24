Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OF5oIb032703
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:05:55 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OF5rGd006857
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:05:53 -0400
Message-ID: <52693750.7090207@redhat.com>
Date: Thu, 24 Oct 2013 11:05:52 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 63/74] seinfo needs to work if mls is disabled.
Content-Type: multipart/mixed;
 boundary="------------030604080606000604020702"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030604080606000604020702
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpN1AACgkQrlYvE4MpobM/UACggs0X/cBLfEy8ENeJQ8YbI8LP
lBQAoIuD7acX0ZifDH3JNNIKr1pZrmOT
=y+x8
-----END PGP SIGNATURE-----

--------------030604080606000604020702
Content-Type: text/x-patch;
 name="0063-seinfo-needs-to-work-if-mls-is-disabled.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0063-seinfo-needs-to-work-if-mls-is-disabled.patch"


--------------030604080606000604020702--

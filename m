Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9ODnbhI023873
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:49:37 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9ODnZeT021314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:49:35 -0400
Message-ID: <5269256F.60503@redhat.com>
Date: Thu, 24 Oct 2013 09:49:35 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 10/74] This patch fixes python parsing.
Content-Type: multipart/mixed;
 boundary="------------000602050000010408070305"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000602050000010408070305
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

We had some resource/memory leaks in our python bindings, this patch cleans
these up and cleans up some of the code.

   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpJW4ACgkQrlYvE4MpobNNZgCdHLt3HXy04qVRY51jhG1lev6K
WQ4AnRb8wWrVreOvaI30UX9vhOgJhtcA
=HRxB
-----END PGP SIGNATURE-----

--------------000602050000010408070305
Content-Type: text/x-patch;
 name="0010-This-patch-fixes-python-parsing.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0010-This-patch-fixes-python-parsing.patch"


--------------000602050000010408070305--

Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MEwsYJ015027
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:58:57 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0MEwtZg004199
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:58:55 -0500
Message-ID: <50FEA92E.5000907@redhat.com>
Date: Tue, 22 Jan 2013 09:58:54 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 77/84] libselinux: audit2why: use the new constraint
Content-Type: multipart/mixed;
 boundary="------------010304050406040907040900"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010304050406040907040900
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD+qS4ACgkQrlYvE4MpobMKgACg3LqyOtNOYMtxJ5uIPSHHYwrw
QsMAoKZdq7bviKsXaVJ1J6AhZ+7kW8u3
=K78H
-----END PGP SIGNATURE-----

--------------010304050406040907040900
Content-Type: text/x-patch;
 name="0077-libselinux-audit2why-use-the-new-constraint-informat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0077-libselinux-audit2why-use-the-new-constraint-informat.pa";
 filename*1="tch"


--------------010304050406040907040900--

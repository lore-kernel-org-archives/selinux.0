Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9ODwRaP024779
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:58:27 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9ODwPqJ009930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:58:25 -0400
Message-ID: <52692780.6020706@redhat.com>
Date: Thu, 24 Oct 2013 09:58:24 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 18/74] Fixes for procattr calls to handle cache properly.
Content-Type: multipart/mixed;
 boundary="------------090207010709010305020703"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090207010709010305020703
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

We were asked not to link to libpthread but to use gcc internals.
We were not handling properly the fact that a cache was UNSET, and this
patch fixes this.

   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpJ4AACgkQrlYvE4MpobM6LACgyMt1KHAUSwOBEepGaMinAHvr
YjYAmgK3TBekoGBOGhfK/HDII9KcOJue
=R+Hn
-----END PGP SIGNATURE-----

--------------090207010709010305020703
Content-Type: text/x-patch;
 name="0018-Fixes-for-procattr-calls-to-handle-cache-properly.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0018-Fixes-for-procattr-calls-to-handle-cache-properly.patch"


--------------090207010709010305020703--

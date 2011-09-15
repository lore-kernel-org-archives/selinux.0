Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8FJtsFm021734
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 15:55:54 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8FJtrHA020092
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 19:55:53 GMT
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p8FJtrNk024383
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 15:55:53 -0400
Message-ID: <4E725847.6040004@redhat.com>
Date: Thu, 15 Sep 2011 15:55:51 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 52/67] libsepol: FIXME setools expects expand_module_avrules
Content-Type: multipart/mixed;
 boundary="------------010306010006060705070203"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010306010006060705070203
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.

This is needed in order to build setools, although I think setools
still will not fully build.  It would be good if someone from setools
would diagnose what is breaking.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5yWEcACgkQrlYvE4MpobOUPwCeLu4620TdPJDbLP9+8Osnn0yP
xTkAmwZ8l3bbsjHwNLH8JWmhkSCcuD3w
=z+vA
-----END PGP SIGNATURE-----

--------------010306010006060705070203
Content-Type: text/plain;
 name="0052-libsepol-FIXME-setools-expects-expand_module_avrules.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0052-libsepol-FIXME-setools-expects-expand_module_avrules.pa";
 filename*1="tch"


--------------010306010006060705070203--

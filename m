Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MEn7fr012794
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:49:14 -0500
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0MEnDOE030636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:49:13 -0500
Message-ID: <50FEA6E8.2000203@redhat.com>
Date: Tue, 22 Jan 2013 09:49:12 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 42/84] libselinux: audit2why: Fix segfault if finish() called
Content-Type: multipart/mixed;
 boundary="------------080808050401000208020301"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080808050401000208020301
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD+pugACgkQrlYvE4MpobMa1gCeLC/lYrIcsCjFcgpHSxENrIB4
IhoAoLFHM8rT0WZfiqZyE7cpMHmejr70
=Ki7w
-----END PGP SIGNATURE-----

--------------080808050401000208020301
Content-Type: text/x-patch;
 name="0042-libselinux-audit2why-Fix-segfault-if-finish-called-t.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0042-libselinux-audit2why-Fix-segfault-if-finish-called-t.pa";
 filename*1="tch"


--------------080808050401000208020301--

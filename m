Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MEu3kQ014294
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:56:03 -0500
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0MEu1xd029116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:56:01 -0500
Message-ID: <50FEA880.4080809@redhat.com>
Date: Tue, 22 Jan 2013 09:56:00 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 66/84] libselinux: selinux_status_open: handle error from
Content-Type: multipart/mixed;
 boundary="------------050002020803020702030801"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050002020803020702030801
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD+qIAACgkQrlYvE4MpobODbACgv63ix1VFIihVgIJ6j/qNXxTZ
AOUAn05ZBxuhsgn8IINUz9rZlpTIFKCS
=aXlb
-----END PGP SIGNATURE-----

--------------050002020803020702030801
Content-Type: text/x-patch;
 name="0066-libselinux-selinux_status_open-handle-error-from-sys.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0066-libselinux-selinux_status_open-handle-error-from-sys.pa";
 filename*1="tch"


--------------050002020803020702030801--

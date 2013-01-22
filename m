Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MEuEKk014332
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:56:14 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0MEuDIf016647
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:56:13 -0500
Message-ID: <50FEA88C.1050404@redhat.com>
Date: Tue, 22 Jan 2013 09:56:12 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 67/84] libselinux: selinux_status_open: do not leak statusfd
Content-Type: multipart/mixed;
 boundary="------------040103080802020900060509"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040103080802020900060509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD+qIwACgkQrlYvE4MpobMy1QCffAkqcUO/gJdMxxMzm7HxcBWq
49sAoLkREjdK2Kxstqf4zjZyOEEOw1oQ
=2Seb
-----END PGP SIGNATURE-----

--------------040103080802020900060509
Content-Type: text/x-patch;
 name="0067-libselinux-selinux_status_open-do-not-leak-statusfd-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0067-libselinux-selinux_status_open-do-not-leak-statusfd-.pa";
 filename*1="tch"


--------------040103080802020900060509--

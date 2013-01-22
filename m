Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MEFks1009170
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:15:46 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0MEFgTs032028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:15:44 -0500
Message-ID: <50FE9F0C.60605@redhat.com>
Date: Tue, 22 Jan 2013 09:15:40 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 04/84] libselinux: audit2why: make sure path is nul terminated
Content-Type: multipart/mixed;
 boundary="------------070701080402090200090706"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070701080402090200090706
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD+nwwACgkQrlYvE4MpobPxcwCePzY64JhlL2NmZ1p7m/iOh1as
d0AAoLIN8AW+C+buxy3DYBuNqIYPIpue
=Zn4Y
-----END PGP SIGNATURE-----

--------------070701080402090200090706
Content-Type: text/x-patch;
 name="0004-libselinux-audit2why-make-sure-path-is-nul-terminate.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0004-libselinux-audit2why-make-sure-path-is-nul-terminate.pa";
 filename*1="tch"


--------------070701080402090200090706--

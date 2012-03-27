Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RF6EMb024419
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:06:14 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q2RF6EqB027443
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:06:14 -0400
Message-ID: <4F71D765.3080408@redhat.com>
Date: Tue, 27 Mar 2012 11:06:13 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 18/73] libselinux: Remove jump over variable declaration
Content-Type: multipart/mixed;
 boundary="------------060801010001090905080103"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060801010001090905080103
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9x12UACgkQrlYvE4MpobOt9QCgoEHqgcE0qRNMtypmatkTJKfw
V7EAnRdqxmbYcP4r0+LgEomYqXFD1Idi
=Pzuu
-----END PGP SIGNATURE-----

--------------060801010001090905080103
Content-Type: text/x-patch;
 name="0018-libselinux-Remove-jump-over-variable-declaration.patch"
Content-Disposition: attachment;
 filename*0="0018-libselinux-Remove-jump-over-variable-declaration.patch"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx1.redhat.com id q2RF6EqB027443


--------------060801010001090905080103--

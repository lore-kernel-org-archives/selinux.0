Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pB5Jd8qr001363
	for <selinux@tycho.nsa.gov>; Mon, 5 Dec 2011 14:39:08 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id pB5Jd79F013974
	for <selinux@tycho.nsa.gov>; Mon, 5 Dec 2011 19:39:07 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pB5Jd68C003703
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Mon, 5 Dec 2011 14:39:06 -0500
Message-ID: <4EDD1DD8.8050309@redhat.com>
Date: Mon, 05 Dec 2011 14:39:04 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 41/48] libselinux: return EINVAL if invalid role selected
Content-Type: multipart/mixed;
 boundary="------------080907060502000304070203"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080907060502000304070203
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7dHdgACgkQrlYvE4MpobNv1ACeLTzML8D4EkvA8AlrYQq3EH5y
dnwAoJ11+aC3a7hqhEa8KopmKU2kAeHc
=UdEj
-----END PGP SIGNATURE-----

--------------080907060502000304070203
Content-Type: text/plain;
 name="0041-libselinux-return-EINVAL-if-invalid-role-selected.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0041-libselinux-return-EINVAL-if-invalid-role-selected.patch"


--------------080907060502000304070203--

Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7BEHvi3031418
	for <selinux@tycho.nsa.gov>; Thu, 11 Aug 2011 10:17:57 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7BEHuCo007840
	for <selinux@tycho.nsa.gov>; Thu, 11 Aug 2011 14:17:56 GMT
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7BEHuS2015967
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 11 Aug 2011 10:17:56 -0400
Message-ID: <4E43E492.9040109@redhat.com>
Date: Thu, 11 Aug 2011 10:17:54 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 10/96] libsemanage: python3 support.
Content-Type: multipart/mixed;
 boundary="------------030209040904080503050400"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030209040904080503050400
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.

Dave Malcolm has also reviewed this patch again.  Tested against
python3.2 also
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5D5JIACgkQrlYvE4MpobOJdgCdHJyp8XR7h99eF92NT2jTP+px
Ty4AoORG0EaBV2NmS9/59uSRk6UHSf8w
=4YmO
-----END PGP SIGNATURE-----

--------------030209040904080503050400
Content-Type: text/plain;
 name="0010-libsemanage-python3-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0010-libsemanage-python3-support.patch"


--------------030209040904080503050400--

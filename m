Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8FJm1n0020804
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 15:48:01 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8FJm0HA018237
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 19:48:00 GMT
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p8FJm0Mv007419
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 15:48:00 -0400
Message-ID: <4E72566F.90101@redhat.com>
Date: Thu, 15 Sep 2011 15:47:59 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 38/67] sepolgen: FIXME Change perm-map and add open to try
 to
Content-Type: multipart/mixed;
 boundary="------------010002020702090005010602"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010002020702090005010602
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.

This patch adds open to sepolgen checks and resets the priorities to
get better matches on AVCs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5yVm8ACgkQrlYvE4MpobNgBgCg4AMoqz0Vc+Gx6n6A6nIm8hLC
HyAAn0nVx/+cTey510qIFny9vHJrjTI2
=dtQu
-----END PGP SIGNATURE-----

--------------010002020702090005010602
Content-Type: text/plain;
 name="0038-sepolgen-FIXME-Change-perm-map-and-add-open-to-try-t.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0038-sepolgen-FIXME-Change-perm-map-and-add-open-to-try-t.pa";
 filename*1="tch"


--------------010002020702090005010602--

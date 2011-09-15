Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8FJnkiS020978
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 15:49:46 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8FJnjHA018520
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 19:49:45 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p8FJnjNp021821
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 15:49:45 -0400
Message-ID: <4E7256D8.6010208@redhat.com>
Date: Thu, 15 Sep 2011 15:49:44 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 39/67] sepolgen: FIXME Change analysys of sepolgen to return
Content-Type: multipart/mixed;
 boundary="------------060302080100030509040901"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060302080100030509040901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.

This patch allows audit2allow to do analysis on the AVC's to see if a
boolean would have solved the problem or if the AVC is caused by a
constraint.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5yVtgACgkQrlYvE4MpobN6NQCg1sPGcc8doc7uDRqzpLVnRWLl
mcoAoN+n22BL7MXAGySZn96vMyuy5c5a
=B398
-----END PGP SIGNATURE-----

--------------060302080100030509040901
Content-Type: text/plain;
 name="0039-sepolgen-FIXME-Change-analysys-of-sepolgen-to-return.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0039-sepolgen-FIXME-Change-analysys-of-sepolgen-to-return.pa";
 filename*1="tch"


--------------060302080100030509040901--

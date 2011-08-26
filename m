Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7QIkWwF032729
	for <selinux@tycho.nsa.gov>; Fri, 26 Aug 2011 14:46:32 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7QIkUS5015796
	for <selinux@tycho.nsa.gov>; Fri, 26 Aug 2011 18:46:31 GMT
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7QIkUu4005481
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 26 Aug 2011 14:46:30 -0400
Message-ID: <4E57EA05.9010601@redhat.com>
Date: Fri, 26 Aug 2011 14:46:29 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 76/77] sepolgen: FIXME Allow sepolgen to handle file name
Content-Type: multipart/mixed;
 boundary="------------000500030905030003020106"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000500030905030003020106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.

This patch is needed to be able to compile policy with filetrans rules.

Also add open as a valid command.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5X6gUACgkQrlYvE4MpobN5ZwCfUUH0NMofG6mpVL2iWkQId3cx
TOYAoM162KTczTJktCnSYzOrGFGHTbB6
=Ydc/
-----END PGP SIGNATURE-----

--------------000500030905030003020106
Content-Type: text/plain;
 name="0076-sepolgen-FIXME-Allow-sepolgen-to-handle-file-name-tr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0076-sepolgen-FIXME-Allow-sepolgen-to-handle-file-name-tr.pa";
 filename*1="tch"


--------------000500030905030003020106--

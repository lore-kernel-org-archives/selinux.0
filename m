Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pA1K04TK000392
	for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2011 16:00:04 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id pA1K03Oe000706
	for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2011 20:00:03 GMT
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pA1K02rj031039
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2011 16:00:02 -0400
Message-ID: <4EB04FC1.1010801@redhat.com>
Date: Tue, 01 Nov 2011 16:00:01 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 36/63] libselinux: load_policy: handle selinux=0 and
Content-Type: multipart/mixed;
 boundary="------------010705000109040003060107"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010705000109040003060107
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6wT8EACgkQrlYvE4MpobOajgCgmjREEVQnkhXAOC0o5xzX64WK
JHQAmgIEtZJo7zLMrbY3NKhj5bBlRzm/
=PCxH
-----END PGP SIGNATURE-----

--------------010705000109040003060107
Content-Type: text/plain;
 name="0036-libselinux-load_policy-handle-selinux-0-and-sys-fs-s.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0036-libselinux-load_policy-handle-selinux-0-and-sys-fs-s.pa";
 filename*1="tch"


--------------010705000109040003060107--

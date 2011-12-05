Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pB5Jaav5001018
	for <selinux@tycho.nsa.gov>; Mon, 5 Dec 2011 14:36:36 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id pB5JaZ9F013009
	for <selinux@tycho.nsa.gov>; Mon, 5 Dec 2011 19:36:35 GMT
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pB5JaZwv031939
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Mon, 5 Dec 2011 14:36:35 -0500
Message-ID: <4EDD1D42.7050903@redhat.com>
Date: Mon, 05 Dec 2011 14:36:34 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 35/48] libselinux: selinuxswig_python.i: don't make syscall
Content-Type: multipart/mixed;
 boundary="------------090000030907090706040507"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090000030907090706040507
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7dHUIACgkQrlYvE4MpobPMeACaAsc9zD+5Rtj/XxkfrAdOHqw3
G6oAoI4AZwL5kMg0+IKYMZEMLHZZ7V94
=ijAa
-----END PGP SIGNATURE-----

--------------090000030907090706040507
Content-Type: text/plain;
 name="0035-libselinux-selinuxswig_python.i-don-t-make-syscall-i.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0035-libselinux-selinuxswig_python.i-don-t-make-syscall-i.pa";
 filename*1="tch"


--------------090000030907090706040507--

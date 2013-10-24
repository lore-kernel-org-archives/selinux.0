Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9ODih58023286
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:44:43 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9ODieho003355
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:44:41 -0400
Message-ID: <52692448.4050409@redhat.com>
Date: Thu, 24 Oct 2013 09:44:40 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 04/74] Allow " " and ":" in file name transtions
Content-Type: multipart/mixed;
 boundary="------------060407080400030206030904"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060407080400030206030904
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

We need filename transitions to supported files with " " and ":" in them in Fedora

   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpJEgACgkQrlYvE4MpobNM9ACcDv6MGpOyTML+Zx1hoZ+fuo/e
QeAAoK+VjWPWIk6yZzOg+OQ/wrL/JggY
=z8eL
-----END PGP SIGNATURE-----

--------------060407080400030206030904
Content-Type: text/x-patch;
 name="0004-Allow-and-in-file-name-transtions.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0004-Allow-and-in-file-name-transtions.patch"


--------------060407080400030206030904--

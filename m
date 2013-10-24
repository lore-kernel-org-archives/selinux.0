Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9ODsY50024419
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:54:34 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9ODsKgt013686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:54:20 -0400
Message-ID: <5269268C.2060007@redhat.com>
Date: Thu, 24 Oct 2013 09:54:20 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 13/74] Support udev-197 and higher
Content-Type: multipart/mixed;
 boundary="------------090008020605060106060309"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090008020605060106060309
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

We were not returning proper error codes, which was causing udev to mislabel
some files.
   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpJosACgkQrlYvE4MpobOHtQCfW3dsVtjsogtWPG1AKlYhsrN8
BngAoN6IwtMV74iw6WUzA9HE23bpZyF8
=fNxv
-----END PGP SIGNATURE-----

--------------090008020605060106060309
Content-Type: text/x-patch;
 name="0013-Support-udev-197-and-higher.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0013-Support-udev-197-and-higher.patch"


--------------090008020605060106060309--

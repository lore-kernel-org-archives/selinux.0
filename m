Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OE4a9P025896
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:04:36 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OE4DLQ015693
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:04:13 -0400
Message-ID: <526928DC.50309@redhat.com>
Date: Thu, 24 Oct 2013 10:04:12 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 24/74] fix bug in calls to attributes
Content-Type: multipart/mixed;
 boundary="------------090709030907030506030205"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090709030907030506030205
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpKNwACgkQrlYvE4MpobM+IgCgytERHKgrZ6s4v+aATebY4eHW
kNEAnRg38KhgWW3XBNbguGWlKEB8LO16
=EDlf
-----END PGP SIGNATURE-----

--------------090709030907030506030205
Content-Type: text/x-patch;
 name="0024-fix-bug-in-calls-to-attributes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0024-fix-bug-in-calls-to-attributes.patch"


--------------090709030907030506030205--

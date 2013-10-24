Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OFC7LR001022
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:12:07 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OFC5JN010513
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:12:05 -0400
Message-ID: <526938C3.5070709@redhat.com>
Date: Thu, 24 Oct 2013 11:12:03 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 70/74] Use power of 2 for STAR_COUNT
Content-Type: multipart/mixed;
 boundary="------------070504040103010905070601"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070504040103010905070601
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpOMMACgkQrlYvE4MpobPqywCguBV7E+qIhHvyLbLiPpTtJVoU
pJUAoMaeAE5Nkxd6ssecBsZ2yDDt2yqe
=LrkW
-----END PGP SIGNATURE-----

--------------070504040103010905070601
Content-Type: text/x-patch;
 name="0070-Use-power-of-2-for-STAR_COUNT.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0070-Use-power-of-2-for-STAR_COUNT.patch"


--------------070504040103010905070601--

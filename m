Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OFbsWa003073
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:37:54 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OF0TaB022633
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:00:33 -0400
Message-ID: <52693600.6090608@redhat.com>
Date: Thu, 24 Oct 2013 11:00:16 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 52/74] Add deleteall customizations field for modules.
Content-Type: multipart/mixed;
 boundary="------------080608050006010305000109"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080608050006010305000109
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Allow user to semange module -D which will remove all disabled modules.
   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpNgAACgkQrlYvE4MpobMVXQCeMTjSvVpcqzgDP62B+cQKox5W
DLMAoIO3558tVE7yv2ltd6jIcdCRw/wH
=wWqo
-----END PGP SIGNATURE-----

--------------080608050006010305000109
Content-Type: text/x-patch;
 name="0052-Add-deleteall-customizations-field-for-modules.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0052-Add-deleteall-customizations-field-for-modules.patch"


--------------080608050006010305000109--

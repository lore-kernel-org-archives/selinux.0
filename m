Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7BEAZeX030844
	for <selinux@tycho.nsa.gov>; Thu, 11 Aug 2011 10:10:35 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7BEAYTk003226
	for <selinux@tycho.nsa.gov>; Thu, 11 Aug 2011 14:10:34 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7BEAXfJ021205
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 11 Aug 2011 10:10:33 -0400
Message-ID: <4E43E2D8.9050400@redhat.com>
Date: Thu, 11 Aug 2011 10:10:32 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 02/96] checkpolicy: add missing ; to attribute_role_def
Content-Type: multipart/mixed;
 boundary="------------010305020602060706060709"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010305020602060706060709
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.


Simple fix for a missing ';'
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5D4tgACgkQrlYvE4MpobNUmQCfdSRjuWwrvmQajddsYikLMvG4
NcIAn2zFf4tgO5IC0FR7c+Z82asi8V06
=/N3t
-----END PGP SIGNATURE-----

--------------010305020602060706060709
Content-Type: text/plain;
 name="0002-checkpolicy-add-missing-to-attribute_role_def.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-checkpolicy-add-missing-to-attribute_role_def.patch"


--------------010305020602060706060709--

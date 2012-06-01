Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q51I7PXl009439
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 14:07:25 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q51I7KXI003725
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 14:07:23 -0400
Message-ID: <4FC8F8BA.9010606@redhat.com>
Date: Fri, 01 Jun 2012 13:15:38 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 33/90] libsemanage: Use default semanage.conf as a fallback
Content-Type: multipart/mixed;
 boundary="------------040608010600070104090305"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040608010600070104090305
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/I+LoACgkQrlYvE4MpobNFVACgrHTDdbtlugdj43UZGm2n4d7l
vpAAoNVhKK6Qq/uq93irq6mD77iY3cXJ
=kK2b
-----END PGP SIGNATURE-----

--------------040608010600070104090305
Content-Type: text/x-patch;
 name="0033-libsemanage-Use-default-semanage.conf-as-a-fallback.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0033-libsemanage-Use-default-semanage.conf-as-a-fallback.pat";
 filename*1="ch"


--------------040608010600070104090305--

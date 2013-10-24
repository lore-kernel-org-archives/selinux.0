Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OE2w3f025764
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:03:01 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OE30u8012276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:03:00 -0400
Message-ID: <52692893.4080706@redhat.com>
Date: Thu, 24 Oct 2013 10:02:59 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 22/74] Pull auditing into libsemanage.
Content-Type: multipart/mixed;
 boundary="------------020309040909030006080609"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020309040909030006080609
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

libsemanage needs to write audit messages when tools change the MAC Policy.
This is the first patch to do this, we will probably have more coming in the
future.

   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpKJMACgkQrlYvE4MpobOEtQCfesDgovuNs40VKtr/ey/H2vc2
qqgAn1XkSnY1XYi08x8Eip+xRK68x5Dm
=WWbM
-----END PGP SIGNATURE-----

--------------020309040909030006080609
Content-Type: text/x-patch;
 name="0022-Pull-auditing-into-libsemanage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0022-Pull-auditing-into-libsemanage.patch"


--------------020309040909030006080609--

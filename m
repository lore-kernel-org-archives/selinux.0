Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OKmaHQ024224
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 16:48:36 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OKmYTO005451
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 16:48:34 -0400
Message-ID: <526987A1.1040204@redhat.com>
Date: Thu, 24 Oct 2013 16:48:33 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] Need to delete all managed objects before readding them
Content-Type: multipart/mixed;
 boundary="------------050505070302000403030005"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050505070302000403030005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

We need to delete all modifications before we re-add them, otherwise we end up
with conflicts on user/login mappings.
   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJph6EACgkQrlYvE4MpobPW1QCdHNpLIzTF0mkn/7q8TJE/sNYi
xegAn32VlxNrrIBqTnQ9w+fpmFJZdlU5
=vdCH
-----END PGP SIGNATURE-----

--------------050505070302000403030005
Content-Type: text/x-patch;
 name="0002-Need-to-delete-all-managed-objects-before-readding-t.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-Need-to-delete-all-managed-objects-before-readding-t.pa";
 filename*1="tch"


--------------050505070302000403030005--

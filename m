Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9SJpOlM013769
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2013 15:51:24 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9SJpL6x008978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2013 15:51:21 -0400
Message-ID: <526EC038.7090306@redhat.com>
Date: Mon, 28 Oct 2013 15:51:20 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 07/17] Fix line spacing on audit2allow output
Content-Type: multipart/mixed;
 boundary="------------020101080901040807090001"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020101080901040807090001
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

In certain situations the formatting of the audit2allow lines was not done
correctly.  Putting the newline at the beginning fixes this.
   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJuwDgACgkQrlYvE4MpobNqAQCbBh0YcPhqIOKAIbu3nxvuLxoN
1M0An3iHI9/b6ZwyRUuYpjgdt0yPDWdw
=q75P
-----END PGP SIGNATURE-----

--------------020101080901040807090001
Content-Type: text/x-patch;
 name="0007-Fix-line-spacing-on-audit2allow-output.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0007-Fix-line-spacing-on-audit2allow-output.patch"


--------------020101080901040807090001--

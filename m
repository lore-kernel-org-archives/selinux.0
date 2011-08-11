Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7BEJt8N031592
	for <selinux@tycho.nsa.gov>; Thu, 11 Aug 2011 10:19:55 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7BEJrCo008166
	for <selinux@tycho.nsa.gov>; Thu, 11 Aug 2011 14:19:54 GMT
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7BEJrdB016678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 11 Aug 2011 10:19:53 -0400
Message-ID: <4E43E507.4020400@redhat.com>
Date: Thu, 11 Aug 2011 10:19:51 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 12/96] libsemanage: introduce semanage_set_root and friends
Content-Type: multipart/mixed;
 boundary="------------080106060004060204080909"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080106060004060204080909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.


This patch allows us to build a policy to ship within the RPM rather
then always requiring us to build at install time.  Probably useful for
embedded users also.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5D5QcACgkQrlYvE4MpobN9xwCgjBmkNvmarovifeR2yDHEzxis
WOAAn3ZhNsGamdqVHvIbSAyitljX5Is2
=qeoY
-----END PGP SIGNATURE-----

--------------080106060004060204080909
Content-Type: text/plain;
 name="0012-libsemanage-introduce-semanage_set_root-and-friends.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0012-libsemanage-introduce-semanage_set_root-and-friends.pat";
 filename*1="ch"


--------------080106060004060204080909--

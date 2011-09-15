Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8FK6OdN022884
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 16:06:24 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8FK6NHA022624
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 20:06:23 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p8FK6GjJ001510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 16:06:16 -0400
Message-ID: <4E725AB7.60806@redhat.com>
Date: Thu, 15 Sep 2011 16:06:15 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 65/67] libselinux: put libselinux.so.1 in /lib not /usr/lib
Content-Type: multipart/mixed;
 boundary="------------080505050002040709090202"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080505050002040709090202
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5yWrcACgkQrlYvE4MpobNzWQCdH9xexXB6/riII69h8UhrxqTQ
AxYAoIIcgb5RlMVRmtys0mryIsBmnTPW
=cULt
-----END PGP SIGNATURE-----

--------------080505050002040709090202
Content-Type: text/plain;
 name="0065-libselinux-put-libselinux.so.1-in-lib-not-usr-lib.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0065-libselinux-put-libselinux.so.1-in-lib-not-usr-lib.patch"


--------------080505050002040709090202--

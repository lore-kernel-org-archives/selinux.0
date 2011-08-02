Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p72FbHbL022851
	for <selinux@tycho.nsa.gov>; Tue, 2 Aug 2011 11:37:17 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p72FbElF026764
	for <selinux@tycho.nsa.gov>; Tue, 2 Aug 2011 15:37:15 GMT
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p72FbEUg007587
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 2 Aug 2011 11:37:14 -0400
Message-ID: <4E3819A9.3050203@redhat.com>
Date: Tue, 02 Aug 2011 11:37:13 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 91/92] policycoreutils: sandbox: FIXME update sandbox
Content-Type: multipart/mixed;
 boundary="------------040408040203050804010201"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040408040203050804010201
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.

I agree that this is almost an entire rewrite.  Most of the sandbox code
that went into upstream has changed drastically.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk44GakACgkQrlYvE4MpobObAQCZAay+sKzeKgObo07Qf6RIyxcG
UT4Anitd00nZGNMjInNOsDfhxH8iAbER
=yn41
-----END PGP SIGNATURE-----

--------------040408040203050804010201
Content-Type: text/plain;
 name="0091-policycoreutils-sandbox-FIXME-update-sandbox.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0091-policycoreutils-sandbox-FIXME-update-sandbox.patch"


--------------040408040203050804010201--

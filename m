Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7UKksfi014150
	for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2011 16:46:54 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7UKkqbL022550
	for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2011 20:46:53 GMT
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7UKkqd3010672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2011 16:46:52 -0400
Message-ID: <4E5D4C3B.1080808@redhat.com>
Date: Tue, 30 Aug 2011 16:46:51 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 17/48] policycoreutils: setfiles: FIXME Fix potential crash
Content-Type: multipart/mixed;
 boundary="------------030001050400020804010009"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030001050400020804010009
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.

FIXME: Would this be somehow a normal condition for an empty directory?
Don't know the code well enough to tell.

No the code works fine with empty directories.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5dTDsACgkQrlYvE4MpobPZOwCguShVgT7fhgSDOn3uNstJ7Gv1
eSEAn0/pNB6SFHvusyQ6LWpl56ENcajE
=WDFm
-----END PGP SIGNATURE-----

--------------030001050400020804010009
Content-Type: text/plain;
 name="0017-policycoreutils-setfiles-FIXME-Fix-potential-crash-u.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0017-policycoreutils-setfiles-FIXME-Fix-potential-crash-u.pa";
 filename*1="tch"


--------------030001050400020804010009--

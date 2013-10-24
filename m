Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OF3Fpd032398
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:03:15 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OF3BFe007524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:03:13 -0400
Message-ID: <526936AD.1070800@redhat.com>
Date: Thu, 24 Oct 2013 11:03:09 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 57/74] If users of seobject set serange or seuser to ""
Content-Type: multipart/mixed;
 boundary="------------080308060203010402000103"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080308060203010402000103
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Avoid bad data getting through semanage command.

   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpNq0ACgkQrlYvE4MpobNiaQCgjNSzsoiRwa31KlLiGTUj1wxs
EhEAoJpZUhnIDL66td2Lq3BjPTe3No59
=4dO1
-----END PGP SIGNATURE-----

--------------080308060203010402000103
Content-Type: text/x-patch;
 name="0057-If-users-of-seobject-set-serange-or-seuser-to-we-nee.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0057-If-users-of-seobject-set-serange-or-seuser-to-we-nee.pa";
 filename*1="tch"


--------------080308060203010402000103--

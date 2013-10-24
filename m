Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9ODi3tq023259
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:44:03 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9ODi0Zl018505
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:44:01 -0400
Message-ID: <5269241E.7050600@redhat.com>
Date: Thu, 24 Oct 2013 09:43:58 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 03/74] handle-unknown should be an optional argument
Content-Type: multipart/mixed;
 boundary="------------000702000002000908080104"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000702000002000908080104
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I believe this was already applied upstream but we still have it.

Basically stops a crash if you call hanlde-unknown without an option

   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpJB4ACgkQrlYvE4MpobMuXgCguRCvwlDptmFIu2CQOdsREZFI
NJYAoKt9rJEokmqlJSO4CV1uMUrEebSe
=E3Yg
-----END PGP SIGNATURE-----

--------------000702000002000908080104
Content-Type: text/x-patch;
 name="0003-handle-unknown-should-be-an-optional-argument.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0003-handle-unknown-should-be-an-optional-argument.patch"


--------------000702000002000908080104--

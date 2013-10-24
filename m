Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OEOcCt028357
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:24:38 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OEOM7g022342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:24:22 -0400
Message-ID: <52692D95.4070001@redhat.com>
Date: Thu, 24 Oct 2013 10:24:21 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 37/74] Give people who use run_init or newrole an indicator
 to
Content-Type: multipart/mixed;
 boundary="------------090600080603020603080109"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090600080603020603080109
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch adds documentation to pam files to tell admins how to make newrole
and run_init not ask for the password.

   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpLZUACgkQrlYvE4MpobNGzgCg5aw/+6B3808KuxG3MtGFC6rl
jj0AoNbI/GjWdf59iWeRFmsby5hLM2e1
=3ogW
-----END PGP SIGNATURE-----

--------------090600080603020603080109
Content-Type: text/x-patch;
 name="0037-Give-people-who-use-run_init-or-newrole-an-indicator.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0037-Give-people-who-use-run_init-or-newrole-an-indicator.pa";
 filename*1="tch"


--------------090600080603020603080109--

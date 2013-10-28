Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9SJoE8b013626
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2013 15:50:14 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9SJoCCZ031603
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2013 15:50:12 -0400
Message-ID: <526EBFEE.3030603@redhat.com>
Date: Mon, 28 Oct 2013 15:50:06 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 06/17] Return the sections of the source and target context
Content-Type: multipart/mixed;
 boundary="------------070709030107090905020606"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070709030107090905020606
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch returns extra data about what is different between the source and
target context when a constraint violation happens.
   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJuv+4ACgkQrlYvE4MpobOFrACg3Ng2xsKL6RFHNBIDGUoJ48yx
Mt8AnidAzeE6+d4PKUQTnLeDq3hgmsZo
=TKPZ
-----END PGP SIGNATURE-----

--------------070709030107090905020606
Content-Type: text/x-patch;
 name="0006-Return-the-sections-of-the-source-and-target-context.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0006-Return-the-sections-of-the-source-and-target-context.pa";
 filename*1="tch"


--------------070709030107090905020606--

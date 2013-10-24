Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9ODre87024356
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:53:40 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9ODrcRh013380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:53:38 -0400
Message-ID: <52692661.5070801@redhat.com>
Date: Thu, 24 Oct 2013 09:53:37 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 12/74] Separate out the calling of local subs and dist subs
 in
Content-Type: multipart/mixed;
 boundary="------------060806070406060701050301"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060806070406060701050301
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch separates out the distro subs after the admin subs.  Basically
apply the distro subs second.  Fixes problems where users specify a label that
a distro sub would have covered.

Distro sub has /usr/local -> /usr

And user adds a sub from in /usr/local.

   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpJmEACgkQrlYvE4MpobNahgCfQS9r55tw0Dsh/a30GVBXkUpm
siUAoJUqjKfekwvQXDjIpsKEgX0+TP4/
=MgUC
-----END PGP SIGNATURE-----

--------------060806070406060701050301
Content-Type: text/x-patch;
 name="0012-Separate-out-the-calling-of-local-subs-and-dist-subs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0012-Separate-out-the-calling-of-local-subs-and-dist-subs.pa";
 filename*1="tch"


--------------060806070406060701050301--

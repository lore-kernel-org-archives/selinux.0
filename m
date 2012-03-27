Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RFS4Gj026730
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:28:04 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q2RFS2Vl019421
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:28:02 -0400
Message-ID: <4F71DC81.9080205@redhat.com>
Date: Tue, 27 Mar 2012 11:28:01 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 39/73] policycoreutils: load_policy: Stop making link for
Content-Type: multipart/mixed;
 boundary="------------060003040303090002070805"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060003040303090002070805
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

After the usermove /sbin points as /usr/sbin

So
/sbin/load_policy and /usr/sbin/load_policy

Are already the same.

If a distribution does not support the usrmove it should make the link
in its packageing file we should not be doing this in the Makefile.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9x3IEACgkQrlYvE4MpobOzugCcDVS96lTvqUIVG2ZkNUTcme77
YvYAoI0U+gbFMW7xIXd0o4OASh+TL30l
=sgw5
-----END PGP SIGNATURE-----

--------------060003040303090002070805
Content-Type: text/x-patch;
 name="0039-policycoreutils-load_policy-Stop-making-link-for-loa.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0039-policycoreutils-load_policy-Stop-making-link-for-loa.pa";
 filename*1="tch"


--------------060003040303090002070805--

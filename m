Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9ODpvmF024283
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:51:57 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9ODptWv020015
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:51:55 -0400
Message-ID: <526925FA.9000309@redhat.com>
Date: Thu, 24 Oct 2013 09:51:54 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 11/74] Patch to change *setfilecon to not return ENOSUP if
Content-Type: multipart/mixed;
 boundary="------------070305060104030607010500"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070305060104030607010500
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch might be somewhat controversial, basically makes *setfilecon
commands not fail if the caller tries to set the file context on a file system
that does not support XATTRs, and the file context it is trying to set matches
the current file context.

setfilecon("/mnt/nfshare/dwalsh", "system_u:object_r:nfs_t:s0")

Would not fail for example.


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpJfoACgkQrlYvE4MpobO99QCcDi2w/WdXxj7E7xj9gq8am85x
4j8AoNQZm75o1mV5WtbzvE3Zamxw5I24
=Spvh
-----END PGP SIGNATURE-----

--------------070305060104030607010500
Content-Type: text/x-patch;
 name="0011-Patch-to-change-setfilecon-to-not-return-ENOSUP-if-c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0011-Patch-to-change-setfilecon-to-not-return-ENOSUP-if-c.pa";
 filename*1="tch"


--------------070305060104030607010500--

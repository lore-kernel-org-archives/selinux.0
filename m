Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OEI4Dc027567
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:18:04 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OEI1kt001283
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:18:02 -0400
Message-ID: <52692C18.7050909@redhat.com>
Date: Thu, 24 Oct 2013 10:18:00 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 33/74] Allow users to have homedir as a symbolic link but
Content-Type: multipart/mixed;
 boundary="------------090104090004030009050207"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090104090004030009050207
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Had a user with a symbolic link for a homedir, this patch follows the link to
the real homedir for sandbox tools.

   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpLBgACgkQrlYvE4MpobMdTwCffGJ9bTf3tYpRXmEcsLAuBgZt
jo4An3Znt2n73xT/RYuY6JG3dh6npDJO
=eUN6
-----END PGP SIGNATURE-----

--------------090104090004030009050207
Content-Type: text/x-patch;
 name="0033-Allow-users-to-have-homedir-as-a-symbolic-link-but-m.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0033-Allow-users-to-have-homedir-as-a-symbolic-link-but-m.pa";
 filename*1="tch"


--------------090104090004030009050207--

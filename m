Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q51Isaqk013491
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 14:54:40 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q51IsbfD023159
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 14:54:37 -0400
Message-ID: <4FC90FEC.4030308@redhat.com>
Date: Fri, 01 Jun 2012 14:54:36 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 04/90] policycoreutils: run_init: FIXME If open_init_pty is
Content-Type: multipart/mixed;
 boundary="------------070902020902030409000408"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070902020902030409000408
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.
   We no longer ship open_init_pty in Fedora, RHEL6 since it was causing more
problems then it was worth.  This fix makes it optional to use the open_init_pty.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/JD+wACgkQrlYvE4MpobOgOgCaAmLQgyNp/xgVzz9lHoQ/So/b
XlYAoLZC6Tw7Sj+Fe2WV0nktvWW0MvGv
=FVpM
-----END PGP SIGNATURE-----

--------------070902020902030409000408
Content-Type: text/x-patch;
 name="0004-policycoreutils-run_init-FIXME-If-open_init_pty-is-n.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0004-policycoreutils-run_init-FIXME-If-open_init_pty-is-n.pa";
 filename*1="tch"


--------------070902020902030409000408--

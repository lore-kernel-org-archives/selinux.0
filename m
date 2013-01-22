Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MEoiR6013238
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:50:44 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0MEoejf000898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:50:42 -0500
Message-ID: <50FEA737.1070105@redhat.com>
Date: Tue, 22 Jan 2013 09:50:31 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 46/84] policycoreutils: sandbox: Copy /var/tmp to /tmp as
 they
Content-Type: multipart/mixed;
 boundary="------------060504040400030700020105"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060504040400030700020105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD+pzcACgkQrlYvE4MpobPqtgCfY/B8gfpuiK81DHvjXITtCmJl
bHsAnRJLmk2axXAFitCjr9P1qnBk70hF
=0SX6
-----END PGP SIGNATURE-----

--------------060504040400030700020105
Content-Type: text/x-patch;
 name="0046-policycoreutils-sandbox-Copy-var-tmp-to-tmp-as-they-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0046-policycoreutils-sandbox-Copy-var-tmp-to-tmp-as-they-.pa";
 filename*1="tch"


--------------060504040400030700020105--

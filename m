Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OEsh2W030907
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:54:43 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OEsUH8012220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:54:30 -0400
Message-ID: <526934A5.9060303@redhat.com>
Date: Thu, 24 Oct 2013 10:54:29 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 44/74] Convert semanage command to use argparse
Content-Type: multipart/mixed;
 boundary="------------060309030703040900040807"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060309030703040900040807
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch was worked on by Dave Quigley, Miroslav Grepl and Me, to switch
semanage to use argparse which gives much better help messages and really
cleans up the code.

   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpNKUACgkQrlYvE4MpobO36wCcC389tsqeXdtmqYwoVq5ukDEP
cRwAoI3C5aA+OQxTqvb+KUAJzcCeNciw
=V7q3
-----END PGP SIGNATURE-----

--------------060309030703040900040807
Content-Type: text/x-patch;
 name="0044-Convert-semanage-command-to-use-argparse.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0044-Convert-semanage-command-to-use-argparse.patch"


--------------060309030703040900040807--

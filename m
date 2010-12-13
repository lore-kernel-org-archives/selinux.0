Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oBDIjg3N004913
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2010 13:45:42 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id oBDIjfCJ009813
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2010 18:45:41 GMT
Message-ID: <4D0669D3.7020507@redhat.com>
Date: Mon, 13 Dec 2010 13:45:39 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "'Chad Sellers'" <csellers@tresys.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Sandbox Patch
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch to sandbox adds cgroups support
Changes seunshare to use file capabilities.
Changes seunshare to mount more secure /tmp
Adds seunshare man page
Changes sandbox.config file name to sandbox.conf
Adds -Es to python scripts to make them more secure
Plus a myriad of fixes.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0GadMACgkQrlYvE4MpobOvvwCghJ20qfTjXi/K5sVL7f7p1VDm
jIwAn3rQruOSLpZ0B+8F1uPXA5DBJxn3
=Iite
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

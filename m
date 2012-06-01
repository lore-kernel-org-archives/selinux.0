Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q51IvFoM013701
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 14:57:15 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q51IvDp8007831
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 14:57:13 -0400
Message-ID: <4FC91088.5020204@redhat.com>
Date: Fri, 01 Jun 2012 14:57:12 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 08/90] policycoreutils: newrole: FIXME do not drop
Content-Type: multipart/mixed;
 boundary="------------040802010504000902010503"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040802010504000902010503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

If you run newrole as root and it drops capabilities, the next shell script
does not have any capabilities and can not function.

newrole -L TopSecret

Would end up with a root shell and no capabilities.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/JEIgACgkQrlYvE4MpobPH9ACfUrUOvNr3QavxkJrGHxPlf6fC
wh0An2y3xa3Ns71EtaaiiU9BUC0X9bEY
=Davq
-----END PGP SIGNATURE-----

--------------040802010504000902010503
Content-Type: text/x-patch;
 name="0008-policycoreutils-newrole-FIXME-do-not-drop-capabiliti.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0008-policycoreutils-newrole-FIXME-do-not-drop-capabiliti.pa";
 filename*1="tch"


--------------040802010504000902010503--

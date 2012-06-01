Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q51HSbAX006745
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 13:28:37 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q51HSZAl012387
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 13:28:35 -0400
Message-ID: <4FC8FBC2.4010909@redhat.com>
Date: Fri, 01 Jun 2012 13:28:34 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 78/90] Fix seusers potential crash.  Change getdefaultcon
 to
Content-Type: multipart/mixed;
 boundary="------------070105050200000701020901"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070105050200000701020901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/I+8IACgkQrlYvE4MpobPo3wCgt10X9J+DL1Hz1LwgEWCHp45v
yVcAnApaNGrtesDAHGZsQkkn+XqolfXa
=5E5E
-----END PGP SIGNATURE-----

--------------070105050200000701020901
Content-Type: text/x-patch;
 name="0078-Fix-seusers-potential-crash.-Change-getdefaultcon-to.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0078-Fix-seusers-potential-crash.-Change-getdefaultcon-to.pa";
 filename*1="tch"


--------------070105050200000701020901--

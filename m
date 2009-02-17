Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1HGoA0Y012867
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 11:50:11 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1HGkmJD015637
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 16:46:49 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n1HGo9iZ023753
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 11:50:09 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n1HGo9ob009906
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 11:50:09 -0500
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n1HGo8jZ020438
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 11:50:08 -0500
Message-ID: <499AEABF.4060208@redhat.com>
Date: Tue, 17 Feb 2009 11:50:07 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Removing a module that does not exist should not be an error.
Content-Type: multipart/mixed;
 boundary="------------070800060907080206020408"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070800060907080206020408
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This allows us to run a command that removes several modules while
installing others.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkma6r8ACgkQrlYvE4MpobPXgwCgzyp+iRSfgj4FMmTuvj2+8k9Y
nooAoMdbsPa2fY/P5hB7qPvNdItOyfCG
=VQkC
-----END PGP SIGNATURE-----

--------------070800060907080206020408
Content-Type: text/plain;
 name="nsapolicycoreutils_semodule_semodule.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsapolicycoreutils_semodule_semodule.c.patch"

--- nsapolicycoreutils/semodule/semodule.c	2009-01-13 08:45:35.000000000 -0500
+++ policycoreutils-2.0.61/semodule/semodule.c	2009-01-28 16:52:58.000000000 -0500
@@ -359,6 +363,9 @@
 					     mode_arg);
 				}
 				result = semanage_module_remove(sh, mode_arg);
+				if ( result == -2 ) { 
+					continue;
+				}
 				break;
 			}
 		case LIST_M:{

--------------070800060907080206020408
Content-Type: application/pgp-signature;
 name="nsapolicycoreutils_semodule_semodule.c.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="nsapolicycoreutils_semodule_semodule.c.patch.sig"

iEYEABECAAYFAkma6r8ACgkQrlYvE4MpobPKLwCggLwppX0NYYvnylUP0MANWOke1pYAoKlt
nu36xZTv79OtZhsOlvSzZnKq
--------------070800060907080206020408--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

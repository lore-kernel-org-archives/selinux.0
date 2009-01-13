Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0DDvK2f013822
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 08:57:20 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0DDsXKL005751
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 13:54:33 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n0DDvIQP011726
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 08:57:18 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n0DDvJCL015455
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 08:57:19 -0500
Received: from localhost.localdomain (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n0DDvIjp021691
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 08:57:18 -0500
Message-ID: <496C9DBD.6090008@redhat.com>
Date: Tue, 13 Jan 2009 08:57:17 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Make removing of a module a warning rather then an error.
Content-Type: multipart/mixed;
 boundary="------------080509010707020406040803"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080509010707020406040803
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This way if I say a command line

semodule -r mypol -i newmypol

and mypol was not there the semodule command does not error out.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAklsnb0ACgkQrlYvE4MpobNwFACfTqc17wREKC2aAhLOIkfbqgeg
GxgAn2/ZBz5ljtyK1aiVkqoCBj98y9Ey
=I4uX
-----END PGP SIGNATURE-----

--------------080509010707020406040803
Content-Type: text/plain;
 name="policycoreutils_semodule.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils_semodule.patch"

--- nsapolicycoreutils/semodule/semodule.c	2009-01-13 08:45:35.000000000 -0500
+++ policycoreutils-2.0.60/semodule/semodule.c	2009-01-06 08:56:37.000000000 -0500
@@ -359,6 +359,9 @@
 					     mode_arg);
 				}
 				result = semanage_module_remove(sh, mode_arg);
+				if ( result == -2 ) { 
+					continue;
+				}
 				break;
 			}
 		case LIST_M:{

--------------080509010707020406040803--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

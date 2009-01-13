Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0DDu7Ev013526
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 08:56:07 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0DDu5Og024474
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 13:56:06 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n0DDtvXR011455
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 08:55:57 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n0DDtvRX015136
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 08:55:57 -0500
Received: from localhost.localdomain (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n0DDtvNg021557
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 08:55:57 -0500
Message-ID: <496C9D6C.5030704@redhat.com>
Date: Tue, 13 Jan 2009 08:55:56 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: policycoreutils_semanage.patch
Content-Type: multipart/mixed;
 boundary="------------090607010501080101040307"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090607010501080101040307
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Add missing locallist option
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAklsnWwACgkQrlYvE4MpobPZJwCguhEXCkkeS+4QPeBIDMD/sMTv
yMoAoLz7d20UABT1La/JcUaMrXr/XLF7
=L7QI
-----END PGP SIGNATURE-----

--------------090607010501080101040307
Content-Type: text/plain;
 name="policycoreutils_semanage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils_semanage.patch"

--- nsapolicycoreutils/semanage/semanage	2008-11-14 17:10:15.000000000 -0500
+++ policycoreutils-2.0.60/semanage/semanage	2009-01-13 08:55:07.000000000 -0500
@@ -219,6 +219,7 @@
 					     'seuser=',
 					     'store=',
 					     'range=',
+					     'locallist=',
 					     'level=',
 					     'roles=',
 					     'type=',
Binary files nsapolicycoreutils/semodule/semodule and policycoreutils-2.0.60/semodule/semodule differ

--------------090607010501080101040307--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

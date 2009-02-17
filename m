Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1HGgFif011484
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 11:42:15 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1HGgDZD025706
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 16:42:14 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n1HGgDhu022016
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 11:42:13 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n1HGgDl6007221
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 11:42:13 -0500
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n1HGgCV2016667
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 11:42:12 -0500
Message-ID: <499AE8E3.70807@redhat.com>
Date: Tue, 17 Feb 2009 11:42:11 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Add btrfs to fixfiles
Content-Type: multipart/mixed;
 boundary="------------070305060206060005050002"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070305060206060005050002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hopefully will convert to seclabel when it is available.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkma6OMACgkQrlYvE4MpobNegwCfSBpm7O9wIKK+O89gC+Lwx+PV
rmsAn12IADGzhFu4thYK5qakacviWwfZ
=PtIL
-----END PGP SIGNATURE-----

--------------070305060206060005050002
Content-Type: text/plain;
 name="nsapolicycoreutils_scripts_fixfiles.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsapolicycoreutils_scripts_fixfiles.patch"

--- nsapolicycoreutils/scripts/fixfiles	2008-09-12 11:48:15.000000000 -0400
+++ policycoreutils-2.0.61/scripts/fixfiles	2009-02-17 11:25:28.000000000 -0500
@@ -3,7 +3,7 @@
 #
 # Script to restore labels on a SELinux box
 #
-# Copyright (C) 2004 Red Hat, Inc.
+# Copyright (C) 2004-2009 Red Hat, Inc.
 # Authors: Dan Walsh <dwalsh@redhat.com>
 #
 # This program is free software; you can redistribute it and/or modify
@@ -36,8 +36,8 @@
 LOGGER=/usr/sbin/logger
 SETFILES=/sbin/setfiles
 RESTORECON=/sbin/restorecon
-FILESYSTEMSRW=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[234]| ext4dev | gfs2 | xfs | jfs ).*\(rw/{print $3}';`
-FILESYSTEMSRO=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[234]| ext4dev | gfs2 | xfs | jfs ).*\(ro/{print $3}';`
+FILESYSTEMSRW=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[234]| ext4dev | gfs2 | xfs | jfs | btrfs ).*\(rw/{print $3}';`
+FILESYSTEMSRO=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[234]| ext4dev | gfs2 | xfs | jfs | btrfs ).*\(ro/{print $3}';`
 FILESYSTEMS="$FILESYSTEMSRW $FILESYSTEMSRO"
 SELINUXTYPE="targeted"
 if [ -e /etc/selinux/config ]; then

--------------070305060206060005050002
Content-Type: application/pgp-signature;
 name="nsapolicycoreutils_scripts_fixfiles.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="nsapolicycoreutils_scripts_fixfiles.patch.sig"

iEYEABECAAYFAkma6OMACgkQrlYvE4MpobMXzwCg3iTpsuKUlWi3eR8alQAIliFuuB0AoNs0
0ZDyNtRTQIIoHqzrPKFSLGN+
--------------070305060206060005050002--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

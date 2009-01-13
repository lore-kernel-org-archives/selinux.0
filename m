Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0DDxsbY015069
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 08:59:54 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0DDxqOg025336
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 13:59:53 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n0DDxqY6011981
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 08:59:52 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n0DDxqB9015928
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 08:59:53 -0500
Received: from localhost.localdomain (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n0DDxqMw021926
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 08:59:52 -0500
Message-ID: <496C9E57.209@redhat.com>
Date: Tue, 13 Jan 2009 08:59:51 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: sepolgen patch
Content-Type: multipart/mixed;
 boundary="------------050902080300040504080808"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050902080300040504080808
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

md5 semodule packages is being retired.  Supposed to use hashlib now.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAklsnlcACgkQrlYvE4MpobMEHQCgiRH3w/m4vTnPSdKfYCJtPHKF
ncEAn2WdQb9l5uiUsmIvp+92mTBAcmCR
=RVRr
-----END PGP SIGNATURE-----

--------------050902080300040504080808
Content-Type: text/plain;
 name="diffsepol"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diffsepol"

diff --exclude-from=exclude -N -u -r nsasepolgen/src/sepolgen/yacc.py policycoreutils-2.0.60/sepolgen-1.0.14/src/sepolgen/yacc.py
--- nsasepolgen/src/sepolgen/yacc.py	2008-08-28 09:34:24.000000000 -0400
+++ policycoreutils-2.0.60/sepolgen-1.0.14/src/sepolgen/yacc.py	2008-12-15 15:34:55.000000000 -0500
@@ -67,7 +67,7 @@
 
 error_count = 3                # Number of symbols that must be shifted to leave recovery mode
 
-import re, types, sys, cStringIO, md5, os.path
+import re, types, sys, cStringIO, hashlib, os.path
 
 # Exception raised for yacc-related errors
 class YaccError(Exception):   pass
@@ -506,7 +506,7 @@
 
     Errorfunc    = None    # User defined error handler
 
-    Signature    = md5.new()   # Digital signature of the grammar rules, precedence
+    Signature    = hashlib.md5()   # Digital signature of the grammar rules, precedence
                                # and other information.  Used to determined when a
                                # parsing table needs to be regenerated.
 

--------------050902080300040504080808--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

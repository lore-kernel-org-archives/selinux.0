Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oBMK8cqZ006245
	for <selinux@tycho.nsa.gov>; Wed, 22 Dec 2010 15:08:38 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id oBMK8Zf4015187
	for <selinux@tycho.nsa.gov>; Wed, 22 Dec 2010 20:08:36 GMT
Message-ID: <4D125AC1.8000505@redhat.com>
Date: Wed, 22 Dec 2010 15:08:33 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "'Chad Sellers'" <csellers@tresys.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Rearranged audit2allow.1 to match the newer ways we use the tool.
Content-Type: multipart/mixed;
 boundary="------------040600090306010402080701"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040600090306010402080701
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------040600090306010402080701
Content-Type: text/plain;
 name="audit2allow_man.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="audit2allow_man.patch"

diff --git a/policycoreutils/audit2allow/audit2allow.1 b/policycoreutils/audit2allow/audit2allow.1
index 6178cc8..b6f386d 100644
--- a/policycoreutils/audit2allow/audit2allow.1
+++ b/policycoreutils/audit2allow/audit2allow.1
@@ -1,5 +1,6 @@
 .\" Hey, Emacs! This is an -*- nroff -*- source file.
 .\" Copyright (c) 2005 Manoj Srivastava <srivasta@debian.org>
+.\" Copyright (c) 2010 Dan Walsh <dwalsh@redhat.com>
 .\"
 .\" This is free documentation; you can redistribute it and/or
 .\" modify it under the terms of the GNU General Public License as
@@ -22,7 +23,7 @@
 .\" USA.
 .\"
 .\"
-.TH AUDIT2ALLOW "1" "January 2005" "Security Enhanced Linux" NSA
+.TH AUDIT2ALLOW "1" "October 2010" "Security Enhanced Linux" NSA
 .SH NAME
 .BR audit2allow
 \- generate SELinux policy allow/dontaudit rules from logs of denied operations
@@ -117,14 +121,6 @@ an 'allow' rule.
 .B Please substitute /var/log/messages for /var/log/audit/audit.log in the 
 .B examples.
 .PP
-.B Using audit2allow to generate monolithic (non-module) policy
-$ cd /etc/selinux/$SELINUXTYPE/src/policy
-$ cat /var/log/audit/audit.log | audit2allow >> domains/misc/local.te
-$ cat domains/misc/local.te
-allow cupsd_config_t unconfined_t:fifo_file { getattr ioctl };
-<review domains/misc/local.te and customize as desired>
-$ make load
-
 .B Using audit2allow to generate module policy
 
 $ cat /var/log/audit/audit.log | audit2allow -m local > local.te
@@ -132,20 +128,38 @@ $ cat local.te
 module local 1.0;
 
 require {
-        role system_r;
+        class file {  getattr open read };
 
 
-        class fifo_file {  getattr ioctl };
+        type myapp_t;
+        type etc_t;
+ };
 
 
-        type cupsd_config_t;
-        type unconfined_t;
- };
+allow myapp_t etc_t:file { getattr open read };
+<review local.te and customize as desired>
 
+.B Using audit2allow to generate module policy using reference policy
 
-allow cupsd_config_t unconfined_t:fifo_file { getattr ioctl };
+$ cat /var/log/audit/audit.log | audit2allow -R -m local > local.te
+$ cat local.te
+policy_module(local, 1.0)
+
+gen_require(`
+        type myapp_t;
+        type etc_t;
+ };
+
+files_read_etc_files(myapp_t)
 <review local.te and customize as desired>
 
+.B Building module policy using Makefile
+
+# SELinux provides a policy devel environment under /usr/share/selinux/devel
+# You can create a te file and compile it by executing 
+$ make -f /usr/share/selinux/devel/Makefile
+$ semodule -i local.pp
+
 .B Building module policy manually
 
 # Compile the module
@@ -168,6 +182,14 @@ you are required to execute
 
 semodule -i local.pp
 
+.B Using audit2allow to generate monolithic (non-module) policy
+$ cd /etc/selinux/$SELINUXTYPE/src/policy
+$ cat /var/log/audit/audit.log | audit2allow >> domains/misc/local.te
+$ cat domains/misc/local.te
+allow cupsd_config_t unconfined_t:fifo_file { getattr ioctl };
+<review domains/misc/local.te and customize as desired>
+$ make load
+
 .fi
 .PP
 .SH AUTHOR

--------------040600090306010402080701
Content-Type: application/pgp-signature;
 name="audit2allow_man.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="audit2allow_man.patch.sig"

iEYEABECAAYFAk0SWsEACgkQrlYvE4MpobMKDACggS99gkimOEqrwPBMlXMw6gems84AoNY7
s2r90F01+kTpdNyb4KcN9wCQ
--------------040600090306010402080701--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

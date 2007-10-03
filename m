Message-ID: <4703B657.2010205@redhat.com>
Date: Wed, 03 Oct 2007 11:33:43 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Man page change for semodule -D qualifier
Content-Type: multipart/mixed;
 boundary="------------010005010304070304030700"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010005010304070304030700
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------010005010304070304030700
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude --exclude=sepolgen-1.0.10 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semodule/semodule.8 policycoreutils-2.0.27/semodule/semodule.8
--- nsapolicycoreutils/semodule/semodule.8	2007-07-16 14:20:42.000000000 -0400
+++ policycoreutils-2.0.27/semodule/semodule.8	2007-10-03 11:23:39.000000000 -0400
@@ -23,6 +23,9 @@
 .B \-B, \-\-build		
 force a rebuild of policy (also reloads unless -n is used)
 .TP
+.B \-D, \-\-disable_dontaudit
+Temporarily remove dontaudits from policy.  Reverts whenever policy is rebuilt
+.TP
 .B \-i,\-\-install=MODULE_PKG
 install/replace a module package
 .TP
@@ -58,6 +61,10 @@
 $ semodule -i httpd.pp
 # List non-base modules.
 $ semodule -l
+# Turn on all AVC Messages for which SELinux currently is "dontaudit"ing.
+$ semodule -DB
+# Turn "dontaudit" rules back on.
+$ semodule -B
 # Install or replace all non-base modules in the current directory.
 $ semodule -i *.pp
 # Install or replace all modules in the current directory.

--------------010005010304070304030700
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iD8DBQBHA7ZWrlYvE4MpobMRAt15AKCQjzrDnmpfKridbhCNgw8NBdvkBgCfenyaX1iMr3Fa
Aqr49sqFIvrk8Hw=
--------------010005010304070304030700--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

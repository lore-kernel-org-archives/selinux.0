Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9Q9NqXZ010605
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2004 05:23:52 -0400 (EDT)
Received: from kokytos.rz.informatik.uni-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9Q9NpT7000917
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2004 09:23:51 GMT
Received: from rom.cip.ifi.lmu.de (rom.cip.informatik.uni-muenchen.de [141.84.214.183])
	by kokytos.rz.informatik.uni-muenchen.de (Postfix) with ESMTP id 25EA6435FF
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2004 11:23:51 +0200 (CEST)
Date: Tue, 26 Oct 2004 11:23:51 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Patch: small fix for sudo
Message-ID: <20041026092350.GB24672@rom.cip.ifi.lmu.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

Attached patch fixes one duplicate permission which is already in
newrole_domain() and moves the exec type declaration out of the macro.
The old policy generated types like staff_sudo_exec_t which is wrong, I
think.

Please apply.

Thomas

-- 
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="sudo_fix.patch"

--- orig/domains/program/newrole.te
+++ mod/domains/program/newrole.te
@@ -8,6 +8,9 @@
 # secure mode means that newrole/sudo/su/userhelper cannot reach sysadm_t
 bool secure_mode false;
 
+type newrole_exec_t, file_type, exec_type, sysadmfile;
+domain_auto_trans(userdomain, newrole_exec_t, newrole_t)
+
 newrole_domain(newrole)
 
 # Write to utmp.


--- orig/macros/program/newrole_macros.te
+++ mod/macros/program/newrole_macros.te
@@ -23,9 +23,6 @@
 # for when the user types "exec newrole" at the command line
 allow $1_t privfd:process sigchld;
 
-type $1_exec_t, file_type, exec_type, sysadmfile;
-domain_auto_trans(userdomain, $1_exec_t, $1_t)
-
 # Inherit descriptors from the current session.
 allow $1_t privfd:fd use;
 


--- orig/macros/program/sudo_macros.te
+++ mod/macros/program/sudo_macros.te
@@ -31,5 +31,4 @@
 rw_dir_create_file($1_sudo_t, $1_tmp_t)
 rw_dir_create_file($1_sudo_t, $1_home_t)
 domain_auto_trans($1_t, sudo_exec_t, $1_sudo_t)
-r_dir_file($1_sudo_t, selinux_config_t)
 ')

--azLHFNyN32YCQGCU--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

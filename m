Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9QC6TXZ011338
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2004 08:06:29 -0400 (EDT)
Received: from kokytos.rz.informatik.uni-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9QC5BC0009882
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2004 12:05:12 GMT
Received: from rom.cip.ifi.lmu.de (rom.cip.informatik.uni-muenchen.de [141.84.214.183])
	by kokytos.rz.informatik.uni-muenchen.de (Postfix) with ESMTP id 95E87435C9
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2004 14:06:29 +0200 (CEST)
Date: Tue, 26 Oct 2004 14:06:29 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: screen patch
Message-ID: <20041026120629.GC24672@rom.cip.ifi.lmu.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="QTprm0S8XgL7H0Dt"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

The following patch allows users to start screen with some other program
than the shell, e.g. "screen vim /some/file". The given command forms
the first session inside of screen.

Please apply.

Thomas

-- 
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="screen.patch"

--- orig/macros/program/screen_macros.te
+++ mod/macros/program/screen_macros.te
@@ -42,7 +42,11 @@
 allow $1_screen_t urandom_device_t:chr_file read;
 
 # Revert to the user domain when a shell is executed.
-domain_auto_trans($1_screen_t, shell_exec_t, $1_t)
+domain_auto_trans($1_screen_t, { shell_exec_t bin_t }, $1_t)
+domain_auto_trans($1_screen_t, $1_home_t, $1_t)
+ifdef(`nfs_home_dirs', `
+domain_auto_trans($1_screen_t, nfs_t, $1_t)
+')
 
 # Inherit and use descriptors from gnome-pty-helper.
 ifdef(`gnome-pty-helper.te', `allow $1_screen_t $1_gph_t:fd use;')
@@ -106,7 +110,6 @@
 allow $1_screen_t self:unix_stream_socket create_socket_perms;
 allow $1_screen_t self:unix_dgram_socket create_socket_perms;
 
-can_exec($1_screen_t, shell_exec_t)
 allow $1_screen_t bin_t:dir search;
 allow $1_screen_t bin_t:lnk_file read;
 read_locale($1_screen_t)

--QTprm0S8XgL7H0Dt--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

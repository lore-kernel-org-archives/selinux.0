Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7MCTFrT012959
	for <selinux@tycho.nsa.gov>; Sun, 22 Aug 2004 08:29:16 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7MCSTdQ004245
	for <selinux@tycho.nsa.gov>; Sun, 22 Aug 2004 12:28:30 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 0C2D461AFC
	for <selinux@tycho.nsa.gov>; Sun, 22 Aug 2004 22:29:13 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 05685-10 for <selinux@tycho.nsa.gov>;
	Sun, 22 Aug 2004 22:29:12 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 9524D61AFA
	for <selinux@tycho.nsa.gov>; Sun, 22 Aug 2004 22:29:12 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 92F65B5A2B
	for <selinux@tycho.nsa.gov>; Sun, 22 Aug 2004 22:29:10 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: logrotate policy
Date: Sun, 22 Aug 2004 22:29:09 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_VGJKBOLg7slZaht"
Message-Id: <200408222229.09972.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_VGJKBOLg7slZaht
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This policy patch fixes a couple of minor issues with logrotate and puts in a 
couple of ifdef(`distro_debian' rules.

Also I added my name to the credits.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_VGJKBOLg7slZaht
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /usr/src/se/policy/domains/program/logrotate.te	2004-07-15 10:22:49.000000000 +1000
+++ domains/program/logrotate.te	2004-08-22 22:27:10.000000000 +1000
@@ -1,7 +1,9 @@
 #DESC Logrotate - Rotate log files
 #
-# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
+# Authors:  Stephen Smalley <sds@epoch.ncsc.mil>   Timothy Fraser  
+#           Russell Coker <rcoker@redhat.com>
 # X-Debian-Packages: logrotate
+# Depends: crond.te
 #
 
 #################################
@@ -19,12 +21,19 @@
 type logrotate_exec_t, file_type, sysadmfile, exec_type;
 
 system_crond_entry(logrotate_exec_t, logrotate_t)
+allow crond_t logrotate_var_lib_t:dir search;
 domain_auto_trans(sysadm_t, logrotate_exec_t, logrotate_t)
 allow logrotate_t self:unix_stream_socket create_socket_perms;
 allow logrotate_t devtty_t:chr_file rw_file_perms;
 
+ifdef(`distro_debian', `
+# for savelog
+can_exec(logrotate_t, logrotate_exec_t)
+')
+
 # for perl
-allow logrotate_t usr_t:file { getattr read };
+allow logrotate_t usr_t:file { getattr read ioctl };
+allow logrotate_t usr_t:lnk_file read;
 
 # access files in /etc
 allow logrotate_t etc_t:file { getattr read ioctl };
--- /usr/src/se/policy/file_contexts/program/logrotate.fc	2004-06-17 15:10:43.000000000 +1000
+++ file_contexts/program/logrotate.fc	2004-08-22 22:24:23.000000000 +1000
@@ -1,7 +1,9 @@
 # logrotate
 /usr/sbin/logrotate	--	system_u:object_r:logrotate_exec_t
 /usr/sbin/logcheck	--	system_u:object_r:logrotate_exec_t
+ifdef(`distro_debian', `
 /usr/bin/savelog	--	system_u:object_r:logrotate_exec_t
+')
 /etc/cron\.(daily|weekly)/sysklogd -- system_u:object_r:logrotate_exec_t
 /var/lib/logrotate.status --	system_u:object_r:logrotate_var_lib_t
 /var/lib/logcheck(/.*)?		system_u:object_r:logrotate_var_lib_t

--Boundary-00=_VGJKBOLg7slZaht--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

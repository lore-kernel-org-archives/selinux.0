Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA21907
	for <selinux@tycho.nsa.gov>; Wed, 16 Oct 2002 18:18:03 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA06726
	for <selinux@tycho.nsa.gov>; Wed, 16 Oct 2002 22:16:11 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id WAA06722 for <selinux@tycho.nsa.gov>; Wed, 16 Oct 2002 22:16:09 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 4180F92465
	for <selinux@tycho.nsa.gov>; Thu, 17 Oct 2002 08:17:47 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id BCBC8B88
	for <selinux@tycho.nsa.gov>; Thu, 17 Oct 2002 00:17:38 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: latest policy patch
Date: Thu, 17 Oct 2002 00:17:38 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_EXH3YPPUWFHL4N0TEQRI"
Message-Id: <200210170017.38299.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_EXH3YPPUWFHL4N0TEQRI
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

This one has my latest patch.  It's nothing serious at all.

A change to postgresql policy because the start scripts run "ps".

A new type for quota databases (which needs some improvement - apparently 
different versions of quota use different names, also needs support for 
multiple file systems).

The logrotate domain needs to read apache config files so it knows how to 
restart it.

update-modules needs to read some sysctl's (the tail program which is called 
from a script needs them).  Could have used a dontaudit rule I guess, but for 
what update-modules is doing there's no reason to prevent such access (and a 
dontaudit rule could bite us later if the modutils change in an unexpected 
way).

tmpreaper needs to be able to unlink files of home_type so that
"mv ~/file /tmp" on a machine with a single file system (/tmp and /home on the 
same filesystem), doesn't result in files under /tmp that tmpreaper can't 
remove.  Sure there's probably lots of other ways of preventing tmpreaper 
from removing files, but this is a really common one that's easy to fix.  
tmpreaper can't search home_type directories so it can't invade your home dir 
either...

Steve, I think this is worthy of the CVS.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_EXH3YPPUWFHL4N0TEQRI
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff"

diff -ru /tmp/policy/domains/program/apache.te policy/domains/program/apache.te
--- /tmp/policy/domains/program/apache.te	2002-10-01 19:28:42.000000000 +0200
+++ policy/domains/program/apache.te	2002-10-14 10:29:41.000000000 +0200
@@ -401,6 +401,10 @@
 ###################################################
 allow httpd_t httpd_config_t:file r_file_perms;
 allow httpd_t httpd_config_t:dir r_dir_perms;
+# allow logrotate to read the config files for restart
+ifdef(`logrotate.te', `
+r_dir_file(logrotate_t, httpd_config_t)
+')
 ##################################################
 
 ##################################################
diff -ru /tmp/policy/domains/program/modutil.te policy/domains/program/modutil.te
--- /tmp/policy/domains/program/modutil.te	2002-10-01 19:28:44.000000000 +0200
+++ policy/domains/program/modutil.te	2002-10-16 11:37:37.000000000 +0200
@@ -132,6 +132,8 @@
 allow update_modules_t proc_t:dir search;
 allow update_modules_t proc_t:file r_file_perms;
 allow update_modules_t { self proc_t }:lnk_file read;
+allow update_modules_t sysctl_kernel_t:dir search;
+allow update_modules_t sysctl_kernel_t:file { getattr read };
 allow update_modules_t self:dir search;
 allow update_modules_t self:unix_stream_socket create_socket_perms;
 
diff -ru /tmp/policy/domains/program/mrtg.te policy/domains/program/mrtg.te
--- /tmp/policy/domains/program/mrtg.te	2002-10-17 00:01:11.000000000 +0200
+++ policy/domains/program/mrtg.te	2002-10-13 17:10:48.000000000 +0200
@@ -72,4 +72,7 @@
 # should not need this!
 allow mrtg_t sysadm_home_dir_t:dir { search read getattr };
 dontaudit mrtg_t { boot_t device_t file_labels_t file_t lost_found_t }:dir getattr;
+ifdef(`quota.te', `
+dontaudit mrtg_t quota_db_t:file getattr;
+')
 dontaudit mrtg_t root_t:lnk_file getattr;
diff -ru /tmp/policy/domains/program/passwd.te policy/domains/program/passwd.te
--- /tmp/policy/domains/program/passwd.te	2002-09-26 13:37:04.000000000 +0200
+++ policy/domains/program/passwd.te	2002-10-17 00:03:13.000000000 +0200
@@ -21,6 +21,9 @@
 domain_auto_trans(userdomain, passwd_exec_t, passwd_t)
 domain_auto_trans(sysadm_t, admin_passwd_exec_t, passwd_t)
 
+# for vipw - vi looks in the root home directory for config
+dontaudit passwd_t sysadm_home_dir_t:dir { getattr search };
+
 # Use capabilities.
 allow passwd_t passwd_t:capability { chown dac_override fsetid setuid sys_resource };
 
diff -ru /tmp/policy/domains/program/postgresql.te policy/domains/program/postgresql.te
--- /tmp/policy/domains/program/postgresql.te	2002-09-27 22:27:38.000000000 +0200
+++ policy/domains/program/postgresql.te	2002-10-16 12:03:52.000000000 +0200
@@ -56,7 +56,7 @@
 # allow any user domain to connect to the database server
 can_tcp_connect(userdomain, postgresql_t)
 
-allow postgresql_t proc_t:file { getattr read };
+allow postgresql_t { proc_t self }:file { getattr read };
 allow postgresql_t fs_t:filesystem getattr;
 
 # Allow access to the postgresql databases
diff -ru /tmp/policy/domains/program/quota.te policy/domains/program/quota.te
--- /tmp/policy/domains/program/quota.te	2002-10-01 19:28:47.000000000 +0200
+++ policy/domains/program/quota.te	2002-10-12 23:22:16.000000000 +0200
@@ -10,6 +10,7 @@
 daemon_base_domain(quota)
 
 type quota_flag_t, file_type, sysadmfile;
+type quota_db_t, file_type, sysadmfile;
 
 rw_dir_create_file(initrc_t, quota_flag_t)
 
@@ -17,8 +18,8 @@
 allow quota_t self:capability sys_admin;
 allow quota_t file_t:file quotaon;
 
-# for /quota.* - should setup a new type for it
-allow quota_t file_t:file { read write };
+# for /quota.*
+allow quota_t quota_db_t:file { read write };
 
 # Read /etc/mtab.
 allow quota_t etc_runtime_t:file { read getattr };
diff -ru /tmp/policy/domains/program/tmpreaper.te policy/domains/program/tmpreaper.te
--- /tmp/policy/domains/program/tmpreaper.te	2002-09-27 22:27:39.000000000 +0200
+++ policy/domains/program/tmpreaper.te	2002-10-13 10:27:38.000000000 +0200
@@ -19,9 +19,9 @@
 allow tmpreaper_t fcron_t:fd use;
 allow tmpreaper_t fcron_t:fifo_file { read write };
 ')
-create_dir_file(tmpreaper_t, tmpfile)
 allow tmpreaper_t tmpfile:dir { rw_dir_perms rmdir };
 allow tmpreaper_t tmpfile:notdevfile_class_set { getattr unlink };
+allow tmpreaper_t home_type:notdevfile_class_set { getattr unlink };
 allow tmpreaper_t self:process { fork sigchld };
 allow tmpreaper_t self:capability { dac_override dac_read_search fowner };
 
diff -ru /tmp/policy/file_contexts/program/fingerd.fc policy/file_contexts/program/fingerd.fc
--- /tmp/policy/file_contexts/program/fingerd.fc	2002-09-27 22:27:39.000000000 +0200
+++ policy/file_contexts/program/fingerd.fc	2002-10-12 23:23:27.000000000 +0200
@@ -1,6 +1,6 @@
 # fingerd
 /usr/sbin/in.fingerd		system_u:object_r:fingerd_exec_t
 /usr/sbin/[cef]fingerd		system_u:object_r:fingerd_exec_t
-/etc/cron.weekly/fingerd	system_u:object_r:fingerd_exec_t
+/etc/cron.weekly/(c)?fingerd	system_u:object_r:fingerd_exec_t
 /etc/cfingerd(/.*)?		system_u:object_r:etc_fingerd_t
 /var/log/cfingerd.log.*		system_u:object_r:var_log_fingerd_t
diff -ru /tmp/policy/file_contexts/program/quota.fc policy/file_contexts/program/quota.fc
--- /tmp/policy/file_contexts/program/quota.fc	2002-07-12 17:19:44.000000000 +0200
+++ policy/file_contexts/program/quota.fc	2002-10-12 23:23:55.000000000 +0200
@@ -1,3 +1,4 @@
 # quota system
 /var/lib/quota(/.*)?		system_u:object_r:quota_flag_t
 /sbin/quota(check|on)		system_u:object_r:quota_exec_t
+/quota.(user|group)		system_u:object_r:quota_db_t
diff -ru /tmp/policy/macros/program/ssh_macros.te policy/macros/program/ssh_macros.te
--- /tmp/policy/macros/program/ssh_macros.te	2002-10-17 00:01:27.000000000 +0200
+++ policy/macros/program/ssh_macros.te	2002-10-16 11:38:10.000000000 +0200
@@ -31,6 +31,9 @@
 # This domain is granted permissions common to most domains (including can_net)
 every_domain($1_ssh_t)
 
+# for sshing to a ssh tunnel
+can_tcp_connect($1_ssh_t, $1_ssh_t)
+
 # Use capabilities.
 allow $1_ssh_t self:capability { setuid setgid dac_override dac_read_search };
 

--------------Boundary-00=_EXH3YPPUWFHL4N0TEQRI--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

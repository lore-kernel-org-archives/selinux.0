Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4GE8PgA019509
	for <selinux@tycho.nsa.gov>; Mon, 16 May 2005 10:08:25 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4GE4lhq026762
	for <selinux@tycho.nsa.gov>; Mon, 16 May 2005 14:04:48 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id CEEEC61AEC
	for <selinux@tycho.nsa.gov>; Mon, 16 May 2005 10:58:52 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 02389-01 for <selinux@tycho.nsa.gov>;
	Mon, 16 May 2005 10:58:52 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 3452561AEB
	for <selinux@tycho.nsa.gov>; Mon, 16 May 2005 10:58:52 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id DEDAF38
	for <selinux@tycho.nsa.gov>; Tue, 17 May 2005 00:04:59 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux <selinux@tycho.nsa.gov>
Subject: crond_log_t
Date: Tue, 17 May 2005 00:04:55 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KiKiC2CojSozovl"
Message-Id: <200505170004.58546.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_KiKiC2CojSozovl
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

What is the point of the type crond_log_t?

It's been in the policy for ages but I don't recall any time at which it had a 
purpose.

/var/log/cron* are the only files to get that type according to the file 
contexts.  /var/log/cron* files need no special protection and they are 
written by syslogd (which usually writes files with type var_log_t).  If we 
are going to apply some special protection to syslogd output then we should 
probably start with /var/log/secure...

crond.te allows crond_t and system_crond_t to write to crond_log_t.  If we 
only have one file on the system that is a candidate for writing with that 
label then having system_crond_t, crond_t, and syslogd_t fighting over who 
gets to write to it seems like a bad idea.

I suggest the attached patch as the solution to this problem.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_KiKiC2CojSozovl
Content-Type: text/x-diff;
  charset="us-ascii";
  name="d"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="d"

diff -ru orig/domains/program/crond.te new/domains/program/crond.te
--- orig/domains/program/crond.te	2005-05-03 06:18:36.000000000 +1000
+++ new/domains/program/crond.te	2005-05-17 00:02:49.000000000 +1000
@@ -43,8 +43,6 @@
 
 read_locale(crond_t)
 
-log_domain(crond)
-
 # Use capabilities.
 allow crond_t self:capability { dac_override setgid setuid net_bind_service sys_nice };
 dontaudit crond_t self:capability sys_resource;
@@ -103,9 +101,6 @@
 # Still need to study anacron.
 domain_auto_trans(initrc_t, anacron_exec_t, system_crond_t)
 
-# Access log files
-file_type_auto_trans(system_crond_t, var_log_t, crond_log_t, file)
-
 # Inherit and use descriptors from init for anacron.
 allow system_crond_t init_t:fd use;
 
diff -ru orig/domains/program/syslogd.te new/domains/program/syslogd.te
--- orig/domains/program/syslogd.te	2005-05-03 06:18:36.000000000 +1000
+++ new/domains/program/syslogd.te	2005-05-17 00:03:05.000000000 +1000
@@ -64,8 +64,6 @@
 allow privlog devlog_t:lnk_file read;
 
 ifdef(`crond.te', `
-# Write to the cron log.
-allow syslogd_t crond_log_t:file rw_file_perms;
 # for daemon re-start
 allow system_crond_t syslogd_t:lnk_file read;
 ')
diff -ru orig/file_contexts/program/crond.fc new/file_contexts/program/crond.fc
--- orig/file_contexts/program/crond.fc	2005-05-03 06:18:36.000000000 +1000
+++ new/file_contexts/program/crond.fc	2005-05-17 00:03:38.000000000 +1000
@@ -9,7 +9,6 @@
 /var/spool/cron/crontabs/root -- system_u:object_r:sysadm_cron_spool_t
 /var/spool/cron/root	--	system_u:object_r:sysadm_cron_spool_t
 /var/spool/cron/[^/]*	--	<<none>>
-/var/log/cron.*		--	system_u:object_r:crond_log_t
 /var/run/crond\.reboot	--	system_u:object_r:crond_var_run_t
 /var/run/crond?\.pid	--	system_u:object_r:crond_var_run_t
 # fcron
diff -ru orig/types/file.te new/types/file.te
--- orig/types/file.te	2005-05-03 06:18:36.000000000 +1000
+++ new/types/file.te	2005-05-17 00:03:23.000000000 +1000
@@ -188,6 +188,7 @@
 #
 type var_run_t, file_type, sysadmfile;
 type var_log_t, file_type, sysadmfile, logfile;
+typealias var_log_t alias crond_log_t;
 type faillog_t, file_type, sysadmfile, logfile;
 type var_lock_t, file_type, sysadmfile, lockfile;
 type var_lib_t, file_type, sysadmfile;

--Boundary-00=_KiKiC2CojSozovl--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

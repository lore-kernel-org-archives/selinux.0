Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8OJjOrT020363
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 15:45:25 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8OJiMxO009851
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 19:44:23 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: sendmail and cron policy
Date: Sat, 25 Sep 2004 05:45:20 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QlHVBk9/hE6HpG+"
Message-Id: <200409250545.20316.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_QlHVBk9/hE6HpG+
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch allows sysadm cron jobs to run setfiles without AVC 
messages, and also allows sendmail to be run from sysadm_t without AVC 
messages.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_QlHVBk9/hE6HpG+
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /usr/src/se/policy/domains/program/crond.te	2004-09-16 18:06:45.000000000 +1000
+++ ./domains/program/crond.te	2004-09-25 05:28:40.000000000 +1000
@@ -39,6 +39,8 @@
 allow system_crond_t etc_t:file r_file_perms;
 allow system_crond_t etc_runtime_t:file read;
 
+allow system_crond_t { sysfs_t rpc_pipefs_t }:dir getattr;
+
 read_locale(crond_t)
 
 log_domain(crond)
@@ -110,7 +112,7 @@
 allow system_crond_t initrc_devpts_t:chr_file { read write };
 
 # Use capabilities.
-allow system_crond_t self:capability { chown setgid setuid fowner net_bind_service fsetid };
+allow system_crond_t self:capability { dac_read_search chown setgid setuid fowner net_bind_service fsetid };
 
 # Read the system crontabs.
 allow system_crond_t system_cron_spool_t:file r_file_perms;
--- /usr/src/se/policy/macros/program/sendmail_macros.te	2004-03-18 15:36:09.000000000 +1100
+++ ./macros/program/sendmail_macros.te	2004-09-25 05:42:27.000000000 +1000
@@ -44,7 +44,7 @@
 
 ifelse(`$1', `sysadm', `
 allow $1_mail_t proc_t:dir { getattr search };
-allow $1_mail_t proc_t:file { getattr read };
+allow $1_mail_t proc_t:{ lnk_file file } { getattr read };
 allow $1_mail_t sysctl_kernel_t:file { getattr read };
 allow $1_mail_t etc_runtime_t:file { getattr read };
 ', `

--Boundary-00=_QlHVBk9/hE6HpG+--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

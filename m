Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id AAA27458
	for <selinux@tycho.nsa.gov>; Sat, 21 Sep 2002 00:29:13 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id EAA25631
	for <selinux@tycho.nsa.gov>; Sat, 21 Sep 2002 04:27:47 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id EAA25625
	for <selinux@tycho.nsa.gov>; Sat, 21 Sep 2002 04:27:45 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 6F19D92472
	for <selinux@tycho.nsa.gov>; Sat, 21 Sep 2002 14:29:08 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id CD7F16CB
	for <selinux@tycho.nsa.gov>; Sat, 21 Sep 2002 06:28:58 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: var_t
Date: Sat, 21 Sep 2002 06:28:58 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_ASTRT3R9CDUKTY4XCSB5"
Message-Id: <200209210628.58180.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_ASTRT3R9CDUKTY4XCSB5
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I've attached a patch file giving daemons access to var_t.

Many things need getattr access because if /var is a separate file system then 
for bash to run "cd /var/whatever" you need getattr access.

-- 
There is no point PGP/GPG signing an email unless the signature can be
verified.  If you post to a list then don't sign the message unless your
key is available on public key servers and has been signed by someone
who is in the web of trust, otherwise you just waste bandwidth and CPU.

--------------Boundary-00=_ASTRT3R9CDUKTY4XCSB5
Content-Type: text/x-diff;
  charset="us-ascii";
  name="var.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="var.diff"

diff -ru /tmp/policy/domains/program/acct.te policy/domains/program/acct.te
--- /tmp/policy/domains/program/acct.te	2002-08-23 21:04:27.000000000 +0200
+++ policy/domains/program/acct.te	2002-09-12 10:28:18.000000000 +0200
@@ -18,6 +18,8 @@
 
 # gzip needs chown capability for some reason
 allow acct_t self:capability chown;
+
+allow acct_t var_t:dir { getattr search };
 rw_dir_create_file(acct_t, acct_data_t)
 
 can_exec(acct_t, { shell_exec_t bin_t etc_t acct_exec_t })
diff -ru /tmp/policy/domains/program/crack.te policy/domains/program/crack.te
--- /tmp/policy/domains/program/crack.te	2002-09-21 05:01:25.000000000 +0200
+++ policy/domains/program/crack.te	2002-09-19 23:39:01.000000000 +0200
@@ -12,10 +12,15 @@
 domain_auto_trans(system_crond_t, crack_exec_t, crack_t)
 
 type crack_db_t, file_type, sysadmfile;
+allow crack_t var_t:dir search;
 rw_dir_create_file(crack_t, crack_db_t)
 
 allow crack_t crond_t:fd use;
 allow crack_t crond_t:fifo_file r_file_perms;
+ifdef(`fcron.te', `
+allow crack_t fcron_t:fd use;
+allow crack_t fcron_t:fifo_file r_file_perms;
+')
 allow crack_t device_t:dir search;
 allow crack_t devtty_t:chr_file rw_file_perms;
 allow crack_t self:fifo_file { read write getattr };
diff -ru /tmp/policy/domains/program/dpkg.te policy/domains/program/dpkg.te
--- /tmp/policy/domains/program/dpkg.te	2002-09-21 06:04:23.000000000 +0200
+++ policy/domains/program/dpkg.te	2002-09-21 05:19:00.000000000 +0200
@@ -224,6 +224,7 @@
 allow install_menu_t { bin_t sbin_t }:dir search;
 allow install_menu_t bin_t:lnk_file read;
 
+allow install_menu_t var_t:dir search;
 file_type_auto_trans(install_menu_t, var_run_t, install_menu_var_run_t)
 file_type_auto_trans(install_menu_t, tmp_t, install_menu_tmp_t)
 
diff -ru /tmp/policy/domains/program/mrtg.te policy/domains/program/mrtg.te
--- /tmp/policy/domains/program/mrtg.te	2002-09-21 05:01:27.000000000 +0200
+++ policy/domains/program/mrtg.te	2002-09-19 10:39:55.000000000 +0200
@@ -34,6 +34,7 @@
 can_exec(mrtg_t, { shell_exec_t bin_t sbin_t })
 allow mrtg_t { bin_t sbin_t }:dir { getattr search };
 allow mrtg_t bin_t:lnk_file read;
+allow mrtg_t var_t:dir { getattr search };
 r_dir_file(mrtg_t, var_lib_snmpd_t)
 
 ifdef(`snmpd.te', `
@@ -55,6 +56,7 @@
 allow mrtg_t sysctl_kernel_t:file read;
 
 # for uptime
+allow mrtg_t var_run_t:dir search;
 allow mrtg_t initrc_var_run_t:file read;
 dontaudit mrtg_t initrc_var_run_t:file { write lock };
 allow mrtg_t etc_runtime_t:file { getattr read };
diff -ru /tmp/policy/domains/program/procmail.te policy/domains/program/procmail.te
--- /tmp/policy/domains/program/procmail.te	2002-09-09 19:54:14.000000000 +0200
+++ policy/domains/program/procmail.te	2002-09-21 05:33:25.000000000 +0200
@@ -35,7 +35,7 @@
 # for /var/mail
 rw_dir_create_file(procmail_t, mail_spool_t)
 
-allow procmail_t var_t:dir r_dir_perms;
+allow procmail_t var_t:dir { getattr search };
 allow procmail_t var_spool_t:dir r_dir_perms;
 
 allow procmail_t fs_t:filesystem getattr;
diff -ru /tmp/policy/domains/program/sysstat.te policy/domains/program/sysstat.te
--- /tmp/policy/domains/program/sysstat.te	2002-09-21 05:01:28.000000000 +0200
+++ policy/domains/program/sysstat.te	2002-09-19 11:49:41.000000000 +0200
@@ -35,6 +35,7 @@
 # Type for files created during execution of sysstatd.
 type var_log_sysstat_t, file_type, sysadmfile;
 
+allow sysstat_t var_t:dir search;
 allow sysstat_t var_log_t:dir r_dir_perms;
 allow sysstat_t var_log_sysstat_t:dir rw_dir_perms;
 allow sysstat_t var_log_sysstat_t:file create_file_perms;
diff -ru /tmp/policy/domains/program/tmpreaper.te policy/domains/program/tmpreaper.te
--- /tmp/policy/domains/program/tmpreaper.te	2002-09-09 19:54:16.000000000 +0200
+++ policy/domains/program/tmpreaper.te	2002-09-21 05:37:06.000000000 +0200
@@ -22,7 +26,7 @@
 allow tmpreaper_t self:capability { dac_override dac_read_search fowner };
 
 r_dir_file(tmpreaper_t, etc_t)
-r_dir_file(tmpreaper_t, var_t)
+allow tmpreaper_t var_t:dir { getattr search };
 r_dir_file(tmpreaper_t, var_lib_t)
 allow tmpreaper_t device_t:dir { getattr search };
 
diff -ru /tmp/policy/macros/global_macros.te policy/macros/global_macros.te
--- /tmp/policy/macros/global_macros.te	2002-09-21 05:01:30.000000000 +0200
+++ policy/macros/global_macros.te	2002-09-12 10:32:52.000000000 +0200
@@ -928,7 +928,7 @@
 allow $1_t { self proc_t }:dir r_dir_perms;
 allow $1_t { self proc_t }:lnk_file read;
 
-allow $1_t device_t:dir search;
+allow $1_t device_t:dir { getattr search };
 allow $1_t null_device_t:chr_file rw_file_perms;
 allow $1_t console_device_t:chr_file rw_file_perms;
 ')dnl
@@ -936,7 +936,7 @@
 define(`daemon_domain', `
 daemon_base_domain($1, `$2')
 # Create pid file.
-allow $1_t var_t:dir search;
+allow $1_t var_t:dir { getattr search };
 type var_run_$1_t, file_type, sysadmfile, pidfile;
 file_type_auto_trans($1_t, var_run_t, var_run_$1_t)
 

--------------Boundary-00=_ASTRT3R9CDUKTY4XCSB5--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA16271
	for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2002 15:36:17 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA05245
	for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2002 19:34:23 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id TAA05241 for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2002 19:34:20 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 1620E92713
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2002 05:36:10 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 5157AADD
	for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2002 21:36:02 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: patch for latest release
Date: Wed, 23 Oct 2002 21:36:01 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_149GGIZLPAV1R6DZOEZB"
Message-Id: <200210232136.01880.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_149GGIZLPAV1R6DZOEZB
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I've attached my latest patch against the recent release.

The ipsec change is merely cosmetic, it removed duplicate entries and combines 
some entries, but a policy file that ugly needs some cosmetic changes.  ;)

The samba changes are apparently related to newer versions of samba and only 
are needed in some situations.  The older versions of samba (which I 
understood) didn't need such things, and the new version didn't show a need 
for it when I first installed SE on a sometimes-samba machine.

I've allowed squid to setuid/setgid because the default setup of squid on 
Debian wants to change it's uid/gid to proxy/proxy and forcing everyone to 
change their config.

I changed the file_contexts entries for /var/spool/mail to be in mta.fc 
instead of sendmail.fc because it applies to all mail servers.

I changed crontab_macros.te to not audit writes to the home directory (when 
vim wants to create it's config file).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_149GGIZLPAV1R6DZOEZB
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff"

diff -ru /tmp/t/policy/domains/program/dpkg.te policy/domains/program/dpkg.te
--- /tmp/t/policy/domains/program/dpkg.te	2002-10-01 21:03:32.000000000 +0200
+++ policy/domains/program/dpkg.te	2002-10-23 19:58:50.000000000 +0200
@@ -60,6 +60,11 @@
 ifdef(`named.te', `
 file_type_auto_trans(dpkg_t, named_zone_t, rndc_conf_t)
 ')
+# because the syslogd package is broken and does not use the start scripts
+ifdef(`syslogd.te', `
+domain_auto_trans(dpkg_t, klogd_exec_t, klogd_t)
+domain_auto_trans(dpkg_t, syslogd_exec_t, syslogd_t)
+')
 
 # for apt
 type apt_t, domain, admin, privmail;
diff -ru /tmp/t/policy/domains/program/fingerd.te policy/domains/program/fingerd.te
--- /tmp/t/policy/domains/program/fingerd.te	2002-10-01 20:14:03.000000000 +0200
+++ policy/domains/program/fingerd.te	2002-10-23 19:59:08.000000000 +0200
@@ -35,6 +35,8 @@
 allow fingerd_t inetd_t:tcp_socket { read write getattr ioctl };
 
 allow fingerd_t self:capability { setgid setuid };
+# for gzip from logrotate
+dontaudit fingerd_t self:capability fsetid;
 
 # cfingerd runs shell scripts
 allow fingerd_t { bin_t sbin_t }:dir search;
diff -ru /tmp/t/policy/domains/program/gatekeeper.te policy/domains/program/gatekeeper.te
--- /tmp/t/policy/domains/program/gatekeeper.te	2002-08-21 20:22:44.000000000 +0200
+++ policy/domains/program/gatekeeper.te	2002-10-23 20:00:12.000000000 +0200
@@ -17,6 +17,9 @@
 can_network(gatekeeper_t)
 allow gatekeeper_t self:unix_stream_socket create_socket_perms;
 
+# for stupid symlinks
+tmp_domain(gatekeeper)
+
 # pthreads wants to know the kernel version
 allow gatekeeper_t sysctl_kernel_t:dir r_dir_perms;
 allow gatekeeper_t sysctl_kernel_t:file r_file_perms;
diff -ru /tmp/t/policy/domains/program/ipsec.te policy/domains/program/ipsec.te
--- /tmp/t/policy/domains/program/ipsec.te	2002-09-23 18:10:02.000000000 +0200
+++ policy/domains/program/ipsec.te	2002-10-23 20:06:33.000000000 +0200
@@ -114,20 +114,11 @@
 dontaudit ipsec_mgmt_t domain:key_socket { read write };
 dontaudit ipsec_mgmt_t domain:udp_socket { read write };
 
-#
-# bits and pieces from other files to make this as self-contained as possible
-#
-
 # from rbac
-role system_r types {
-	ipsec_t
-	ipsec_mgmt_t
-};
+role system_r types { ipsec_t ipsec_mgmt_t };
 
 # from initrc.te
 domain_auto_trans(initrc_t, ipsec_mgmt_exec_t, ipsec_mgmt_t)
-# i don't know if this is really needed anymore...
-# allow initrc_t ipsec_var_run_t:sock_file { read write };
 
 # from init.te
 type_transition init_t ipsec_mgmt_exec_t:process ipsec_mgmt_t;
@@ -136,8 +127,7 @@
 ########## The following rules were added by cvance@tislabs.com ##########
 
 # allow pluto and startup scripts to access /dev/urandom
-allow ipsec_t random_device_t:chr_file r_file_perms;
-allow ipsec_mgmt_t random_device_t:chr_file r_file_perms;
+allow { ipsec_t ipsec_mgmt_t } random_device_t:chr_file r_file_perms;
 
 # allow pluto to access /proc/net/ipsec_eroute;
 general_proc_read_access(ipsec_t)
@@ -145,26 +135,21 @@
 
 # allow pluto to search the root directory (not sure why, but mostly harmless)
 # Are these all really necessary?
-allow ipsec_t root_t:dir r_dir_perms;
-allow ipsec_t etc_t:dir { search };
 allow ipsec_t var_t:dir { search };
 allow ipsec_t bin_t:dir { search };
-allow ipsec_t device_t:dir { search };
-allow ipsec_mgmt_t etc_t:dir { search };
+allow ipsec_t device_t:dir { getattr search };
+allow ipsec_mgmt_t device_t:dir { getattr search read };
+dontaudit ipsec_mgmt_t tty_device_t:chr_file getattr;
+dontaudit ipsec_mgmt_t devpts_t:dir getattr;
 allow ipsec_mgmt_t etc_t:lnk_file read;
 allow ipsec_mgmt_t var_t:dir { search };
 allow ipsec_mgmt_t sbin_t:dir { search };
 allow ipsec_mgmt_t bin_t:dir { search };
-allow ipsec_mgmt_t device_t:dir { search };
 allow ipsec_mgmt_t ipsec_var_run_t:file { getattr read };
 
 # Startup scripts
 # use libraries
-uses_shlib(ipsec_mgmt_t)
-uses_shlib(ipsec_t)
-allow ipsec_mgmt_t lib_t:dir r_dir_perms;
-# access /usr/share/locale 
-allow ipsec_mgmt_t usr_t:file r_file_perms;
+uses_shlib({ ipsec_t ipsec_mgmt_t })
 # Read and write /dev/tty
 allow ipsec_mgmt_t devtty_t:chr_file rw_file_perms;
 # fork
@@ -174,8 +159,7 @@
 # read /etc/mtab Why?
 allow ipsec_mgmt_t etc_runtime_t:file { read getattr };
 # read link for /bin/sh 
-allow ipsec_mgmt_t bin_t:lnk_file read;
-allow ipsec_t bin_t:lnk_file read;
+allow { ipsec_t ipsec_mgmt_t } bin_t:lnk_file read;
 
 #
 allow ipsec_mgmt_t self:process { sigchld signal };
diff -ru /tmp/t/policy/domains/program/logrotate.te policy/domains/program/logrotate.te
--- /tmp/t/policy/domains/program/logrotate.te	2002-09-27 23:22:50.000000000 +0200
+++ policy/domains/program/logrotate.te	2002-10-23 21:05:52.000000000 +0200
@@ -21,6 +21,9 @@
 # it should not require this
 allow logrotate_t sysadm_home_dir_t:dir { read getattr search };
 
+# create lock files
+rw_dir_create_file(logrotate_t, var_lock_t)
+
 # Create temporary files.
 tmp_domain(logrotate)
 
diff -ru /tmp/t/policy/domains/program/samba.te policy/domains/program/samba.te
--- /tmp/t/policy/domains/program/samba.te	2002-10-01 20:14:03.000000000 +0200
+++ policy/domains/program/samba.te	2002-10-23 20:09:39.000000000 +0200
@@ -16,6 +16,13 @@
 type samba_share_t, file_type, sysadmfile;
 type samba_secrets_t, file_type, sysadmfile;
 
+# for /var/run/samba/messages.tdb
+allow smbd_t var_run_nmbd_t:file rw_file_perms;
+
+ifdef(`crond.te', `
+allow system_crond_t samba_etc_t:file { read getattr };
+')
+
 #################################
 #
 # Rules for the smbd_t domain.
@@ -37,7 +44,7 @@
 
 # Permissions for Samba files in /etc/samba
 # either allow read access to the directory or allow the auto_trans rule to
-# allow creation of the secrets.tdb file
+# allow creation of the secrets.tdb file and the MACHINE.SID file
 #allow smbd_t samba_etc_t:dir { search getattr };
 file_type_auto_trans(smbd_t, samba_etc_t, samba_secrets_t, file)
 
diff -ru /tmp/t/policy/domains/program/squid.te policy/domains/program/squid.te
--- /tmp/t/policy/domains/program/squid.te	2002-10-01 21:03:32.000000000 +0200
+++ policy/domains/program/squid.te	2002-10-23 20:10:15.000000000 +0200
@@ -25,6 +25,7 @@
 # type for /var/cache/squid
 type squid_cache_t, file_type, sysadmfile;
 
+allow squid_t squid_t:capability { setgid setuid };
 allow squid_t { etc_t etc_runtime_t }:file r_file_perms;
 allow squid_t etc_t:lnk_file read;
 allow squid_t self:unix_stream_socket create_socket_perms;
diff -ru /tmp/t/policy/file_contexts/program/mta.fc policy/file_contexts/program/mta.fc
--- /tmp/t/policy/file_contexts/program/mta.fc	2002-08-21 20:22:47.000000000 +0200
+++ policy/file_contexts/program/mta.fc	2002-10-23 20:11:48.000000000 +0200
@@ -2,3 +2,5 @@
 /usr/sbin/sendmail(.sendmail)?	system_u:object_r:sendmail_exec_t
 /etc/aliases			system_u:object_r:etc_aliases_t
 /etc/aliases.db			system_u:object_r:etc_aliases_t
+/var/spool/mail(/.*)?		system_u:object_r:mail_spool_t
+/var/mail(/.*)?			system_u:object_r:mail_spool_t
diff -ru /tmp/t/policy/file_contexts/program/samba.fc policy/file_contexts/program/samba.fc
--- /tmp/t/policy/file_contexts/program/samba.fc	2002-10-01 20:14:03.000000000 +0200
+++ policy/file_contexts/program/samba.fc	2002-10-23 20:12:00.000000000 +0200
@@ -4,4 +4,6 @@
 /etc/samba(/.*)?		system_u:object_r:samba_etc_t
 /var/log/samba(/.*)?		system_u:object_r:samba_log_t
 /var/cache/samba(/.*)?		system_u:object_r:samba_var_t
+/var/lib/samba(/.*)?		system_u:object_r:samba_var_t
 /etc/samba/secrets.tdb		system_u:object_r:samba_secrets_t
+/etc/samba/MACHINE.SID		system_u:object_r:samba_secrets_t
diff -ru /tmp/t/policy/file_contexts/program/sendmail.fc policy/file_contexts/program/sendmail.fc
--- /tmp/t/policy/file_contexts/program/sendmail.fc	2002-08-29 14:21:31.000000000 +0200
+++ policy/file_contexts/program/sendmail.fc	2002-10-23 20:12:12.000000000 +0200
@@ -1,6 +1,4 @@
 # sendmail
 /etc/mail(/.*)?			system_u:object_r:etc_mail_t
-/var/spool/mail(/.*)?		system_u:object_r:mail_spool_t
 /var/spool/mqueue(/.*)?		system_u:object_r:mqueue_spool_t
 /var/log/sendmail.st		system_u:object_r:sendmail_var_log_t
-/var/mail(/.*)?			system_u:object_r:mail_spool_t
diff -ru /tmp/t/policy/macros/program/crontab_macros.te policy/macros/program/crontab_macros.te
--- /tmp/t/policy/macros/program/crontab_macros.te	2002-10-01 21:03:33.000000000 +0200
+++ policy/macros/program/crontab_macros.te	2002-10-23 20:16:40.000000000 +0200
@@ -65,6 +65,7 @@
 # Read user crontabs 
 allow $1_crontab_t { $1_home_t $1_home_dir_t }:dir r_dir_perms;  
 allow $1_crontab_t $1_home_t:file r_file_perms;  
+dontaudit $1_crontab_t $1_home_dir_t:dir write;
 
 # Access the cron log file.
 allow $1_crontab_t cron_log_t:file r_file_perms;

--------------Boundary-00=_149GGIZLPAV1R6DZOEZB--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

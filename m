Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72Kl6TN026481
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:47:06 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72Kl4Tm008191
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:47:04 GMT
Date: Thu, 2 Aug 2007 16:47:00 -0400
Message-Id: <200708022047.l72Kl0oK000323@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_ntp changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add support for ntp secret keys

--- nsaserefpolicy/policy/modules/services/ntp.fc	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/ntp.fc	2007-08-02 11:02:02.000000000 -0400
@@ -17,3 +17,7 @@
 /var/log/xntpd.*		--	gen_context(system_u:object_r:ntpd_log_t,s0)
 
 /var/run/ntpd\.pid		--	gen_context(system_u:object_r:ntpd_var_run_t,s0)
+
+/etc/ntp/crypto(/.*)?         gen_context(system_u:object_r:ntpd_key_t,s0)
+/etc/ntp/keys              -- gen_context(system_u:object_r:ntpd_key_t,s0)
+
--- nsaserefpolicy/policy/modules/services/ntp.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/ntp.te	2007-08-02 11:02:02.000000000 -0400
@@ -25,6 +25,9 @@
 type ntpdate_exec_t;
 init_system_domain(ntpd_t,ntpdate_exec_t)
 
+type ntpd_key_t;
+files_type(ntpd_key_t)
+
 ########################################
 #
 # Local policy
@@ -36,6 +39,7 @@
 dontaudit ntpd_t self:capability { net_admin sys_tty_config fsetid sys_nice };
 allow ntpd_t self:process { signal_perms setcap setsched setrlimit };
 allow ntpd_t self:fifo_file { read write getattr };
+allow ntpd_t self:shm create_shm_perms;
 allow ntpd_t self:unix_dgram_socket create_socket_perms;
 allow ntpd_t self:unix_stream_socket create_socket_perms;
 allow ntpd_t self:tcp_socket create_stream_socket_perms;
@@ -49,6 +53,8 @@
 manage_files_pattern(ntpd_t,ntpd_log_t,ntpd_log_t)
 logging_log_filetrans(ntpd_t,ntpd_log_t,{ file dir })
 
+read_files_pattern(ntpd_t,ntpd_key_t,ntpd_key_t)
+
 # for some reason it creates a file in /tmp
 manage_dirs_pattern(ntpd_t,ntpd_tmp_t,ntpd_tmp_t)
 manage_files_pattern(ntpd_t,ntpd_tmp_t,ntpd_tmp_t)
@@ -82,6 +88,8 @@
 
 fs_getattr_all_fs(ntpd_t)
 fs_search_auto_mountpoints(ntpd_t)
+# Necessary to communicate with gpsd devices
+fs_rw_tmpfs_files(ntpd_t)
 
 auth_use_nsswitch(ntpd_t)
 
@@ -107,6 +115,8 @@
 
 sysnet_read_config(ntpd_t)
 
+term_use_ptmx(ntpd_t)
+
 userdom_dontaudit_use_unpriv_user_fds(ntpd_t)
 userdom_list_sysadm_home_dirs(ntpd_t)
 userdom_dontaudit_list_sysadm_home_dirs(ntpd_t)
@@ -126,9 +136,14 @@
 ')
 
 optional_policy(`
+	hal_dontaudit_write_log(ntpd_t)
+')
+
+optional_policy(`
 	seutil_sigchld_newrole(ntpd_t)
 ')
 
 optional_policy(`
 	udev_read_db(ntpd_t)
 ')
+

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

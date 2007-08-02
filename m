Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72IHrIW012462
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 14:17:53 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72IHpev007234
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 18:17:52 GMT
Date: Thu, 2 Aug 2007 14:17:48 -0400
Message-Id: <200708021817.l72IHm5X022833@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: admin_readahead changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/admin/readahead.fc	2007-05-29 14:10:59.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/admin/readahead.fc	2007-08-02 11:02:02.000000000 -0400
@@ -2,3 +2,4 @@
 # /usr
 #
 /usr/sbin/readahead	--	gen_context(system_u:object_r:readahead_exec_t,s0)
+/etc/readahead.d(/.*)?		gen_context(system_u:object_r:readahead_etc_rw_t,s0)
--- nsaserefpolicy/policy/modules/admin/readahead.te	2007-07-25 10:37:43.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/admin/readahead.te	2007-08-02 11:43:14.000000000 -0400
@@ -9,19 +9,24 @@
 type readahead_t;
 type readahead_exec_t;
 init_daemon_domain(readahead_t,readahead_exec_t)
-application_domain(readahead_t,readahead_exec_t)
 
 type readahead_var_run_t;
 files_pid_file(readahead_var_run_t)
 
+type readahead_etc_rw_t;
+files_pid_file(readahead_etc_rw_t)
+
 ########################################
 #
 # Local policy
 #
 
-dontaudit readahead_t self:capability { dac_override dac_read_search sys_tty_config };
+allow readahead_t self:capability { dac_override dac_read_search };
+dontaudit readahead_t self:capability sys_tty_config;
 allow readahead_t self:process signal_perms;
 
+manage_files_pattern(readahead_t,readahead_etc_rw_t,readahead_etc_rw_t)
+
 manage_files_pattern(readahead_t,readahead_var_run_t,readahead_var_run_t)
 files_pid_filetrans(readahead_t,readahead_var_run_t,file)
 
@@ -37,7 +42,7 @@
 dev_dontaudit_read_all_blk_files(readahead_t)
 dev_dontaudit_getattr_memory_dev(readahead_t)
 dev_dontaudit_getattr_nvram_dev(readahead_t)
-storage_dontaudit_getattr_fixed_disk_dev(readahead_t)
+storage_raw_read_fixed_disk(readahead_t)
 
 domain_use_interactive_fds(readahead_t)
 
@@ -68,6 +73,7 @@
 libs_use_shared_libs(readahead_t)
 
 logging_send_syslog_msg(readahead_t)
+logging_dontaudit_search_audit_config(readahead_t)
 
 miscfiles_read_localization(readahead_t)
 
@@ -75,5 +81,9 @@
 userdom_dontaudit_search_sysadm_home_dirs(readahead_t)
 
 optional_policy(`
+	cron_system_entry(readahead_t, readahead_exec_t)
+')
+
+optional_policy(`
 	seutil_sigchld_newrole(readahead_t)
 ')
From:  dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: system_logging changes
--text follows this line--
--- nsaserefpolicy/policy/modules/system/logging.fc	2007-05-29 14:10:58.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/system/logging.fc	2007-08-02 11:02:02.000000000 -0400
@@ -1,12 +1,15 @@
-
 /dev/log		-s	gen_context(system_u:object_r:devlog_t,s0)
 
+/etc/rsyslog.conf		gen_context(system_u:object_r:syslog_conf_t,s0)
+/etc/syslog.conf		gen_context(system_u:object_r:syslog_conf_t,s0)
 /etc/audit(/.*)?		gen_context(system_u:object_r:auditd_etc_t,mls_systemhigh)
 
 /sbin/auditctl		--	gen_context(system_u:object_r:auditctl_exec_t,s0)
 /sbin/auditd		--	gen_context(system_u:object_r:auditd_exec_t,s0)
+/sbin/rklogd		--	gen_context(system_u:object_r:klogd_exec_t,s0)
 /sbin/klogd		--	gen_context(system_u:object_r:klogd_exec_t,s0)
 /sbin/minilogd		--	gen_context(system_u:object_r:syslogd_exec_t,s0)
+/sbin/rsyslogd		--	gen_context(system_u:object_r:syslogd_exec_t,s0)
 /sbin/syslogd		--	gen_context(system_u:object_r:syslogd_exec_t,s0)
 /sbin/syslog-ng		--	gen_context(system_u:object_r:syslogd_exec_t,s0)
 
@@ -43,3 +46,5 @@
 /var/spool/postfix/pid	-d	gen_context(system_u:object_r:var_run_t,s0)
 
 /var/tinydns/log/main(/.*)?	gen_context(system_u:object_r:var_log_t,s0)
+
+/var/log/syslog-ng(/.*)?	--	gen_context(system_u:object_r:syslogd_var_run_t,s0)
--- nsaserefpolicy/policy/modules/system/logging.if	2007-06-15 14:54:34.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/system/logging.if	2007-08-02 11:02:02.000000000 -0400
@@ -317,6 +379,25 @@
 
 ########################################
 ## <summary>
+##	dontaudit search of auditd configuration files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`logging_dontaudit_search_audit_config',`
+	gen_require(`
+		type auditd_etc_t;
+	')
+
+	dontaudit $1 auditd_etc_t:dir search_dir_perms;
+')
+
+########################################
+## <summary>
 ##	Allows the domain to open a file in the
 ##	log directory, but does not allow the listing
 ##	of the contents of the log directory.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

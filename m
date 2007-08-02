Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72J51Io017202
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 15:05:01 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72J4xOD019405
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 19:05:00 GMT
Date: Thu, 2 Aug 2007 15:04:56 -0400
Message-Id: <200708021904.l72J4uKD024298@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: system_logging changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Added policy for new rsyslogd
Resubmitting logging interfaces for auditing.  
Added interfaces to be used by new SELinux user logadm_t for managing logging environment
Fix some mistakes in var_log_t should be logfile
auditctl needs privs to be able to look at non root files


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
@@ -33,8 +33,13 @@
 ## </param>
 #
 interface(`logging_send_audit_msgs',`
+	gen_require(`
+		attribute can_send_audit_msgs;
+	')
+
+	typeattribute $1 can_send_audit_msgs;
 	allow $1 self:capability audit_write;
-	allow $1 self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
+	allow $1 self:netlink_audit_socket { r_netlink_socket_perms nlmsg_relay };
 ')
 
 ########################################
@@ -238,6 +243,63 @@
 
 ########################################
 ## <summary>
+##	Manage the syslogd configuration files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`logging_manage_syslog_config',`
+	gen_require(`
+		type syslog_conf_t;
+	')
+
+	files_search_etc($1)
+	manage_files_pattern($1,syslog_conf_t,syslog_conf_t)
+')
+
+#######################################
+## <summary>
+##	Automatic transition from etc to syslog_conf_t.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`logging_etc_filetrans_syslog_conf',`
+	gen_require(`
+		type syslog_conf_t;
+	')
+
+	files_etc_filetrans($1,syslog_conf_t,file)
+')
+
+########################################
+## <summary>
+##	Execute klogd in the klog domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`logging_domtrans_klog',`
+	gen_require(`
+		type klogd_t, klogd_exec_t;
+	')
+
+	corecmd_search_bin($1)
+	domtrans_pattern($1,klogd_exec_t,klogd_t)
+')
+
+########################################
+## <summary>
 ##	Create an object in the log directory, with a private
 ##	type using a type transition.
 ## </summary>
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
@@ -451,7 +532,7 @@
 
 	files_search_var($1)
 	allow $1 var_log_t:dir list_dir_perms;
-	read_files_pattern($1,var_log_t,logfile)
+	read_files_pattern($1,logfile, logfile)
 ')
 
 ########################################
@@ -495,6 +576,8 @@
 	files_search_var($1)
 	manage_files_pattern($1,logfile,logfile)
 	read_lnk_files_pattern($1,logfile,logfile)
+	allow $1 logfile:dir  { relabelfrom relabelto };
+	allow $1 logfile:file  { relabelfrom relabelto };
 ')
 
 ########################################
@@ -578,3 +661,101 @@
 	files_search_var($1)
 	manage_files_pattern($1,var_log_t,var_log_t)
 ')
+
+########################################
+## <summary>
+##	Set login uid
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`logging_set_loginuid',`
+	gen_require(`
+		attribute can_set_loginuid;
+		attribute can_send_audit_msgs;
+	')
+
+	typeattribute $1 can_set_loginuid, can_send_audit_msgs;
+
+	allow $1 self:capability audit_control;
+	allow $1 self:netlink_audit_socket { r_netlink_socket_perms nlmsg_relay };
+')
+
+########################################
+## <summary>
+##	Set up audit
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`logging_set_audit',`
+	gen_require(`
+		attribute can_set_audit;
+		attribute can_send_audit_msgs;
+	')
+
+	typeattribute $1  can_set_audit, can_send_audit_msgs;
+	allow $1 self:capability { audit_write audit_control };
+	allow $1 self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
+')
+
+########################################
+## <summary>
+##	Set audit control rules
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`logging_set_auditctl',`
+	gen_require(`
+		attribute can_set_auditctl;
+	')
+
+	typeattribute $1  can_set_auditctl;
+	logging_set_audit($1)
+	allow $1 self:netlink_audit_socket nlmsg_readpriv;
+')
+
+########################################
+## <summary>
+##	Unconfined access to the loggin module.
+## </summary>
+## <desc>
+##	<p>
+##	Unconfined access to the authlogin module.
+##	</p>
+##	<p>
+##	Currently, this only allows assertions for
+##	the audit susbsystem to be passed.
+##      No access is granted yet.
+##	</p>
+## </desc>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`logging_unconfined',`
+	gen_require(`
+		attribute can_set_audit;
+		attribute can_set_auditctl;
+		attribute can_send_audit_msgs;
+		attribute can_set_loginuid;
+	')
+
+	typeattribute $1 can_set_loginuid;
+	typeattribute $1 can_set_audit;
+	typeattribute $1 can_set_auditctl;
+	typeattribute $1 can_send_audit_msgs;
+')
+
--- nsaserefpolicy/policy/modules/system/logging.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/system/logging.te	2007-08-02 11:02:02.000000000 -0400
@@ -7,10 +7,15 @@
 #
 
 attribute logfile;
+attribute can_set_audit;
+attribute can_set_auditctl;
+attribute can_set_loginuid;
+attribute can_send_audit_msgs;
 
 type auditctl_t;
 type auditctl_exec_t;
 init_system_domain(auditctl_t,auditctl_exec_t)
+application_type(auditctl_t)
 role system_r types auditctl_t;
 
 type auditd_etc_t;
@@ -45,9 +50,15 @@
 type syslogd_exec_t;
 init_daemon_domain(syslogd_t,syslogd_exec_t)
 
+type syslog_conf_t;
+files_type(syslog_conf_t)
+
 type syslogd_tmp_t;
 files_tmp_file(syslogd_tmp_t)
 
+type syslogd_var_lib_t;
+files_type(syslogd_var_lib_t)
+
 type syslogd_var_run_t;
 files_pid_file(syslogd_var_run_t)
 
@@ -59,19 +70,25 @@
 	init_ranged_daemon_domain(auditd_t,auditd_exec_t,mls_systemhigh)
 ')
 
+neverallow ~{ can_set_loginuid can_set_audit } self:capability audit_control;
+neverallow ~can_set_audit self:netlink_audit_socket nlmsg_write;
+neverallow ~can_set_auditctl self:netlink_audit_socket nlmsg_readpriv;
+neverallow ~can_send_audit_msgs self:capability audit_write;
+neverallow ~can_send_audit_msgs  self:netlink_audit_socket nlmsg_relay;
+
 ########################################
 #
-# Auditd local policy
+# Auditctl local policy
 #
 
-allow auditctl_t self:capability { audit_write audit_control };
-allow auditctl_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay nlmsg_readpriv };
+allow auditctl_t self:capability { fsetid dac_read_search dac_override };
 
 read_files_pattern(auditctl_t,auditd_etc_t,auditd_etc_t)
 allow auditctl_t auditd_etc_t:dir list_dir_perms;
 
 # Needed for adding watches
 files_getattr_all_dirs(auditctl_t)
+files_getattr_all_files(auditctl_t)
 files_read_etc_files(auditctl_t)
 
 kernel_read_kernel_sysctls(auditctl_t)
@@ -91,6 +108,7 @@
 
 locallogin_dontaudit_use_fds(auditctl_t)
 
+logging_set_auditctl(auditctl_t)
 logging_send_syslog_msg(auditctl_t)
 
 ########################################
@@ -98,12 +116,11 @@
 # Auditd local policy
 #
 
-allow auditd_t self:capability { audit_write audit_control fsetid sys_nice sys_resource };
+allow auditd_t self:capability { fsetid sys_nice sys_resource };
 dontaudit auditd_t self:capability sys_tty_config;
 allow auditd_t self:process { signal_perms setpgid setsched };
 allow auditd_t self:file { getattr read write };
 allow auditd_t self:unix_dgram_socket create_socket_perms;
-allow auditd_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay nlmsg_readpriv };
 allow auditd_t self:fifo_file rw_file_perms;
 
 allow auditd_t auditd_etc_t:dir list_dir_perms;
@@ -141,6 +158,7 @@
 
 init_telinit(auditd_t)
 
+logging_set_audit(auditd_t)
 logging_send_syslog_msg(auditd_t)
 
 libs_use_ld_so(auditd_t)
@@ -157,6 +175,8 @@
 
 userdom_dontaudit_use_unpriv_user_fds(auditd_t)
 userdom_dontaudit_search_sysadm_home_dirs(auditd_t)
+# cjp: this is questionable
+userdom_use_sysadm_ttys(auditd_t)
 
 optional_policy(`
 	seutil_sigchld_newrole(auditd_t)
@@ -243,12 +263,18 @@
 allow syslogd_t self:udp_socket create_socket_perms;
 allow syslogd_t self:tcp_socket create_stream_socket_perms;
 
+allow syslogd_t syslog_conf_t:file r_file_perms;
+
 # Create and bind to /dev/log or /var/run/log.
 allow syslogd_t devlog_t:sock_file manage_sock_file_perms;
 files_pid_filetrans(syslogd_t,devlog_t,sock_file)
 
 # create/append log files.
 manage_files_pattern(syslogd_t,var_log_t,var_log_t)
+allow syslogd_t var_run_t:fifo_file { ioctl read write };
+# r/w log fifo_files files.
+rw_fifo_files_pattern(syslogd_t,var_log_t,var_log_t)
+
 # Allow access for syslog-ng
 allow syslogd_t var_log_t:dir { create setattr };
 
@@ -257,6 +283,9 @@
 manage_files_pattern(syslogd_t,syslogd_tmp_t,syslogd_tmp_t)
 files_tmp_filetrans(syslogd_t,syslogd_tmp_t,{ dir file })
 
+files_search_var_lib(syslogd_t)
+manage_files_pattern(syslogd_t,syslogd_var_lib_t,syslogd_var_lib_t)
+
 allow syslogd_t syslogd_var_run_t:file manage_file_perms;
 files_pid_filetrans(syslogd_t,syslogd_var_run_t,file)
 
@@ -314,6 +343,7 @@
 domain_use_interactive_fds(syslogd_t)
 
 files_read_etc_files(syslogd_t)
+files_read_var_files(syslogd_t)
 files_read_etc_runtime_files(syslogd_t)
 # /initrd is not umounted before minilog starts
 files_dontaudit_search_isid_type_dirs(syslogd_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

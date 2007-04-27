Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3RMOWK8011080
	for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2007 18:24:32 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3RMOVA1017179
	for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2007 22:24:31 GMT
Message-ID: <4632781D.2030406@redhat.com>
Date: Fri, 27 Apr 2007 18:24:29 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Patch to cleanup audit handling in policy.
Content-Type: multipart/mixed;
 boundary="------------000304060900060102060207"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000304060900060102060207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I have removed -send_audit_msgs_pattern and replaced it with 4 functions 
and added constraints to make sure no one accidentally breaks auditing 
rules.

logging_send_audit_msg
logging_set_audit
logging_set_auditctl
logging_set_loginuid



--------------000304060900060102060207
Content-Type: text/x-patch;
 name="audit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audit.patch"

--- serefpolicy-2.6.1/policy/modules/services/dbus.te~	2007-04-27 16:34:57.000000000 -0400
+++ serefpolicy-2.6.1/policy/modules/services/dbus.te	2007-04-27 17:16:58.000000000 -0400
@@ -40,8 +40,6 @@
 # Receive notifications of policy reloads and enforcing status changes.
 allow system_dbusd_t self:netlink_selinux_socket { create bind read };
 
-send_audit_msgs_pattern(system_dbusd_t)
-
 allow system_dbusd_t dbusd_etc_t:dir list_dir_perms;
 read_files_pattern(system_dbusd_t,dbusd_etc_t,dbusd_etc_t)
 read_lnk_files_pattern(system_dbusd_t,dbusd_etc_t,dbusd_etc_t)
@@ -93,6 +91,7 @@
 libs_use_shared_libs(system_dbusd_t)
 
 logging_send_syslog_msg(system_dbusd_t)
+logging_send_audit_msg(system_dbusd_t)
 
 miscfiles_read_localization(system_dbusd_t)
 miscfiles_read_certs(system_dbusd_t)
--- serefpolicy-2.6.1/policy/modules/services/oddjob.te~	2007-04-23 09:52:08.000000000 -0400
+++ serefpolicy-2.6.1/policy/modules/services/oddjob.te	2007-04-27 16:56:37.000000000 -0400
@@ -27,7 +27,7 @@
 # oddjob local policy
 #
 
-allow oddjob_t self:capability { audit_write setgid } ;
+allow oddjob_t self:capability setgid;
 allow oddjob_t self:process { setexec signal };
 allow oddjob_t self:fifo_file { read write };
 allow oddjob_t self:unix_stream_socket create_stream_socket_perms;
--- serefpolicy-2.6.1/policy/modules/services/hal.te~	2007-04-27 16:34:57.000000000 -0400
+++ serefpolicy-2.6.1/policy/modules/services/hal.te	2007-04-27 17:17:10.000000000 -0400
@@ -61,8 +61,6 @@
 # For backwards compatibility with older kernels
 allow hald_t self:netlink_socket create_socket_perms;
 
-send_audit_msgs_pattern(hald_t)
-
 manage_dirs_pattern(hald_t,hald_tmp_t,hald_tmp_t)
 manage_files_pattern(hald_t,hald_tmp_t,hald_tmp_t)
 files_tmp_filetrans(hald_t, hald_tmp_t, { file dir })
@@ -174,6 +172,7 @@
 libs_exec_ld_so(hald_t)
 libs_exec_lib_files(hald_t)
 
+logging_send_audit_msg(hald_t)
 logging_send_syslog_msg(hald_t)
 logging_search_logs(hald_t)
 
--- serefpolicy-2.6.1/policy/modules/services/cron.te~	2007-04-27 16:34:57.000000000 -0400
+++ serefpolicy-2.6.1/policy/modules/services/cron.te	2007-04-27 17:15:06.000000000 -0400
@@ -93,7 +93,7 @@
 # Cron Local policy
 #
 
-allow crond_t self:capability { dac_override setgid setuid sys_nice dac_read_search audit_control };
+allow crond_t self:capability { dac_override setgid setuid sys_nice dac_read_search };
 dontaudit crond_t self:capability { sys_resource sys_tty_config };
 allow crond_t self:process ~{ ptrace setcurrent setexec setfscreate setrlimit execmem execstack execheap };
 allow crond_t self:process { setexec setfscreate };
@@ -133,7 +133,6 @@
 fs_search_auto_mountpoints(crond_t)
 
 # need auth_chkpwd to check for locked accounts.
-send_audit_msgs_pattern(crond_t)
 auth_domtrans_upd_passwd(crond_t)
 
 corecmd_exec_shell(crond_t)
@@ -165,6 +164,7 @@
 libs_use_shared_libs(crond_t)
 
 logging_send_syslog_msg(crond_t)
+logging_send_audit_msg(crond_t)
 
 seutil_read_config(crond_t)
 seutil_read_default_contexts(crond_t)
--- serefpolicy-2.6.1/policy/modules/services/samba.te~	2007-04-27 16:34:57.000000000 -0400
+++ serefpolicy-2.6.1/policy/modules/services/samba.te	2007-04-27 16:44:16.000000000 -0400
@@ -597,7 +597,6 @@
 allow swat_t self:process signal_perms;
 allow swat_t self:fifo_file rw_file_perms;
 allow swat_t self:netlink_tcpdiag_socket r_netlink_socket_perms;
-allow swat_t self:netlink_audit_socket create;
 allow swat_t self:tcp_socket create_stream_socket_perms;
 allow swat_t self:udp_socket create_socket_perms;
 allow swat_t self:netlink_route_socket r_netlink_socket_perms;
--- serefpolicy-2.6.1/policy/modules/services/nscd.te~	2007-04-27 16:34:57.000000000 -0400
+++ serefpolicy-2.6.1/policy/modules/services/nscd.te	2007-04-27 16:56:26.000000000 -0400
@@ -28,14 +28,14 @@
 # Local policy
 #
 
-allow nscd_t self:capability { kill setgid setuid audit_write };
+allow nscd_t self:capability { kill setgid setuid };
 dontaudit nscd_t self:capability sys_tty_config;
 allow nscd_t self:process { getattr setcap setsched signal_perms };
 allow nscd_t self:fifo_file { read write };
 allow nscd_t self:unix_stream_socket create_stream_socket_perms;
 allow nscd_t self:unix_dgram_socket create_socket_perms;
 allow nscd_t self:netlink_selinux_socket create_socket_perms;
-allow nscd_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
+
 allow nscd_t self:tcp_socket create_socket_perms;
 allow nscd_t self:udp_socket create_socket_perms;
 
@@ -93,6 +93,7 @@
 libs_use_shared_libs(nscd_t)
 
 logging_send_syslog_msg(nscd_t)
+logging_send_audit_msg(nscd_t)
 
 miscfiles_read_localization(nscd_t)
 
--- serefpolicy-2.6.1/policy/modules/services/aide.te~	2007-04-27 16:34:57.000000000 -0400
+++ serefpolicy-2.6.1/policy/modules/services/aide.te	2007-04-27 17:16:32.000000000 -0400
@@ -26,7 +26,7 @@
 
 allow aide_t self:capability { dac_override fowner };
 
-send_audit_msgs_pattern(aide_t)
+logging_send_audit_msg(aide_t)
 
 # database actions
 manage_files_pattern(aide_t,aide_db_t,aide_db_t)
--- serefpolicy-2.6.1/policy/modules/services/pegasus.te~	2007-04-27 16:34:57.000000000 -0400
+++ serefpolicy-2.6.1/policy/modules/services/pegasus.te	2007-04-27 17:17:21.000000000 -0400
@@ -38,8 +38,6 @@
 allow pegasus_t self:unix_stream_socket create_stream_socket_perms;
 allow pegasus_t self:tcp_socket create_stream_socket_perms;
 
-send_audit_msgs_pattern(pegasus_t)
-
 allow pegasus_t pegasus_conf_t:dir rw_dir_perms;
 allow pegasus_t pegasus_conf_t:file { read_file_perms link unlink };
 allow pegasus_t pegasus_conf_t:lnk_file read_lnk_file_perms;
@@ -129,6 +127,7 @@
 
 optional_policy(`
 	logging_send_syslog_msg(pegasus_t)
+	logging_send_audit_msg(pegasus_t)
 ')
 
 optional_policy(`
--- serefpolicy-2.6.1/policy/modules/services/dbus.if~	2007-04-27 16:34:57.000000000 -0400
+++ serefpolicy-2.6.1/policy/modules/services/dbus.if	2007-04-27 17:15:53.000000000 -0400
@@ -85,8 +85,6 @@
 	allow $1_dbusd_t self:tcp_socket create_stream_socket_perms;
 	allow $1_dbusd_t self:netlink_selinux_socket create_socket_perms;
 
-	send_audit_msgs_pattern($1_dbusd_t)
-
 	# For connecting to the bus
 	allow $2 $1_dbusd_t:unix_stream_socket connectto;
 	type_change $2 $1_dbusd_t:dbus $1_dbusd_$1_t;
@@ -159,6 +157,7 @@
 	libs_use_shared_libs($1_dbusd_t)
 
 	logging_send_syslog_msg($1_dbusd_t)
+	logging_send_audit_msg($1_dbusd_t)
 
 	miscfiles_read_localization($1_dbusd_t)
 
--- serefpolicy-2.6.1/policy/modules/services/cups.te~	2007-04-27 16:34:57.000000000 -0400
+++ serefpolicy-2.6.1/policy/modules/services/cups.te	2007-04-27 17:16:10.000000000 -0400
@@ -93,8 +93,6 @@
 # generic socket here until appletalk socket is available in kernels
 allow cupsd_t self:socket create_socket_perms;
 
-send_audit_msgs_pattern(cupsd_t)
-
 allow cupsd_t cupsd_etc_t:{ dir file } setattr;
 read_files_pattern(cupsd_t,cupsd_etc_t,cupsd_etc_t)
 read_lnk_files_pattern(cupsd_t,cupsd_etc_t,cupsd_etc_t)
@@ -216,6 +214,7 @@
 libs_read_lib_files(cupsd_t)
 
 logging_send_syslog_msg(cupsd_t)
+logging_send_audit_msg(cupsd_t)
 
 miscfiles_read_localization(cupsd_t)
 # invoking ghostscript needs to read fonts
--- serefpolicy-2.6.1/policy/modules/system/init.te~	2007-04-27 16:34:57.000000000 -0400
+++ serefpolicy-2.6.1/policy/modules/system/init.te	2007-04-27 18:05:56.000000000 -0400
@@ -89,7 +89,7 @@
 #
 
 # Use capabilities. old rule:
-allow init_t self:capability ~sys_module;
+allow init_t self:capability ~{ audit_control audit_write sys_module };
 # is ~sys_module really needed? observed: 
 # sys_boot
 # sys_tty_config
@@ -205,7 +205,7 @@
 #
 
 allow initrc_t self:process { getpgid setsched setpgid setrlimit getsched };
-allow initrc_t self:capability ~{ sys_admin sys_module };
+allow initrc_t self:capability ~{ audit_control audit_write sys_admin sys_module };
 dontaudit initrc_t self:capability sys_module; # sysctl is triggering this
 allow initrc_t self:passwd rootok;
 
--- serefpolicy-2.6.1/policy/modules/system/logging.if~	2007-04-27 16:34:57.000000000 -0400
+++ serefpolicy-2.6.1/policy/modules/system/logging.if	2007-04-27 17:56:00.000000000 -0400
@@ -584,3 +584,121 @@
 	files_search_var($1)
 	manage_files_pattern($1,var_log_t,var_log_t)
 ')
+
+########################################
+## <summary>
+##	Send audit messages
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`logging_send_audit_msg',`
+	gen_require(`
+		attribute can_send_audit_msg;
+	')
+
+	typeattribute $1 can_send_audit_msg;
+	allow $1 self:capability audit_write;
+	allow $1 self:netlink_audit_socket { create_socket_perms nlmsg_read nlmsg_relay };
+')
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
+		attribute can_send_audit_msg;
+	')
+
+	typeattribute $1 can_set_loginuid, can_send_audit_msg;
+
+	allow $1 self:capability audit_control;
+	allow $1 self:netlink_audit_socket { create_socket_perms nlmsg_read nlsms_relay };
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
+		attribute can_send_audit_msg;
+	')
+
+	typeattribute $1  can_set_audit, can_send_audit_msg;
+	allow $1 self:capability { audit_write audit_control };
+	allow $1 self:netlink_audit_socket { create_socket_perms nlmsg_read nlmsg_write nlmsg_relay };
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
+		attribute can_send_audit_msg;
+		attribute can_set_loginuid;
+	')
+
+	typeattribute $1 can_set_loginuid;
+	typeattribute $1 can_set_audit;
+	typeattribute $1 can_set_auditctl;
+	typeattribute $1 can_send_audit_msg;
+')
+
--- serefpolicy-2.6.1/policy/modules/system/authlogin.te~	2007-04-27 16:34:57.000000000 -0400
+++ serefpolicy-2.6.1/policy/modules/system/authlogin.te	2007-04-27 17:45:25.000000000 -0400
@@ -258,7 +258,7 @@
 # System check password local policy
 #
 
-allow system_chkpwd_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
+logging_send_audit_msg(system_chkpwd_t)
 
 allow system_chkpwd_t shadow_t:file { getattr read };
 
--- serefpolicy-2.6.1/policy/modules/system/ipsec.te~	2007-04-27 16:34:57.000000000 -0400
+++ serefpolicy-2.6.1/policy/modules/system/ipsec.te	2007-04-27 17:31:20.000000000 -0400
@@ -283,13 +283,13 @@
 # Racoon local policy
 #
 
-allow racoon_t self:capability { net_admin net_bind_service audit_control };
+allow racoon_t self:capability { net_admin net_bind_service };
 allow racoon_t self:netlink_route_socket create_netlink_socket_perms;
 allow racoon_t self:unix_dgram_socket { connect create ioctl write };
 allow racoon_t self:netlink_selinux_socket { bind create read };
 allow racoon_t self:udp_socket create_socket_perms;
 allow racoon_t self:key_socket { create read setopt write };
-allow racoon_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
+logging_send_audit_msg(racoon_t)
 
 # manage pid file
 manage_files_pattern(racoon_t,ipsec_var_run_t,ipsec_var_run_t)
--- serefpolicy-2.6.1/policy/modules/system/clock.te~	2007-04-23 09:52:09.000000000 -0400
+++ serefpolicy-2.6.1/policy/modules/system/clock.te	2007-04-27 17:17:59.000000000 -0400
@@ -26,8 +26,6 @@
 allow hwclock_t self:process signal_perms;
 allow hwclock_t self:fifo_file { getattr read write };
 
-send_audit_msgs_pattern(hwclock_t)
-
 # Allow hwclock to store & retrieve correction factors.
 allow hwclock_t adjtime_t:file { rw_file_perms setattr };
 
@@ -61,6 +59,7 @@
 libs_use_shared_libs(hwclock_t)
 
 logging_send_syslog_msg(hwclock_t)
+logging_send_audit_msg(hwclock_t)
 
 miscfiles_read_localization(hwclock_t)
 
--- serefpolicy-2.6.1/policy/modules/system/logging.te~	2007-04-27 16:38:36.000000000 -0400
+++ serefpolicy-2.6.1/policy/modules/system/logging.te	2007-04-27 18:00:26.000000000 -0400
@@ -7,6 +7,10 @@
 #
 
 attribute logfile;
+attribute can_set_audit;
+attribute can_set_auditctl;
+attribute can_set_loginuid;
+attribute can_send_audit_msg;
 
 type auditctl_t;
 type auditctl_exec_t;
@@ -60,6 +64,12 @@
 	init_ranged_daemon_domain(auditd_t,auditd_exec_t,mls_systemhigh)
 ')
 
+neverallow ~{ can_set_loginuid can_set_audit } self:capability audit_control;
+neverallow ~can_set_audit self:netlink_audit_socket nlmsg_write;
+neverallow ~can_set_auditctl self:netlink_audit_socket nlmsg_readpriv;
+neverallow ~can_send_audit_msg self:capability audit_write;
+neverallow ~can_send_audit_msg  self:netlink_audit_socket nlmsg_relay;
+
 ########################################
 #
 # Auditd local policy
--- serefpolicy-2.6.1/policy/modules/system/selinuxutil.te~	2007-04-27 16:34:57.000000000 -0400
+++ serefpolicy-2.6.1/policy/modules/system/selinuxutil.te	2007-04-27 16:42:12.000000000 -0400
@@ -243,7 +243,7 @@
 allow newrole_t self:msg { send receive };
 allow newrole_t self:unix_dgram_socket sendto;
 allow newrole_t self:unix_stream_socket { create_stream_socket_perms connectto };
-allow newrole_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
+logging_send_audit_msg(newrole_t)
 
 read_files_pattern(newrole_t,selinux_config_t,selinux_config_t)
 read_lnk_files_pattern(newrole_t,selinux_config_t,selinux_config_t)
@@ -493,7 +493,7 @@
 allow run_init_t self:process setexec;
 allow run_init_t self:capability setuid;
 allow run_init_t self:fifo_file rw_file_perms;
-allow run_init_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
+logging_send_audit_msg(run_init_t)
 
 # often the administrator runs such programs from a directory that is owned
 # by a different user or has restrictive SE permissions, do not want to audit
@@ -564,7 +564,7 @@
 allow semanage_t self:capability { dac_override audit_write };
 allow semanage_t self:unix_stream_socket create_stream_socket_perms;
 allow semanage_t self:unix_dgram_socket create_socket_perms;
-allow semanage_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
+logging_send_audit_msg(semanage_t)
 
 allow semanage_t policy_config_t:file { read write };
 
--- serefpolicy-2.6.1/policy/modules/system/authlogin.if~	2007-04-27 16:34:57.000000000 -0400
+++ serefpolicy-2.6.1/policy/modules/system/authlogin.if	2007-04-27 17:46:20.000000000 -0400
@@ -27,11 +27,9 @@
 	domain_type($1_chkpwd_t)
 	domain_entry_file($1_chkpwd_t,chkpwd_exec_t)
 
-	allow $1_chkpwd_t self:capability { audit_control setuid };
+	allow $1_chkpwd_t self:capability setuid;
 	allow $1_chkpwd_t self:process getattr;
 
-	send_audit_msgs_pattern($1_chkpwd_t)
-
 	files_list_etc($1_chkpwd_t)
 	allow $1_chkpwd_t shadow_t:file { getattr read };
 
@@ -53,6 +51,7 @@
 	libs_use_shared_libs($1_chkpwd_t)
 
 	logging_send_syslog_msg($1_chkpwd_t)
+	logging_send_audit_msg($1_chkpwd_t)
 
 	miscfiles_read_localization($1_chkpwd_t)
 
@@ -109,7 +108,7 @@
 	role $3 types system_chkpwd_t;
 
 	# cjp: is this really needed?
-	allow $2 self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
+	logging_send_audit_msg($2)
 
 	dontaudit $2 shadow_t:file { getattr read };
 
@@ -320,10 +319,6 @@
 		type system_chkpwd_t, chkpwd_exec_t, shadow_t;
 	')
 
-	# cjp: is this really needed?
-	allow $1 self:capability audit_control;
-	send_audit_msgs_pattern($1)
-
 	corecmd_search_bin($1)
 	domtrans_pattern($1,chkpwd_exec_t,system_chkpwd_t)
 
--- serefpolicy-2.6.1/policy/modules/system/unconfined.if~	2007-04-27 16:34:57.000000000 -0400
+++ serefpolicy-2.6.1/policy/modules/system/unconfined.if	2007-04-27 18:03:53.000000000 -0400
@@ -61,7 +61,6 @@
 #		auditallow $1 self:process execstack;
 	')
 
-
 	optional_policy(`
 		auth_unconfined($1)
 	')
@@ -78,6 +77,10 @@
 	')
 
 	optional_policy(`
+		logging_unconfined($1)
+	')
+
+	optional_policy(`
 		nscd_unconfined($1)
 	')
 
--- serefpolicy-2.6.1/policy/modules/system/userdomain.if~	2007-04-27 16:34:57.000000000 -0400
+++ serefpolicy-2.6.1/policy/modules/system/userdomain.if	2007-04-27 16:43:07.000000000 -0400
@@ -1173,8 +1173,6 @@
 	# Manipulate other users crontab.
 	allow $1_t self:passwd crontab;
 
-	allow $1_t self:netlink_audit_socket nlmsg_readpriv;
-
 	kernel_read_software_raid_state($1_t)
 	kernel_getattr_core_if($1_t)
 	kernel_getattr_message_if($1_t)
--- serefpolicy-2.6.1/policy/modules/kernel/kernel.te~	2007-04-27 16:34:57.000000000 -0400
+++ serefpolicy-2.6.1/policy/modules/kernel/kernel.te	2007-04-27 18:07:15.000000000 -0400
@@ -281,6 +281,7 @@
 
 optional_policy(`
 	logging_send_syslog_msg(kernel_t)
+	logging_unconfined(kernel_t)
 ')
 
 optional_policy(`
--- serefpolicy-2.6.1/policy/modules/admin/amtu.te~	2007-04-27 16:34:57.000000000 -0400
+++ serefpolicy-2.6.1/policy/modules/admin/amtu.te	2007-04-27 16:55:38.000000000 -0400
@@ -16,8 +16,7 @@
 #
 
 # Specific allow rules required for amtu
-allow amtu_t self:capability { audit_write net_raw };
-allow amtu_t self:netlink_audit_socket { create nlmsg_relay read write };
+allow amtu_t self:capability net_raw;
 allow amtu_t self:packet_socket { bind create read write };
 allow amtu_t self:udp_socket { create ioctl };
 
@@ -30,6 +29,8 @@
 libs_use_ld_so(amtu_t)
 libs_use_shared_libs(amtu_t)
 
+logging_send_audit_msg(amtu_t)
+
 optional_policy(`
     seutil_use_newrole_fds(amtu_t)
 ');
--- serefpolicy-2.6.1/policy/modules/admin/su.if~	2007-04-27 16:34:57.000000000 -0400
+++ serefpolicy-2.6.1/policy/modules/admin/su.if	2007-04-27 16:55:00.000000000 -0400
@@ -41,12 +41,11 @@
 
 	allow $2 $1_su_t:process signal;
 
-	allow $1_su_t self:capability { audit_control audit_write setuid setgid net_bind_service chown dac_override fowner sys_nice sys_resource };
+	allow $1_su_t self:capability { setuid setgid net_bind_service chown dac_override fowner sys_nice sys_resource };
 	dontaudit $1_su_t self:capability sys_tty_config;
 	allow $1_su_t self:key { search write };
 	allow $1_su_t self:process { setexec setsched setrlimit };
 	allow $1_su_t self:fifo_file rw_fifo_file_perms;
-	allow $1_su_t self:netlink_audit_socket { nlmsg_relay create_netlink_socket_perms };
 	allow $1_su_t self:unix_stream_socket create_stream_socket_perms;
 
 	# Transition from the user domain to this domain.
@@ -90,6 +89,7 @@
 	libs_use_ld_so($1_su_t)
 	libs_use_shared_libs($1_su_t)
 
+	logging_send_audit_msg($1_su_t)
 	logging_send_syslog_msg($1_su_t)
 
 	miscfiles_read_localization($1_su_t)
@@ -175,11 +175,9 @@
 
 	allow $2 $1_su_t:process signal;
 
-	allow $1_su_t self:capability { audit_control audit_write setuid setgid net_bind_service chown dac_override fowner sys_nice sys_resource };
 	dontaudit $1_su_t self:capability sys_tty_config;
 	allow $1_su_t self:process { setexec setsched setrlimit };
 	allow $1_su_t self:fifo_file rw_fifo_file_perms;
-	allow $1_su_t self:netlink_audit_socket { nlmsg_relay create_netlink_socket_perms };
 	allow $1_su_t self:key { search write };
 
 	# Transition from the user domain to this domain.
@@ -230,6 +228,7 @@
 	libs_use_shared_libs($1_su_t)
 
 	logging_send_syslog_msg($1_su_t)
+	logging_send_audit_msg($1_su_t)
 
 	miscfiles_read_localization($1_su_t)
 
--- serefpolicy-2.6.1/policy/modules/admin/sudo.if~	2007-04-27 16:34:57.000000000 -0400
+++ serefpolicy-2.6.1/policy/modules/admin/sudo.if	2007-04-27 18:15:10.000000000 -0400
@@ -69,7 +69,6 @@
 	allow $1_sudo_t self:unix_stream_socket create_stream_socket_perms;
 	allow $1_sudo_t self:unix_dgram_socket sendto;
 	allow $1_sudo_t self:unix_stream_socket connectto;
-	allow $1_sudo_t self:netlink_audit_socket { create bind write nlmsg_read read };
 	allow $1_sudo_t self:netlink_route_socket r_netlink_socket_perms;
 
 	# Enter this derived domain from the user domain
@@ -91,8 +90,8 @@
 	fs_search_auto_mountpoints($1_sudo_t)
 	fs_getattr_xattr_fs($1_sudo_t)
 
-	auth_run_chk_passwd($1_sudo_t)
-	auth_run_upd_passwd($1_sudo_t)
+	auth_domtrans_chk_passwd($1_sudo_t)
+	auth_domtrans_upd_passwd($1_sudo_t)
 	# sudo stores a token in the pam_pid directory
 	auth_manage_pam_pid($1_sudo_t)
 
@@ -116,6 +115,7 @@
 	libs_use_shared_libs($1_sudo_t)
 
 	logging_send_syslog_msg($1_sudo_t)
+	logging_send_audit_msg($1_sudo_t)
 
 	miscfiles_read_localization($1_sudo_t)
 
--- serefpolicy-2.6.1/policy/modules/admin/usermanage.te~	2007-04-27 16:34:57.000000000 -0400
+++ serefpolicy-2.6.1/policy/modules/admin/usermanage.te	2007-04-27 16:57:42.000000000 -0400
@@ -184,7 +184,7 @@
 # Groupadd local policy
 #
 
-allow groupadd_t self:capability { dac_override chown kill setuid sys_resource audit_write };
+allow groupadd_t self:capability { dac_override chown kill setuid sys_resource };
 dontaudit groupadd_t self:capability { fsetid sys_tty_config };
 allow groupadd_t self:process ~{ ptrace setcurrent setexec setfscreate setrlimit execmem execheap execstack };
 allow groupadd_t self:process { setrlimit setfscreate };
@@ -198,7 +198,6 @@
 allow groupadd_t self:unix_stream_socket create_stream_socket_perms;
 allow groupadd_t self:unix_dgram_socket sendto;
 allow groupadd_t self:unix_stream_socket connectto;
-allow groupadd_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
 
 fs_getattr_xattr_fs(groupadd_t)
 fs_search_auto_mountpoints(groupadd_t)
@@ -231,6 +230,7 @@
 corecmd_exec_bin(groupadd_t)
 
 logging_send_syslog_msg(groupadd_t)
+logging_send_audit_msg(groupadd_t)
 
 miscfiles_read_localization(groupadd_t)
 
@@ -266,7 +266,7 @@
 # Passwd local policy
 #
 
-allow passwd_t self:capability { chown dac_override fsetid setuid setgid sys_resource audit_control audit_write };
+allow passwd_t self:capability { chown dac_override fsetid setuid setgid sys_resource };
 allow passwd_t self:process ~{ ptrace setcurrent setexec setfscreate setrlimit execmem execstack execheap };
 allow passwd_t self:process { setrlimit setfscreate };
 allow passwd_t self:fd use;
@@ -276,7 +276,6 @@
 allow passwd_t self:unix_stream_socket create_stream_socket_perms;
 allow passwd_t self:unix_dgram_socket sendto;
 allow passwd_t self:unix_stream_socket connectto;
-allow passwd_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
 allow passwd_t self:shm create_shm_perms;
 allow passwd_t self:sem create_sem_perms;
 allow passwd_t self:msgq create_msgq_perms;
@@ -329,6 +328,7 @@
 libs_use_shared_libs(passwd_t)
 
 logging_send_syslog_msg(passwd_t)
+logging_send_audit_msg(passwd_t)
 
 miscfiles_read_localization(passwd_t)
 
@@ -449,7 +449,7 @@
 # Useradd local policy
 #
 
-allow useradd_t self:capability { dac_override chown kill fowner fsetid setuid sys_resource audit_write };
+allow useradd_t self:capability { dac_override chown kill fowner fsetid setuid sys_resource };
 dontaudit useradd_t self:capability sys_tty_config;
 allow useradd_t self:process ~{ ptrace setcurrent setexec setfscreate setrlimit execmem execstack execheap };
 allow useradd_t self:process setfscreate;
@@ -463,7 +463,6 @@
 allow useradd_t self:unix_stream_socket create_stream_socket_perms;
 allow useradd_t self:unix_dgram_socket sendto;
 allow useradd_t self:unix_stream_socket connectto;
-allow useradd_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
 
 # for getting the number of groups
 kernel_read_kernel_sysctls(useradd_t)
@@ -509,6 +508,7 @@
 libs_use_shared_libs(useradd_t)
 
 logging_send_syslog_msg(useradd_t)
+logging_send_audit_msg(useradd_t)
 
 miscfiles_read_localization(useradd_t)
 
--- serefpolicy-2.6.1/policy/support/misc_patterns.spt~	2007-04-23 09:52:10.000000000 -0400
+++ serefpolicy-2.6.1/policy/support/misc_patterns.spt	2007-04-27 17:27:40.000000000 -0400
@@ -41,11 +41,6 @@
 #
 # Other process permissions
 #
-define(`send_audit_msgs_pattern',`
-	allow $1 self:capability audit_write;
-	allow $1 self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
-')
-
 define(`ps_process_pattern',`
 	allow $1 $2:dir { search getattr read };
 	allow $1 $2:{ file lnk_file } { read getattr };

--------------000304060900060102060207--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

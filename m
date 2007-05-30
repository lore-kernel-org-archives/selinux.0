Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHpZpB016208
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:51:35 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHpSui005771
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:51:33 GMT
Date: Wed, 30 May 2007 10:49:01 -0400
Message-Id: <200705301449.l4UEn1ke008185@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: Many hal changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hal broken up into several sub types
Lots of confined domains need additional interfaces to talk to hal logs and fds.


--- nsaserefpolicy/policy/modules/services/hal.fc	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/hal.fc	2007-05-30 07:35:54.000000000 -0400
@@ -8,4 +8,14 @@
 
 /var/lib/hal(/.*)?				gen_context(system_u:object_r:hald_var_lib_t,s0)
 
+/var/cache/hald(/.*)?				gen_context(system_u:object_r:hald_cache_t,s0)
+
 /var/run/haldaemon.pid	--	 		gen_context(system_u:object_r:hald_var_run_t,s0)
+/var/run/vbestate 	--			gen_context(system_u:object_r:hald_var_run_t,s0)
+
+/usr/libexec/hal-acl-tool		--	gen_context(system_u:object_r:hald_acl_exec_t,s0)
+/usr/libexec/hald-addon-macbookpro-backlight --	gen_context(system_u:object_r:hald_mac_exec_t,s0)
+/usr/libexec/hal-system-sonypic	 --	gen_context(system_u:object_r:hald_sonypic_exec_t,s0)
+
+/var/log/pm-suspend.log				gen_context(system_u:object_r:hald_log_t,s0)
+
--- nsaserefpolicy/policy/modules/services/hal.if	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/hal.if	2007-05-30 07:35:54.000000000 -0400
@@ -208,3 +208,98 @@
 	files_search_pids($1)
 	allow $1 hald_var_run_t:file rw_file_perms;
 ')
+
+########################################
+## <summary>
+##	Do not audit attempts to write the hal
+##	log files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit
+##	</summary>
+## </param>
+#
+interface(`hal_dontaudit_write_log',`
+	gen_require(`
+		type hald_log_t;
+	')
+
+	dontaudit $1 hald_log_t:file { append write };
+')
+
+########################################
+## <summary>
+##	Allow attempts to write the hal
+##	log files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit
+##	</summary>
+## </param>
+#
+interface(`hal_write_log',`
+	gen_require(`
+		type hald_log_t;
+	')
+
+	logging_search_logs($1)
+	allow $1 hald_log_t:file rw_file_perms;
+')
+
+########################################
+## <summary>
+##	Allow domain to use file descriptors from hal.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`hal_use_fds',`
+	gen_require(`
+		type hald_t;
+	')
+
+	allow $1 hald_t:fd use; 
+')
+
+########################################
+## <summary>
+##	Allow attempts to read and write to
+##	hald unnamed pipes.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`hal_rw_pipes',`
+	gen_require(`
+		type hald_t;
+	')
+
+	allow $1 hald_t:fifo_file rw_fifo_file_perms; 
+')
+
+########################################
+## <summary>
+##	Allow ptrace of hal domain
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`hal_ptrace',`
+	gen_require(`
+		type hald_t;
+	')
+
+	allow $1 hald_t:process ptrace;
+')
+
--- nsaserefpolicy/policy/modules/services/hal.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/hal.te	2007-05-30 07:35:54.000000000 -0400
@@ -1,5 +1,5 @@
 
-policy_module(hal,1.6.0)
+policy_module(hal,1.6.1)
 
 ########################################
 #
@@ -10,6 +10,30 @@
 type hald_exec_t;
 init_daemon_domain(hald_t,hald_exec_t)
 
+type hald_acl_t;
+type hald_acl_exec_t;
+domain_type(hald_acl_t)
+domain_entry_file(hald_acl_t,hald_acl_exec_t)
+role system_r types hald_acl_t;
+
+type hald_cache_t;
+files_pid_file(hald_cache_t)
+
+type hald_log_t;
+files_type(hald_log_t)
+
+type hald_mac_t;
+type hald_mac_exec_t;
+domain_type(hald_mac_t)
+domain_entry_file(hald_mac_t,hald_mac_exec_t)
+role system_r types hald_mac_t;
+
+type hald_sonypic_t;
+type hald_sonypic_exec_t;
+domain_type(hald_sonypic_t)
+domain_entry_file(hald_sonypic_t,hald_sonypic_exec_t)
+role system_r types hald_sonypic_t;
+
 type hald_tmp_t;
 files_tmp_file(hald_tmp_t)
 
@@ -26,7 +50,7 @@
 
 # execute openvt which needs setuid
 allow hald_t self:capability { chown setuid setgid kill net_admin sys_admin sys_nice dac_override dac_read_search mknod sys_rawio sys_tty_config };
-dontaudit hald_t self:capability sys_tty_config;
+dontaudit hald_t self:capability {sys_ptrace sys_tty_config };
 allow hald_t self:process signal_perms;
 allow hald_t self:fifo_file rw_fifo_file_perms;
 allow hald_t self:unix_stream_socket { create_stream_socket_perms connectto };
@@ -37,7 +61,11 @@
 # For backwards compatibility with older kernels
 allow hald_t self:netlink_socket create_socket_perms;
 
-send_audit_msgs_pattern(hald_t)
+manage_files_pattern(hald_t,hald_cache_t,hald_cache_t)
+
+# log files for hald
+allow hald_t hald_log_t:file manage_file_perms;
+logging_log_filetrans(hald_t,hald_log_t,file)
 
 manage_dirs_pattern(hald_t,hald_tmp_t,hald_tmp_t)
 manage_files_pattern(hald_t,hald_tmp_t,hald_tmp_t)
@@ -53,9 +81,9 @@
 
 kernel_read_system_state(hald_t)
 kernel_read_network_state(hald_t)
-kernel_read_kernel_sysctls(hald_t)
+kernel_rw_kernel_sysctl(hald_t)
 kernel_read_fs_sysctls(hald_t)
-kernel_read_irq_sysctls(hald_t)
+kernel_rw_irq_sysctls(hald_t)
 kernel_rw_vm_sysctls(hald_t)
 kernel_write_proc_files(hald_t)
 
@@ -85,9 +113,13 @@
 dev_rw_power_management(hald_t)
 # hal is now execing pm-suspend
 dev_rw_sysfs(hald_t)
+dev_read_sound(hald_t)
+dev_write_sound(hald_t)
+dev_read_raw_memory(hald_t)
 
 domain_use_interactive_fds(hald_t)
 domain_read_all_domains_state(hald_t)
+domain_dontaudit_ptrace_all_domains(hald_t)
 
 files_exec_etc_files(hald_t)
 files_read_etc_files(hald_t)
@@ -101,9 +133,11 @@
 files_create_boot_flag(hald_t)
 files_getattr_all_dirs(hald_t)
 files_read_kernel_img(hald_t)
+files_rw_lock_dirs(hald_t)
 
 fs_getattr_all_fs(hald_t)
 fs_search_all(hald_t)
+fs_list_inotifyfs(hald_t)
 fs_list_auto_mountpoints(hald_t)
 files_getattr_all_mountpoints(hald_t)
 
@@ -128,16 +162,17 @@
 auth_use_nsswitch(hald_t)
 
 init_domtrans_script(hald_t)
-init_write_initctl(hald_t)
 init_read_utmp(hald_t)
 #hal runs shutdown, probably need a shutdown domain
 init_rw_utmp(hald_t)
+init_telinit(hald_t)
 
 libs_use_ld_so(hald_t)
 libs_use_shared_libs(hald_t)
 libs_exec_ld_so(hald_t)
 libs_exec_lib_files(hald_t)
 
+logging_send_audit_msg(hald_t)
 logging_send_syslog_msg(hald_t)
 logging_search_logs(hald_t)
 
@@ -148,6 +183,7 @@
 
 seutil_read_config(hald_t)
 seutil_read_default_contexts(hald_t)
+seutil_read_file_contexts(hald_t)
 
 sysnet_read_config(hald_t)
 
@@ -155,6 +191,11 @@
 userdom_dontaudit_search_sysadm_home_dirs(hald_t)
 
 optional_policy(`
+	alsa_domtrans(hald_t)
+	alsa_read_rw_config(hald_t)
+')
+
+optional_policy(`
 	bootloader_domtrans(hald_t)
 ')
 
@@ -240,3 +281,89 @@
 optional_policy(`
 	vbetool_domtrans(hald_t)
 ')
+
+########################################
+#
+# Hal acl local policy
+#
+
+allow hald_acl_t self:capability { dac_override fowner };
+allow hald_acl_t self:fifo_file read_fifo_file_perms;
+
+domtrans_pattern(hald_t, hald_acl_exec_t, hald_acl_t)
+allow hald_t hald_acl_t:process signal;
+allow hald_acl_t hald_t:unix_stream_socket connectto;
+
+manage_dirs_pattern(hald_acl_t,hald_var_lib_t,hald_var_lib_t)
+manage_files_pattern(hald_acl_t,hald_var_lib_t,hald_var_lib_t)
+files_search_var_lib(hald_acl_t)
+
+corecmd_exec_bin(hald_acl_t)
+
+dev_getattr_all_chr_files(hald_acl_t)
+dev_getattr_generic_usb_dev(hald_acl_t)
+dev_getattr_video_dev(hald_acl_t)
+dev_setattr_video_dev(hald_acl_t)
+dev_getattr_sound_dev(hald_acl_t)
+dev_setattr_sound_dev(hald_acl_t)
+dev_setattr_generic_usb_dev(hald_acl_t)
+dev_setattr_usbfs_files(hald_acl_t)
+
+files_read_usr_files(hald_acl_t)
+files_read_etc_files(hald_acl_t)
+
+storage_getattr_removable_dev(hald_acl_t)
+storage_setattr_removable_dev(hald_acl_t)
+
+auth_use_nsswitch(hald_acl_t)
+
+libs_use_ld_so(hald_acl_t)
+libs_use_shared_libs(hald_acl_t)
+
+miscfiles_read_localization(hald_acl_t)
+
+########################################
+#
+# Local hald mac policy
+#
+
+domtrans_pattern(hald_t, hald_mac_exec_t, hald_mac_t)
+allow hald_t hald_mac_t:process signal;
+allow hald_mac_t hald_t:unix_stream_socket connectto;
+
+manage_dirs_pattern(hald_mac_t,hald_var_lib_t,hald_var_lib_t)
+manage_files_pattern(hald_mac_t,hald_var_lib_t,hald_var_lib_t)
+files_search_var_lib(hald_mac_t)
+
+dev_write_raw_memory(hald_mac_t)
+
+files_read_usr_files(hald_mac_t)
+
+libs_use_ld_so(hald_mac_t)
+libs_use_shared_libs(hald_mac_t)
+
+miscfiles_read_localization(hald_mac_t)
+
+########################################
+#
+# Local hald sonypic policy
+#
+
+domtrans_pattern(hald_t, hald_sonypic_exec_t, hald_sonypic_t)
+allow hald_t hald_sonypic_t:process signal;
+allow hald_sonypic_t hald_t:unix_stream_socket connectto;
+
+dev_read_video_dev(hald_sonypic_t)
+dev_write_video_dev(hald_sonypic_t)
+
+manage_dirs_pattern(hald_sonypic_t,hald_var_lib_t,hald_var_lib_t)
+manage_files_pattern(hald_sonypic_t,hald_var_lib_t,hald_var_lib_t)
+files_search_var_lib(hald_sonypic_t)
+
+files_read_usr_files(hald_sonypic_t)
+
+libs_use_ld_so(hald_sonypic_t)
+libs_use_shared_libs(hald_sonypic_t)
+
+miscfiles_read_localization(hald_sonypic_t)
+

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

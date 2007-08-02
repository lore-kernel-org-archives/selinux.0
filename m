Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KremG027328
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:53:40 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KrdM1010446
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:53:39 GMT
Date: Thu, 2 Aug 2007 16:53:36 -0400
Message-Id: <200708022053.l72KraD0000552@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_hal changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Many changes to break apart power of hal.
New interfaces for other daemons to write to log files

--- nsaserefpolicy/policy/modules/services/hal.fc	2007-05-30 11:47:29.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/hal.fc	2007-08-02 11:02:02.000000000 -0400
@@ -8,9 +8,14 @@
 /usr/libexec/hald-addon-macbookpro-backlight --	gen_context(system_u:object_r:hald_mac_exec_t,s0)
 
 /usr/sbin/hald		--			gen_context(system_u:object_r:hald_exec_t,s0)
+/usr/bin/hal-setup-keymap		--			gen_context(system_u:object_r:hald_keymap_exec_t,s0)
 
 /var/cache/hald(/.*)?				gen_context(system_u:object_r:hald_cache_t,s0)
 
 /var/lib/hal(/.*)?				gen_context(system_u:object_r:hald_var_lib_t,s0)
 
 /var/run/haldaemon.pid	--	 		gen_context(system_u:object_r:hald_var_run_t,s0)
+/var/run/vbestate 	--			gen_context(system_u:object_r:hald_var_run_t,s0)
+
+/var/log/pm-suspend.log				gen_context(system_u:object_r:hald_log_t,s0)
+
--- nsaserefpolicy/policy/modules/services/hal.if	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/hal.if	2007-08-02 11:02:02.000000000 -0400
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
--- nsaserefpolicy/policy/modules/services/hal.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/hal.te	2007-08-02 11:02:02.000000000 -0400
@@ -22,6 +22,12 @@
 type hald_log_t;
 files_type(hald_log_t)
 
+type hald_keymap_t;
+type hald_keymap_exec_t;
+domain_type(hald_keymap_t)
+domain_entry_file(hald_keymap_t,hald_keymap_exec_t)
+role system_r types hald_keymap_t;
+
 type hald_mac_t;
 type hald_mac_exec_t;
 domain_type(hald_mac_t)
@@ -81,6 +87,7 @@
 
 kernel_read_system_state(hald_t)
 kernel_read_network_state(hald_t)
+kernel_read_software_raid_state(hald_t)
 kernel_rw_kernel_sysctl(hald_t)
 kernel_read_fs_sysctls(hald_t)
 kernel_rw_irq_sysctls(hald_t)
@@ -114,6 +121,9 @@
 dev_rw_power_management(hald_t)
 # hal is now execing pm-suspend
 dev_rw_sysfs(hald_t)
+dev_read_sound(hald_t)
+dev_write_sound(hald_t)
+dev_read_raw_memory(hald_t)
 
 domain_use_interactive_fds(hald_t)
 domain_read_all_domains_state(hald_t)
@@ -131,6 +141,7 @@
 files_create_boot_flag(hald_t)
 files_getattr_all_dirs(hald_t)
 files_read_kernel_img(hald_t)
+files_rw_lock_dirs(hald_t)
 
 fs_getattr_all_fs(hald_t)
 fs_search_all(hald_t)
@@ -163,6 +174,7 @@
 #hal runs shutdown, probably need a shutdown domain
 init_rw_utmp(hald_t)
 init_telinit(hald_t)
+init_dontaudit_use_fds(hald_t)
 
 libs_use_ld_so(hald_t)
 libs_use_shared_libs(hald_t)
@@ -180,6 +192,7 @@
 
 seutil_read_config(hald_t)
 seutil_read_default_contexts(hald_t)
+seutil_read_file_contexts(hald_t)
 
 sysnet_read_config(hald_t)
 
@@ -187,6 +200,7 @@
 userdom_dontaudit_search_sysadm_home_dirs(hald_t)
 
 optional_policy(`
+	alsa_domtrans(hald_t)
 	alsa_read_rw_config(hald_t)
 ')
 
@@ -228,6 +242,10 @@
 	optional_policy(`
 		networkmanager_dbus_chat(hald_t)
 	')
+
+	optional_policy(`
+		userdom_dbus_chat_all_users(hald_t)
+	')
 ')
 
 optional_policy(`
@@ -296,7 +314,10 @@
 corecmd_exec_bin(hald_acl_t)
 
 dev_getattr_all_chr_files(hald_acl_t)
+dev_getattr_generic_usb_dev(hald_acl_t)
+dev_getattr_video_dev(hald_acl_t)
 dev_setattr_video_dev(hald_acl_t)
+dev_getattr_sound_dev(hald_acl_t)
 dev_setattr_sound_dev(hald_acl_t)
 dev_setattr_generic_usb_dev(hald_acl_t)
 dev_setattr_usbfs_files(hald_acl_t)
@@ -358,3 +379,25 @@
 libs_use_shared_libs(hald_sonypic_t)
 
 miscfiles_read_localization(hald_sonypic_t)
+
+########################################
+#
+# Local hald keymap policy
+#
+
+domtrans_pattern(hald_t, hald_keymap_exec_t, hald_keymap_t)
+allow hald_t hald_keymap_t:process signal;
+allow hald_keymap_t hald_t:unix_stream_socket connectto;
+
+manage_dirs_pattern(hald_keymap_t,hald_var_lib_t,hald_var_lib_t)
+manage_files_pattern(hald_keymap_t,hald_var_lib_t,hald_var_lib_t)
+files_search_var_lib(hald_keymap_t)
+
+files_read_usr_files(hald_keymap_t)
+
+libs_use_ld_so(hald_keymap_t)
+libs_use_shared_libs(hald_keymap_t)
+
+miscfiles_read_localization(hald_keymap_t)
+
+dev_rw_input_dev(hald_keymap_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

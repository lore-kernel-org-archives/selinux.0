Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KtpvQ027610
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:55:51 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KtoM1010719
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:55:50 GMT
Date: Thu, 2 Aug 2007 16:55:46 -0400
Message-Id: <200708022055.l72KtkGL000634@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_cups changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Multiple cups fixes
Some scripts being renamed to bin_t
Uses nsswitch

--- nsaserefpolicy/policy/modules/services/cups.fc	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/cups.fc	2007-08-02 11:02:02.000000000 -0400
@@ -8,6 +8,7 @@
 /etc/cups/ppd/.*	--	gen_context(system_u:object_r:cupsd_rw_etc_t,s0)
 /etc/cups/ppds\.dat	--	gen_context(system_u:object_r:cupsd_rw_etc_t,s0)
 /etc/cups/printers\.conf.* --	gen_context(system_u:object_r:cupsd_rw_etc_t,s0)
+/etc/cups/subscriptions.*  --	gen_context(system_u:object_r:cupsd_rw_etc_t,s0)
 /etc/cups/certs		-d	gen_context(system_u:object_r:cupsd_rw_etc_t,s0)
 /etc/cups/certs/.*	--	gen_context(system_u:object_r:cupsd_rw_etc_t,s0)
 
@@ -17,8 +18,6 @@
 
 /usr/bin/cups-config-daemon --	gen_context(system_u:object_r:cupsd_config_exec_t,s0)
 
-/usr/lib(64)?/cups/backend/.* -- gen_context(system_u:object_r:cupsd_exec_t,s0)
-/usr/lib(64)?/cups/daemon/.*	-- gen_context(system_u:object_r:cupsd_exec_t,s0)
 /usr/lib(64)?/cups/daemon/cups-lpd -- gen_context(system_u:object_r:cupsd_lpd_exec_t,s0)
 
 /usr/libexec/hal_lpadmin --	gen_context(system_u:object_r:cupsd_config_exec_t,s0)
@@ -52,3 +51,4 @@
 /var/run/ptal-mlcd(/.*)?	gen_context(system_u:object_r:ptal_var_run_t,s0)
 
 /var/spool/cups(/.*)?		gen_context(system_u:object_r:print_spool_t,mls_systemhigh)
+/usr/local/Brother/inf(/.*)?	gen_context(system_u:object_r:cupsd_rw_etc_t,s0)
--- nsaserefpolicy/policy/modules/services/cups.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/cups.te	2007-08-02 11:02:02.000000000 -0400
@@ -81,12 +81,11 @@
 # /usr/lib/cups/backend/serial needs sys_admin(?!)
 allow cupsd_t self:capability { sys_admin dac_override dac_read_search kill setgid setuid fsetid net_bind_service fowner chown dac_override sys_resource sys_tty_config };
 dontaudit cupsd_t self:capability { sys_tty_config net_admin };
-allow cupsd_t self:process { setsched signal_perms };
+allow cupsd_t self:process { setpgid setsched signal_perms };
 allow cupsd_t self:fifo_file rw_file_perms;
 allow cupsd_t self:unix_stream_socket { create_stream_socket_perms connectto };
 allow cupsd_t self:unix_dgram_socket create_socket_perms;
 allow cupsd_t self:netlink_selinux_socket create_socket_perms;
-allow cupsd_t self:netlink_route_socket r_netlink_socket_perms;
 allow cupsd_t self:tcp_socket create_stream_socket_perms;
 allow cupsd_t self:udp_socket create_socket_perms;
 allow cupsd_t self:appletalk_socket create_socket_perms;
@@ -105,7 +104,7 @@
 
 # allow cups to execute its backend scripts
 can_exec(cupsd_t, cupsd_exec_t)
-allow cupsd_t cupsd_exec_t:dir search;
+allow cupsd_t cupsd_exec_t:dir search_dir_perms;
 allow cupsd_t cupsd_exec_t:lnk_file read;
 
 manage_files_pattern(cupsd_t,cupsd_log_t,cupsd_log_t)
@@ -150,20 +149,24 @@
 corenet_tcp_bind_reserved_port(cupsd_t)
 corenet_dontaudit_tcp_bind_all_reserved_ports(cupsd_t)
 corenet_tcp_connect_all_ports(cupsd_t)
+corenet_tcp_connect_smbd_port(cupsd_t)
 corenet_sendrecv_hplip_client_packets(cupsd_t)
 corenet_sendrecv_ipp_client_packets(cupsd_t)
 corenet_sendrecv_ipp_server_packets(cupsd_t)
+corenet_tcp_bind_all_rpc_ports(cupsd_t)
 
 dev_rw_printer(cupsd_t)
 dev_read_urand(cupsd_t)
 dev_read_sysfs(cupsd_t)
-dev_read_usbfs(cupsd_t)
+dev_rw_generic_usb_dev(cupsd_t)
+dev_rw_usbfs(cupsd_t)
 dev_getattr_printer_dev(cupsd_t)
 
 domain_read_all_domains_state(cupsd_t)
 
 fs_getattr_all_fs(cupsd_t)
 fs_search_auto_mountpoints(cupsd_t)
+fs_read_anon_inodefs_files(cupsd_t)
 
 mls_fd_use_all_levels(cupsd_t)
 mls_file_downgrade(cupsd_t)
@@ -176,6 +179,7 @@
 term_search_ptys(cupsd_t)
 
 auth_domtrans_chk_passwd(cupsd_t)
+auth_domtrans_upd_passwd_chk(cupsd_t)
 auth_dontaudit_read_pam_pid(cupsd_t)
 
 # Filter scripts may be shell scripts, and may invoke progs like /bin/mktemp
@@ -189,7 +193,7 @@
 # read python modules
 files_read_usr_files(cupsd_t)
 # for /var/lib/defoma
-files_search_var_lib(cupsd_t)
+files_read_var_lib_files(cupsd_t)
 files_list_world_readable(cupsd_t)
 files_read_world_readable_files(cupsd_t)
 files_read_world_readable_symlinks(cupsd_t)
@@ -223,21 +227,45 @@
 
 sysnet_read_config(cupsd_t)
 
+files_dontaudit_list_home(cupsd_t)
 userdom_dontaudit_use_unpriv_user_fds(cupsd_t)
 userdom_dontaudit_search_all_users_home_content(cupsd_t)
 
 # Write to /var/spool/cups.
 lpd_manage_spool(cupsd_t)
+lpd_read_config(cupsd_t)
 
 ifdef(`enable_mls',`
 	lpd_relabel_spool(cupsd_t)
 ')
 
 optional_policy(`
+	avahi_dbus_chat(cupsd_t)
+')
+
+optional_policy(`
+	init_stream_connect_script(cupsd_t)
+
+	unconfined_rw_pipes(cupsd_t)
+
+	optional_policy(`
+		init_dbus_chat_script(cupsd_t)
+
+		unconfined_dbus_send(cupsd_t)
+
+		dbus_stub(cupsd_t)
+	')
+')
+
+optional_policy(`
 	apm_domtrans_client(cupsd_t)
 ')
 
 optional_policy(`
+	auth_use_nsswitch(cupsd_t)
+')
+
+optional_policy(`
 	cron_system_entry(cupsd_t, cupsd_exec_t)
 ')
 
@@ -250,6 +278,10 @@
 	optional_policy(`
 		hal_dbus_chat(cupsd_t)
 	')
+
+	optional_policy(`
+		userdom_dbus_chat_all_users(cupsd_t)
+	')
 ')
 
 optional_policy(`
@@ -265,16 +297,16 @@
 ')
 
 optional_policy(`
-	nscd_socket_use(cupsd_t)
-')
-
-optional_policy(`
 	# cups execs smbtool which reads samba_etc_t files
 	samba_read_config(cupsd_t)
 	samba_rw_var_files(cupsd_t)
 ')
 
 optional_policy(`
+	mta_send_mail(cupsd_t)
+')
+
+optional_policy(`
 	seutil_sigchld_newrole(cupsd_t)
 ')
 
@@ -379,6 +411,14 @@
 ')
 
 optional_policy(`
+	term_use_generic_ptys(cupsd_config_t)
+')
+
+optional_policy(`
+	unconfined_rw_pipes(cupsd_config_t)
+')
+
+optional_policy(`
 	cron_system_entry(cupsd_config_t, cupsd_config_exec_t)
 ')
 
@@ -562,7 +602,7 @@
 dev_read_urand(hplip_t)
 dev_read_rand(hplip_t)
 dev_rw_generic_usb_dev(hplip_t)
-dev_read_usbfs(hplip_t)
+dev_rw_usbfs(hplip_t)
 
 fs_getattr_all_fs(hplip_t)
 fs_search_auto_mountpoints(hplip_t)
@@ -589,8 +629,6 @@
 userdom_dontaudit_search_sysadm_home_dirs(hplip_t)
 userdom_dontaudit_search_all_users_home_content(hplip_t)
 
-lpd_read_config(cupsd_t)
-
 optional_policy(`
 	seutil_sigchld_newrole(hplip_t)
 ')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

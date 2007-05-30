Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbKX7014100
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:20 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbH2p008303
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:17 GMT
Date: Wed, 30 May 2007 10:25:21 -0400
Message-Id: <200705301425.l4UEPLup007797@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: Manage samba changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Additional samba interfaces for private data
Add /etc/samba/passdb.tdb
Add ability for users to define helper scripts, so they can use something other then samba_unconfined_script
Add boolean for samba_unconfined_script
Many other fixes

--- nsaserefpolicy/policy/modules/services/samba.fc	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/samba.fc	2007-05-30 07:35:54.000000000 -0400
@@ -3,6 +3,7 @@
 # /etc
 #
 /etc/samba/MACHINE\.SID		--	gen_context(system_u:object_r:samba_secrets_t,s0)
+/etc/samba/passdb.tdb		--	gen_context(system_u:object_r:samba_secrets_t,s0)
 /etc/samba/secrets\.tdb		--	gen_context(system_u:object_r:samba_secrets_t,s0)
 /etc/samba/smbpasswd		--	gen_context(system_u:object_r:samba_secrets_t,s0)
 /etc/samba(/.*)?			gen_context(system_u:object_r:samba_etc_t,s0)
@@ -27,6 +28,9 @@
 /var/cache/samba/winbindd_privileged(/.*)? gen_context(system_u:object_r:winbind_var_run_t,s0)
 
 /var/lib/samba(/.*)?			gen_context(system_u:object_r:samba_var_t,s0)
+/var/lib/samba/winbindd_privileged(/.*)? gen_context(system_u:object_r:winbind_var_run_t,s0)
+
+/var/lib/samba/scripts(/.*)?		gen_context(system_u:object_r:samba_unconfined_script_exec_t,s0)
 
 /var/log/samba(/.*)?			gen_context(system_u:object_r:samba_log_t,s0)
 
--- nsaserefpolicy/policy/modules/services/samba.if	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/samba.if	2007-05-30 07:35:54.000000000 -0400
@@ -210,6 +210,27 @@
 
 ########################################
 ## <summary>
+##	Allow the specified domain to append to  samba's log files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`samba_append_log',`
+	gen_require(`
+		type samba_log_t;
+	')
+
+	logging_search_logs($1)
+	allow $1 samba_log_t:dir list_dir_perms;
+	allow $1 samba_log_t:file append_file_perms;
+')
+
+########################################
+## <summary>
 ##	Execute samba log in the caller domain.
 ## </summary>
 ## <param name="domain">
@@ -263,6 +284,7 @@
 	')
 
 	files_search_var($1)
+	files_search_var_lib($1)
 	allow $1 samba_var_t:dir search_dir_perms;
 ')
 
@@ -283,11 +305,55 @@
 	')
 
 	files_search_var($1)
+	files_search_var_lib($1)
 	rw_files_pattern($1,samba_var_t,samba_var_t)
 ')
 
 ########################################
 ## <summary>
+##	Allow the specified domain to
+##	read and write samba /var files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`samba_manage_var_files',`
+	gen_require(`
+		type samba_var_t;
+	')
+
+	files_search_var($1)
+	files_search_var_lib($1)
+	manage_files_pattern($1,samba_var_t,samba_var_t)
+	manage_lnk_files_pattern($1,samba_var_t,samba_var_t)
+')
+
+########################################
+## <summary>
+##	Allow the specified domain to
+##	read samba /var files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`samba_read_var_files',`
+	gen_require(`
+		type samba_var_t;
+	')
+
+	files_search_var($1)
+	files_search_var_lib($1)
+	read_files_pattern($1,samba_var_t,samba_var_t)
+')
+
+########################################
+## <summary>
 ##	Allow the specified domain to write to smbmount tcp sockets.
 ## </summary>
 ## <param name="domain">
@@ -410,3 +476,52 @@
 	allow $1 samba_var_t:dir search_dir_perms;
 	stream_connect_pattern($1,winbind_var_run_t,winbind_var_run_t,winbind_t)
 ')
+
+########################################
+## <summary>
+##	Do not audit attempts to use file descriptors from samba.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`samba_dontaudit_use_fds',`
+	gen_require(`
+		type smbd_t;
+	')
+
+	dontaudit $1 smbd_t:fd use; 
+')
+
+
+########################################
+## <summary>
+##	Create a set of derived types for apache
+##	web content.
+## </summary>
+## <param name="prefix">
+##	<summary>
+##	The prefix to be used for deriving type names.
+##	</summary>
+## </param>
+#
+template(`samba_helper_template',`
+	gen_require(`
+		type smbd_t;
+	')
+	#This type is for samba helper scripts
+	type samba_$1_script_t;
+	domain_type(samba_$1_script_t)
+	role system_r types samba_$1_script_t;
+
+	# This type is used for executable scripts files
+	type samba_$1_script_exec_t;
+	corecmd_shell_entry_type(samba_$1_script_t)
+	domain_entry_file(samba_$1_script_t,samba_$1_script_exec_t)
+
+	domtrans_pattern(smbd_t, samba_$1_script_exec_t, samba_$1_script_t)
+	allow smbd_t samba_$1_script_exec_t:file ioctl;
+
+')
--- nsaserefpolicy/policy/modules/services/samba.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/samba.te	2007-05-30 07:35:54.000000000 -0400
@@ -28,6 +28,35 @@
 ## </desc>
 gen_tunable(samba_share_nfs,false)
 
+## <desc>
+## <p>
+## Allow samba to run as the domain controller; add machines to passwd file
+## 
+## </p>
+## </desc>
+gen_tunable(samba_domain_controller,false)
+
+## <desc>
+## <p>
+## Allow samba to be exported read/write.
+## </p>
+## </desc>
+gen_tunable(samba_export_all_rw,false)
+
+## <desc>
+## <p>
+## Allow samba to be exported read only
+## </p>
+## </desc>
+gen_tunable(samba_export_all_ro,false)
+
+## <desc>
+## <p>
+## Allow samba to run unconfined scripts
+## </p>
+## </desc>
+gen_tunable(samba_run_unconfined,false)
+
 type nmbd_t;
 type nmbd_exec_t;
 init_daemon_domain(nmbd_t,nmbd_exec_t)
@@ -117,6 +146,7 @@
 allow samba_net_t self:unix_stream_socket create_stream_socket_perms;
 allow samba_net_t self:udp_socket create_socket_perms;
 allow samba_net_t self:tcp_socket create_socket_perms;
+allow samba_net_t self:netlink_route_socket r_netlink_socket_perms;
 
 allow samba_net_t samba_etc_t:file read_file_perms;
 
@@ -159,6 +189,8 @@
 
 miscfiles_read_localization(samba_net_t) 
 
+samba_read_var_files(samba_net_t) 
+
 sysnet_read_config(samba_net_t)
 sysnet_use_ldap(samba_net_t)
 
@@ -197,7 +229,6 @@
 
 create_dirs_pattern(smbd_t,samba_log_t,samba_log_t)
 create_files_pattern(smbd_t,samba_log_t,samba_log_t)
-append_files_pattern(smbd_t,samba_log_t,samba_log_t)
 allow smbd_t samba_log_t:dir setattr;
 dontaudit smbd_t samba_log_t:dir remove_name;
 
@@ -251,6 +282,9 @@
 corenet_tcp_connect_ipp_port(smbd_t)
 corenet_tcp_connect_smbd_port(smbd_t)
 
+corecmd_exec_shell(smbd_t)
+corecmd_exec_bin(smbd_t)
+
 dev_read_sysfs(smbd_t)
 dev_read_urand(smbd_t)
 dev_getattr_mtrr_dev(smbd_t)
@@ -260,11 +294,13 @@
 fs_get_xattr_fs_quotas(smbd_t)
 fs_search_auto_mountpoints(smbd_t)
 fs_getattr_rpc_dirs(smbd_t)
+fs_list_inotifyfs(smbd_t)
 
 auth_use_nsswitch(smbd_t)
 auth_domtrans_chk_passwd(smbd_t)
 
 domain_use_interactive_fds(smbd_t)
+domain_dontaudit_list_all_domains_state(smbd_t)
 
 files_list_var_lib(smbd_t)
 files_read_etc_files(smbd_t)
@@ -291,6 +327,12 @@
 userdom_dontaudit_use_unpriv_user_fds(smbd_t)
 userdom_use_unpriv_users_fds(smbd_t)
 
+tunable_policy(`samba_domain_controller',`
+	usermanage_domtrans_passwd(smbd_t)
+	usermanage_domtrans_useradd(smbd_t)
+	usermanage_domtrans_groupadd(smbd_t)
+')
+
 ifdef(`hide_broken_symptoms', `
 	files_dontaudit_getattr_default_dirs(smbd_t)
 	files_dontaudit_getattr_boot_dirs(smbd_t)
@@ -328,6 +370,23 @@
 	udev_read_db(smbd_t)
 ')
 
+tunable_policy(`samba_export_all_rw',`
+	fs_read_noxattr_fs_files(smbd_t) 
+	auth_manage_all_files_except_shadow(smbd_t)
+	fs_read_noxattr_fs_files(nmbd_t) 
+	auth_manage_all_files_except_shadow(nmbd_t)
+	userdom_generic_user_home_dir_filetrans_generic_user_home_content(nmbd_t, { file dir })
+
+')
+
+tunable_policy(`samba_export_all_ro',`
+	fs_read_noxattr_fs_files(smbd_t) 
+	auth_read_all_files_except_shadow(smbd_t)
+	fs_read_noxattr_fs_files(nmbd_t) 
+	auth_read_all_files_except_shadow(nmbd_t)
+')
+
+
 ########################################
 #
 # nmbd Local policy
@@ -351,9 +410,12 @@
 files_pid_filetrans(nmbd_t,nmbd_var_run_t,file)
 
 read_files_pattern(nmbd_t,samba_etc_t,samba_etc_t)
+files_list_var_lib(nmbd_t)
 
-create_dirs_pattern(nmbd_t,samba_log_t,samba_log_t)
+manage_dirs_pattern(nmbd_t,samba_log_t,samba_log_t)
 append_files_pattern(nmbd_t,samba_log_t,samba_log_t)
+allow nmbd_t samba_log_t:file unlink;
+
 read_files_pattern(nmbd_t,samba_log_t,samba_log_t)
 create_files_pattern(nmbd_t,samba_log_t,samba_log_t)
 allow nmbd_t samba_log_t:dir setattr;
@@ -380,6 +442,7 @@
 corenet_udp_bind_nmbd_port(nmbd_t)
 corenet_sendrecv_nmbd_server_packets(nmbd_t)
 corenet_sendrecv_nmbd_client_packets(nmbd_t)
+corenet_tcp_connect_smbd_port(nmbd_t)
 
 dev_read_sysfs(nmbd_t)
 dev_getattr_mtrr_dev(nmbd_t)
@@ -440,6 +503,7 @@
 
 allow smbmount_t samba_secrets_t:file manage_file_perms;
 
+files_list_var_lib(smbmount_t)
 allow smbmount_t samba_var_t:dir rw_dir_perms;
 manage_files_pattern(smbmount_t,samba_var_t,samba_var_t)
 manage_lnk_files_pattern(smbmount_t,samba_var_t,samba_var_t)
@@ -470,6 +534,7 @@
 storage_raw_write_fixed_disk(smbmount_t)
 
 term_list_ptys(smbmount_t)
+term_use_controlling_term(smbmount_t)
 
 corecmd_list_bin(smbmount_t)
 
@@ -493,6 +558,11 @@
 sysnet_read_config(smbmount_t)
 
 userdom_use_all_users_fds(smbmount_t)
+userdom_use_sysadm_ttys(smbmount_t)
+
+optional_policy(`
+	cups_read_rw_config(smbmount_t)
+')
 
 optional_policy(`
 	nis_use_ypbind(smbmount_t)
@@ -511,7 +581,6 @@
 allow swat_t self:process signal_perms;
 allow swat_t self:fifo_file rw_file_perms;
 allow swat_t self:netlink_tcpdiag_socket r_netlink_socket_perms;
-allow swat_t self:netlink_audit_socket create;
 allow swat_t self:tcp_socket create_stream_socket_perms;
 allow swat_t self:udp_socket create_socket_perms;
 allow swat_t self:netlink_route_socket r_netlink_socket_perms;
@@ -602,6 +671,8 @@
 # Winbind local policy
 #
 
+
+allow winbind_t self:capability { dac_override ipc_lock setuid };
 dontaudit winbind_t self:capability sys_tty_config;
 allow winbind_t self:process signal_perms;
 allow winbind_t self:fifo_file { read write };
@@ -611,10 +682,15 @@
 allow winbind_t self:tcp_socket create_stream_socket_perms;
 allow winbind_t self:udp_socket create_socket_perms;
 
+allow winbind_t nmbd_t:process { signal signull };
+allow winbind_t nmbd_var_run_t:file read_file_perms;
+
 allow winbind_t samba_etc_t:dir list_dir_perms;
 read_files_pattern(winbind_t,samba_etc_t,samba_etc_t)
 read_lnk_files_pattern(winbind_t,samba_etc_t,samba_etc_t)
 
+rw_files_pattern(winbind_t,smbd_tmp_t,smbd_tmp_t)
+
 manage_files_pattern(winbind_t,samba_etc_t,samba_secrets_t)
 filetrans_pattern(winbind_t,samba_etc_t,samba_secrets_t,file)
 
@@ -622,6 +698,8 @@
 manage_files_pattern(winbind_t,samba_log_t,samba_log_t)
 manage_lnk_files_pattern(winbind_t,samba_log_t,samba_log_t)
 
+files_list_var_lib(winbind_t)
+manage_dirs_pattern(winbind_t,samba_var_t,samba_var_t)
 manage_files_pattern(winbind_t,samba_var_t,samba_var_t)
 manage_lnk_files_pattern(winbind_t,samba_var_t,samba_var_t)
 
@@ -707,6 +785,7 @@
 read_files_pattern(winbind_helper_t,samba_etc_t,samba_etc_t)
 read_lnk_files_pattern(winbind_helper_t,samba_etc_t,samba_etc_t)
 
+files_list_var_lib(winbind_helper_t)
 allow winbind_helper_t samba_var_t:dir search;
 
 stream_connect_pattern(winbind_helper_t,winbind_var_run_t,winbind_var_run_t,winbind_t)
@@ -722,6 +801,11 @@
 
 miscfiles_read_localization(winbind_helper_t) 
 
+ifdef(`targeted_policy',`
+	term_use_generic_ptys(winbind_helper_t)
+	term_use_unallocated_ttys(winbind_helper_t)
+')
+
 optional_policy(`
 	nscd_socket_use(winbind_helper_t)
 ')
@@ -730,3 +814,23 @@
 	squid_read_log(winbind_helper_t)
 	squid_append_log(winbind_helper_t)
 ')
+
+########################################
+#
+# samba_unconfined_script_t local policy
+#
+type samba_unconfined_script_t;
+domain_type(samba_unconfined_script_t)
+role system_r types samba_unconfined_script_t;
+
+# This type is used for executable scripts files
+type samba_unconfined_script_exec_t;
+corecmd_shell_entry_type(samba_unconfined_script_t)
+domain_entry_file(samba_unconfined_script_t,samba_unconfined_script_exec_t)
+allow smbd_t samba_unconfined_script_exec_t:dir search_dir_perms;
+allow smbd_t samba_unconfined_script_exec_t:file ioctl;
+
+tunable_policy(`samba_run_unconfined',`
+	domtrans_pattern(smbd_t, samba_unconfined_script_exec_t, samba_unconfined_script_t)
+')
+unconfined_domain(samba_unconfined_script_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

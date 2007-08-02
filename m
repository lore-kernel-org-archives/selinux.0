Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72Kdtjp025360
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:39:55 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KdsM1007988
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:39:54 GMT
Date: Thu, 2 Aug 2007 16:39:51 -0400
Message-Id: <200708022039.l72KdpfQ032538@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_samba changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Added interfaces to samba to allow people to define policy for helper apps.Still has unconfined directory and boolean to control this

--- nsaserefpolicy/policy/modules/services/samba.fc	2007-06-19 16:23:34.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/samba.fc	2007-08-02 11:02:02.000000000 -0400
@@ -30,6 +30,8 @@
 /var/lib/samba(/.*)?			gen_context(system_u:object_r:samba_var_t,s0)
 /var/lib/samba/winbindd_privileged(/.*)? gen_context(system_u:object_r:winbind_var_run_t,s0)
 
+/var/lib/samba/scripts(/.*)?		gen_context(system_u:object_r:samba_unconfined_script_exec_t,s0)
+
 /var/log/samba(/.*)?			gen_context(system_u:object_r:samba_log_t,s0)
 
 /var/run/samba/brlock\.tdb	--	gen_context(system_u:object_r:smbd_var_run_t,s0)
--- nsaserefpolicy/policy/modules/services/samba.if	2007-06-19 16:23:35.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/samba.if	2007-08-02 11:02:02.000000000 -0400
@@ -349,6 +349,7 @@
 	files_search_var($1)
 	files_search_var_lib($1)
 	manage_files_pattern($1,samba_var_t,samba_var_t)
+	manage_lnk_files_pattern($1,samba_var_t,samba_var_t)
 ')
 
 ########################################
@@ -493,3 +494,52 @@
 	allow $1 samba_var_t:dir search_dir_perms;
 	stream_connect_pattern($1,winbind_var_run_t,winbind_var_run_t,winbind_t)
 ')
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
+
+########################################
+## <summary>
+##	Allow the specified domain to read samba's shares
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`samba_read_share_files',`
+	gen_require(`
+		type samba_share_t;
+	')
+
+	read_files_pattern($1, samba_share_t, samba_share_t)
+')
+
--- nsaserefpolicy/policy/modules/services/samba.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/samba.te	2007-08-02 11:02:02.000000000 -0400
@@ -190,6 +190,8 @@
 
 miscfiles_read_localization(samba_net_t) 
 
+samba_read_var_files(samba_net_t) 
+
 sysnet_read_config(samba_net_t)
 sysnet_use_ldap(samba_net_t)
 
@@ -226,8 +228,8 @@
 
 allow smbd_t samba_etc_t:file { rw_file_perms setattr };
 
-create_dirs_pattern(smbd_t,samba_log_t,samba_log_t)
-create_files_pattern(smbd_t,samba_log_t,samba_log_t)
+manage_dirs_pattern(smbd_t,samba_log_t,samba_log_t)
+manage_files_pattern(smbd_t,samba_log_t,samba_log_t)
 allow smbd_t samba_log_t:dir setattr;
 dontaudit smbd_t samba_log_t:dir remove_name;
 
@@ -298,6 +300,7 @@
 
 auth_use_nsswitch(smbd_t)
 auth_domtrans_chk_passwd(smbd_t)
+auth_domtrans_upd_passwd(smbd_t)
 
 domain_use_interactive_fds(smbd_t)
 domain_dontaudit_list_all_domains_state(smbd_t)
@@ -350,6 +353,10 @@
 ')
 
 optional_policy(`
+	lpd_exec_lpr(smbd_t)
+')
+
+optional_policy(`
 	cups_read_rw_config(smbd_t)
 	cups_stream_connect(smbd_t)
 ')
@@ -533,6 +540,7 @@
 storage_raw_write_fixed_disk(smbmount_t)
 
 term_list_ptys(smbmount_t)
+term_use_controlling_term(smbmount_t)
 
 corecmd_list_bin(smbmount_t)
 
@@ -556,6 +564,11 @@
 sysnet_read_config(smbmount_t)
 
 userdom_use_all_users_fds(smbmount_t)
+userdom_use_sysadm_ttys(smbmount_t)
+
+optional_policy(`
+	cups_read_rw_config(smbmount_t)
+')
 
 optional_policy(`
 	nis_use_ypbind(smbmount_t)
@@ -622,17 +635,20 @@
 
 dev_read_urand(swat_t)
 
+files_list_var_lib(swat_t)
 files_read_etc_files(swat_t)
 files_search_home(swat_t)
 files_read_usr_files(swat_t)
 fs_getattr_xattr_fs(swat_t)
 
 auth_domtrans_chk_passwd(swat_t)
+auth_domtrans_upd_passwd(swat_t)
 
 libs_use_ld_so(swat_t)
 libs_use_shared_libs(swat_t)
 
 logging_send_syslog_msg(swat_t)
+logging_send_audit_msgs(swat_t)
 logging_search_logs(swat_t)
 
 miscfiles_read_localization(swat_t)
@@ -672,7 +688,6 @@
 allow winbind_t self:fifo_file { read write };
 allow winbind_t self:unix_dgram_socket create_socket_perms;
 allow winbind_t self:unix_stream_socket create_stream_socket_perms;
-allow winbind_t self:netlink_route_socket r_netlink_socket_perms;
 allow winbind_t self:tcp_socket create_stream_socket_perms;
 allow winbind_t self:udp_socket create_socket_perms;
 
@@ -709,6 +724,8 @@
 manage_sock_files_pattern(winbind_t,winbind_var_run_t,winbind_var_run_t)
 files_pid_filetrans(winbind_t,winbind_var_run_t,file)
 
+corecmd_exec_bin(winbind_t)
+
 kernel_read_kernel_sysctls(winbind_t)
 kernel_list_proc(winbind_t)
 kernel_read_proc_symlinks(winbind_t)
@@ -733,7 +750,9 @@
 fs_getattr_all_fs(winbind_t)
 fs_search_auto_mountpoints(winbind_t)
 
+auth_use_nsswitch(winbind_t)
 auth_domtrans_chk_passwd(winbind_t)
+auth_domtrans_upd_passwd(winbind_t)
 
 domain_use_interactive_fds(winbind_t)
 
@@ -746,9 +765,6 @@
 
 miscfiles_read_localization(winbind_t)
 
-sysnet_read_config(winbind_t)
-sysnet_dns_name_resolve(winbind_t)
-
 userdom_dontaudit_use_unpriv_user_fds(winbind_t)
 userdom_dontaudit_search_sysadm_home_dirs(winbind_t)
 userdom_priveleged_home_dir_manager(winbind_t)
@@ -758,10 +774,6 @@
 ')
 
 optional_policy(`
-	nscd_socket_use(winbind_t)
-')
-
-optional_policy(`
 	seutil_sigchld_newrole(winbind_t)
 ')
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

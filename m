Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3JESQgk024163
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 10:28:26 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3JESPUG014430
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 14:28:25 GMT
Message-ID: <46277C78.8090200@redhat.com>
Date: Thu, 19 Apr 2007 10:28:08 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Samba fixes
Content-Type: multipart/mixed;
 boundary="------------000906010502070607050704"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000906010502070607050704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I have been working heavily with the samba team here to get selinux 
policy working well with samba.


Most controversial part is
samba_unconfined_script_exec_t

Which is a directory that administrators can put random scripts into and 
allow samba to execute.


--------------000906010502070607050704
Content-Type: text/x-patch;
 name="samba.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="samba.patch"

--- nsaserefpolicy/policy/modules/services/samba.fc	2007-02-23 16:50:01.000000000 -0500
+++ serefpolicy-2.5.12/policy/modules/services/samba.fc	2007-04-11 17:07:34.000000000 -0400
@@ -27,6 +27,9 @@
 /var/cache/samba/winbindd_privileged(/.*)? gen_context(system_u:object_r:winbind_var_run_t,s0)
 
 /var/lib/samba(/.*)?			gen_context(system_u:object_r:samba_var_t,s0)
+/var/lib/samba/winbindd_privileged(/.*)? gen_context(system_u:object_r:winbind_var_run_t,s0)
+
+/var/lib/samba/scripts(/.*)?		gen_context(system_u:object_r:samba_unconfined_script_exec_t,s0)
 
 /var/log/samba(/.*)?			gen_context(system_u:object_r:samba_log_t,s0)
 
--- nsaserefpolicy/policy/modules/services/samba.if	2007-01-02 12:57:43.000000000 -0500
+++ serefpolicy-2.5.12/policy/modules/services/samba.if	2007-04-18 16:04:30.000000000 -0400
@@ -177,6 +177,27 @@
 
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
@@ -230,6 +251,7 @@
 	')
 
 	files_search_var($1)
+	files_search_var_lib($1)
 	allow $1 samba_var_t:dir search_dir_perms;
 ')
 
@@ -250,11 +272,55 @@
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
@@ -377,3 +443,23 @@
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
--- nsaserefpolicy/policy/modules/services/samba.te	2007-03-26 16:24:12.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/services/samba.te	2007-04-18 16:08:21.000000000 -0400
@@ -28,10 +28,39 @@
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
 type nmbd_t;
 type nmbd_exec_t;
 init_daemon_domain(nmbd_t,nmbd_exec_t)
 
+type samba_unconfined_script_t;
+domain_type(samba_unconfined_script_t)
+role system_r types samba_unconfined_script_t;
+
+type samba_unconfined_script_exec_t;
+domain_entry_file(samba_unconfined_script_t, samba_unconfined_script_exec_t)
+
 type nmbd_var_run_t;
 files_pid_file(nmbd_var_run_t)
 
@@ -159,6 +188,8 @@
 
 miscfiles_read_localization(samba_net_t) 
 
+samba_read_var_files(samba_net_t) 
+
 sysnet_read_config(samba_net_t)
 sysnet_use_ldap(samba_net_t)
 
@@ -256,6 +287,9 @@
 corenet_tcp_connect_ipp_port(smbd_t)
 corenet_tcp_connect_smbd_port(smbd_t)
 
+corecmd_exec_shell(smbd_t)
+corecmd_exec_bin(smbd_t)
+
 dev_read_sysfs(smbd_t)
 dev_read_urand(smbd_t)
 dev_getattr_mtrr_dev(smbd_t)
@@ -265,6 +299,7 @@
 fs_get_xattr_fs_quotas(smbd_t)
 fs_search_auto_mountpoints(smbd_t)
 fs_getattr_rpc_dirs(smbd_t)
+fs_list_inotifyfs(smbd_t)
 
 auth_use_nsswitch(smbd_t)
 auth_domtrans_chk_passwd(smbd_t)
@@ -296,6 +331,12 @@
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
@@ -339,6 +380,21 @@
 	udev_read_db(smbd_t)
 ')
 
+tunable_policy(`samba_export_all_rw',`
+	fs_read_noxattr_fs_files(smbd_t) 
+	auth_manage_all_files_except_shadow(smbd_t)
+	fs_read_noxattr_fs_files(nmbd_t) 
+	auth_manage_all_files_except_shadow(nmbd_t)
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
@@ -362,9 +418,12 @@
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
@@ -391,6 +450,7 @@
 corenet_udp_bind_nmbd_port(nmbd_t)
 corenet_sendrecv_nmbd_server_packets(nmbd_t)
 corenet_sendrecv_nmbd_client_packets(nmbd_t)
+corenet_tcp_connect_smbd_port(nmbd_t)
 
 dev_read_sysfs(nmbd_t)
 dev_getattr_mtrr_dev(nmbd_t)
@@ -457,6 +517,7 @@
 
 allow smbmount_t samba_secrets_t:file manage_file_perms;
 
+files_list_var_lib(smbmount_t)
 allow smbmount_t samba_var_t:dir rw_dir_perms;
 manage_files_pattern(smbmount_t,samba_var_t,samba_var_t)
 manage_lnk_files_pattern(smbmount_t,samba_var_t,samba_var_t)
@@ -514,7 +575,7 @@
 userdom_use_sysadm_ttys(smbmount_t)
 
 optional_policy(`
-	cups_read_rw_config(smbd_t)
+	cups_read_rw_config(smbmount_t)
 ')
 
 optional_policy(`
@@ -625,6 +686,8 @@
 # Winbind local policy
 #
 
+
+allow winbind_t self:capability { dac_override ipc_lock setuid };
 dontaudit winbind_t self:capability sys_tty_config;
 allow winbind_t self:process signal_perms;
 allow winbind_t self:fifo_file { read write };
@@ -634,10 +697,15 @@
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
 
@@ -645,6 +713,7 @@
 manage_files_pattern(winbind_t,samba_log_t,samba_log_t)
 manage_lnk_files_pattern(winbind_t,samba_log_t,samba_log_t)
 
+files_list_var_lib(winbind_t)
 manage_files_pattern(winbind_t,samba_var_t,samba_var_t)
 manage_lnk_files_pattern(winbind_t,samba_var_t,samba_var_t)
 
@@ -736,6 +805,7 @@
 read_files_pattern(winbind_helper_t,samba_etc_t,samba_etc_t)
 read_lnk_files_pattern(winbind_helper_t,samba_etc_t,samba_etc_t)
 
+files_list_var_lib(winbind_helper_t)
 allow winbind_helper_t samba_var_t:dir search;
 
 stream_connect_pattern(winbind_helper_t,winbind_var_run_t,winbind_var_run_t,winbind_t)
@@ -764,3 +834,14 @@
 	squid_read_log(winbind_helper_t)
 	squid_append_log(winbind_helper_t)
 ')
+
+########################################
+#
+# samba_unconfined_script_t local policy
+#
+allow smbd_t samba_unconfined_script_exec_t:dir search_dir_perms;
+allow smbd_t samba_unconfined_script_exec_t:file ioctl;
+domtrans_pattern(smbd_t,samba_unconfined_script_exec_t,samba_unconfined_script_t)
+unconfined_domain(samba_unconfined_script_t)
+
+
--- nsaserefpolicy/policy/modules/services/nscd.te	2007-03-20 23:37:51.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/services/nscd.te	2007-04-11 17:07:34.000000000 -0400
@@ -30,7 +30,7 @@
 
 allow nscd_t self:capability { kill setgid setuid audit_write };
 dontaudit nscd_t self:capability sys_tty_config;
-allow nscd_t self:process { getattr setsched signal_perms };
+allow nscd_t self:process { getattr setcap setsched signal_perms };
 allow nscd_t self:fifo_file { read write };
 allow nscd_t self:unix_stream_socket create_stream_socket_perms;
 allow nscd_t self:unix_dgram_socket create_socket_perms;
@@ -119,3 +119,11 @@
 	xen_dontaudit_rw_unix_stream_sockets(nscd_t)
 	xen_append_log(nscd_t)
 ')
+
+optional_policy(`
+	tunable_policy(`samba_domain_controller',`
+		samba_append_log(nscd_t)
+		samba_dontaudit_use_fds(nscd_t)
+	')
+')
+
--- nsaserefpolicy/policy/modules/services/radius.te	2007-03-26 10:39:04.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/services/radius.te	2007-04-11 17:07:34.000000000 -0400
@@ -130,3 +130,7 @@
 optional_policy(`
 	udev_read_db(radiusd_t)
 ')
+
+optional_policy(`
+	samba_read_var_files(radiusd_t)
+')

--------------000906010502070607050704--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

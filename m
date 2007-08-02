Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72L3HTp028431
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 17:03:17 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72L3GM1011975
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 21:03:16 GMT
Date: Thu, 2 Aug 2007 17:03:10 -0400
Message-Id: <200708022103.l72L3AHm000875@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_apache changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Move some of booleans out of interface and only have them work on httpd_sys_script_t
Bugzilla policy
Added a bunch of interfaces for new root user type webadm_t
Apache dbus chats with avahi
Apache uses nsswitch

--- nsaserefpolicy/policy/modules/services/apache.fc	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/apache.fc	2007-08-02 11:02:02.000000000 -0400
@@ -16,7 +16,6 @@
 
 /usr/lib/apache-ssl/.+		--	gen_context(system_u:object_r:httpd_exec_t,s0)
 /usr/lib/cgi-bin(/.*)?			gen_context(system_u:object_r:httpd_sys_script_exec_t,s0)
-/usr/lib/squid/cachemgr\.cgi	--	gen_context(system_u:object_r:httpd_exec_t,s0)
 /usr/lib(64)?/apache(/.*)?		gen_context(system_u:object_r:httpd_modules_t,s0)
 /usr/lib(64)?/apache2/modules(/.*)?	gen_context(system_u:object_r:httpd_modules_t,s0)
 /usr/lib(64)?/apache(2)?/suexec(2)? --	gen_context(system_u:object_r:httpd_suexec_exec_t,s0)
@@ -71,5 +70,14 @@
 
 /var/www(/.*)?				gen_context(system_u:object_r:httpd_sys_content_t,s0)
 /var/www/cgi-bin(/.*)?			gen_context(system_u:object_r:httpd_sys_script_exec_t,s0)
+/var/www/[^/]*/cgi-bin(/.*)?		gen_context(system_u:object_r:httpd_sys_script_exec_t,s0)
 /var/www/icons(/.*)?			gen_context(system_u:object_r:httpd_sys_content_t,s0)
 /var/www/perl(/.*)?			gen_context(system_u:object_r:httpd_sys_script_exec_t,s0)
+
+#Bugzilla file context
+/usr/share/bugzilla(/.*)?	-d	gen_context(system_u:object_r:httpd_bugzilla_content_t,s0)
+/usr/share/bugzilla(/.*)?	--	gen_context(system_u:object_r:httpd_bugzilla_script_exec_t,s0)
+/var/lib/bugzilla(/.*)?			gen_context(system_u:object_r:httpd_bugzilla_script_rw_t,s0)
+#viewvc file context
+/var/spool/viewvc(/.*)?  		gen_context(system_u:object_r:httpd_sys_script_rw_t, s0)
+
--- nsaserefpolicy/policy/modules/services/apache.if	2007-07-03 07:06:27.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/apache.if	2007-08-02 11:02:02.000000000 -0400
@@ -18,10 +18,6 @@
 		attribute httpd_script_exec_type;
 		type httpd_t, httpd_suexec_t, httpd_log_t;
 	')
-	# allow write access to public file transfer
-	# services files.
-	gen_tunable(allow_httpd_$1_script_anon_write,false)
-
 	#This type is for webpages
 	type httpd_$1_content_t, httpdcontent; # customizable
 	files_type(httpd_$1_content_t)
@@ -120,10 +116,6 @@
 		can_exec(httpd_$1_script_t, httpdcontent)
 	')
 
-	tunable_policy(`allow_httpd_$1_script_anon_write',`
-		miscfiles_manage_public_files(httpd_$1_script_t)
-	') 
-
 	# Allow the web server to run scripts and serve pages
 	tunable_policy(`httpd_builtin_scripting',`
 		manage_dirs_pattern(httpd_t,httpd_$1_script_rw_t,httpd_$1_script_rw_t)
@@ -177,48 +169,6 @@
 		miscfiles_read_localization(httpd_$1_script_t)
 	')
 
-	tunable_policy(`httpd_enable_cgi && httpd_can_network_connect_db',`
-		allow httpd_$1_script_t self:tcp_socket create_stream_socket_perms;
-		allow httpd_$1_script_t self:udp_socket create_socket_perms;
-
-		corenet_all_recvfrom_unlabeled(httpd_$1_script_t)
-		corenet_all_recvfrom_netlabel(httpd_$1_script_t)
-		corenet_tcp_sendrecv_all_if(httpd_$1_script_t)
-		corenet_udp_sendrecv_all_if(httpd_$1_script_t)
-		corenet_tcp_sendrecv_all_nodes(httpd_$1_script_t)
-		corenet_udp_sendrecv_all_nodes(httpd_$1_script_t)
-		corenet_tcp_sendrecv_all_ports(httpd_$1_script_t)
-		corenet_udp_sendrecv_all_ports(httpd_$1_script_t)
-		corenet_tcp_connect_postgresql_port(httpd_$1_script_t)
-		corenet_tcp_connect_mysqld_port(httpd_$1_script_t)
-		corenet_sendrecv_postgresql_client_packets(httpd_$1_script_t)
-		corenet_sendrecv_mysqld_client_packets(httpd_$1_script_t)
-
-		sysnet_read_config(httpd_$1_script_t)
-	')
-
-	tunable_policy(`httpd_enable_cgi && httpd_can_network_connect',`
-		allow httpd_$1_script_t self:tcp_socket create_stream_socket_perms;
-		allow httpd_$1_script_t self:udp_socket create_socket_perms;
-
-		corenet_all_recvfrom_unlabeled(httpd_$1_script_t)
-		corenet_all_recvfrom_netlabel(httpd_$1_script_t)
-		corenet_tcp_sendrecv_all_if(httpd_$1_script_t)
-		corenet_udp_sendrecv_all_if(httpd_$1_script_t)
-		corenet_tcp_sendrecv_all_nodes(httpd_$1_script_t)
-		corenet_udp_sendrecv_all_nodes(httpd_$1_script_t)
-		corenet_tcp_sendrecv_all_ports(httpd_$1_script_t)
-		corenet_udp_sendrecv_all_ports(httpd_$1_script_t)
-		corenet_tcp_connect_all_ports(httpd_$1_script_t)
-		corenet_sendrecv_all_client_packets(httpd_$1_script_t)
-
-		sysnet_read_config(httpd_$1_script_t)
-	')
-
-	optional_policy(`
-		mta_send_mail(httpd_$1_script_t)
-	')
-
 	optional_policy(`
 		tunable_policy(`httpd_enable_cgi && allow_ypbind',`
 			nis_use_ypbind_uncond(httpd_$1_script_t)
@@ -270,8 +220,11 @@
 	')
 
 	apache_content_template($1)
+	manage_dirs_pattern($1_t,httpd_$1_content_t,httpd_$1_content_t)
+	manage_files_pattern($1_t,httpd_$1_content_t,httpd_$1_content_t)
+	manage_lnk_files_pattern($1_t,httpd_$1_content_t,httpd_$1_content_t)
 
-	typeattribute httpd_$1_script_t httpd_script_domains;
+	typeattribute httpd_$1_content_t httpd_script_domains;
 	userdom_user_home_content($1,httpd_$1_content_t)
 
 	role $3 types httpd_$1_script_t;
@@ -436,6 +389,24 @@
 
 ########################################
 ## <summary>
+##	getattr apache.process
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`apache_getattr',`
+	gen_require(`
+		type httpd_t;
+	')
+
+	allow $1 httpd_t:process getattr;
+')
+
+########################################
+## <summary>
 ##	Inherit and use file descriptors from Apache.
 ## </summary>
 ## <param name="domain">
@@ -754,6 +725,7 @@
 	')
 
 	allow $1 httpd_modules_t:dir list_dir_perms;
+	read_lnk_files_pattern($1,httpd_modules_t,httpd_modules_t)
 ')
 
 ########################################
@@ -838,6 +810,10 @@
 		type httpd_sys_script_t;
 	')
 
+	tunable_policy(`httpd_enable_cgi',`
+		domtrans_pattern($1, httpd_sys_script_exec_t, httpd_sys_script_t)
+	')
+
 	tunable_policy(`httpd_enable_cgi && httpd_unified',`
 		domtrans_pattern($1, httpdcontent, httpd_sys_script_t)
 	')
@@ -925,7 +901,7 @@
 		type httpd_squirrelmail_t;
 	')
 
-	allow $1 httpd_squirrelmail_t:file { getattr read };
+	read_files_pattern($1,httpd_squirrelmail_t,httpd_squirrelmail_t)
 ')
 
 ########################################
@@ -1002,3 +978,158 @@
 
 	allow $1 httpd_sys_script_t:dir search_dir_perms;
 ')
+
+########################################
+## <summary>
+##	Allow the specified domain to manage
+##	apache modules.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`apache_manage_modules',`
+	gen_require(`
+		type httpd_modules_t;
+	')
+
+	manage_dirs_pattern($1,httpd_modules_t,httpd_modules_t)
+	manage_files_pattern($1,httpd_modules_t,httpd_modules_t)
+	manage_lnk_files_pattern($1,httpd_modules_t,httpd_modules_t)
+')
+
+########################################
+## <summary>
+##	Allow the specified domain to create 
+##	apache lock file
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`apache_manage_lock',`
+	gen_require(`
+		type httpd_lock_t;
+	')
+	allow $1 httpd_lock_t:file manage_file_perms;
+	files_lock_filetrans($1, httpd_lock_t, file)
+')
+
+########################################
+## <summary>
+##	Allow the specified domain to manage
+##	apache pid file
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`apache_manage_pid',`
+	gen_require(`
+		type httpd_var_run_t;
+	')
+	manage_files_pattern($1,httpd_var_run_t,httpd_var_run_t)
+	files_pid_filetrans($1,httpd_var_run_t, file)
+')
+
+########################################
+## <summary>
+##f	Read apache system state
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`apache_read_state',`
+	gen_require(`
+		type httpd_t;
+	')
+	kernel_search_proc($1)
+	allow $1 httpd_t:dir list_dir_perms;
+	read_files_pattern($1,httpd_t,httpd_t)
+	read_lnk_files_pattern($1,httpd_t,httpd_t)
+	dontaudit $1 httpd_t:process ptrace;
+')
+
+########################################
+## <summary>
+##f	allow domain to signal apache
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`apache_signal',`
+	gen_require(`
+		type httpd_t;
+	')
+	allow $1 httpd_t:process signal;
+')
+
+########################################
+## <summary>
+##	allow domain to relabel apache content
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`apache_relabel',`
+	gen_require(`
+		attribute httpdcontent;
+		attribute httpd_script_exec_type;
+	')
+
+	allow $1 { httpd_script_exec_type httpdcontent}:dir { relabelto relabelfrom };
+	allow $1 { httpd_script_exec_type httpdcontent}:file { relabelto relabelfrom };
+')
+
+########################################
+## <summary>
+##	Allow the specified domain to search 
+##	apache bugzilla directories.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`apache_search_bugzilla_dirs',`
+	gen_require(`
+		type httpd_bugzilla_content_t;
+	')
+
+	allow $1 httpd_bugzilla_content_t:dir search_dir_perms;
+')
+
+########################################
+## <summary>
+##	Do not audit attempts to read and write Apache
+##	bugzill script unix domain stream sockets.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`apache_dontaudit_rw_bugzilla_script_stream_sockets',`
+	gen_require(`
+		type httpd_bugzilla_script_t;
+	')
+
+	dontaudit $1 httpd_bugzilla_script_t:unix_stream_socket { read write };
+')
--- nsaserefpolicy/policy/modules/services/apache.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/apache.te	2007-08-02 11:02:02.000000000 -0400
@@ -30,6 +30,13 @@
 
 ## <desc>
 ## <p>
+## Allow Apache to communicate with avahi via dbus
+## </p>
+## </desc>
+gen_tunable(allow_httpd_dbus_avahi,false)
+
+## <desc>
+## <p>
 ## Allow Apache to use mod_auth_pam
 ## </p>
 ## </desc>
@@ -47,6 +54,13 @@
 ## Allow http daemon to tcp connect
 ## </p>
 ## </desc>
+gen_tunable(httpd_can_sendmail,false)
+
+## <desc>
+## <p>
+## Allow http daemon to tcp connect
+## </p>
+## </desc>
 gen_tunable(httpd_can_network_connect,false)
 
 ## <desc>
@@ -97,7 +111,7 @@
 ## Allow http daemon to communicate with the TTY
 ## </p>
 ## </desc>
-gen_tunable(httpd_tty_comm,false)
+gen_tunable(httpd_tty_comm,true)
 
 ## <desc>
 ## <p>
@@ -106,6 +120,27 @@
 ## </desc>
 gen_tunable(httpd_unified,false)
 
+## <desc>
+## <p>
+## Allow httpd to read nfs files
+## </p>
+## </desc>
+gen_tunable(httpd_use_nfs,false)
+
+## <desc>
+## <p>
+## Allow httpd to read cifs files
+## </p>
+## </desc>
+gen_tunable(httpd_use_cifs,false)
+
+## <desc>
+## <p>
+## Allow apache scripts to write to public content 
+## </p>
+## </desc>
+gen_tunable(allow_httpd_sys_script_anon_write,false)
+
 attribute httpdcontent;
 
 # domains that can exec all users scripts
@@ -182,6 +217,14 @@
 type httpd_tmpfs_t;
 files_tmpfs_file(httpd_tmpfs_t)
 
+# Unconfined domain for apache scripts.
+# Only to be used as a last resort
+type httpd_unconfined_script_t;
+type httpd_unconfined_script_exec_t; # customizable
+domain_type(httpd_unconfined_script_t)
+domain_entry_file(httpd_unconfined_script_t,httpd_unconfined_script_exec_t)
+role system_r types httpd_unconfined_script_t;
+
 # for apache2 memory mapped files
 type httpd_var_lib_t;
 files_type(httpd_var_lib_t)
@@ -202,7 +245,7 @@
 # Apache server local policy
 #
 
-allow httpd_t self:capability { chown dac_override kill setgid setuid sys_tty_config };
+allow httpd_t self:capability { chown dac_override kill setgid setuid sys_nice sys_tty_config };
 dontaudit httpd_t self:capability { net_admin sys_tty_config };
 allow httpd_t self:process ~{ ptrace setcurrent setexec setfscreate setrlimit execmem execstack execheap };
 allow httpd_t self:fd use;
@@ -244,6 +287,7 @@
 allow httpd_t httpd_modules_t:dir list_dir_perms;
 mmap_files_pattern(httpd_t,httpd_modules_t,httpd_modules_t)
 read_files_pattern(httpd_t,httpd_modules_t,httpd_modules_t)
+read_lnk_files_pattern(httpd_t,httpd_modules_t,httpd_modules_t)
 
 apache_domtrans_rotatelogs(httpd_t)
 # Apache-httpd needs to be able to send signals to the log rotate procs.
@@ -284,6 +328,7 @@
 kernel_read_kernel_sysctls(httpd_t)
 # for modules that want to access /proc/meminfo
 kernel_read_system_state(httpd_t)
+kernel_search_network_sysctl(httpd_t)
 
 corenet_all_recvfrom_unlabeled(httpd_t)
 corenet_all_recvfrom_netlabel(httpd_t)
@@ -330,6 +375,9 @@
 files_read_var_lib_symlinks(httpd_t)
 
 fs_search_auto_mountpoints(httpd_sys_script_t)
+# php uploads a file to /tmp and then execs programs to acton them
+manage_dirs_pattern(httpd_sys_script_t,httpd_tmp_t,httpd_tmp_t)
+manage_files_pattern(httpd_sys_script_t,httpd_tmp_t,httpd_tmp_t)
 
 libs_use_ld_so(httpd_t)
 libs_use_shared_libs(httpd_t)
@@ -348,7 +396,9 @@
 
 userdom_use_unpriv_users_fds(httpd_t)
 
-mta_send_mail(httpd_t)
+tunable_policy(`httpd_enable_homedirs',`
+	userdom_search_generic_user_home_dirs(httpd_t)
+')
 
 tunable_policy(`allow_httpd_anon_write',`
 	miscfiles_manage_public_files(httpd_t)
@@ -360,6 +410,7 @@
 #
 tunable_policy(`allow_httpd_mod_auth_pam',`
 	auth_domtrans_chk_passwd(httpd_t)
+	auth_domtrans_upd_passwd(httpd_t)
 ')
 ')
 
@@ -367,6 +418,16 @@
 	corenet_tcp_connect_all_ports(httpd_t)
 ')
 
+tunable_policy(`httpd_can_sendmail',`
+	# allow httpd to connect to mail servers
+	corenet_tcp_connect_smtp_port(httpd_t)
+	corenet_sendrecv_smtp_client_packets(httpd_t)
+	corenet_tcp_connect_pop_port(httpd_t)
+	corenet_sendrecv_pop_client_packets(httpd_t)
+	mta_send_mail(httpd_t)
+	mta_send_mail(httpd_sys_script_t)
+')
+
 tunable_policy(`httpd_can_network_connect_db',`
 	# allow httpd to connect to mysql/posgresql
 	corenet_tcp_connect_postgresql_port(httpd_t)
@@ -387,6 +448,17 @@
 	corenet_sendrecv_http_cache_client_packets(httpd_t)
 ')
 
+tunable_policy(`httpd_enable_cgi',`
+	domtrans_pattern(httpd_t, httpd_unconfined_script_exec_t, httpd_unconfined_script_t)
+
+	allow httpd_t httpd_unconfined_script_t:process { signal sigkill sigstop };
+	allow httpd_t httpd_unconfined_script_exec_t:dir list_dir_perms;
+')
+
+tunable_policy(`allow_httpd_sys_script_anon_write',`
+	miscfiles_manage_public_files(httpd_sys_script_t)
+') 
+
 tunable_policy(`httpd_enable_cgi && httpd_unified && httpd_builtin_scripting',`
 	domtrans_pattern(httpd_t, httpdcontent, httpd_sys_script_t)
 
@@ -404,11 +476,21 @@
 	fs_read_nfs_symlinks(httpd_t)
 ')
 
+tunable_policy(`httpd_use_nfs',`
+	fs_read_nfs_files(httpd_t)
+	fs_read_nfs_symlinks(httpd_t)
+')
+
 tunable_policy(`httpd_enable_homedirs && use_samba_home_dirs',`
 	fs_read_cifs_files(httpd_t)
 	fs_read_cifs_symlinks(httpd_t)
 ')
 
+tunable_policy(`httpd_use_cifs',`
+	fs_read_cifs_files(httpd_t)
+	fs_read_cifs_symlinks(httpd_t)
+')
+
 tunable_policy(`httpd_ssi_exec',`
 	corecmd_shell_domtrans(httpd_t,httpd_sys_script_t)
 	allow httpd_sys_script_t httpd_t:fd use;
@@ -430,6 +512,12 @@
 ')
 
 optional_policy(`
+	tunable_policy(`httpd_tty_comm',`
+		unconfined_use_terminals(httpd_t)
+	')
+')
+
+optional_policy(`
 	calamaris_read_www_files(httpd_t)
 ')
 
@@ -512,10 +600,16 @@
 tunable_policy(`httpd_tty_comm',`
 	# cjp: this is redundant:
 	term_use_controlling_term(httpd_helper_t)
-
 	userdom_use_sysadm_terms(httpd_helper_t)
 ')
 
+optional_policy(`
+	tunable_policy(`httpd_tty_comm',`
+		unconfined_use_terminals(httpd_helper_t)
+	')
+')
+
+
 ########################################
 #
 # Apache PHP script local policy
@@ -567,7 +661,6 @@
 allow httpd_suexec_t self:capability { setuid setgid };
 allow httpd_suexec_t self:process signal_perms;
 allow httpd_suexec_t self:unix_stream_socket create_stream_socket_perms;
-allow httpd_suexec_t self:netlink_route_socket r_netlink_socket_perms;
 
 domtrans_pattern(httpd_t, httpd_suexec_exec_t, httpd_suexec_t)
 
@@ -581,6 +674,8 @@
 manage_files_pattern(httpd_suexec_t,httpd_suexec_tmp_t,httpd_suexec_tmp_t)
 files_tmp_filetrans(httpd_suexec_t, httpd_suexec_tmp_t, { file dir })
 
+auth_use_nsswitch(httpd_suexec_t)
+
 kernel_read_kernel_sysctls(httpd_suexec_t)
 kernel_list_proc(httpd_suexec_t)
 kernel_read_proc_symlinks(httpd_suexec_t)
@@ -606,6 +701,10 @@
 
 miscfiles_read_localization(httpd_suexec_t)
 
+tunable_policy(`httpd_enable_homedirs',`
+	userdom_search_generic_user_home_dirs(httpd_suexec_t)
+')
+
 tunable_policy(`httpd_can_network_connect',`
 	allow httpd_suexec_t self:tcp_socket create_stream_socket_perms;
 	allow httpd_suexec_t self:udp_socket create_socket_perms;
@@ -620,10 +719,13 @@
 	corenet_udp_sendrecv_all_ports(httpd_suexec_t)
 	corenet_tcp_connect_all_ports(httpd_suexec_t)
 	corenet_sendrecv_all_client_packets(httpd_suexec_t)
-
 	sysnet_read_config(httpd_suexec_t)
 ')
 
+tunable_policy(`httpd_enable_cgi',`
+	domtrans_pattern(httpd_suexec_t, httpd_unconfined_script_exec_t, httpd_unconfined_script_t)
+')
+
 tunable_policy(`httpd_enable_cgi && httpd_unified',`
 	domtrans_pattern(httpd_suexec_t, httpdcontent, httpd_sys_script_t)
 ')
@@ -634,6 +736,12 @@
 	fs_exec_nfs_files(httpd_suexec_t)
 ')
 
+tunable_policy(`httpd_use_cifs',`
+	fs_read_cifs_files(httpd_suexec_t)
+	fs_read_cifs_symlinks(httpd_suexec_t)
+	fs_exec_cifs_files(httpd_suexec_t)
+')
+
 tunable_policy(`httpd_enable_homedirs && use_samba_home_dirs',`
 	fs_read_cifs_files(httpd_suexec_t)
 	fs_read_cifs_symlinks(httpd_suexec_t)
@@ -655,14 +763,6 @@
 	nagios_domtrans_cgi(httpd_suexec_t)
 ')
 
-optional_policy(`
-	nis_use_ypbind(httpd_suexec_t)
-')
-
-optional_policy(`
-	nscd_socket_use(httpd_suexec_t)
-')
-
 ########################################
 #
 # Apache system script local policy
@@ -672,7 +772,8 @@
 
 dontaudit httpd_sys_script_t httpd_config_t:dir search;
 
-allow httpd_sys_script_t httpd_squirrelmail_t:file { append read };
+apache_read_squirrelmail_data(httpd_sys_script_t)
+apache_append_squirrelmail_data(httpd_sys_script_t)
 
 allow httpd_sys_script_t squirrelmail_spool_t:dir list_dir_perms;
 read_files_pattern(httpd_sys_script_t,squirrelmail_spool_t,squirrelmail_spool_t)
@@ -686,15 +787,66 @@
 # Should we add a boolean?
 apache_domtrans_rotatelogs(httpd_sys_script_t)
 
+sysnet_read_config(httpd_sys_script_t)
+
 ifdef(`distro_redhat',`
 	allow httpd_sys_script_t httpd_log_t:file { getattr append };
 ')
 
-tunable_policy(`httpd_enable_homedirs && use_nfs_home_dirs',`
+tunable_policy(`httpd_enable_homedirs',`
+	userdom_search_generic_user_home_dirs(httpd_sys_script_t)
+')
+
+tunable_policy(`httpd_use_nfs', `
 	fs_read_nfs_files(httpd_sys_script_t)
 	fs_read_nfs_symlinks(httpd_sys_script_t)
 ')
 
+tunable_policy(`httpd_enable_homedirs && use_nfs_home_dirs', `
+	fs_read_nfs_files(httpd_sys_script_t)
+	fs_read_nfs_symlinks(httpd_sys_script_t)
+')
+
+tunable_policy(`httpd_enable_cgi && httpd_can_network_connect_db',`
+	allow httpd_sys_script_t self:tcp_socket create_stream_socket_perms;
+	allow httpd_sys_script_t self:udp_socket create_socket_perms;
+
+	corenet_all_recvfrom_unlabeled(httpd_sys_script_t)
+	corenet_all_recvfrom_netlabel(httpd_sys_script_t)
+	corenet_tcp_sendrecv_all_if(httpd_sys_script_t)
+	corenet_udp_sendrecv_all_if(httpd_sys_script_t)
+	corenet_tcp_sendrecv_all_nodes(httpd_sys_script_t)
+	corenet_udp_sendrecv_all_nodes(httpd_sys_script_t)
+	corenet_tcp_sendrecv_all_ports(httpd_sys_script_t)
+	corenet_udp_sendrecv_all_ports(httpd_sys_script_t)
+	corenet_tcp_connect_postgresql_port(httpd_sys_script_t)
+	corenet_tcp_connect_mysqld_port(httpd_sys_script_t)
+	corenet_sendrecv_postgresql_client_packets(httpd_sys_script_t)
+	corenet_sendrecv_mysqld_client_packets(httpd_sys_script_t)
+')
+
+tunable_policy(`httpd_enable_cgi && httpd_can_network_connect',`
+	allow httpd_sys_script_t self:tcp_socket create_stream_socket_perms;
+	allow httpd_sys_script_t self:udp_socket create_socket_perms;
+
+	corenet_all_recvfrom_unlabeled(httpd_sys_script_t)
+	corenet_all_recvfrom_netlabel(httpd_sys_script_t)
+	corenet_tcp_sendrecv_all_if(httpd_sys_script_t)
+	corenet_udp_sendrecv_all_if(httpd_sys_script_t)
+	corenet_tcp_sendrecv_all_nodes(httpd_sys_script_t)
+	corenet_udp_sendrecv_all_nodes(httpd_sys_script_t)
+	corenet_tcp_sendrecv_all_ports(httpd_sys_script_t)
+	corenet_udp_sendrecv_all_ports(httpd_sys_script_t)
+	corenet_tcp_connect_all_ports(httpd_sys_script_t)
+	corenet_sendrecv_all_client_packets(httpd_sys_script_t)
+')
+
+
+tunable_policy(`httpd_use_cifs', `
+	fs_read_cifs_files(httpd_sys_script_t)
+	fs_read_cifs_symlinks(httpd_sys_script_t)
+')
+
 tunable_policy(`httpd_enable_homedirs && use_samba_home_dirs',`
 	fs_read_cifs_files(httpd_sys_script_t)
 	fs_read_cifs_symlinks(httpd_sys_script_t)
@@ -711,6 +863,19 @@
 
 ########################################
 #
+# Apache unconfined script local policy
+#
+
+optional_policy(`
+	nscd_socket_use(httpd_unconfined_script_t)
+')
+
+optional_policy(`
+	unconfined_domain(httpd_unconfined_script_t)
+')
+
+########################################
+#
 # httpd_rotatelogs local policy
 #
 
@@ -728,3 +893,27 @@
 logging_search_logs(httpd_rotatelogs_t)
 
 miscfiles_read_localization(httpd_rotatelogs_t)
+
+#============= bugzilla policy ==============
+apache_content_template(bugzilla)
+allow httpd_bugzilla_script_t self:netlink_route_socket r_netlink_socket_perms;
+
+files_search_var_lib(httpd_bugzilla_script_t)
+
+optional_policy(`
+	mysql_search_db(httpd_bugzilla_script_t)
+	mysql_stream_connect(httpd_bugzilla_script_t)
+')
+
+optional_policy(`
+	postgresql_stream_connect(httpd_bugzilla_script_t)
+')
+
+
+optional_policy(`
+	dbus_system_bus_client_template(httpd,httpd_t)
+	dbus_send_system_bus(httpd_t)
+	tunable_policy(`allow_httpd_dbus_avahi',`
+		avahi_dbus_chat(httpd_t)
+	')
+')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

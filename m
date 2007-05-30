Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHarQT013770
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:53 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHaoue002805
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:50 GMT
Date: Wed, 30 May 2007 11:15:13 -0400
Message-Id: <200705301515.l4UFFDQM010380@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: services_apache changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eventually we need to get the cgi scripts changes upstream
Tunables should not be used in httpd script interfaces.  Developers should 
need to define these themselves
Additional interfaces to be used by webadm_r.
Additional booleans to use nfs and cifs file systems without access to homedirs


--- nsaserefpolicy/policy/modules/services/apache.fc	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/apache.fc	2007-05-30 09:25:53.000000000 -0400
@@ -16,7 +16,6 @@
 
 /usr/lib/apache-ssl/.+		--	gen_context(system_u:object_r:httpd_exec_t,s0)
 /usr/lib/cgi-bin(/.*)?			gen_context(system_u:object_r:httpd_sys_script_exec_t,s0)
-/usr/lib/squid/cachemgr\.cgi	--	gen_context(system_u:object_r:httpd_exec_t,s0)
 /usr/lib(64)?/apache(/.*)?		gen_context(system_u:object_r:httpd_modules_t,s0)
 /usr/lib(64)?/apache2/modules(/.*)?	gen_context(system_u:object_r:httpd_modules_t,s0)
 /usr/lib(64)?/apache(2)?/suexec(2)? --	gen_context(system_u:object_r:httpd_suexec_exec_t,s0)
@@ -73,3 +72,11 @@
 /var/www/cgi-bin(/.*)?			gen_context(system_u:object_r:httpd_sys_script_exec_t,s0)
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
--- nsaserefpolicy/policy/modules/services/apache.if	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/apache.if	2007-05-30 09:25:53.000000000 -0400
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
@@ -268,8 +260,11 @@
 	')
 
 	apache_content_template($1)
+	manage_dirs_pattern($1_t,httpd_$1_content_t,httpd_$1_content_t)
+	manage_files_pattern($1_t,httpd_$1_content_t,httpd_$1_content_t)
+	manage_lnk_files_pattern($1_t,httpd_$1_content_t,httpd_$1_content_t)
 
-	typeattribute httpd_$1_script_t httpd_script_domains;
+	typeattribute httpd_$1_content_t httpd_script_domains;
 	userdom_user_home_content($1,httpd_$1_content_t)
 
 	role $3 types httpd_$1_script_t;
@@ -434,6 +429,24 @@
 
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
@@ -752,6 +765,7 @@
 	')
 
 	allow $1 httpd_modules_t:dir list_dir_perms;
+	read_lnk_files_pattern($1,httpd_modules_t,httpd_modules_t)
 ')
 
 ########################################
@@ -836,6 +850,10 @@
 		type httpd_sys_script_t;
 	')
 
+	tunable_policy(`httpd_enable_cgi',`
+		domtrans_pattern($1, httpd_sys_script_exec_t, httpd_sys_script_t)
+	')
+
 	tunable_policy(`httpd_enable_cgi && httpd_unified',`
 		domtrans_pattern($1, httpdcontent, httpd_sys_script_t)
 	')
@@ -923,7 +941,7 @@
 		type httpd_squirrelmail_t;
 	')
 
-	allow $1 httpd_squirrelmail_t:file { getattr read };
+	read_files_pattern($1,httpd_squirrelmail_t,httpd_squirrelmail_t)
 ')
 
 ########################################
@@ -1000,3 +1018,140 @@
 
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
--- nsaserefpolicy/policy/modules/services/apache.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/apache.te	2007-05-30 09:25:53.000000000 -0400
@@ -30,7 +30,7 @@
 
 ## <desc>
 ## <p>
-## Allow Apache to use mod_auth_pam
+## Allow Apache to use mod_auth_pams
 ## </p>
 ## </desc>
 gen_tunable(allow_httpd_mod_auth_pam,false)
@@ -47,6 +47,13 @@
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
@@ -106,6 +113,27 @@
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
@@ -210,7 +238,7 @@
 # Apache server local policy
 #
 
-allow httpd_t self:capability { chown dac_override kill setgid setuid sys_tty_config };
+allow httpd_t self:capability { chown dac_override kill setgid setuid sys_nice sys_tty_config };
 dontaudit httpd_t self:capability { net_admin sys_tty_config };
 allow httpd_t self:process ~{ ptrace setcurrent setexec setfscreate setrlimit execmem execstack execheap };
 allow httpd_t self:fd use;
@@ -252,6 +280,7 @@
 allow httpd_t httpd_modules_t:dir list_dir_perms;
 mmap_files_pattern(httpd_t,httpd_modules_t,httpd_modules_t)
 read_files_pattern(httpd_t,httpd_modules_t,httpd_modules_t)
+read_lnk_files_pattern(httpd_t,httpd_modules_t,httpd_modules_t)
 
 apache_domtrans_rotatelogs(httpd_t)
 # Apache-httpd needs to be able to send signals to the log rotate procs.
@@ -292,6 +321,7 @@
 kernel_read_kernel_sysctls(httpd_t)
 # for modules that want to access /proc/meminfo
 kernel_read_system_state(httpd_t)
+kernel_search_network_sysctl(httpd_t)
 
 corenet_non_ipsec_sendrecv(httpd_t)
 corenet_tcp_sendrecv_all_if(httpd_t)
@@ -337,6 +367,9 @@
 files_read_var_lib_symlinks(httpd_t)
 
 fs_search_auto_mountpoints(httpd_sys_script_t)
+# php uploads a file to /tmp and then execs programs to acton them
+manage_dirs_pattern(httpd_sys_script_t,httpd_tmp_t,httpd_tmp_t)
+manage_files_pattern(httpd_sys_script_t,httpd_tmp_t,httpd_tmp_t)
 
 libs_use_ld_so(httpd_t)
 libs_use_shared_libs(httpd_t)
@@ -357,6 +390,10 @@
 
 mta_send_mail(httpd_t)
 
+optional_policy(`
+	nscd_socket_use(httpd_t)
+')
+
 ifdef(`targeted_policy',`
 	tunable_policy(`httpd_enable_homedirs',`
 		userdom_search_generic_user_home_dirs(httpd_t)
@@ -380,6 +417,14 @@
 	corenet_tcp_connect_all_ports(httpd_t)
 ')
 
+tunable_policy(`httpd_can_sendmail',`
+	# allow httpd to connect to mail servers
+	corenet_tcp_connect_smtp_port(httpd_t)
+	corenet_sendrecv_smtp_client_packets(httpd_t)
+	corenet_tcp_connect_pop_port(httpd_t)
+	corenet_sendrecv_pop_client_packets(httpd_t)
+')
+
 tunable_policy(`httpd_can_network_connect_db',`
 	# allow httpd to connect to mysql/posgresql
 	corenet_tcp_connect_postgresql_port(httpd_t)
@@ -407,6 +452,10 @@
 	allow httpd_t httpd_unconfined_script_exec_t:dir list_dir_perms;
 ')
 
+tunable_policy(`allow_httpd_sys_script_anon_write',`
+	miscfiles_manage_public_files(httpd_sys_script_t)
+') 
+
 tunable_policy(`httpd_enable_cgi && httpd_unified && httpd_builtin_scripting',`
 	domtrans_pattern(httpd_t, httpdcontent, httpd_sys_script_t)
 
@@ -424,11 +473,21 @@
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
@@ -659,6 +718,12 @@
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
@@ -697,7 +762,8 @@
 
 dontaudit httpd_sys_script_t httpd_config_t:dir search;
 
-allow httpd_sys_script_t httpd_squirrelmail_t:file { append read };
+apache_read_squirrelmail_data(httpd_sys_script_t)
+apache_append_squirrelmail_data(httpd_sys_script_t)
 
 allow httpd_sys_script_t squirrelmail_spool_t:dir list_dir_perms;
 read_files_pattern(httpd_sys_script_t,squirrelmail_spool_t,squirrelmail_spool_t)
@@ -721,11 +787,21 @@
 	')
 ')
 
+tunable_policy(`httpd_use_nfs', `
+	fs_read_nfs_files(httpd_sys_script_t)
+	fs_read_nfs_symlinks(httpd_sys_script_t)
+')
+
 tunable_policy(`httpd_enable_homedirs && use_nfs_home_dirs',`
 	fs_read_nfs_files(httpd_sys_script_t)
 	fs_read_nfs_symlinks(httpd_sys_script_t)
 ')
 
+tunable_policy(`httpd_use_cifs', `
+	fs_read_cifs_files(httpd_sys_script_t)
+	fs_read_cifs_symlinks(httpd_sys_script_t)
+')
+
 tunable_policy(`httpd_enable_homedirs && use_samba_home_dirs',`
 	fs_read_cifs_files(httpd_sys_script_t)
 	fs_read_cifs_symlinks(httpd_sys_script_t)
@@ -776,3 +852,19 @@
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

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

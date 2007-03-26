Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2QFbWYT011263
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 11:37:32 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2QFbR91005724
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 15:37:28 GMT
Message-ID: <4607E8AD.1010304@redhat.com>
Date: Mon, 26 Mar 2007 11:37:17 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Some disable_trans stuff was missed in selinux-policy update
Content-Type: multipart/mixed;
 boundary="------------040007030400000803060401"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040007030400000803060401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Mainly man pages and http, ppp.

--------------040007030400000803060401
Content-Type: text/x-patch;
 name="disable_trans.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="disable_trans.patch"

--- nsaserefpolicy/man/man8/ftpd_selinux.8	2006-11-16 17:15:28.000000000 -0500
+++ serefpolicy-2.5.11/man/man8/ftpd_selinux.8	2007-03-26 11:09:16.000000000 -0400
@@ -39,14 +39,10 @@
 ftpd can run either as a standalone daemon or as part of the xinetd domain.  If you want to run ftpd as a daemon you must set the ftpd_is_daemon boolean.
 .TP
 setsebool -P ftpd_is_daemon 1
-.TP
-You can disable SELinux protection for the ftpd daemon by executing:
-.TP
-setsebool -P ftpd_disable_trans 1
 .br
 service vsftpd restart
 .TP
-system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
+system-config-selinux is a GUI tool available to customize SELinux policy settings.
 .SH AUTHOR	
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
 
--- nsaserefpolicy/man/man8/httpd_selinux.8	2007-02-19 11:32:55.000000000 -0500
+++ serefpolicy-2.5.11/man/man8/httpd_selinux.8	2007-03-26 11:09:16.000000000 -0400
@@ -110,22 +110,7 @@
 .EE
 
 .PP
-You can disable suexec transition, set httpd_suexec_disable_trans deny this
-
-.EX
-setsebool -P httpd_suexec_disable_trans 1
-.EE
-
-.PP
-You can disable SELinux protection for the httpd daemon by executing:
-
-.EX
-setsebool -P httpd_disable_trans 1
-service httpd restart
-.EE
-
-.PP
-system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
+system-config-selinux is a GUI tool available to customize SELinux policy settings.
 .SH AUTHOR	
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
 
--- nsaserefpolicy/man/man8/kerberos_selinux.8	2007-02-26 14:42:44.000000000 -0500
+++ serefpolicy-2.5.11/man/man8/kerberos_selinux.8	2007-03-26 11:09:16.000000000 -0400
@@ -18,16 +18,9 @@
 You must set the allow_kerberos boolean to allow your system to work properly in a Kerberos environment.
 .EX
 setsebool -P allow_kerberos 1
-.EE 
-If you are running Kerberos daemons kadmind or krb5kdc you can disable the SELinux protection on these daemons by setting the krb5kdc_disable_trans and kadmind_disable_trans booleans.
-.EX
-setsebool -P krb5kdc_disable_trans 1
-service krb5kdc restart
-setsebool -P kadmind_disable_trans 1
-service kadmind restart
 .EE
 .PP
-system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
+system-config-selinux is a GUI tool available to customize SELinux policy settings.
 .SH AUTHOR	
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
 
--- nsaserefpolicy/man/man8/named_selinux.8	2007-02-19 11:32:55.000000000 -0500
+++ serefpolicy-2.5.11/man/man8/named_selinux.8	2007-03-26 11:09:16.000000000 -0400
@@ -20,13 +20,7 @@
 setsebool -P named_write_master_zones 1
 .EE
 .PP
-You can disable SELinux protection for the named daemon by executing:
-.EX
-setsebool -P named_disable_trans 1
-service named restart
-.EE
-.PP
-system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
+system-config-selinux is a GUI tool available to customize SELinux policy settings.
 .SH AUTHOR	
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
 
--- nsaserefpolicy/man/man8/nfs_selinux.8	2006-11-16 17:15:28.000000000 -0500
+++ serefpolicy-2.5.11/man/man8/nfs_selinux.8	2007-03-26 11:09:16.000000000 -0400
@@ -22,7 +22,7 @@
 .TP
 setsebool -P use_nfs_home_dirs 1
 .TP
-system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
+system-config-selinux is a GUI tool available to customize SELinux policy settings.
 .SH AUTHOR	
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
 
--- nsaserefpolicy/man/man8/rsync_selinux.8	2007-02-19 11:32:55.000000000 -0500
+++ serefpolicy-2.5.11/man/man8/rsync_selinux.8	2007-03-26 11:09:16.000000000 -0400
@@ -36,13 +36,7 @@
 
 .SH BOOLEANS
 .TP
-You can disable SELinux protection for the rsync daemon by executing:
-.EX
-setsebool -P rsync_disable_trans 1
-service xinetd restart
-.EE
-.TP
-system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
+system-config-selinux is a GUI tool available to customize SELinux policy settings.
 .SH AUTHOR	
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
 
--- nsaserefpolicy/man/man8/samba_selinux.8	2006-11-16 17:15:28.000000000 -0500
+++ serefpolicy-2.5.11/man/man8/samba_selinux.8	2007-03-26 11:09:16.000000000 -0400
@@ -41,17 +41,7 @@
 
 setsebool -P use_samba_home_dirs 1
 .TP
-You can disable SELinux protection for the samba daemon by executing:
-.br 
-
-setsebool -P smbd_disable_trans 1
-.br
-service smb restart
-.TP
-system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
-
-
-
+system-config-selinux is a GUI tool available to customize SELinux policy settings.
 
 .SH AUTHOR	
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
--- nsaserefpolicy/man/man8/ypbind_selinux.8	2006-11-16 17:15:28.000000000 -0500
+++ serefpolicy-2.5.11/man/man8/ypbind_selinux.8	2007-03-26 11:09:16.000000000 -0400
@@ -11,7 +11,7 @@
 .TP
 setsebool -P allow_ypbind 1
 .TP
-system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
+system-config-selinux is a GUI tool available to customize SELinux policy settings.
 .SH AUTHOR	
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
 
--- nsaserefpolicy/policy/modules/services/apache.fc	2007-02-23 16:50:01.000000000 -0500
+++ serefpolicy-2.5.11/policy/modules/services/apache.fc	2007-03-26 11:09:17.000000000 -0400
@@ -1,10 +1,5 @@
 # temporary hack till genhomedircon is fixed
-ifdef(`targeted_policy',`
-HOME_DIR/((www)|(web)|(public_html))(/.+)? gen_context(system_u:object_r:httpd_user_content_t,s0)
-',`
 HOME_DIR/((www)|(web)|(public_html))(/.+)? gen_context(system_u:object_r:httpd_ROLE_content_t,s0)
-')
-
 /etc/apache(2)?(/.*)?			gen_context(system_u:object_r:httpd_config_t,s0)
 /etc/apache-ssl(2)?(/.*)?		gen_context(system_u:object_r:httpd_config_t,s0)
 /etc/htdig(/.*)?			gen_context(system_u:object_r:httpd_sys_content_t,s0)
@@ -21,7 +16,6 @@
 
 /usr/lib/apache-ssl/.+		--	gen_context(system_u:object_r:httpd_exec_t,s0)
 /usr/lib/cgi-bin(/.*)?			gen_context(system_u:object_r:httpd_sys_script_exec_t,s0)
-/usr/lib/squid/cachemgr\.cgi	--	gen_context(system_u:object_r:httpd_exec_t,s0)
 /usr/lib(64)?/apache(/.*)?		gen_context(system_u:object_r:httpd_modules_t,s0)
 /usr/lib(64)?/apache2/modules(/.*)?	gen_context(system_u:object_r:httpd_modules_t,s0)
 /usr/lib(64)?/apache(2)?/suexec(2)? --	gen_context(system_u:object_r:httpd_suexec_exec_t,s0)
@@ -78,3 +72,11 @@
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
--- nsaserefpolicy/policy/modules/services/apache.if	2007-03-26 10:39:04.000000000 -0400
+++ serefpolicy-2.5.11/policy/modules/services/apache.if	2007-03-26 11:09:17.000000000 -0400
@@ -268,6 +268,9 @@
 	')
 
 	apache_content_template($1)
+	manage_dirs_pattern($1_t,httpd_$1_content_t,httpd_$1_content_t)
+	manage_files_pattern($1_t,httpd_$1_content_t,httpd_$1_content_t)
+	manage_lnk_files_pattern($1_t,httpd_$1_content_t,httpd_$1_content_t)
 
 	typeattribute httpd_$1_content_t httpd_script_domains;
 	userdom_user_home_content($1,httpd_$1_content_t)
@@ -434,6 +437,24 @@
 
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
@@ -752,6 +773,7 @@
 	')
 
 	allow $1 httpd_modules_t:dir list_dir_perms;
+	read_lnk_files_pattern($1,httpd_modules_t,httpd_modules_t)
 ')
 
 ########################################
@@ -1000,3 +1022,140 @@
 
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
--- nsaserefpolicy/policy/modules/services/apache.te	2007-03-26 10:39:04.000000000 -0400
+++ serefpolicy-2.5.11/policy/modules/services/apache.te	2007-03-26 11:09:54.000000000 -0400
@@ -507,13 +520,7 @@
 allow httpd_suexec_t self:unix_stream_socket create_stream_socket_perms;
 allow httpd_suexec_t self:netlink_route_socket r_netlink_socket_perms;
 
-ifdef(`targeted_policy',`
-	gen_tunable(httpd_suexec_disable_trans,false)
-
-	tunable_policy(`httpd_suexec_disable_trans',`',`
-		domtrans_pattern(httpd_t, httpd_suexec_exec_t, httpd_suexec_t)
-	')
-')
+domtrans_pattern(httpd_t, httpd_suexec_exec_t, httpd_suexec_t)
 
 create_files_pattern(httpd_suexec_t,httpd_log_t,httpd_log_t)
 append_files_pattern(httpd_suexec_t,httpd_log_t,httpd_log_t)
--- nsaserefpolicy/policy/modules/services/ppp.te	2007-03-26 10:39:04.000000000 -0400
+++ serefpolicy-2.5.11/policy/modules/services/ppp.te	2007-03-26 11:09:55.000000000 -0400
@@ -173,19 +173,10 @@
 	term_dontaudit_use_generic_ptys(pppd_t)
 	files_dontaudit_read_root_files(pppd_t)
 
-	optional_policy(`
-		gen_require(`
-			bool postfix_disable_trans;
-		')
-
-		if(!postfix_disable_trans) {
-			postfix_domtrans_master(pppd_t)
-		}
-	')
-',`
-	optional_policy(`
-		postfix_domtrans_master(pppd_t)
-	')
+')
+
+optional_policy(`
+	postfix_domtrans_master(pppd_t)
 ')
 
 optional_policy(`

--------------040007030400000803060401--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

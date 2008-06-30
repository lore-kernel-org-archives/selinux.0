Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5UK9WX1031198
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2008 16:09:32 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5UK9Whx010399
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2008 20:09:32 GMT
Message-ID: <48693D78.6090103@redhat.com>
Date: Mon, 30 Jun 2008 16:09:28 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>, lkundrak@v3.sk
Subject: cvs patch
Content-Type: multipart/mixed;
 boundary="------------090305010801060705030603"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090305010801060705030603
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

cvs needs auth_use_nsswitch
Added cvsweb policy from Lubomir Rintel
Added _admin interface

--------------090305010801060705030603
Content-Type: text/plain;
 name="cvs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cvs.patch"

Subject: [PATCH] refpolicy: services_cvs changes
--text follows this line--
--- nsaserefpolicy/policy/modules/services/cvs.fc	2008-06-12 23:25:05.000000000 -0400
+++ serefpolicy-3.4.2/policy/modules/services/cvs.fc	2008-06-30 16:00:10.000000000 -0400
@@ -5,3 +5,6 @@
 
 /var/cvs(/.*)?		gen_context(system_u:object_r:cvs_data_t,s0)
 
+#CVSWeb file context
+/usr/share/cvsweb/cvsweb\.cgi	--	gen_context(system_u:object_r:httpd_cvs_script_exec_t,s0)
+/var/www/cgi-bin/cvsweb\.cgi	--	gen_context(system_u:object_r:httpd_cvs_script_exec_t,s0)
--- nsaserefpolicy/policy/modules/services/cvs.if	2008-06-12 23:25:05.000000000 -0400
+++ serefpolicy-3.4.2/policy/modules/services/cvs.if	2008-06-30 16:04:16.000000000 -0400
@@ -36,3 +36,70 @@
 
 	can_exec($1,cvs_exec_t)
 ')
+
+########################################
+## <summary>
+##	Execute cvs server in the cvs domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+#
+interface(`cvs_script_domtrans',`
+	gen_require(`
+		type cvs_script_exec_t;
+	')
+
+	init_script_domtrans_spec($1,cvs_script_exec_t)
+')
+
+########################################
+## <summary>
+##	All of the rules required to administrate 
+##	an cvs environment
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <param name="role">
+##	<summary>
+##	The role to be allowed to manage the cvs domain.
+##	</summary>
+## </param>
+## <param name="terminal">
+##	<summary>
+##	The type of the user terminal.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`cvs_admin',`
+	gen_require(`
+		type cvs_t, cvs_tmp_t;
+		type cvs_data_t, cvs_var_run_t;
+		type cvs_script_exec_t;
+	')
+
+	allow $1 cvs_t:process { ptrace signal_perms };
+	ps_process_pattern($1, cvs_t)
+	        
+	# Allow cvs_t to restart the apache service
+	cvs_script_domtrans($1)
+	domain_system_change_exemption($1)
+	role_transition $2 cvs_script_exec_t system_r;
+	allow $2 system_r;
+
+	files_list_tmp($1)
+        manage_all_pattern($1,cvs_tmp_t)
+
+	manage_all_pattern($1,cvs_data_t)
+
+	files_list_pids($1)
+        manage_all_pattern($1,cvs_var_run_t)
+')
+
--- nsaserefpolicy/policy/modules/services/cvs.te	2008-06-12 23:25:05.000000000 -0400
+++ serefpolicy-3.4.2/policy/modules/services/cvs.te	2008-06-30 16:00:42.000000000 -0400
@@ -28,6 +28,9 @@
 type cvs_var_run_t;
 files_pid_file(cvs_var_run_t)
 
+type cvs_script_exec_t;
+init_script_type(cvs_script_exec_t)
+
 ########################################
 #
 # Local policy
@@ -69,6 +72,7 @@
 fs_getattr_xattr_fs(cvs_t)
 
 auth_domtrans_chk_passwd(cvs_t)
+auth_use_nsswitch(cvs_t)
 
 corecmd_exec_bin(cvs_t)
 corecmd_exec_shell(cvs_t)
@@ -86,8 +90,6 @@
 
 miscfiles_read_localization(cvs_t)
 
-sysnet_read_config(cvs_t)
-
 mta_send_mail(cvs_t)
 
 # cjp: typeattribute doesnt work in conditionals yet
@@ -103,10 +105,13 @@
 	kerberos_dontaudit_write_config(cvs_t)
 ')
 
-optional_policy(`
-	nis_use_ypbind(cvs_t)
-')
+########################################
+# CVSWeb policy
+
+apache_content_template(cvs)
+
+read_files_pattern(httpd_cvs_script_t, cvs_data_t, cvs_data_t)
+manage_dirs_pattern(httpd_cvs_script_t_t,cvs_tmp_t,cvs_tmp_t)
+manage_files_pattern(httpd_cvs_script_t,cvs_tmp_t,cvs_tmp_t)
+files_tmp_filetrans(httpd_cvs_script_t, cvs_tmp_t, { file dir })
 
-optional_policy(`
-	nscd_socket_use(cvs_t)
-')

--------------090305010801060705030603--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

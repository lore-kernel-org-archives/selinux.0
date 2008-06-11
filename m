Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5BIaYhk000415
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 14:36:34 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5BIaYX5006286
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 18:36:34 GMT
Message-ID: <48501AC9.60901@redhat.com>
Date: Wed, 11 Jun 2008 14:34:49 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Current Fedora Prelude patch
Content-Type: multipart/mixed;
 boundary="------------070501070803070807080801"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070501070803070807080801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------070501070803070807080801
Content-Type: text/plain;
 name="services_prelude.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="services_prelude.patch"

Subject: [PATCH] refpolicy: services_prelude changes
--text follows this line--
--- nsaserefpolicy/policy/modules/services/prelude.fc	2008-06-11 08:15:44.000000000 -0400
+++ serefpolicy-3.4.2/policy/modules/services/prelude.fc	2008-06-11 14:30:20.000000000 -0400
@@ -9,3 +9,4 @@
 
 /var/spool/prelude-manager(/.*)?	gen_context(system_u:object_r:prelude_spool_t,s0)
 /var/spool/prelude(/.*)?		gen_context(system_u:object_r:prelude_spool_t,s0)
+/etc/rc.d/init.d/prelude-manager	--	gen_context(system_u:object_r:prelude_script_exec_t,s0)
--- nsaserefpolicy/policy/modules/services/prelude.if	2008-06-11 08:15:44.000000000 -0400
+++ serefpolicy-3.4.2/policy/modules/services/prelude.if	2008-06-11 14:32:45.000000000 -0400
@@ -42,7 +42,7 @@
 ## </summary>
 ## <param name="domain">
 ## <summary>
-##	Domain allowed acccess.
+##	Domain allowed access.
 ## </summary>
 ## </param>
 #
@@ -56,6 +56,24 @@
 
 ########################################
 ## <summary>
+##	Execute prelude server in the prelude domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`prelude_script_domtrans',`
+	gen_require(`
+		type prelude_script_exec_t;
+	')
+
+	init_script_domtrans_spec($1,prelude_script_exec_t)
+')
+
+########################################
+## <summary>
 ##	All of the rules required to administrate 
 ##	an prelude environment
 ## </summary>
@@ -64,6 +82,16 @@
 ##	Domain allowed access.
 ##	</summary>
 ## </param>
+## <param name="role">
+##	<summary>
+##	The role to be allowed to manage the syslog domain.
+##	</summary>
+## </param>
+## <param name="terminal">
+##	<summary>
+##	The type of the user terminal.
+##	</summary>
+## </param>
 ## <rolecap/>
 #
 interface(`prelude_admin',`
@@ -71,6 +99,7 @@
 		type prelude_t, prelude_spool_t;
 		type prelude_var_run_t, prelude_var_lib_t;
 		type prelude_audisp_t, prelude_audisp_var_run_t;
+		type prelude_script_exec_t;
 	')
 
 	allow $1 prelude_t:process { ptrace signal_perms };
@@ -79,11 +108,14 @@
 	allow $1 prelude_audisp_t:process { ptrace signal_perms };
 	ps_process_pattern($1, prelude_audisp_t)
 
-	manage_files_pattern($1, prelude_spool_t, prelude_spool_t)
-
-	manage_files_pattern($1, prelude_var_lib_t, prelude_var_lib_t)
-
-	manage_files_pattern($1, prelude_var_run_t, prelude_var_run_t)
-
-	manage_files_pattern($1, prelude_audisp_var_run_t, prelude_audisp_var_run_t)
+	# Allow prelude_t to restart the apache service
+	prelude_script_domtrans($1)
+	domain_system_change_exemption($1)
+	role_transition $2 prelude_script_exec_t system_r;
+	allow $2 system_r;
+
+	manage_all_pattern($1, prelude_spool_t)
+	manage_all_pattern($1, prelude_var_lib_t)
+	manage_all_pattern($1, prelude_var_run_t)
+	manage_all_pattern($1, prelude_audisp_var_run_t)
 ')
--- nsaserefpolicy/policy/modules/services/prelude.te	2008-06-11 08:15:44.000000000 -0400
+++ serefpolicy-3.4.2/policy/modules/services/prelude.te	2008-06-11 13:48:53.000000000 -0400
@@ -19,12 +19,18 @@
 type prelude_var_lib_t;
 files_type(prelude_var_lib_t)
 
+type prelude_script_exec_t;
+init_script_type(prelude_script_exec_t)
+
 type prelude_audisp_t;
 type prelude_audisp_exec_t;
 init_daemon_domain(prelude_audisp_t, prelude_audisp_exec_t)
+typealias prelude_audisp_t alias audisp_prelude_t;
+typealias prelude_audisp_exec_t alias audisp_prelude_exec_t;
 
 type prelude_audisp_var_run_t;
 files_pid_file(prelude_audisp_var_run_t)
+typealias prelude_audisp_var_run_t alias audisp_prelude_var_run_t;
 
 ########################################
 #
@@ -56,6 +62,8 @@
 corenet_tcp_sendrecv_all_if(prelude_t)
 corenet_tcp_sendrecv_all_nodes(prelude_t)
 corenet_tcp_bind_all_nodes(prelude_t)
+corenet_tcp_bind_prelude_port(prelude_t)
+corenet_tcp_connect_prelude_port(prelude_t)
 
 dev_read_rand(prelude_t)
 dev_read_urand(prelude_t)
@@ -66,6 +74,8 @@
 files_read_etc_files(prelude_t)
 files_read_usr_files(prelude_t)
 
+fs_rw_anon_inodefs_files(prelude_t)
+
 auth_use_nsswitch(prelude_t)
 
 libs_use_ld_so(prelude_t)
@@ -110,6 +120,7 @@
 corenet_tcp_sendrecv_all_if(prelude_audisp_t)
 corenet_tcp_sendrecv_all_nodes(prelude_audisp_t)
 corenet_tcp_bind_all_nodes(prelude_audisp_t)
+corenet_tcp_connect_prelude_port(prelude_audisp_t)
 
 dev_read_rand(prelude_audisp_t)
 dev_read_urand(prelude_audisp_t)
@@ -126,6 +137,8 @@
 
 miscfiles_read_localization(prelude_audisp_t)
 
+logging_audisp_system_domain(prelude_audisp_t, prelude_audisp_exec_t)
+
 ########################################
 #
 # prewikka_cgi Declarations

--------------070501070803070807080801
Content-Type: application/pgp-signature;
 name="services_prelude.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="services_prelude.patch.sig"

iEYEABECAAYFAkhQGsgACgkQrlYvE4MpobPvCwCgh7FhDgvpH1vw/ntj2yncPBHlDtIAn2jO
wT1yD9Q/VJWqkSN3iycneDe5
--------------070501070803070807080801--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

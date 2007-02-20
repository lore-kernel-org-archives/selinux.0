Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KGLAYr032118
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 11:21:10 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1KGMRlw028878
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 16:22:27 GMT
Message-ID: <45DB2040.3030209@redhat.com>
Date: Tue, 20 Feb 2007 11:22:24 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Spamd policy patch
Content-Type: multipart/mixed;
 boundary="------------040803090208060909010209"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040803090208060909010209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

spamassassin has a new directory under /var/lib that it stores files in.

Communicates with smtp port directly.

Needs to be able to create ~/.spam* files

Needs to signal pyzor.

--------------040803090208060909010209
Content-Type: text/x-patch;
 name*0="nsaserefpolicy_policy_modules_services_spamassassin.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="nsaserefpolicy_policy_modules_services_spamassassin.patch"

--- nsaserefpolicy/policy/modules/services/spamassassin.fc	2006-11-16 17:15:21.000000000 -0500
+++ serefpolicy-2.5.4/policy/modules/services/spamassassin.fc	2007-02-19 16:01:52.000000000 -0500
@@ -7,6 +7,7 @@
 /usr/sbin/spamd		--	gen_context(system_u:object_r:spamd_exec_t,s0)
 
 /var/spool/spamassassin(/.*)?	gen_context(system_u:object_r:spamd_spool_t,s0)
+/var/lib/spamassassin(/.*)?	gen_context(system_u:object_r:spamd_var_lib_t,s0)
 
 ifdef(`strict_policy',`
 HOME_DIR/\.spamassassin(/.*)?	gen_context(system_u:object_r:ROLE_spamassassin_home_t,s0)
--- nsaserefpolicy/policy/modules/services/spamassassin.if	2007-02-19 11:32:53.000000000 -0500
+++ serefpolicy-2.5.4/policy/modules/services/spamassassin.if	2007-02-19 16:01:52.000000000 -0500
@@ -496,3 +496,44 @@
 
 	dontaudit $1 spamd_tmp_t:sock_file getattr;
 ')
+
+########################################
+## <summary>
+##	Create, read, write, and delete
+##	spamd lib files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`spamassassin_manage_lib_files',`
+	gen_require(`
+		type spamd_var_lib_t;
+	')
+
+	files_search_var_lib($1)
+	manage_dirs_pattern($1,spamd_var_lib_t,spamd_var_lib_t)
+	manage_files_pattern($1,spamd_var_lib_t,spamd_var_lib_t)
+')
+
+########################################
+## <summary>
+##	read spamd lib files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`spamassassin_read_lib_files',`
+	gen_require(`
+		type spamd_var_lib_t;
+	')
+
+	files_search_var_lib($1)
+	read_files_pattern($1,spamd_var_lib_t,spamd_var_lib_t)
+')
+
--- nsaserefpolicy/policy/modules/services/spamassassin.te	2007-02-19 11:32:53.000000000 -0500
+++ serefpolicy-2.5.4/policy/modules/services/spamassassin.te	2007-02-19 16:01:52.000000000 -0500
@@ -8,7 +8,7 @@
 
 # spamassassin client executable
 type spamc_exec_t;
-corecmd_executable_file(spamc_exec_t)
+userdom_executable_file(spamc_exec_t)
 
 type spamd_t;
 type spamd_exec_t;
@@ -17,6 +17,10 @@
 type spamd_spool_t;
 files_type(spamd_spool_t)
 
+# var/lib files
+type spamd_var_lib_t;
+files_type(spamd_var_lib_t)
+
 type spamd_tmp_t;
 files_tmp_file(spamd_tmp_t)
 
@@ -24,7 +28,7 @@
 files_pid_file(spamd_var_run_t)
 
 type spamassassin_exec_t;
-corecmd_executable_file(spamassassin_exec_t)
+userdom_executable_file(spamassassin_exec_t)
 
 ########################################
 #
@@ -77,6 +81,7 @@
 corenet_tcp_bind_all_nodes(spamd_t)
 corenet_tcp_bind_spamd_port(spamd_t)
 corenet_tcp_connect_razor_port(spamd_t)
+corenet_tcp_connect_smtp_port(spamd_t)
 corenet_sendrecv_razor_client_packets(spamd_t)
 corenet_sendrecv_spamd_server_packets(spamd_t)
 # spamassassin 3.1 needs this for its
@@ -110,6 +115,10 @@
 # /var/lib/spamassin
 files_read_var_lib_files(spamd_t)
 
+# var/lib files for spamd
+allow spamd_t spamd_var_lib_t:dir r_dir_perms;
+read_files_pattern(spamd_t,spamd_var_lib_t,spamd_var_lib_t)
+
 init_use_fds(spamd_t)
 init_use_script_ptys(spamd_t)
 init_dontaudit_rw_utmp(spamd_t)
@@ -139,6 +148,7 @@
 
 	tunable_policy(`spamd_enable_home_dirs',`
 		userdom_home_filetrans_generic_user_home_dir(spamd_t)
+		userdom_manage_generic_user_home_dirs(spamd_t)
 		userdom_manage_generic_user_home_content_dirs(spamd_t)
 		userdom_manage_generic_user_home_content_files(spamd_t)
 		userdom_manage_generic_user_home_content_symlinks(spamd_t)
@@ -184,6 +194,7 @@
 
 optional_policy(`
 	pyzor_domtrans(spamd_t)
+	pyzor_signal(spamd_t)
 ')
 
 optional_policy(`

--------------040803090208060909010209--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

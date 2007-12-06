Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB6KD9Nl012121
	for <selinux@tycho.nsa.gov>; Thu, 6 Dec 2007 15:13:09 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lB6KD8Tn011583
	for <selinux@tycho.nsa.gov>; Thu, 6 Dec 2007 20:13:08 GMT
Message-ID: <475857D1.7080300@redhat.com>
Date: Thu, 06 Dec 2007 15:13:05 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: kismet policy
Content-Type: multipart/mixed;
 boundary="------------010202010800060701060608"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010202010800060701060608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Mainly to fix tmpreaper errors.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHWFfQrlYvE4MpobMRAuiKAJ4txdoxxFxZw8YhREDgAV9gtMtFfgCbBBZd
xNXiCrMsY22YT2zsZ6yhShY=
=fHei
-----END PGP SIGNATURE-----

--------------010202010800060701060608
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/tmpreaper.te serefpolicy-3.2.3/policy/modules/admin/tmpreaper.te
--- nsaserefpolicy/policy/modules/admin/tmpreaper.te	2007-10-02 09:54:52.000000000 -0400
+++ serefpolicy-3.2.3/policy/modules/admin/tmpreaper.te	2007-12-06 15:06:34.000000000 -0500
@@ -43,5 +43,10 @@
 cron_system_entry(tmpreaper_t,tmpreaper_exec_t)
 
 optional_policy(`
+	kismet_manage_log(tmpreaper_t)
+')
+
+optional_policy(`
 	lpd_manage_spool(tmpreaper_t)
 ')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/kismet.fc serefpolicy-3.2.3/policy/modules/services/kismet.fc
--- nsaserefpolicy/policy/modules/services/kismet.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.2.3/policy/modules/services/kismet.fc	2007-12-06 15:11:55.000000000 -0500
@@ -0,0 +1,9 @@
+
+/usr/bin/kismet		--	gen_context(system_u:object_r:kismet_exec_t,s0)
+/usr/bin/kismet_server	--	gen_context(system_u:object_r:kismet_exec_t,s0)
+
+/var/run/kismet_server.pid	--	gen_context(system_u:object_r:kismet_var_run_t,s0)
+
+/var/lib/kismet(/.*)?		gen_context(system_u:object_r:kismet_var_lib_t,s0)
+
+/var/log/kismet(/.*)?		gen_context(system_u:object_r:kismet_log_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/kismet.if serefpolicy-3.2.3/policy/modules/services/kismet.if
--- nsaserefpolicy/policy/modules/services/kismet.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.2.3/policy/modules/services/kismet.if	2007-12-06 15:06:34.000000000 -0500
@@ -0,0 +1,275 @@
+
+## <summary>policy for kismet</summary>
+
+########################################
+## <summary>
+##	Execute a domain transition to run kismet.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`kismet_domtrans',`
+	gen_require(`
+		type kismet_t;
+                type kismet_exec_t;
+	')
+
+	domtrans_pattern($1,kismet_exec_t,kismet_t)
+')
+
+
+########################################
+## <summary>
+##	Read kismet PID files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`kismet_read_pid_files',`
+	gen_require(`
+		type kismet_var_run_t;
+	')
+
+	files_search_pids($1)
+	allow $1 kismet_var_run_t:file read_file_perms;
+')
+
+########################################
+## <summary>
+##	Manage kismet var_run files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`kismet_manage_var_run',`
+	gen_require(`
+		type kismet_var_run_t;
+	')
+
+         manage_dirs_pattern($1,kismet_var_run_t,kismet_var_run_t)
+         manage_files_pattern($1,kismet_var_run_t,kismet_var_run_t)
+         manage_lnk_files_pattern($1,kismet_var_run_t,kismet_var_run_t)
+')
+
+
+########################################
+## <summary>
+##	Search kismet lib directories.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`kismet_search_lib',`
+	gen_require(`
+		type kismet_var_lib_t;
+	')
+
+	allow $1 kismet_var_lib_t:dir search_dir_perms;
+	files_search_var_lib($1)
+')
+
+########################################
+## <summary>
+##	Read kismet lib files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`kismet_read_lib_files',`
+	gen_require(`
+		type kismet_var_lib_t;
+	')
+
+	allow $1 kismet_var_lib_t:file read_file_perms;
+	allow $1 kismet_var_lib_t:dir list_dir_perms;
+	files_search_var_lib($1)
+')
+
+########################################
+## <summary>
+##	Create, read, write, and delete
+##	kismet lib files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`kismet_manage_lib_files',`
+	gen_require(`
+		type kismet_var_lib_t;
+	')
+
+	allow $1 kismet_var_lib_t:file manage_file_perms;
+	allow $1 kismet_var_lib_t:dir rw_dir_perms;
+	files_search_var_lib($1)
+')
+
+########################################
+## <summary>
+##	Manage kismet var_lib files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`kismet_manage_var_lib',`
+	gen_require(`
+		type kismet_var_lib_t;
+	')
+
+         manage_dirs_pattern($1,kismet_var_lib_t,kismet_var_lib_t)
+         manage_files_pattern($1,kismet_var_lib_t,kismet_var_lib_t)
+         manage_lnk_files_pattern($1,kismet_var_lib_t,kismet_var_lib_t)
+')
+
+
+########################################
+## <summary>
+##	Allow the specified domain to read kismet's log files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`kismet_read_log',`
+	gen_require(`
+		type kismet_log_t;
+	')
+
+	logging_search_logs($1)
+	read_files_pattern($1, kismet_log_t, kismet_log_t)
+')
+
+########################################
+## <summary>
+##	Allow the specified domain to append
+##	kismet log files.
+## </summary>
+## <param name="domain">
+## 	<summary>
+##	Domain allowed to transition.
+## 	</summary>
+## </param>
+#
+interface(`kismet_append_log',`
+	gen_require(`
+		type var_log_t, kismet_log_t;
+	')
+
+	logging_search_logs($1)
+	append_files_pattern($1, kismet_log_t, kismet_log_t)
+')
+
+########################################
+## <summary>
+##	Allow domain to manage kismet log files
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`kismet_manage_log',`
+	gen_require(`
+		type kismet_log_t;
+	')
+
+	 logging_search_logs($1)
+         manage_dirs_pattern($1,kismet_log_t,kismet_log_t)
+         manage_files_pattern($1,kismet_log_t,kismet_log_t)
+         manage_lnk_files_pattern($1,kismet_log_t,kismet_log_t)
+')
+
+########################################
+## <summary>
+##	Execute kismet in the kismet domain, and
+##	allow the specified role the kismet domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access
+##	</summary>
+## </param>
+## <param name="role">
+##	<summary>
+##	The role to be allowed the kismet domain.
+##	</summary>
+## </param>
+## <param name="terminal">
+##	<summary>
+##	The type of the role's terminal.
+##	</summary>
+## </param>
+#
+interface(`kismet_run',`
+	gen_require(`
+		type kismet_t;
+	')
+
+	kismet_domtrans($1)
+	role $2 types kismet_t;
+	dontaudit kismet_t $3:chr_file rw_term_perms;
+')
+
+
+########################################
+## <summary>
+##	All of the rules required to administrate an kismet environment
+## </summary>
+## <param name="prefix">
+##	<summary>
+##	Prefix of the domain. Example, user would be
+##	the prefix for the uder_t domain.
+##	</summary>
+## </param>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <param name="role">
+##	<summary>
+##	The role to be allowed to manage the kismet domain.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`kismet_admin',`
+	gen_require(`
+		type kismet_t;
+	')
+
+	allow $2 kismet_t:process { ptrace signal_perms getattr };
+	read_files_pattern($2, kismet_t, kismet_t)
+	        
+
+	kismet_manage_var_run($2)
+
+	kismet_manage_var_lib($2)
+
+	kismet_manage_log($2)
+
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/kismet.te serefpolicy-3.2.3/policy/modules/services/kismet.te
--- nsaserefpolicy/policy/modules/services/kismet.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.2.3/policy/modules/services/kismet.te	2007-12-06 15:06:34.000000000 -0500
@@ -0,0 +1,53 @@
+policy_module(kismet,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type kismet_t;
+type kismet_exec_t;
+init_daemon_domain(kismet_t, kismet_exec_t)
+role system_r types kismet_t;
+
+type kismet_var_run_t;
+files_pid_file(kismet_var_run_t)
+
+type kismet_var_lib_t;
+files_type(kismet_var_lib_t)
+
+type kismet_log_t;
+logging_log_file(kismet_log_t)
+
+########################################
+#
+# kismet local policy
+#
+
+allow kismet_t self:capability { net_admin setuid setgid };
+allow kismet_t self:fifo_file rw_file_perms;
+allow kismet_t self:unix_stream_socket create_stream_socket_perms;
+
+corecmd_exec_bin(kismet_t)
+
+files_read_etc_files(kismet_t)
+
+auth_use_nsswitch(kismet_t)
+
+libs_use_ld_so(kismet_t)
+libs_use_shared_libs(kismet_t)
+
+miscfiles_read_localization(kismet_t)
+
+manage_dirs_pattern(kismet_t, kismet_var_run_t,  kismet_var_run_t
+manage_files_pattern(kismet_t, kismet_var_run_t,  kismet_var_run_t
+files_pid_filetrans(kismet_t,kismet_var_run_t, { file dir })
+
+manage_dirs_pattern(kismet_t, kismet_var_lib_t,  kismet_var_lib_t
+manage_files_pattern(kismet_t, kismet_var_lib_t,  kismet_var_lib_t
+files_var_lib_filetrans(kismet_t,kismet_var_lib_t, { file dir })
+
+manage_dirs_pattern(kismet_t, kismet_log_t,  kismet_log_t
+manage_files_pattern(kismet_t, kismet_log_t,  kismet_log_t
+logging_log_filetrans(kismet_t,kismet_log_t,{ file dir })
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.te serefpolicy-3.2.3/policy/modules/system/unconfined.te
--- nsaserefpolicy/policy/modules/system/unconfined.te	2007-11-16 15:30:49.000000000 -0500
+++ serefpolicy-3.2.3/policy/modules/system/unconfined.te	2007-12-06 15:09:45.000000000 -0500
@@ -212,6 +212,10 @@
 	xserver_domtrans_xdm_xserver(unconfined_t)
 ')
 
+optional_policy(`
+	kismet_run(unconfined_t, unconfined_r, { unconfined_tty_device_t unconfined_devpts_t })
+')
+
 ########################################
 #
 # Unconfined Execmem Local policy
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.te serefpolicy-3.2.3/policy/modules/system/userdomain.te
--- nsaserefpolicy/policy/modules/system/userdomain.te	2007-11-29 13:29:35.000000000 -0500
+++ serefpolicy-3.2.3/policy/modules/system/userdomain.te	2007-12-06 15:06:34.000000000 -0500
@@ -352,6 +352,10 @@
 ')
 
 optional_policy(`
+	kismet_run(sysadm_t, sysadm_r, admin_terminal)
+')
+
+optional_policy(`
 	lvm_run(sysadm_t, sysadm_r, admin_terminal)
 ')
 

--------------010202010800060701060608
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iD8DBQBHWFfRrlYvE4MpobMRAqnQAJ9LwKnRvUScqemlnBPbDj+aCmcQPQCdGVBku7kbCXRX
Z/Nlv20DoDffNWQ=
--------------010202010800060701060608--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

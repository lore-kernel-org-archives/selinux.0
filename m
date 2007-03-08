Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28ESq9W003980
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 09:28:52 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l28ESmko002166
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 14:28:49 GMT
Message-ID: <45F01D96.1010806@redhat.com>
Date: Thu, 08 Mar 2007 09:28:38 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: New fail2ban policy
Content-Type: multipart/mixed;
 boundary="------------080500040402010802090605"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080500040402010802090605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Resend to list.


--------------080500040402010802090605
Content-Type: text/x-patch;
 name="nsaserefpolicy_policy_modules_services_fail2ban.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="nsaserefpolicy_policy_modules_services_fail2ban.patch"

--- nsaserefpolicy/policy/modules/services/fail2ban.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/services/fail2ban.fc	2007-03-08 08:42:37.000000000 -0500
@@ -0,0 +1,4 @@
+
+/usr/bin/fail2ban		--	gen_context(system_u:object_r:fail2ban_exec_t,s0)
+/var/log/fail2ban.log		--	gen_context(system_u:object_r:fail2ban_log_t,s0)
+/var/run/fail2ban.pid		--	gen_context(system_u:object_r:fail2ban_var_run_t,s0)
--- nsaserefpolicy/policy/modules/services/fail2ban.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/services/fail2ban.if	2007-03-08 08:42:37.000000000 -0500
@@ -0,0 +1,87 @@
+
+## <summary>policy for fail2ban</summary>
+
+########################################
+## <summary>
+##	Execute a domain transition to run fail2ban.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`fail2ban_domtrans',`
+	gen_require(`
+		type fail2ban_t, fail2ban_exec_t;
+	')
+
+	domain_auto_trans($1,fail2ban_exec_t,fail2ban_t)
+
+	allow fail2ban_t $1:fd use;
+	allow fail2ban_t $1:fifo_file rw_file_perms;
+	allow fail2ban_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##	Allow the specified domain to read fail2ban's log files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`fail2ban_read_log',`
+	gen_require(`
+		type fail2ban_log_t;
+	')
+
+	logging_search_logs($1)
+	allow $1 fail2ban_log_t:dir list_dir_perms;
+	allow $1 fail2ban_log_t:file { read getattr lock };
+')
+
+########################################
+## <summary>
+##	Allow the specified domain to append
+##	fail2ban log files.
+## </summary>
+## <param name="domain">
+## 	<summary>
+##	Domain allowed to transition.
+## 	</summary>
+## </param>
+#
+interface(`fail2ban_append_log',`
+	gen_require(`
+		type var_log_t, fail2ban_log_t;
+	')
+
+	logging_search_logs($1)
+	allow $1 fail2ban_log_t:dir list_dir_perms;
+	allow $1 fail2ban_log_t:file { getattr append };
+')
+
+
+########################################
+## <summary>
+##	Read fail2ban PID files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`fail2ban_read_pid_files',`
+	gen_require(`
+		type fail2ban_var_run_t;
+	')
+
+	files_search_pids($1)
+	allow $1 fail2ban_var_run_t:file r_file_perms;
+')
+
--- nsaserefpolicy/policy/modules/services/fail2ban.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/services/fail2ban.te	2007-03-08 08:42:37.000000000 -0500
@@ -0,0 +1,77 @@
+policy_module(fail2ban,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type fail2ban_t;
+type fail2ban_exec_t;
+domain_type(fail2ban_t)
+init_daemon_domain(fail2ban_t, fail2ban_exec_t)
+
+# log files
+type fail2ban_log_t;
+logging_log_file(fail2ban_log_t)
+
+# pid files
+type fail2ban_var_run_t;
+files_pid_file(fail2ban_var_run_t)
+
+########################################
+#
+# fail2ban local policy
+#
+
+allow fail2ban_t self : capability { net_admin net_raw };
+allow fail2ban_t self : process signal;
+allow fail2ban_t self : rawip_socket { getopt create setopt };
+
+# Init script handling
+init_use_fds(fail2ban_t)
+init_use_script_ptys(fail2ban_t)
+domain_use_interactive_fds(fail2ban_t)
+
+## internal communication is often done using fifo and unix sockets.
+allow fail2ban_t self:fifo_file rw_file_perms;
+allow fail2ban_t self:unix_stream_socket create_stream_socket_perms;
+
+# Some common macros (you might be able to remove some)
+files_read_etc_files(fail2ban_t)
+
+libs_use_ld_so(fail2ban_t)
+libs_use_shared_libs(fail2ban_t)
+
+miscfiles_read_localization(fail2ban_t)
+
+# log files
+allow fail2ban_t fail2ban_log_t:file manage_file_perms;
+allow fail2ban_t fail2ban_log_t:dir { rw_dir_perms setattr };
+logging_log_filetrans(fail2ban_t,fail2ban_log_t,{ file dir })
+
+# pid file
+allow fail2ban_t fail2ban_var_run_t:file manage_file_perms;
+allow fail2ban_t fail2ban_var_run_t:dir rw_dir_perms;
+files_pid_filetrans(fail2ban_t,fail2ban_var_run_t, file)
+
+corecmd_search_sbin(fail2ban_t)
+corecmd_exec_bin(fail2ban_t)
+corecmd_exec_shell(fail2ban_t)
+
+dev_read_urand(fail2ban_t)
+
+files_read_usr_files(fail2ban_t)
+
+logging_read_generic_logs(fail2ban_t)
+
+selinux_get_fs_mount(fail2ban_t)
+
+optional_policy(`
+	iptables_domtrans(fail2ban_t)
+')
+
+ifdef(`targeted_policy',`
+	term_dontaudit_use_unallocated_ttys(fail2ban_t)
+	term_dontaudit_use_generic_ptys(fail2ban_t)
+')
+


--------------080500040402010802090605--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

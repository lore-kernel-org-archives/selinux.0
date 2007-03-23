Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NJRGwO006166
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 15:27:16 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NJREU1002447
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 19:27:15 GMT
Message-ID: <46042A0D.5050309@redhat.com>
Date: Fri, 23 Mar 2007 15:27:09 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Zabbix policy
Content-Type: multipart/mixed;
 boundary="------------000703040103010000050005"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000703040103010000050005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

New pocicy for zabbix.


--------------000703040103010000050005
Content-Type: text/x-patch;
 name="zabbix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="zabbix.patch"

--- nsaserefpolicy/policy/modules/services/zabbix.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.10/policy/modules/services/zabbix.fc	2007-03-22 15:06:59.000000000 -0400
@@ -0,0 +1,4 @@
+
+/usr/bin/zabbix_server		--	gen_context(system_u:object_r:zabbix_exec_t,s0)
+/var/run/zabbix(/.*)?			gen_context(system_u:object_r:zabbix_var_run_t,s0)
+/var/log/zabbix(/.*)?			gen_context(system_u:object_r:zabbix_log_t,s0)
--- nsaserefpolicy/policy/modules/services/zabbix.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.10/policy/modules/services/zabbix.if	2007-03-22 15:06:59.000000000 -0400
@@ -0,0 +1,87 @@
+
+## <summary>policy for zabbix</summary>
+
+########################################
+## <summary>
+##	Execute a domain transition to run zabbix.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`zabbix_domtrans',`
+	gen_require(`
+		type zabbix_t, zabbix_exec_t;
+	')
+
+	domain_auto_trans($1,zabbix_exec_t,zabbix_t)
+
+	allow zabbix_t $1:fd use;
+	allow zabbix_t $1:fifo_file rw_file_perms;
+	allow zabbix_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##	Read zabbix PID files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`zabbix_read_pid_files',`
+	gen_require(`
+		type zabbix_var_run_t;
+	')
+
+	files_search_pids($1)
+	allow $1 zabbix_var_run_t:file r_file_perms;
+')
+
+
+########################################
+## <summary>
+##	Allow the specified domain to read zabbix's log files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`zabbix_read_log',`
+	gen_require(`
+		type zabbix_log_t;
+	')
+
+	logging_search_logs($1)
+	allow $1 zabbix_log_t:dir r_dir_perms;
+	allow $1 zabbix_log_t:file { read getattr lock };
+')
+
+########################################
+## <summary>
+##	Allow the specified domain to append
+##	zabbix log files.
+## </summary>
+## <param name="domain">
+## 	<summary>
+##	Domain allowed to transition.
+## 	</summary>
+## </param>
+#
+interface(`zabbix_append_log',`
+	gen_require(`
+		type var_log_t, zabbix_log_t;
+	')
+
+	logging_search_logs($1)
+	allow $1 zabbix_log_t:dir r_dir_perms;
+	allow $1 zabbix_log_t:file { getattr append };
+')
+
--- nsaserefpolicy/policy/modules/services/zabbix.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.10/policy/modules/services/zabbix.te	2007-03-22 15:06:59.000000000 -0400
@@ -0,0 +1,64 @@
+policy_module(zabbix,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type zabbix_t;
+type zabbix_exec_t;
+domain_type(zabbix_t)
+init_daemon_domain(zabbix_t, zabbix_exec_t)
+
+# pid files
+type zabbix_var_run_t;
+files_pid_file(zabbix_var_run_t)
+
+# log files
+type zabbix_log_t;
+logging_log_file(zabbix_log_t)
+
+########################################
+#
+# zabbix local policy
+#
+# Check in /usr/share/selinux/devel/include for macros to use instead of allow rules.
+
+# Init script handling
+
+
+domain_use_interactive_fds(zabbix_t)
+
+allow zabbix_t self:capability { setuid setgid };
+
+## internal communication is often done using fifo and unix sockets.
+allow zabbix_t self:fifo_file rw_file_perms;
+allow zabbix_t self:unix_stream_socket create_stream_socket_perms;
+
+# Some common macros (you might be able to remove some)
+files_read_etc_files(zabbix_t)
+
+libs_use_ld_so(zabbix_t)
+libs_use_shared_libs(zabbix_t)
+
+miscfiles_read_localization(zabbix_t)
+
+ifdef(`targeted_policy',`
+	term_dontaudit_use_unallocated_ttys(zabbix_t)
+	term_dontaudit_use_generic_ptys(zabbix_t)
+')
+
+
+# pid file
+allow zabbix_t zabbix_var_run_t:file manage_file_perms;
+allow zabbix_t zabbix_var_run_t:dir rw_dir_perms;
+files_pid_filetrans(zabbix_t,zabbix_var_run_t, file)
+
+# log files
+allow zabbix_t zabbix_log_t:file manage_file_perms;
+allow zabbix_t zabbix_log_t:dir { rw_dir_perms setattr };
+logging_log_filetrans(zabbix_t,zabbix_log_t,{ file dir })
+
+optional_policy(`
+	mysql_stream_connect(zabbix_t)
+')

--------------000703040103010000050005--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

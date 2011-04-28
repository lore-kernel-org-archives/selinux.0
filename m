Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3SE40L6032176
	for <selinux@tycho.nsa.gov>; Thu, 28 Apr 2011 10:04:00 -0400
Received: from mail-ww0-f49.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p3SE3xqg000608
	for <selinux@tycho.nsa.gov>; Thu, 28 Apr 2011 14:03:59 GMT
Received: by wwb39 with SMTP id 39so2617320wwb.30
        for <selinux@tycho.nsa.gov>; Thu, 28 Apr 2011 07:03:59 -0700 (PDT)
From: Elia Pinto <andronicus.spiros@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] policy module for atop
Date: Thu, 28 Apr 2011 16:03:56 +0200
Message-Id: <1303999436-1548852-1-git-send-email-andronicus.spiros@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Elia Pinto <gitter.spiros@gmail.com>

---
 policy/modules/admin/logrotate.te |    4 +
 policy/modules/services/atopd.fc  |    8 ++
 policy/modules/services/atopd.if  |  133 +++++++++++++++++++++++++++++++++++++
 policy/modules/services/atopd.te  |   77 +++++++++++++++++++++
 4 files changed, 222 insertions(+), 0 deletions(-)
 create mode 100644 policy/modules/services/atopd.fc
 create mode 100644 policy/modules/services/atopd.if
 create mode 100644 policy/modules/services/atopd.te

diff --git a/policy/modules/admin/logrotate.te b/policy/modules/admin/logrotate.te
index 7090dae..6423b3c 100644
--- a/policy/modules/admin/logrotate.te
+++ b/policy/modules/admin/logrotate.te
@@ -182,6 +182,10 @@ optional_policy(`
 ')
 
 optional_policy(`
+	atopd_signal(logrotate_t)
+')
+
+optional_policy(`
 	mailman_domtrans(logrotate_t)
 	mailman_search_data(logrotate_t)
 	mailman_manage_log(logrotate_t)
diff --git a/policy/modules/services/atopd.fc b/policy/modules/services/atopd.fc
new file mode 100644
index 0000000..508a650
--- /dev/null
+++ b/policy/modules/services/atopd.fc
@@ -0,0 +1,8 @@
+/etc/rc\.d/init\.d/atopd        --      gen_context(system_u:object_r:atopd_initrc_exec_t,s0)
+/usr/bin/atopd                  --      gen_context(system_u:object_r:atopd_exec_t,s0)
+/usr/bin/atop                   --      gen_context(system_u:object_r:atopd_exec_t,s0)
+
+/var/log/atop(/.*)?                     gen_context(system_u:object_r:atopd_log_t,s0)
+/var/run/atop\.pid              --      gen_context(system_u:object_r:atopd_var_run_t,s0)
+/tmp/atop.d(/.*)?                       gen_context(system_u:object_r:atopd_tmp_t,s0)
+
diff --git a/policy/modules/services/atopd.if b/policy/modules/services/atopd.if
new file mode 100644
index 0000000..8e9c1e4
--- /dev/null
+++ b/policy/modules/services/atopd.if
@@ -0,0 +1,133 @@
+## <summary>policy for atopd</summary>
+
+
+########################################
+## <summary>
+##      Execute a domain transition to run atopd.
+## </summary>
+## <param name="domain">
+## <summary>
+##      Domain allowed access.
+## </summary>
+## </param>
+#
+interface(`atopd_domtrans',`
+        gen_require(`
+                type atopd_t, atopd_exec_t;
+        ')
+
+        domtrans_pattern($1, atopd_exec_t, atopd_t)
+')
+
+
+########################################
+## <summary>
+##      Allow the specified domain to read atopd's log files.
+## </summary>
+## <param name="domain">
+##      <summary>
+##      Domain allowed access.
+##      </summary>
+## </param>
+## <rolecap/>
+#
+interface(`atopd_read_log',`
+        gen_require(`
+                type atopd_log_t;
+        ')
+
+        logging_search_logs($1)
+        read_files_pattern($1, atopd_log_t, atopd_log_t)
+')
+
+########################################
+## <summary>
+##      Allow the specified domain to append
+##      atopd log files.
+## </summary>
+## <param name="domain">
+##      <summary>
+##      Domain allowed to transition.
+##      </summary>
+## </param>
+#
+interface(`atopd_append_log',`
+        gen_require(`
+                type atopd_log_t;
+        ')
+
+        logging_search_logs($1)
+        append_files_pattern($1, atopd_log_t, atopd_log_t)
+')
+
+########################################
+## <summary>
+##      Allow domain to manage atopd log files
+## </summary>
+## <param name="domain">
+##      <summary>
+##      Domain to not audit.
+##      </summary>
+## </param>
+#
+interface(`atopd_manage_log',`
+        gen_require(`
+                type atopd_log_t;
+        ')
+
+        logging_search_logs($1)
+        manage_dirs_pattern($1, atopd_log_t, atopd_log_t)
+        manage_files_pattern($1, atopd_log_t, atopd_log_t)
+        manage_lnk_files_pattern($1, atopd_log_t, atopd_log_t)
+')
+
+########################################
+## <summary>
+##      All of the rules required to administrate
+##      an atopd environment
+## </summary>
+## <param name="domain">
+##      <summary>
+##      Domain allowed access.
+##      </summary>
+## </param>
+## <param name="role">
+##      <summary>
+##      Role allowed access.
+##      </summary>
+## </param>
+## <rolecap/>
+#
+interface(`atopd_admin',`
+        gen_require(`
+                type atopd_t;
+                type atopd_log_t;
+        ')
+
+        allow $1 atopd_t:process { ptrace signal_perms };
+        ps_process_pattern($1, atopd_t)
+
+        logging_search_logs($1)
+        admin_pattern($1, atopd_log_t)
+
+')
+
+########################################
+## <summary>
+##    Allow domain signal atopd
+## </summary>
+## <param name="domain">
+##    <summary>
+##    Domain to not audit.
+##    </summary>
+## </param>
+#
+interface(`atopd_signal',`
+    gen_require(`
+        type atopd_t;
+    ')
+
+    allow $1 atopd_t:process signal;
+')
+
+
diff --git a/policy/modules/services/atopd.te b/policy/modules/services/atopd.te
new file mode 100644
index 0000000..c53ecda
--- /dev/null
+++ b/policy/modules/services/atopd.te
@@ -0,0 +1,77 @@
+policy_module(atopd,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type atopd_t;
+type atopd_exec_t;
+init_daemon_domain(atopd_t, atopd_exec_t)
+
+
+type atopd_initrc_exec_t;
+init_script_file(atopd_initrc_exec_t)
+
+
+can_exec(atopd_t, atopd_exec_t)
+
+type atopd_log_t;
+logging_log_file(atopd_log_t)
+
+type atopd_var_run_t;
+files_pid_file(atopd_var_run_t)
+
+type atopd_tmp_t;
+files_tmp_file(atopd_tmp_t)
+
+
+
+########################################
+#
+# atopd local policy
+#
+
+allow atopd_t self:fifo_file rw_fifo_file_perms;
+allow atopd_t self:unix_stream_socket create_stream_socket_perms;
+
+allow atopd_t self:sem create_sem_perms;
+allow atopd_t self:capability { net_admin setuid sys_nice sys_resource sys_ptrace ipc_lock sys_pacct };
+allow atopd_t self:process    { setsched sigkill setrlimit };
+
+manage_dirs_pattern(atopd_t, atopd_log_t, atopd_log_t)
+manage_files_pattern(atopd_t, atopd_log_t, atopd_log_t)
+logging_log_filetrans(atopd_t, atopd_log_t, { dir file } )
+
+domain_use_interactive_fds(atopd_t)
+
+files_read_etc_files(atopd_t)
+
+miscfiles_read_localization(atopd_t)
+
+
+# pid files
+manage_dirs_pattern(atopd_t, atopd_var_run_t, atopd_var_run_t)
+manage_files_pattern(atopd_t, atopd_var_run_t, atopd_var_run_t)
+files_pid_filetrans(atopd_t, atopd_var_run_t, { dir file  })
+
+# tmp files
+manage_dirs_pattern(atopd_t, atopd_tmp_t, atopd_tmp_t)
+manage_files_pattern(atopd_t, atopd_tmp_t, atopd_tmp_t)
+files_tmp_filetrans(atopd_t, atopd_tmp_t, { dir file  })
+
+
+
+auth_use_nsswitch(atopd_t)
+
+domain_read_all_domains_state(atopd_t)
+
+kernel_list_proc(atopd_t)
+kernel_read_network_state(atopd_t)
+kernel_read_system_state(atopd_t)
+
+fs_getattr_xattr_fs(atopd_t)
+
+corecmd_exec_bin(atopd_t)
+
+acct_manage_data(atopd_t)
-- 
1.7.2.1.44.g721e7


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

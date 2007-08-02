Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72Kudgo027724
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:56:39 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KucTm009994
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:56:38 GMT
Date: Thu, 2 Aug 2007 16:56:32 -0400
Message-Id: <200708022056.l72KuW1v000654@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_consolekit changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Multiple minor fixes

--- nsaserefpolicy/policy/modules/services/consolekit.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/consolekit.te	2007-08-02 11:02:02.000000000 -0400
@@ -10,7 +10,6 @@
 type consolekit_exec_t;
 init_daemon_domain(consolekit_t, consolekit_exec_t)
 
-# pid files
 type consolekit_var_run_t;
 files_pid_file(consolekit_var_run_t)
 
@@ -25,7 +24,6 @@
 allow consolekit_t self:unix_stream_socket create_stream_socket_perms;
 allow consolekit_t self:unix_dgram_socket create_socket_perms;
 
-# pid file
 manage_files_pattern(consolekit_t,consolekit_var_run_t,consolekit_var_run_t)
 files_pid_filetrans(consolekit_t,consolekit_var_run_t, file)
 
@@ -38,6 +36,7 @@
 
 domain_read_all_domains_state(consolekit_t)
 domain_use_interactive_fds(consolekit_t)
+domain_dontaudit_ptrace_all_domains(consolekit_t)
 
 files_read_etc_files(consolekit_t)
 # needs to read /var/lib/dbus/machine-id
@@ -50,8 +49,15 @@
 libs_use_ld_so(consolekit_t)
 libs_use_shared_libs(consolekit_t)
 
+logging_send_syslog_msg(consolekit_t)
+
 miscfiles_read_localization(consolekit_t)
 
+# consolekit needs to be able to ptrace all logged in users 
+userdom_ptrace_all_users(consolekit_t)
+hal_ptrace(consolekit_t)
+mcs_ptrace_all(consolekit_t)
+
 optional_policy(`
 	dbus_system_bus_client_template(consolekit, consolekit_t)
 	dbus_send_system_bus(consolekit_t)
@@ -62,9 +68,17 @@
 	optional_policy(`
 		unconfined_dbus_chat(consolekit_t)
 	')
+
+	userdom_dbus_chat_all_users(consolekit_t)
 ')
 
 optional_policy(`
 	xserver_read_all_users_xauth(consolekit_t)
 	xserver_stream_connect_xdm_xserver(consolekit_t)
 ')
+
+optional_policy(`
+	#reading .Xauthity
+	unconfined_ptrace(consolekit_t)
+')
+

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbKVj014091
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:20 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbH2p008299
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:17 GMT
Date: Wed, 30 May 2007 11:01:49 -0400
Message-Id: <200705301501.l4UF1nVB009223@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: Fixes for consolekit
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Consolekit ptraces all users looking for environment flags

--- nsaserefpolicy/policy/modules/services/consolekit.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/consolekit.te	2007-05-30 09:25:53.000000000 -0400
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
 
@@ -50,8 +48,15 @@
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
@@ -68,3 +73,9 @@
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

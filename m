Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NK4uTl008424
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 16:04:56 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NK4tU1009704
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 20:04:55 GMT
Message-ID: <460432E1.5000503@redhat.com>
Date: Fri, 23 Mar 2007 16:04:49 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: consolekit needs additional privs.
Content-Type: multipart/mixed;
 boundary="------------020808060307000403030209"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020808060307000403030209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

consolekit uses a pidfile

sends itself signals

reads /var/lib/dbus/machine-id

Needs to search and read users environments

Uses dbus to communicate with unconfined processes.

--------------020808060307000403030209
Content-Type: text/x-patch;
 name="consolekit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="consolekit.patch"

--- nsaserefpolicy/policy/modules/services/consolekit.fc	2007-03-20 09:23:13.000000000 -0400
+++ serefpolicy-2.5.10/policy/modules/services/consolekit.fc	2007-03-22 15:06:59.000000000 -0400
@@ -1 +1,2 @@
 /usr/sbin/console-kit-daemon	--	gen_context(system_u:object_r:consolekit_exec_t,s0)
+/var/run/consolekit.pid		--	gen_context(system_u:object_r:consolekit_var_run_t,s0)
--- nsaserefpolicy/policy/modules/services/consolekit.te	2007-03-20 23:38:12.000000000 -0400
+++ serefpolicy-2.5.10/policy/modules/services/consolekit.te	2007-03-22 15:06:59.000000000 -0400
@@ -10,13 +10,16 @@
 type consolekit_exec_t;
 init_daemon_domain(consolekit_t, consolekit_exec_t)
 
+# pid files
+type consolekit_var_run_t;
+files_pid_file(consolekit_var_run_t)
+
 ########################################
 #
 # consolekit local policy
 #
-
 allow consolekit_t self:capability { sys_tty_config dac_override sys_nice sys_ptrace };
-allow consolekit_t self:process getsched;
+allow consolekit_t self:process { getsched signal };
 allow consolekit_t self:fifo_file rw_fifo_file_perms;
 allow consolekit_t self:unix_stream_socket create_stream_socket_perms;
 
@@ -27,6 +30,10 @@
 domain_use_interactive_fds(consolekit_t)
 
 files_read_etc_files(consolekit_t)
+# needs to read /var/lib/dbus/machine-id
+files_read_var_lib_files(consolekit_t)
+
+
 
 libs_use_ld_so(consolekit_t)
 libs_use_shared_libs(consolekit_t)
@@ -38,10 +45,25 @@
 	term_dontaudit_use_generic_ptys(consolekit_t)
 ')
 
+# pid file
+allow consolekit_t consolekit_var_run_t:file manage_file_perms;
+allow consolekit_t consolekit_var_run_t:dir rw_dir_perms;
+files_pid_filetrans(consolekit_t,consolekit_var_run_t, file)
+
+# Init script handling
+
+
+domain_ptrace_all_domains(consolekit_t)
+mcs_ptrace_all(consolekit_t)
+
 optional_policy(`
 	dbus_system_bus_client_template(consolekit, consolekit_t)
 	dbus_send_system_bus(consolekit_t)
 	dbus_connect_system_bus(consolekit_t)
 
 	hal_dbus_chat(consolekit_t)
+	unconfined_dbus_chat(consolekit_t)
 ')
+
+term_use_console(consolekit_t)
+

--------------020808060307000403030209--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

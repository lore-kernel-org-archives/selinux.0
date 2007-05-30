Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbffL014319
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:41 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbe2p008401
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:40 GMT
Date: Wed, 30 May 2007 10:38:34 -0400
Message-Id: <200705301438.l4UEcYWj008006@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: openct modifications
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

correct path to executable
Additional interfaces
openct execs itself and needs access to smartcards and usb devices

--- nsaserefpolicy/policy/modules/services/openct.fc	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/openct.fc	2007-05-30 09:08:15.000000000 -0400
@@ -2,6 +2,7 @@
 # /usr
 #
 /usr/sbin/openct-control	 --	gen_context(system_u:object_r:openct_exec_t,s0)
+/usr/sbin/ifdhandler		--	gen_context(system_u:object_r:openct_exec_t,s0)
 
 #
 # /var
--- nsaserefpolicy/policy/modules/services/openct.if	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/openct.if	2007-05-30 09:08:15.000000000 -0400
@@ -1 +1,82 @@
 ## <summary>Service for handling smart card readers.</summary>
+
+########################################
+## <summary>
+##	Execute a domain transition to run openct.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`openct_domtrans',`
+	gen_require(`
+		type openct_t, openct_exec_t;
+	')
+
+	domain_auto_trans($1,openct_exec_t,openct_t)
+
+	allow openct_t $1:fd use;
+	allow openct_t $1:fifo_file rw_file_perms;
+	allow openct_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##	Read openct PID files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`openct_read_pid_files',`
+	gen_require(`
+		type openct_var_run_t;
+	')
+
+	files_search_pids($1)
+	allow $1 openct_var_run_t:dir search_dir_perms;
+	allow $1 openct_var_run_t:file r_file_perms;
+')
+
+########################################
+## <summary>
+##	Connect to openct over an unix stream socket.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`openct_stream_connect',`
+	gen_require(`
+		type openct_t, openct_var_run_t;
+	')
+
+	files_search_pids($1)
+	allow $1 openct_var_run_t:dir search_dir_perms;
+	allow $1 openct_var_run_t:sock_file write;
+	allow $1 openct_t:unix_stream_socket connectto;
+')
+
+########################################
+## <summary>
+##	Send openct a null signal.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`openct_signull',`
+	gen_require(`
+		type openct_t;
+	')
+
+	allow $1 openct_t:process signull;
+')
--- nsaserefpolicy/policy/modules/services/openct.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/openct.te	2007-05-30 09:08:15.000000000 -0400
@@ -21,9 +21,13 @@
 dontaudit openct_t self:capability sys_tty_config;
 allow openct_t self:process signal_perms;
 
+can_exec(openct_t,openct_exec_t)
+
 manage_files_pattern(openct_t,openct_var_run_t,openct_var_run_t)
 files_pid_filetrans(openct_t,openct_var_run_t,file)
 
+corecmd_search_bin(openct_t)
+
 kernel_read_kernel_sysctls(openct_t)
 kernel_list_proc(openct_t)
 kernel_read_proc_symlinks(openct_t)
@@ -31,6 +35,8 @@
 dev_read_sysfs(openct_t)
 # openct asks for this
 dev_rw_usbfs(openct_t)
+dev_rw_smartcard(openct_t)
+dev_rw_generic_usb_dev(openct_t)
 
 domain_use_interactive_fds(openct_t)
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

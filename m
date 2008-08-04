Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74Cc2wx012031
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:38:02 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74Cc07E010549
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:38:00 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id 761935E2
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:37:58 +0200 (CEST)
Message-Id: <20080804123735.501182274@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:35:02 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 06/35] soundserver policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This policy was written by Ken Yang and reviewed by Dan Walsh:
http://marc.info/?l=fedora-selinux-list&m=118561164825982&w=2
and here:
https://bugzilla.redhat.com/show_bug.cgi?id=250453

I updated the .fc changes to also work with Debian paths.

Originally submitted Jul 19, refreshed to apply cleanly

Index: refpolicy/policy/modules/services/soundserver.fc
===================================================================
--- refpolicy.orig/policy/modules/services/soundserver.fc	2008-08-03 13:09:39.000000000 +0200
+++ refpolicy/policy/modules/services/soundserver.fc	2008-08-03 17:07:46.000000000 +0200
@@ -7,4 +7,8 @@
 /usr/sbin/yiff		--	gen_context(system_u:object_r:soundd_exec_t,s0)
 
 /var/run/yiff-[0-9]+\.pid --	gen_context(system_u:object_r:soundd_var_run_t,s0)
+/var/run/nasd(/.*)?  	gen_context(system_u:object_r:soundd_var_run_t,s0)
+
 /var/state/yiff(/.*)?		gen_context(system_u:object_r:soundd_state_t,s0)
+
+/etc/(rc.d/)?init.d/nas(d)?	--	gen_context(system_u:object_r:soundd_script_exec_t,s0)
Index: refpolicy/policy/modules/services/soundserver.if
===================================================================
--- refpolicy.orig/policy/modules/services/soundserver.if	2008-08-03 13:09:39.000000000 +0200
+++ refpolicy/policy/modules/services/soundserver.if	2008-08-03 17:13:28.000000000 +0200
@@ -13,3 +13,74 @@
 interface(`soundserver_tcp_connect',`
 	refpolicywarn(`$0($*) has been deprecated.')
 ')
+
+########################################
+## <summary>
+##	Execute soundd server in the soundd domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+#
+interface(`soundserver_script_domtrans',`
+	gen_require(`
+		type soundd_script_exec_t;
+	')
+
+	init_script_domtrans_spec($1,soundd_script_exec_t)
+')
+
+########################################
+## <summary>
+##	All of the rules required to administrate
+##	an soundd environment
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <param name="role">
+##	<summary>
+##	The role to be allowed to manage the soundd domain.
+##	</summary>
+## </param>
+## <param name="terminal">
+##	<summary>
+##	The type of the user terminal.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`soundserver_admin',`
+	gen_require(`
+		type soundd_t;
+		type soundd_script_exec_t;
+		type soundd_etc_t;
+		type soundd_tmp_t;
+		type soundd_var_run_t;
+	')
+
+	allow $1 soundd_t:process { ptrace signal_perms getattr };
+	read_files_pattern($1, soundd_t, soundd_t)
+
+	# Allow soundd_t to restart the apache service
+	soundserver_script_domtrans($1)
+	domain_system_change_exemption($1)
+	role_transition $2 soundd_script_exec_t system_r;
+	allow $2 system_r;
+
+	files_list_tmp($1)
+        manage_all_pattern($1,soundd_tmp_t)
+
+	files_list_etc($1)
+        manage_all_pattern($1,soundd_etc_t)
+
+	files_list_pids($1)
+        manage_all_pattern($1,soundd_var_run_t)
+')
+
+
Index: refpolicy/policy/modules/services/soundserver.te
===================================================================
--- refpolicy.orig/policy/modules/services/soundserver.te	2008-08-03 16:47:00.000000000 +0200
+++ refpolicy/policy/modules/services/soundserver.te	2008-08-03 17:11:27.000000000 +0200
@@ -10,9 +10,6 @@
 type soundd_exec_t;
 init_daemon_domain(soundd_t, soundd_exec_t)
 
-type soundd_etc_t alias etc_soundd_t;
-files_type(soundd_etc_t)
-
 type soundd_state_t;
 files_type(soundd_state_t)
 
@@ -26,21 +23,30 @@
 type soundd_var_run_t;
 files_pid_file(soundd_var_run_t)
 
+type soundd_etc_t;
+files_config_file(soundd_etc_t)
+
+type soundd_script_exec_t;
+init_script_type(soundd_script_exec_t)
+
 ########################################
 #
-# Declarations
+# sound server local policy
 #
 
+allow soundd_t self:capability dac_override;
 dontaudit soundd_t self:capability sys_tty_config;
 allow soundd_t self:process { setpgid signal_perms };
 allow soundd_t self:tcp_socket create_stream_socket_perms;
 allow soundd_t self:udp_socket create_socket_perms;
+allow soundd_t self:unix_stream_socket { connectto create_stream_socket_perms };
+
+fs_getattr_all_fs(soundd_t)
+
 # for yiff
 allow soundd_t self:shm create_shm_perms;
 
-allow soundd_t soundd_etc_t:dir list_dir_perms;
-allow soundd_t soundd_etc_t:file read_file_perms;
-allow soundd_t soundd_etc_t:lnk_file { getattr read };
+read_files_pattern(soundd_t,soundd_etc_t,soundd_etc_t)
 
 manage_files_pattern(soundd_t, soundd_state_t, soundd_state_t)
 manage_lnk_files_pattern(soundd_t, soundd_state_t, soundd_state_t)
@@ -55,8 +61,10 @@
 manage_sock_files_pattern(soundd_t, soundd_tmpfs_t, soundd_tmpfs_t)
 fs_tmpfs_filetrans(soundd_t, soundd_tmpfs_t, { dir file lnk_file sock_file fifo_file })
 
+manage_sock_files_pattern(soundd_t,soundd_var_run_t,soundd_var_run_t)
 manage_files_pattern(soundd_t, soundd_var_run_t, soundd_var_run_t)
-files_pid_filetrans(soundd_t, soundd_var_run_t, file)
+manage_dirs_pattern(soundd_t,soundd_var_run_t,soundd_var_run_t)
+files_pid_filetrans(soundd_t,soundd_var_run_t,{ file dir })
 
 kernel_read_kernel_sysctls(soundd_t)
 kernel_list_proc(soundd_t)
@@ -96,10 +104,13 @@
 sysnet_read_config(soundd_t)
 
 userdom_dontaudit_use_unpriv_user_fds(soundd_t)
-
 sysadm_dontaudit_search_home_dirs(soundd_t)
 
 optional_policy(`
+	alsa_domtrans(soundd_t)
+')
+
+optional_policy(`
 	seutil_sigchld_newrole(soundd_t)
 ')
 

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

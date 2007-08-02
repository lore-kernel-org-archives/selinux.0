Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KZNXB024917
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:35:23 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KZKTm005610
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:35:20 GMT
Date: Thu, 2 Aug 2007 16:34:43 -0400
Message-Id: <200708022034.l72KYhN8032390@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_soundserver changes add nasd policy
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/soundserver.fc	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/soundserver.fc	2007-08-02 11:02:02.000000000 -0400
@@ -1,10 +1,22 @@
-/etc/nas(/.*)?			gen_context(system_u:object_r:soundd_etc_t,s0)
-/etc/yiff(/.*)?			gen_context(system_u:object_r:soundd_etc_t,s0)
-
-/usr/bin/nasd		--	gen_context(system_u:object_r:soundd_exec_t,s0)
 /usr/bin/gpe-soundserver --	gen_context(system_u:object_r:soundd_exec_t,s0)
-
 /usr/sbin/yiff		--	gen_context(system_u:object_r:soundd_exec_t,s0)
-
 /var/run/yiff-[0-9]+\.pid --	gen_context(system_u:object_r:soundd_var_run_t,s0)
 /var/state/yiff(/.*)?		gen_context(system_u:object_r:soundd_state_t,s0)
+
+
+#
+# Following is for nas
+
+#
+# /usr/bin
+#
+
+/usr/bin/nasd		--	gen_context(system_u:object_r:soundd_exec_t,s0)
+
+
+# 
+# /tmp
+#
+/tmp/\.sockets		-d	gen_context(system_u:object_r:soundd_tmp_t,s0)
+/tmp/\.sockets/.*	-s	<<none>>
+
--- nsaserefpolicy/policy/modules/services/soundserver.if	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/soundserver.if	2007-08-02 11:02:02.000000000 -0400
@@ -13,3 +13,64 @@
 interface(`soundserver_tcp_connect',`
 	refpolicywarn(`$0($*) has been deprecated.')
 ')
+
+
+########################################
+## <summary>
+##	Execute a domain transition to run soundserver.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`soundserver_domtrans',`
+	gen_require(`
+		type soundd_t, soundd_exec_t;
+	')
+
+	domain_auto_trans($1,soundd_exec_t,soundd_t)
+
+	allow soundd_t $1:fd use;
+	allow soundd_t $1:fifo_file rw_file_perms;
+	allow soundd_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##	Do not audit attempts to read, 
+##	soundserver tmp files
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`soundserver_dontaudit_read_tmp_files',`
+	gen_require(`
+		type soundd_tmp_t;
+	')
+
+	dontaudit $1 soundd_tmp_t:file r_file_perms;
+')
+
+########################################
+## <summary>
+##	Allow domain to read, soundserver tmp files
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`soundserver_read_tmp_files',`
+	gen_require(`
+		type soundd_tmp_t;
+	')
+
+	dontaudit $1 soundd_tmp_t:file r_file_perms;
+')
+
--- nsaserefpolicy/policy/modules/services/soundserver.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/soundserver.te	2007-08-02 11:02:02.000000000 -0400
@@ -1,5 +1,5 @@
 
-policy_module(soundserver,1.3.0)
+policy_module(soundserver,1.2.1)
 
 ########################################
 #
@@ -10,9 +10,6 @@
 type soundd_exec_t;
 init_daemon_domain(soundd_t,soundd_exec_t)
 
-type soundd_etc_t alias etc_soundd_t;
-files_type(soundd_etc_t)
-
 type soundd_state_t;
 files_type(soundd_state_t)
 
@@ -28,20 +25,34 @@
 
 ########################################
 #
-# Declarations
+# sound server local policy
 #
 
 dontaudit soundd_t self:capability sys_tty_config;
 allow soundd_t self:process { setpgid signal_perms };
+
 allow soundd_t self:tcp_socket create_stream_socket_perms;
 allow soundd_t self:udp_socket create_socket_perms;
+
+allow soundd_t self:unix_stream_socket { connectto create_stream_socket_perms };
+manage_sock_files_pattern(soundd_t,soundd_tmp_t,soundd_tmp_t)
+files_tmp_filetrans(soundd_t, soundd_tmp_t, { file dir sock_file })
+
+
+# Remove /tmp/.sockets/audio$n
+delete_files_pattern(soundd_t,soundd_tmp_t,soundd_tmp_t)
+
+allow soundd_t self:capability { dac_override };
+
+fs_getattr_all_fs(soundd_t)
+
+optional_policy(`
+	alsa_domtrans(soundd_t)
+')
+
 # for yiff
 allow soundd_t self:shm create_shm_perms;
 
-allow soundd_t soundd_etc_t:dir list_dir_perms;
-allow soundd_t soundd_etc_t:file read_file_perms;
-allow soundd_t soundd_etc_t:lnk_file { getattr read };
-
 manage_files_pattern(soundd_t,soundd_state_t,soundd_state_t)
 manage_lnk_files_pattern(soundd_t,soundd_state_t,soundd_state_t)
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

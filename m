Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72Ksoxm027438
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:54:50 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KsnM1010616
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:54:49 GMT
Date: Thu, 2 Aug 2007 16:54:46 -0400
Message-Id: <200708022054.l72Ksk97000591@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_dbus changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

dbus uses var_lib
Multiple small fixes

--- nsaserefpolicy/policy/modules/services/dbus.fc	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/dbus.fc	2007-08-02 11:02:02.000000000 -0400
@@ -5,6 +5,8 @@
 /bin/dbus-daemon 	--	gen_context(system_u:object_r:system_dbusd_exec_t,s0)
 /var/run/dbus(/.*)?		gen_context(system_u:object_r:system_dbusd_var_run_t,s0)
 
+/var/lib/dbus(/.*)? gen_context(system_u:object_r:system_dbusd_var_lib_t,s0)
+
 ifdef(`distro_redhat',`
 /var/named/chroot/var/run/dbus(/.*)?	gen_context(system_u:object_r:system_dbusd_var_run_t,s0)
 ')
--- nsaserefpolicy/policy/modules/services/dbus.if	2007-07-03 07:06:27.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/dbus.if	2007-08-02 11:02:02.000000000 -0400
@@ -50,6 +50,12 @@
 ## </param>
 #
 template(`dbus_per_role_template',`
+	gen_require(`
+		type system_dbusd_exec_t;
+		type system_dbusd_t;
+		type dbusd_etc_t;
+		class dbus { send_msg acquire_svc };
+	')
 
 	##############################
 	#
@@ -71,6 +77,7 @@
 	#
 
 	allow $1_dbusd_t self:process { getattr sigkill signal };
+	dontaudit $1_dbusd_t self:process ptrace;
 	allow $1_dbusd_t self:file { getattr read write };
 	allow $1_dbusd_t self:fifo_file rw_fifo_file_perms;
 	allow $1_dbusd_t self:dbus { send_msg acquire_svc };
@@ -135,6 +142,19 @@
 	selinux_compute_relabel_context($1_dbusd_t)
 	selinux_compute_user_contexts($1_dbusd_t)
 
+	corecmd_bin_domtrans($1_dbusd_t, $1_t)
+	allow $1_dbusd_t $1_t:process sigkill;
+
+	allow $1_t $1_dbusd_t:fd use;
+	allow $1_t $1_dbusd_t:fifo_file rw_fifo_file_perms;
+	allow $1_t $1_dbusd_t:process sigchld;
+	
+	ifdef(`hide_broken_symptoms', `
+		dontaudit $1_t $1_dbusd_t:netlink_selinux_socket { read write };
+	');
+
+	userdom_read_user_home_content_files($1, $1_dbusd_t)
+
 	auth_read_pam_console_data($1_dbusd_t)
 
 	libs_use_ld_so($1_dbusd_t)
@@ -193,6 +213,7 @@
 	gen_require(`
 		type system_dbusd_t, system_dbusd_t;
 		type system_dbusd_var_run_t;
+		type system_dbusd_var_lib_t;
 		class dbus send_msg;
 	')
 
@@ -202,9 +223,12 @@
 	# SE-DBus specific permissions
 	allow $1_dbusd_system_t { system_dbusd_t self }:dbus send_msg;
 
+	read_files_pattern($2,system_dbusd_var_lib_t,system_dbusd_var_lib_t)
+
 	# For connecting to the bus
 	files_search_pids($2)
 	stream_connect_pattern($2,system_dbusd_var_run_t,system_dbusd_var_run_t,system_dbusd_t)
+	dbus_read_config($2)
 ')
 
 #######################################
@@ -271,6 +295,32 @@
 	allow $2 $1_dbusd_t:dbus send_msg;
 ')
 
+
+########################################
+## <summary>
+##	connectto a message on user/application specific DBUS.
+## </summary>
+## <param name="domain_prefix">
+##	<summary>
+##	The prefix of the domain (e.g., user
+##	is the prefix for user_t).
+##	</summary>
+## </param>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+template(`dbus_connectto_user_bus',`
+	gen_require(`
+		type $1_dbusd_t;
+	')
+
+	allow $2 $1_dbusd_t:unix_stream_socket connectto;
+')
+
+
 ########################################
 ## <summary>
 ##	Read dbus configuration.
@@ -286,6 +336,7 @@
 		type dbusd_etc_t;
 	')
 
+	allow $1 dbusd_etc_t:dir list_dir_perms;
 	allow $1 dbusd_etc_t:file read_file_perms;
 ')
 
@@ -346,3 +397,23 @@
 
 	allow $1 system_dbusd_t:dbus *;
 ')
+
+########################################
+## <summary>
+##	dontaudit attempts to use system_dbus_t selinux_socket
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`dbus_dontaudit_rw_system_selinux_socket',`
+	gen_require(`
+		type system_dbusd_t;
+	')
+
+	dontaudit $1 system_dbusd_t:netlink_selinux_socket { read write };
+')
+
+
--- nsaserefpolicy/policy/modules/services/dbus.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/dbus.te	2007-08-02 11:02:02.000000000 -0400
@@ -23,6 +23,9 @@
 type system_dbusd_var_run_t;
 files_pid_file(system_dbusd_var_run_t)
 
+type system_dbusd_var_lib_t;
+files_pid_file(system_dbusd_var_lib_t)
+
 ##############################
 #
 # Local policy
@@ -48,6 +51,8 @@
 manage_files_pattern(system_dbusd_t,system_dbusd_tmp_t,system_dbusd_tmp_t)
 files_tmp_filetrans(system_dbusd_t, system_dbusd_tmp_t, { file dir })
 
+read_files_pattern(system_dbusd_t,system_dbusd_var_lib_t,system_dbusd_var_lib_t)
+
 manage_files_pattern(system_dbusd_t,system_dbusd_var_run_t,system_dbusd_var_run_t)
 manage_sock_files_pattern(system_dbusd_t,system_dbusd_var_run_t,system_dbusd_var_run_t)
 files_pid_filetrans(system_dbusd_t,system_dbusd_var_run_t,file)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

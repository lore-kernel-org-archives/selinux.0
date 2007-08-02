Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KbqOP025144
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:37:52 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KbpM1007246
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:37:51 GMT
Date: Thu, 2 Aug 2007 16:37:48 -0400
Message-Id: <200708022037.l72KbmTS032482@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_setroubleshoot changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Uses nsswitch
New interface to remove avc messages from unprivledged users try to connect
Checks attributes of files

--- nsaserefpolicy/policy/modules/services/setroubleshoot.if	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/setroubleshoot.if	2007-08-02 11:02:02.000000000 -0400
@@ -19,3 +19,22 @@
 	allow $1 setroubleshoot_var_run_t:sock_file write;
 	allow $1 setroubleshootd_t:unix_stream_socket connectto;
 ')
+
+########################################
+## <summary>
+##	Dontaudit Connect to setroubleshootd over an unix stream socket.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`setroubleshoot_dontaudit_stream_connect',`
+	gen_require(`
+		type setroubleshootd_t, setroubleshoot_var_run_t;
+	')
+
+	dontaudit $1 setroubleshoot_var_run_t:sock_file write;
+	dontaudit $1 setroubleshootd_t:unix_stream_socket connectto;
+')
--- nsaserefpolicy/policy/modules/services/setroubleshoot.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/setroubleshoot.te	2007-08-02 11:02:02.000000000 -0400
@@ -33,7 +33,6 @@
 allow setroubleshootd_t self:tcp_socket create_stream_socket_perms;
 allow setroubleshootd_t self:unix_stream_socket { create_stream_socket_perms connectto };
 allow setroubleshootd_t self:unix_dgram_socket create_socket_perms;
-allow setroubleshootd_t self:netlink_route_socket r_netlink_socket_perms;
 
 # database files
 allow setroubleshootd_t setroubleshoot_var_lib_t:dir setattr;
@@ -51,6 +50,8 @@
 manage_sock_files_pattern(setroubleshootd_t,setroubleshoot_var_run_t,setroubleshoot_var_run_t)
 files_pid_filetrans(setroubleshootd_t,setroubleshoot_var_run_t, { file sock_file })
 
+auth_use_nsswitch(setroubleshootd_t)
+
 kernel_read_kernel_sysctls(setroubleshootd_t)
 kernel_read_system_state(setroubleshootd_t)
 kernel_read_network_state(setroubleshootd_t)
@@ -76,6 +77,9 @@
 files_getattr_all_dirs(setroubleshootd_t)
 files_getattr_all_files(setroubleshootd_t)
 
+fs_getattr_all_dirs(setroubleshootd_t)
+fs_getattr_all_files(setroubleshootd_t)
+
 selinux_get_enforce_mode(setroubleshootd_t)
 selinux_validate_context(setroubleshootd_t)
 
@@ -108,6 +112,3 @@
         rpm_use_script_fds(setroubleshootd_t)
 ')
 
-optional_policy(`
-	nis_use_ypbind(setroubleshootd_t)
-')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

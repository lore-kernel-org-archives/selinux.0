Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0BLaoXf000917
	for <selinux@tycho.nsa.gov>; Wed, 11 Jan 2006 16:36:50 -0500 (EST)
Received: from e34.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0BLZim0004951
	for <selinux@tycho.nsa.gov>; Wed, 11 Jan 2006 21:35:44 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k0BLanL3021053
	for <selinux@tycho.nsa.gov>; Wed, 11 Jan 2006 16:36:49 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k0BLcqX5147830
	for <selinux@tycho.nsa.gov>; Wed, 11 Jan 2006 14:38:52 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k0BLam0U013522
	for <selinux@tycho.nsa.gov>; Wed, 11 Jan 2006 14:36:48 -0700
Received: from sergelap.hallyn.com (sig-9-65-123-242.mts.ibm.com [9.65.123.242])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id k0BLalNO013496
	for <selinux@tycho.nsa.gov>; Wed, 11 Jan 2006 14:36:48 -0700
Date: Wed, 11 Jan 2006 15:36:47 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH] sereference: enable local login
Message-ID: <20060111213646.GA30428@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Following is a patch which allows me to log in locally on a gentoo
system with the reference policy.

thanks,
-serge

Index: refpolicy/policy/modules/system/userdomain.if
===================================================================
--- refpolicy.orig/policy/modules/system/userdomain.if
+++ refpolicy/policy/modules/system/userdomain.if
@@ -33,6 +33,9 @@ template(`base_user_template',`
 	role $1_r types $1_t;
 	allow system_r $1_r;
 
+	allow $1_t local_login_t:process { sigchld };
+	files_read_etc_runtime_files($1_t);
+
 	# user pseudoterminal
 	type $1_devpts_t;
 	term_user_pty($1_t,$1_devpts_t)
@@ -66,6 +69,7 @@ template(`base_user_template',`
 
 	type $1_tty_device_t; 
 	term_tty($1_t,$1_tty_device_t)
+	fs_associate_tmpfs($1_tty_device_t)
 
 	##############################
 	#
Index: refpolicy/policy/modules/system/authlogin.if
===================================================================
--- refpolicy.orig/policy/modules/system/authlogin.if
+++ refpolicy/policy/modules/system/authlogin.if
@@ -115,6 +115,8 @@ template(`authlogin_per_userdomain_templ
 	allow $2 self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
 
 	dontaudit $2 shadow_t:file { getattr read };
+	typeattribute $2 can_read_shadow_passwords;
+	allow $2 shadow_t:file { getattr read };
 
 	# Transition from the user domain to this domain.
 	domain_auto_trans($2,chkpwd_exec_t,$1_chkpwd_t)
@@ -253,6 +255,8 @@ interface(`auth_domtrans_chk_passwd',`
 	allow system_chkpwd_t $1:process sigchld;
 
 	dontaudit $1 shadow_t:file { getattr read };
+	typeattribute $1 can_read_shadow_passwords;
+	allow $1 shadow_t:file { getattr read };
 
 	dev_read_rand($1)
 	dev_read_urand($1)
Index: refpolicy/policy/modules/system/locallogin.te
===================================================================
--- refpolicy.orig/policy/modules/system/locallogin.te
+++ refpolicy/policy/modules/system/locallogin.te
@@ -61,6 +61,21 @@ files_create_tmp_files(local_login_t, lo
 kernel_read_system_state(local_login_t)
 kernel_read_kernel_sysctl(local_login_t)
 
+corecmd_exec_sbin(local_login_t)
+libs_use_shared_libs(local_login_t)
+
+# not sure where better to put the initrc_t ones:
+# note that initrc_t is defined in mls.te!
+dev_rw_generic_file(initrc_t)
+dev_manage_dev_nodes(initrc_t)
+dev_manage_dev_nodes(init_t)
+dev_manage_dev_nodes(local_login_t)
+files_rw_etc_files(initrc_t)
+auth_rw_login_records(initrc_t)
+dev_setattr_all_chr_files(getty_t)
+udev_read_state(init_t)
+init_allow_unix_stream_connect(local_login_t)
+
 dev_setattr_mouse(local_login_t)
 dev_getattr_mouse(local_login_t)
 dev_getattr_power_management(local_login_t)
Index: refpolicy/policy/modules/system/init.if
===================================================================
--- refpolicy.orig/policy/modules/system/init.if
+++ refpolicy/policy/modules/system/init.if
@@ -873,3 +873,17 @@ interface(`init_dontaudit_rw_script_pid'
 	dontaudit $1 initrc_var_run_t:file { getattr read write append };
 ')
 
+## <summary>
+##	Allow a domain to access init_t socket.  (?)
+## </summary>
+## <param name="domain">
+##	Domain allowed access.
+## </param>
+interface(`init_allow_unix_stream_connect',`
+	gen_require(`
+		type init_t;;
+	')
+
+	allow $1 init_t:unix_stream_socket { connectto accept };
+')
+
Index: refpolicy/policy/modules/kernel/terminal.fc
===================================================================
--- refpolicy.orig/policy/modules/kernel/terminal.fc
+++ refpolicy/policy/modules/kernel/terminal.fc
@@ -1,5 +1,6 @@
 
 /dev/.*tty[^/]*		-c	gen_context(system_u:object_r:tty_device_t,s0)
+/dev/.*tty[^/]*		-l	gen_context(system_u:object_r:tty_device_t,s0)
 /dev/[pt]ty[abcdepqrstuvwxyz][0-9a-f]	-c gen_context(system_u:object_r:bsdpty_device_t,s0)
 /dev/adb.*		-c	gen_context(system_u:object_r:tty_device_t,s0)
 /dev/capi.*		-c	gen_context(system_u:object_r:tty_device_t,s0)
@@ -14,6 +15,7 @@
 /dev/rfcomm[0-9]+	-c	gen_context(system_u:object_r:tty_device_t,s0)
 /dev/tty		-c	gen_context(system_u:object_r:devtty_t,s0)
 /dev/ttySG.*		-c	gen_context(system_u:object_r:tty_device_t,s0)
+/dev/tts/[0-9]		-c	gen_context(system_u:object_r:tty_device_t,s0)
 
 /dev/pty/.*		-c	gen_context(system_u:object_r:bsdpty_device_t,s0)
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

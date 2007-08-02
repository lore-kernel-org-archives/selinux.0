Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KHr78023116
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:17:53 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KHpM1003190
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:17:51 GMT
Date: Thu, 2 Aug 2007 16:17:48 -0400
Message-Id: <200708022017.l72KHmPN030112@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: system_sysnetwork changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

dhcpc needs to read urand for ldap
Now needs to ptrace itself
Runs ntpdate
Runs restorecon

--- nsaserefpolicy/policy/modules/system/sysnetwork.if	2007-07-03 07:06:32.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/system/sysnetwork.if	2007-08-02 11:02:02.000000000 -0400
@@ -522,6 +522,8 @@
 
 	files_search_etc($1)
 	allow $1 net_conf_t:file read_file_perms;
+	# LDAP Configuration using encrypted requires
+	dev_read_urand($1)
 ')
 
 ########################################
--- nsaserefpolicy/policy/modules/system/sysnetwork.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/system/sysnetwork.te	2007-08-02 11:02:02.000000000 -0400
@@ -45,7 +45,7 @@
 dontaudit dhcpc_t self:capability sys_tty_config;
 # for access("/etc/bashrc", X_OK) on Red Hat
 dontaudit dhcpc_t self:capability { dac_read_search sys_module };
-allow dhcpc_t self:process signal_perms;
+allow dhcpc_t self:process { ptrace signal_perms };
 allow dhcpc_t self:fifo_file rw_file_perms;
 allow dhcpc_t self:tcp_socket create_stream_socket_perms;
 allow dhcpc_t self:udp_socket create_socket_perms;
@@ -159,6 +159,10 @@
 	dbus_connect_system_bus(dhcpc_t)
 	dbus_send_system_bus(dhcpc_t)
 
+	dbus_read_config(dhcpc_t)
+
+	dbus_dontaudit_rw_system_selinux_socket(dhcpc_t)
+
 	optional_policy(`
 		networkmanager_dbus_chat(dhcpc_t)
 	')
@@ -206,6 +210,7 @@
 	# dhclient sometimes starts ntpd
 	init_exec_script_files(dhcpc_t)
 	ntp_domtrans(dhcpc_t)
+	ntp_domtrans_ntpdate(dhcpc_t)
 ')
 
 optional_policy(`
@@ -216,6 +221,7 @@
 optional_policy(`
 	seutil_sigchld_newrole(dhcpc_t)
 	seutil_dontaudit_search_config(dhcpc_t)
+	seutil_domtrans_setfiles(dhcpc_t)
 ')
 
 optional_policy(`
@@ -280,6 +286,8 @@
 fs_getattr_xattr_fs(ifconfig_t)
 fs_search_auto_mountpoints(ifconfig_t)
 
+selinux_dontaudit_getattr_fs(ifconfig_t)
+
 term_dontaudit_use_all_user_ttys(ifconfig_t)
 term_dontaudit_use_all_user_ptys(ifconfig_t)
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

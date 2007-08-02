Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72IWFfB013712
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 14:32:15 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72IWDev010273
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 18:32:13 GMT
Message-ID: <46B222FC.3040504@redhat.com>
Date: Thu, 02 Aug 2007 14:31:24 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: [Fwd: [PATCH] refpolicy: system_locallogin changes]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Changes for local login

Not sure init_system_domain is still needed
On big iron console_device_t is the label of the actuall console
Login now talks dbus
Remove unconfined_domain no longer necessary


--- nsaserefpolicy/policy/modules/system/locallogin.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.4/policy/modules/system/locallogin.te	2007-07-25 12:23:11.000000000 -0400
@@ -25,6 +25,7 @@
 domain_role_change_exemption(sulogin_t)
 domain_interactive_fd(sulogin_t)
 init_domain(sulogin_t,sulogin_exec_t)
+init_system_domain(sulogin_t,sulogin_exec_t)
 role system_r types sulogin_t;
 
 ########################################
@@ -97,6 +98,11 @@
 term_setattr_all_user_ttys(local_login_t)
 term_setattr_unallocated_ttys(local_login_t)
 
+tunable_policy(`allow_console_login', `
+     term_relabel_console(local_login_t)
+     term_setattr_console(local_login_t)
+')
+
 auth_rw_login_records(local_login_t)
 auth_rw_faillog(local_login_t)
 auth_manage_pam_console_data(local_login_t)
@@ -160,6 +166,15 @@
 ')
 
 optional_policy(`
+	consolekit_dbus_chat(local_login_t)
+')
+
+optional_policy(`
+	dbus_system_bus_client_template(local_login,local_login_t)
+	dbus_send_system_bus(local_login_t)
+')
+
+optional_policy(`
 	gpm_getattr_gpmctl(local_login_t)
 	gpm_setattr_gpmctl(local_login_t)
 ')
@@ -178,13 +193,18 @@
 ')
 
 optional_policy(`
-	unconfined_domain(local_login_t)
+	unconfined_shell_domtrans(local_login_t)
 ')
 
 optional_policy(`
 	usermanage_read_crack_db(local_login_t)
 ')
 
+optional_policy(`
+	xserver_read_xdm_tmp_files(local_login_t)
+	xserver_rw_xdm_tmp_files(local_login_t)
+')
+
 #################################
 # 
 # Sulogin local policy



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

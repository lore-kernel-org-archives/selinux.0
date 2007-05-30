Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHc0Qe014641
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:38:00 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbt2p008445
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:56 GMT
Date: Wed, 30 May 2007 11:42:16 -0400
Message-Id: <200705301542.l4UFgGRc011857@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: apps_gnome changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fix up interfaces for gnome
--- nsaserefpolicy/policy/modules/apps/gnome.if	2007-05-29 14:10:48.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/apps/gnome.if	2007-05-30 09:25:53.000000000 -0400
@@ -35,6 +35,7 @@
 template(`gnome_per_role_template',`
 	gen_require(`
 		type gconfd_exec_t;
+		type gconf_etc_t;
 		attribute gnomedomain;
 	')
 
@@ -102,6 +103,11 @@
 
 	optional_policy(`
 		nscd_dontaudit_search_pid($1_gconfd_t)
+		nscd_socket_use($1_gconfd_t)
+	')
+
+	optional_policy(`
+		ssh_dontaudit_use_user_ssh_agent_fds($1,$1_gconfd_t)
 	')
 
 	optional_policy(`
@@ -136,13 +142,32 @@
 	allow $2 $1_gconfd_t:unix_stream_socket connectto;
 ')
 
+
+########################################
+## <summary>
+##	Send general signals to all gconf domains.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`gnome_signal_all',`
+	gen_require(`
+		attribute gnomedomain;
+	')
+
+	allow $1 gnomedomain:process signal;
+')
+
 ########################################
 ## <summary>
 ##	Run gconfd in the role-specific gconfd domain.
 ## </summary>
 ## <desc>
 ##	<p>
-##	Run gconfd in the role-specfic gconfd domain.
+##	Run gconfd in the role-specific gconfd domain.
 ##	</p>
 ##	<p>
 ##	This is a templated interface, and should only

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

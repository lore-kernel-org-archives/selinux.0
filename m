Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3KIs9l5025108
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 14:54:09 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3KIs7P1026941
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 18:54:08 GMT
From: dwalsh@redhat.com
Date: Fri, 20 Apr 2007 14:54:04 -0400
Message-Id: <200704201854.l3KIs47L027135@redsox.boston.devel.redhat.com>
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: logwatch tries to look at avahi, avahi needs to use winbind
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/admin/logwatch.te	2007-04-10 12:52:58.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/admin/logwatch.te	2007-04-11 17:07:34.000000000 -0400
@@ -95,6 +95,10 @@
 ')
 
 optional_policy(`
+	avahi_dontaudit_search_pid(logwatch_t)
+')
+
+optional_policy(`
 	bind_read_config(logwatch_t)
 	bind_read_zone(logwatch_t)
 ')
--- nsaserefpolicy/policy/modules/services/avahi.if	2007-01-02 12:57:43.000000000 -0500
+++ serefpolicy-2.5.12/policy/modules/services/avahi.if	2007-04-11 17:07:34.000000000 -0400
@@ -39,3 +39,22 @@
 	files_search_pids($1)
 	stream_connect_pattern($1,avahi_var_run_t,avahi_var_run_t,avahi_t)
 ')
+
+########################################
+## <summary>
+##	Do not audit attempts to search the AVAHI pid directory.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`avahi_dontaudit_search_pid',`
+	gen_require(`
+		type avahi_var_run_t;
+	')
+
+	dontaudit $1 avahi_var_run_t:dir search_dir_perms;
+')
+
--- nsaserefpolicy/policy/modules/services/avahi.te	2007-03-20 23:38:05.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/services/avahi.te	2007-04-18 16:04:51.000000000 -0400
@@ -105,3 +105,7 @@
 optional_policy(`
 	udev_read_db(avahi_t)
 ')
+
+optional_policy(`
+	samba_stream_connect_winbind(avahi_t)
+')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

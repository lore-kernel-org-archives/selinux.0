Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72Jb80i019676
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 15:37:08 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72Jb7OD024582
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 19:37:07 GMT
Date: Thu, 2 Aug 2007 15:36:59 -0400
Message-Id: <200708021936.l72JaxML028850@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: admin_logrotate changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

logrotate uses nsswitch.

--- nsaserefpolicy/policy/modules/admin/logrotate.te	2007-07-25 10:37:43.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/admin/logrotate.te	2007-08-02 11:02:02.000000000 -0400
@@ -75,11 +75,13 @@
 mls_file_read_up(logrotate_t)
 mls_file_write_down(logrotate_t)
 mls_file_upgrade(logrotate_t)
+mls_process_write_down(logrotate_t)
 
 selinux_get_fs_mount(logrotate_t)
 selinux_get_enforce_mode(logrotate_t)
 
 auth_manage_login_records(logrotate_t)
+auth_use_nsswitch(logrotate_t)
 
 # Run helper programs.
 corecmd_exec_bin(logrotate_t)
@@ -95,6 +97,7 @@
 files_read_etc_files(logrotate_t)
 files_read_etc_runtime_files(logrotate_t)
 files_read_all_pids(logrotate_t)
+files_search_all(logrotate_t)
 # Write to /var/spool/slrnpull - should be moved into its own type.
 files_manage_generic_spool(logrotate_t)
 files_manage_generic_spool_dirs(logrotate_t)
@@ -114,8 +117,6 @@
 
 seutil_dontaudit_read_config(logrotate_t)
 
-sysnet_read_config(logrotate_t)
-
 userdom_dontaudit_search_sysadm_home_dirs(logrotate_t)
 userdom_use_unpriv_users_fds(logrotate_t)
 
@@ -177,14 +178,6 @@
 ')
 
 optional_policy(`
-	nis_use_ypbind(logrotate_t)
-')
-
-optional_policy(`
-	nscd_socket_use(logrotate_t)
-')
-
-optional_policy(`
 	slrnpull_manage_spool(logrotate_t)
 ')
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

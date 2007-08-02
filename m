Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72L0Dqh028082
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 17:00:13 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72L0BTm010955
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 21:00:12 GMT
Date: Thu, 2 Aug 2007 17:00:08 -0400
Message-Id: <200708022100.l72L08Ii000786@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_automount changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

automount reads /dev/rand
corecmd_exec_bin defined twice

--- nsaserefpolicy/policy/modules/services/automount.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/automount.te	2007-08-02 11:02:02.000000000 -0400
@@ -69,6 +69,7 @@
 files_mounton_all_mountpoints(automount_t)
 files_mount_all_file_type_fs(automount_t)
 files_unmount_all_file_type_fs(automount_t)
+files_manage_non_security_dirs(automount_t)
 
 fs_mount_all_fs(automount_t)
 fs_unmount_all_fs(automount_t)
@@ -99,6 +100,7 @@
 
 dev_read_sysfs(automount_t)
 # for SSP
+dev_read_rand(automount_t)
 dev_read_urand(automount_t)
 
 domain_use_interactive_fds(automount_t)
@@ -147,10 +149,6 @@
 userdom_dontaudit_search_sysadm_home_dirs(automount_t)
 
 optional_policy(`
-	corecmd_exec_bin(automount_t)
-')
-
-optional_policy(`
 	bind_search_cache(automount_t)
 ')
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

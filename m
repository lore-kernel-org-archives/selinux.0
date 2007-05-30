Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHatok013803
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:55 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHaq2p008238
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:53 GMT
Date: Wed, 30 May 2007 11:05:39 -0400
Message-Id: <200705301505.l4UF5dTl009288@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: Automount changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

automount manages all directories
Needs to read /dev/rand

--- nsaserefpolicy/policy/modules/services/automount.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/automount.te	2007-05-30 07:35:54.000000000 -0400
@@ -69,6 +69,7 @@
 files_mounton_all_mountpoints(automount_t)
 files_mount_all_file_type_fs(automount_t)
 files_unmount_all_file_type_fs(automount_t)
+files_manage_non_security_dirs(automount_t)
 
 fs_mount_all_fs(automount_t)
 fs_unmount_all_fs(automount_t)
@@ -98,6 +99,7 @@
 
 dev_read_sysfs(automount_t)
 # for SSP
+dev_read_rand(automount_t)
 dev_read_urand(automount_t)
 
 domain_use_interactive_fds(automount_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

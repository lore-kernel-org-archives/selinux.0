Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3KIrNKV025008
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 14:53:23 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3KIrLP1026799
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 18:53:22 GMT
From: dwalsh@redhat.com
Date: Fri, 20 Apr 2007 14:53:14 -0400
Message-Id: <200704201853.l3KIrEGf027126@redsox.boston.devel.redhat.com>
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: bluetooth reads inotifyfs_t:dir
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/bluetooth.te	2007-03-20 23:38:04.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/services/bluetooth.te	2007-04-11 17:07:34.000000000 -0400
@@ -98,7 +98,7 @@
 
 fs_getattr_all_fs(bluetooth_t)
 fs_search_auto_mountpoints(bluetooth_t)
-fs_search_inotifyfs(bluetooth_t)
+fs_list_inotifyfs(bluetooth_t)
 
 #Handle bluetooth serial devices
 term_use_unallocated_ttys(bluetooth_t)

From:  <dwalsh@redhat.com>
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: bluetooth reads inotifyfs_t:dir


--- nsaserefpolicy/policy/modules/services/bluetooth.te	2007-03-20 23:38:04.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/services/bluetooth.te	2007-04-11 17:07:34.000000000 -0400
@@ -98,7 +98,7 @@
 
 fs_getattr_all_fs(bluetooth_t)
 fs_search_auto_mountpoints(bluetooth_t)
-fs_search_inotifyfs(bluetooth_t)
+fs_list_inotifyfs(bluetooth_t)
 
 #Handle bluetooth serial devices
 term_use_unallocated_ttys(bluetooth_t)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

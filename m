Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KDfAt022801
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:13:41 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KDdTm001686
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:13:39 GMT
Date: Thu, 2 Aug 2007 16:13:36 -0400
Message-Id: <200708022013.l72KDahn029980@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: kernel_storage changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

New storage devices.
Fedora has fixed_disk_device_t chr files

--- nsaserefpolicy/policy/modules/kernel/storage.fc	2007-06-15 14:54:30.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/kernel/storage.fc	2007-08-02 11:02:02.000000000 -0400
@@ -23,6 +23,7 @@
 /dev/loop.*		-b	gen_context(system_u:object_r:fixed_disk_device_t,mls_systemhigh)
 /dev/lvm		-c	gen_context(system_u:object_r:fixed_disk_device_t,mls_systemhigh)
 /dev/mcdx?		-b	gen_context(system_u:object_r:removable_device_t,s0)
+/dev/megadev.*		-c	gen_context(system_u:object_r:removable_device_t,s0)
 /dev/mmcblk.*		-b	gen_context(system_u:object_r:removable_device_t,s0)
 /dev/nb[^/]+		-b	gen_context(system_u:object_r:fixed_disk_device_t,mls_systemhigh)
 /dev/optcd		-b	gen_context(system_u:object_r:removable_device_t,s0)
--- nsaserefpolicy/policy/modules/kernel/storage.if	2007-06-15 14:54:30.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/kernel/storage.if	2007-08-02 11:02:02.000000000 -0400
@@ -100,6 +100,7 @@
 
 	dev_list_all_dev_nodes($1)
 	allow $1 fixed_disk_device_t:blk_file read_blk_file_perms;
+	allow $1 fixed_disk_device_t:chr_file read_chr_file_perms;
 	typeattribute $1 fixed_disk_raw_read;
 ')
 
@@ -144,6 +145,7 @@
 
 	dev_list_all_dev_nodes($1)
 	allow $1 fixed_disk_device_t:blk_file write_blk_file_perms;
+	allow $1 fixed_disk_device_t:chr_file write_chr_file_perms;
 	typeattribute $1 fixed_disk_raw_write;
 ')
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

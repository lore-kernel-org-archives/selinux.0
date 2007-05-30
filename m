Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHakqH013498
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:46 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHai2p008173
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:44 GMT
Date: Wed, 30 May 2007 08:50:35 -0400
Message-Id: <200705301250.l4UCoZCF003454@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: Mdadm makes its own devices, reads generic iscsi
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/system/raid.te	2007-05-29 14:10:58.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/system/raid.te	2007-05-30 07:35:54.000000000 -0400
@@ -19,7 +19,7 @@
 # Local policy
 #
 
-allow mdadm_t self:capability { dac_override sys_admin ipc_lock };
+allow mdadm_t self:capability { dac_override mknod sys_admin ipc_lock };
 dontaudit mdadm_t self:capability sys_tty_config;
 allow mdadm_t self:process { sigchld sigkill sigstop signull signal };
 allow mdadm_t self:fifo_file rw_fifo_file_perms;
@@ -46,6 +46,7 @@
 # RAID block device access
 storage_manage_fixed_disk(mdadm_t)
 storage_dev_filetrans_fixed_disk(mdadm_t)
+storage_read_scsi_generic(mdadm_t)
 
 term_dontaudit_list_ptys(mdadm_t)
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

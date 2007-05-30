Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHaowd013650
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:50 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHan2p008196
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:49 GMT
Date: Wed, 30 May 2007 11:25:27 -0400
Message-Id: <200705301525.l4UFPRvF010540@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: admin_prelink changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Prelink needs to be able to write execs in /usr dirs
Needs sys_resource capability

--- nsaserefpolicy/policy/modules/admin/prelink.te	2007-05-29 14:10:59.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/admin/prelink.te	2007-05-30 09:25:53.000000000 -0400
@@ -26,7 +26,7 @@
 # Local policy
 #
 
-allow prelink_t self:capability { chown dac_override fowner fsetid };
+allow prelink_t self:capability { chown dac_override fowner fsetid sys_resource };
 allow prelink_t self:process { execheap execmem execstack signal };
 allow prelink_t self:fifo_file rw_fifo_file_perms;
 
@@ -65,6 +65,7 @@
 files_read_etc_files(prelink_t)
 files_read_etc_runtime_files(prelink_t)
 files_dontaudit_read_all_symlinks(prelink_t)
+files_manage_usr_files(prelink_t)
 
 fs_getattr_xattr_fs(prelink_t)
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

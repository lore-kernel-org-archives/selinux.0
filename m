Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KQQ8J023992
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:26:26 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KQPM1005117
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:26:26 GMT
Date: Thu, 2 Aug 2007 16:26:18 -0400
Message-Id: <200708022026.l72KQI9M032096@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: system_lvm changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

New directory for cache file
Interacts with xen
runs modutils
creates tmp files in /dev

--- nsaserefpolicy/policy/modules/system/lvm.fc	2007-05-29 14:10:58.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/system/lvm.fc	2007-08-02 11:02:02.000000000 -0400
@@ -15,6 +15,7 @@
 #
 /etc/lvm(/.*)?			gen_context(system_u:object_r:lvm_etc_t,s0)
 /etc/lvm/\.cache	--	gen_context(system_u:object_r:lvm_metadata_t,s0)
+/etc/lvm/cache(/.*)?		gen_context(system_u:object_r:lvm_metadata_t,s0)
 /etc/lvm/archive(/.*)?		gen_context(system_u:object_r:lvm_metadata_t,s0)
 /etc/lvm/backup(/.*)?		gen_context(system_u:object_r:lvm_metadata_t,s0)
 /etc/lvm/lock(/.*)?		gen_context(system_u:object_r:lvm_lock_t,s0)
@@ -228,6 +231,8 @@
 dev_dontaudit_getattr_generic_blk_files(lvm_t)
 dev_dontaudit_getattr_generic_pipes(lvm_t)
 dev_create_generic_dirs(lvm_t)
+dev_delete_generic_dirs(lvm_t)
+dev_rw_generic_files(lvm_t)
 
 fs_getattr_xattr_fs(lvm_t)
 fs_search_auto_mountpoints(lvm_t)
@@ -246,6 +251,7 @@
 storage_dev_filetrans_fixed_disk(lvm_t)
 # Access raw devices and old /dev/lvm (c 109,0).  Is this needed?
 storage_manage_fixed_disk(lvm_t)
+mls_file_read_up(lvm_t)
 
 term_getattr_all_user_ttys(lvm_t)
 term_list_ptys(lvm_t)
@@ -293,5 +299,15 @@
 ')
 
 optional_policy(`
+	modutils_domtrans_insmod(lvm_t)
+')
+
+optional_policy(`
 	udev_read_db(lvm_t)
 ')
+
+optional_policy(`
+	xen_append_log(lvm_t)
+	xen_dontaudit_rw_unix_stream_sockets(lvm_t)
+')
+

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

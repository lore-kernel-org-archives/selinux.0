Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbLq7014143
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:21 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbG2p008294
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:17 GMT
Date: Wed, 30 May 2007 10:17:51 -0400
Message-Id: <200705301417.l4UEHpv6007730@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: remove uncofined_domain from modutils, needs to exec scripts, few other fixes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/system/modutils.te	2007-05-29 14:10:58.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/system/modutils.te	2007-05-30 08:54:03.000000000 -0400
@@ -102,6 +102,7 @@
 init_use_fds(insmod_t)
 init_use_script_fds(insmod_t)
 init_use_script_ptys(insmod_t)
+init_spec_domtrans_script(insmod_t)
 
 libs_use_ld_so(insmod_t)
 libs_use_shared_libs(insmod_t)
@@ -118,6 +119,18 @@
 }
 
 optional_policy(`
+	alsa_domtrans(insmod_t)
+')
+
+optional_policy(`
+	firstboot_dontaudit_rw_pipes(insmod_t)
+')
+
+optional_policy(`
+	hal_write_log(insmod_t)
+')
+
+optional_policy(`
 	hotplug_search_config(insmod_t)
 ')
 
@@ -150,6 +163,7 @@
 
 optional_policy(`
 	rpm_rw_pipes(insmod_t)
+	rpm_read_script_tmp_files(insmod_t)
 ')
 
 optional_policy(`
@@ -180,7 +194,8 @@
 
 files_read_kernel_symbol_table(depmod_t)
 files_read_kernel_modules(depmod_t)
+files_delete_kernel_modules(depmod_t)
 
 fs_getattr_xattr_fs(depmod_t)
 
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

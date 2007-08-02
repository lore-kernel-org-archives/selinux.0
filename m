Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KOCFk023795
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:24:12 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KOBM1004782
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:24:11 GMT
Date: Thu, 2 Aug 2007 16:24:08 -0400
Message-Id: <200708022024.l72KO8fA032021@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: system_modutils changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Many policy changes required for running insmod, no longer unconfined

--- nsaserefpolicy/policy/modules/system/modutils.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/system/modutils.te	2007-08-02 11:02:02.000000000 -0400
@@ -42,7 +42,7 @@
 # insmod local policy
 #
 
-allow insmod_t self:capability { dac_override net_raw sys_tty_config };
+allow insmod_t self:capability { dac_override mknod net_raw sys_nice sys_tty_config };
 allow insmod_t self:process { execmem sigchld sigkill sigstop signull signal };
 
 allow insmod_t self:udp_socket create_socket_perms; 
@@ -63,6 +63,7 @@
 kernel_read_kernel_sysctls(insmod_t)
 kernel_rw_kernel_sysctl(insmod_t)
 kernel_read_hotplug_sysctls(insmod_t)
+kernel_setsched(insmod_t)
 
 files_read_kernel_modules(insmod_t)
 # for locking: (cjp: ????)
@@ -76,9 +77,7 @@
 dev_read_sound(insmod_t)
 dev_write_sound(insmod_t)
 dev_rw_apm_bios(insmod_t)
-# cjp: why is this needed?  insmod cannot mounton any dir
-# and it also transitions to mount
-dev_mount_usbfs(insmod_t)
+dev_create_generic_chr_files(insmod_t)
 
 fs_getattr_xattr_fs(insmod_t)
 
@@ -101,6 +100,7 @@
 init_use_fds(insmod_t)
 init_use_script_fds(insmod_t)
 init_use_script_ptys(insmod_t)
+init_spec_domtrans_script(insmod_t)
 
 libs_use_ld_so(insmod_t)
 libs_use_shared_libs(insmod_t)
@@ -112,11 +112,25 @@
 
 seutil_read_file_contexts(insmod_t)
 
+term_dontaudit_use_unallocated_ttys(insmod_t)
+
 if( ! secure_mode_insmod ) {
 	kernel_domtrans_to(insmod_t,insmod_exec_t)
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
 
@@ -149,6 +163,7 @@
 
 optional_policy(`
 	rpm_rw_pipes(insmod_t)
+	rpm_read_script_tmp_files(insmod_t)
 ')
 
 optional_policy(`
@@ -179,6 +194,7 @@
 
 files_read_kernel_symbol_table(depmod_t)
 files_read_kernel_modules(depmod_t)
+files_delete_kernel_modules(depmod_t)
 
 fs_getattr_xattr_fs(depmod_t)
 
@@ -205,9 +221,12 @@
 userdom_read_staff_home_content_files(depmod_t)
 userdom_read_sysadm_home_content_files(depmod_t)
 
+userdom_dontaudit_use_sysadm_terms(depmod_t)
+
 optional_policy(`
 	# Read System.map from home directories.
 	unconfined_read_home_content_files(depmod_t)
+	unconfined_dontaudit_use_terminals(depmod_t)
 ')
 
 optional_policy(`

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

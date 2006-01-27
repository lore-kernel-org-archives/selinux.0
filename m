Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0R6b7Xf002708
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2006 01:37:07 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0R6b5C1012114
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2006 06:37:05 GMT
Message-ID: <43D9BF9F.2010601@redhat.com>
Date: Fri, 27 Jan 2006 01:37:19 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Latest diff
Content-Type: multipart/mixed;
 boundary="------------010407090007080402000208"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010407090007080402000208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Mainly this patch splits secadm_r from sysadm_r.  Still have some 
problems.  (rpm_script_t executing load_policy is failing and I don't 
know why.  No AVC messages)

Add rpm definitions for pub and pirut.

Need to run load_policy from rpm_script in the correct role.  So added 
seutil_run_loadpol to rpm.if

rpm_script wants to output to the terminal.

Mono needs execmem.

Error in the files.if file.

inotify and udev caused audit to go nuts on MLS platform.  Wants to 
search the inotifyfs_t dir

Want to drop sensitivity level on rpm and lvm when run by kernel or 
sysadm_t at SystemHigh.

Add +/dev/xvd for Zen machines

Cups looks like it is probing all ttydevices for serial printers I guess.

Hal wants to communicate with initctl and read utmp

sulogin wants to use a tmpfs_t:chr_file if udev has not started.

Insmod reads /etc/selinux/targeted/contexts/files/media file.

Fix run_init to use netlink_audit_t

Stop auditing denials to execstack.  Too many files ask for it and it 
does not seem to break anything.  Log files are filling up with denials.

On mls machines, secadm can only run SELinux utilities and read the 
auditfiles, and is not allowed to do most of what sysadm_t can.  
Sysadm_t is not allowed to run most  SELinux utilities or read the 
auditfiles.





--------------010407090007080402000208
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/rpm.fc serefpolicy-2.2.7/policy/modules/admin/rpm.fc
--- nsaserefpolicy/policy/modules/admin/rpm.fc	2006-01-13 09:48:26.000000000 -0500
+++ serefpolicy-2.2.7/policy/modules/admin/rpm.fc	2006-01-26 17:01:26.000000000 -0500
@@ -16,6 +16,8 @@
 /usr/bin/fedora-rmdevelrpms	--	gen_context(system_u:object_r:rpm_exec_t,s0)
 /usr/sbin/up2date		--	gen_context(system_u:object_r:rpm_exec_t,s0)
 /usr/sbin/rhn_check		--	gen_context(system_u:object_r:rpm_exec_t,s0)
+/usr/sbin/pup			--	gen_context(system_u:object_r:rpm_exec_t,s0)
+/usr/sbin/pirut			--	gen_context(system_u:object_r:rpm_exec_t,s0)
 ')
 
 /var/lib/alternatives(/.*)?		gen_context(system_u:object_r:rpm_var_lib_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/rpm.if serefpolicy-2.2.7/policy/modules/admin/rpm.if
--- nsaserefpolicy/policy/modules/admin/rpm.if	2006-01-04 17:28:52.000000000 -0500
+++ serefpolicy-2.2.7/policy/modules/admin/rpm.if	2006-01-26 17:01:26.000000000 -0500
@@ -71,6 +71,7 @@
 	rpm_domtrans($1)
 	role $2 types rpm_t;
 	role $2 types rpm_script_t;
+	seutil_run_loadpol(rpm_script_t,$2,$3)
 	allow rpm_t $3:chr_file rw_term_perms;
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/rpm.te serefpolicy-2.2.7/policy/modules/admin/rpm.te
--- nsaserefpolicy/policy/modules/admin/rpm.te	2006-01-17 17:08:52.000000000 -0500
+++ serefpolicy-2.2.7/policy/modules/admin/rpm.te	2006-01-26 17:01:26.000000000 -0500
@@ -288,6 +288,7 @@
 
 term_getattr_unallocated_ttys(rpm_script_t)
 term_list_ptys(rpm_script_t)
+term_use_all_terms(rpm_script_t)
 
 auth_dontaudit_getattr_shadow(rpm_script_t)
 # ideally we would not need this
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/mono.te serefpolicy-2.2.7/policy/modules/apps/mono.te
--- nsaserefpolicy/policy/modules/apps/mono.te	2006-01-19 18:02:04.000000000 -0500
+++ serefpolicy-2.2.7/policy/modules/apps/mono.te	2006-01-26 17:01:26.000000000 -0500
@@ -18,7 +18,7 @@
 #
 
 ifdef(`targeted_policy',`
-	allow mono_t self:process execheap;
+	allow mono_t self:process { execheap execmem };
 	unconfined_domain_template(mono_t)
 	role system_r types mono_t;
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/files.fc serefpolicy-2.2.7/policy/modules/kernel/files.fc
--- nsaserefpolicy/policy/modules/kernel/files.fc	2006-01-25 15:58:58.000000000 -0500
+++ serefpolicy-2.2.7/policy/modules/kernel/files.fc	2006-01-26 17:01:26.000000000 -0500
@@ -126,6 +126,11 @@
 /mnt/[^/]*/.*			<<none>>
 
 #
+# /net
+#
+/net			-d	gen_context(system_u:object_r:mnt_t,s0)
+
+#
 # /opt
 #
 /opt(/.*)?			gen_context(system_u:object_r:usr_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/files.if serefpolicy-2.2.7/policy/modules/kernel/files.if
--- nsaserefpolicy/policy/modules/kernel/files.if	2006-01-25 15:58:59.000000000 -0500
+++ serefpolicy-2.2.7/policy/modules/kernel/files.if	2006-01-26 17:01:26.000000000 -0500
@@ -321,7 +321,7 @@
 		attribute file_type, security_file_type;
 	')
 
-	dontaudit $1 { file_type -security_file_type }:dir r_dir_perms;
+	allow $1 { file_type -security_file_type }:dir r_dir_perms;
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/filesystem.if serefpolicy-2.2.7/policy/modules/kernel/filesystem.if
--- nsaserefpolicy/policy/modules/kernel/filesystem.if	2006-01-25 15:58:59.000000000 -0500
+++ serefpolicy-2.2.7/policy/modules/kernel/filesystem.if	2006-01-26 17:01:26.000000000 -0500
@@ -2855,3 +2855,22 @@
 	# and its files.
 	allow $1 filesystem_type:{ dir file lnk_file sock_file fifo_file chr_file blk_file } *;
 ')
+
+
+########################################
+## <summary>
+##	Search inotifyfs_t filesystem 
+## </summary>
+## <param name="domain">
+##	The type of the domain performing this action.
+## </param>
+#
+interface(`fs_search_inotifyfs',`
+	gen_require(`
+		type inotifyfs_t;
+		class dir search_dir_perms;
+	')
+
+	allow $1 inotifyfs_t:dir search_dir_perms;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/mls.te serefpolicy-2.2.7/policy/modules/kernel/mls.te
--- nsaserefpolicy/policy/modules/kernel/mls.te	2006-01-17 17:08:52.000000000 -0500
+++ serefpolicy-2.2.7/policy/modules/kernel/mls.te	2006-01-26 17:01:26.000000000 -0500
@@ -86,7 +86,8 @@
 ')
 
 ifdef(`enable_mls',`
-# run init with maximum MLS range
 range_transition kernel_t init_exec_t s0 - s15:c0.c255;
+range_transition kernel_t lvm_exec_t s0 - s15:c0.c255;
 range_transition initrc_t auditd_exec_t s15:c0.c255;
+range_transition sysadm_t rpm_exec_t s0 - s15:c0.c255;
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/storage.fc serefpolicy-2.2.7/policy/modules/kernel/storage.fc
--- nsaserefpolicy/policy/modules/kernel/storage.fc	2006-01-09 11:32:53.000000000 -0500
+++ serefpolicy-2.2.7/policy/modules/kernel/storage.fc	2006-01-26 17:01:26.000000000 -0500
@@ -12,6 +12,7 @@
 /dev/cm20.*		-b	gen_context(system_u:object_r:removable_device_t,s0)
 /dev/dasd[^/]*		-b	gen_context(system_u:object_r:fixed_disk_device_t,s15:c0.c255)
 /dev/dm-[0-9]+		-b	gen_context(system_u:object_r:fixed_disk_device_t,s15:c0.c255)
+/dev/xvd[^/]*		-b	gen_context(system_u:object_r:fixed_disk_device_t,s15:c0.c255)
 /dev/fd[^/]+		-b	gen_context(system_u:object_r:removable_device_t,s0)
 /dev/flash[^/]*		-b	gen_context(system_u:object_r:fixed_disk_device_t,s15:c0.c255)
 /dev/gscd		-b	gen_context(system_u:object_r:removable_device_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cups.te serefpolicy-2.2.7/policy/modules/services/cups.te
--- nsaserefpolicy/policy/modules/services/cups.te	2006-01-17 17:08:53.000000000 -0500
+++ serefpolicy-2.2.7/policy/modules/services/cups.te	2006-01-26 17:01:26.000000000 -0500
@@ -148,6 +148,7 @@
 fs_search_auto_mountpoints(cupsd_t)
 
 term_dontaudit_use_console(cupsd_t)
+term_write_unallocated_ttys(cupsd_t)
 
 auth_domtrans_chk_passwd(cupsd_t)
 auth_dontaudit_read_pam_pid(cupsd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/hal.te serefpolicy-2.2.7/policy/modules/services/hal.te
--- nsaserefpolicy/policy/modules/services/hal.te	2006-01-19 10:00:41.000000000 -0500
+++ serefpolicy-2.2.7/policy/modules/services/hal.te	2006-01-26 17:01:26.000000000 -0500
@@ -116,6 +116,8 @@
 init_use_fd(hald_t)
 init_use_script_pty(hald_t)
 init_domtrans_script(hald_t)
+init_write_initctl(hald_t)
+init_read_utmp(hald_t)
 
 libs_use_ld_so(hald_t)
 libs_use_shared_libs(hald_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/locallogin.te serefpolicy-2.2.7/policy/modules/system/locallogin.te
--- nsaserefpolicy/policy/modules/system/locallogin.te	2006-01-25 15:59:01.000000000 -0500
+++ serefpolicy-2.2.7/policy/modules/system/locallogin.te	2006-01-26 17:01:26.000000000 -0500
@@ -27,6 +27,8 @@
 domain_subj_id_change_exempt(sulogin_t)
 domain_role_change_exempt(sulogin_t)
 domain_wide_inherit_fd(sulogin_t)
+fs_use_tmpfs_chr_dev(sulogin_t)
+
 init_domain(sulogin_t,sulogin_exec_t)
 init_system_domain(sulogin_t,sulogin_exec_t)
 role system_r types sulogin_t;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/modutils.te serefpolicy-2.2.7/policy/modules/system/modutils.te
--- nsaserefpolicy/policy/modules/system/modutils.te	2006-01-13 17:06:08.000000000 -0500
+++ serefpolicy-2.2.7/policy/modules/system/modutils.te	2006-01-26 17:01:26.000000000 -0500
@@ -113,6 +113,8 @@
 
 miscfiles_read_localization(insmod_t)
 
+seutil_read_file_contexts(insmod_t)
+
 if( ! secure_mode_insmod ) {
 	kernel_userland_entry(insmod_t,insmod_exec_t)
 }
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.te serefpolicy-2.2.7/policy/modules/system/selinuxutil.te
--- nsaserefpolicy/policy/modules/system/selinuxutil.te	2006-01-19 10:00:41.000000000 -0500
+++ serefpolicy-2.2.7/policy/modules/system/selinuxutil.te	2006-01-26 17:01:26.000000000 -0500
@@ -414,7 +414,7 @@
 	allow run_init_t self:process setexec;
 	allow run_init_t self:capability setuid;
 	allow run_init_t self:fifo_file rw_file_perms;
-	allow run_init_t self:netlink_audit_socket { create bind write nlmsg_read read };
+	allow run_init_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
 
 	# often the administrator runs such programs from a directory that is owned
 	# by a different user or has restrictive SE permissions, do not want to audit
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/udev.te serefpolicy-2.2.7/policy/modules/system/udev.te
--- nsaserefpolicy/policy/modules/system/udev.te	2006-01-19 10:00:41.000000000 -0500
+++ serefpolicy-2.2.7/policy/modules/system/udev.te	2006-01-26 17:01:26.000000000 -0500
@@ -90,6 +90,7 @@
 dev_delete_generic_file(udev_t)
 
 fs_getattr_all_fs(udev_t)
+fs_search_inotifyfs(udev_t)
 
 selinux_get_fs_mount(udev_t)
 selinux_validate_context(udev_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.if serefpolicy-2.2.7/policy/modules/system/unconfined.if
--- nsaserefpolicy/policy/modules/system/unconfined.if	2006-01-20 10:02:33.000000000 -0500
+++ serefpolicy-2.2.7/policy/modules/system/unconfined.if	2006-01-26 17:01:26.000000000 -0500
@@ -54,8 +54,13 @@
 	tunable_policy(`allow_execmem && allow_execstack',`
 		# Allow making the stack executable via mprotect.
 		allow $1 self:process execstack;
+	', `
+		# These are fairly common but seem to be harmless
+		# caused by using shared libraries built with old tool chains
+		dontaudit $1 self:process execstack;
 	')
 
+
 	optional_policy(`authlogin',`
 		auth_unconfined($1)
 	')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.if serefpolicy-2.2.7/policy/modules/system/userdomain.if
--- nsaserefpolicy/policy/modules/system/userdomain.if	2006-01-26 16:54:28.000000000 -0500
+++ serefpolicy-2.2.7/policy/modules/system/userdomain.if	2006-01-26 17:01:26.000000000 -0500
@@ -848,9 +848,6 @@
 	fs_set_all_quotas($1_t)
 	fs_exec_noxattr($1_t)
 
-	selinux_set_enforce_mode($1_t)
-	selinux_set_boolean($1_t)
-	selinux_set_parameters($1_t)
 	# Get security policy decisions:
 	selinux_get_fs_mount($1_t)
 	selinux_validate_context($1_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.te serefpolicy-2.2.7/policy/modules/system/userdomain.te
--- nsaserefpolicy/policy/modules/system/userdomain.te	2006-01-26 16:54:28.000000000 -0500
+++ serefpolicy-2.2.7/policy/modules/system/userdomain.te	2006-01-26 17:12:42.000000000 -0500
@@ -154,10 +154,16 @@
 
 	corecmd_exec_shell(sysadm_t)
 
-	mls_process_read_up(sysadm_t)
-
-	logging_read_audit_log(sysadm_t)
+	ifdef(`enable_mls',`
+		logging_read_audit_log(secadm_t)
+		logging_domtrans_auditctl(secadm_t)
+		mls_process_read_up(secadm_t)
+	', `
+		logging_domtrans_auditctl(sysadm_t)
+		logging_read_audit_log(sysadm_t)
+	')
 
+	mls_process_read_up(sysadm_t)
 	ifdef(`direct_sysadm_daemon',`
 		optional_policy(`init',`
 			init_run_daemon(sysadm_t,sysadm_r,admin_terminal)
@@ -168,6 +174,10 @@
 		domain_ptrace_all_domains(sysadm_t)
 	')
 
+	optional_policy(`dmesg',`
+		dmesg_exec(sysadm_t)
+	')
+
 	optional_policy(`amanda',`
 		amanda_run_recover(sysadm_t,sysadm_r,admin_terminal)
 	')
@@ -205,6 +215,9 @@
 
 	optional_policy(`consoletype',`
 		consoletype_exec(sysadm_t)
+		ifdef(`enable_mls',`
+			consoletype_exec(secadm_t)
+		')
 	')
 
 	optional_policy(`ddcprobe',`
@@ -320,10 +333,24 @@
 	')
 
 	optional_policy(`selinuxutil',`
-		seutil_run_checkpol(sysadm_t,sysadm_r,admin_terminal)
-		seutil_run_loadpol(sysadm_t,sysadm_r,admin_terminal)
+		ifdef(`enable_mls',`
+			seutil_manage_binary_pol(secadm_t)
+			seutil_run_checkpol(secadm_t,secadm_r,admin_terminal)
+			seutil_run_loadpol(secadm_t,secadm_r,admin_terminal)
+			seutil_run_setfiles(secadm_t,secadm_r,admin_terminal)
+			selinux_set_enforce_mode(secadm_t)
+			selinux_set_boolean(secadm_t)
+			selinux_set_parameters(secadm_t)
+		', `
+			seutil_manage_binary_pol(sysadm_t)
+			seutil_run_checkpol(sysadm_t,sysadm_r,admin_terminal)
+			seutil_run_loadpol(sysadm_t,sysadm_r,admin_terminal)
+			seutil_run_setfiles(sysadm_t,sysadm_r,admin_terminal)
+			selinux_set_enforce_mode(sysadm_t)
+			selinux_set_boolean(sysadm_t)
+			selinux_set_parameters(sysadm_t)
+		')
 		seutil_run_restorecon(sysadm_t,sysadm_r,admin_terminal)
-		seutil_run_setfiles(sysadm_t,sysadm_r,admin_terminal)
 
 		ifdef(`targeted_policy',`',`
 			seutil_run_runinit(sysadm_t,sysadm_r,admin_terminal)

--------------010407090007080402000208--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

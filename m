Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1KMJaYq022048
	for <selinux@tycho.nsa.gov>; Mon, 20 Feb 2006 17:19:36 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1KMJXQp021398
	for <selinux@tycho.nsa.gov>; Mon, 20 Feb 2006 22:19:33 GMT
Message-ID: <43FA4076.5020908@redhat.com>
Date: Mon, 20 Feb 2006 17:19:34 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Latest diffs
Content-Type: multipart/mixed;
 boundary="------------090501090303070400030001"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090501090303070400030001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fixing problems for strict policy

$1_su_t needs to transition to $1_xauth_t

Stop locate audits on mls machines

pam_console needs to setattr/getattr dri_device_t

cron.if has a cut and paste error

crond wants to read postfix_etc_t

initrc wants to write to cups_log_t

spapmd needs to search user_home_dir_t

ssh_agent wants to connect to its own unix_stream_socket

Want to allow mount_t to mount on users home dirs

Fixed up semodule policy; although matchpathcon does not seem to be 
returning the correct labels

strict policy fixes for userdomain.
must get netstat, ifconfig, rpm -q working



--------------090501090303070400030001
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/su.if serefpolicy-2.2.17/policy/modules/admin/su.if
--- nsaserefpolicy/policy/modules/admin/su.if	2006-02-14 07:20:23.000000000 -0500
+++ serefpolicy-2.2.17/policy/modules/admin/su.if	2006-02-20 16:22:06.000000000 -0500
@@ -220,6 +220,14 @@
 		nscd_socket_use($1_su_t)
 	')
 
+	# Modify .Xauthority file (via xauth program).
+	optional_policy(`xserver',`
+#		file_type_auto_trans($1_su_t, staff_home_dir_t, staff_xauth_home_t, file)
+#		file_type_auto_trans($1_su_t, user_home_dir_t, user_xauth_home_t, file)
+#		file_type_auto_trans($1_su_t, sysadm_home_dir_t, sysadm_xauth_home_t, file)
+		xserver_domtrans_user_xauth($1, $1_su_t)
+	')
+
 	ifdef(`TODO',`
 	# Caused by su - init scripts
 	dontaudit $1_su_t initrc_devpts_t:chr_file { getattr ioctl };
@@ -235,17 +243,6 @@
 	dontaudit $1_su_t home_dir_type:dir { search write };
 	')
 
-	# Modify .Xauthority file (via xauth program).
-	ifdef(`xauth.te', `
-	file_type_auto_trans($1_su_t, staff_home_dir_t, staff_xauth_home_t, file)
-	file_type_auto_trans($1_su_t, user_home_dir_t, user_xauth_home_t, file)
-	file_type_auto_trans($1_su_t, sysadm_home_dir_t, sysadm_xauth_home_t, file)
-	domain_auto_trans($1_su_t, xauth_exec_t, $1_xauth_t)
-	')
-
-	ifdef(`cyrus.te', `
-	allow $1_su_t cyrus_var_lib_t:dir search;
-	')
 	ifdef(`ssh.te', `
 	# Access sshd cookie files.
 	allow $1_su_t sshd_tmp_t:file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/slocate.te serefpolicy-2.2.17/policy/modules/apps/slocate.te
--- nsaserefpolicy/policy/modules/apps/slocate.te	2006-01-25 15:58:58.000000000 -0500
+++ serefpolicy-2.2.17/policy/modules/apps/slocate.te	2006-02-20 16:22:06.000000000 -0500
@@ -36,6 +36,8 @@
 
 files_list_all(locate_t)
 files_getattr_all_files(locate_t)
+# mls Higher level directories will be refused, so dontaudit
+files_dontaudit_getattr_all_dirs(locate_t)
 files_read_etc_runtime_files(locate_t)
 files_read_etc_files(locate_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/devices.if serefpolicy-2.2.17/policy/modules/kernel/devices.if
--- nsaserefpolicy/policy/modules/kernel/devices.if	2006-02-20 14:07:36.000000000 -0500
+++ serefpolicy-2.2.17/policy/modules/kernel/devices.if	2006-02-20 16:22:06.000000000 -0500
@@ -1115,6 +1115,45 @@
 
 ########################################
 ## <summary>
+##	Setattr the dri devices.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`dev_setattr_dri_dev',`
+	gen_require(`
+		type device_t, dri_device_t;
+	')
+
+	allow $1 device_t:dir r_dir_perms;
+	allow $1 dri_device_t:chr_file setattr;
+')
+
+########################################
+## <summary>
+##	getattr the dri devices.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`dev_getattr_dri_dev',`
+	gen_require(`
+		type device_t, dri_device_t;
+	')
+
+	allow $1 device_t:dir r_dir_perms;
+	allow $1 dri_device_t:chr_file getattr;
+')
+
+
+########################################
+## <summary>
 ##	Read input event devices (/dev/input).
 ## </summary>
 ## <param name="domain">
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cron.if serefpolicy-2.2.17/policy/modules/services/cron.if
--- nsaserefpolicy/policy/modules/services/cron.if	2006-02-20 14:07:37.000000000 -0500
+++ serefpolicy-2.2.17/policy/modules/services/cron.if	2006-02-20 16:22:06.000000000 -0500
@@ -544,7 +544,7 @@
 		type system_crond_t;
 	')
 
-	allow $1 system_crond_t:file rw_file_perms;
+	allow $1 system_crond_t:fifo_file rw_file_perms;
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cron.te serefpolicy-2.2.17/policy/modules/services/cron.te
--- nsaserefpolicy/policy/modules/services/cron.te	2006-02-20 14:07:37.000000000 -0500
+++ serefpolicy-2.2.17/policy/modules/services/cron.te	2006-02-20 16:22:06.000000000 -0500
@@ -398,6 +398,10 @@
 		prelink_delete_cache(system_crond_t)
 	')
 
+	optional_policy(`postfix',`
+		postfix_read_config(system_crond_t)
+	')	
+
 	optional_policy(`samba',`
 		samba_read_config(system_crond_t)
 		samba_read_log(system_crond_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cups.if serefpolicy-2.2.17/policy/modules/services/cups.if
--- nsaserefpolicy/policy/modules/services/cups.if	2006-02-10 21:34:13.000000000 -0500
+++ serefpolicy-2.2.17/policy/modules/services/cups.if	2006-02-20 16:22:06.000000000 -0500
@@ -169,6 +169,25 @@
 
 ########################################
 ## <summary>
+##	write cups log files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`cups_write_log',`
+	gen_require(`
+		type cupsd_log_t;
+	')
+
+	logging_search_logs($1)
+	allow $1 cupsd_log_t:file write;
+')
+
+########################################
+## <summary>
 ##	Connect to ptal over an unix domain stream socket.
 ## </summary>
 ## <param name="domain">
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/spamassassin.te serefpolicy-2.2.17/policy/modules/services/spamassassin.te
--- nsaserefpolicy/policy/modules/services/spamassassin.te	2006-02-20 14:07:37.000000000 -0500
+++ serefpolicy-2.2.17/policy/modules/services/spamassassin.te	2006-02-20 16:22:06.000000000 -0500
@@ -124,6 +124,7 @@
 	term_dontaudit_use_generic_ptys(spamd_t)
 	files_dontaudit_read_root_files(spamd_t)
 	tunable_policy(`spamd_enable_home_dirs',`
+		userdom_search_unpriv_user_home_dirs(spamd_t)
 		userdom_manage_generic_user_home_dirs(spamd_t)
 		userdom_manage_generic_user_home_files(spamd_t)
 		userdom_manage_generic_user_home_symlinks(spamd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ssh.if serefpolicy-2.2.17/policy/modules/services/ssh.if
--- nsaserefpolicy/policy/modules/services/ssh.if	2006-02-16 09:05:14.000000000 -0500
+++ serefpolicy-2.2.17/policy/modules/services/ssh.if	2006-02-20 16:22:06.000000000 -0500
@@ -279,6 +279,8 @@
 
 	allow $1_ssh_agent_t { $1_ssh_agent_t $2 }:process signull;
 
+	allow $1_ssh_agent_t $1_ssh_agent_t:unix_stream_socket { connectto rw_socket_perms };
+
 	allow $1_ssh_t $1_ssh_agent_t:unix_stream_socket connectto;
 
 	# for ssh-add
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/authlogin.te serefpolicy-2.2.17/policy/modules/system/authlogin.te
--- nsaserefpolicy/policy/modules/system/authlogin.te	2006-02-03 08:55:55.000000000 -0500
+++ serefpolicy-2.2.17/policy/modules/system/authlogin.te	2006-02-20 16:22:06.000000000 -0500
@@ -153,6 +153,8 @@
 dev_read_sysfs(pam_console_t)
 dev_getattr_apm_bios_dev(pam_console_t)
 dev_setattr_apm_bios_dev(pam_console_t)
+dev_getattr_dri_dev(pam_console_t)
+dev_setattr_dri_dev(pam_console_t)
 dev_getattr_framebuffer_dev(pam_console_t)
 dev_setattr_framebuffer_dev(pam_console_t)
 dev_getattr_misc_dev(pam_console_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/mount.te serefpolicy-2.2.17/policy/modules/system/mount.te
--- nsaserefpolicy/policy/modules/system/mount.te	2006-02-14 07:20:31.000000000 -0500
+++ serefpolicy-2.2.17/policy/modules/system/mount.te	2006-02-20 16:22:06.000000000 -0500
@@ -137,6 +137,8 @@
 	samba_domtrans_smbmount(mount_t)
 ')
 
+userdom_mounton_generic_user_home_dir(mount_t)
+
 ifdef(`TODO',`
 # TODO: Need to examine this further. Not sure how to handle this
 #type sysadm_mount_source_t, file_type, sysadmfile, $1_file_type;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.fc serefpolicy-2.2.17/policy/modules/system/selinuxutil.fc
--- nsaserefpolicy/policy/modules/system/selinuxutil.fc	2006-01-09 11:32:54.000000000 -0500
+++ serefpolicy-2.2.17/policy/modules/system/selinuxutil.fc	2006-02-20 17:04:24.000000000 -0500
@@ -39,3 +39,10 @@
 ifdef(`distro_debian', `
 /usr/share/selinux(/.*)?		gen_context(system_u:object_r:policy_src_t,s0)
 ')
+
+/usr/sbin/semodule		--	gen_context(system_u:object_r:semodule_exec_t,s0)
+
+/etc/selinux([^/]*/)?modules    -d	gen_context(system_u:object_r:selinux_config_t,s0)
+/etc/selinux([^/]*/)?modules/(active|tmp|previous)(/.*)?     --	gen_context(system_u:object_r:semodule_store_t,s0)
+/etc/selinux([^/]*/)?modules/semanage.read.LOCK    --	gen_context(system_u:object_r:semodule_read_lock_t,s0)
+/etc/selinux([^/]*/)?modules/semanage.trans.LOCK   --	gen_context(system_u:object_r:semodule_trans_lock_t,s0)
\ No newline at end of file
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.if serefpolicy-2.2.17/policy/modules/system/selinuxutil.if
--- nsaserefpolicy/policy/modules/system/selinuxutil.if	2006-02-16 14:46:56.000000000 -0500
+++ serefpolicy-2.2.17/policy/modules/system/selinuxutil.if	2006-02-20 17:01:53.000000000 -0500
@@ -705,3 +705,90 @@
 	allow $1 policy_src_t:dir create_dir_perms;
 	allow $1 policy_src_t:file create_file_perms;
 ')
+
+########################################
+## <summary>
+##	Execute a domain transition to run semodule.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed to transition.
+##	</summary>
+## </param>
+#
+interface(`semodule_domtrans',`
+	gen_require(`
+		type semodule_t, semodule_exec_t;
+	')
+	files_search_usr($1)
+	corecmd_search_bin($1)
+
+	domain_auto_trans($1,semodule_exec_t,semodule_t)
+
+	allow $1 semodule_t:fd use;
+	allow semodule_t $1:fd use;
+	allow semodule_t $1:fifo_file rw_file_perms;
+	allow semodule_t $1:process sigchld;
+')
+
+
+
+########################################
+## <summary>
+##	Create, read, write, and delete files in
+##	/etc/selinux/*/modules/*
+##	such as mtab.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`seutil_manage_module_store_files',`
+	gen_require(`
+		type semodule_store_t;
+	')
+
+	allow $1 semodule_store_t:dir rw_dir_perms;
+	allow $1 semodule_store_t:file create_file_perms;
+	type_transition $1 selinux_config_t:dir semodule_store_t;
+')
+
+
+#######################################
+## <summary>
+##	Get read lock on module store
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`seutil_module_get_read_lock',`
+	gen_require(`
+		type semodule_read_lock_t;
+	')
+
+	allow $1 semodule_read_lock_t:file rw_file_perms;
+')
+
+#######################################
+## <summary>
+##	Get trans lock on module store
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`seutil_module_get_trans_lock',`
+	gen_require(`
+		type semodule_trans_lock_t;
+	')
+
+	allow $1 semodule_trans_lock_t:file rw_file_perms;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.te serefpolicy-2.2.17/policy/modules/system/selinuxutil.te
--- nsaserefpolicy/policy/modules/system/selinuxutil.te	2006-02-16 14:46:56.000000000 -0500
+++ serefpolicy-2.2.17/policy/modules/system/selinuxutil.te	2006-02-20 17:08:53.000000000 -0500
@@ -526,12 +526,74 @@
 
 miscfiles_read_localization(setfiles_t)
 
+seutil_module_get_trans_lock(setfiles_t)
+seutil_module_get_read_lock(setfiles_t)
+
 userdom_use_all_users_fd(setfiles_t)
 # for config files in a home directory
 userdom_read_all_user_files(setfiles_t)
 
-ifdef(`TODO',`
-# for upgrading glibc and other shared objects - without this the upgrade
-# scripts will put things in a state such that setfiles can not be run!
-allow setfiles_t lib_t:file { read execute };
-') dnl endif TODO
+########################################
+#
+# Declarations
+#
+
+type semodule_t;
+domain_type(semodule_t)
+
+type semodule_exec_t;
+domain_entry_file(semodule_t, semodule_exec_t)
+role system_r types semodule_t;
+
+type semodule_store_t;
+files_type(semodule_store_t)
+
+type semodule_read_lock_t;
+files_type(semodule_read_lock_t)
+
+type semodule_trans_lock_t; 
+files_type(semodule_trans_lock_t)
+
+term_use_all_terms(semodule_t)
+allow semodule_t policy_config_t:file { read write };
+
+########################################
+#
+# semodule local policy
+#
+corecmd_exec_bin(semodule_t)
+corecmd_exec_sbin(semodule_t)
+
+files_read_etc_files(semodule_t)
+files_search_etc(semodule_t)
+files_list_usr(semodule_t)
+files_list_pids(semodule_t)
+files_read_usr_files(semodule_t)
+
+kernel_read_system_state(semodule_t)
+kernel_read_kernel_sysctls(semodule_t)
+
+libs_use_ld_so(semodule_t)
+libs_use_shared_libs(semodule_t)
+libs_use_lib_files(semodule_t)
+
+mls_file_write_down(semodule_t)
+mls_rangetrans_target(semodule_t)
+
+optional_policy(`selinux', `
+	selinux_get_enforce_mode(semodule_t)
+')
+
+seutil_search_default_contexts(semodule_t)
+seutil_rw_file_contexts(semodule_t)
+seutil_domtrans_setfiles(semodule_t)
+seutil_domtrans_loadpolicy(semodule_t)
+seutil_read_config(semodule_t)
+seutil_manage_bin_policy(semodule_t)
+seutil_use_newrole_fd(semodule_t)
+
+allow semodule_t self:unix_stream_socket create_stream_socket_perms;
+
+seutil_manage_module_store_files(semodule_t)
+seutil_module_get_trans_lock(semodule_t)
+seutil_module_get_read_lock(semodule_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.if serefpolicy-2.2.17/policy/modules/system/userdomain.if
--- nsaserefpolicy/policy/modules/system/userdomain.if	2006-02-20 14:07:38.000000000 -0500
+++ serefpolicy-2.2.17/policy/modules/system/userdomain.if	2006-02-20 16:22:06.000000000 -0500
@@ -145,6 +145,7 @@
 	allow $1_t unpriv_userdomain:fd use;
 
 	kernel_read_kernel_sysctls($1_t)
+	kernel_read_net_sysctls($1_t)
 	kernel_dontaudit_list_unlabeled($1_t)
 	kernel_dontaudit_getattr_unlabeled_files($1_t)
 	kernel_dontaudit_getattr_unlabeled_symlinks($1_t)
@@ -414,6 +415,8 @@
 	optional_policy(`rpm',`
 		files_getattr_var_lib_dirs($1_t)
 		files_search_var_lib($1_t)
+		rpm_read_db($1_t)
+		rpm_dontaudit_manage_db($1_t)
 	')
 
 	optional_policy(`samba',`
@@ -4423,3 +4426,24 @@
 	allow $1 user_home_dir_t:dir create_dir_perms;
 	files_filetrans_home($1,user_home_dir_t)
 ')
+
+
+########################################
+## <summary>
+##	mounton generic user home directories.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`userdom_mounton_generic_user_home_dir',`
+	gen_require(`
+		attribute user_home_dir_type, user_home_type;
+	')
+
+	allow $1 user_home_dir_type:dir mounton;
+	allow $1 user_home_type:dir mounton;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.te serefpolicy-2.2.17/policy/modules/system/userdomain.te
--- nsaserefpolicy/policy/modules/system/userdomain.te	2006-02-16 14:46:56.000000000 -0500
+++ serefpolicy-2.2.17/policy/modules/system/userdomain.te	2006-02-20 16:22:06.000000000 -0500
@@ -358,6 +358,8 @@
 			seutil_run_checkpolicy(secadm_t,secadm_r,admin_terminal)
 			seutil_run_loadpolicy(secadm_t,secadm_r,admin_terminal)
 			seutil_run_setfiles(secadm_t,secadm_r,admin_terminal)
+			semodule_domtrans(secadm_t)
+			role secadm_r types semodule_t;
 			seutil_run_restorecon(secadm_t,secadm_r,admin_terminal)
 		', `
 			selinux_set_enforce_mode(sysadm_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/support/Makefile.devel serefpolicy-2.2.17/support/Makefile.devel
--- nsaserefpolicy/support/Makefile.devel	2006-02-16 16:42:39.000000000 -0500
+++ serefpolicy-2.2.17/support/Makefile.devel	2006-02-20 16:22:06.000000000 -0500
@@ -1,3 +1,6 @@
+# installation paths
+SHAREDIR := $(PREFIX)/share/selinux
+HEADERDIR := $(SHAREDIR)/refpolicy/include
 
 include $(HEADERDIR)/build.conf
 
@@ -19,8 +22,13 @@
 PYTHON ?= python
 
 # set default build options if missing
-TYPE ?= strict
-NAME ?= $(TYPE)
+NAME ?= $(shell . /etc/selinux/config; echo $$SELINUXTYPE)
+MLSENABLED := $(shell cat /selinux/mls)
+ifeq ($(MLSENABLED),1)
+MCSFLAG=-mcs
+endif
+
+TYPE ?= $(NAME)${MCSFLAG}
 DIRECT_INITRC ?= n
 POLY ?= n
 QUIET ?= y

--------------090501090303070400030001--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

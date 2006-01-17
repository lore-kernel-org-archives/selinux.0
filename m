Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0H46MXf027821
	for <selinux@tycho.nsa.gov>; Mon, 16 Jan 2006 23:06:22 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0H45EP2016890
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 04:05:14 GMT
Message-ID: <43CC6D3C.1060307@redhat.com>
Date: Mon, 16 Jan 2006 23:06:20 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: latest diff
Content-Type: multipart/mixed;
 boundary="------------010209060602030501040506"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010209060602030501040506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fixes for man pages

Kudzu needs to write to some MLS files

Added some additional dontaudit rules for readahead

gij is another java executable.

Added wine policy to mimic java.


Do we need one for mono?  Or do we change java policy to 
unconfined_execmem policy?

Do you have a problem with my range_transition rules?

How about the cron ones?  Is this happening in some other way?

Cron wants to update utmp file.

Is the a problem with the hal changes?

+allow system_mail_t eventpollfs_t:file r_file_perms;
I got bug reports on the above.  I have no idea why.

Removed some TODO, that I believe were caused by old bugs.

I still think running hostname policy for anything other than init and 
dhcpc is a bad idea.

libflashplayer.so looks like it moved up a level.

Russell changed the way restorecon and setfiles worked using a fifo to 
communicate between processes.

+    domain_dontaudit_read_all_domains_state($1)
was added to unconfined_t to eliminate AVC messages created by running 
top when logged in on a MCS machine.  If you are running unconfined_t:s0 
and run top you will not be able to read all the processes running at 
s0-s0:c0.c255

Userdomain needs to be able to read /home directory.

Do you have a problem with the MLS gen_user stuff?





--------------010209060602030501040506
Content-Type: text/x-patch;
 name="policy-20060104.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-20060104.patch"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/Makefile serefpolicy-2.1.11/Makefile
--- nsaserefpolicy/Makefile	2006-01-13 09:48:25.000000000 -0500
+++ serefpolicy-2.1.11/Makefile	2006-01-16 22:32:53.000000000 -0500
@@ -92,7 +92,7 @@
 
 # enable MLS if requested.
 ifneq ($(findstring -mls,$(TYPE)),)
-	override M4PARAM += -D enable_mls
+	override M4PARAM += -D enable_mls -D separate_secadm
 	override CHECKPOLICY += -M
 	override CHECKMODULE += -M
 endif
diff --exclude-from=exclude -N -u -r nsaserefpolicy/man/man8/ftpd_selinux.8 serefpolicy-2.1.11/man/man8/ftpd_selinux.8
--- nsaserefpolicy/man/man8/ftpd_selinux.8	2006-01-06 17:55:17.000000000 -0500
+++ serefpolicy-2.1.11/man/man8/ftpd_selinux.8	2006-01-16 22:32:53.000000000 -0500
@@ -16,9 +16,9 @@
 .TP
 chcon -t public_content_rw_t /var/ftp/incoming
 .TP
-You must also turn on the boolean allow_ftp_anon_write.
+You must also turn on the boolean allow_ftpd_anon_write.
 .TP
-setsebool -P allow_ftp_anon_write=1
+setsebool -P allow_ftpd_anon_write=1
 .TP
 If you want to make this permanant, i.e. survive a relabel, you must add an entry to the file_contexts.local file.
 .TP
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/kudzu.te serefpolicy-2.1.11/policy/modules/admin/kudzu.te
--- nsaserefpolicy/policy/modules/admin/kudzu.te	2006-01-13 17:06:02.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/admin/kudzu.te	2006-01-16 22:32:53.000000000 -0500
@@ -63,6 +63,7 @@
 fs_write_ramfs_socket(kudzu_t)
 
 mls_file_read_up(kudzu_t)
+mls_file_write_down(kudzu_t)
 
 modutils_read_mods_deps(kudzu_t)
 modutils_read_module_conf(kudzu_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/readahead.te serefpolicy-2.1.11/policy/modules/admin/readahead.te
--- nsaserefpolicy/policy/modules/admin/readahead.te	2006-01-13 17:06:02.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/admin/readahead.te	2006-01-16 22:32:53.000000000 -0500
@@ -35,6 +35,7 @@
 dev_getattr_all_chr_files(readahead_t)
 dev_getattr_all_blk_files(readahead_t)
 dev_dontaudit_read_all_blk_files(readahead_t)
+dev_dontaudit_getattr_memory_device(readahead_t)
 
 domain_use_wide_inherit_fd(readahead_t)
 
@@ -46,6 +47,7 @@
 fs_search_auto_mountpoints(readahead_t)
 fs_getattr_all_pipes(readahead_t)
 fs_getattr_all_files(readahead_t)
+fs_search_ramfs(readahead_t)
 
 term_dontaudit_use_console(readahead_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/java.fc serefpolicy-2.1.11/policy/modules/apps/java.fc
--- nsaserefpolicy/policy/modules/apps/java.fc	2006-01-12 18:28:45.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/apps/java.fc	2006-01-16 22:32:53.000000000 -0500
@@ -2,3 +2,5 @@
 # /usr
 #
 /usr(/.*)?/bin/java.* 	--	gen_context(system_u:object_r:java_exec_t,s0)
+/usr/bin/gij	--	gen_context(system_u:object_r:java_exec_t,s0)
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/wine.fc serefpolicy-2.1.11/policy/modules/apps/wine.fc
--- nsaserefpolicy/policy/modules/apps/wine.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/apps/wine.fc	2006-01-16 22:32:53.000000000 -0500
@@ -0,0 +1,2 @@
+/usr/bin/wine	--	gen_context(system_u:object_r:wine_exec_t,s0)
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/wine.if serefpolicy-2.1.11/policy/modules/apps/wine.if
--- nsaserefpolicy/policy/modules/apps/wine.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/apps/wine.if	2006-01-16 22:32:53.000000000 -0500
@@ -0,0 +1,23 @@
+## <summary>Load keyboard mappings.</summary>
+
+########################################
+## <summary>
+##	Execute the wine program in the wine domain.
+## </summary>
+## <param name="domain">
+##	The type of the process performing this action.
+## </param>
+#
+interface(`wine_domtrans',`
+	gen_require(`
+		type wine_t, wine_exec_t;
+	')
+
+	corecmd_search_bin($1)
+	domain_auto_trans($1, wine_exec_t, wine_t)
+
+	allow $1 wine_t:fd use;
+	allow wine_t $1:fd use;
+	allow wine_t $1:fifo_file rw_file_perms;
+	allow wine_t $1:process sigchld;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/wine.te serefpolicy-2.1.11/policy/modules/apps/wine.te
--- nsaserefpolicy/policy/modules/apps/wine.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/apps/wine.te	2006-01-16 22:32:53.000000000 -0500
@@ -0,0 +1,27 @@
+policy_module(wine,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type wine_t;
+domain_type(wine_t)
+
+type wine_exec_t;
+domain_entry_file(wine_t,wine_exec_t)
+
+
+########################################
+#
+# Local policy
+#
+
+ifdef(`targeted_policy',`
+	allow wine_t self:process execmem;
+	unconfined_domain_template(wine_t)
+	unconfined_domtrans(wine_t)
+	role system_r types wine_t;
+	allow wine_t file_type:file execmod;
+
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/devices.if serefpolicy-2.1.11/policy/modules/kernel/devices.if
--- nsaserefpolicy/policy/modules/kernel/devices.if	2006-01-13 17:06:03.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/kernel/devices.if	2006-01-16 22:32:53.000000000 -0500
@@ -2248,3 +2248,19 @@
 	typeattribute $1 memory_raw_write, memory_raw_read;
 ')
 
+########################################
+## <summary>
+##	dontaudit getattr raw memory devices (e.g. /dev/mem).
+## </summary>
+## <param name="domain">
+##	Domain allowed access.
+## </param>
+#
+interface(`dev_dontaudit_getattr_memory_device',`
+	gen_require(`
+		type memory_device_t;
+	')
+
+	dontaudit $1 memory_device_t:chr_file getattr;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/filesystem.if serefpolicy-2.1.11/policy/modules/kernel/filesystem.if
--- nsaserefpolicy/policy/modules/kernel/filesystem.if	2006-01-13 17:06:04.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/kernel/filesystem.if	2006-01-16 22:32:53.000000000 -0500
@@ -2282,6 +2282,26 @@
 
 ########################################
 ## <summary>
+##	dontaudit Read and write character nodes on tmpfs filesystems.
+## </summary>
+## <param name="domain">
+##	The type of the process performing this action.
+## </param>
+#
+interface(`fs_dontaudit_use_tmpfs_chr_dev',`
+	gen_require(`
+		type tmpfs_t;
+		class dir r_dir_perms; 
+		class chr_file rw_file_perms;
+	')
+
+	dontaudit $1 tmpfs_t:dir r_dir_perms;
+	dontaudit $1 tmpfs_t:chr_file rw_file_perms;
+')
+
+
+########################################
+## <summary>
 ##	Relabel character nodes on tmpfs filesystems.
 ## </summary>
 ## <param name="domain">
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/mls.te serefpolicy-2.1.11/policy/modules/kernel/mls.te
--- nsaserefpolicy/policy/modules/kernel/mls.te	2006-01-09 11:32:53.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/kernel/mls.te	2006-01-16 22:32:53.000000000 -0500
@@ -82,9 +82,11 @@
 # these might be targeted_policy only
 range_transition unconfined_t su_exec_t s0 - s0:c0.c255;
 range_transition unconfined_t initrc_exec_t s0;
+range_transition unconfined_t ping_exec_t s0;
 ')
 
 ifdef(`enable_mls',`
 # run init with maximum MLS range
 range_transition kernel_t init_exec_t s0 - s15:c0.c255;
+range_transition initrc_t auditd_exec_t s15:c0.c255;
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/apache.te serefpolicy-2.1.11/policy/modules/services/apache.te
--- nsaserefpolicy/policy/modules/services/apache.te	2006-01-16 22:19:19.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/services/apache.te	2006-01-16 22:32:53.000000000 -0500
@@ -693,3 +693,8 @@
 optional_policy(`nscd',`
 	nscd_use_socket(httpd_unconfined_script_t)
 ')
+
+optional_policy(`crond',`
+	cron_system_entry(httpd_t, httpd_exec_t)
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/apm.te serefpolicy-2.1.11/policy/modules/services/apm.te
--- nsaserefpolicy/policy/modules/services/apm.te	2006-01-13 17:06:04.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/services/apm.te	2006-01-16 22:32:53.000000000 -0500
@@ -196,6 +196,7 @@
 ')
 
 optional_policy(`cron',`
+	cron_system_entry(apmd_t, apmd_exec_t)
 	cron_domtrans_anacron_system_job(apmd_t)
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/automount.te serefpolicy-2.1.11/policy/modules/services/automount.te
--- nsaserefpolicy/policy/modules/services/automount.te	2006-01-13 17:06:04.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/services/automount.te	2006-01-16 22:32:53.000000000 -0500
@@ -108,6 +108,7 @@
 fs_manage_auto_mountpoints(automount_t)
 
 term_dontaudit_use_console(automount_t)
+term_dontaudit_getattr_pty_dir(automount_t)
 
 init_use_fd(automount_t)
 init_use_script_pty(automount_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cron.te serefpolicy-2.1.11/policy/modules/services/cron.te
--- nsaserefpolicy/policy/modules/services/cron.te	2006-01-16 22:19:19.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/services/cron.te	2006-01-16 22:32:53.000000000 -0500
@@ -120,7 +120,7 @@
 
 init_use_fd(crond_t)
 init_use_script_pty(crond_t)
-init_read_script_pid(crond_t)
+init_rw_script_pid(crond_t)
 
 libs_use_ld_so(crond_t)
 libs_use_shared_libs(crond_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cups.te serefpolicy-2.1.11/policy/modules/services/cups.te
--- nsaserefpolicy/policy/modules/services/cups.te	2006-01-13 17:06:04.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/services/cups.te	2006-01-16 22:32:53.000000000 -0500
@@ -201,8 +201,7 @@
 ')
 
 optional_policy(`cron',`
-	cron_use_fd(cupsd_t)
-	cron_read_pipe(cupsd_t)
+	cron_system_entry(cupsd_t, cupsd_exec_t)
 ')
 
 optional_policy(`dbus',`
@@ -580,8 +579,7 @@
 ')
 
 optional_policy(`cron',`
-	cron_use_system_job_fd(cupsd_config_t)
-	cron_read_pipe(cupsd_config_t)
+	cron_system_entry(cupsd_config_t, cupsd_config_exec_t)
 ')
 
 optional_policy(`dbus',`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/dovecot.te serefpolicy-2.1.11/policy/modules/services/dovecot.te
--- nsaserefpolicy/policy/modules/services/dovecot.te	2006-01-13 17:06:05.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/services/dovecot.te	2006-01-16 22:32:53.000000000 -0500
@@ -95,6 +95,7 @@
 files_read_etc_files(dovecot_t)
 files_search_spool(dovecot_t)
 files_search_tmp(dovecot_t)
+files_search_tmp(dovecot_auth_t)
 files_dontaudit_list_default(dovecot_t)
 
 init_use_fd(dovecot_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/hal.te serefpolicy-2.1.11/policy/modules/services/hal.te
--- nsaserefpolicy/policy/modules/services/hal.te	2006-01-13 17:06:05.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/services/hal.te	2006-01-16 22:39:09.000000000 -0500
@@ -48,8 +48,13 @@
 kernel_read_network_state(hald_t)
 kernel_read_kernel_sysctl(hald_t)
 kernel_read_fs_sysctl(hald_t)
+
 kernel_write_proc_file(hald_t)
 
+mls_file_read_up(hald_t)
+
+bootloader_getattr_boot_dir(hald_t)
+
 corecmd_exec_bin(hald_t)
 corecmd_exec_sbin(hald_t)
 
@@ -82,8 +87,8 @@
 files_exec_etc_files(hald_t)
 files_read_etc_files(hald_t)
 files_rw_etc_runtime_files(hald_t)
-files_search_mnt(hald_t)
 files_manage_mnt_dirs(hald_t)
+files_manage_mnt_files(hald_t)
 files_search_var_lib(hald_t)
 files_read_usr_files(hald_t)
 # hal is now execing pm-suspend
@@ -158,6 +163,7 @@
 	dbus_system_bus_client_template(hald,hald_t)
 	dbus_send_system_bus_msg(hald_t)
 	dbus_connect_system_bus(hald_t)
+	allow hald_t self:dbus send_msg;
 
 	init_dbus_chat_script(hald_t)
 
@@ -212,3 +218,7 @@
 optional_policy(`vbetool',`
 	vbetool_domtrans(hald_t)
 ')
+
+optional_policy(`bind',`
+	bind_search_cache(hald_t)
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/mta.te serefpolicy-2.1.11/policy/modules/services/mta.te
--- nsaserefpolicy/policy/modules/services/mta.te	2006-01-16 22:19:19.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/services/mta.te	2006-01-16 22:32:53.000000000 -0500
@@ -46,6 +46,7 @@
 
 allow system_mail_t etc_mail_t:dir { getattr search };
 allow system_mail_t etc_mail_t:file r_file_perms;
+allow system_mail_t eventpollfs_t:file r_file_perms;
 
 kernel_read_system_state(system_mail_t)
 kernel_read_network_state(system_mail_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/sendmail.te serefpolicy-2.1.11/policy/modules/services/sendmail.te
--- nsaserefpolicy/policy/modules/services/sendmail.te	2006-01-16 22:19:19.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/services/sendmail.te	2006-01-16 22:32:53.000000000 -0500
@@ -17,6 +17,7 @@
 
 type sendmail_t;
 mta_sendmail_mailserver(sendmail_t)
+mta_read_config(sendmail_t)
 mta_mailserver_delivery(sendmail_t)
 mta_mailserver_sender(sendmail_t)
 
@@ -53,6 +54,7 @@
 corenet_udp_bind_all_nodes(sendmail_t)
 corenet_tcp_bind_smtp_port(sendmail_t)
 corenet_tcp_connect_all_ports(sendmail_t)
+allow sendmail_t self:udp_socket create_socket_perms;
 
 dev_read_urand(sendmail_t)
 dev_read_sysfs(sendmail_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/authlogin.if serefpolicy-2.1.11/policy/modules/system/authlogin.if
--- nsaserefpolicy/policy/modules/system/authlogin.if	2006-01-13 17:06:08.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/system/authlogin.if	2006-01-16 22:32:53.000000000 -0500
@@ -1075,3 +1075,16 @@
 	typeattribute $1 can_write_shadow_passwords;
 	typeattribute $1 can_relabelto_shadow_passwords;
 ')
+#######################################
+#
+# auth_setattr_login_records(domain)
+#
+interface(`auth_setattr_login_records',`
+	gen_require(`
+		type wtmp_t;
+		class file setattr;
+	')
+
+	allow $1 wtmp_t:file setattr;
+	logging_search_logs($1)
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/authlogin.te serefpolicy-2.1.11/policy/modules/system/authlogin.te
--- nsaserefpolicy/policy/modules/system/authlogin.te	2006-01-13 17:06:08.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/system/authlogin.te	2006-01-16 22:32:53.000000000 -0500
@@ -129,14 +129,6 @@
 	nscd_use_socket(pam_t)
 ')
 
-ifdef(`TODO',`
-ifdef(`gnome-pty-helper.te', `allow pam_t gphdomain:fd use;')
-# Supress xdm denial
-ifdef(`xdm.te', `
-dontaudit pam_t xdm_t:fd use;
-') dnl ifdef
-') dnl endif TODO
-
 ########################################
 #
 # PAM console local policy
@@ -223,6 +215,10 @@
 	userdom_dontaudit_use_sysadm_terms(pam_console_t)
 ')
 
+optional_policy(`alsa',`
+	alsa_domtrans(pam_console_t)
+')
+
 ifdef(`targeted_policy', `
 	term_dontaudit_use_unallocated_tty(pam_console_t)
 	term_dontaudit_use_generic_pty(pam_console_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/hostname.te serefpolicy-2.1.11/policy/modules/system/hostname.te
--- nsaserefpolicy/policy/modules/system/hostname.te	2005-12-09 23:35:06.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/system/hostname.te	2006-01-16 22:32:53.000000000 -0500
@@ -29,6 +29,7 @@
 
 fs_getattr_xattr_fs(hostname_t)
 fs_search_auto_mountpoints(hostname_t)
+fs_dontaudit_use_tmpfs_chr_dev(hostname_t)
 
 term_dontaudit_use_console(hostname_t)
 term_use_all_user_ttys(hostname_t)
@@ -55,35 +56,6 @@
 sysnet_read_config(hostname_t)
 sysnet_dns_name_resolve(hostname_t)
 
-userdom_use_all_user_fd(hostname_t)
 
-ifdef(`distro_redhat', `
-	fs_use_tmpfs_chr_dev(hostname_t)
-')
-
-ifdef(`targeted_policy', `
-	term_dontaudit_use_unallocated_tty(hostname_t)
-	term_dontaudit_use_generic_pty(hostname_t)
-	files_dontaudit_read_root_file(hostname_t)
-')
-
-optional_policy(`firstboot',`
-	firstboot_use_fd(hostname_t)
-')
-
-optional_policy(`hotplug',`
-	hotplug_dontaudit_use_fd(hostname_t)
-')
-
-optional_policy(`nscd',`
-	nscd_use_socket(hostname_t)
-')
-
-optional_policy(`selinuxutil',`
-	seutil_sigchld_newrole(hostname_t)
-')
-
-optional_policy(`udev',`
-	udev_dontaudit_use_fd(hostname_t)
-	udev_read_db(hostname_t)
-')
+
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.te serefpolicy-2.1.11/policy/modules/system/init.te
--- nsaserefpolicy/policy/modules/system/init.te	2006-01-16 22:19:19.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/system/init.te	2006-01-16 22:32:53.000000000 -0500
@@ -298,6 +298,7 @@
 term_reset_tty_labels(initrc_t)
 
 auth_rw_login_records(initrc_t)
+auth_setattr_login_records(initrc_t)
 auth_rw_lastlog(initrc_t)
 auth_read_pam_pid(initrc_t)
 auth_delete_pam_pid(initrc_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/libraries.fc serefpolicy-2.1.11/policy/modules/system/libraries.fc
--- nsaserefpolicy/policy/modules/system/libraries.fc	2006-01-13 09:48:27.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/system/libraries.fc	2006-01-16 22:32:53.000000000 -0500
@@ -158,7 +158,7 @@
 
 # Flash plugin, Macromedia
 HOME_DIR/.*/plugins/libflashplayer\.so.* --	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib(64)?/.*/plugins/libflashplayer\.so.* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/.*/libflashplayer\.so.* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 # Jai, Sun Microsystems (Jpackage SPRM)
 /usr/lib(64)?/libmlib_jai\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/lvm.te serefpolicy-2.1.11/policy/modules/system/lvm.te
--- nsaserefpolicy/policy/modules/system/lvm.te	2006-01-13 17:06:08.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/system/lvm.te	2006-01-16 22:32:53.000000000 -0500
@@ -209,6 +209,7 @@
 storage_manage_fixed_disk(lvm_t)
 
 term_dontaudit_getattr_all_user_ttys(lvm_t)
+term_dontaudit_getattr_pty_dir(lvm_t)
 
 corecmd_search_sbin(lvm_t)
 corecmd_dontaudit_getattr_sbin_file(lvm_t)
@@ -260,10 +261,3 @@
 	udev_read_db(lvm_t)
 ')
 
-ifdef(`TODO',`
-# it has no reason to need this
-allow lvm_t var_t:dir { search getattr };
-allow lvm_t ramfs_t:filesystem unmount;
-
-dontaudit lvm_t xconsole_device_t:fifo_file getattr;
-') dnl end TODO
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/mount.te serefpolicy-2.1.11/policy/modules/system/mount.te
--- nsaserefpolicy/policy/modules/system/mount.te	2006-01-13 17:06:08.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/system/mount.te	2006-01-16 22:32:53.000000000 -0500
@@ -32,6 +32,7 @@
 
 dev_getattr_all_blk_files(mount_t)
 dev_list_all_dev_nodes(mount_t)
+dev_rw_lvm_control(mount_t)
 
 storage_raw_read_fixed_disk(mount_t)
 storage_raw_write_fixed_disk(mount_t)
@@ -46,7 +47,7 @@
 fs_search_auto_mountpoints(mount_t)
 fs_use_tmpfs_chr_dev(mount_t)
 
-term_use_console(mount_t)
+term_use_all_terms(mount_t)
 
 # required for mount.smbfs
 corecmd_exec_sbin(mount_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.te serefpolicy-2.1.11/policy/modules/system/selinuxutil.te
--- nsaserefpolicy/policy/modules/system/selinuxutil.te	2006-01-16 22:19:19.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/system/selinuxutil.te	2006-01-16 22:32:53.000000000 -0500
@@ -316,6 +316,7 @@
 #
 
 allow restorecon_t self:capability { dac_override dac_read_search fowner };
+allow restorecon_t self:fifo_file rw_file_perms;
 
 allow restorecon_t { policy_src_t policy_config_t file_context_t selinux_config_t default_context_t }:dir r_dir_perms;
 allow restorecon_t { policy_src_t policy_config_t file_context_t selinux_config_t default_context_t }:file r_file_perms;
@@ -414,6 +415,7 @@
 	allow run_init_t self:capability setuid;
 	allow run_init_t self:fifo_file rw_file_perms;
 	allow run_init_t self:netlink_audit_socket { create bind write nlmsg_read read };
+	domain_auto_trans(run_init_t,initrc_exec_t,initrc_t)
 
 	# often the administrator runs such programs from a directory that is owned
 	# by a different user or has restrictive SE permissions, do not want to audit
@@ -469,6 +471,7 @@
 #
 
 allow setfiles_t self:capability { dac_override dac_read_search fowner };
+allow setfiles_t self:fifo_file rw_file_perms;
 
 allow setfiles_t { policy_src_t policy_config_t file_context_t selinux_config_t default_context_t }:dir r_dir_perms;
 allow setfiles_t { policy_src_t policy_config_t file_context_t selinux_config_t default_context_t }:file r_file_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.if serefpolicy-2.1.11/policy/modules/system/unconfined.if
--- nsaserefpolicy/policy/modules/system/unconfined.if	2006-01-16 22:19:19.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/system/unconfined.if	2006-01-16 22:32:53.000000000 -0500
@@ -33,6 +33,7 @@
 	corenet_unconfined($1)
 	dev_unconfined($1)
 	domain_unconfined($1)
+	domain_dontaudit_read_all_domains_state($1)
 	files_unconfined($1)
 	fs_unconfined($1)
 	selinux_unconfined($1)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.if serefpolicy-2.1.11/policy/modules/system/userdomain.if
--- nsaserefpolicy/policy/modules/system/userdomain.if	2006-01-16 22:19:19.000000000 -0500
+++ serefpolicy-2.1.11/policy/modules/system/userdomain.if	2006-01-16 22:32:53.000000000 -0500
@@ -103,6 +103,7 @@
 	# execute files in the home directory
 	can_exec($1_t,$1_home_t)
 
+	allow $1_t home_root_t:dir { getattr search };
 	# full control of the home directory
 	allow $1_t $1_home_t:file { create_file_perms relabelfrom relabelto };
 	allow $1_t $1_home_t:lnk_file { create_lnk_perms relabelfrom relabelto };
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/users serefpolicy-2.1.11/policy/users
--- nsaserefpolicy/policy/users	2005-12-05 22:35:02.000000000 -0500
+++ serefpolicy-2.1.11/policy/users	2006-01-16 22:32:53.000000000 -0500
@@ -26,7 +26,9 @@
 ifdef(`targeted_policy',`
 gen_user(user_u, user_r sysadm_r system_r, s0, s0 - s15:c0.c255, c0.c255)
 ',`
-gen_user(user_u, user_r, s0, s0 - s15:c0.c255, c0.c255)
+gen_user(user_u, user_r, s0, s0 - s0, c0)
+gen_user(staff_u, staff_r secadm_r sysadm_r, s0, s0 - s15:c0.c255, c0.c255)
+gen_user(sysadm_u, sysadm_r, s0, s0 - s15:c0.c255, c0.c255)
 ')
 
 #
@@ -40,8 +42,8 @@
 	gen_user(root, user_r sysadm_r system_r, s0, s0 - s15:c0.c255, c0.c255)
 ',`
 	ifdef(`direct_sysadm_daemon',`
-		gen_user(root, sysadm_r staff_r system_r, s0, s0 - s15:c0.c255, c0.c255)
+		gen_user(root, sysadm_r staff_r secadm_r system_r, s0, s0 - s15:c0.c255, c0.c255)
 	',`
-		gen_user(root, sysadm_r staff_r, s0, s0 - s15:c0.c255, c0.c255)
+		gen_user(root, sysadm_r staff_r secadm_r , s0, s0 - s15:c0.c255, c0.c255)
 	')
 ')

--------------010209060602030501040506--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

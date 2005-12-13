Message-ID: <439EED4B.4070701@redhat.com>
Date: Tue, 13 Dec 2005 10:48:27 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Latest diffs.
Content-Type: multipart/mixed;
 boundary="------------060001010400090006000002"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060001010400090006000002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add crond range_transition to run at SystemHigh for MCS policy
Added transition from unconfined_t to run ping at s0.
Which brings up a point, when a transition happens should the 
application continue to run at the same security level that the prev 
context ran at?  Or should all domains start with a default security 
level. 

In current MCS policy if unconfined_t started ping, it would run at the 
with the same mls range as unconfined_t.

Beginning to fix up automouter.  Wants to read sysctl_fs_t.  Also seems 
to exec showmount which requires additional privs.

allow automount_t self:capability net_bind_service;
allow automount_t portmap_port_t:tcp_socket name_connect;
allow automount_t reserved_port_t:tcp_socket name_connect;
allow automount_t sbin_t:file read;

We probably need a policy for the showmount command, rather then adding 
these rules to automount.  Anyone want to write some policy?

Rules to make dovecot work better.

/var/log/proftpd/ should be marked xferlog

gpm wants to communicate using unix_stream_socket.

More fixes for hal.  Seems hal is now tied into powersaver and needs 
some addtional privs.
Needs to be able to start init scripts.
Added new policy for vbetool, to be execed from hal.

If you need to signal nis, you need to read the pid file.  This is what 
dhcpd does.

spamassassin needs to write to users homedirs in targeted policy.  I 
hate it but, it has to work.

unconfined_t was not able to read textrel_shlib_t.
Added auditallow to show when unconfined_t is running a program that 
requires execmem


-- 



--------------060001010400090006000002
Content-Type: text/x-patch;
 name="policy-20051208.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-20051208.patch"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/Makefile serefpolicy-2.1.4/Makefile
--- nsaserefpolicy/Makefile	2005-12-09 23:35:04.000000000 -0500
+++ serefpolicy-2.1.4/Makefile	2005-12-13 09:15:56.000000000 -0500
@@ -92,7 +92,7 @@
 
 # enable MLS if requested.
 ifneq ($(findstring -mls,$(TYPE)),)
-	override M4PARAM += -D enable_mls
+	override M4PARAM += -D enable_mls -D separate_secadm
 	override CHECKPOLICY += -M
 	override CHECKMODULE += -M
 endif
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/updfstab.te serefpolicy-2.1.4/policy/modules/admin/updfstab.te
--- nsaserefpolicy/policy/modules/admin/updfstab.te	2005-12-12 15:35:53.000000000 -0500
+++ serefpolicy-2.1.4/policy/modules/admin/updfstab.te	2005-12-13 09:15:56.000000000 -0500
@@ -32,6 +32,7 @@
 dev_manage_generic_symlinks(updfstab_t)
 
 fs_getattr_xattr_fs(updfstab_t)
+fs_getattr_tmpfs(updfstab_t)
 fs_getattr_tmpfs_dir(updfstab_t)
 fs_search_auto_mountpoints(updfstab_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/mls.te serefpolicy-2.1.4/policy/modules/kernel/mls.te
--- nsaserefpolicy/policy/modules/kernel/mls.te	2005-12-09 23:35:04.000000000 -0500
+++ serefpolicy-2.1.4/policy/modules/kernel/mls.te	2005-12-13 09:16:43.000000000 -0500
@@ -68,6 +68,7 @@
 ifdef(`enable_mcs',`
 range_transition getty_t login_exec_t s0 - s0:c0.c255;
 range_transition init_t xdm_exec_t s0 - s0:c0.c255;
+range_transition initrc_t crond_exec_t s0 - s0:c0.c255;
 range_transition initrc_t cupsd_exec_t s0 - s0:c0.c255;
 range_transition initrc_t sshd_exec_t s0 - s0:c0.c255;
 range_transition initrc_t udev_exec_t s0 - s0:c0.c255;
@@ -77,6 +78,7 @@
 # these might be targeted_policy only
 range_transition unconfined_t su_exec_t s0 - s0:c0.c255;
 range_transition unconfined_t initrc_exec_t s0;
+range_transition unconfined_t ping_exec_t s0;
 ')
 
 ifdef(`enable_mls',`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/automount.te serefpolicy-2.1.4/policy/modules/services/automount.te
--- nsaserefpolicy/policy/modules/services/automount.te	2005-12-09 16:09:22.000000000 -0500
+++ serefpolicy-2.1.4/policy/modules/services/automount.te	2005-12-13 09:15:56.000000000 -0500
@@ -58,6 +58,7 @@
 files_create_pid(automount_t,automount_var_run_t)
 
 kernel_read_kernel_sysctl(automount_t)
+kernel_read_fs_sysctl(automount_t)
 kernel_read_proc_symlinks(automount_t)
 kernel_read_system_state(automount_t)
 kernel_list_proc(automount_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/dovecot.te serefpolicy-2.1.4/policy/modules/services/dovecot.te
--- nsaserefpolicy/policy/modules/services/dovecot.te	2005-12-09 23:35:05.000000000 -0500
+++ serefpolicy-2.1.4/policy/modules/services/dovecot.te	2005-12-13 09:15:56.000000000 -0500
@@ -153,6 +153,7 @@
 allow dovecot_auth_t dovecot_t:unix_stream_socket { getattr accept read write ioctl };
 
 allow dovecot_auth_t dovecot_passwd_t:file { getattr read };
+allow dovecot_t dovecot_var_run_t:dir r_dir_perms;
 
 kernel_read_all_sysctl(dovecot_auth_t)
 kernel_read_system_state(dovecot_auth_t)
@@ -165,6 +166,8 @@
 files_read_etc_files(dovecot_auth_t)
 files_read_etc_runtime_files(dovecot_auth_t)
 files_search_pids(dovecot_auth_t)
+files_read_usr_symlinks(dovecot_auth_t)
+files_search_tmp(dovecot_auth_t)
 
 libs_use_ld_so(dovecot_auth_t)
 libs_use_shared_libs(dovecot_auth_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ftp.fc serefpolicy-2.1.4/policy/modules/services/ftp.fc
--- nsaserefpolicy/policy/modules/services/ftp.fc	2005-11-25 08:11:11.000000000 -0500
+++ serefpolicy-2.1.4/policy/modules/services/ftp.fc	2005-12-13 09:15:56.000000000 -0500
@@ -24,3 +24,4 @@
 /var/log/vsftpd.*	--	gen_context(system_u:object_r:xferlog_t,s0)
 /var/log/xferlog.*	--	gen_context(system_u:object_r:xferlog_t,s0)
 /var/log/xferreport.*	--	gen_context(system_u:object_r:xferlog_t,s0)
+/var/log/proftpd(/.*)?          gen_context(system_u:object_r:xferlog_t,s0)
\ No newline at end of file
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/gpm.te serefpolicy-2.1.4/policy/modules/services/gpm.te
--- nsaserefpolicy/policy/modules/services/gpm.te	2005-12-12 15:35:53.000000000 -0500
+++ serefpolicy-2.1.4/policy/modules/services/gpm.te	2005-12-13 09:15:56.000000000 -0500
@@ -46,6 +46,8 @@
 
 # cjp: this has no effect
 allow gpm_t gpmctl_t:unix_stream_socket name_bind;
+allow gpm_t self:unix_stream_socket { create_stream_socket_perms };
+
 
 kernel_read_kernel_sysctl(gpm_t)
 kernel_list_proc(gpm_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/hal.te serefpolicy-2.1.4/policy/modules/services/hal.te
--- nsaserefpolicy/policy/modules/services/hal.te	2005-12-09 23:35:05.000000000 -0500
+++ serefpolicy-2.1.4/policy/modules/services/hal.te	2005-12-13 09:15:56.000000000 -0500
@@ -21,7 +21,10 @@
 # Local policy
 #
 
-allow hald_t self:capability { net_admin sys_admin dac_override dac_read_search mknod sys_rawio };
+# execute openvt which needs setuid
+allow hald_t self:capability setuid;
+
+allow hald_t self:capability { kill net_admin sys_admin sys_nice dac_override dac_read_search mknod sys_rawio };
 dontaudit hald_t self:capability sys_tty_config;
 # vbetool requires execmem
 allow hald_t self:process { execmem signal_perms };
@@ -104,9 +107,11 @@
 storage_raw_write_fixed_disk(hald_t)
 
 term_dontaudit_use_console(hald_t)
+dontaudit hald_t tty_device_t:chr_file ioctl;
 
 init_use_fd(hald_t)
 init_use_script_pty(hald_t)
+init_domtrans_script(hald_t)
 
 libs_use_ld_so(hald_t)
 libs_use_shared_libs(hald_t)
@@ -143,6 +148,10 @@
 	cups_signal_config(hald_t)
 ')
 
+optional_policy(`clock',`
+	clock_domtrans(hald_t)
+')
+
 optional_policy(`dbus',`
 	dbus_system_bus_client_template(hald,hald_t)
 	dbus_send_system_bus_msg(hald_t)
@@ -176,8 +185,8 @@
 	nscd_use_socket(hald_t)
 ')
 
-optional_policy(`ntp',`
-	ntp_domtrans(hald_t)
+optional_policy(`vbetool',`
+	vbetool_domtrans(hald_t)
 ')
 
 optional_policy(`pcmcia',`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/nis.if serefpolicy-2.1.4/policy/modules/services/nis.if
--- nsaserefpolicy/policy/modules/services/nis.if	2005-12-06 19:49:50.000000000 -0500
+++ serefpolicy-2.1.4/policy/modules/services/nis.if	2005-12-13 09:15:56.000000000 -0500
@@ -150,8 +150,10 @@
 interface(`nis_signal_ypbind',`
 	gen_require(`
 		type ypbind_t;
+		type ypbind_var_run_t;
 	')
 
+	allow $1 ypbind_var_run_t:file read;
 	allow $1 ypbind_t:process signal;
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/spamassassin.te serefpolicy-2.1.4/policy/modules/services/spamassassin.te
--- nsaserefpolicy/policy/modules/services/spamassassin.te	2005-12-09 23:35:06.000000000 -0500
+++ serefpolicy-2.1.4/policy/modules/services/spamassassin.te	2005-12-13 09:15:56.000000000 -0500
@@ -120,6 +120,8 @@
 	term_dontaudit_use_unallocated_tty(spamd_t)
 	term_dontaudit_use_generic_pty(spamd_t)
 	files_dontaudit_read_root_file(spamd_t)
+	allow spamd_t user_home_t:dir create_dir_perms;
+	allow spamd_t user_home_t:file create_file_perms;
 ')
 
 tunable_policy(`use_nfs_home_dirs',`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/vbetool.fc serefpolicy-2.1.4/policy/modules/services/vbetool.fc
--- nsaserefpolicy/policy/modules/services/vbetool.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.1.4/policy/modules/services/vbetool.fc	2005-12-13 09:15:56.000000000 -0500
@@ -0,0 +1 @@
+/usr/sbin/vbetool	--	gen_context(system_u:object_r:vbetool_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/vbetool.if serefpolicy-2.1.4/policy/modules/services/vbetool.if
--- nsaserefpolicy/policy/modules/services/vbetool.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.1.4/policy/modules/services/vbetool.if	2005-12-13 09:15:56.000000000 -0500
@@ -0,0 +1,27 @@
+## <summary>run real-mode video BIOS code to alter hardware state</summary>
+
+########################################
+## <summary>
+##	Execute vbetool application in the vbetool domain.
+## </summary>
+## <param name="domain" optional="true">
+##	N/A
+## </param>
+#
+interface(`vbetool_domtrans',`
+	gen_require(`
+		type vbetool_t, vbetool_exec_t;
+		class process sigchld;
+		class fd use;
+		class fifo_file rw_file_perms;
+	')
+
+	corecmd_search_sbin($1)
+	domain_auto_trans($1,vbetool_exec_t,vbetool_t)
+
+	allow $1 vbetool_t:fd use;
+	allow vbetool_t $1:fd use;
+	allow vbetool_t $1:fifo_file rw_file_perms;
+	allow vbetool_t $1:process sigchld;
+
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/vbetool.te serefpolicy-2.1.4/policy/modules/services/vbetool.te
--- nsaserefpolicy/policy/modules/services/vbetool.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.1.4/policy/modules/services/vbetool.te	2005-12-13 09:15:56.000000000 -0500
@@ -0,0 +1,22 @@
+
+policy_module(vbetool,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type vbetool_t;
+type vbetool_exec_t;
+init_system_domain(vbetool_t,vbetool_exec_t)
+
+allow vbetool_t self:process execmem;
+
+dev_wx_raw_memory(vbetool_t)
+dev_read_raw_memory(vbetool_t)
+dev_rwx_zero_dev(vbetool_t)
+dev_read_sysfs(vbetool_t)
+
+libs_use_ld_so(vbetool_t)
+libs_use_shared_libs(vbetool_t)
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/mount.te serefpolicy-2.1.4/policy/modules/system/mount.te
--- nsaserefpolicy/policy/modules/system/mount.te	2005-12-12 23:05:35.000000000 -0500
+++ serefpolicy-2.1.4/policy/modules/system/mount.te	2005-12-13 09:15:56.000000000 -0500
@@ -47,6 +47,7 @@
 fs_use_tmpfs_chr_dev(mount_t)
 
 term_use_console(mount_t)
+term_use_generic_pty(mount_t)
 
 # required for mount.smbfs
 corecmd_exec_sbin(mount_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.if serefpolicy-2.1.4/policy/modules/system/unconfined.if
--- nsaserefpolicy/policy/modules/system/unconfined.if	2005-12-12 15:35:54.000000000 -0500
+++ serefpolicy-2.1.4/policy/modules/system/unconfined.if	2005-12-13 09:15:56.000000000 -0500
@@ -29,6 +29,8 @@
 	allow $1 self:dbus *;
 	allow $1 self:passwd *;
 
+	libs_use_shared_libs($1)
+
 	kernel_unconfined($1)
 	corenet_unconfined($1)
 	dev_unconfined($1)
@@ -42,6 +44,7 @@
 		# Allow making anonymous memory executable, e.g. 
 		# for runtime-code generation or executable stack.
 		allow $1 self:process execmem;
+		auditallow $1 self:process execmem;
 	')
 
 	tunable_policy(`allow_execmem && allow_execstack',`

--------------060001010400090006000002--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2HKUx2e014637
	for <selinux@tycho.nsa.gov>; Fri, 17 Mar 2006 15:30:59 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2HKUehG003733
	for <selinux@tycho.nsa.gov>; Fri, 17 Mar 2006 20:30:40 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id k2HKTQdd014949
	for <selinux@tycho.nsa.gov>; Fri, 17 Mar 2006 15:29:26 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id k2HKTQ06014948
	for selinux@tycho.nsa.gov; Fri, 17 Mar 2006 15:29:26 -0500
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2HKNL9I014343
	for <selinux@tycho.nsa.gov>; Fri, 17 Mar 2006 15:23:21 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2HKNGhG001668
	for <selinux@tycho.nsa.gov>; Fri, 17 Mar 2006 20:23:17 GMT
Message-ID: <441B1A9D.7090903@redhat.com>
Date: Fri, 17 Mar 2006 15:22:53 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Latest Diffs.  This is a big one because we were frozen for so long.
Content-Type: multipart/mixed;
 boundary="------------070102050109030205020908"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070102050109030205020908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Allow mcs to look at higerlevel domain files for ps and top command

blkid.tab file is now in /etc/blkid/blkid.tab.  So commands need to be 
able to manipulate etc_runtime_t directories.

dmidecode needs to be able to read shared memory marked SystemHigh

readahead needs some dac privs.

Fix labeling on log files

Get transitions correct for rpm_script_t to seutils for mls machines.

Make kdesu work

Fix su.if typeos

allow updafstab to gettattr on swapfiles

vbetool needs more privs

Add Xen policy

add /dev/smu

Several commands search the /dev/ directory for fixed disk.  Need to 
dontaudit avcs

Change /home to be SystemLow-SystemHigh

init needs to be able to unlink /.** files

Changes needed for polyinstantiated file systems

Add support for hfsplus Named it NFS????

Fix some kernel interfaces.  Add xen kernel interfaces

Added additional file context for html files

Fix apache interface so we can use it for development of modules

Fixes to make bluetooth work

cron and init need to be able to run mono

Many fixes for cups

Fix specifications for customizable types

Need interfaces for hal var_run dirs.

Hal needs more privs to handle suspend/resume

Allow in.talkd to log.

Postfix wants to use mailman

Add policy for xpxfr

nscd socket is now in a subdir

Add policy for dmraid

udev needs setuid

Don't transition from unconfined_t to mount or fstools

secadm needs to be able to change the machines runlevel
















--------------070102050109030205020908
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/mcs serefpolicy-2.2.23/policy/mcs
--- nsaserefpolicy/policy/mcs	2006-02-16 14:46:56.000000000 -0500
+++ serefpolicy-2.2.23/policy/mcs	2006-03-09 10:26:36.000000000 -0500
@@ -141,9 +141,7 @@
 
 mlsconstrain file { create relabelto } ((h1 dom h2) and (l2 eq h2));
 
-mlsconstrain file { read } ((h1 dom h2) or 
-			    ( t1 == mlsfileread ));
-
+mlsconstrain file { read } ((h1 dom h2) or ( t2 == domain ) or ( t1 == mlsfileread ));
 
 # new file labels must be dominated by the relabeling subject clearance
 mlsconstrain { dir lnk_file chr_file blk_file sock_file fifo_file } { relabelfrom }
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/bootloader.te serefpolicy-2.2.23/policy/modules/admin/bootloader.te
--- nsaserefpolicy/policy/modules/admin/bootloader.te	2006-03-02 18:45:54.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/admin/bootloader.te	2006-03-13 12:23:12.000000000 -0500
@@ -103,7 +103,7 @@
 files_manage_boot_symlinks(bootloader_t)
 files_read_etc_files(bootloader_t)
 files_exec_etc_files(bootloader_t)
-files_read_etc_runtime_files(bootloader_t)
+files_manage_etc_runtime_files(bootloader_t)
 files_read_usr_src_files(bootloader_t)
 files_read_usr_files(bootloader_t)
 files_read_var_files(bootloader_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/dmidecode.te serefpolicy-2.2.23/policy/modules/admin/dmidecode.te
--- nsaserefpolicy/policy/modules/admin/dmidecode.te	2006-03-04 00:06:33.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/admin/dmidecode.te	2006-03-13 12:26:24.000000000 -0500
@@ -32,6 +32,8 @@
 
 locallogin_use_fds(dmidecode_t)
 
+mls_file_read_up(dmidecode_t)
+
 ifdef(`targeted_policy',`
 	term_use_generic_ptys(dmidecode_t)
 	term_use_unallocated_ttys(dmidecode_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/readahead.te serefpolicy-2.2.23/policy/modules/admin/readahead.te
--- nsaserefpolicy/policy/modules/admin/readahead.te	2006-03-04 00:06:33.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/admin/readahead.te	2006-03-07 13:42:37.000000000 -0500
@@ -18,7 +18,7 @@
 # Local policy
 #
 
-dontaudit readahead_t self:capability sys_tty_config;
+dontaudit readahead_t self:capability { dac_override dac_read_search sys_tty_config };
 allow readahead_t self:process signal_perms;
 
 allow readahead_t readahead_var_run_t:file create_file_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/rpm.fc serefpolicy-2.2.23/policy/modules/admin/rpm.fc
--- nsaserefpolicy/policy/modules/admin/rpm.fc	2006-01-27 21:35:04.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/admin/rpm.fc	2006-03-07 15:39:28.000000000 -0500
@@ -25,7 +25,7 @@
 /var/lib/rpm(/.*)?			gen_context(system_u:object_r:rpm_var_lib_t,s0)
 
 /var/log/rpmpkgs.*		--	gen_context(system_u:object_r:rpm_log_t,s0)
-/var/log/yum\.log		--	gen_context(system_u:object_r:rpm_log_t,s0)
+/var/log/yum\.log.*		--	gen_context(system_u:object_r:rpm_log_t,s0)
 
 # SuSE
 ifdef(`distro_suse', `
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/rpm.if serefpolicy-2.2.23/policy/modules/admin/rpm.if
--- nsaserefpolicy/policy/modules/admin/rpm.if	2006-03-04 00:06:33.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/admin/rpm.if	2006-03-14 17:08:39.000000000 -0500
@@ -78,6 +78,9 @@
 	role $2 types rpm_t;
 	role $2 types rpm_script_t;
 	seutil_run_loadpolicy(rpm_script_t,$2,$3)
+	seutil_run_semanage(rpm_script_t,$2,$3)
+	seutil_run_setfiles(rpm_script_t,$2,$3)
+	seutil_run_restorecon(rpm_script_t,$2,$3)
 	allow rpm_t $3:chr_file rw_term_perms;
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/rpm.te serefpolicy-2.2.23/policy/modules/admin/rpm.te
--- nsaserefpolicy/policy/modules/admin/rpm.te	2006-03-04 00:06:33.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/admin/rpm.te	2006-03-15 09:22:44.000000000 -0500
@@ -326,6 +326,7 @@
 
 seutil_domtrans_loadpolicy(rpm_script_t)
 seutil_domtrans_restorecon(rpm_script_t)
+seutil_domtrans_semanage(rpm_script_t)
 
 userdom_use_all_users_fds(rpm_script_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/su.fc serefpolicy-2.2.23/policy/modules/admin/su.fc
--- nsaserefpolicy/policy/modules/admin/su.fc	2005-11-14 18:24:06.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/admin/su.fc	2006-03-07 13:42:37.000000000 -0500
@@ -2,3 +2,4 @@
 /bin/su			--	gen_context(system_u:object_r:su_exec_t,s0)
 
 /usr(/local)?/bin/ksu	--	gen_context(system_u:object_r:su_exec_t,s0)
+/usr/bin/kdesu		--	gen_context(system_u:object_r:su_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/su.if serefpolicy-2.2.23/policy/modules/admin/su.if
--- nsaserefpolicy/policy/modules/admin/su.if	2006-03-04 00:06:33.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/admin/su.if	2006-03-07 13:42:37.000000000 -0500
@@ -141,10 +141,10 @@
 
 	# By default, revert to the calling domain when a shell is executed.
 	corecmd_shell_domtrans($1_su_t,$2)
-	allow $2 $1_su_t:fd use;
 	allow $1_su_t $2:fd use;
-	allow $1_su_t $2:fifo_file rw_file_perms;
-	allow $1_su_t $2:process sigchld;
+	allow $2 $1_su_t:fd use;
+	allow $2 $1_su_t:fifo_file rw_file_perms;
+	allow $2 $1_su_t:process sigchld;
 
 	kernel_read_system_state($1_su_t)
 	kernel_read_kernel_sysctls($1_su_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/updfstab.te serefpolicy-2.2.23/policy/modules/admin/updfstab.te
--- nsaserefpolicy/policy/modules/admin/updfstab.te	2006-03-04 00:06:33.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/admin/updfstab.te	2006-03-14 11:34:03.000000000 -0500
@@ -125,6 +125,6 @@
 	udev_read_db(updfstab_t)
 ')
 
-ifdef(`TODO',`
-allow updfstab_t tmpfs_t:dir getattr;
+optional_policy(`fstools',`
+	fstools_getattr_swap_files(updfstab_t)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/vbetool.te serefpolicy-2.2.23/policy/modules/admin/vbetool.te
--- nsaserefpolicy/policy/modules/admin/vbetool.te	2006-02-01 08:23:27.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/admin/vbetool.te	2006-03-09 16:31:49.000000000 -0500
@@ -15,6 +15,7 @@
 # Local policy
 #
 
+allow vbetool_t self:capability { sys_tty_config sys_admin };
 allow vbetool_t self:process execmem;
 
 dev_wx_raw_memory(vbetool_t)
@@ -24,3 +25,11 @@
 
 libs_use_ld_so(vbetool_t)
 libs_use_shared_libs(vbetool_t)
+
+miscfiles_read_localization(vbetool_t)
+
+term_use_unallocated_ttys(vbetool_t)
+
+optional_policy(`hal',`
+	hal_rw_var_run(vbetool_t)
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/corenetwork.te.in serefpolicy-2.2.23/policy/modules/kernel/corenetwork.te.in
--- nsaserefpolicy/policy/modules/kernel/corenetwork.te.in	2006-02-20 14:07:36.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/kernel/corenetwork.te.in	2006-03-07 13:42:37.000000000 -0500
@@ -126,6 +126,7 @@
 network_port(uucpd, tcp,540,s0)
 network_port(vnc, tcp,5900,s0)
 network_port(xserver, tcp,6001,s0, tcp,6002,s0, tcp,6003,s0, tcp,6004,s0, tcp,6005,s0, tcp,6006,s0, tcp,6007,s0, tcp,6008,s0, tcp,6009,s0, tcp,6010,s0, tcp,6011,s0, tcp,6012,s0, tcp,6013,s0, tcp,6014,s0, tcp,6015,s0, tcp,6016,s0, tcp,6017,s0, tcp,6018,s0, tcp,6019,s0)
+network_port(xen, tcp,8002,s0)
 network_port(zebra, tcp,2601,s0)
 network_port(zope, tcp,8021,s0)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/devices.fc serefpolicy-2.2.23/policy/modules/kernel/devices.fc
--- nsaserefpolicy/policy/modules/kernel/devices.fc	2006-02-27 17:17:23.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/kernel/devices.fc	2006-03-08 17:34:22.000000000 -0500
@@ -33,6 +33,7 @@
 /dev/par.*		-c	gen_context(system_u:object_r:printer_device_t,s0)
 /dev/patmgr[01]		-c	gen_context(system_u:object_r:sound_device_t,s0)
 /dev/pmu			-c	gen_context(system_u:object_r:power_device_t,s0)
+/dev/smu			-c	gen_context(system_u:object_r:power_device_t,s0)
 /dev/port		-c	gen_context(system_u:object_r:memory_device_t,s15:c0.c255)
 /dev/(misc/)?psaux	-c	gen_context(system_u:object_r:mouse_device_t,s0)
 /dev/rmidi.*		-c	gen_context(system_u:object_r:sound_device_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/devices.if serefpolicy-2.2.23/policy/modules/kernel/devices.if
--- nsaserefpolicy/policy/modules/kernel/devices.if	2006-02-23 09:25:08.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/kernel/devices.if	2006-03-09 16:17:57.000000000 -0500
@@ -2384,7 +2384,7 @@
 	')
 
 	allow $1 device_t:dir r_dir_perms;
-	allow $1 usb_device_t:chr_file { read write };
+	allow $1 usb_device_t:chr_file rw_file_perms;
 ')
 
 ########################################
@@ -2732,3 +2732,22 @@
 	typeattribute $1 memory_raw_write, memory_raw_read;
 ')
 
+########################################
+## <summary>
+##	Dontaudit getattr on all device nodes.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`dev_dontaudit_getattr_all_device_nodes',`
+	gen_require(`
+		attribute device_node;
+	')
+
+	dontaudit $1 device_t:dir_file_class_set getattr;
+	dontaudit $1 device_node:dir_file_class_set getattr;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/files.fc serefpolicy-2.2.23/policy/modules/kernel/files.fc
--- nsaserefpolicy/policy/modules/kernel/files.fc	2006-03-04 00:06:34.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/kernel/files.fc	2006-03-08 16:26:29.000000000 -0500
@@ -45,7 +45,7 @@
 /etc(/.*)?			gen_context(system_u:object_r:etc_t,s0)
 /etc/\.fstab\.hal\..+	--	gen_context(system_u:object_r:etc_runtime_t,s0)
 /etc/asound\.state	--	gen_context(system_u:object_r:etc_runtime_t,s0)
-/etc/blkid\.tab.*	--	gen_context(system_u:object_r:etc_runtime_t,s0)
+/etc/blkid(/.*)?		gen_context(system_u:object_r:etc_runtime_t,s0)
 /etc/fstab\.REVOKE	--	gen_context(system_u:object_r:etc_runtime_t,s0)
 /etc/HOSTNAME		--	gen_context(system_u:object_r:etc_runtime_t,s0)
 /etc/ioctl\.save		--	gen_context(system_u:object_r:etc_runtime_t,s0)
@@ -60,7 +60,7 @@
 
 /etc/cups/client\.conf	--	gen_context(system_u:object_r:etc_t,s0)
 
-/etc/init\.d/functions	--	gen_context(system_u:object_r:etc_t,s0)
+/etc/init\.d/functions	--	gen_context(system_u:object_r:bin_t,s0)
 
 /etc/ipsec\.d/examples(/.*)?	gen_context(system_u:object_r:etc_t,s0)
 
@@ -68,7 +68,7 @@
 
 /etc/ptal/ptal-printd-like -- 	gen_context(system_u:object_r:etc_runtime_t,s0)
 
-/etc/rc\.d/init\.d/functions -- gen_context(system_u:object_r:etc_t,s0)
+/etc/rc\.d/init\.d/functions -- gen_context(system_u:object_r:bin_t,s0)
 
 /etc/sysconfig/hwconf	--	gen_context(system_u:object_r:etc_runtime_t,s0)
 /etc/sysconfig/iptables\.save -- gen_context(system_u:object_r:etc_runtime_t,s0)
@@ -93,7 +93,7 @@
 # HOME_ROOT
 # expanded by genhomedircon
 #
-HOME_ROOT		-d	gen_context(system_u:object_r:home_root_t,s15:c0.c255)
+HOME_ROOT		-d	gen_context(system_u:object_r:home_root_t,s0-s15:c0.c255)
 HOME_ROOT/\.journal		<<none>>
 HOME_ROOT/lost\+found	-d	gen_context(system_u:object_r:lost_found_t,s15:c0.c255)
 HOME_ROOT/lost\+found/.*		<<none>>
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/files.if serefpolicy-2.2.23/policy/modules/kernel/files.if
--- nsaserefpolicy/policy/modules/kernel/files.if	2006-03-04 00:06:34.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/kernel/files.if	2006-03-09 11:17:00.000000000 -0500
@@ -1648,6 +1648,21 @@
 ')
 
 ########################################
+#
+# files_unlink_boot_flag(domain)
+#
+# /halt, /.autofsck, etc
+#
+interface(`files_unlink_boot_flag',`
+	gen_require(`
+		type root_t;
+	')
+
+	allow $1 root_t:file unlink;
+')
+
+
+########################################
 ## <summary>
 ##	Read files in /etc that are dynamically
 ##	created on boot, such as mtab.
@@ -1726,6 +1741,7 @@
 	')
 
 	allow $1 etc_t:dir rw_dir_perms;
+	allow $1 etc_runtime_t:dir rw_dir_perms;
 	allow $1 etc_runtime_t:file create_file_perms;
 	type_transition $1 etc_t:file etc_runtime_t;
 ')
@@ -3789,12 +3805,13 @@
 
 	# Need to give permission to create directories where applicable
 	allow $1 self:process setfscreate;
-	allow $1 polymember: dir { create setattr };
+	allow $1 polymember: dir { create setattr relabelto };
 	allow $1 polydir: dir { write add_name };
-	allow $1 polyparent:dir { write add_name };
+	allow $1 polyparent:dir { write add_name relabelfrom relabelto };
 
 	# Default type for mountpoints
 	allow $1 poly_t:dir { create mounton };
+	fs_unmount_xattr_fs($1)
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/filesystem.te serefpolicy-2.2.23/policy/modules/kernel/filesystem.te
--- nsaserefpolicy/policy/modules/kernel/filesystem.te	2006-02-14 07:20:25.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/kernel/filesystem.te	2006-03-08 11:55:28.000000000 -0500
@@ -167,3 +167,4 @@
 genfscon nfs / gen_context(system_u:object_r:nfs_t,s0)
 genfscon nfs4 / gen_context(system_u:object_r:nfs_t,s0)
 genfscon afs / gen_context(system_u:object_r:nfs_t,s0)
+genfscon hfsplus / gen_context(system_u:object_r:nfs_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/kernel.if serefpolicy-2.2.23/policy/modules/kernel/kernel.if
--- nsaserefpolicy/policy/modules/kernel/kernel.if	2006-03-04 00:06:34.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/kernel/kernel.if	2006-03-07 14:00:35.000000000 -0500
@@ -1044,6 +1044,7 @@
 
 	allow $1 proc_t:dir search;
 	allow $1 sysctl_t:dir r_dir_perms;
+	allow $1 sysctl_vm_t:dir rw_dir_perms;
 	allow $1 sysctl_vm_t:file rw_file_perms;
 ')
 
@@ -1328,7 +1329,7 @@
 
 	allow $1 proc_t:dir search;
 	allow $1 sysctl_t:dir r_dir_perms;
-	allow $1 sysctl_kernel_t:dir r_dir_perms;
+	allow $1 sysctl_kernel_t:dir rw_dir_perms;
 	allow $1 sysctl_kernel_t:file rw_file_perms;
 ')
 
@@ -1946,3 +1947,102 @@
 
 	kernel_rw_all_sysctls($1)
 ')
+
+
+
+########################################
+## <summary>
+##	Do not audit attempts to search the xen
+##	state directory.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The process type reading the state.
+##	</summary>
+## </param>
+##
+#
+interface(`kernel_dontaudit_search_xen_state',`
+	gen_require(`
+		type proc_xen_t;
+	')
+
+	dontaudit $1 proc_xen_t:dir search;
+')
+
+########################################
+## <summary>
+##	Allow searching of xen state directory.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The process type reading the state.
+##	</summary>
+## </param>
+##
+#
+interface(`kernel_search_xen_state',`
+	gen_require(`
+		type proc_xen_t;
+	')
+
+	allow $1 proc_xen_t:dir search;
+')
+
+########################################
+## <summary>
+##	Allow caller to read the xen state information.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The process type reading the state.
+##	</summary>
+## </param>
+##
+#
+interface(`kernel_read_xen_state',`
+	gen_require(`
+		type proc_t, proc_xen_t;
+	')
+
+	allow $1 proc_t:dir search;
+	allow $1 proc_xen_t:dir r_dir_perms;
+	allow $1 proc_xen_t:file r_file_perms;
+	allow $1 proc_xen_t:lnk_file { getattr read };
+')
+
+########################################
+## <summary>
+##	Allow caller to read the xen state symbolic links.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The process type reading the state.
+##	</summary>
+## </param>
+##
+#
+interface(`kernel_read_xen_state_symlinks',`
+	gen_require(`
+		type proc_t, proc_xen_t;
+	')
+
+	allow $1 proc_t:dir search;
+	allow $1 proc_xen_t:dir r_dir_perms;
+	allow $1 proc_xen_t:lnk_file r_file_perms;
+')
+
+
+########################################
+#
+# kernel_rw_xen(domain)
+#
+interface(`kernel_write_xen_state',`
+	gen_require(`
+		type proc_t, proc_xen_t;
+	')
+
+	allow $1 proc_t:dir search;
+	allow $1 proc_xen_t:dir r_dir_perms;
+	allow $1 proc_xen_t:file write;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/kernel.te serefpolicy-2.2.23/policy/modules/kernel/kernel.te
--- nsaserefpolicy/policy/modules/kernel/kernel.te	2006-02-07 10:43:26.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/kernel/kernel.te	2006-03-07 13:42:37.000000000 -0500
@@ -75,6 +75,9 @@
 type proc_net_t, proc_type;
 genfscon proc /net gen_context(system_u:object_r:proc_net_t,s0)
 
+type proc_xen_t, proc_type;
+genfscon proc /xen gen_context(system_u:object_r:proc_xen_t,s0)
+
 #
 # Sysctl types
 #
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/apache.fc serefpolicy-2.2.23/policy/modules/services/apache.fc
--- nsaserefpolicy/policy/modules/services/apache.fc	2006-02-27 17:17:23.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/services/apache.fc	2006-03-07 13:42:37.000000000 -0500
@@ -15,6 +15,7 @@
 /etc/vhosts			--	gen_context(system_u:object_r:httpd_config_t,s0)
 
 /srv/([^/]*/)?www(/.*)?			gen_context(system_u:object_r:httpd_sys_content_t,s0)
+/srv/gallery2(/.*)?			gen_context(system_u:object_r:httpd_sys_content_t,s0)
 
 /usr/bin/htsslpass 		--	gen_context(system_u:object_r:httpd_helper_exec_t,s0)
 
@@ -75,3 +76,4 @@
 /var/www/cgi-bin(/.*)?			gen_context(system_u:object_r:httpd_sys_script_exec_t,s0)
 /var/www/icons(/.*)?			gen_context(system_u:object_r:httpd_sys_content_t,s0)
 /var/www/perl(/.*)?			gen_context(system_u:object_r:httpd_sys_script_exec_t,s0)
+/usr/share/selinux-policy([^/]*)?/html(/.*)?	gen_context(system_u:object_r:httpd_sys_content_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/apache.if serefpolicy-2.2.23/policy/modules/services/apache.if
--- nsaserefpolicy/policy/modules/services/apache.if	2006-03-04 00:06:35.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/services/apache.if	2006-03-07 13:42:37.000000000 -0500
@@ -12,6 +12,11 @@
 ## </param>
 #
 template(`apache_content_template',`
+	gen_require(`
+		attribute httpdcontent;
+		attribute httpd_exec_scripts;
+		type httpd_t, httpd_suexec_t, httpd_log_t;
+	')
 	# allow write access to public file transfer
 	# services files.
 	gen_tunable(allow_httpd_$1_script_anon_write,false)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/apm.fc serefpolicy-2.2.23/policy/modules/services/apm.fc
--- nsaserefpolicy/policy/modules/services/apm.fc	2005-11-14 18:24:08.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/services/apm.fc	2006-03-07 15:38:20.000000000 -0500
@@ -11,7 +11,7 @@
 #
 # /var
 #
-/var/log/acpid		--	gen_context(system_u:object_r:apmd_log_t,s0)
+/var/log/acpid.*	--	gen_context(system_u:object_r:apmd_log_t,s0)
 
 /var/run/\.?acpid\.socket -s	gen_context(system_u:object_r:apmd_var_run_t,s0)
 /var/run/apmd\.pid	--	gen_context(system_u:object_r:apmd_var_run_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/apm.te serefpolicy-2.2.23/policy/modules/services/apm.te
--- nsaserefpolicy/policy/modules/services/apm.te	2006-03-04 00:06:35.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/services/apm.te	2006-03-08 13:36:37.000000000 -0500
@@ -225,6 +225,10 @@
 	pcmcia_domtrans_cardctl(apmd_t)
 ')
 
+optional_policy(`xserver',`
+	xserver_domtrans_xdm_xserver(apmd_t)
+')
+
 optional_policy(`selinuxutil',`
 	seutil_sigchld_newrole(apmd_t)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/bluetooth.te serefpolicy-2.2.23/policy/modules/services/bluetooth.te
--- nsaserefpolicy/policy/modules/services/bluetooth.te	2006-03-04 00:06:35.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/services/bluetooth.te	2006-03-16 09:30:42.000000000 -0500
@@ -115,6 +115,7 @@
 corecmd_exec_shell(bluetooth_t)
 
 domain_use_interactive_fds(bluetooth_t)
+domain_dontaudit_search_all_domains_state(bluetooth_t)
 
 files_read_etc_files(bluetooth_t)
 files_read_etc_runtime_files(bluetooth_t)
@@ -145,7 +146,11 @@
 
 optional_policy(`dbus',`
 	dbus_system_bus_client_template(bluetooth,bluetooth_t)
+	dbus_connect_system_bus(bluetooth_t)
 	dbus_send_system_bus(bluetooth_t)
+	dbus_system_bus_client_template(bluetooth_helper,bluetooth_helper_t)
+	dbus_connect_system_bus(bluetooth_helper_t)
+	dbus_send_system_bus(bluetooth_helper_t)
 ')
 
 optional_policy(`nis',`
@@ -170,6 +175,7 @@
 allow bluetooth_helper_t self:fifo_file rw_file_perms;
 allow bluetooth_helper_t self:shm create_shm_perms;
 allow bluetooth_helper_t self:unix_stream_socket { create_stream_socket_perms connectto };
+allow bluetooth_helper_t self:tcp_socket create_socket_perms;
 
 allow bluetooth_helper_t bluetooth_t:socket { read write };
 
@@ -202,20 +208,17 @@
 miscfiles_read_localization(bluetooth_helper_t) 
 miscfiles_read_fonts(bluetooth_helper_t)
 
-userdom_search_all_users_home_content(bluetooth_helper_t)
-
 optional_policy(`nscd',`
 	nscd_socket_use(bluetooth_helper_t)
 ')
 
+optional_policy(`xserver', `
+       	xserver_stream_connect_xdm(bluetooth_helper_t)
+');	
+
 ifdef(`TODO',`
 allow bluetooth_helper_t tmp_t:dir search;
 
-ifdef(`xserver.te', `
-	allow bluetooth_helper_t xserver_log_t:dir search;
-	allow bluetooth_helper_t xserver_log_t:file { getattr read };
-')
-
 ifdef(`strict_policy',`
 	ifdef(`xdm.te',`
 		allow bluetooth_helper_t xdm_xserver_tmp_t:sock_file { read write };
@@ -227,4 +230,7 @@
 	files_rw_generic_tmp_sockets(bluetooth_helper_t)
 	allow bluetooth_helper_t tmpfs_t:file { read write };
 	allow bluetooth_helper_t unconfined_t:unix_stream_socket connectto;
+	userdom_read_all_users_home_content_files(bluetooth_helper_t)
+
+	xserver_stream_connect_xdm(bluetooth_helper_t)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cron.te serefpolicy-2.2.23/policy/modules/services/cron.te
--- nsaserefpolicy/policy/modules/services/cron.te	2006-03-04 00:06:35.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/services/cron.te	2006-03-07 13:42:37.000000000 -0500
@@ -166,6 +166,9 @@
 
 	allow crond_t unconfined_t:dbus send_msg;
 	allow crond_t initrc_t:dbus send_msg;
+	optional_policy(`mono',`
+		mono_domtrans(crond_t)
+	')
 ',`
 	allow crond_t crond_tmp_t:dir create_dir_perms;
 	allow crond_t crond_tmp_t:file create_file_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cups.fc serefpolicy-2.2.23/policy/modules/services/cups.fc
--- nsaserefpolicy/policy/modules/services/cups.fc	2005-11-14 18:24:08.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/services/cups.fc	2006-03-07 13:42:37.000000000 -0500
@@ -43,7 +43,7 @@
 /var/log/cups(/.*)?		gen_context(system_u:object_r:cupsd_log_t,s0)
 /var/log/turboprint_cups\.log.* -- gen_context(system_u:object_r:cupsd_log_t,s0)
 
-/var/run/cups/printcap	--	gen_context(system_u:object_r:cupsd_var_run_t,s0)
+/var/run/cups(/.*)?		gen_context(system_u:object_r:cupsd_var_run_t,s0)
 /var/run/hp.*\.pid	--	gen_context(system_u:object_r:hplip_var_run_t,s0)
 /var/run/hp.*\.port	--	gen_context(system_u:object_r:hplip_var_run_t,s0)
 /var/run/ptal-printd(/.*)?	gen_context(system_u:object_r:ptal_var_run_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cups.if serefpolicy-2.2.23/policy/modules/services/cups.if
--- nsaserefpolicy/policy/modules/services/cups.if	2006-02-23 09:25:09.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/services/cups.if	2006-03-07 13:42:37.000000000 -0500
@@ -226,3 +226,25 @@
 	allow cupsd_t $1:tcp_socket { acceptfrom recvfrom };
 	kernel_tcp_recvfrom($1)
 ')
+
+########################################
+## <summary>
+##	Connect to cupsd over an unix domain stream socket.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`cups_stream_connect',`
+	gen_require(`
+		type cupsd_t, cupsd_var_run_t;
+	')
+
+	files_search_pids($1)
+	allow $1 cupsd_var_run_t:dir search;
+	allow $1 cupsd_var_run_t:sock_file write;
+	allow $1 cupsd_t:unix_stream_socket connectto;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cups.te serefpolicy-2.2.23/policy/modules/services/cups.te
--- nsaserefpolicy/policy/modules/services/cups.te	2006-03-04 00:06:35.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/services/cups.te	2006-03-07 13:42:37.000000000 -0500
@@ -77,7 +77,7 @@
 dontaudit cupsd_t self:capability { sys_tty_config net_admin };
 allow cupsd_t self:process { setsched signal_perms };
 allow cupsd_t self:fifo_file rw_file_perms;
-allow cupsd_t self:unix_stream_socket create_socket_perms;
+allow cupsd_t self:unix_stream_socket { create_stream_socket_perms connectto };
 allow cupsd_t self:unix_dgram_socket create_socket_perms;
 allow cupsd_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
 allow cupsd_t self:netlink_route_socket { r_netlink_socket_perms };
@@ -110,6 +110,7 @@
 
 allow cupsd_t cupsd_var_run_t:file create_file_perms;
 allow cupsd_t cupsd_var_run_t:dir rw_dir_perms;
+allow cupsd_t cupsd_var_run_t:sock_file create_file_perms;
 files_pid_filetrans(cupsd_t,cupsd_var_run_t,file)
 
 allow cupsd_t hplip_var_run_t:file { read getattr };
@@ -119,6 +120,7 @@
 allow cupsd_t ptal_t:unix_stream_socket connectto;
 
 kernel_read_system_state(cupsd_t)
+kernel_read_network_state(cupsd_t)
 kernel_read_all_sysctls(cupsd_t)
 kernel_tcp_recvfrom(cupsd_t)
 
@@ -382,6 +384,7 @@
 allow hplip_t self:rawip_socket create_socket_perms;
 
 allow hplip_t cupsd_etc_t:dir search;
+cups_stream_connect(hplip_t)
 
 allow hplip_t hplip_etc_t:file r_file_perms;
 allow hplip_t hplip_etc_t:dir r_dir_perms;
@@ -649,7 +652,7 @@
 ifdef(`targeted_policy',`
 	term_use_generic_ptys(cupsd_config_t)
 
-	unconfined_read_pipes(cupsd_config_t)
+	unconfined_rw_pipes(cupsd_config_t)
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cvs.te serefpolicy-2.2.23/policy/modules/services/cvs.te
--- nsaserefpolicy/policy/modules/services/cvs.te	2006-03-04 00:06:35.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/services/cvs.te	2006-03-07 13:42:37.000000000 -0500
@@ -11,7 +11,7 @@
 inetd_tcp_service_domain(cvs_t,cvs_exec_t)
 role system_r types cvs_t;
 
-type cvs_data_t; #, customizable;
+type cvs_data_t; # customizable
 files_type(cvs_data_t)
 
 type cvs_tmp_t;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/hal.if serefpolicy-2.2.23/policy/modules/services/hal.if
--- nsaserefpolicy/policy/modules/services/hal.if	2006-03-04 00:06:36.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/services/hal.if	2006-03-07 13:42:37.000000000 -0500
@@ -100,3 +100,44 @@
 	allow $1 hald_t:dbus send_msg;
 	allow hald_t $1:dbus send_msg;
 ')
+
+
+########################################
+## <summary>
+##	Read hald state files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`hal_read_var_run',`
+	gen_require(`
+		type hald_var_run_t;
+	')
+
+	files_search_pids($1)
+	allow $1 hald_var_run_t:file r_file_perms;
+')
+
+
+########################################
+## <summary>
+##	Read/Write hald state files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`hal_rw_var_run',`
+	gen_require(`
+		type hald_var_run_t;
+	')
+
+	files_search_pids($1)
+	allow $1 hald_var_run_t:file rw_file_perms;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/hal.te serefpolicy-2.2.23/policy/modules/services/hal.te
--- nsaserefpolicy/policy/modules/services/hal.te	2006-03-04 00:06:36.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/services/hal.te	2006-03-09 16:33:41.000000000 -0500
@@ -22,7 +22,7 @@
 #
 
 # execute openvt which needs setuid
-allow hald_t self:capability { setuid setgid kill net_admin sys_admin sys_nice dac_override dac_read_search mknod sys_rawio };
+allow hald_t self:capability { setuid setgid kill net_admin sys_admin sys_nice dac_override dac_read_search mknod sys_rawio sys_tty_config };
 dontaudit hald_t self:capability sys_tty_config;
 allow hald_t self:process signal_perms;
 allow hald_t self:fifo_file rw_file_perms;
@@ -48,6 +48,7 @@
 kernel_read_network_state(hald_t)
 kernel_read_kernel_sysctls(hald_t)
 kernel_read_fs_sysctls(hald_t)
+kernel_rw_vm_sysctls(hald_t)
 kernel_write_proc_files(hald_t)
 
 files_search_boot(hald_t)
@@ -75,6 +76,8 @@
 dev_read_lvm_control(hald_t)
 dev_getattr_all_chr_files(hald_t)
 dev_manage_generic_chr_files(hald_t)
+dev_rw_generic_usb_dev(hald_t)
+
 # hal is now execing pm-suspend
 dev_rw_sysfs(hald_t)
 
@@ -110,9 +113,8 @@
 storage_raw_write_fixed_disk(hald_t)
 
 term_dontaudit_use_console(hald_t)
-term_dontaudit_ioctl_unallocated_ttys(hald_t)
-term_dontaudit_use_unallocated_ttys(hald_t)
 term_dontaudit_use_generic_ptys(hald_t)
+term_use_unallocated_ttys(hald_t)
 
 init_use_fds(hald_t)
 init_use_script_ptys(hald_t)
@@ -144,6 +146,7 @@
 userdom_dontaudit_search_sysadm_home_dirs(hald_t)
 
 ifdef(`targeted_policy', `
+	term_setattr_unallocated_ttys(hald_t)
 	term_dontaudit_use_unallocated_ttys(hald_t)
 	term_dontaudit_use_generic_ptys(hald_t)
 	files_dontaudit_read_root_files(hald_t)
@@ -195,6 +198,10 @@
 	hotplug_read_config(hald_t)
 ')
 
+optional_policy(`lvm', `
+	lvm_domtrans(hald_t)
+')
+
 optional_policy(`mount',`
 	mount_domtrans(hald_t)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ktalk.fc serefpolicy-2.2.23/policy/modules/services/ktalk.fc
--- nsaserefpolicy/policy/modules/services/ktalk.fc	2006-02-20 14:07:37.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/services/ktalk.fc	2006-03-07 13:42:37.000000000 -0500
@@ -1,3 +1,4 @@
 
 /usr/bin/in.talkd		--	gen_context(system_u:object_r:ktalkd_exec_t,s0)
 /usr/bin/ktalkd		--	gen_context(system_u:object_r:ktalkd_exec_t,s0)
+/var/log/talkd.*	--	gen_context(system_u:object_r:ktalkd_log_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ktalk.te serefpolicy-2.2.23/policy/modules/services/ktalk.te
--- nsaserefpolicy/policy/modules/services/ktalk.te	2006-03-04 00:06:36.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/services/ktalk.te	2006-03-07 13:42:37.000000000 -0500
@@ -14,6 +14,9 @@
 type ktalkd_tmp_t;
 files_tmp_file(ktalkd_tmp_t)
 
+type ktalkd_log_t;
+logging_log_file(ktalkd_log_t)
+
 type ktalkd_var_run_t;
 files_pid_file(ktalkd_var_run_t)
 
@@ -68,9 +71,12 @@
 
 files_read_etc_files(ktalkd_t)
 
+init_read_utmp(ktalkd_t)
+
 libs_use_ld_so(ktalkd_t)
 libs_use_shared_libs(ktalkd_t)
 logging_send_syslog_msg(ktalkd_t)
+logging_log_filetrans(ktalkd_t,ktalkd_log_t,file)
 
 miscfiles_read_localization(ktalkd_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/mailman.if serefpolicy-2.2.23/policy/modules/services/mailman.if
--- nsaserefpolicy/policy/modules/services/mailman.if	2006-03-04 00:06:36.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/services/mailman.if	2006-03-08 16:59:01.000000000 -0500
@@ -275,3 +275,28 @@
 	allow $1 mailman_archive_t:file r_file_perms;
 	allow $1 mailman_archive_t:lnk_file { getattr read };
 ')
+
+
+#######################################
+## <summary>
+##	Execute mailman_queue in the mailman_queue domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`mailman_queue_domtrans',`
+	gen_require(`
+		type mailman_queue_exec_t, mailman_queue_t;
+	')
+
+	domain_auto_trans($1, mailman_queue_exec_t, mailman_queue_t)
+
+	allow $1 mailman_queue_t:fd use;
+	allow mailman_queue_t $1:fd use;
+	allow mailman_queue_t $1:fifo_file rw_file_perms;
+	allow mailman_queue_t $1:process sigchld;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/nis.fc serefpolicy-2.2.23/policy/modules/services/nis.fc
--- nsaserefpolicy/policy/modules/services/nis.fc	2005-11-28 21:48:04.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/services/nis.fc	2006-03-10 16:47:00.000000000 -0500
@@ -7,3 +7,4 @@
 /usr/sbin/ypserv	--	gen_context(system_u:object_r:ypserv_exec_t,s0)
 
 /var/yp(/.*)?			gen_context(system_u:object_r:var_yp_t,s0)
+/usr/sbin/rpc.ypxfr	--	gen_context(system_u:object_r:ypxfr_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/nis.if serefpolicy-2.2.23/policy/modules/services/nis.if
--- nsaserefpolicy/policy/modules/services/nis.if	2006-02-10 21:34:14.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/services/nis.if	2006-03-10 16:45:39.000000000 -0500
@@ -277,3 +277,28 @@
 	files_search_etc($1)
 	allow $1 ypserv_conf_t:file { getattr read };
 ')
+
+
+########################################
+## <summary>
+##	Execute ypxfr in the ypxfr domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`nis_domtrans_ypxfr',`
+	gen_require(`
+		type ypxfr_t, ypxfr_exec_t;
+	')
+
+	corecmd_search_bin($1)
+	domain_auto_trans($1,ypxfr_exec_t,ypxfr_t)
+
+	allow $1 ypxfr_t:fd use;
+	allow ypxfr_t $1:fd use;
+	allow ypxfr_t $1:fifo_file rw_file_perms;
+	allow ypxfr_t $1:process sigchld;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/nis.te serefpolicy-2.2.23/policy/modules/services/nis.te
--- nsaserefpolicy/policy/modules/services/nis.te	2006-03-04 00:06:36.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/services/nis.te	2006-03-13 13:32:08.000000000 -0500
@@ -31,6 +31,10 @@
 type ypserv_exec_t;
 init_daemon_domain(ypserv_t,ypserv_exec_t)
 
+type ypxfr_t;
+type ypxfr_exec_t;
+init_daemon_domain(ypxfr_t,ypxfr_exec_t)
+
 type ypserv_conf_t;
 files_type(ypserv_conf_t)
 
@@ -245,6 +249,7 @@
 allow ypserv_t self:fifo_file rw_file_perms;
 allow ypserv_t self:process signal_perms;
 allow ypserv_t self:unix_dgram_socket create_socket_perms;
+allow ypserv_t self:unix_stream_socket create_stream_socket_perms;
 allow ypserv_t self:netlink_route_socket r_netlink_socket_perms;
 allow ypserv_t self:tcp_socket connected_stream_socket_perms;
 allow ypserv_t self:udp_socket create_socket_perms;
@@ -306,6 +311,8 @@
 
 miscfiles_read_localization(ypserv_t)
 
+nis_domtrans_ypxfr(ypserv_t)
+
 sysnet_read_config(ypserv_t)
 
 userdom_dontaudit_use_unpriv_user_fds(ypserv_t)
@@ -326,3 +333,24 @@
 optional_policy(`udev',`
 	udev_read_db(ypserv_t)
 ')
+
+corenet_tcp_sendrecv_all_if(ypxfr_t)
+corenet_udp_sendrecv_all_if(ypxfr_t)
+corenet_raw_sendrecv_all_if(ypxfr_t)
+corenet_tcp_sendrecv_all_nodes(ypxfr_t)
+corenet_udp_sendrecv_all_nodes(ypxfr_t)
+corenet_raw_sendrecv_all_nodes(ypxfr_t)
+corenet_tcp_sendrecv_all_ports(ypxfr_t)
+corenet_udp_sendrecv_all_ports(ypxfr_t)
+corenet_non_ipsec_sendrecv(ypxfr_t)
+corenet_tcp_bind_all_nodes(ypxfr_t)
+corenet_udp_bind_all_nodes(ypxfr_t)
+corenet_tcp_bind_reserved_port(ypxfr_t)
+corenet_udp_bind_reserved_port(ypxfr_t)
+corenet_dontaudit_tcp_bind_all_reserved_ports(ypxfr_t)
+corenet_dontaudit_udp_bind_all_reserved_ports(ypxfr_t)
+corenet_tcp_connect_all_ports(ypxfr_t)
+allow ypxfr_t self:unix_stream_socket create_stream_socket_perms;
+
+allow ypxfr_t etc_t:file { getattr read };
+files_read_etc_files(ypxfr_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/nscd.if serefpolicy-2.2.23/policy/modules/services/nscd.if
--- nsaserefpolicy/policy/modules/services/nscd.if	2006-02-10 21:34:14.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/services/nscd.if	2006-03-07 13:42:37.000000000 -0500
@@ -49,8 +49,8 @@
 	dontaudit $1 nscd_t:nscd { shmempwd shmemgrp shmemhost };
 
 	files_search_pids($1)
+	allow $1 nscd_var_run_t:dir r_dir_perms;
 	allow $1 nscd_var_run_t:sock_file rw_file_perms;
-	dontaudit $1 nscd_var_run_t:dir { search getattr };
 	dontaudit $1 nscd_var_run_t:file { getattr read };
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/postfix.te serefpolicy-2.2.23/policy/modules/services/postfix.te
--- nsaserefpolicy/policy/modules/services/postfix.te	2006-03-04 00:06:36.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/services/postfix.te	2006-03-08 16:58:41.000000000 -0500
@@ -406,6 +406,10 @@
 	procmail_domtrans(postfix_pipe_t)
 ')
 
+optional_policy(`mailman',`
+	mailman_queue_domtrans(postfix_pipe_t)
+')
+
 ########################################
 #
 # Postfix postdrop local policy
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/samba.te serefpolicy-2.2.23/policy/modules/services/samba.te
--- nsaserefpolicy/policy/modules/services/samba.te	2006-03-04 00:06:36.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/services/samba.te	2006-03-07 13:42:37.000000000 -0500
@@ -32,7 +32,7 @@
 type samba_secrets_t;
 files_type(samba_secrets_t)
 
-type samba_share_t;
+type samba_share_t;  # customizable
 files_config_file(samba_share_t)
 
 type samba_var_t;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/sendmail.te serefpolicy-2.2.23/policy/modules/services/sendmail.te
--- nsaserefpolicy/policy/modules/services/sendmail.te	2006-03-04 00:06:36.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/services/sendmail.te	2006-03-14 15:56:20.000000000 -0500
@@ -125,6 +125,7 @@
 ')
 
 optional_policy(`postfix',`
+	postfix_exec_master(sendmail_t)
 	postfix_read_config(sendmail_t)
 	postfix_search_spool(sendmail_t)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/fstools.if serefpolicy-2.2.23/policy/modules/system/fstools.if
--- nsaserefpolicy/policy/modules/system/fstools.if	2006-02-10 21:34:15.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/system/fstools.if	2006-03-14 11:33:20.000000000 -0500
@@ -110,3 +110,21 @@
 
 	allow $1 fsadm_exec_t:file create_file_perms;
 ')
+
+########################################
+## <summary>
+##	Getattr swapfile
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`fstools_getattr_swap_files',`
+	gen_require(`
+		type swapfile_t;
+	')
+
+	allow $1 swapfile_t:file getattr;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/fstools.te serefpolicy-2.2.23/policy/modules/system/fstools.te
--- nsaserefpolicy/policy/modules/system/fstools.te	2006-03-04 00:06:37.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/system/fstools.te	2006-03-14 11:32:08.000000000 -0500
@@ -53,6 +53,7 @@
 kernel_change_ring_buffer_level(fsadm_t)
 # mkreiserfs needs this
 kernel_getattr_proc(fsadm_t)
+kernel_getattr_core_if(fsadm_t)
 # Access to /initrd devices
 kernel_rw_unlabeled_dirs(fsadm_t)
 kernel_rw_unlabeled_blk_files(fsadm_t)
@@ -73,6 +74,7 @@
 dev_getattr_usbfs_dirs(fsadm_t)
 # Access to /dev/mapper/control
 dev_rw_lvm_control(fsadm_t)
+dev_dontaudit_getattr_all_device_nodes(fsadm_t)
 
 fs_search_auto_mountpoints(fsadm_t)
 fs_getattr_xattr_fs(fsadm_t)
@@ -127,6 +129,7 @@
 
 init_use_fds(fsadm_t)
 init_use_script_ptys(fsadm_t)
+init_dontaudit_getattr_initctl(fsadm_t)
 
 libs_use_ld_so(fsadm_t)
 libs_use_shared_libs(fsadm_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.te serefpolicy-2.2.23/policy/modules/system/init.te
--- nsaserefpolicy/policy/modules/system/init.te	2006-03-04 00:06:37.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/system/init.te	2006-03-15 09:44:32.000000000 -0500
@@ -349,6 +349,7 @@
 files_mounton_isid_type_dirs(initrc_t)
 files_list_default(initrc_t)
 files_mounton_default(initrc_t)
+files_unlink_boot_flag(initrc_t)
 
 libs_rw_ld_so_cache(initrc_t)
 libs_use_ld_so(initrc_t)
@@ -482,6 +483,10 @@
 ifdef(`targeted_policy',`
 	domain_subj_id_change_exemption(initrc_t)
 	unconfined_domain(initrc_t)
+	optional_policy(`mono',`
+		mono_domtrans(initrc_t)
+	')
+
 ',`
 	# cjp: require doesnt work in optionals :\
 	# this also would result in a type transition
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/libraries.fc serefpolicy-2.2.23/policy/modules/system/libraries.fc
--- nsaserefpolicy/policy/modules/system/libraries.fc	2006-02-20 14:07:38.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/system/libraries.fc	2006-03-07 13:42:37.000000000 -0500
@@ -65,6 +65,7 @@
 /usr/lib(64)?/(nvidia/)?libGL(core)?\.so(\.[^/]*)* --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libGLU\.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?(/.*)?/libnvidia.*\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?(/.*)?/nvidia_drv.*\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 /usr/(local/)?lib/wine/.*\.so  		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/(local/)?lib/libfame-.*\.so.*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
@@ -74,6 +75,7 @@
 /usr/X11R6/lib/libXvMCNVIDIA\.so.* 	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 /usr/x11R6/lib/modules/extensions/libglx\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/xorg/modules/extensions/libglx\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 ifdef(`distro_redhat',`
 /usr/lib(64)?/.*/program/.*\.so.*		gen_context(system_u:object_r:shlib_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/locallogin.te serefpolicy-2.2.23/policy/modules/system/locallogin.te
--- nsaserefpolicy/policy/modules/system/locallogin.te	2006-03-04 00:06:37.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/system/locallogin.te	2006-03-07 13:42:37.000000000 -0500
@@ -20,6 +20,7 @@
 
 type local_login_tmp_t;
 files_tmp_file(local_login_tmp_t)
+files_poly_parent(local_login_tmp_t)
 
 type sulogin_t;
 type sulogin_exec_t;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/lvm.fc serefpolicy-2.2.23/policy/modules/system/lvm.fc
--- nsaserefpolicy/policy/modules/system/lvm.fc	2005-11-14 18:24:06.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/system/lvm.fc	2006-03-07 13:42:37.000000000 -0500
@@ -25,6 +25,7 @@
 # /sbin
 #
 /sbin/cryptsetup	--	gen_context(system_u:object_r:lvm_exec_t,s0)
+/sbin/dmraid		--	gen_context(system_u:object_r:lvm_exec_t,s0)
 /sbin/dmsetup		--	gen_context(system_u:object_r:lvm_exec_t,s0)
 /sbin/dmsetup\.static	--	gen_context(system_u:object_r:lvm_exec_t,s0)
 /sbin/e2fsadm		--	gen_context(system_u:object_r:lvm_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/lvm.te serefpolicy-2.2.23/policy/modules/system/lvm.te
--- nsaserefpolicy/policy/modules/system/lvm.te	2006-03-04 00:06:37.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/system/lvm.te	2006-03-08 10:58:24.000000000 -0500
@@ -129,6 +129,8 @@
 
 # DAC overrides and mknod for modifying /dev entries (vgmknodes)
 allow lvm_t self:capability { dac_override ipc_lock sys_admin sys_nice mknod chown sys_resource };
+# Needed for dmraid
+allow lvm_t self:capability sys_rawio;
 dontaudit lvm_t self:capability sys_tty_config;
 allow lvm_t self:process { sigchld sigkill sigstop signull signal };
 # LVM will complain a lot if it cannot set its priority.
@@ -199,6 +201,7 @@
 dev_dontaudit_getattr_generic_chr_files(lvm_t)
 dev_dontaudit_getattr_generic_blk_files(lvm_t)
 dev_dontaudit_getattr_generic_pipes(lvm_t)
+dev_create_generic_dirs(lvm_t)
 
 fs_getattr_xattr_fs(lvm_t)
 fs_search_auto_mountpoints(lvm_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/mount.te serefpolicy-2.2.23/policy/modules/system/mount.te
--- nsaserefpolicy/policy/modules/system/mount.te	2006-03-04 00:06:37.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/system/mount.te	2006-03-14 14:40:50.000000000 -0500
@@ -26,6 +26,7 @@
 files_tmp_filetrans(mount_t,mount_tmp_t,{ file dir })
 
 kernel_read_system_state(mount_t)
+kernel_dontaudit_getattr_core_if(mount_t)
 
 corenet_dontaudit_tcp_bind_all_reserved_ports(mount_t)
 corenet_dontaudit_udp_bind_all_reserved_ports(mount_t)
@@ -33,6 +34,7 @@
 dev_getattr_all_blk_files(mount_t)
 dev_list_all_dev_nodes(mount_t)
 dev_rw_lvm_control(mount_t)
+dev_dontaudit_getattr_all_device_nodes(mount_t)
 dev_dontaudit_getattr_memory_dev(mount_t)
 dev_getattr_sound_dev(mount_t)
 
@@ -73,6 +75,7 @@
 
 init_use_fds(mount_t)
 init_use_script_ptys(mount_t)
+init_dontaudit_getattr_initctl(mount_t)
 
 libs_use_ld_so(mount_t)
 libs_use_shared_libs(mount_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.fc serefpolicy-2.2.23/policy/modules/system/selinuxutil.fc
--- nsaserefpolicy/policy/modules/system/selinuxutil.fc	2006-02-23 09:25:09.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/system/selinuxutil.fc	2006-03-15 16:33:44.000000000 -0500
@@ -8,9 +8,9 @@
 /etc/selinux/([^/]*/)?contexts/files(/.*)? gen_context(system_u:object_r:file_context_t,s0)
 /etc/selinux/([^/]*/)?policy(/.*)?	gen_context(system_u:object_r:policy_config_t,s15:c0.c255)
 /etc/selinux/([^/]*/)?seusers	--	gen_context(system_u:object_r:selinux_config_t,s15:c0.c255)
-/etc/selinux([^/]*/)?modules/(active|tmp|previous)(/.*)?     --	gen_context(system_u:object_r:semanage_store_t,s0)
-/etc/selinux([^/]*/)?modules/semanage.read.LOCK    --	gen_context(system_u:object_r:semanage_read_lock_t,s0)
-/etc/selinux([^/]*/)?modules/semanage.trans.LOCK   --	gen_context(system_u:object_r:semanage_trans_lock_t,s0)
+/etc/selinux/([^/]*/)?modules/(active|tmp|previous)(/.*)?     gen_context(system_u:object_r:semanage_store_t,s0)
+/etc/selinux/([^/]*/)?modules/semanage.read.LOCK    --	gen_context(system_u:object_r:semanage_read_lock_t,s0)
+/etc/selinux/([^/]*/)?modules/semanage.trans.LOCK   --	gen_context(system_u:object_r:semanage_trans_lock_t,s0)
 /etc/selinux/([^/]*/)?users(/.*)?	--	gen_context(system_u:object_r:selinux_config_t,s15:c0.c255)
 
 #
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.if serefpolicy-2.2.23/policy/modules/system/selinuxutil.if
--- nsaserefpolicy/policy/modules/system/selinuxutil.if	2006-02-23 09:25:09.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/system/selinuxutil.if	2006-03-14 17:32:57.000000000 -0500
@@ -675,8 +675,8 @@
 
 	files_search_etc($1)
 	allow $1 selinux_config_t:dir search;
-	allow $1 file_context_t:dir r_dir_perms;
-	allow $1 file_context_t:file rw_file_perms;
+	allow $1 file_context_t:dir rw_dir_perms;
+	allow $1 file_context_t:file create_file_perms;
 	allow $1 file_context_t:lnk_file { getattr read };
 ')
 
@@ -853,7 +853,7 @@
 	')
 
 	files_search_etc($1)
-	allow $1 selinux_config_t:dir rw_dir_perms;
+	allow $1 selinux_config_t:dir create_dir_perms;
 	type_transition $1 selinux_config_t:dir semanage_store_t;
 
 	allow $1 semanage_store_t:dir create_dir_perms;
@@ -899,3 +899,20 @@
 	allow $1 selinux_config_t:dir search_dir_perms;
 	allow $1 semanage_trans_lock_t:file rw_file_perms;
 ')
+
+
+########################################
+#
+# seutil_manage_config(domain)
+#
+interface(`seutil_manage_selinux_config',`
+	gen_require(`
+		type selinux_config_t;
+	')
+
+	files_search_etc($1)
+	allow $1 selinux_config_t:dir rw_dir_perms;
+	allow $1 selinux_config_t:file create_file_perms;
+	allow $1 selinux_config_t:lnk_file { getattr read };
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.te serefpolicy-2.2.23/policy/modules/system/selinuxutil.te
--- nsaserefpolicy/policy/modules/system/selinuxutil.te	2006-03-04 00:06:37.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/system/selinuxutil.te	2006-03-15 09:23:03.000000000 -0500
@@ -192,6 +192,9 @@
 selinux_load_policy(load_policy_t)
 selinux_set_boolean(load_policy_t)
 
+seutil_get_semanage_trans_lock(load_policy_t)
+seutil_get_semanage_read_lock(load_policy_t)
+
 term_use_console(load_policy_t)
 term_list_ptys(load_policy_t)
 
@@ -263,6 +266,7 @@
 selinux_compute_relabel_context(newrole_t)
 selinux_compute_user_contexts(newrole_t)
 
+term_getattr_unallocated_ttys(newrole_t)
 term_use_all_user_ttys(newrole_t)
 term_use_all_user_ptys(newrole_t)
 term_relabel_all_user_ttys(newrole_t)
@@ -476,6 +480,11 @@
 	optional_policy(`daemontools',`
 		daemontools_domtrans_start(run_init_t)
 	')
+
+	optional_policy(`nscd',`
+		nscd_socket_use(run_init_t)
+	')	
+
 ') dnl end ifdef targeted policy
 
 ########################################
@@ -499,6 +508,7 @@
 
 mls_file_write_down(semanage_t)
 mls_rangetrans_target(semanage_t)
+mls_file_read_up(semanage_t)
 
 selinux_get_enforce_mode(semanage_t)
 
@@ -510,6 +520,7 @@
 
 seutil_search_default_contexts(semanage_t)
 seutil_rw_file_contexts(semanage_t)
+seutil_manage_selinux_config(semanage_t)
 seutil_domtrans_setfiles(semanage_t)
 seutil_domtrans_loadpolicy(semanage_t)
 seutil_read_config(semanage_t)
@@ -519,6 +530,10 @@
 seutil_get_semanage_trans_lock(semanage_t)
 seutil_get_semanage_read_lock(semanage_t)
 
+optional_policy(`nscd',`
+	nscd_socket_use(semanage_t)
+')
+
 ########################################
 #
 # Setfiles local policy
@@ -581,6 +596,7 @@
 miscfiles_read_localization(setfiles_t)
 
 seutil_get_semanage_read_lock(setfiles_t)
+seutil_get_semanage_trans_lock(setfiles_t)
 
 userdom_use_all_users_fds(setfiles_t)
 # for config files in a home directory
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/sysnetwork.te serefpolicy-2.2.23/policy/modules/system/sysnetwork.te
--- nsaserefpolicy/policy/modules/system/sysnetwork.te	2006-03-04 00:06:37.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/system/sysnetwork.te	2006-03-09 11:15:56.000000000 -0500
@@ -161,6 +161,10 @@
 	consoletype_domtrans(dhcpc_t)
 ')
 
+optional_policy(`xend',`
+	xend_append_log(dhcpc_t)
+')
+
 optional_policy(`dbus',`
 	gen_require(`
 		class dbus send_msg;
@@ -322,6 +326,9 @@
 		udev_dontaudit_rw_dgram_sockets(ifconfig_t)
 	')
 ')
+optional_policy(`xend',`
+	xend_append_log(ifconfig_t)
+')
 
 ifdef(`targeted_policy',`
 	term_use_generic_ptys(ifconfig_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/udev.te serefpolicy-2.2.23/policy/modules/system/udev.te
--- nsaserefpolicy/policy/modules/system/udev.te	2006-03-04 00:06:37.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/system/udev.te	2006-03-13 12:21:29.000000000 -0500
@@ -39,7 +39,7 @@
 # Local policy
 #
 
-allow udev_t self:capability { chown dac_override dac_read_search fowner fsetid sys_admin mknod net_raw net_admin sys_nice sys_rawio sys_resource sys_nice };
+allow udev_t self:capability { chown dac_override dac_read_search fowner fsetid sys_admin mknod net_raw net_admin sys_nice sys_rawio sys_resource setuid setgid sys_nice };
 dontaudit udev_t self:capability sys_tty_config;
 allow udev_t self:process ~{ ptrace setcurrent setexec setfscreate setrlimit execmem execstack execheap };
 allow udev_t self:process { execmem setfscreate };
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.te serefpolicy-2.2.23/policy/modules/system/unconfined.te
--- nsaserefpolicy/policy/modules/system/unconfined.te	2006-02-20 14:07:38.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/system/unconfined.te	2006-03-08 12:35:43.000000000 -0500
@@ -89,10 +89,6 @@
 		firstboot_domtrans(unconfined_t)
 	')
 
-	optional_policy(`fstools',`
-		fstools_domtrans(unconfined_t)
-	')
-
 	optional_policy(`java',`
 		java_domtrans(unconfined_t)
 	')
@@ -109,10 +105,6 @@
 		mono_domtrans(unconfined_t)
 	')
 
-	optional_policy(`mount',`
-		mount_domtrans(unconfined_t)
-	')
-
 	optional_policy(`netutils',`
 		netutils_domtrans_ping(unconfined_t)
 	')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.te serefpolicy-2.2.23/policy/modules/system/userdomain.te
--- nsaserefpolicy/policy/modules/system/userdomain.te	2006-03-04 00:06:37.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/system/userdomain.te	2006-03-14 15:57:25.000000000 -0500
@@ -179,6 +179,7 @@
 		logging_read_audit_log(secadm_t)
 		logging_domtrans_auditctl(secadm_t)
 		userdom_dontaudit_append_staff_home_content_files(secadm_t)
+		init_exec(secadm_t)
 	', `
 		logging_domtrans_auditctl(sysadm_t)
 		logging_read_audit_log(sysadm_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/xend.fc serefpolicy-2.2.23/policy/modules/system/xend.fc
--- nsaserefpolicy/policy/modules/system/xend.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/system/xend.fc	2006-03-10 16:48:34.000000000 -0500
@@ -0,0 +1,23 @@
+# xend executable will have:
+# label: system_u:object_r:xend_exec_t
+# MLS sensitivity: s0
+# MCS categories: <none>
+/usr/sbin/xend          --      system_u:object_r:xend_exec_t:s0
+/usr/sbin/xenconsoled   --      system_u:object_r:xenconsoled_exec_t:s0
+/usr/sbin/xenstored     --      system_u:object_r:xenstored_exec_t:s0
+
+/var/log/xend\.log              -- system_u:object_r:xend_var_log_t:s0
+/var/log/xend-debug\.log        -- system_u:object_r:xend_var_log_t:s0
+/var/log/xen-hotplug\.log        -- system_u:object_r:xend_var_log_t:s0
+/var/lib/xen(/.*)?              system_u:object_r:xend_var_lib_t:s0
+/var/lib/xend(/.*)?             system_u:object_r:xend_var_lib_t:s0
+/var/lib/xenstored(/.*)?        system_u:object_r:xenstored_var_lib_t:s0
+/var/run/xenstored(/.*)?        system_u:object_r:xenstored_var_run_t:s0
+/var/run/xend\.pid      --      system_u:object_r:xend_var_run_t:s0
+/var/run/xenstore\.pid  --      system_u:object_r:xenstored_var_run_t:s0
+/var/run/xenconsoled\.pid        --      system_u:object_r:xenconsoled_var_run_t:s0
+/etc/xen/scripts(/.*)?          system_u:object_r:bin_t:s0
+/dev/evtchn             -c      system_u:object_r:xend_device_t:s0
+/dev/xen/evtchn         -c      system_u:object_r:xend_device_t:s0
+/usr/lib/xen/bin(/.*)?          system_u:object_r:bin_t:s0
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/xend.if serefpolicy-2.2.23/policy/modules/system/xend.if
--- nsaserefpolicy/policy/modules/system/xend.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/system/xend.if	2006-03-07 15:47:54.000000000 -0500
@@ -0,0 +1,71 @@
+## <summary>policy for xen</summary>
+
+########################################
+## <summary>
+##	Execute a domain transition to run xend.
+## </summary>
+## <param name="domain">
+## 	<summary>
+##	Domain allowed to transition.
+## 	</summary>
+## </param>
+#
+interface(`xend_domtrans',`
+	gen_requires(`
+		type xend_t, xend_exec_t;
+	')
+
+	domain_auto_trans($1,xend_exec_t,xend_t)
+
+	allow $1 xend_t:fd use;
+	allow xend_t $1:fd use;
+	allow xend_t $1:fifo_file rw_file_perms;
+	allow xend_t $1:process sigchld;
+')
+
+
+########################################
+## <summary>
+##	Allow the specified domain to append
+##	xend log files.
+## </summary>
+## <param name="domain">
+## 	<summary>
+##	Domain allowed to transition.
+## 	</summary>
+## </param>
+#
+interface(`xend_append_log',`
+	gen_require(`
+		type var_log_t, xend_var_log_t;
+	')
+
+	files_search_var($1)
+	allow $1 var_log_t:dir r_dir_perms;
+	allow $1 xend_var_log_t:file { getattr append };
+	dontaudit $1 xend_var_log_t:file write;
+')
+
+
+
+########################################
+## <summary>
+##	Connect to xenstored over an unix stream socket.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`xend_store_stream_connect',`
+	gen_require(`
+		type xenstored_t, xenstored_var_run_t;
+	')
+
+	files_search_pids($1)
+	allow $1 xenstored_var_run_t:dir search;
+	allow $1 xenstored_var_run_t:sock_file { getattr write };
+	allow $1 xenstored_t:unix_stream_socket connectto;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/xend.te serefpolicy-2.2.23/policy/modules/system/xend.te
--- nsaserefpolicy/policy/modules/system/xend.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.2.23/policy/modules/system/xend.te	2006-03-13 16:17:27.000000000 -0500
@@ -0,0 +1,219 @@
+policy_module(xend,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type xend_t;
+type xend_exec_t;
+domain_type(xend_t)
+init_daemon_domain(xend_t, xend_exec_t)
+
+# pid files
+type xend_var_run_t;
+files_pid_file(xend_var_run_t)
+
+# log files
+type xend_var_log_t;
+logging_log_file(xend_var_log_t)
+
+# var/lib files
+type xend_var_lib_t;
+files_type(xend_var_lib_t)
+
+# var/lib files
+type xend_device_t;
+dev_node(xend_device_t)
+
+type xenstored_t;
+type xenstored_exec_t;
+domain_type(xenstored_t)
+domain_entry_file(xenstored_t,xenstored_exec_t)
+
+# pid files
+type xenstored_var_run_t;
+files_pid_file(xenstored_var_run_t)
+
+# var/lib files
+type xenstored_var_lib_t;
+files_type(xenstored_var_lib_t)
+
+type xenconsoled_t;
+type xenconsoled_exec_t;
+domain_type(xenconsoled_t)
+domain_entry_file(xenconsoled_t,xenconsoled_exec_t)
+
+# pid files
+type xenconsoled_var_run_t;
+files_pid_file(xenconsoled_var_run_t)
+
+# console ptys
+type xen_devpts_t;
+term_pty(xen_devpts_t);
+files_type(xen_devpts_t);
+
+########################################
+#
+# xend local policy
+#
+# Check in /etc/selinux/refpolicy/include for macros to use instead of allow rules.
+
+## internal communication is often done using fifo and unix sockets.
+allow xend_t self:fifo_file rw_file_perms;
+allow xend_t self:unix_stream_socket create_stream_socket_perms;
+allow xend_t self:process { signal sigkill };
+allow xend_t self:capability { dac_override ipc_lock net_admin setuid sys_nice sys_tty_config };
+allow xend_t self:netlink_route_socket r_netlink_socket_perms;
+
+# pid file
+allow xend_t xend_var_run_t:file manage_file_perms;
+allow xend_t xend_var_run_t:sock_file manage_file_perms;
+allow xend_t xend_var_run_t:dir rw_dir_perms;
+
+# log files
+allow xend_t xend_var_log_t:file create_file_perms;
+allow xend_t xend_var_log_t:sock_file create_file_perms;
+allow xend_t xend_var_log_t:dir { rw_dir_perms setattr };
+
+# var/lib files for xend
+allow xend_t xend_var_lib_t:file create_file_perms;
+allow xend_t xend_var_lib_t:sock_file create_file_perms;
+allow xend_t xend_var_lib_t:dir create_dir_perms;
+
+allow xend_t self:tcp_socket create_stream_socket_perms;
+allow xend_t self:packet_socket create_socket_perms;
+allow xend_t self:unix_dgram_socket create_socket_perms;
+
+consoletype_exec(xend_t)
+
+corenet_tcp_sendrecv_all_if(xend_t)
+corenet_tcp_sendrecv_all_nodes(xend_t)
+corenet_tcp_sendrecv_all_ports(xend_t)
+corenet_non_ipsec_sendrecv(xend_t)
+corenet_tcp_bind_xen_port(xend_t)
+corenet_tcp_bind_soundd_port(xend_t)
+
+corecmd_exec_sbin(xend_t)
+corecmd_exec_bin(xend_t)
+corecmd_exec_shell(xend_t)
+
+dev_read_urand(xend_t)
+dev_filetrans(xend_t, xend_device_t, chr_file)
+dev_rw_sysfs(xend_t)
+
+domain_read_all_domains_state(xend_t)
+domain_dontaudit_read_all_domains_state(xend_t)
+
+files_var_lib_filetrans(xend_t,xend_var_lib_t,{ file dir sock_file })
+files_pid_filetrans(xend_t,xend_var_run_t, { file sock_file })
+files_read_etc_files(xend_t)
+
+init_use_fds(xend_t)
+
+kernel_read_kernel_sysctls(xend_t)
+kernel_read_system_state(xend_t)
+kernel_write_xen_state(xend_t)
+kernel_read_xen_state(xend_t)
+kernel_rw_net_sysctls(xend_t)
+kernel_read_network_state(xend_t)
+
+libs_use_ld_so(xend_t)
+libs_use_shared_libs(xend_t)
+
+logging_send_syslog_msg(xend_t)
+logging_log_filetrans(xend_t,xend_var_log_t,{ sock_file file dir })
+
+miscfiles_read_localization(xend_t)
+
+sysnet_domtrans_dhcpc(xend_t)
+sysnet_signal_dhcpc(xend_t)
+sysnet_domtrans_ifconfig(xend_t)
+sysnet_dns_name_resolve(xend_t)
+sysnet_delete_dhcpc_pid(xend_t)
+sysnet_read_dhcpc_pid(xend_t)
+
+term_dontaudit_getattr_all_user_ptys(xend_t)
+term_dontaudit_use_generic_ptys(xend_t)
+
+storage_raw_read_fixed_disk(xend_t)
+
+xend_store_stream_connect(xend_t)
+
+################################   xenconsoled_t ##############################
+domain_auto_trans(xend_t, xenconsoled_exec_t, xenconsoled_t)
+role system_r types xenconsoled_t;
+allow xenconsoled_t xend_t:fd use;
+
+allow xenconsoled_t self:unix_stream_socket create_stream_socket_perms;
+allow xenconsoled_t self:capability { dac_override fsetid ipc_lock };
+allow xenconsoled_t self:fifo_file { read write };
+allow xenconsoled_t xend_device_t:chr_file rw_file_perms;
+allow xenconsoled_t xen_devpts_t:chr_file rw_term_perms;
+# pid file
+allow xenconsoled_t xenconsoled_var_run_t:file manage_file_perms;
+allow xenconsoled_t xenconsoled_var_run_t:sock_file manage_file_perms;
+allow xenconsoled_t xenconsoled_var_run_t:dir rw_dir_perms;
+
+files_pid_filetrans(xenconsoled_t,xenconsoled_var_run_t, { file sock_file })
+files_search_etc(xenconsoled_t)
+
+init_use_fds(xenconsoled_t)
+
+kernel_read_kernel_sysctls(xenconsoled_t)
+kernel_write_xen_state(xenconsoled_t)
+kernel_read_xen_state(xenconsoled_t)
+
+libs_use_ld_so(xenconsoled_t)
+libs_use_shared_libs(xenconsoled_t)
+
+miscfiles_read_localization(xenconsoled_t)
+
+term_create_pty(xenconsoled_t,xen_devpts_t);
+term_dontaudit_use_generic_ptys(xenconsoled_t)
+
+xend_append_log(xenconsoled_t)
+xend_store_stream_connect(xenconsoled_t)
+
+################################   xenstored_t ###############################
+domain_auto_trans(xend_t, xenstored_exec_t, xenstored_t)
+role system_r types xenstored_t;
+allow xenstored_t xend_t:fd use;
+
+allow xenstored_t self:capability { dac_override mknod ipc_lock };
+allow xenstored_t self:unix_stream_socket create_stream_socket_perms;
+allow xenstored_t xend_t:process sigchld;
+allow xenstored_t xend_t:fifo_file write;
+allow xenstored_t xend_device_t:chr_file create_file_perms;
+
+# pid file
+allow xenstored_t xenstored_var_run_t:file manage_file_perms;
+allow xenstored_t xenstored_var_run_t:sock_file manage_file_perms;
+allow xenstored_t xenstored_var_run_t:dir rw_dir_perms;
+
+# var/lib files for xenstored
+allow xenstored_t xenstored_var_lib_t:file create_file_perms;
+allow xenstored_t xenstored_var_lib_t:sock_file create_file_perms;
+allow xenstored_t xenstored_var_lib_t:dir create_dir_perms;
+
+dev_create_generic_dirs(xenstored_t)
+dev_filetrans(xenstored_t, xend_device_t, chr_file)
+
+files_pid_filetrans(xenstored_t,xenstored_var_run_t, { file sock_file })
+files_var_lib_filetrans(xenstored_t,xenstored_var_lib_t,{ file dir sock_file })
+files_search_etc(xenstored_t)
+
+init_use_fds(xenstored_t)
+
+kernel_write_xen_state(xenstored_t)
+kernel_read_xen_state(xenstored_t)
+
+libs_use_ld_so(xenstored_t)
+libs_use_shared_libs(xenstored_t)
+
+miscfiles_read_localization(xenstored_t)
+
+term_dontaudit_use_generic_ptys(xenstored_t)
+
+xend_append_log(xenstored_t)
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/Rules.modular serefpolicy-2.2.23/Rules.modular
--- nsaserefpolicy/Rules.modular	2006-02-17 14:46:10.000000000 -0500
+++ serefpolicy-2.2.23/Rules.modular	2006-03-07 13:42:37.000000000 -0500
@@ -204,7 +204,7 @@
 #
 $(APPDIR)/customizable_types: $(BASE_CONF)
 	@mkdir -p $(APPDIR)
-	$(verbose) grep "^type .*customizable" $< | cut -d',' -f1 | cut -d' ' -f2 > $(TMPDIR)/customizable_types
+	$(verbose)  grep '^[^[:print:]]*type .*customizable' $< | cut -d',' -f1 | cut -d' ' -f2 | sort -u > $(TMPDIR)/customizable_types
 	$(verbose) install -m 644 $(TMPDIR)/customizable_types $@ 
 
 ########################################

--------------070102050109030205020908--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3ECMpoG026374
	for <selinux@tycho.nsa.gov>; Fri, 14 Apr 2006 08:22:51 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3ECMoZb011978
	for <selinux@tycho.nsa.gov>; Fri, 14 Apr 2006 12:22:50 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6) with ESMTP id k3ECNIZB008162
	for <selinux@tycho.nsa.gov>; Fri, 14 Apr 2006 08:23:18 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6/Submit) id k3ECNIGP008161
	for selinux@tycho.nsa.gov; Fri, 14 Apr 2006 08:23:18 -0400
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3EC8hXA026160
	for <selinux@tycho.nsa.gov>; Fri, 14 Apr 2006 08:08:43 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3EC8fZb010048
	for <selinux@tycho.nsa.gov>; Fri, 14 Apr 2006 12:08:41 GMT
Message-ID: <443F90CB.6080208@redhat.com>
Date: Fri, 14 Apr 2006 08:08:43 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>, Russell Coker <rcoker@redhat.com>
Subject: Latest patches.
Content-Type: multipart/mixed;
 boundary="------------050802080202010000070504"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050802080202010000070504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is a combination of a patch from Russell and Me.

Comments added to explain MCS constraint decisions

Fixes for amanda to run as tcp

bootloader needs to read SystemHigh

make system-install-packages run as rpm

Changes to make stem compression algorithm work better.  Also some 
changes to file_context to fix sort problems.  Mainly make sure 
textrel_shlib_t always comes after shlib_t definition.

Allow usermanage to create staff user accounts

defind java as a entry_point

allow mono and unconfined_t to dbus_chat with programs running as 
initrc_t/network_manager

Fixes to allow xen to work.

mailman interaction with postfix

Fix nfs booleans to actually work

fix samba to be able to create directories in users home dirs.

fix samba to work on nfs...

Allow usermanage to create the homedir













--------------050802080202010000070504
Content-Type: text/x-patch;
 name="policy-20060411.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-20060411.patch"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/mcs serefpolicy-2.2.31/policy/mcs
--- nsaserefpolicy/policy/mcs	2006-03-29 11:23:41.000000000 -0500
+++ serefpolicy-2.2.31/policy/mcs	2006-04-13 12:53:30.000000000 -0400
@@ -134,14 +134,18 @@
 # the high range of the file.  We use the high range of the process so
 # that processes can always simply run at s0.
 #
-# Only files are constrained by MCS at this stage.
+# Note that getattr on files is always permitted.
 #
 mlsconstrain file { write setattr append unlink link rename ioctl lock execute relabelfrom }
 	( h1 dom h2 );
 
+# New filesystem object labels must be dominated by the relabeling subject
+# clearance, also the objects are single-level.
 mlsconstrain file { create relabelto }
 	(( h1 dom h2 ) and ( l2 eq h2 ));
 
+# At this time we do not restrict "ps" type operations via MCS.  This
+# will probably change in future.
 mlsconstrain file { read }
 	(( h1 dom h2 ) or ( t2 == domain ) or ( t1 == mlsfileread ));
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/amanda.te serefpolicy-2.2.31/policy/modules/admin/amanda.te
--- nsaserefpolicy/policy/modules/admin/amanda.te	2006-03-24 11:15:40.000000000 -0500
+++ serefpolicy-2.2.31/policy/modules/admin/amanda.te	2006-04-13 12:53:30.000000000 -0400
@@ -9,6 +9,7 @@
 type amanda_t;
 type amanda_inetd_exec_t;
 inetd_udp_service_domain(amanda_t,amanda_inetd_exec_t)
+inetd_tcp_service_domain(amanda_t,amanda_inetd_exec_t)
 role system_r types amanda_t;
 
 type amanda_exec_t;
@@ -183,13 +184,15 @@
 
 optional_policy(`
 	nscd_socket_use(amanda_t)
+	nscd_socket_use(amanda_recover_t)
 ')
 
 ########################################
 #
 # Amanda recover local policy
 
-allow amanda_recover_t self:capability { fowner fsetid kill setgid setuid chown dac_override net_bind_service };
+allow amanda_recover_t self:capability { fowner fsetid kill setgid setuid chown dac_override };
+corenet_tcp_bind_reserved_port(amanda_recover_t)
 allow amanda_recover_t self:process { sigkill sigstop signal };
 allow amanda_recover_t self:fifo_file { getattr ioctl read write };
 allow amanda_recover_t self:unix_stream_socket { connect create read write };
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/bootloader.te serefpolicy-2.2.31/policy/modules/admin/bootloader.te
--- nsaserefpolicy/policy/modules/admin/bootloader.te	2006-04-04 18:06:37.000000000 -0400
+++ serefpolicy-2.2.31/policy/modules/admin/bootloader.te	2006-04-13 12:53:30.000000000 -0400
@@ -84,6 +84,7 @@
 dev_read_sysfs(bootloader_t)
 # for reading BIOS data
 dev_read_raw_memory(bootloader_t)
+mls_file_read_up(bootloader_t)
 
 fs_getattr_xattr_fs(bootloader_t)
 fs_read_tmpfs_symlinks(bootloader_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/rpm.fc serefpolicy-2.2.31/policy/modules/admin/rpm.fc
--- nsaserefpolicy/policy/modules/admin/rpm.fc	2006-04-04 18:06:37.000000000 -0400
+++ serefpolicy-2.2.31/policy/modules/admin/rpm.fc	2006-04-13 12:53:30.000000000 -0400
@@ -10,6 +10,7 @@
 /usr/lib(64)?/rpm/rpmv		-- 	gen_context(system_u:object_r:bin_t,s0)
 
 /usr/share/yumex/yumex		--	gen_context(system_u:object_r:rpm_exec_t,s0)
+/usr/sbin/system-install-packages --	gen_context(system_u:object_r:rpm_exec_t,s0)
 
 ifdef(`distro_redhat', `
 /usr/bin/fedora-rmdevelrpms	--	gen_context(system_u:object_r:rpm_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/su.fc serefpolicy-2.2.31/policy/modules/admin/su.fc
--- nsaserefpolicy/policy/modules/admin/su.fc	2006-03-23 14:33:29.000000000 -0500
+++ serefpolicy-2.2.31/policy/modules/admin/su.fc	2006-04-13 12:53:30.000000000 -0400
@@ -1,5 +1,5 @@
 
 /bin/su			--	gen_context(system_u:object_r:su_exec_t,s0)
 
-/usr(/local)?/bin/ksu	--	gen_context(system_u:object_r:su_exec_t,s0)
+/usr/(local/)?bin/ksu	--	gen_context(system_u:object_r:su_exec_t,s0)
 /usr/bin/kdesu		--	gen_context(system_u:object_r:su_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/usermanage.te serefpolicy-2.2.31/policy/modules/admin/usermanage.te
--- nsaserefpolicy/policy/modules/admin/usermanage.te	2006-04-04 18:06:38.000000000 -0400
+++ serefpolicy-2.2.31/policy/modules/admin/usermanage.te	2006-04-13 12:53:30.000000000 -0400
@@ -514,6 +514,7 @@
 # Add/remove user home directories
 userdom_home_filetrans_generic_user_home_dir(useradd_t)
 userdom_manage_generic_user_home_content_dirs(useradd_t)
+userdom_manage_staff_home_dir(useradd_t)
 userdom_generic_user_home_dir_filetrans_generic_user_home_content(useradd_t,notdevfile_class_set)
 
 mta_manage_spool(useradd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/java.fc serefpolicy-2.2.31/policy/modules/apps/java.fc
--- nsaserefpolicy/policy/modules/apps/java.fc	2006-04-12 13:44:36.000000000 -0400
+++ serefpolicy-2.2.31/policy/modules/apps/java.fc	2006-04-13 16:12:57.000000000 -0400
@@ -1,11 +1,8 @@
 #
-# /opt
-#
-/opt(/.*)?/bin/java.* 	--	gen_context(system_u:object_r:java_exec_t,s0)
-
-#
 # /usr
 #
-/usr(/.*)?/bin/java.* 	--	gen_context(system_u:object_r:java_exec_t,s0)
+/usr/(.*/)?bin/java.* 	--	gen_context(system_u:object_r:java_exec_t,s0)
+/usr/lib(.*/)?bin/java([^/]*)? 	--	gen_context(system_u:object_r:java_exec_t,s0)
 /usr/bin/gcj-dbtool	--	gen_context(system_u:object_r:java_exec_t,s0)
 /usr/bin/gij		--	gen_context(system_u:object_r:java_exec_t,s0)
+/opt/(.*/)?bin/java([^/]*)? 	--	gen_context(system_u:object_r:java_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/java.te serefpolicy-2.2.31/policy/modules/apps/java.te
--- nsaserefpolicy/policy/modules/apps/java.te	2006-04-12 13:44:36.000000000 -0400
+++ serefpolicy-2.2.31/policy/modules/apps/java.te	2006-04-13 15:36:02.000000000 -0400
@@ -10,6 +10,7 @@
 domain_type(java_t)
 
 type java_exec_t;
+init_system_domain(java_t,java_exec_t)
 files_type(java_exec_t)
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/mono.te serefpolicy-2.2.31/policy/modules/apps/mono.te
--- nsaserefpolicy/policy/modules/apps/mono.te	2006-04-12 13:44:36.000000000 -0400
+++ serefpolicy-2.2.31/policy/modules/apps/mono.te	2006-04-13 16:32:05.000000000 -0400
@@ -22,6 +22,8 @@
 	unconfined_domain_noaudit(mono_t)
 	role system_r types mono_t;
 
+	init_dbus_chat_script(mono_t)
+
 	optional_policy(`
 		avahi_dbus_chat(mono_t)
 	')
@@ -29,4 +31,8 @@
 	optional_policy(`
 		hal_dbus_chat(mono_t)
 	')
+	optional_policy(`
+		networkmanager_dbus_chat(mono_t)
+	')
+
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/corecommands.fc serefpolicy-2.2.31/policy/modules/kernel/corecommands.fc
--- nsaserefpolicy/policy/modules/kernel/corecommands.fc	2006-04-10 17:05:08.000000000 -0400
+++ serefpolicy-2.2.31/policy/modules/kernel/corecommands.fc	2006-04-13 14:39:12.000000000 -0400
@@ -2,7 +2,8 @@
 #
 # /bin
 #
-/bin(/.*)?				gen_context(system_u:object_r:bin_t,s0)
+/bin				-d	gen_context(system_u:object_r:bin_t,s0)
+/bin/.*					gen_context(system_u:object_r:bin_t,s0)
 /bin/d?ash			--	gen_context(system_u:object_r:shell_exec_t,s0)
 /bin/bash			--	gen_context(system_u:object_r:shell_exec_t,s0)
 /bin/bash2			--	gen_context(system_u:object_r:shell_exec_t,s0)
@@ -86,27 +87,30 @@
 #
 # /sbin
 #
-/sbin(/.*)?				gen_context(system_u:object_r:sbin_t,s0)
+/sbin				-d	gen_context(system_u:object_r:sbin_t,s0)
+/sbin/.*				gen_context(system_u:object_r:sbin_t,s0)
 /sbin/mkfs\.cramfs		--	gen_context(system_u:object_r:sbin_t,s0)
 /sbin/insmod_ksymoops_clean	--	gen_context(system_u:object_r:sbin_t,s0)
 
 #
 # /opt
 #
-/opt(/.*)?/bin(/.*)?			gen_context(system_u:object_r:bin_t,s0)
+/opt/(.*/)?bin(/.*)?			gen_context(system_u:object_r:bin_t,s0)
 
-/opt(/.*)?/libexec(/.*)?		gen_context(system_u:object_r:bin_t,s0)
+/opt/(.*/)?libexec(/.*)?		gen_context(system_u:object_r:bin_t,s0)
 
-/opt(/.*)?/sbin(/.*)?			gen_context(system_u:object_r:sbin_t,s0)
+/opt/(.*/)?sbin(/.*)?			gen_context(system_u:object_r:sbin_t,s0)
 
 #
 # /usr
 #
-/usr(/.*)?/Bin(/.*)?			gen_context(system_u:object_r:bin_t,s0)
+/usr/(.*/)?Bin(/.*)?			gen_context(system_u:object_r:bin_t,s0)
 
-/usr(/.*)?/bin(/.*)?			gen_context(system_u:object_r:bin_t,s0)
+/usr/(.*/)?bin(/.*)?			gen_context(system_u:object_r:bin_t,s0)
+/usr/lib(.*/)?bin(/.*)?			gen_context(system_u:object_r:bin_t,s0)
 
-/usr(/.*)?/sbin(/.*)?			gen_context(system_u:object_r:sbin_t,s0)
+/usr/(.*/)?sbin(/.*)?			gen_context(system_u:object_r:sbin_t,s0)
+/usr/lib(.*/)?sbin(/.*)?		gen_context(system_u:object_r:sbin_t,s0)
 
 /usr/lib/ccache/bin(/.*)?		gen_context(system_u:object_r:bin_t,s0)
 /usr/lib/pgsql/test/regress/.*\.sh --	gen_context(system_u:object_r:bin_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/devices.fc serefpolicy-2.2.31/policy/modules/kernel/devices.fc
--- nsaserefpolicy/policy/modules/kernel/devices.fc	2006-04-12 13:44:36.000000000 -0400
+++ serefpolicy-2.2.31/policy/modules/kernel/devices.fc	2006-04-13 12:53:30.000000000 -0400
@@ -1,5 +1,6 @@
 
-/dev(/.*)?			gen_context(system_u:object_r:device_t,s0)
+/dev			-d	gen_context(system_u:object_r:device_t,s0)
+/dev/.*				gen_context(system_u:object_r:device_t,s0)
 
 /dev/.*mouse.*		-c	gen_context(system_u:object_r:mouse_device_t,s0)
 /dev/adsp		-c	gen_context(system_u:object_r:sound_device_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/devices.if serefpolicy-2.2.31/policy/modules/kernel/devices.if
--- nsaserefpolicy/policy/modules/kernel/devices.if	2006-04-12 13:44:36.000000000 -0400
+++ serefpolicy-2.2.31/policy/modules/kernel/devices.if	2006-04-13 12:53:30.000000000 -0400
@@ -2701,7 +2701,7 @@
 	')
 
 	allow $1 device_t:dir r_dir_perms;
-	allow $1 xen_device_t:chr_file r_file_perms;
+	allow $1 xen_device_t:chr_file rw_file_perms;
 ')
 
 ########################################
@@ -2720,7 +2720,7 @@
 	')
 
 	allow $1 device_t:dir r_dir_perms;
-	allow $1 xen_device_t:chr_file r_file_perms;
+	allow $1 xen_device_t:chr_file manage_file_perms;
 ')
 
 ########################################
@@ -2874,3 +2874,23 @@
 
 	typeattribute $1 devices_unconfined_type;
 ')
+
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
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/files.fc serefpolicy-2.2.31/policy/modules/kernel/files.fc
--- nsaserefpolicy/policy/modules/kernel/files.fc	2006-03-23 14:33:29.000000000 -0500
+++ serefpolicy-2.2.31/policy/modules/kernel/files.fc	2006-04-13 12:53:30.000000000 -0400
@@ -25,7 +25,8 @@
 #
 # /boot
 #
-/boot(/.*)?			gen_context(system_u:object_r:boot_t,s0)
+/boot			-d	gen_context(system_u:object_r:boot_t,s0)
+/boot/.*			gen_context(system_u:object_r:boot_t,s0)
 /boot/\.journal			<<none>>
 /boot/lost\+found	-d	gen_context(system_u:object_r:lost_found_t,s15:c0.c255)
 /boot/lost\+found/.*		<<none>>
@@ -36,13 +37,15 @@
 #
 
 ifdef(`distro_redhat',`
-/emul(/.*)?			gen_context(system_u:object_r:usr_t,s0)
+/emul			-d	gen_context(system_u:object_r:usr_t,s0)
+/emul/.*			gen_context(system_u:object_r:usr_t,s0)
 ')
 
 #
 # /etc
 #
-/etc(/.*)?			gen_context(system_u:object_r:etc_t,s0)
+/etc			-d	gen_context(system_u:object_r:etc_t,s0)
+/etc/.*				gen_context(system_u:object_r:etc_t,s0)
 /etc/\.fstab\.hal\..+	--	gen_context(system_u:object_r:etc_runtime_t,s0)
 /etc/asound\.state	--	gen_context(system_u:object_r:etc_runtime_t,s0)
 /etc/blkid(/.*)?		gen_context(system_u:object_r:etc_runtime_t,s0)
@@ -104,7 +107,8 @@
 #
 # /lib(64)?
 #
-/lib(64)?/modules(/.*)?		gen_context(system_u:object_r:modules_object_t,s0)
+/lib/modules(/.*)?		gen_context(system_u:object_r:modules_object_t,s0)
+/lib64/modules(/.*)?		gen_context(system_u:object_r:modules_object_t,s0)
 
 #
 # /lost+found
@@ -139,29 +143,34 @@
 #
 # /opt
 #
-/opt(/.*)?			gen_context(system_u:object_r:usr_t,s0)
+/opt			-d	gen_context(system_u:object_r:usr_t,s0)
+/opt/.*				gen_context(system_u:object_r:usr_t,s0)
 
-/opt(/.*)?/var/lib(64)?(/.*)?	gen_context(system_u:object_r:var_lib_t,s0)
+/opt/(.*/)?var/lib(64)?(/.*)?	gen_context(system_u:object_r:var_lib_t,s0)
 
 #
 # /proc
 #
-/proc(/.*)?                     <<none>>
+/proc			-d	<<none>>
+/proc/.*			<<none>>
 
 #
 # /selinux
 #
-/selinux(/.*)?                  <<none>>
+/selinux		-d	<<none>>
+/selinux/.*			<<none>>
 
 #
 # /srv
 #
-/srv(/.*)?			gen_context(system_u:object_r:var_t,s0)
+/srv			-d	gen_context(system_u:object_r:var_t,s0)
+/srv/.*				gen_context(system_u:object_r:var_t,s0)
 
 #
 # /sys
 #
-/sys(/.*)?                      <<none>>
+/sys			-d	<<none>>
+/sys/.*				<<none>>
 
 #
 # /tmp
@@ -176,7 +185,8 @@
 #
 # /usr
 #
-/usr(/.*)?			gen_context(system_u:object_r:usr_t,s0)
+/usr			-d	gen_context(system_u:object_r:usr_t,s0)
+/usr/.*				gen_context(system_u:object_r:usr_t,s0)
 /usr/\.journal			<<none>>
 
 /usr/doc(/.*)?/lib(/.*)?		gen_context(system_u:object_r:usr_t,s0)
@@ -200,7 +210,7 @@
 /usr/share(/.*)?/lib(64)?(/.*)?	gen_context(system_u:object_r:usr_t,s0)
 
 /usr/src(/.*)?			gen_context(system_u:object_r:src_t,s0)
-/usr/src(/.*)?/lib(/.*)?		gen_context(system_u:object_r:usr_t,s0)
+/usr/src/kernels/.+/lib(/.*)?		gen_context(system_u:object_r:usr_t,s0)
 
 /usr/tmp			-d	gen_context(system_u:object_r:tmp_t,s0-s15:c0.c255)
 /usr/tmp/.*			<<none>>
@@ -208,7 +218,8 @@
 #
 # /var
 #
-/var(/.*)?			gen_context(system_u:object_r:var_t,s0)
+/var			-d	gen_context(system_u:object_r:var_t,s0)
+/var/.*				gen_context(system_u:object_r:var_t,s0)
 /var/\.journal			<<none>>
 
 /var/db/.*\.db		--	gen_context(system_u:object_r:etc_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/files.if serefpolicy-2.2.31/policy/modules/kernel/files.if
--- nsaserefpolicy/policy/modules/kernel/files.if	2006-04-10 17:05:10.000000000 -0400
+++ serefpolicy-2.2.31/policy/modules/kernel/files.if	2006-04-13 12:53:30.000000000 -0400
@@ -948,6 +948,18 @@
 
 ########################################
 #
+# files_stat_all_mountpoints(domain)
+#
+interface(`files_stat_all_mountpoints',`
+	gen_require(`
+		attribute mountpoint;
+	')
+
+	allow $1 mountpoint:dir { getattr };
+')
+
+########################################
+#
 # files_list_root(domain)
 #
 interface(`files_list_root',`
@@ -1661,6 +1673,21 @@
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
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/kernel.if serefpolicy-2.2.31/policy/modules/kernel/kernel.if
--- nsaserefpolicy/policy/modules/kernel/kernel.if	2006-04-10 17:05:10.000000000 -0400
+++ serefpolicy-2.2.31/policy/modules/kernel/kernel.if	2006-04-13 15:25:54.000000000 -0400
@@ -1148,7 +1148,8 @@
 
 	allow $1 proc_t:dir search;
 	allow $1 sysctl_t:dir r_dir_perms;
-	allow $1 sysctl_vm_t:dir list_dir_perms;
+#hal needs allow hald_t sysctl_vm_t:dir write;
+	allow $1 sysctl_vm_t:dir rw_dir_perms;
 	allow $1 sysctl_vm_t:file rw_file_perms;
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/mcs.te serefpolicy-2.2.31/policy/modules/kernel/mcs.te
--- nsaserefpolicy/policy/modules/kernel/mcs.te	2006-04-04 18:06:38.000000000 -0400
+++ serefpolicy-2.2.31/policy/modules/kernel/mcs.te	2006-04-13 12:53:30.000000000 -0400
@@ -32,6 +32,10 @@
 type xdm_exec_t;
 
 ifdef(`enable_mcs',`
+# The eventual plan is to have a range_transition to s0 for the daemon by
+# default and have the daemons which need to run with all categories be
+# exceptions.  But while range_transitions have to be in the base module
+# this is not possible.
 range_transition getty_t login_exec_t s0 - s0:c0.c255;
 range_transition init_t xdm_exec_t s0 - s0:c0.c255;
 range_transition initrc_t crond_exec_t s0 - s0:c0.c255;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/mls.te serefpolicy-2.2.31/policy/modules/kernel/mls.te
--- nsaserefpolicy/policy/modules/kernel/mls.te	2006-03-07 10:31:09.000000000 -0500
+++ serefpolicy-2.2.31/policy/modules/kernel/mls.te	2006-04-13 12:53:30.000000000 -0400
@@ -60,6 +60,7 @@
 
 ifdef(`enable_mls',`
 range_transition initrc_t auditd_exec_t s15:c0.c255;
+range_transition secadm_t auditctl_exec_t s15:c0.c255;
 range_transition kernel_t init_exec_t s0 - s15:c0.c255;
 range_transition kernel_t lvm_exec_t s0 - s15:c0.c255;
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/avahi.te serefpolicy-2.2.31/policy/modules/services/avahi.te
--- nsaserefpolicy/policy/modules/services/avahi.te	2006-03-24 11:15:50.000000000 -0500
+++ serefpolicy-2.2.31/policy/modules/services/avahi.te	2006-04-13 16:17:29.000000000 -0400
@@ -92,6 +92,7 @@
 	dbus_system_bus_client_template(avahi,avahi_t)
 	dbus_connect_system_bus(avahi_t)
 	dbus_send_system_bus(avahi_t)
+	init_dbus_chat_script(avahi_t)
 ')
 
 optional_policy(`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/bind.fc serefpolicy-2.2.31/policy/modules/services/bind.fc
--- nsaserefpolicy/policy/modules/services/bind.fc	2006-01-16 17:04:24.000000000 -0500
+++ serefpolicy-2.2.31/policy/modules/services/bind.fc	2006-04-13 12:53:30.000000000 -0400
@@ -29,6 +29,7 @@
 
 ifdef(`distro_redhat',`
 /etc/named\.conf		--	gen_context(system_u:object_r:named_conf_t,s0)
+/etc/named\.caching-nameserver\.conf		--	gen_context(system_u:object_r:named_conf_t,s0)
 /var/named(/.*)?			gen_context(system_u:object_r:named_zone_t,s0)
 /var/named/slaves(/.*)?		gen_context(system_u:object_r:named_cache_t,s0)
 /var/named/data(/.*)?		gen_context(system_u:object_r:named_cache_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/hal.te serefpolicy-2.2.31/policy/modules/services/hal.te
--- nsaserefpolicy/policy/modules/services/hal.te	2006-04-12 13:44:37.000000000 -0400
+++ serefpolicy-2.2.31/policy/modules/services/hal.te	2006-04-13 12:53:30.000000000 -0400
@@ -103,6 +103,7 @@
 fs_getattr_all_fs(hald_t)
 fs_search_all(hald_t)
 fs_list_auto_mountpoints(hald_t)
+files_stat_all_mountpoints(hald_t)
 
 mls_file_read_up(hald_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/kerberos.fc serefpolicy-2.2.31/policy/modules/services/kerberos.fc
--- nsaserefpolicy/policy/modules/services/kerberos.fc	2005-10-06 17:29:17.000000000 -0400
+++ serefpolicy-2.2.31/policy/modules/services/kerberos.fc	2006-04-13 12:53:30.000000000 -0400
@@ -5,8 +5,8 @@
 /etc/krb5kdc/kadm5.keytab 	--	gen_context(system_u:object_r:krb5_keytab_t,s0)
 /etc/krb5kdc/principal.*		gen_context(system_u:object_r:krb5kdc_principal_t,s0)
 
-/usr(/local)?(/kerberos)?/sbin/krb5kdc -- gen_context(system_u:object_r:krb5kdc_exec_t,s0)
-/usr(/local)?(/kerberos)?/sbin/kadmind -- gen_context(system_u:object_r:kadmind_exec_t,s0)
+/usr/(local/)?(kerberos/)?sbin/krb5kdc -- gen_context(system_u:object_r:krb5kdc_exec_t,s0)
+/usr/(local/)?(kerberos/)?sbin/kadmind -- gen_context(system_u:object_r:kadmind_exec_t,s0)
 
 /usr/local/var/krb5kdc(/.*)?		gen_context(system_u:object_r:krb5kdc_conf_t,s0)
 /usr/local/var/krb5kdc/principal.*	gen_context(system_u:object_r:krb5kdc_principal_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/mailman.if serefpolicy-2.2.31/policy/modules/services/mailman.if
--- nsaserefpolicy/policy/modules/services/mailman.if	2006-03-24 11:15:50.000000000 -0500
+++ serefpolicy-2.2.31/policy/modules/services/mailman.if	2006-04-13 12:53:30.000000000 -0400
@@ -200,6 +200,44 @@
 
 #######################################
 ## <summary>
+##	Allow domain to to create mailman data files and write the directory
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`mailman_create_data_file',`
+	gen_require(`
+		type mailman_data_t;
+	')
+
+	allow $1 mailman_data_t:dir rw_dir_perms;
+	allow $1 mailman_data_t:file create_file_perms;
+')
+
+#######################################
+## <summary>
+##	Allow domain to to read mailman data files
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`mailman_read_data_file',`
+	gen_require(`
+		type mailman_data_t;
+	')
+
+	allow $1 mailman_data_t:dir search_dir_perms;
+	allow $1 mailman_data_t:file read_file_perms;
+')
+
+#######################################
+## <summary>
 ##	List the contents of mailman data directories.
 ## </summary>
 ## <param name="domain">
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/postfix.te serefpolicy-2.2.31/policy/modules/services/postfix.te
--- nsaserefpolicy/policy/modules/services/postfix.te	2006-04-04 18:06:38.000000000 -0400
+++ serefpolicy-2.2.31/policy/modules/services/postfix.te	2006-04-13 12:53:30.000000000 -0400
@@ -408,6 +408,9 @@
 
 optional_policy(`
 	mailman_domtrans_queue(postfix_pipe_t)
+#	for postalias
+	mailman_create_data_file(postfix_master_t)
+	mailman_read_data_file(postfix_local_t)
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/rpc.te serefpolicy-2.2.31/policy/modules/services/rpc.te
--- nsaserefpolicy/policy/modules/services/rpc.te	2006-03-24 11:15:50.000000000 -0500
+++ serefpolicy-2.2.31/policy/modules/services/rpc.te	2006-04-13 12:53:30.000000000 -0400
@@ -110,13 +110,13 @@
 portmap_udp_chat(nfsd_t)
 
 tunable_policy(`nfs_export_all_rw',`
-	auth_read_all_dirs_except_shadow(nfsd_t) 
 	fs_read_noxattr_fs_files(nfsd_t) 
+	auth_manage_all_files_except_shadow(nfsd_t)
 ')
 
 tunable_policy(`nfs_export_all_ro',`
-	auth_read_all_dirs_except_shadow(nfsd_t) 
 	fs_read_noxattr_fs_files(nfsd_t) 
+	auth_read_all_files_except_shadow(nfsd_t)
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/samba.if serefpolicy-2.2.31/policy/modules/services/samba.if
--- nsaserefpolicy/policy/modules/services/samba.if	2006-02-21 14:35:36.000000000 -0500
+++ serefpolicy-2.2.31/policy/modules/services/samba.if	2006-04-13 12:53:30.000000000 -0400
@@ -33,6 +33,7 @@
 	')
 
 	tunable_policy(`samba_enable_home_dirs',`
+		userdom_manage_user_home_content_dirs($1,smbd_t)
 		userdom_manage_user_home_content_files($1,smbd_t)
 		userdom_manage_user_home_content_symlinks($1,smbd_t)
 		userdom_manage_user_home_content_sockets($1,smbd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/samba.te serefpolicy-2.2.31/policy/modules/services/samba.te
--- nsaserefpolicy/policy/modules/services/samba.te	2006-04-12 13:44:37.000000000 -0400
+++ serefpolicy-2.2.31/policy/modules/services/samba.te	2006-04-13 12:53:30.000000000 -0400
@@ -333,6 +333,13 @@
 ')
 allow smbd_t mtrr_device_t:file getattr;
 
+# Support Samba sharing of NFS mount points
+bool samba_share_nfs false;
+if (samba_share_nfs) {
+fs_manage_nfs_dirs(smbd_t)
+fs_manage_nfs_files(smbd_t)
+}
+
 ########################################
 #
 # nmbd Local policy
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/tftp.fc serefpolicy-2.2.31/policy/modules/services/tftp.fc
--- nsaserefpolicy/policy/modules/services/tftp.fc	2005-10-06 17:29:17.000000000 -0400
+++ serefpolicy-2.2.31/policy/modules/services/tftp.fc	2006-04-13 12:53:30.000000000 -0400
@@ -2,4 +2,5 @@
 /usr/sbin/atftpd	--	gen_context(system_u:object_r:tftpd_exec_t,s0)
 /usr/sbin/in\.tftpd	--	gen_context(system_u:object_r:tftpd_exec_t,s0)
 
-/tftpboot(/.*)?			gen_context(system_u:object_r:tftpdir_t,s0)
+/tftpboot		-d	gen_context(system_u:object_r:tftpdir_t,s0)
+/tftpboot/.*			gen_context(system_u:object_r:tftpdir_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xserver.if serefpolicy-2.2.31/policy/modules/services/xserver.if
--- nsaserefpolicy/policy/modules/services/xserver.if	2006-04-06 15:31:54.000000000 -0400
+++ serefpolicy-2.2.31/policy/modules/services/xserver.if	2006-04-13 12:53:30.000000000 -0400
@@ -1070,3 +1070,24 @@
 
 	dontaudit $1 xdm_xserver_t:tcp_socket { read write };
 ')
+
+########################################
+## <summary>
+##	Allow read and write to
+##	a XDM X server socket.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to allow
+##	</summary>
+## </param>
+#
+interface(`xserver_rw_xdm_sockets',`
+	gen_require(`
+		type xdm_xserver_tmp_t;
+	')
+
+	allow $1 xdm_xserver_tmp_t:dir search;
+	allow $1 xdm_xserver_tmp_t:sock_file { read write };
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/authlogin.fc serefpolicy-2.2.31/policy/modules/system/authlogin.fc
--- nsaserefpolicy/policy/modules/system/authlogin.fc	2006-01-19 17:48:34.000000000 -0500
+++ serefpolicy-2.2.31/policy/modules/system/authlogin.fc	2006-04-13 12:53:30.000000000 -0400
@@ -7,7 +7,8 @@
 /etc/passwd\.lock	--	gen_context(system_u:object_r:shadow_t,s0)
 /etc/shadow.*		--	gen_context(system_u:object_r:shadow_t,s0)
 
-/lib(64)?/security/pam_krb5/pam_krb5_storetmp -- gen_context(system_u:object_r:pam_exec_t,s0)
+/lib/security/pam_krb5/pam_krb5_storetmp -- gen_context(system_u:object_r:pam_exec_t,s0)
+/lib64/security/pam_krb5/pam_krb5_storetmp -- gen_context(system_u:object_r:pam_exec_t,s0)
 
 /sbin/pam_console_apply	 --	gen_context(system_u:object_r:pam_console_exec_t,s0)
 /sbin/pam_timestamp_check --	gen_context(system_u:object_r:pam_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/daemontools.fc serefpolicy-2.2.31/policy/modules/system/daemontools.fc
--- nsaserefpolicy/policy/modules/system/daemontools.fc	2006-04-05 11:35:09.000000000 -0400
+++ serefpolicy-2.2.31/policy/modules/system/daemontools.fc	2006-04-13 12:53:30.000000000 -0400
@@ -2,7 +2,8 @@
 # /service
 #
 
-/service(/.*)?			gen_context(system_u:object_r:svc_svc_t,s0)
+/service		-d	gen_context(system_u:object_r:svc_svc_t,s0)
+/service/.*			gen_context(system_u:object_r:svc_svc_t,s0)
 
 #
 # /usr
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/fstools.te serefpolicy-2.2.31/policy/modules/system/fstools.te
--- nsaserefpolicy/policy/modules/system/fstools.te	2006-04-04 18:06:38.000000000 -0400
+++ serefpolicy-2.2.31/policy/modules/system/fstools.te	2006-04-13 12:53:30.000000000 -0400
@@ -77,6 +77,7 @@
 dev_getattr_usbfs_dirs(fsadm_t)
 # Access to /dev/mapper/control
 dev_rw_lvm_control(fsadm_t)
+dev_dontaudit_getattr_all_device_nodes(fsadm_t)
 
 fs_search_auto_mountpoints(fsadm_t)
 fs_getattr_xattr_fs(fsadm_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.te serefpolicy-2.2.31/policy/modules/system/init.te
--- nsaserefpolicy/policy/modules/system/init.te	2006-04-06 15:32:43.000000000 -0400
+++ serefpolicy-2.2.31/policy/modules/system/init.te	2006-04-13 12:53:30.000000000 -0400
@@ -352,6 +352,7 @@
 files_mounton_isid_type_dirs(initrc_t)
 files_list_default(initrc_t)
 files_mounton_default(initrc_t)
+files_unlink_boot_flag(initrc_t)
 
 libs_rw_ld_so_cache(initrc_t)
 libs_use_ld_so(initrc_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/libraries.fc serefpolicy-2.2.31/policy/modules/system/libraries.fc
--- nsaserefpolicy/policy/modules/system/libraries.fc	2006-04-12 13:44:38.000000000 -0400
+++ serefpolicy-2.2.31/policy/modules/system/libraries.fc	2006-04-13 16:25:13.000000000 -0400
@@ -24,17 +24,22 @@
 #
 # /lib(64)?
 #
-/lib(64)?(/.*)?					gen_context(system_u:object_r:lib_t,s0)
+/lib(/.*)?					gen_context(system_u:object_r:lib_t,s0)
+/lib64(/.*)?					gen_context(system_u:object_r:lib_t,s0)
 /lib(64)?/.*\.so(\.[^/]*)*		--	gen_context(system_u:object_r:shlib_t,s0)
 /lib(64)?(/.*)?/ld-[^/]*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:ld_so_t,s0)
 
 #
 # /opt
 #
-/opt(/.*)?/lib(64)?(/.*)?			gen_context(system_u:object_r:lib_t,s0)
-/opt(/.*)?/lib(64)?/.*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:shlib_t,s0)
-/opt/.*/jre.*/libdeploy.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/opt/.*/jre.*/libjvm.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/opt/(.*/)?lib(/.*)?			gen_context(system_u:object_r:lib_t,s0)
+/opt/(.*/)?lib64(/.*)?			gen_context(system_u:object_r:lib_t,s0)
+/opt/(.*/)?lib/.*\.so		--	gen_context(system_u:object_r:shlib_t,s0)
+/opt/(.*/)?lib/.*\.so\.[^/]*	--	gen_context(system_u:object_r:shlib_t,s0)
+/opt/(.*/)?lib64/.*\.so		--	gen_context(system_u:object_r:shlib_t,s0)
+/opt/(.*/)?lib64/.*\.so\.[^/]*	--	gen_context(system_u:object_r:shlib_t,s0)
+/opt/(.*/)?jre.*/libdeploy.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/opt/(.*/)?jre.*/libjvm.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 #
 # /sbin
@@ -44,18 +49,22 @@
 #
 # /usr
 #
-/usr(/.*)?/HelixPlayer/.*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/(.*/)?/HelixPlayer/.*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
-/usr(/.*)?/java/.*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr(/.*)?/java/.*\.jar			--	gen_context(system_u:object_r:shlib_t,s0)
-/usr(/.*)?/java/.*\.jsa			--	gen_context(system_u:object_r:shlib_t,s0)
+/usr/(.*/)?java/.*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/(.*/)?java/.*\.jar			--	gen_context(system_u:object_r:shlib_t,s0)
+/usr/(.*/)?java/.*\.jsa			--	gen_context(system_u:object_r:shlib_t,s0)
+
+/usr/(.*/)?lib(/.*)?			gen_context(system_u:object_r:lib_t,s0)
+/usr/(.*/)?lib64(/.*)?			gen_context(system_u:object_r:lib_t,s0)
+/usr/(.*/)?lib/.*\.so		--	gen_context(system_u:object_r:shlib_t,s0)
+/usr/(.*/)?lib/.*\.so\.[^/]*	--	gen_context(system_u:object_r:shlib_t,s0)
+/usr/(.*/)?lib64/.*\.so		--	gen_context(system_u:object_r:shlib_t,s0)
+/usr/(.*/)?lib64/.*\.so\.[^/]*	--	gen_context(system_u:object_r:shlib_t,s0)
 
-/usr(/.*)?/lib(64)?(/.*)?			gen_context(system_u:object_r:lib_t,s0)
-/usr(/.*)?/lib(64)?/.*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:shlib_t,s0)
+/usr/(.*/)?lib(64)?(/.*)?/ld-[^/]*\.so(\.[^/]*)* gen_context(system_u:object_r:ld_so_t,s0)
 
-/usr(/.*)?/lib(64)?(/.*)?/ld-[^/]*\.so(\.[^/]*)* gen_context(system_u:object_r:ld_so_t,s0)
-
-/usr(/.*)?/nvidia/.*\.so(\..*)?		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/(.*/)?nvidia/.*\.so(\..*)?		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 /usr/lib(64)?/pgsql/test/regress/.*\.so	--	gen_context(system_u:object_r:shlib_t,s0)
 
@@ -64,7 +73,7 @@
 /usr/lib(64)?/im/.*\.so.*		--	gen_context(system_u:object_r:shlib_t,s0)
 /usr/lib(64)?/iiim/.*\.so.*		--	gen_context(system_u:object_r:shlib_t,s0)
 
-/usr(/.*)?/lib(64)?(/.*)?/nvidia/.*\.so(\..*)? -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/(.*/)?lib(64)?(/.*)?/nvidia/.*\.so(\..*)? -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libsipphoneapi\.so.*	--	gen_context(system_u:object_r:texrel_shlib_t,s0)
 /usr/lib(64)?/(nvidia/)?libGL(core)?\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libGLU\.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
@@ -74,9 +83,9 @@
 /usr/lib(64)?/nvidia-graphics(-[^/]*/)?libGL(core)?\.so(\.[^/]*)*             --      	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/nvidia-graphics(-[^/]*/)?libnvidia.*\.so(\.[^/]*)*              --      	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/nvidia-graphics(-[^/]*/)?libXvMCNVIDIA\.so.*            --      	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib(64)?/vmware(.*/)?/VmPerl\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/vmware(.*/)?VmPerl\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
-/usr/(local/)?lib/wine/.*\.so  		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/(local/)?lib(64)?/wine/.*\.so  		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/(local/)?lib/libfame-.*\.so.*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/local/.*\.so(\.[^/]*)*		--	gen_context(system_u:object_r:shlib_t,s0)
 
@@ -127,7 +136,7 @@
 /usr/lib(64)?/.*/program/libsvx680li\.so --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/.*/program/libcomphelp4gcc3\.so -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/.*/program/libsoffice\.so  --	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr(/.*)?/pcsc/drivers(/.*)?/lib(cm2020|cm4000|SCR24x)\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/(.*/)?pcsc/drivers(/.*)?/lib(cm2020|cm4000|SCR24x)\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 /usr/lib(64)?/firefox.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/mozilla.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
@@ -182,13 +191,13 @@
 /usr/lib(64)?/vmware/lib(/.*)?/libgdk-x11-.*\.so.*  -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 # Java, Sun Microsystems (JPackage SRPM)
-/usr/.*/jre.*/libdeploy.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/.*/jre.*/libjvm.so			--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/(.*/)?jre.*/libdeploy.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/(.*/)?jre.*/libjvm.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
-/usr(/.*)?/intellinux/nppdf\.so		--	gen_context(system_u:object_r:texrel_shlib_t,s0)
-/usr(/.*)?/intellinux/lib/\.so		--	gen_context(system_u:object_r:texrel_shlib_t,s0)
-/usr(/.*)?/intellinux/plug_ins/.*\.api	--	gen_context(system_u:object_r:texrel_shlib_t,s0)
-/usr(/.*)?/intellinux/SPPlugins/ADMPlugin\.apl -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/(.*/)?intellinux/nppdf\.so		--	gen_context(system_u:object_r:texrel_shlib_t,s0)
+/usr/(.*/)?intellinux/lib/\.so		--	gen_context(system_u:object_r:texrel_shlib_t,s0)
+/usr/(.*/)?intellinux/plug_ins/.*\.api	--	gen_context(system_u:object_r:texrel_shlib_t,s0)
+/usr/(.*/)?intellinux/SPPlugins/ADMPlugin\.apl -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 ') dnl end distro_redhat
 
 ifdef(`distro_suse',`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/miscfiles.fc serefpolicy-2.2.31/policy/modules/system/miscfiles.fc
--- nsaserefpolicy/policy/modules/system/miscfiles.fc	2005-10-27 14:57:47.000000000 -0400
+++ serefpolicy-2.2.31/policy/modules/system/miscfiles.fc	2006-04-13 12:53:30.000000000 -0400
@@ -7,7 +7,7 @@
 #
 # /opt
 #
-/opt(/.*)?/man(/.*)?		gen_context(system_u:object_r:man_t,s0)
+/opt/(.*/)?man(/.*)?		gen_context(system_u:object_r:man_t,s0)
 
 #
 # /srv
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/modutils.fc serefpolicy-2.2.31/policy/modules/system/modutils.fc
--- nsaserefpolicy/policy/modules/system/modutils.fc	2005-10-06 17:29:17.000000000 -0400
+++ serefpolicy-2.2.31/policy/modules/system/modutils.fc	2006-04-13 12:53:30.000000000 -0400
@@ -2,9 +2,11 @@
 /etc/modules\.conf.*	--	gen_context(system_u:object_r:modules_conf_t,s0)
 /etc/modprobe\.conf.*	--	gen_context(system_u:object_r:modules_conf_t,s0)
 
-/lib(64)?/modules/[^/]+/modules\..+ -- gen_context(system_u:object_r:modules_dep_t,s0)
+/lib/modules/[^/]+/modules\..+ -- gen_context(system_u:object_r:modules_dep_t,s0)
+/lib64/modules/[^/]+/modules\..+ -- gen_context(system_u:object_r:modules_dep_t,s0)
 
-/lib(64)?/modules/modprobe\.conf -- gen_context(system_u:object_r:modules_conf_t,s0)
+/lib/modules/modprobe\.conf -- gen_context(system_u:object_r:modules_conf_t,s0)
+/lib64/modules/modprobe\.conf -- gen_context(system_u:object_r:modules_conf_t,s0)
 
 /sbin/depmod.*		--	gen_context(system_u:object_r:depmod_exec_t,s0)
 /sbin/generate-modprobe\.conf -- gen_context(system_u:object_r:update_modules_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.if serefpolicy-2.2.31/policy/modules/system/selinuxutil.if
--- nsaserefpolicy/policy/modules/system/selinuxutil.if	2006-03-29 14:18:17.000000000 -0500
+++ serefpolicy-2.2.31/policy/modules/system/selinuxutil.if	2006-04-13 15:29:28.000000000 -0400
@@ -623,7 +623,8 @@
 	')
 
 	files_search_etc($1)
-	allow $1 selinux_config_t:dir rw_dir_perms;
+	# semanage wants to rmdir 
+	allow $1 selinux_config_t:dir { rmdir rw_dir_perms };
 	allow $1 selinux_config_t:file manage_file_perms;
 	allow $1 selinux_config_t:lnk_file { getattr read };
 ')
@@ -697,8 +698,8 @@
 
 	files_search_etc($1)
 	allow $1 selinux_config_t:dir search;
-	allow $1 file_context_t:dir r_dir_perms;
-	allow $1 file_context_t:file rw_file_perms;
+	allow $1 file_context_t:dir rw_dir_perms;
+	allow $1 file_context_t:file create_file_perms;
 	allow $1 file_context_t:lnk_file { getattr read };
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.te serefpolicy-2.2.31/policy/modules/system/unconfined.te
--- nsaserefpolicy/policy/modules/system/unconfined.te	2006-04-12 13:44:38.000000000 -0400
+++ serefpolicy-2.2.31/policy/modules/system/unconfined.te	2006-04-13 15:21:35.000000000 -0400
@@ -64,6 +64,8 @@
 	optional_policy(`
 		dbus_stub(unconfined_t)
 
+		init_dbus_chat_script(unconfined_t)
+
 		optional_policy(`
 			avahi_dbus_chat(unconfined_t)
 		')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.if serefpolicy-2.2.31/policy/modules/system/userdomain.if
--- nsaserefpolicy/policy/modules/system/userdomain.if	2006-04-11 16:58:42.000000000 -0400
+++ serefpolicy-2.2.31/policy/modules/system/userdomain.if	2006-04-13 12:53:30.000000000 -0400
@@ -4132,11 +4132,31 @@
 		type user_home_dir_t;
 	')
 
+	allow $1 user_home_dir_t:dir create_dir_perms;
 	files_home_filetrans($1,user_home_dir_t,dir)
 ')
 
 ########################################
 ## <summary>
+##	Create staff home directories
+##	with automatic file type transition.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`userdom_manage_staff_home_dir',`
+	gen_require(`
+		type staff_home_dir_t;
+	')
+
+	allow $1 staff_home_dir_t:dir create_dir_perms;
+')
+
+########################################
+## <summary>
 ##	Search generic user home directories.
 ## </summary>
 ## <param name="domain">
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/xen.te serefpolicy-2.2.31/policy/modules/system/xen.te
--- nsaserefpolicy/policy/modules/system/xen.te	2006-03-23 14:33:30.000000000 -0500
+++ serefpolicy-2.2.31/policy/modules/system/xen.te	2006-04-13 12:53:30.000000000 -0400
@@ -19,6 +19,8 @@
 # var/lib files
 type xend_var_lib_t;
 files_type(xend_var_lib_t)
+# for mounting an NFS store
+files_mountpoint(xend_var_lib_t)
 
 # log files
 type xend_var_log_t;
@@ -67,6 +69,8 @@
 allow xend_t self:tcp_socket create_stream_socket_perms;
 allow xend_t self:packet_socket create_socket_perms;
 
+files_read_kernel_symbol_table(xend_t)
+
 # pid file
 allow xend_t xend_var_run_t:file manage_file_perms;
 allow xend_t xend_var_run_t:sock_file manage_file_perms;
@@ -210,6 +214,7 @@
 dev_filetrans_xen(xenstored_t)
 
 term_dontaudit_use_generic_ptys(xenstored_t)
+dev_rw_xen(xenstored_t)
 
 init_use_fds(xenstored_t)
 

--------------050802080202010000070504--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

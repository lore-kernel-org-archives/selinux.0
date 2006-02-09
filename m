Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k19IdPXf027786
	for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2006 13:39:25 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k19Ic67q015666
	for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2006 18:38:06 GMT
Message-ID: <43EB8C6D.7060809@redhat.com>
Date: Thu, 09 Feb 2006 13:39:41 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Latest diffs
Content-Type: multipart/mixed;
 boundary="------------020403070102080603040002"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020403070102080603040002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Update build.conf to match what I believe should be the defaults.

Add some of Russell's mcs changes

Kudzu wants to check write access to removable devices

Prelink needs to execute_no_trans ld_so_t

dontaudit readahear reading ramfs file systems

su.if had some cut and paste errors

bootloader wants to ioctl fifo_file and read sysfs files

Added bgp port for Zebra

Additiona usb devices (per russell)

Added
+/usr/doc(/.*)?/lib(/.*)?       gen_context(system_u:object_r:usr_t,s0)
+/usr/src(/.*)?/lib(/.*)?       gen_context(system_u:object_r:usr_t,s0)

So labeling of these directories would not end up lib_t.

files.if had a cut and paste error

udev wants to read inotifyfs directory

Added cacti directories for httpd

automount creates tmp directories in / that hal wants to look at.

fetchmail wants to ps all processes.

hal continuously wants more privs...


mta/sendmail wants to read postfix config and spools.

NetworkManager needs to be able to create directory for wpa_supplicant

postfix_postdrop_t needs to be able to resolve

Made some changes to turn on polyinstatiation.

Spamd wants to talk to razor and ldap.

zebra needs to connect to its own tcp_socket

audit daemon needs sigpgid
auditctl needs to output to  terminals.

unconfined daemon needs to be able to create and setattr on its own 
fifo_files

make fstools and mount work from unconfined_t

sysadm needs to be able to run init in order to change runlevel

secadm needs to be able to run dmesg













--------------020403070102080603040002
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/build.conf serefpolicy-2.2.12/build.conf
--- nsaserefpolicy/build.conf	2006-01-26 16:54:24.000000000 -0500
+++ serefpolicy-2.2.12/build.conf	2006-02-08 11:43:58.000000000 -0500
@@ -8,13 +8,13 @@
 # version policy it supports.  Setting this will
 # override the version.  This only has an
 # effect for monolithic policies.
-#OUTPUT_POLICY = 18
+#OUTPUT_POLICY = 20
 
 # Policy Type
 # strict, targeted,
 # strict-mls, targeted-mls,
 # strict-mcs, targeted-mcs
-TYPE = strict
+TYPE = strict-mcs
 
 # Policy Name
 # If set, this will be used as the policy
@@ -40,7 +40,7 @@
 
 # Build monolithic policy.  Putting n here
 # will build a loadable module policy.
-MONOLITHIC=y
+MONOLITHIC=n
 
 # Polyinstantiation
 # Enable polyinstantiated directory support.
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/mcs serefpolicy-2.2.12/policy/mcs
--- nsaserefpolicy/policy/mcs	2006-01-09 11:32:53.000000000 -0500
+++ serefpolicy-2.2.12/policy/mcs	2006-02-08 11:43:58.000000000 -0500
@@ -137,15 +137,24 @@
 # Only files are constrained by MCS at this stage.
 #
 mlsconstrain file { write setattr append unlink link rename
-		    create ioctl lock execute } (h1 dom h2);
+		    ioctl lock execute relabelfrom } (h1 dom h2);
+
+mlsconstrain file { create relabelto } ((h1 dom h2) and (l2 eq h2));
 
 mlsconstrain file { read } ((h1 dom h2) or 
 			    ( t1 == mlsfileread ));
 
 
 # new file labels must be dominated by the relabeling subject clearance
-mlsconstrain { dir file lnk_file chr_file blk_file sock_file fifo_file } { relabelfrom relabelto }
+mlsconstrain { dir lnk_file chr_file blk_file sock_file fifo_file } { relabelfrom }
 	( h1 dom h2 );
+mlsconstrain { dir lnk_file chr_file blk_file sock_file fifo_file } { create relabelto }
+	(( h1 dom h2 ) and ( l2 eq h2 ));
+
+mlsconstrain process { ptrace } ( h1 dom h2 );
+
+mlsconstrain process { sigkill sigstop } ( h1 dom h2 ) or
+		( t1 == init_t ) or ( t1 == initrc_t );
 
 define(`nogetattr_file_perms', `{ create ioctl read lock write setattr append 
 link unlink rename relabelfrom relabelto }')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/kudzu.te serefpolicy-2.2.12/policy/modules/admin/kudzu.te
--- nsaserefpolicy/policy/modules/admin/kudzu.te	2006-02-07 10:43:25.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/admin/kudzu.te	2006-02-08 11:43:58.000000000 -0500
@@ -24,7 +24,6 @@
 allow kudzu_t self:capability { dac_override sys_admin sys_rawio net_admin sys_tty_config mknod };
 dontaudit kudzu_t self:capability sys_tty_config;
 allow kudzu_t self:process { signal_perms execmem };
-auditallow kudzu_t self:process execmem; 
 allow kudzu_t self:fifo_file rw_file_perms;
 allow kudzu_t self:unix_stream_socket { connectto create_stream_socket_perms };
 allow kudzu_t self:unix_dgram_socket create_socket_perms;
@@ -72,6 +71,7 @@
 storage_read_scsi_generic(kudzu_t)
 storage_read_tape(kudzu_t)
 storage_raw_write_fixed_disk(kudzu_t)
+storage_raw_write_removable_device(kudzu_t)
 storage_raw_read_fixed_disk(kudzu_t)
 storage_raw_read_removable_device(kudzu_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/prelink.te serefpolicy-2.2.12/policy/modules/admin/prelink.te
--- nsaserefpolicy/policy/modules/admin/prelink.te	2006-02-03 08:55:52.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/admin/prelink.te	2006-02-08 11:43:58.000000000 -0500
@@ -65,6 +65,7 @@
 fs_getattr_xattr_fs(prelink_t)
 
 libs_use_ld_so(prelink_t)
+libs_execute_no_trans_ld_so(prelink_t)
 libs_manage_ld_so(prelink_t)
 libs_relabel_ld_so(prelink_t)
 libs_use_shared_libs(prelink_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/readahead.te serefpolicy-2.2.12/policy/modules/admin/readahead.te
--- nsaserefpolicy/policy/modules/admin/readahead.te	2006-02-03 08:55:52.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/admin/readahead.te	2006-02-08 11:43:58.000000000 -0500
@@ -47,7 +47,9 @@
 fs_search_auto_mountpoints(readahead_t)
 fs_getattr_all_pipes(readahead_t)
 fs_getattr_all_files(readahead_t)
-fs_search_ramfs(readahead_t)
+fs_dontaudit_search_ramfs(readahead_t)
+fs_dontaudit_read_ramfs_fifo_file(readahead_t)
+fs_dontaudit_read_ramfs_file(readahead_t)
 fs_read_tmpfs_symlinks(readahead_t)
 
 term_dontaudit_use_console(readahead_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/su.if serefpolicy-2.2.12/policy/modules/admin/su.if
--- nsaserefpolicy/policy/modules/admin/su.if	2006-02-03 08:55:52.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/admin/su.if	2006-02-08 11:43:58.000000000 -0500
@@ -23,13 +23,12 @@
 	# Transition from the user domain to this domain.
 	domain_auto_trans($2, su_exec_t, $1_su_t)
 	allow $2 $1_su_t:fd use;
-	allow $1_su_t $2:fd use;
-	allow $1_su_t $2:fifo_file rw_file_perms;
-	allow $1_su_t $2:process sigchld;
+	allow $2 $1_su_t:fifo_file rw_file_perms;
+	allow $2 $1_su_t:process sigchld;
 
 	# By default, revert to the calling domain when a shell is executed.
 	corecmd_shell_domtrans($1_su_t,$2)
-	allow $2 $1_su_t:fd use;
+	allow $1_su_t $2:fd use;
 	allow $1_su_t $2:fd use;
 	allow $1_su_t $2:fifo_file rw_file_perms;
 	allow $1_su_t $2:process sigchld;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/bootloader.te serefpolicy-2.2.12/policy/modules/kernel/bootloader.te
--- nsaserefpolicy/policy/modules/kernel/bootloader.te	2006-02-03 08:55:52.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/kernel/bootloader.te	2006-02-08 11:43:58.000000000 -0500
@@ -71,7 +71,7 @@
 
 allow bootloader_t self:capability { dac_read_search fsetid sys_rawio sys_admin mknod chown };
 allow bootloader_t self:process { sigkill sigstop signull signal };
-allow bootloader_t self:fifo_file { getattr read write };
+allow bootloader_t self:fifo_file rw_file_perms;
 
 allow bootloader_t boot_t:dir { create rw_dir_perms };
 allow bootloader_t boot_t:file create_file_perms;
@@ -110,7 +110,7 @@
 dev_dontaudit_rw_generic_dev_nodes(bootloader_t)
 dev_read_rand(bootloader_t)
 dev_read_urand(bootloader_t)
-dev_getattr_sysfs_dirs(bootloader_t)
+dev_read_sysfs(bootloader_t)
 # for reading BIOS data
 dev_read_raw_memory(bootloader_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/corenetwork.te.in serefpolicy-2.2.12/policy/modules/kernel/corenetwork.te.in
--- nsaserefpolicy/policy/modules/kernel/corenetwork.te.in	2006-01-09 11:32:53.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/kernel/corenetwork.te.in	2006-02-08 11:43:58.000000000 -0500
@@ -124,6 +124,7 @@
 network_port(uucpd, tcp,540,s0)
 network_port(vnc, tcp,5900,s0)
 network_port(xserver, tcp,6001,s0, tcp,6002,s0, tcp,6003,s0, tcp,6004,s0, tcp,6005,s0, tcp,6006,s0, tcp,6007,s0, tcp,6008,s0, tcp,6009,s0, tcp,6010,s0, tcp,6011,s0, tcp,6012,s0, tcp,6013,s0, tcp,6014,s0, tcp,6015,s0, tcp,6016,s0, tcp,6017,s0, tcp,6018,s0, tcp,6019,s0)
+network_port(bgp, tcp,179,s0, udp,179,s0)
 network_port(zebra, tcp,2601,s0)
 network_port(zope, tcp,8021,s0)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/devices.fc serefpolicy-2.2.12/policy/modules/kernel/devices.fc
--- nsaserefpolicy/policy/modules/kernel/devices.fc	2006-02-02 10:39:15.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/kernel/devices.fc	2006-02-08 11:43:58.000000000 -0500
@@ -78,6 +78,7 @@
 /dev/usb/lp.*		-c	gen_context(system_u:object_r:printer_device_t,s0)
 /dev/usb/mdc800.*	-c	gen_context(system_u:object_r:scanner_device_t,s0)
 /dev/usb/scanner.*	-c	gen_context(system_u:object_r:scanner_device_t,s0)
+/dev/bus/usb/.*/[0-9]+	-c	gen_context(system_u:object_r:usb_device_t,s0)
 
 ifdef(`distro_redhat',`
 # originally from named.fc
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/devices.te serefpolicy-2.2.12/policy/modules/kernel/devices.te
--- nsaserefpolicy/policy/modules/kernel/devices.te	2006-02-01 08:23:28.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/kernel/devices.te	2006-02-08 11:43:58.000000000 -0500
@@ -159,6 +159,11 @@
 genfscon usbfs / gen_context(system_u:object_r:usbfs_t,s0)
 genfscon usbdevfs / gen_context(system_u:object_r:usbfs_t,s0)
 
+#
+# usb_device_t is the type for /dev/bus/usb/[0-9]+/[0-9]+
+type usb_device_t;
+dev_node(usb_device_t)
+
 type v4l_device_t;
 dev_node(v4l_device_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/files.fc serefpolicy-2.2.12/policy/modules/kernel/files.fc
--- nsaserefpolicy/policy/modules/kernel/files.fc	2006-02-03 08:55:52.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/kernel/files.fc	2006-02-08 11:43:58.000000000 -0500
@@ -192,6 +192,8 @@
 /usr/share(/.*)?/lib(64)?(/.*)?	gen_context(system_u:object_r:usr_t,s0)
 
 /usr/src(/.*)?			gen_context(system_u:object_r:src_t,s0)
+/usr/doc(/.*)?/lib(/.*)?	gen_context(system_u:object_r:usr_t,s0)
+/usr/src(/.*)?/lib(/.*)?	gen_context(system_u:object_r:usr_t,s0)
 
 /usr/tmp			-d	gen_context(system_u:object_r:tmp_t,s0-s15:c0.c255)
 /usr/tmp/.*			<<none>>
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/files.if serefpolicy-2.2.12/policy/modules/kernel/files.if
--- nsaserefpolicy/policy/modules/kernel/files.if	2006-02-03 08:55:52.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/kernel/files.if	2006-02-08 11:43:58.000000000 -0500
@@ -2080,7 +2080,7 @@
 		attribute tmpfile;
 	')
 
-	allow $1 tmpfile:dir { search getattr };
+	allow $1 tmpfile:dir { search setattr };
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/filesystem.if serefpolicy-2.2.12/policy/modules/kernel/filesystem.if
--- nsaserefpolicy/policy/modules/kernel/filesystem.if	2006-02-07 10:43:26.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/kernel/filesystem.if	2006-02-08 11:43:58.000000000 -0500
@@ -929,6 +929,22 @@
 
 ########################################
 ## <summary>
+##	List inotifyfs filesystem. 
+## </summary>
+## <param name="domain">
+##	Domain allowed access.
+## </param>
+#
+interface(`fs_list_inotifyfs',`
+	gen_require(`
+		type inotifyfs_t;
+	')
+
+	allow $1 inotifyfs_t:dir r_dir_perms;
+')
+
+########################################
+## <summary>
 ##	Mount an iso9660 filesystem, which
 ##	is usually used on CDs.
 ## </summary>
@@ -1763,6 +1779,38 @@
 
 ########################################
 ## <summary>
+##	Dontaudit read on a ramfs file/fifo_file
+## </summary>
+## <param name="domain">
+##	Domain allowed access.
+## </param>
+#
+interface(`fs_dontaudit_read_ramfs_file',`
+	gen_require(`
+		type ramfs_t;
+	')
+
+	dontaudit $1 ramfs_t:file read;
+')
+
+########################################
+## <summary>
+##	Dontaudit read on a ramfs fifo_file
+## </summary>
+## <param name="domain">
+##	Domain allowed access.
+## </param>
+#
+interface(`fs_dontaudit_read_ramfs_fifo_file',`
+	gen_require(`
+		type ramfs_t;
+	')
+
+	dontaudit $1 ramfs_t:fifo_file read;
+')
+
+########################################
+## <summary>
 ##	Write to named pipe on a ramfs filesystem.
 ## </summary>
 ## <param name="domain">
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/terminal.if serefpolicy-2.2.12/policy/modules/kernel/terminal.if
--- nsaserefpolicy/policy/modules/kernel/terminal.if	2006-02-03 08:55:53.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/kernel/terminal.if	2006-02-09 07:23:31.000000000 -0500
@@ -386,7 +386,7 @@
 		type devpts_t;
 	')
 
-	dontaudit $1 devpts_t:chr_file { read write };
+	dontaudit $1 devpts_t:chr_file { getattr read write };
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/apache.fc serefpolicy-2.2.12/policy/modules/services/apache.fc
--- nsaserefpolicy/policy/modules/services/apache.fc	2006-02-07 10:43:26.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/services/apache.fc	2006-02-09 08:54:38.000000000 -0500
@@ -48,6 +48,7 @@
 /var/lib/dav(/.*)?			gen_context(system_u:object_r:httpd_var_lib_t,s0)
 /var/lib/htdig(/.*)?			gen_context(system_u:object_r:httpd_sys_content_t,s0)
 /var/lib/httpd(/.*)?			gen_context(system_u:object_r:httpd_var_lib_t,s0)
+/var/lib/cacti(/.*)?			gen_context(system_u:object_r:httpd_var_lib_t,s0)
 /var/lib/php/session(/.*)?		gen_context(system_u:object_r:httpd_var_run_t,s0)
 /var/lib/squirrelmail/prefs(/.*)?	gen_context(system_u:object_r:httpd_squirrelmail_t,s0)
 
@@ -55,6 +56,8 @@
 /var/log/apache-ssl(2)?(/.*)?		gen_context(system_u:object_r:httpd_log_t,s0)
 /var/log/cgiwrap\.log.*		--	gen_context(system_u:object_r:httpd_log_t,s0)
 /var/log/httpd(/.*)?			gen_context(system_u:object_r:httpd_log_t,s0)
+/var/log/cacti(/.*)?			gen_context(system_u:object_r:httpd_log_t,s0)
+
 ifdef(`distro_debian', `
 /var/log/horde2(/.*)?			gen_context(system_u:object_r:httpd_log_t,s0)
 ')
@@ -73,3 +76,4 @@
 /var/www/cgi-bin(/.*)?			gen_context(system_u:object_r:httpd_sys_script_exec_t,s0)
 /var/www/icons(/.*)?			gen_context(system_u:object_r:httpd_sys_content_t,s0)
 /var/www/perl(/.*)?			gen_context(system_u:object_r:httpd_sys_script_exec_t,s0)
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/automount.if serefpolicy-2.2.12/policy/modules/services/automount.if
--- nsaserefpolicy/policy/modules/services/automount.if	2005-12-12 15:35:53.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/services/automount.if	2006-02-09 07:12:23.000000000 -0500
@@ -39,3 +39,19 @@
 	corecmd_search_sbin($1)
 	can_exec($1,automount_etc_t)
 ')
+
+########################################
+## <summary>
+##	dontaudit getattr of automount tmp dir
+## </summary>
+## <param name="domain">
+##	Domain allowed access.
+## </param>
+#
+interface(`automount_dontaudit_getattr_tmp_dir',`
+	gen_require(`
+		type automount_tmp_t;
+	')
+
+	dontaudit $1 automount_tmp_t:dir getattr;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/automount.te serefpolicy-2.2.12/policy/modules/services/automount.te
--- nsaserefpolicy/policy/modules/services/automount.te	2006-02-07 10:43:26.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/services/automount.te	2006-02-08 11:43:58.000000000 -0500
@@ -63,6 +63,7 @@
 kernel_read_system_state(automount_t)
 kernel_list_proc(automount_t)
 
+bootloader_getattr_boot_dirs(automount_t)
 bootloader_search_boot(automount_t)
 
 corecmd_exec_sbin(automount_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cron.if serefpolicy-2.2.12/policy/modules/services/cron.if
--- nsaserefpolicy/policy/modules/services/cron.if	2006-02-03 15:45:55.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/services/cron.if	2006-02-08 11:43:58.000000000 -0500
@@ -407,7 +407,7 @@
 		type crond_t;
 	')
 
-	allow $1 crond_t:fifo_file { read write };
+	allow $1 crond_t:fifo_file { getattr read write };
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cron.te serefpolicy-2.2.12/policy/modules/services/cron.te
--- nsaserefpolicy/policy/modules/services/cron.te	2006-02-07 10:43:26.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/services/cron.te	2006-02-08 11:43:58.000000000 -0500
@@ -108,6 +108,7 @@
 
 corecmd_exec_shell(crond_t)
 corecmd_list_sbin(crond_t)
+corecmd_read_sbin_symlinks(crond_t)
 
 domain_use_wide_inherit_fd(crond_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/fetchmail.te serefpolicy-2.2.12/policy/modules/services/fetchmail.te
--- nsaserefpolicy/policy/modules/services/fetchmail.te	2006-02-03 08:55:53.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/services/fetchmail.te	2006-02-08 11:43:58.000000000 -0500
@@ -44,6 +44,7 @@
 kernel_list_proc(fetchmail_t)
 kernel_getattr_proc_files(fetchmail_t)
 kernel_read_proc_symlinks(fetchmail_t)
+kernel_dontaudit_read_system_state(fetchmail_t)
 
 corenet_non_ipsec_sendrecv(fetchmail_t)
 corenet_tcp_sendrecv_generic_if(fetchmail_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/hal.te serefpolicy-2.2.12/policy/modules/services/hal.te
--- nsaserefpolicy/policy/modules/services/hal.te	2006-02-07 10:43:26.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/services/hal.te	2006-02-09 07:25:33.000000000 -0500
@@ -50,6 +50,7 @@
 kernel_read_fs_sysctls(hald_t)
 kernel_write_proc_files(hald_t)
 
+bootloader_getattr_boot_dirs(hald_t)
 bootloader_search_boot(hald_t)
 
 corecmd_exec_bin(hald_t)
@@ -97,6 +98,8 @@
 
 mls_file_read_up(hald_t)
 
+modutils_domtrans_insmod_uncond(hald_t)
+
 selinux_get_fs_mount(hald_t)
 selinux_validate_context(hald_t)
 selinux_compute_access_vector(hald_t)
@@ -112,12 +115,15 @@
 term_dontaudit_use_console(hald_t)
 term_dontaudit_ioctl_unallocated_ttys(hald_t)
 term_dontaudit_use_unallocated_ttys(hald_t)
+term_dontaudit_use_generic_ptys(hald_t)
 
 init_use_fd(hald_t)
 init_use_script_ptys(hald_t)
 init_domtrans_script(hald_t)
 init_write_initctl(hald_t)
 init_read_utmp(hald_t)
+#hal runs shutdown, probably need a shutdown domain
+init_rw_utmp(hald_t)
 
 libs_use_ld_so(hald_t)
 libs_use_shared_libs(hald_t)
@@ -150,6 +156,10 @@
 	apm_stream_connect(hald_t)
 ')
 
+optional_policy(`automount', `
+	automount_dontaudit_getattr_tmp_dir(hald_t)
+')
+
 optional_policy(`bind',`
 	bind_search_cache(hald_t)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/mta.if serefpolicy-2.2.12/policy/modules/services/mta.if
--- nsaserefpolicy/policy/modules/services/mta.if	2006-02-03 15:45:55.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/services/mta.if	2006-02-08 11:43:58.000000000 -0500
@@ -434,6 +434,7 @@
 
 	allow $1 sendmail_exec_t:lnk_file r_file_perms;
 	domain_auto_trans($1, sendmail_exec_t, system_mail_t)
+	domain_entry_file($1,sendmail_exec_t)
 
 	allow $1 system_mail_t:fd use;
 	allow system_mail_t $1:fd use;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/mta.te serefpolicy-2.2.12/policy/modules/services/mta.te
--- nsaserefpolicy/policy/modules/services/mta.te	2006-02-03 15:45:55.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/services/mta.te	2006-02-08 11:43:58.000000000 -0500
@@ -145,6 +145,8 @@
 	files_getattr_tmp_dirs(system_mail_t)
 
 	postfix_exec_master(system_mail_t)
+	postfix_read_config(system_mail_t)
+	postfix_search_spool(system_mail_t)
 
 	ifdef(`distro_redhat',`
 		# compatability for old default main.cf
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/networkmanager.te serefpolicy-2.2.12/policy/modules/services/networkmanager.te
--- nsaserefpolicy/policy/modules/services/networkmanager.te	2006-02-07 10:43:26.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/services/networkmanager.te	2006-02-08 11:43:58.000000000 -0500
@@ -31,7 +31,10 @@
 
 allow NetworkManager_t NetworkManager_var_run_t:file create_file_perms;
 allow NetworkManager_t NetworkManager_var_run_t:dir rw_dir_perms;
-files_filetrans_pid(NetworkManager_t,NetworkManager_var_run_t)
+files_filetrans_pid(NetworkManager_t,NetworkManager_var_run_t, { dir file sock_file })
+
+allow NetworkManager_t NetworkManager_var_run_t:sock_file create_file_perms;
+allow NetworkManager_t NetworkManager_var_run_t:dir create_dir_perms;
 
 kernel_read_system_state(NetworkManager_t)
 kernel_read_network_state(NetworkManager_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/postfix.te serefpolicy-2.2.12/policy/modules/services/postfix.te
--- nsaserefpolicy/policy/modules/services/postfix.te	2006-02-03 08:55:54.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/services/postfix.te	2006-02-08 11:43:58.000000000 -0500
@@ -411,6 +411,9 @@
 allow postfix_postdrop_t self:capability sys_resource;
 allow postfix_postdrop_t self:tcp_socket create;
 allow postfix_postdrop_t self:udp_socket create_socket_perms;
+corenet_udp_sendrecv_all_if(postfix_postdrop_t)
+corenet_udp_sendrecv_all_nodes(postfix_postdrop_t)
+sysnet_dns_name_resolve(postfix_postdrop_t)
 
 allow postfix_postdrop_t postfix_public_t:dir search;
 allow postfix_postdrop_t postfix_public_t:fifo_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/remotelogin.te serefpolicy-2.2.12/policy/modules/services/remotelogin.te
--- nsaserefpolicy/policy/modules/services/remotelogin.te	2006-02-07 10:43:26.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/services/remotelogin.te	2006-02-08 11:43:58.000000000 -0500
@@ -98,6 +98,7 @@
 files_list_mnt(remote_login_t)
 # for when /var/mail is a sym-link
 files_read_var_symlinks(remote_login_t)
+files_polyinstantiate_all(remote_login_t)
 
 init_rw_utmp(remote_login_t)
 
@@ -164,29 +165,6 @@
 	usermanage_read_crack_db(remote_login_t)
 ')
 
-ifdef(`TODO',`
-# this goes to xdm:
-optional_policy(`remotelogin',`
-	# FIXME: what is this for?
-	remotelogin_signull(xdm_t)
+optional_policy(`alsa',`
+	alsa_domtrans(remote_login_t)
 ')
-# Login can polyinstantiate
-polyinstantiater(remote_login_t)
-
-ifdef(`alsa.te', `
-domain_auto_trans($1_login_t, alsa_exec_t, alsa_t)
-')
-
-allow remote_login_t userpty_type:chr_file { setattr write };
-allow remote_login_t ptyfile:chr_file { getattr ioctl };
-
-optional_policy(`rlogind',`
-	allow remote_login_t rlogind_devpts_t:chr_file { setattr rw_file_perms };
-	allow remote_login_t rlogind_devpts_t:chr_file { relabelfrom relabelto };
-')
-
-optional_policy(`telnetd',`
-	allow remote_login_t telnetd_devpts_t:chr_file { setattr rw_file_perms };
-	allow remote_login_t telnetd_devpts_t:chr_file { relabelfrom relabelto };
-')
-') dnl endif TODO
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/sendmail.te serefpolicy-2.2.12/policy/modules/services/sendmail.te
--- nsaserefpolicy/policy/modules/services/sendmail.te	2006-02-07 10:43:26.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/services/sendmail.te	2006-02-08 11:43:58.000000000 -0500
@@ -65,6 +65,7 @@
 
 # for piping mail to a command
 corecmd_exec_shell(sendmail_t)
+corecmd_search_sbin(sendmail_t)
 
 domain_use_wide_inherit_fd(sendmail_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/spamassassin.te serefpolicy-2.2.12/policy/modules/services/spamassassin.te
--- nsaserefpolicy/policy/modules/services/spamassassin.te	2006-02-07 10:43:26.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/services/spamassassin.te	2006-02-08 11:43:58.000000000 -0500
@@ -77,6 +77,8 @@
 # DnsResolver.pm module which binds to
 # random ports >= 1024.
 corenet_udp_bind_generic_port(spamd_t)
+corenet_tcp_connect_razor_port(spamd_t)
+sysnet_use_ldap(spamd_t)
 
 dev_read_sysfs(spamd_t)
 dev_read_urand(spamd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/zebra.te serefpolicy-2.2.12/policy/modules/services/zebra.te
--- nsaserefpolicy/policy/modules/services/zebra.te	2006-02-03 08:55:55.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/services/zebra.te	2006-02-08 11:43:58.000000000 -0500
@@ -34,7 +34,7 @@
 allow zebra_t self:unix_dgram_socket create_socket_perms;
 allow zebra_t self:unix_stream_socket { connectto create_stream_socket_perms };
 allow zebra_t self:netlink_route_socket rw_netlink_socket_perms;
-allow zebra_t self:tcp_socket connected_stream_socket_perms;
+allow zebra_t self:tcp_socket { connect connected_stream_socket_perms };
 allow zebra_t self:udp_socket create_socket_perms;
 allow zebra_t self:rawip_socket create_socket_perms;
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/fstools.te serefpolicy-2.2.12/policy/modules/system/fstools.te
--- nsaserefpolicy/policy/modules/system/fstools.te	2006-02-03 08:55:55.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/system/fstools.te	2006-02-09 07:06:48.000000000 -0500
@@ -57,6 +57,8 @@
 kernel_rw_unlabeled_dirs(fsadm_t)
 kernel_rw_unlabeled_blk_files(fsadm_t)
 
+bootloader_getattr_boot_dirs(fsadm_t)
+
 dev_getattr_all_chr_files(fsadm_t)
 # mkreiserfs and other programs need this for UUID
 dev_read_rand(fsadm_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.fc serefpolicy-2.2.12/policy/modules/system/init.fc
--- nsaserefpolicy/policy/modules/system/init.fc	2006-01-16 22:19:19.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/system/init.fc	2006-02-08 11:43:58.000000000 -0500
@@ -22,7 +22,8 @@
 #
 # /sbin
 #
-/sbin/init		--	gen_context(system_u:object_r:init_exec_t,s0)
+/sbin/init(ng)?		--	gen_context(system_u:object_r:init_exec_t,s0)
+
 
 ifdef(`distro_gentoo', `
 /sbin/rc			--	gen_context(system_u:object_r:initrc_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/libraries.if serefpolicy-2.2.12/policy/modules/system/libraries.if
--- nsaserefpolicy/policy/modules/system/libraries.if	2006-02-03 08:55:55.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/system/libraries.if	2006-02-08 11:43:58.000000000 -0500
@@ -70,6 +70,23 @@
 
 ########################################
 ## <summary>
+##	Allow domain execute_no_trans on ld_so_t
+## </summary>
+## <param name="domain">
+##	The type of the process performing this action.
+## </param>
+#
+interface(`libs_execute_no_trans_ld_so',`
+	gen_require(`
+		type ld_so_t;
+	')
+
+	files_list_etc($1)
+	allow $1 ld_so_t:file execute_no_trans;
+')
+
+########################################
+## <summary>
 ##	Use the dynamic link/loader for automatic loading
 ##	of shared libraries with legacy support.
 ## </summary>
@@ -253,6 +270,7 @@
 
 	allow $1 lib_t:dir search_dir_perms;
 	allow $1 lib_t:file manage_file_perms;
+	allow $1 lib_t:lnk_file unlink;
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/libraries.te serefpolicy-2.2.12/policy/modules/system/libraries.te
--- nsaserefpolicy/policy/modules/system/libraries.te	2006-02-07 10:43:26.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/system/libraries.te	2006-02-08 11:43:58.000000000 -0500
@@ -53,6 +53,7 @@
 
 allow ldconfig_t ld_so_cache_t:file create_file_perms;
 files_filetrans_etc(ldconfig_t,ld_so_cache_t,file)
+files_search_usr(ldconfig_t)
 
 allow ldconfig_t lib_t:dir rw_dir_perms;
 allow ldconfig_t lib_t:lnk_file { getattr create read unlink };
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/locallogin.te serefpolicy-2.2.12/policy/modules/system/locallogin.te
--- nsaserefpolicy/policy/modules/system/locallogin.te	2006-02-07 10:43:26.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/system/locallogin.te	2006-02-08 11:43:58.000000000 -0500
@@ -214,10 +214,8 @@
 	alsa_domtrans(local_login_t)
 ')
 
-ifdef(`TODO',`
 # Login can polyinstantiate
-polyinstantiater(local_login_t)
-') dnl endif TODO
+files_polyinstantiate_all(local_login_t)
 
 #################################
 # 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/logging.te serefpolicy-2.2.12/policy/modules/system/logging.te
--- nsaserefpolicy/policy/modules/system/logging.te	2006-02-03 08:55:55.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/system/logging.te	2006-02-08 11:43:58.000000000 -0500
@@ -92,6 +92,8 @@
 	term_use_unallocated_ttys(auditctl_t)
 ')
 
+term_use_all_terms(auditctl_t)
+
 ifdef(`TODO',`
 role secadm_r types auditctl_t;
 role sysadm_r types auditctl_t;
@@ -114,7 +116,7 @@
 
 allow auditd_t self:capability { audit_write audit_control sys_nice sys_resource };
 dontaudit auditd_t self:capability sys_tty_config;
-allow auditd_t self:process { signal_perms setsched };
+allow auditd_t self:process { signal_perms setpgid setsched };
 allow auditd_t self:file { getattr read write };
 allow auditd_t self:unix_dgram_socket create_socket_perms;
 allow auditd_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay nlmsg_readpriv };
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/mount.te serefpolicy-2.2.12/policy/modules/system/mount.te
--- nsaserefpolicy/policy/modules/system/mount.te	2006-02-03 08:55:55.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/system/mount.te	2006-02-08 11:43:58.000000000 -0500
@@ -33,6 +33,8 @@
 dev_getattr_all_blk_files(mount_t)
 dev_list_all_dev_nodes(mount_t)
 dev_rw_lvm_control(mount_t)
+dev_dontaudit_getattr_memory_dev(mount_t)
+dev_getattr_sound_dev(mount_t)
 
 storage_raw_read_fixed_disk(mount_t)
 storage_raw_write_fixed_disk(mount_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.te serefpolicy-2.2.12/policy/modules/system/selinuxutil.te
--- nsaserefpolicy/policy/modules/system/selinuxutil.te	2006-02-03 15:45:55.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/system/selinuxutil.te	2006-02-09 07:21:02.000000000 -0500
@@ -245,6 +245,7 @@
 selinux_compute_relabel_context(newrole_t)
 selinux_compute_user_contexts(newrole_t)
 
+term_dontaudit_use_unallocated_ttys(newrole_t)
 term_use_all_user_ttys(newrole_t)
 term_use_all_user_ptys(newrole_t)
 term_relabel_all_user_ttys(newrole_t)
@@ -354,6 +355,7 @@
 init_use_script_ptys(restorecon_t)
 
 domain_use_wide_inherit_fd(restorecon_t)
+domain_dontaudit_search_all_domains_state(restorecon_t)
 
 files_read_etc_runtime_files(restorecon_t)
 files_read_etc_files(restorecon_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/udev.te serefpolicy-2.2.12/policy/modules/system/udev.te
--- nsaserefpolicy/policy/modules/system/udev.te	2006-02-07 10:43:26.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/system/udev.te	2006-02-08 11:43:58.000000000 -0500
@@ -18,6 +18,8 @@
 domain_obj_id_change_exemption(udev_t)
 domain_entry_file(udev_t,udev_helper_exec_t)
 domain_wide_inherit_fd(udev_t)
+domain_read_all_domains_state(udev_t)
+
 init_daemon_domain(udev_t,udev_exec_t)
 
 type udev_etc_t alias etc_udev_t;
@@ -90,7 +92,7 @@
 dev_delete_generic_files(udev_t)
 
 fs_getattr_all_fs(udev_t)
-fs_search_inotifyfs(udev_t)
+fs_list_inotifyfs(udev_t)
 
 selinux_get_fs_mount(udev_t)
 selinux_validate_context(udev_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.if serefpolicy-2.2.12/policy/modules/system/unconfined.if
--- nsaserefpolicy/policy/modules/system/unconfined.if	2006-02-07 10:43:26.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/system/unconfined.if	2006-02-09 10:54:49.000000000 -0500
@@ -17,6 +17,7 @@
 
 	# Use any Linux capability.
 	allow $1 self:capability *;
+	allow $1 self:fifo_file create_file_perms;
 
 	# Transition to myself, to make get_ordered_context_list happy.
 	allow $1 self:process transition;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.te serefpolicy-2.2.12/policy/modules/system/unconfined.te
--- nsaserefpolicy/policy/modules/system/unconfined.te	2006-02-07 10:43:26.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/system/unconfined.te	2006-02-08 11:43:58.000000000 -0500
@@ -152,4 +152,10 @@
 	optional_policy(`xserver',`
 		xserver_domtrans_xdm_xserver(unconfined_t)
 	')
+	optional_policy(`fstools',`
+		fstools_domtrans(unconfined_t)
+	')
+	optional_policy(`mount',`
+		mount_domtrans(unconfined_t)
+	')
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.if serefpolicy-2.2.12/policy/modules/system/userdomain.if
--- nsaserefpolicy/policy/modules/system/userdomain.if	2006-02-03 15:45:55.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/system/userdomain.if	2006-02-08 11:43:58.000000000 -0500
@@ -2817,6 +2817,23 @@
 
 ########################################
 ## <summary>
+##	Do not audit attempts to append to the staff
+##	users home directory.
+## </summary>
+## <param name="domain">
+##	Domain to not audit.
+## </param>
+#
+interface(`userdom_dontaudit_append_staff_home_files',`
+	gen_require(`
+		type staff_home_t;
+	')
+
+	dontaudit $1 staff_home_t:file append;
+')
+
+########################################
+## <summary>
 ##	Read files in the staff users home directory.
 ## </summary>
 ## <param name="domain">
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.te serefpolicy-2.2.12/policy/modules/system/userdomain.te
--- nsaserefpolicy/policy/modules/system/userdomain.te	2006-02-03 08:55:55.000000000 -0500
+++ serefpolicy-2.2.12/policy/modules/system/userdomain.te	2006-02-08 11:43:58.000000000 -0500
@@ -162,10 +162,13 @@
 		')
 	')
 
+	init_exec(sysadm_t)
+
 	ifdef(`enable_mls',`
 		logging_read_audit_log(secadm_t)
 		logging_domtrans_auditctl(secadm_t)
 		mls_process_read_up(secadm_t)
+		userdom_dontaudit_append_staff_home_files(secadm_t)
 	', `
 		logging_domtrans_auditctl(sysadm_t)
 		logging_read_audit_log(sysadm_t)
@@ -224,6 +227,10 @@
 
 	optional_policy(`dmesg',`
 		dmesg_exec(sysadm_t)
+		ifdef(`enable_mls',`
+			dmesg_exec(secadm_t)
+		')
+
 	')
 
 	optional_policy(`dmidecode',`

--------------020403070102080603040002--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

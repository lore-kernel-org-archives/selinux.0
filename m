Message-ID: <4297FE8C.6050203@redhat.com>
Date: Sat, 28 May 2005 01:15:56 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: latest diffs
Content-Type: multipart/mixed;
 boundary="------------030209080308030801050408"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030209080308030801050408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Allow kernel to read sysfs files and directories

Don't transition to fsadm_t fom unconfined_t (sysadm_t) in targeted policy.

Add support for debugfs in modutil.

More fixes for amanda.  Change dump to fsadm_exec_t

Fixed for audit daemon

Allow automount to create and delete directories in /root and /home dirs.

Move can_ypbind to chkpwd_macro.te  (If you are need to authenticate via 
yppasswd...)

Allow squid to use cert files

Cups/ptal/foomatic fixes

Begin adding support for Ivan's Font Config stuff.

Allow useradd to create additional files and types via the skell mechanism

Fix crond for targeted to define system_crond_tmp_t as a tempfile



-- 



--------------030209080308030801050408
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/misc/kernel.te policy-1.23.17/domains/misc/kernel.te
--- nsapolicy/domains/misc/kernel.te	2005-05-07 00:41:08.000000000 -0400
+++ policy-1.23.17/domains/misc/kernel.te	2005-05-25 11:41:56.000000000 -0400
@@ -22,8 +22,8 @@
 # Use capabilities.
 allow kernel_t self:capability *;
 
-allow kernel_t sysfs_t:dir search;
-allow kernel_t { usbfs_t usbdevfs_t sysfs_t }:dir search;
+r_dir_file(kernel_t, sysfs_t)
+allow kernel_t { usbfs_t usbdevfs_t }:dir search;
 
 # Run init in the init_t domain.
 domain_auto_trans(kernel_t, init_exec_t, init_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/fsadm.te policy-1.23.17/domains/program/fsadm.te
--- nsapolicy/domains/program/fsadm.te	2005-05-25 11:28:09.000000000 -0400
+++ policy-1.23.17/domains/program/fsadm.te	2005-05-25 11:41:56.000000000 -0400
@@ -47,8 +47,9 @@
 
 type fsadm_exec_t, file_type, sysadmfile, exec_type;
 domain_auto_trans(initrc_t, fsadm_exec_t, fsadm_t)
+ifdef(`targeted_policy', `', `
 domain_auto_trans(sysadm_t, fsadm_exec_t, fsadm_t)
-
+')
 tmp_domain(fsadm)
 
 # remount file system to apply changes
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/modutil.te policy-1.23.17/domains/program/modutil.te
--- nsapolicy/domains/program/modutil.te	2005-05-25 11:28:09.000000000 -0400
+++ policy-1.23.17/domains/program/modutil.te	2005-05-25 11:41:56.000000000 -0400
@@ -138,8 +138,8 @@
 
 allow insmod_t fs_t:filesystem getattr;
 allow insmod_t sysfs_t:dir search;
-allow insmod_t { usbfs_t usbdevfs_t }:dir search;
-allow insmod_t { usbfs_t usbdevfs_t }:filesystem mount;
+allow insmod_t { usbfs_t usbdevfs_t debugfs_t }:dir search;
+allow insmod_t { usbfs_t usbdevfs_t debugfs_t }:filesystem mount;
 
 # Rules for /proc/sys/kernel/tainted
 read_sysctl(insmod_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/amanda.te policy-1.23.17/domains/program/unused/amanda.te
--- nsapolicy/domains/program/unused/amanda.te	2005-05-25 11:28:09.000000000 -0400
+++ policy-1.23.17/domains/program/unused/amanda.te	2005-05-25 11:41:56.000000000 -0400
@@ -31,7 +31,7 @@
 # General declarations
 ######################
 
-type amanda_t, domain, privlog, auth, nscd_client_domain ;
+type amanda_t, domain, privlog, auth, nscd_client_domain;
 role system_r types amanda_t;
 
 # type for the amanda executables
@@ -157,7 +157,7 @@
 allow amanda_t bin_t:file { execute execute_no_trans };
 
 allow amanda_t self:capability { chown dac_override setuid };
-allow amanda_t self:process { fork sigchld };
+allow amanda_t self:process { fork sigchld setpgid signal };
 allow amanda_t self:unix_dgram_socket create;
 
 
@@ -234,7 +234,7 @@
 
 uses_shlib(amanda_recover_t)
 allow amanda_recover_t self:process { fork sigkill sigstop sigchld signal };
-allow amanda_recover_t self:capability { fowner fsetid setgid setuid chown dac_override net_bind_service };
+allow amanda_recover_t self:capability { fowner fsetid kill setgid setuid chown dac_override net_bind_service };
 allow amanda_recover_t shell_exec_t:file { execute execute_no_trans getattr read };
 allow amanda_recover_t privfd:fd use;
 
@@ -304,6 +304,8 @@
 allow amanda_t file_type:dir {getattr read search };
 allow amanda_t file_type:{ lnk_file file chr_file blk_file } {getattr read };
 allow amanda_t device_type:{ blk_file chr_file } getattr;
+domain_auto_trans(amanda_t, fsadm_exec_t, fsadm_t)
+
 dontaudit amanda_t file_type:sock_file getattr;
 logdir_domain(amanda)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/auditd.te policy-1.23.17/domains/program/unused/auditd.te
--- nsapolicy/domains/program/unused/auditd.te	2005-05-25 11:28:09.000000000 -0400
+++ policy-1.23.17/domains/program/unused/auditd.te	2005-05-25 11:41:56.000000000 -0400
@@ -15,6 +15,8 @@
 allow auditd_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay nlmsg_readpriv };
 allow auditd_t self:unix_dgram_socket create_socket_perms;
 allow auditd_t self:capability { audit_write audit_control sys_nice };
+allow auditd_t self:process setsched;
+allow auditd_t self:file { getattr read };
 allow auditd_t etc_t:file { getattr read };
 
 # Do not use logdir_domain since this is a security file
@@ -35,15 +37,17 @@
 
 type auditd_etc_t, file_type, secure_file_type;
 allow { auditd_t auditctl_t } auditd_etc_t:file r_file_perms;
+allow initrc_t auditd_etc_t:file r_file_perms;
 
 role secadm_r types auditctl_t;
 role sysadm_r types auditctl_t;
 audit_manager_domain(secadm_t)
 
+ifdef(`targeted_policy', `', `
 ifdef(`separate_secadm', `', `
 audit_manager_domain(sysadm_t)
+') 
 ')
-allow initrc_t auditd_etc_t:file r_file_perms;
 
 role system_r types auditctl_t;
 domain_auto_trans(initrc_t, auditctl_exec_t, auditctl_t)
@@ -52,11 +56,6 @@
 allow auditctl_t proc_t:dir search;
 allow auditctl_t sysctl_kernel_t:dir search;
 allow auditctl_t sysctl_kernel_t:file { getattr read };
-allow auditd_t self:process setsched;
 dontaudit auditctl_t init_t:fd use; 
-allow auditctl_t privfd:fd use;
 allow auditctl_t initrc_devpts_t:chr_file { read write };
-allow auditd_t self:file { getattr read };
-ifdef(`rpm.te', `
-allow auditctl_t rpm_script_t:fd use;
-')
+allow auditctl_t privfd:fd use;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/automount.te policy-1.23.17/domains/program/unused/automount.te
--- nsapolicy/domains/program/unused/automount.te	2005-05-25 11:28:09.000000000 -0400
+++ policy-1.23.17/domains/program/unused/automount.te	2005-05-25 11:41:56.000000000 -0400
@@ -68,8 +68,8 @@
 
 can_exec(initrc_t, automount_etc_t)
 
-# Need something like the following
-# file_type_auto_trans(automount_t, file_type, automount_tmp_t, dir)
+# Allow automount to create and delete directories in / and /home
+file_type_auto_trans(automount_t, { root_t home_root_t }, automount_tmp_t, dir)
 
 allow automount_t var_lib_t:dir search;
 allow automount_t var_lib_nfs_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.23.17/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2005-05-25 11:28:09.000000000 -0400
+++ policy-1.23.17/domains/program/unused/cups.te	2005-05-26 11:59:14.000000000 -0400
@@ -16,7 +16,6 @@
 type cupsd_rw_etc_t, file_type, sysadmfile, usercanread;
 
 can_network(cupsd_t)
-can_ypbind(cupsd_t)
 allow cupsd_t port_type:tcp_socket name_connect;
 logdir_domain(cupsd)
 
@@ -148,16 +147,16 @@
 etcdir_domain(ptal)
 
 file_type_auto_trans(ptal_t, var_run_t, ptal_var_run_t)
-allow ptal_t self:capability chown;
+allow ptal_t self:capability { chown sys_rawio };
 allow ptal_t self:{ unix_dgram_socket unix_stream_socket } create_socket_perms;
 allow ptal_t self:unix_stream_socket { listen accept };
 allow ptal_t self:fifo_file rw_file_perms;
 allow ptal_t device_t:dir read;
-allow ptal_t printer_device_t:chr_file { ioctl read write };
+allow ptal_t printer_device_t:chr_file rw_file_perms;
 allow initrc_t printer_device_t:chr_file getattr;
 allow ptal_t { etc_t etc_runtime_t }:file { getattr read };
 r_dir_file(ptal_t, usbdevfs_t)
-r_dir_file(ptal_t, usbfs_t)
+rw_dir_file(ptal_t, usbfs_t)
 allow cupsd_t ptal_var_run_t:sock_file { write setattr };
 allow cupsd_t ptal_t:unix_stream_socket connectto;
 allow cupsd_t ptal_var_run_t:dir search;
@@ -166,6 +165,7 @@
 allow initrc_t ptal_var_run_t:dir rmdir;
 allow initrc_t ptal_var_run_t:fifo_file unlink;
 
+
 dontaudit cupsd_t selinux_config_t:dir search;
 dontaudit cupsd_t selinux_config_t:file { getattr read };
 
@@ -181,6 +181,7 @@
 daemon_domain(cupsd_config)
 
 allow cupsd_config_t devpts_t:dir search;
+allow cupsd_config_t devpts_t:chr_file { getattr ioctl };
 
 ifdef(`distro_redhat', `
 ifdef(`rpm.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/firstboot.te policy-1.23.17/domains/program/unused/firstboot.te
--- nsapolicy/domains/program/unused/firstboot.te	2005-04-27 10:28:50.000000000 -0400
+++ policy-1.23.17/domains/program/unused/firstboot.te	2005-05-25 11:41:56.000000000 -0400
@@ -10,7 +10,7 @@
 #
 # firstboot_exec_t is the type of the firstboot executable.
 #
-application_domain(firstboot,`, admin, etc_writer, fs_domain, privmem, auth_write, privlog, privowner, privmodule, sysctl_kernel_writer')
+application_domain(firstboot,`, admin, etc_writer, fs_domain, privmem, auth_write, privowner, privmodule, privuser, sysctl_kernel_writer')
 type firstboot_rw_t, file_type, sysadmfile;
 role system_r types firstboot_t;
 
@@ -29,8 +29,10 @@
 file_type_auto_trans(firstboot_t, etc_t, firstboot_rw_t, file)
 
 can_exec_any(firstboot_t)
+ifdef(`useradd.te',`
 domain_auto_trans(firstboot_t, useradd_exec_t, useradd_t)
 domain_auto_trans(firstboot_t, groupadd_exec_t, groupadd_t)
+')
 allow firstboot_t etc_runtime_t:file { getattr read };
 
 r_dir_file(firstboot_t, etc_t)
@@ -130,4 +132,7 @@
 # The big hammer
 #
 unconfined_domain(firstboot_t) 
+ifdef(`targeted_policy', `
+allow firstboot_t unconfined_t:process transition;
+')
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/fontconfig.te policy-1.23.17/domains/program/unused/fontconfig.te
--- nsapolicy/domains/program/unused/fontconfig.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.23.17/domains/program/unused/fontconfig.te	2005-05-25 11:41:56.000000000 -0400
@@ -0,0 +1,7 @@
+#
+# Fontconfig related types 
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+
+# Look in fontconfig_macros.te
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rhgb.te policy-1.23.17/domains/program/unused/rhgb.te
--- nsapolicy/domains/program/unused/rhgb.te	2005-05-25 11:28:10.000000000 -0400
+++ policy-1.23.17/domains/program/unused/rhgb.te	2005-05-25 11:41:56.000000000 -0400
@@ -43,6 +43,8 @@
 allow rhgb_t port_type:tcp_socket name_connect;
 can_ypbind(rhgb_t)
 
+allow rhgb_t usr_t:{ file lnk_file } { getattr read };
+
 # for running setxkbmap
 r_dir_file(rhgb_t, xkb_var_lib_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rshd.te policy-1.23.17/domains/program/unused/rshd.te
--- nsapolicy/domains/program/unused/rshd.te	2005-04-27 10:28:52.000000000 -0400
+++ policy-1.23.17/domains/program/unused/rshd.te	2005-05-25 11:41:56.000000000 -0400
@@ -25,8 +25,6 @@
 can_network_server(rshd_t)
 allow rshd_t rsh_port_t:tcp_socket name_bind;
 
-can_ypbind(rshd_t)
-
 allow rshd_t etc_t:file { getattr read };
 read_locale(rshd_t)
 allow rshd_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/squid.te policy-1.23.17/domains/program/unused/squid.te
--- nsapolicy/domains/program/unused/squid.te	2005-05-02 14:06:54.000000000 -0400
+++ policy-1.23.17/domains/program/unused/squid.te	2005-05-25 11:41:56.000000000 -0400
@@ -28,7 +28,7 @@
 # type for /var/cache/squid
 type squid_cache_t, file_type, sysadmfile;
 
-allow squid_t self:capability { setgid setuid net_bind_service };
+allow squid_t self:capability { setgid setuid net_bind_service dac_override };
 allow squid_t { etc_t etc_runtime_t }:file r_file_perms;
 allow squid_t etc_t:lnk_file read;
 allow squid_t self:unix_stream_socket create_socket_perms;
@@ -76,3 +76,4 @@
 
 #squid requires the following when run in diskd mode, the recommended setting
 allow squid_t tmpfs_t:file { read write };
+r_dir_file(squid_t, cert_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/user.te policy-1.23.17/domains/user.te
--- nsapolicy/domains/user.te	2005-05-25 11:28:09.000000000 -0400
+++ policy-1.23.17/domains/user.te	2005-05-26 13:10:53.000000000 -0400
@@ -80,11 +80,11 @@
 ') dnl ifdef su.te
 ifdef(`xauth.te', `
 file_type_auto_trans($1_xauth_t, sysadm_home_dir_t, sysadm_home_xauth_t,file)
-')
 ifdef(`userhelper.te', `
 file_type_auto_trans($1_userhelper_t, sysadm_home_dir_t, sysadm_home_xauth_t,file)
-')
-')
+') dnl userhelper.te 
+') dnl xauth.te 
+') dnl reach_sysadm
 
 # Privileged user domain
 undefine(`priv_user')
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/cups.fc policy-1.23.17/file_contexts/program/cups.fc
--- nsapolicy/file_contexts/program/cups.fc	2005-05-07 00:41:12.000000000 -0400
+++ policy-1.23.17/file_contexts/program/cups.fc	2005-05-26 11:58:32.000000000 -0400
@@ -32,6 +32,8 @@
 /usr/lib(64)?/cups/cgi-bin/.* --	system_u:object_r:bin_t
 /usr/sbin/ptal-printd	--	system_u:object_r:ptal_exec_t
 /usr/sbin/ptal-mlcd	--	system_u:object_r:ptal_exec_t
+/usr/sbin/ptal-photod	--	system_u:object_r:ptal_exec_t
 /var/run/ptal-printd(/.*)?	system_u:object_r:ptal_var_run_t
 /var/run/ptal-mlcd(/.*)?	system_u:object_r:ptal_var_run_t
 /usr/share/foomatic/db/oldprinterids 	--	system_u:object_r:cupsd_rw_etc_t
+/var/cache/foomatic(/.*)? 	--	system_u:object_r:cupsd_rw_etc_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/fontconfig.fc policy-1.23.17/file_contexts/program/fontconfig.fc
--- nsapolicy/file_contexts/program/fontconfig.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.23.17/file_contexts/program/fontconfig.fc	2005-05-25 11:41:56.000000000 -0400
@@ -0,0 +1,2 @@
+HOME_DIR/\.fonts(/.*)?				system_u:object_r:ROLE_fonts_t	
+HOME_DIR/\.fonts.cache-1		--	system_u:object_r:ROLE_fonts_cache_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/fsadm.fc policy-1.23.17/file_contexts/program/fsadm.fc
--- nsapolicy/file_contexts/program/fsadm.fc	2005-04-14 15:01:54.000000000 -0400
+++ policy-1.23.17/file_contexts/program/fsadm.fc	2005-05-25 11:41:56.000000000 -0400
@@ -19,6 +19,7 @@
 /sbin/parted		--	system_u:object_r:fsadm_exec_t
 /sbin/tune2fs		--	system_u:object_r:fsadm_exec_t
 /sbin/dumpe2fs		--	system_u:object_r:fsadm_exec_t
+/sbin/dump		--	system_u:object_r:fsadm_exec_t
 /sbin/swapon.*		--	system_u:object_r:fsadm_exec_t
 /sbin/hdparm		--	system_u:object_r:fsadm_exec_t
 /sbin/raidstart		--	system_u:object_r:fsadm_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.23.17/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2005-05-25 11:28:10.000000000 -0400
+++ policy-1.23.17/file_contexts/types.fc	2005-05-25 11:41:56.000000000 -0400
@@ -358,8 +358,9 @@
 # nvidia share libraries
 /usr/x11R6/lib/modules/extensions/libglx\.so(\.[^/]*)* -- system_u:object_r:texrel_shlib_t
 /usr/lib(64)?/libGL(core)?/.so(\.[^/]*)* -- system_u:object_r:texrel_shlib_t
+/usr(/.*)?/nvidia/.*\.so(\..*)?	-- system_u:object_r:texrel_shlib_t
+/usr/lib(64)?(/.*)?/libnvidia.*\.so(\.[^/]*)*	--	system_u:object_r:texrel_shlib_t
 /usr/X11R6/lib/libXvMCNVIDIA\.so.* 	-- system_u:object_r:texrel_shlib_t
-/usr/lib(64)?/(tls/)?libnvidia-tls\.so(\.[^/]*)* -- system_u:object_r:texrel_shlib_t
 
 # libGL
 /usr/X11R6/lib/libGL\.so.* 	-- system_u:object_r:texrel_shlib_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.23.17/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2005-05-25 11:28:10.000000000 -0400
+++ policy-1.23.17/macros/base_user_macros.te	2005-05-25 11:41:56.000000000 -0400
@@ -198,6 +198,8 @@
 ifdef(`mplayer.te', `mplayer_domains($1)')
 ifdef(`gift.te', `gift_domains($1)')
 
+fontconfig_domain($1)
+
 # Instantiate a derived domain for user cron jobs.
 ifdef(`crond.te', `crond_domain($1)')
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/chkpwd_macros.te policy-1.23.17/macros/program/chkpwd_macros.te
--- nsapolicy/macros/program/chkpwd_macros.te	2005-05-02 14:06:57.000000000 -0400
+++ policy-1.23.17/macros/program/chkpwd_macros.te	2005-05-25 11:41:56.000000000 -0400
@@ -34,6 +34,7 @@
 allow auth_chkpwd self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
 dontaudit system_chkpwd_t { user_tty_type tty_device_t }:chr_file rw_file_perms;
 dontaudit auth_chkpwd shadow_t:file { getattr read };
+can_ypbind(auth_chkpwd)
 ', `
 domain_auto_trans($1_t, chkpwd_exec_t, $1_chkpwd_t)
 allow $1_t sbin_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/fontconfig_macros.te policy-1.23.17/macros/program/fontconfig_macros.te
--- nsapolicy/macros/program/fontconfig_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.23.17/macros/program/fontconfig_macros.te	2005-05-25 11:41:56.000000000 -0400
@@ -0,0 +1,24 @@
+#
+# Fontconfig related types 
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+# fontconfig_domain(role_prefix) - create fontconfig domain
+#
+# read_fonts(domain, role_prefix) - 
+#         allow domain to read fonts, optionally per/user
+#  
+# dontaudit_home_fonts(domain, role_prefix) - 
+#	block the denials of home fonts - hack for X
+
+define(`fontconfig_domain', `
+
+type $1_fonts_t, file_type, $1_file_type, sysadmfile, customizable;
+type $1_fonts_cache_t, file_type, $1_file_type, sysadmfile;
+
+allow $1_t $1_fonts_cache_t:file create_file_perms;
+create_dir_file($1_t, $1_fonts_t)
+
+') dnl gnome_domain
+
+
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gift_macros.te policy-1.23.17/macros/program/gift_macros.te
--- nsapolicy/macros/program/gift_macros.te	2005-05-25 11:28:10.000000000 -0400
+++ policy-1.23.17/macros/program/gift_macros.te	2005-05-25 11:41:56.000000000 -0400
@@ -56,6 +56,7 @@
 allow $1_gift_t etc_runtime_t:file { getattr read };
 
 # Tmp/ORBit
+tmp_domain($1_gift)
 file_type_auto_trans($1_gift_t, $1_tmp_t, $1_gift_tmp_t)
 can_unix_connect($1_t, $1_gift_t)
 can_unix_connect($1_gift_t, $1_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/java_macros.te policy-1.23.17/macros/program/java_macros.te
--- nsapolicy/macros/program/java_macros.te	2005-05-25 11:28:10.000000000 -0400
+++ policy-1.23.17/macros/program/java_macros.te	2005-05-25 11:41:56.000000000 -0400
@@ -92,7 +92,4 @@
 dontaudit $1_javaplugin_t tmpfs_t:file { execute read write };
 dontaudit $1_javaplugin_t $1_home_t:file { execute setattr };
 
-# Do not audit read/getattr of .fonts-cache-1
-dontaudit $1_javaplugin_t $1_home_t:file { read getattr };
-
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/user_macros.te policy-1.23.17/macros/user_macros.te
--- nsapolicy/macros/user_macros.te	2005-05-25 11:28:10.000000000 -0400
+++ policy-1.23.17/macros/user_macros.te	2005-05-25 11:41:56.000000000 -0400
@@ -172,6 +172,12 @@
 
 attribute $1_file_type;
 
+ifdef(`useradd.te', `
+# Useradd relabels /etc/skel files so needs these privs 
+allow useradd_t $1_file_type:dir create_dir_perms;
+allow useradd_t $1_file_type:notdevfile_class_set create_file_perms;
+')
+
 can_exec($1_t, usr_t)
 
 # Read directories and files with the readable_t type.
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/program/crond.te policy-1.23.17/targeted/domains/program/crond.te
--- nsapolicy/targeted/domains/program/crond.te	2005-05-02 07:37:54.000000000 -0400
+++ policy-1.23.17/targeted/domains/program/crond.te	2005-05-25 11:41:56.000000000 -0400
@@ -14,7 +14,7 @@
 type crond_t, domain, privuser, privrole, privowner;
 typealias crond_t alias system_crond_t;
 type anacron_exec_t, file_type, sysadmfile, exec_type;
-type system_crond_tmp_t, file_type, sysadmfile;
+type system_crond_tmp_t, file_type, tmpfile, sysadmfile;
 type system_cron_spool_t, file_type, sysadmfile;
 type sysadm_cron_spool_t, file_type, sysadmfile;
 type crond_log_t, file_type, sysadmfile;
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.23.17/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.17/tunables/distro.tun	2005-05-25 11:41:56.000000000 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.23.17/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2005-05-25 11:28:11.000000000 -0400
+++ policy-1.23.17/tunables/tunable.tun	2005-05-25 11:41:56.000000000 -0400
@@ -2,7 +2,7 @@
 dnl define(`user_can_mount')
 
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
 dnl define(`unlimitedUtils')
@@ -20,7 +20,7 @@
 
 # Do not audit things that we know to be broken but which
 # are not security risks
-dnl define(`hide_broken_symptoms')
+define(`hide_broken_symptoms')
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.

--------------030209080308030801050408--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

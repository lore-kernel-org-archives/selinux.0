Message-ID: <41FA9717.2000609@redhat.com>
Date: Fri, 28 Jan 2005 14:48:39 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <SELinux@tycho.nsa.gov>
Subject: Latest diffs
References: <1106940328.32737.120.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1106940328.32737.120.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------020200070107080405080509"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020200070107080405080509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changes include

removal of ifdef automount.te
autofs is defined outside of automount.te so this is not necassary and 
was causing targeted policy problems.

Introduction of texrel_shlib_t which define shlib_t libraries that use 
text relocation (execmod).  I have only labeled a few of these so far,
as Red Hat is working to clean these up.  Also using a boolean to turn 
this feature off allow_execmod

Changes to make smbmount work

Fixes for tmpreaper

Changed postgres helper apps back to default context, running them in 
postgresql breaks alot.

Added HelixPlayer file_context

Modified the Makefile so that it defaults to
make -> make policy

make load and make reload no longer install the context files, only make 
install does.

This prevents people from overwriting the system context files if they 
have modified them.





--------------020200070107080405080509
Content-Type: text/x-patch;
 name="policy-20050128.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-20050128.patch"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/login.te policy-1.21.5/domains/program/login.te
--- nsapolicy/domains/program/login.te	2005-01-28 11:50:48.000000000 -0500
+++ policy-1.21.5/domains/program/login.te	2005-01-28 14:02:57.000000000 -0500
@@ -73,9 +73,7 @@
 # Set exec context.
 can_setexec($1_login_t)
 
-ifdef(`automount.te', `
 allow $1_login_t autofs_t:dir { search read getattr };
-')
 allow $1_login_t mnt_t:dir r_dir_perms;
 
 if (use_nfs_home_dirs) {
@@ -128,6 +126,11 @@
 
 allow $1_login_t mouse_device_t:chr_file { getattr setattr };
 
+ifdef(`targeted_policy',`
+unconfined_domain($1_login_t)
+domain_auto_trans($1_login_t, shell_exec_t, unconfined_t)
+')
+
 ')dnl end login_domain macro
 #################################
 #
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/mount.te policy-1.21.5/domains/program/mount.te
--- nsapolicy/domains/program/mount.te	2005-01-24 16:57:04.000000000 -0500
+++ policy-1.21.5/domains/program/mount.te	2005-01-28 14:02:57.000000000 -0500
@@ -49,6 +49,7 @@
 allow mount_t devpts_t:dir mounton;
 allow mount_t usbdevfs_t:dir mounton;
 allow mount_t sysfs_t:dir mounton;
+allow mount_t binfmt_misc_fs_t:dir mounton;
 allow mount_t nfs_t:dir mounton;
 allow mount_t nfs_t:dir search;
 # nfsv4 has a filesystem to mount for its userspace daemons
@@ -83,9 +84,7 @@
 
 # for localization
 allow mount_t lib_t:file { getattr read };
-ifdef(`automount.te', `
 allow mount_t autofs_t:dir read;
-')
 allow mount_t fs_t:filesystem relabelfrom;
 #
 # This rule needs to be generalized.  Only admin, initrc should have it.
@@ -101,5 +100,13 @@
 allow mount_t tmpfs_t:chr_file { read write };
 allow mount_t tmpfs_t:dir mounton;
 ')
+
+
 # tries to read /init
 dontaudit mount_t root_t:file {getattr read };
+dontaudit mount_t root_t:file read;
+
+allow kernel_t mount_t:tcp_socket { read write };
+allow mount_t self:capability { setgid setuid };
+allow user_t mount_t:tcp_socket write;
+allow mount_t proc_t:lnk_file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ssh.te policy-1.21.5/domains/program/ssh.te
--- nsapolicy/domains/program/ssh.te	2005-01-24 12:08:36.000000000 -0500
+++ policy-1.21.5/domains/program/ssh.te	2005-01-28 14:02:57.000000000 -0500
@@ -73,9 +73,7 @@
 allow $1_t self:capability { kill sys_chroot sys_resource chown dac_override fowner fsetid setgid setuid sys_tty_config };
 allow $1_t { home_root_t home_dir_type }:dir { search getattr };
 if (use_nfs_home_dirs) {
-ifdef(`automount.te', `
 allow $1_t autofs_t:dir { search getattr };
-')
 allow $1_t nfs_t:dir { search getattr };
 allow $1_t nfs_t:file { getattr read };
 }
@@ -213,11 +211,6 @@
 can_exec(sshd_t, pam_exec_t)
 ')
 
-
-ifdef(`automount.te', `
-allow sshd_t autofs_t:dir search;
-')
-
 # ssh_keygen_t is the type of the ssh-keygen program when run at install time
 # and by sysadm_t
 daemon_base_domain(ssh_keygen)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/tmpreaper.te policy-1.21.5/domains/program/tmpreaper.te
--- nsapolicy/domains/program/tmpreaper.te	2005-01-20 15:55:02.000000000 -0500
+++ policy-1.21.5/domains/program/tmpreaper.te	2005-01-28 14:02:57.000000000 -0500
@@ -30,6 +30,8 @@
 allow tmpreaper_t urandom_device_t:chr_file { getattr read };
 rw_dir_file(tmpreaper_t, var_spool_t)
 allow tmpreaper_t var_spool_t:dir setattr;
+allow tmpreaper_t print_spool_t:dir setattr;
+rw_dir_file(tmpreaper_t, print_spool_t)
 
 ifdef(`distro_redhat', `
 # for the Red Hat tmpreaper program which also manages tetex indexes
@@ -37,4 +39,4 @@
 allow tmpreaper_t catman_t:dir setattr;
 ')
 read_locale(tmpreaper_t)
-
+dontaudit tmpreaper_t init_t:fd use;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.21.5/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2005-01-24 12:08:36.000000000 -0500
+++ policy-1.21.5/domains/program/unused/apache.te	2005-01-28 14:02:57.000000000 -0500
@@ -264,10 +264,9 @@
 
 allow httpd_t self:netlink_route_socket { bind create getattr nlmsg_read read write };
 
-ifdef(`automount.te', `
 allow httpd_t autofs_t:dir { search getattr };
 allow httpd_suexec_t autofs_t:dir { search getattr };
-')
+
 if (use_nfs_home_dirs && httpd_enable_homedirs) {
 httpd_home_dirs(nfs_t)
 }
@@ -315,6 +314,8 @@
 ifdef(`snmpd.te', `
 dontaudit httpd_t snmpd_var_lib_t:dir search;
 dontaudit httpd_t snmpd_var_lib_t:file { getattr write read };
+', `
+dontaudit httpd_t usr_t:dir write;
 ')
 
 type httpd_squirrelmail_t, file_type, sysadmfile;
@@ -347,3 +348,4 @@
 
 read_sysctl(httpd_sys_script_t)
 allow httpd_sys_script_t var_lib_t:dir search;
+dontaudit httpd_t selinux_config_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dhcpc.te policy-1.21.5/domains/program/unused/dhcpc.te
--- nsapolicy/domains/program/unused/dhcpc.te	2005-01-20 15:55:04.000000000 -0500
+++ policy-1.21.5/domains/program/unused/dhcpc.te	2005-01-28 14:02:57.000000000 -0500
@@ -128,3 +128,5 @@
 dontaudit dhcpc_t var_lock_t:dir search;
 dontaudit dhcpc_t selinux_config_t:dir search;
 allow dhcpc_t self:netlink_route_socket r_netlink_socket_perms;
+dontaudit dhcpc_t domain:dir getattr;
+allow dhcpc_t initrc_var_run_t:file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ftpd.te policy-1.21.5/domains/program/unused/ftpd.te
--- nsapolicy/domains/program/unused/ftpd.te	2005-01-24 12:08:36.000000000 -0500
+++ policy-1.21.5/domains/program/unused/ftpd.te	2005-01-28 14:02:57.000000000 -0500
@@ -87,9 +87,7 @@
 
 dontaudit ftpd_t sysadm_home_dir_t:dir getattr;
 dontaudit ftpd_t selinux_config_t:dir search;
-ifdef(`automount.te', `
 allow ftpd_t autofs_t:dir search;
-')
 allow ftpd_t self:file { getattr read };
 tmp_domain(ftpd)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/kudzu.te policy-1.21.5/domains/program/unused/kudzu.te
--- nsapolicy/domains/program/unused/kudzu.te	2005-01-20 15:55:07.000000000 -0500
+++ policy-1.21.5/domains/program/unused/kudzu.te	2005-01-28 14:02:57.000000000 -0500
@@ -94,3 +94,7 @@
 ')
 allow kudzu_t cupsd_rw_etc_t:dir r_dir_perms;
 dontaudit kudzu_t src_t:dir search;
+ifdef(`xserver.te', `
+allow kudzu_t xserver_exec_t:file getattr;
+')
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/prelink.te policy-1.21.5/domains/program/unused/prelink.te
--- nsapolicy/domains/program/unused/prelink.te	2005-01-20 15:55:09.000000000 -0500
+++ policy-1.21.5/domains/program/unused/prelink.te	2005-01-28 14:02:57.000000000 -0500
@@ -12,7 +12,7 @@
 daemon_base_domain(prelink, `, admin')
 
 allow prelink_t self:process execmem;
-allow prelink_t shlib_t:file execmod;
+allow prelink_t { texrel_shlib_t shlib_t }:file execmod;
 
 allow prelink_t fs_t:filesystem getattr;
 
@@ -32,7 +32,7 @@
 allow prelink_t file_type:dir rw_dir_perms;
 allow prelink_t file_type:lnk_file r_file_perms;
 allow prelink_t file_type:file getattr;
-allow prelink_t { ifdef(`amanda.te', `amanda_usr_lib_t') admin_passwd_exec_t ifdef(`apache.te', `httpd_modules_t') ifdef(`xserver.te', `var_lib_xkb_t') ld_so_t su_exec_t shlib_t sbin_t bin_t lib_t exec_type }:file { create_file_perms execute relabelto relabelfrom };
+allow prelink_t { ifdef(`amanda.te', `amanda_usr_lib_t') admin_passwd_exec_t ifdef(`apache.te', `httpd_modules_t') ifdef(`xserver.te', `var_lib_xkb_t') ld_so_t su_exec_t texrel_shlib_t shlib_t sbin_t bin_t lib_t exec_type }:file { create_file_perms execute relabelto relabelfrom };
 allow prelink_t ld_so_t:file execute_no_trans;
 
 allow prelink_t self:capability { chown dac_override fowner fsetid };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpm.te policy-1.21.5/domains/program/unused/rpm.te
--- nsapolicy/domains/program/unused/rpm.te	2005-01-24 12:08:36.000000000 -0500
+++ policy-1.21.5/domains/program/unused/rpm.te	2005-01-28 14:02:57.000000000 -0500
@@ -75,11 +75,9 @@
 # bash tries ioctl for some reason
 dontaudit initrc_t pidfile:file ioctl;
 
-ifdef(`automount.te', `
 allow rpm_t autofs_t:dir { search getattr };
 allow rpm_t autofs_t:filesystem getattr;
 allow rpm_script_t autofs_t:dir { search getattr };
-')
 allow rpm_t devpts_t:dir { setattr r_dir_perms };
 allow rpm_t { devpts_t proc_t usbdevfs_t fs_t }:filesystem getattr;
 dontaudit rpm_t security_t:filesystem getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/samba.te policy-1.21.5/domains/program/unused/samba.te
--- nsapolicy/domains/program/unused/samba.te	2005-01-28 11:50:49.000000000 -0500
+++ policy-1.21.5/domains/program/unused/samba.te	2005-01-28 14:02:57.000000000 -0500
@@ -120,3 +120,36 @@
 # Support Samba sharing of home directories
 bool samba_enable_home_dirs false;
 
+ifdef(`mount.te', `
+#
+# Domain for running smbmount
+#
+application_domain(smbmount, `, fs_domain, nscd_client_domain');
+can_network(smbmount_t)
+can_ypbind(smbmount_t)
+allow smbmount_t cifs_t:dir r_dir_perms;
+allow smbmount_t self:unix_dgram_socket create_socket_perms;
+allow smbmount_t samba_etc_t:file r_file_perms;
+allow smbmount_t samba_log_t:dir r_dir_perms;
+allow smbmount_t samba_log_t:file ra_file_perms;
+rw_dir_create_file(smbmount_t, samba_var_t)
+domain_auto_trans(mount_t, smbmount_exec_t, smbmount_t)
+r_dir_file(smbmount_t, proc_t)
+allow smbmount_t self:capability { net_bind_service sys_rawio sys_admin dac_override chown };
+allow smbmount_t self:process { fork signal_perms };
+file_type_auto_trans(smbmount_t, etc_t, etc_runtime_t, file)
+allow smbmount_t cifs_t:dir mounton;
+allow smbmount_t cifs_t:dir search;
+allow smbmount_t mnt_t:dir mounton;
+read_locale(smbmount_t)
+allow smbmount_t userdomain:fd use;
+allow smbmount_t self:unix_stream_socket create_socket_perms;
+can_exec(smbmount_t, bin_t)
+allow kernel_t smbmount_t:tcp_socket { read write };
+allow smbmount_t file_type:filesystem { unmount mount relabelto };
+allow smbmount_t local_login_t:fd use;
+allow smbmount_t mnt_t:dir { search getattr };
+allow smbmount_t samba_etc_t:dir search;
+allow smbmount_t sysadm_tty_device_t:chr_file { read write };
+allow smbmount_t etc_t:file { getattr read };
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/spamd.te policy-1.21.5/domains/program/unused/spamd.te
--- nsapolicy/domains/program/unused/spamd.te	2005-01-24 12:08:36.000000000 -0500
+++ policy-1.21.5/domains/program/unused/spamd.te	2005-01-28 14:02:57.000000000 -0500
@@ -55,9 +55,7 @@
 
 system_crond_entry(spamd_exec_t, spamd_t)
 
-ifdef(`automount.te', `
 allow spamd_t autofs_t:dir { search getattr };
-')
 
 if (use_nfs_home_dirs) {
 allow spamd_t nfs_t:dir rw_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xdm.te policy-1.21.5/domains/program/unused/xdm.te
--- nsapolicy/domains/program/unused/xdm.te	2005-01-24 16:57:05.000000000 -0500
+++ policy-1.21.5/domains/program/unused/xdm.te	2005-01-28 14:02:57.000000000 -0500
@@ -282,9 +282,7 @@
 allow xdm_xserver_t user_home_type:file { getattr read };
 
 if (use_nfs_home_dirs) {
-ifdef(`automount.te', `
 allow { xdm_t xdm_xserver_t } autofs_t:dir { search getattr };
-')
 allow { xdm_t xdm_xserver_t } nfs_t:dir create_dir_perms;
 allow { xdm_t xdm_xserver_t } nfs_t:{file lnk_file} create_file_perms;
 can_exec(xdm_t, nfs_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/user.te policy-1.21.5/domains/user.te
--- nsapolicy/domains/user.te	2005-01-24 12:08:35.000000000 -0500
+++ policy-1.21.5/domains/user.te	2005-01-28 14:02:57.000000000 -0500
@@ -10,6 +10,9 @@
 # Support NFS home directories
 bool use_nfs_home_dirs false;
 
+# Support Share libraries with Text Relocation
+bool allow_execmod false;
+
 # Support SAMBA home directories
 bool use_samba_home_dirs false;
 
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/distros.fc policy-1.21.5/file_contexts/distros.fc
--- nsapolicy/file_contexts/distros.fc	2005-01-28 11:50:49.000000000 -0500
+++ policy-1.21.5/file_contexts/distros.fc	2005-01-28 14:02:57.000000000 -0500
@@ -63,6 +63,10 @@
 ifdef(`dbusd.te', `', `
 /var/run/dbus(/.*)?            system_u:object_r:system_dbusd_var_run_t
 ')
+
+/usr/lib/.*/plugins/libflashplayer\.so.* -- system_u:object_r:texrel_shlib_t
+/usr/X11R6/lib/modules/dri/.*\.so -- system_u:object_r:texrel_shlib_t
+
 ')
 
 ifdef(`distro_suse', `
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/initrc.fc policy-1.21.5/file_contexts/program/initrc.fc
--- nsapolicy/file_contexts/program/initrc.fc	2005-01-20 15:55:17.000000000 -0500
+++ policy-1.21.5/file_contexts/program/initrc.fc	2005-01-28 14:40:08.000000000 -0500
@@ -30,9 +30,7 @@
 
 # run_init
 /usr/sbin/run_init	--	system_u:object_r:run_init_exec_t
-ifdef(`distro_debian', `
 /usr/sbin/open_init_pty	--	system_u:object_r:initrc_exec_t
-')
 /etc/nologin.*		--	system_u:object_r:etc_runtime_t
 /etc/nohotplug		--	system_u:object_r:etc_runtime_t
 ifdef(`distro_redhat', `
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/postgresql.fc policy-1.21.5/file_contexts/program/postgresql.fc
--- nsapolicy/file_contexts/program/postgresql.fc	2005-01-24 16:57:05.000000000 -0500
+++ policy-1.21.5/file_contexts/program/postgresql.fc	2005-01-28 14:02:57.000000000 -0500
@@ -1,18 +1,8 @@
-# postgresql - ldap server
+# postgresql - database server
 /usr/lib(64)?/postgresql/bin/.* --	system_u:object_r:postgresql_exec_t
 /usr/bin/postgres	--	system_u:object_r:postgresql_exec_t
-/usr/bin/pg_dump	--	system_u:object_r:postgresql_exec_t
-/usr/bin/pg_dumpall	--	system_u:object_r:postgresql_exec_t
-/usr/bin/pg_resetxlog	--	system_u:object_r:postgresql_exec_t
 /usr/bin/initdb		--	system_u:object_r:postgresql_exec_t
 
-# not sure whether the following binaries need labelling
-/usr/bin/createlang	--	system_u:object_r:postgresql_exec_t
-/usr/bin/droplang	--	system_u:object_r:postgresql_exec_t
-/usr/bin/pg_encoding	--	system_u:object_r:postgresql_exec_t
-/usr/bin/pg_id		--	system_u:object_r:postgresql_exec_t
-/usr/bin/pg_restore	--	system_u:object_r:postgresql_exec_t
-
 /var/lib/postgres(ql)?(/.*)? 	system_u:object_r:postgresql_db_t
 /var/lib/pgsql/data(/.*)?	system_u:object_r:postgresql_db_t
 /var/run/postgresql(/.*)?	system_u:object_r:postgresql_var_run_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/samba.fc policy-1.21.5/file_contexts/program/samba.fc
--- nsapolicy/file_contexts/program/samba.fc	2005-01-20 15:55:19.000000000 -0500
+++ policy-1.21.5/file_contexts/program/samba.fc	2005-01-28 14:02:57.000000000 -0500
@@ -19,3 +19,6 @@
 /var/run/samba/smbd\.pid --	system_u:object_r:smbd_var_run_t
 /var/run/samba/nmbd\.pid --	system_u:object_r:nmbd_var_run_t
 /var/spool/samba(/.*)?		system_u:object_r:samba_var_t
+ifdef(`mount.te', `
+/usr/bin/smbmount		system_u:object_r:smbmount_exec_t
+')
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.21.5/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2005-01-24 16:57:05.000000000 -0500
+++ policy-1.21.5/file_contexts/types.fc	2005-01-28 14:02:57.000000000 -0500
@@ -336,6 +336,7 @@
 /usr(/.*)?/java/.*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
 /usr(/.*)?/java/.*\.jar	--	system_u:object_r:shlib_t
 /usr(/.*)?/java/.*\.jsa	--	system_u:object_r:shlib_t
+/usr(/.*)?/HelixPlayer/.*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
 /usr(/.*)?/lib(64)?(/.*)?/ld-[^/]*\.so(\.[^/]*)* system_u:object_r:ld_so_t
 /usr(/.*)?/bin(/.*)?		system_u:object_r:bin_t
 /usr(/.*)?/Bin(/.*)?		system_u:object_r:bin_t
@@ -350,6 +351,11 @@
 /usr/share/man(/.*)?		system_u:object_r:man_t
 /usr/share/mc/extfs/.*	--	system_u:object_r:bin_t
 /usr/share(/.*)?/lib(64)?(/.*)?	system_u:object_r:usr_t
+
+# nvidia share libraries
+/usr(/.*)?/nvidia/.*\.so(\..*)?	-- system_u:object_r:texrel_shlib_t
+/usr/X11R6/lib/libXvMCNVIDIA\.so.* 	-- system_u:object_r:texrel_shlib_t
+
 ifdef(`distro_debian', `
 /usr/share/selinux(/.*)?	system_u:object_r:policy_src_t
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.21.5/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2005-01-24 12:08:37.000000000 -0500
+++ policy-1.21.5/macros/base_user_macros.te	2005-01-28 14:02:57.000000000 -0500
@@ -42,8 +42,10 @@
 # Allow loading DSOs that require executable stack.
 allow $1_t self:process execmem;
 
+if (allow_execmod) {
 # Allow text relocations on system shared libraries, e.g. libGL.
 allow $1_t shlib_t:file execmod;
+}
 
 #
 # kdeinit wants this access
@@ -73,9 +75,7 @@
 allow $1_t $1_home_t:notdevfile_class_set { relabelfrom relabelto };
 can_setfscreate($1_t)
 
-ifdef(`automount.te', `
 allow $1_t autofs_t:dir { search getattr };
-')dnl end if automount.te
 
 if (use_nfs_home_dirs) {
 network_home_dir($1_t, nfs_t)
@@ -85,6 +85,7 @@
 network_home_dir($1_t, cifs_t)
 }
 
+can_exec($1_t, { removable_t noexattrfile } )
 if (user_rw_noexattrfile) {
 create_dir_file($1_t, noexattrfile)
 create_dir_file($1_t, removable_t)
@@ -93,6 +94,7 @@
 allow $1_t usbtty_device_t:chr_file write;
 } else {
 r_dir_file($1_t, noexattrfile)
+r_dir_file($1_t, removable_t)
 allow $1_t removable_device_t:blk_file r_file_perms;
 }
 allow $1_t usbtty_device_t:chr_file read;
@@ -281,6 +283,7 @@
 ifdef(`xserver.te', `
 # for /tmp/.ICE-unix
 file_type_auto_trans($1_t, xdm_xserver_tmp_t, $1_tmp_t, sock_file)
+allow $1_t xserver_misc_device_t:{ chr_file blk_file } rw_file_perms;
 ')
 
 ifdef(`xdm.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/macros/core_macros.te policy-1.21.5/macros/core_macros.te
--- nsapolicy/macros/core_macros.te	2005-01-20 15:55:21.000000000 -0500
+++ policy-1.21.5/macros/core_macros.te	2005-01-28 14:02:57.000000000 -0500
@@ -692,7 +692,5 @@
 # eventually this should become can_nsswitch
 #
 can_ypbind($1)
-ifdef(`automount.te', `
 allow $1 autofs_t:dir { search getattr };
-')
 ')dnl end general_domain_access
diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te policy-1.21.5/macros/global_macros.te
--- nsapolicy/macros/global_macros.te	2005-01-24 12:08:37.000000000 -0500
+++ policy-1.21.5/macros/global_macros.te	2005-01-28 14:02:57.000000000 -0500
@@ -104,8 +104,11 @@
 allow $1 ld_so_t:file rx_file_perms;
 #allow $1 ld_so_t:file execute_no_trans;
 allow $1 ld_so_t:lnk_file r_file_perms;
-allow $1 shlib_t:file rx_file_perms;
-allow $1 shlib_t:lnk_file r_file_perms;
+allow $1 { texrel_shlib_t shlib_t }:file rx_file_perms;
+allow $1 { texrel_shlib_t shlib_t }:lnk_file r_file_perms;
+if (allow_execmod) {
+allow $1 texrel_shlib_t:file execmod;
+}
 allow $1 ld_so_cache_t:file r_file_perms;
 allow $1 device_t:dir search;
 allow $1 null_device_t:chr_file rw_file_perms;
@@ -252,9 +255,7 @@
 
 r_dir_file($1_t, sysfs_t) 
 
-ifdef(`automount.te', `
 allow $1_t autofs_t:dir { search getattr };
-')dnl end if automount.te
 ifdef(`targeted_policy', `
 dontaudit $1_t { tty_device_t devpts_t }:chr_file { read write };
 dontaudit $1_t root_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/apache_macros.te policy-1.21.5/macros/program/apache_macros.te
--- nsapolicy/macros/program/apache_macros.te	2005-01-24 12:08:37.000000000 -0500
+++ policy-1.21.5/macros/program/apache_macros.te	2005-01-28 14:02:57.000000000 -0500
@@ -19,6 +19,7 @@
 # Type that CGI scripts run as
 type httpd_$1_script_t, domain, privmail, nscd_client_domain;
 role system_r types httpd_$1_script_t;
+uses_shlib(httpd_$1_script_t)
 
 if (httpd_enable_cgi) {
 domain_auto_trans(httpd_t, httpd_$1_script_exec_t, httpd_$1_script_t)
@@ -28,7 +29,6 @@
 allow httpd_$1_script_t httpd_t:fd use;
 allow httpd_$1_script_t httpd_t:process sigchld;
 
-uses_shlib(httpd_$1_script_t)
 can_network(httpd_$1_script_t)
 allow httpd_$1_script_t { usr_t lib_t }:file { getattr read ioctl };
 allow httpd_$1_script_t usr_t:lnk_file { getattr read };
@@ -41,7 +41,6 @@
 read_locale(httpd_$1_script_t)
 allow httpd_$1_script_t fs_t:filesystem getattr;
 allow httpd_$1_script_t self:unix_stream_socket create_socket_perms;
-allow httpd_$1_script_t httpd_t:unix_stream_socket { read write };
 
 allow httpd_$1_script_t { self proc_t }:file { getattr read };
 allow httpd_$1_script_t { self proc_t }:dir r_dir_perms;
@@ -117,6 +116,7 @@
 domain_auto_trans(httpd_suexec_t, httpdcontent, httpd_sys_script_t)
 domain_auto_trans(sysadm_t, httpdcontent, httpd_sys_script_t)
 create_dir_file(httpd_t, httpdcontent)
+can_exec(httpd_t, httpdcontent )
 ', `
 can_exec(httpd_$1_script_t, httpdcontent )
 domain_auto_trans($1_t, httpdcontent, httpd_$1_script_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/dbusd_macros.te policy-1.21.5/macros/program/dbusd_macros.te
--- nsapolicy/macros/program/dbusd_macros.te	2005-01-20 15:55:23.000000000 -0500
+++ policy-1.21.5/macros/program/dbusd_macros.te	2005-01-28 14:02:57.000000000 -0500
@@ -14,7 +14,7 @@
 typealias system_dbusd_t alias dbusd_t;
 type etc_dbusd_t, file_type, sysadmfile;
 ',`
-type $1_dbusd_t, domain, privlog, userspace_objmgr;
+type $1_dbusd_t, domain, privlog, nscd_client_domain, userspace_objmgr;
 role $1_r types $1_dbusd_t;
 domain_auto_trans($1_t, system_dbusd_exec_t, $1_dbusd_t)
 read_locale($1_dbusd_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.21.5/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2005-01-28 11:50:50.000000000 -0500
+++ policy-1.21.5/macros/program/mozilla_macros.te	2005-01-28 14:02:57.000000000 -0500
@@ -25,7 +25,7 @@
 allow $1_mozilla_t $1_t:process signull;
 
 # Set resource limits and scheduling info.
-allow $1_mozilla_t self:process { setrlimit setsched };
+allow $1_mozilla_t self:process { execmem setrlimit setsched };
 
 allow $1_mozilla_t usr_t:{ lnk_file file } { getattr read };
 allow $1_mozilla_t var_lib_t:file { getattr read };
@@ -43,9 +43,7 @@
 if (use_samba_home_dirs) {
 create_dir_file($1_mozilla_t, cifs_t)
 }
-ifdef(`automount.te', `
 allow $1_mozilla_t autofs_t:dir { search getattr };
-')dnl end if automount
 
 # for bash
 allow $1_mozilla_t device_t:dir r_dir_perms;
@@ -127,7 +125,7 @@
 #
 allow $1_mozilla_t ld_so_cache_t:file execute;
 allow $1_mozilla_t locale_t:file execute;
-dontaudit $1_mozilla_t device_type:{ chr_file file } execute;
+dontaudit $1_mozilla_t *:{ chr_file file } execute;
 dontaudit $1_t ld_so_cache_t:file execute;
 dontaudit $1_t locale_t:file execute;
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/newrole_macros.te policy-1.21.5/macros/program/newrole_macros.te
--- nsapolicy/macros/program/newrole_macros.te	2005-01-20 15:55:25.000000000 -0500
+++ policy-1.21.5/macros/program/newrole_macros.te	2005-01-28 14:02:57.000000000 -0500
@@ -46,9 +46,7 @@
 
 can_setexec($1_t)
 
-ifdef(`automount.te', `
 allow $1_t autofs_t:dir search;
-')
 
 # Use capabilities.
 allow $1_t self:capability { setuid setgid net_bind_service dac_override };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_agent_macros.te policy-1.21.5/macros/program/ssh_agent_macros.te
--- nsapolicy/macros/program/ssh_agent_macros.te	2005-01-24 12:08:37.000000000 -0500
+++ policy-1.21.5/macros/program/ssh_agent_macros.te	2005-01-28 14:02:57.000000000 -0500
@@ -38,9 +38,7 @@
 
 can_ypbind($1_ssh_agent_t)
 if (use_nfs_home_dirs) {
-ifdef(`automount.te', `
 allow $1_ssh_agent_t autofs_t:dir { search getattr };
-')
 rw_dir_create_file($1_ssh_agent_t, nfs_t)
 }
 if (use_samba_home_dirs) {
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_macros.te policy-1.21.5/macros/program/ssh_macros.te
--- nsapolicy/macros/program/ssh_macros.te	2005-01-24 12:08:37.000000000 -0500
+++ policy-1.21.5/macros/program/ssh_macros.te	2005-01-28 14:02:57.000000000 -0500
@@ -24,9 +24,7 @@
 type $1_ssh_t, domain, privlog, nscd_client_domain;
 type $1_home_ssh_t, file_type, $1_file_type, sysadmfile;
 
-ifdef(`automount.te', `
 allow $1_ssh_t autofs_t:dir { search getattr };
-')
 if (use_nfs_home_dirs) {
 create_dir_file($1_ssh_t, nfs_t)
 }
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/su_macros.te policy-1.21.5/macros/program/su_macros.te
--- nsapolicy/macros/program/su_macros.te	2005-01-24 12:08:37.000000000 -0500
+++ policy-1.21.5/macros/program/su_macros.te	2005-01-28 14:02:57.000000000 -0500
@@ -133,9 +133,7 @@
 dontaudit $1_su_t home_dir_type:dir { search write };
 ')
 
-ifdef(`automount.te', `
 allow $1_su_t autofs_t:dir { search getattr };
-')
 if (use_nfs_home_dirs) {
 allow $1_su_t nfs_t:dir search;
 }
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/userhelper_macros.te policy-1.21.5/macros/program/userhelper_macros.te
--- nsapolicy/macros/program/userhelper_macros.te	2005-01-20 15:55:26.000000000 -0500
+++ policy-1.21.5/macros/program/userhelper_macros.te	2005-01-28 14:02:57.000000000 -0500
@@ -115,9 +115,7 @@
 
 allow $1_userhelper_t urandom_device_t:chr_file { getattr read };
 
-ifdef(`automount.te', `
 allow $1_userhelper_t autofs_t:dir search;
-')
 allow $1_userhelper_t sysctl_t:dir search;
 role system_r types $1_userhelper_t;
 r_dir_file($1_userhelper_t, nfs_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/xauth_macros.te policy-1.21.5/macros/program/xauth_macros.te
--- nsapolicy/macros/program/xauth_macros.te	2005-01-24 12:08:37.000000000 -0500
+++ policy-1.21.5/macros/program/xauth_macros.te	2005-01-28 14:02:57.000000000 -0500
@@ -81,9 +81,7 @@
 allow $1_xauth_t $1_tmp_t:file { getattr ioctl read };
 
 if (use_nfs_home_dirs) {
-ifdef(`automount.te', `
 allow $1_xauth_t autofs_t:dir { search getattr };
-')
 rw_dir_create_file($1_xauth_t, nfs_t)
 }
 if (use_samba_home_dirs) {
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/x_client_macros.te policy-1.21.5/macros/program/x_client_macros.te
--- nsapolicy/macros/program/x_client_macros.te	2005-01-28 11:50:50.000000000 -0500
+++ policy-1.21.5/macros/program/x_client_macros.te	2005-01-28 14:02:57.000000000 -0500
@@ -23,7 +23,7 @@
 #
 define(`x_client_domain',`
 # Derived domain based on the calling user domain and the program.
-type $1_$2_t, domain $3;
+type $1_$2_t, domain, nscd_client_domain $3;
 # Type for files that are writeable by this domain.
 type $1_$2_rw_t, file_type, $1_file_type, sysadmfile, tmpfile;
 # Type for files that are read-only for this domain
diff --exclude-from=exclude -N -u -r nsapolicy/macros/user_macros.te policy-1.21.5/macros/user_macros.te
--- nsapolicy/macros/user_macros.te	2005-01-20 15:55:22.000000000 -0500
+++ policy-1.21.5/macros/user_macros.te	2005-01-28 14:02:57.000000000 -0500
@@ -126,10 +126,6 @@
 undefine(`full_user_role')
 define(`full_user_role', `
 
-# certain apps ask for this priv kdesu, fetchmail
-# dac controls force the user to only lower priority
-allow $1_t self:process setrlimit;
-
 # user_t/$1_t is an unprivileged users domain.
 type $1_t, domain, userdomain, unpriv_userdomain, web_client_domain, nscd_client_domain, privfd;
 
diff --exclude-from=exclude -N -u -r nsapolicy/Makefile policy-1.21.5/Makefile
--- nsapolicy/Makefile	2005-01-28 11:50:46.000000000 -0500
+++ policy-1.21.5/Makefile	2005-01-28 14:16:21.000000000 -0500
@@ -3,7 +3,7 @@
 #
 # Targets:
 # 
-# install - compile and install the policy configuration.
+# install - compile and install the policy configuration, and context files.
 # load    - compile, install, and load the policy configuration.
 # reload  - compile, install, and load/reload the policy configuration.
 # relabel - relabel filesystems based on the file contexts configuration.
@@ -60,7 +60,7 @@
 
 ROOTFILES = $(addprefix $(APPDIR)/users/,root)
 
-all:  install
+all:  policy
 
 tmp/valid_fc: $(APPFILES) $(ROOTFILES) $(LOADPATH) $(FCPATH) $(USERPATH)/system.users $(USERPATH)/local.users
 	@echo "Validating file_contexts ..."	
@@ -81,10 +81,9 @@
 
 $(USERPATH)/local.users: local.users
 	@mkdir -p $(USERPATH)
-	m4 $(ALL_TUNABLES) tmp/program_used_flags.te $(USERPATH)/local.users | sed 's/^user/#user/g' > tmp/local.users
+	m4 $(ALL_TUNABLES) tmp/program_used_flags.te local.users | sed 's/^user/#user/g' > tmp/local.users
 	install -m 644 tmp/local.users $@
 
-
 $(CONTEXTPATH)/files/media: appconfig/media
 	mkdir -p $(CONTEXTPATH)/files/
 	install -m 644 $< $@
@@ -145,7 +144,7 @@
 	@echo "Validating file_contexts ..."
 	$(SETFILES) -q -c $(POLICYVER) $(FC)
 
-reload tmp/load: install
+reload tmp/load: $(FCPATH) $(LOADPATH)
 ifeq ($(VERS), $(KERNVERS))
 	$(LOADPOLICY) $(LOADPATH)
 else
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/program/crond.te policy-1.21.5/targeted/domains/program/crond.te
--- nsapolicy/targeted/domains/program/crond.te	2005-01-24 16:57:06.000000000 -0500
+++ policy-1.21.5/targeted/domains/program/crond.te	2005-01-28 14:02:57.000000000 -0500
@@ -12,12 +12,18 @@
 #
 type crond_exec_t, file_type, sysadmfile, exec_type;
 type crond_t, domain;
-type system_crond_t, domain;
+typealias crond_t alias system_crond_t;
 type anacron_exec_t, file_type, sysadmfile, exec_type;
 type system_crond_tmp_t, file_type, sysadmfile;
 type system_cron_spool_t, file_type, sysadmfile;
 type sysadm_cron_spool_t, file_type, sysadmfile;
 type crond_log_t, file_type, sysadmfile;
 type crond_var_run_t, file_type, sysadmfile;
+role system_r types system_crond_t;
 domain_auto_trans(initrc_t, crond_exec_t, crond_t)
 domain_auto_trans(initrc_t, anacron_exec_t, crond_t)
+unconfined_domain(crond_t)
+# Access log files
+file_type_auto_trans(crond_t, var_log_t, crond_log_t, file)
+file_type_auto_trans(crond_t, user_home_dir_t, user_home_t)
+file_type_auto_trans(crond_t, tmp_t, system_crond_tmp_t)
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/unconfined.te policy-1.21.5/targeted/domains/unconfined.te
--- nsapolicy/targeted/domains/unconfined.te	2005-01-28 11:50:50.000000000 -0500
+++ policy-1.21.5/targeted/domains/unconfined.te	2005-01-28 14:02:57.000000000 -0500
@@ -44,6 +44,9 @@
 # Support NFS home directories
 bool use_nfs_home_dirs false;
 
+# Support Share libraries with Text Relocation
+bool allow_execmod false;
+
 # Support SAMBA home directories
 bool use_samba_home_dirs false;
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.21.5/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-08-20 13:57:29.000000000 -0400
+++ policy-1.21.5/tunables/distro.tun	2005-01-28 14:02:57.000000000 -0500
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.21.5/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2005-01-20 15:55:28.000000000 -0500
+++ policy-1.21.5/tunables/tunable.tun	2005-01-28 14:02:57.000000000 -0500
@@ -1,27 +1,27 @@
 # Allow users to execute the mount command
-dnl define(`user_can_mount')
+define(`user_can_mount')
 
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
-dnl define(`unlimitedUtils')
+define(`unlimitedUtils')
 
 # Allow rc scripts to run unconfined, including any daemon
 # started by an rc script that does not have a domain transition
 # explicitly defined.
-dnl define(`unlimitedRC')
+define(`unlimitedRC')
 
 # Allow sysadm_t to directly start daemons
 define(`direct_sysadm_daemon')
 
 # Do not audit things that we know to be broken but which
 # are not security risks
-dnl define(`hide_broken_symptoms')
+define(`hide_broken_symptoms')
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
-dnl define(`user_canbe_sysadm')
+define(`user_canbe_sysadm')
 
 # Allow xinetd to run unconfined, including any services it starts
 # that do not have a domain transition explicitly defined.
diff --exclude-from=exclude -N -u -r nsapolicy/types/file.te policy-1.21.5/types/file.te
--- nsapolicy/types/file.te	2005-01-20 15:55:28.000000000 -0500
+++ policy-1.21.5/types/file.te	2005-01-28 14:02:57.000000000 -0500
@@ -127,9 +127,18 @@
 # shlib_t is the type of shared objects in the system lib
 # directories.
 #
+ifdef(`targeted_policy', `
+typealias lib_t alias shlib_t;
+', `
 type shlib_t, file_type, sysadmfile;
+')
 
 #
+# texrel_shlib_t is the type of shared objects in the system lib
+# directories, which require text relocation.
+#
+type texrel_shlib_t, file_type, sysadmfile;
+
 # ld_so_t is the type of the system dynamic loaders.
 #
 type ld_so_t, file_type, sysadmfile;

--------------020200070107080405080509--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Message-ID: <41C9BA27.4070403@redhat.com>
Date: Wed, 22 Dec 2004 13:17:11 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Latest patches
Content-Type: multipart/mixed;
 boundary="------------060806030300050108060800"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060806030300050108060800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Cleaned up initrc.te file by moving ifdef(`XYZ.te', ... ) to the XYZ file.

A few changes to add additional policies to targeted policy.

Added some dontaudit for reserved_port_type.

Add general_domain_type for squid

Fixed for new version of udev

Fixes for winbind

Added /emul for ia32 platform

Cleaned up file context to put definitions in proper fc file to match te 
file definition.





--------------060806030300050108060800
Content-Type: text/x-patch;
 name="policy-20041221.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-20041221.patch"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/crond.te policy-1.19.15/domains/program/crond.te
--- nsapolicy/domains/program/crond.te	2004-12-02 14:11:41.000000000 -0500
+++ policy-1.19.15/domains/program/crond.te	2004-12-22 11:18:14.000000000 -0500
@@ -160,6 +160,7 @@
 # /sbin/runlevel needs lock access however
 dontaudit system_crond_t initrc_var_run_t:file write;
 allow system_crond_t initrc_var_run_t:file { getattr read lock };
+allow initrc_t system_cron_spool_t:file { getattr read };
 
 # Access other spool directories like
 # /var/spool/anacron and /var/spool/slrnpull.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te policy-1.19.15/domains/program/initrc.te
--- nsapolicy/domains/program/initrc.te	2004-12-21 10:59:57.000000000 -0500
+++ policy-1.19.15/domains/program/initrc.te	2004-12-22 11:18:14.000000000 -0500
@@ -13,10 +13,6 @@
 #
 # do not use privmail for sendmail as it creates a type transition conflict
 type initrc_t, ifdef(`unlimitedRC', `admin, etc_writer, fs_domain, privmem, auth_write, unrestricted, ') domain, privlog, privowner, privmodule, ifdef(`sendmail.te', `', `privmail,') ifdef(`distro_debian', `etc_writer, ') sysctl_kernel_writer, nscd_client_domain;
-ifdef(`sendmail.te', `
-allow system_mail_t initrc_t:fd use;
-allow system_mail_t initrc_t:fifo_file write;
-')
 
 role system_r types initrc_t;
 uses_shlib(initrc_t);
@@ -115,14 +111,6 @@
 # Communicate with the init process.
 allow initrc_t initctl_t:fifo_file rw_file_perms;
 
-# Send messages to portmap and ypbind.
-ifdef(`portmap.te', `
-can_udp_send(initrc_t, portmap_t)
-')
-ifdef(`ypbind.te', `
-can_udp_send(initrc_t, ypbind_t)
-')
-
 # Read /proc/PID directories for all domains.
 r_dir_file(initrc_t, domain)
 allow initrc_t domain:process { getattr getsession };
@@ -137,15 +125,6 @@
 # Update /etc/ld.so.cache.
 allow initrc_t ld_so_cache_t:file rw_file_perms;
 
-ifdef(`xfs.te', `
-# Unlink the xfs socket.
-allow initrc_t xfs_tmp_t:dir rw_dir_perms;
-allow initrc_t xfs_tmp_t:dir rmdir;
-allow initrc_t xfs_tmp_t:sock_file { read getattr unlink };
-allow initrc_t fonts_t:dir create_dir_perms;
-allow initrc_t fonts_t:file create_file_perms;
-')
-
 # Update /var/log/wtmp and /var/log/dmesg.
 allow initrc_t wtmp_t:file { setattr rw_file_perms };
 allow initrc_t var_log_t:dir rw_dir_perms;
@@ -222,38 +201,14 @@
 # readahead asks for these
 #
 allow initrc_t etc_aliases_t:file { getattr read };
-allow initrc_t system_cron_spool_t:file { getattr read };
 allow initrc_t var_lib_nfs_t:file { getattr read };
 
 # for /halt /.autofsck and other flag files
 file_type_auto_trans({ initrc_t sysadm_t }, root_t, etc_runtime_t, file)
 
-ifdef(`rpm.te', `
-# Access /var/lib/rpm.
-allow initrc_t rpm_var_lib_t:dir rw_dir_perms;
-allow initrc_t rpm_var_lib_t:file create_file_perms;
-')
 ')dnl end distro_redhat
 
-ifdef(`distro_gentoo', `
-ifdef(`arpwatch.te', `
-allow initrc_t arpwatch_data_t:dir { add_name write };
-allow initrc_t arpwatch_data_t:file create;
-')
-')dnl end distro_gentoo
-
 allow initrc_t system_map_t:{ file lnk_file } r_file_perms;
-
-ifdef(`rhgb.te', `
-allow initrc_t ramfs_t:dir search;
-allow initrc_t ramfs_t:sock_file write;
-allow initrc_t rhgb_t:unix_stream_socket { read write };
-')
-
-ifdef(`gpm.te', `
-allow initrc_t gpmctl_t:sock_file setattr;
-')
-
 allow initrc_t var_spool_t:file rw_file_perms;
 
 # Allow access to the sysadm TTYs. Note that this will give access to the 
@@ -263,20 +218,6 @@
 
 # Access sound device and files.
 allow initrc_t sound_device_t:chr_file { setattr ioctl read write };
-ifdef(`sound.te', `
-allow initrc_t sound_file_t:file { setattr write };
-')
-
-ifdef(`apmd.te',
-`# Access /dev/apm_bios.
-allow initrc_t apm_bios_t:chr_file { setattr getattr read };
-')
-
-ifdef(`lpd.te',
-`# Read printconf files.
-allow initrc_t printconf_t:dir r_dir_perms;
-allow initrc_t printconf_t:file r_file_perms;
-')
 
 # Read user home directories.
 allow initrc_t { home_root_t home_type }:dir r_dir_perms;
@@ -299,7 +240,12 @@
 #
 # Rules for the run_init_t domain.
 #
+ifdef(`targeted_policy', `
+type run_init_exec_t, file_type, sysadmfile, exec_type;
+domain_auto_trans(unconfined_t, initrc_exec_t, initrc_t)
+', `
 run_program(sysadm_t, sysadm_r, init, initrc_exec_t, initrc_t)
+')
 allow initrc_t privfd:fd use;
 
 # Transition to system_r:initrc_t upon executing init scripts.
@@ -323,10 +269,6 @@
 allow initrc_t device_type:chr_file setattr;
 allow initrc_t binfmt_misc_fs_t:dir { getattr search };
 allow initrc_t binfmt_misc_fs_t:file { getattr ioctl write };
-ifdef(`pam.te', `
-allow initrc_t pam_var_run_t:dir rw_dir_perms;
-allow initrc_t pam_var_run_t:file { getattr read unlink };
-')
 
 # for lsof in shutdown scripts
 can_kerberos(initrc_t)
@@ -351,9 +293,6 @@
 #
 allow initrc_t security_t:dir { getattr search };
 allow initrc_t security_t:file { getattr read };
-ifdef(`dbusd.te', `
-allow initrc_t system_dbusd_t:dbus { send_msg acquire_svc };
-')
 
 # init script state
 type initrc_state_t, file_type, sysadmfile;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ldconfig.te policy-1.19.15/domains/program/ldconfig.te
--- nsapolicy/domains/program/ldconfig.te	2004-12-11 06:31:18.000000000 -0500
+++ policy-1.19.15/domains/program/ldconfig.te	2004-12-22 11:18:14.000000000 -0500
@@ -24,6 +24,7 @@
 file_type_auto_trans(ldconfig_t, etc_t, ld_so_cache_t, file)
 allow ldconfig_t lib_t:dir rw_dir_perms;
 allow ldconfig_t lib_t:lnk_file create_lnk_perms;
+allow ldconfig_t lib_t:file r_file_perms;
 
 allow ldconfig_t userdomain:fd use;
 # unlink for when /etc/ld.so.cache is mislabeled
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/amanda.te policy-1.19.15/domains/program/unused/amanda.te
--- nsapolicy/domains/program/unused/amanda.te	2004-12-02 14:11:41.000000000 -0500
+++ policy-1.19.15/domains/program/unused/amanda.te	2004-12-22 11:18:14.000000000 -0500
@@ -241,8 +241,6 @@
 allow amanda_recover_t self:process { fork sigkill sigstop sigchld signal };
 allow amanda_recover_t self:capability { fowner fsetid setgid setuid chown dac_override net_bind_service };
 allow amanda_recover_t shell_exec_t:file { execute execute_no_trans getattr read };
-allow amanda_recover_t local_login_t:fd use;
-
 
 # amrecover network and process communication
 #############################################
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.19.15/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2004-12-21 10:59:57.000000000 -0500
+++ policy-1.19.15/domains/program/unused/apache.te	2004-12-22 11:18:14.000000000 -0500
@@ -156,6 +156,7 @@
 # Allow the httpd_t to read the web servers config files
 ###################################################
 r_dir_file(httpd_t, httpd_config_t)
+dontaudit httpd_sys_script_t httpd_config_t:dir search;
 # allow logrotate to read the config files for restart
 ifdef(`logrotate.te', `
 r_dir_file(logrotate_t, httpd_config_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apmd.te policy-1.19.15/domains/program/unused/apmd.te
--- nsapolicy/domains/program/unused/apmd.te	2004-12-09 10:26:08.000000000 -0500
+++ policy-1.19.15/domains/program/unused/apmd.te	2004-12-22 11:18:14.000000000 -0500
@@ -131,3 +131,5 @@
 dontaudit apmd_t tmpfs_t:dir r_dir_perms;
 dontaudit apmd_t selinux_config_t:dir search;
 allow apmd_t user_tty_type:chr_file rw_file_perms;
+# Access /dev/apm_bios.
+allow initrc_t apm_bios_t:chr_file { setattr getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/arpwatch.te policy-1.19.15/domains/program/unused/arpwatch.te
--- nsapolicy/domains/program/unused/arpwatch.te	2004-12-02 14:11:41.000000000 -0500
+++ policy-1.19.15/domains/program/unused/arpwatch.te	2004-12-22 11:18:14.000000000 -0500
@@ -35,3 +35,8 @@
 allow arpwatch_t bin_t:dir search;
 ')
 
+ifdef(`distro_gentoo', `
+allow initrc_t arpwatch_data_t:dir { add_name write };
+allow initrc_t arpwatch_data_t:file create;
+')dnl end distro_gentoo
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/bootloader.te policy-1.19.15/domains/program/unused/bootloader.te
--- nsapolicy/domains/program/unused/bootloader.te	2004-12-03 14:42:06.000000000 -0500
+++ policy-1.19.15/domains/program/unused/bootloader.te	2004-12-22 11:18:14.000000000 -0500
@@ -29,7 +29,7 @@
 allow bootloader_t { initrc_t privfd }:fd use;
 
 tmp_domain(bootloader, `, device_type')
-allow bootloader_t bootloader_tmp_t:devfile_class_set create_file_perms;
+allow bootloader_t bootloader_tmp_t:{ devfile_class_set lnk_file } create_file_perms;
 
 read_locale(bootloader_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.19.15/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2004-12-11 06:31:19.000000000 -0500
+++ policy-1.19.15/domains/program/unused/cups.te	2004-12-22 11:18:14.000000000 -0500
@@ -33,10 +33,8 @@
 # temporary solution, we need something better
 allow cupsd_t serial_device:chr_file rw_file_perms;
 
-ifdef(`usbmodules.te', `
 r_dir_file(cupsd_t, usbdevfs_t)
 r_dir_file(cupsd_t, usbfs_t)
-')
 
 ifdef(`logrotate.te', `
 domain_auto_trans(logrotate_t, cupsd_exec_t, cupsd_t)
@@ -166,6 +164,8 @@
 
 allow cupsd_t printconf_t:file { getattr read };
 
+dbusd_client(system, cupsd)
+
 ifdef(`hald.te', `
 
 # CUPS configuration daemon
@@ -201,7 +201,6 @@
 
 allow cupsd_config_t self:unix_stream_socket create_socket_perms;
 ifdef(`dbusd.te', `
-dbusd_client(system, cupsd)
 dbusd_client(system, cupsd_config)
 allow cupsd_config_t userdomain:dbus send_msg;
 allow cupsd_config_t system_dbusd_t:dbus { send_msg acquire_svc };
@@ -243,3 +242,8 @@
 # Alternatives asks for this
 allow cupsd_config_t initrc_exec_t:file getattr;
 ') dnl end if hald.te
+ifdef(`targeted_policy', `
+can_unix_connect(cupsd_t, unconfined_t)
+allow cupsd_t unconfined_t:dbus send_msg;
+')
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dbusd.te policy-1.19.15/domains/program/unused/dbusd.te
--- nsapolicy/domains/program/unused/dbusd.te	2004-11-05 23:24:16.000000000 -0500
+++ policy-1.19.15/domains/program/unused/dbusd.te	2004-12-22 11:18:14.000000000 -0500
@@ -16,3 +16,5 @@
 
 # I expect we need more than this
 
+allow initrc_t system_dbusd_t:dbus { send_msg acquire_svc };
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/gpm.te policy-1.19.15/domains/program/unused/gpm.te
--- nsapolicy/domains/program/unused/gpm.te	2004-11-30 05:59:38.000000000 -0500
+++ policy-1.19.15/domains/program/unused/gpm.te	2004-12-22 11:18:14.000000000 -0500
@@ -40,3 +40,6 @@
 allow gpm_t device_t:lnk_file { getattr read };
 
 read_locale(gpm_t)
+
+allow initrc_t gpmctl_t:sock_file setattr;
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/inetd.te policy-1.19.15/domains/program/unused/inetd.te
--- nsapolicy/domains/program/unused/inetd.te	2004-11-05 23:24:16.000000000 -0500
+++ policy-1.19.15/domains/program/unused/inetd.te	2004-12-22 11:18:14.000000000 -0500
@@ -18,7 +18,7 @@
 # Rules for the inetd_t domain.
 #
 
-daemon_domain(inetd, `ifdef(`unlimitedInetd', `,admin, etc_writer, fs_domain, auth_write, privmem')' )
+daemon_domain(inetd, `ifdef(`unlimitedInetd', `,admin, etc_writer, fs_domain, auth_write, privmem, unrestricted')' )
 
 can_network(inetd_t)
 allow inetd_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/innd.te policy-1.19.15/domains/program/unused/innd.te
--- nsapolicy/domains/program/unused/innd.te	2004-11-20 22:29:09.000000000 -0500
+++ policy-1.19.15/domains/program/unused/innd.te	2004-12-22 11:18:14.000000000 -0500
@@ -76,6 +76,5 @@
 
 allow innd_t self:file { getattr read };
 dontaudit innd_t selinux_config_t:dir { search };
-allow system_crond_t innd_etc_t:file { getattr read };
 allow innd_t bin_t:lnk_file { read };
 allow innd_t sbin_t:lnk_file { read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/kerberos.te policy-1.19.15/domains/program/unused/kerberos.te
--- nsapolicy/domains/program/unused/kerberos.te	2004-12-11 06:31:19.000000000 -0500
+++ policy-1.19.15/domains/program/unused/kerberos.te	2004-12-22 12:43:28.000000000 -0500
@@ -44,11 +44,10 @@
 can_tcp_connect(kerberos_admin_port_t, kadmind_t)
 
 # Bind to the kerberos, kerberos-adm ports.
-allow krb5kdc_t kerberos_port_t:udp_socket name_bind;
-allow krb5kdc_t kerberos_port_t:tcp_socket name_bind;
+allow krb5kdc_t kerberos_port_t:{ udp_socket tcp_socket } name_bind;
 allow kadmind_t kerberos_admin_port_t:{ udp_socket tcp_socket } name_bind;
-dontaudit kadmind_t reserved_port_type:tcp_socket name_bind;
 allow kadmind_t reserved_port_t:tcp_socket name_bind;
+dontaudit kadmind_t reserved_port_type:tcp_socket name_bind;
 
 #
 # Rules for Kerberos5 KDC daemon
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/lpd.te policy-1.19.15/domains/program/unused/lpd.te
--- nsapolicy/domains/program/unused/lpd.te	2004-12-02 14:11:42.000000000 -0500
+++ policy-1.19.15/domains/program/unused/lpd.te	2004-12-22 11:18:14.000000000 -0500
@@ -154,3 +154,8 @@
 # checkpc needs similar permissions.
 allow checkpc_t printconf_t:file getattr;
 allow checkpc_t printconf_t:dir { getattr search read };
+
+# Read printconf files.
+allow initrc_t printconf_t:dir r_dir_perms;
+allow initrc_t printconf_t:file r_file_perms;
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mta.te policy-1.19.15/domains/program/unused/mta.te
--- nsapolicy/domains/program/unused/mta.te	2004-12-11 06:31:19.000000000 -0500
+++ policy-1.19.15/domains/program/unused/mta.te	2004-12-22 11:18:14.000000000 -0500
@@ -76,3 +76,4 @@
 create_dir_file( system_mail_t, mqueue_spool_t)
 ')
 allow system_mail_t etc_runtime_t:file { getattr read };
+allow system_mail_t urandom_device_t:chr_file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nscd.te policy-1.19.15/domains/program/unused/nscd.te
--- nsapolicy/domains/program/unused/nscd.te	2004-12-21 10:59:57.000000000 -0500
+++ policy-1.19.15/domains/program/unused/nscd.te	2004-12-22 11:18:14.000000000 -0500
@@ -70,4 +70,4 @@
 allow nscd_t self:netlink_route_socket r_netlink_socket_perms;
 allow nscd_t tmp_t:dir { search getattr };
 allow nscd_t tmp_t:lnk_file read;
-allow nscd_t urandom_device_t:chr_file { getattr read };
+allow nscd_t { urandom_device_t random_device_t }:chr_file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/pam.te policy-1.19.15/domains/program/unused/pam.te
--- nsapolicy/domains/program/unused/pam.te	2004-09-10 11:01:02.000000000 -0400
+++ policy-1.19.15/domains/program/unused/pam.te	2004-12-22 11:18:14.000000000 -0500
@@ -34,3 +34,6 @@
 
 allow pam_t local_login_t:fd use;
 dontaudit pam_t self:capability sys_tty_config;
+
+allow initrc_t pam_var_run_t:dir rw_dir_perms;
+allow initrc_t pam_var_run_t:file { getattr read unlink };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/portmap.te policy-1.19.15/domains/program/unused/portmap.te
--- nsapolicy/domains/program/unused/portmap.te	2004-12-11 06:31:19.000000000 -0500
+++ policy-1.19.15/domains/program/unused/portmap.te	2004-12-22 12:39:16.000000000 -0500
@@ -23,7 +23,7 @@
 tmp_domain(portmap)
 
 allow portmap_t portmap_port_t:{ udp_socket tcp_socket } name_bind;
-dontaudit portmap_t reserved_port_type:tcp_socket name_bind;
+dontaudit portmap_t reserved_port_type:{ udp_socket tcp_socket } name_bind;
 
 # portmap binds to arbitary ports
 allow portmap_t port_t:{ udp_socket tcp_socket } name_bind;
@@ -55,8 +55,10 @@
 allow portmap_t self:netlink_route_socket r_netlink_socket_perms;
 
 application_domain(portmap_helper)
+role system_r types portmap_helper_t;
 domain_auto_trans(initrc_t, portmap_helper_exec_t, portmap_helper_t)
 dontaudit portmap_helper_t self:capability { net_admin };
+allow portmap_helper_t self:capability { net_bind_service };
 allow portmap_helper_t { var_run_t initrc_var_run_t } :file rw_file_perms;
 allow portmap_helper_t self:netlink_route_socket r_netlink_socket_perms;
 can_network(portmap_helper_t)
@@ -64,4 +66,5 @@
 dontaudit portmap_helper_t admin_tty_type:chr_file rw_file_perms;
 allow portmap_helper_t etc_t:file { getattr read };
 dontaudit portmap_helper_t userdomain:fd use;
-allow portmap_helper_t reserved_port_t:udp_socket name_bind;
+allow portmap_helper_t reserved_port_t:{ tcp_socket udp_socket } name_bind;
+dontaudit portmap_helper_t reserved_port_type:{ tcp_socket udp_socket } name_bind;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postgresql.te policy-1.19.15/domains/program/unused/postgresql.te
--- nsapolicy/domains/program/unused/postgresql.te	2004-12-11 06:31:19.000000000 -0500
+++ policy-1.19.15/domains/program/unused/postgresql.te	2004-12-22 11:18:14.000000000 -0500
@@ -112,7 +112,7 @@
 dontaudit postgresql_t selinux_config_t:dir { search };
 allow postgresql_t mail_spool_t:dir { search };
 rw_dir_create_file(postgresql_t, var_lock_t)
-can_exec(postgresql_t, { shell_exec_t bin_t } )
+can_exec(postgresql_t, { shell_exec_t bin_t postgresql_exec_t ls_exec_t } )
 ifdef(`apache.te', `
 # 
 # Allow httpd to work with postgresql
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rhgb.te policy-1.19.15/domains/program/unused/rhgb.te
--- nsapolicy/domains/program/unused/rhgb.te	2004-12-11 06:31:19.000000000 -0500
+++ policy-1.19.15/domains/program/unused/rhgb.te	2004-12-22 11:18:14.000000000 -0500
@@ -93,3 +93,8 @@
 ')
 allow rhgb_t xdm_xserver_tmp_t:file { getattr read };
 dontaudit rhgb_t default_t:file read;
+
+allow initrc_t ramfs_t:dir search;
+allow initrc_t ramfs_t:sock_file write;
+allow initrc_t rhgb_t:unix_stream_socket { read write };
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpm.te policy-1.19.15/domains/program/unused/rpm.te
--- nsapolicy/domains/program/unused/rpm.te	2004-11-20 22:29:09.000000000 -0500
+++ policy-1.19.15/domains/program/unused/rpm.te	2004-12-22 11:18:14.000000000 -0500
@@ -244,6 +244,10 @@
 
 allow rpm_script_t domain:process { signal signull };
 
+# Access /var/lib/rpm.
+allow initrc_t rpm_var_lib_t:dir rw_dir_perms;
+allow initrc_t rpm_var_lib_t:file create_file_perms;
+
 ifdef(`unlimitedRPM', `
 unconfined_domain(rpm_t)
 unconfined_domain(rpm_script_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/sendmail.te policy-1.19.15/domains/program/unused/sendmail.te
--- nsapolicy/domains/program/unused/sendmail.te	2004-12-21 10:59:57.000000000 -0500
+++ policy-1.19.15/domains/program/unused/sendmail.te	2004-12-22 12:48:29.000000000 -0500
@@ -53,6 +53,8 @@
 # for the start script to run make -C /etc/mail
 allow initrc_t etc_mail_t:dir rw_dir_perms;
 allow initrc_t etc_mail_t:file create_file_perms;
+allow system_mail_t initrc_t:fd use;
+allow system_mail_t initrc_t:fifo_file write;
 
 # Write to /var/spool/mail and /var/spool/mqueue.
 allow sendmail_t var_spool_t:dir { getattr search };
@@ -97,9 +99,12 @@
 allow system_mail_t mqueue_spool_t:file create_file_perms;
 
 allow system_mail_t sysctl_kernel_t:file read;
+ifdef(`crond.te', `
 dontaudit system_mail_t system_crond_tmp_t:file append;
+')
 dontaudit sendmail_t admin_tty_type:chr_file { getattr ioctl };
 
 # sendmail wants to read /var/run/utmp if the controlling tty is /dev/console
 allow sendmail_t initrc_var_run_t:file { getattr read };
 dontaudit sendmail_t initrc_var_run_t:file { lock write };
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/sound.te policy-1.19.15/domains/program/unused/sound.te
--- nsapolicy/domains/program/unused/sound.te	2004-03-23 15:58:08.000000000 -0500
+++ policy-1.19.15/domains/program/unused/sound.te	2004-12-22 11:18:14.000000000 -0500
@@ -23,3 +23,4 @@
 # Read and write ttys.
 allow sound_t sysadm_tty_device_t:chr_file rw_file_perms;
 read_locale(sound_t)
+allow initrc_t sound_file_t:file { setattr write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/squid.te policy-1.19.15/domains/program/unused/squid.te
--- nsapolicy/domains/program/unused/squid.te	2004-12-11 06:31:19.000000000 -0500
+++ policy-1.19.15/domains/program/unused/squid.te	2004-12-22 11:18:14.000000000 -0500
@@ -15,7 +15,7 @@
 
 daemon_domain(squid, `, web_client_domain, nscd_client_domain')
 type squid_conf_t, file_type, sysadmfile;
-
+general_domain_access(squid_t)
 allow { squid_t initrc_t } squid_conf_t:file r_file_perms;
 allow squid_t squid_conf_t:dir r_dir_perms;
 allow squid_t squid_conf_t:lnk_file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.19.15/domains/program/unused/udev.te
--- nsapolicy/domains/program/unused/udev.te	2004-12-01 16:51:43.000000000 -0500
+++ policy-1.19.15/domains/program/unused/udev.te	2004-12-22 11:18:14.000000000 -0500
@@ -24,8 +24,9 @@
 #
 # Rules used for udev
 #
-type udev_tbl_t, file_type, sysadmfile, dev_fs;
-file_type_auto_trans(udev_t, device_t, udev_tbl_t, file)
+type udev_tdb_t, file_type, sysadmfile, dev_fs;
+typealias udev_tdb_t alias udev_tbl_t;
+file_type_auto_trans(udev_t, device_t, udev_tdb_t, { file dir })
 allow udev_t self:capability { chown dac_override dac_read_search fowner fsetid sys_admin mknod net_raw net_admin };
 allow udev_t self:file { getattr read };
 allow udev_t self:unix_stream_socket {connectto create_stream_socket_perms};
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/winbind.te policy-1.19.15/domains/program/unused/winbind.te
--- nsapolicy/domains/program/unused/winbind.te	2004-12-20 16:27:44.000000000 -0500
+++ policy-1.19.15/domains/program/unused/winbind.te	2004-12-22 11:18:14.000000000 -0500
@@ -21,13 +21,13 @@
 type samba_secrets_t, file_type, sysadmfile;
 ')
 rw_dir_file(winbind_t, samba_etc_t)
-rw_dir_file(winbind_t, samba_log_t)
+rw_dir_create_file(winbind_t, samba_log_t)
 allow winbind_t samba_secrets_t:file rw_file_perms;
 allow winbind_t self:unix_dgram_socket create_socket_perms;
 allow winbind_t self:unix_stream_socket create_stream_socket_perms;
 allow winbind_t urandom_device_t:chr_file { getattr read };
 allow winbind_t self:fifo_file { read write };
-rw_dir_file(winbind_t, samba_var_t)
+rw_dir_create_file(winbind_t, samba_var_t)
 allow winbind_t krb5_conf_t:file { getattr read };
 dontaudit winbind_t krb5_conf_t:file { write };
 allow winbind_t self:netlink_route_socket r_netlink_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xfs.te policy-1.19.15/domains/program/unused/xfs.te
--- nsapolicy/domains/program/unused/xfs.te	2004-12-11 06:31:19.000000000 -0500
+++ policy-1.19.15/domains/program/unused/xfs.te	2004-12-22 11:18:14.000000000 -0500
@@ -40,3 +40,11 @@
 # Read /usr/X11R6/lib/X11/fonts/.* and /usr/share/fonts/.*
 allow xfs_t fonts_t:dir search;
 allow xfs_t fonts_t:file { getattr read };
+
+# Unlink the xfs socket.
+allow initrc_t xfs_tmp_t:dir rw_dir_perms;
+allow initrc_t xfs_tmp_t:dir rmdir;
+allow initrc_t xfs_tmp_t:sock_file { read getattr unlink };
+allow initrc_t fonts_t:dir create_dir_perms;
+allow initrc_t fonts_t:file create_file_perms;
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ypbind.te policy-1.19.15/domains/program/unused/ypbind.te
--- nsapolicy/domains/program/unused/ypbind.te	2004-12-11 06:31:19.000000000 -0500
+++ policy-1.19.15/domains/program/unused/ypbind.te	2004-12-22 12:40:26.000000000 -0500
@@ -37,6 +37,7 @@
 allow ypbind_t etc_t:file { getattr read };
 allow ypbind_t self:{ unix_dgram_socket unix_stream_socket } create_socket_perms;
 allow ypbind_t self:netlink_route_socket r_netlink_socket_perms;
-allow ypbind_t reserved_port_t:tcp_socket name_bind;
-allow ypbind_t reserved_port_t:udp_socket name_bind;
-dontaudit ypbind_t reserved_port_type:udp_socket name_bind;
+allow ypbind_t reserved_port_t:{ tcp_socket udp_socket } name_bind;
+dontaudit ypbind_t reserved_port_type:{ tcp_socket udp_socket } name_bind;
+can_udp_send(initrc_t, ypbind_t)
+
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/distros.fc policy-1.19.15/file_contexts/distros.fc
--- nsapolicy/file_contexts/distros.fc	2004-12-21 10:59:57.000000000 -0500
+++ policy-1.19.15/file_contexts/distros.fc	2004-12-22 11:18:14.000000000 -0500
@@ -35,6 +35,33 @@
 /usr/share/texmf/web2c/mktexnam	--	system_u:object_r:bin_t
 /usr/share/texmf/web2c/mktexupd	--	system_u:object_r:bin_t
 /usr/share/ssl/misc(/.*)?		system_u:object_r:bin_t
+#
+# /emul/ia32-linux/usr
+#
+/emul(/.*)?				system_u:object_r:usr_t
+/emul/ia32-linux/usr(/.*)?/lib(/.*)?		system_u:object_r:lib_t
+/emul/ia32-linux/usr(/.*)?/lib/.*\.so(\.[^/]*)*		--	system_u:object_r:shlib_t
+/emul/ia32-linux/usr(/.*)?/java/.*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
+/emul/ia32-linux/usr(/.*)?/java/.*\.jar	--	system_u:object_r:shlib_t
+/emul/ia32-linux/usr(/.*)?/java/.*\.jsa	--	system_u:object_r:shlib_t
+/emul/ia32-linux/usr(/.*)?/lib(/.*)?/ld-[^/]*\.so(\.[^/]*)* system_u:object_r:ld_so_t
+/emul/ia32-linux/usr(/.*)?/bin(/.*)?		system_u:object_r:bin_t
+/emul/ia32-linux/usr(/.*)?/Bin(/.*)?		system_u:object_r:bin_t
+/emul/ia32-linux/usr(/.*)?/sbin(/.*)?		system_u:object_r:sbin_t
+/emul/ia32-linux/usr/libexec(/.*)?		system_u:object_r:bin_t
+# /emul/ia32-linux/lib
+/emul/ia32-linux/lib(/.*)?					system_u:object_r:lib_t
+/emul/ia32-linux/lib/.*\.so(\.[^/]*)*		--	system_u:object_r:shlib_t
+/emul/ia32-linux/lib(/.*)?/ld-[^/]*\.so(\.[^/]*)*	--	system_u:object_r:ld_so_t
+# /emul/ia32-linux/bin
+/emul/ia32-linux/bin(/.*)?			system_u:object_r:bin_t
+# /emul/ia32-linux/sbin
+/emul/ia32-linux/sbin(/.*)?			system_u:object_r:sbin_t
+
+ifdef(`dbusd.te', `', `
+/var/run/dbus(/.*)?            system_u:object_r:system_dbusd_var_run_t
+')
+
 ')
 
 ifdef(`distro_suse', `
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/cups.fc policy-1.19.15/file_contexts/program/cups.fc
--- nsapolicy/file_contexts/program/cups.fc	2004-11-24 07:00:50.000000000 -0500
+++ policy-1.19.15/file_contexts/program/cups.fc	2004-12-22 11:18:14.000000000 -0500
@@ -29,9 +29,6 @@
 /var/run/cups/printcap	--	system_u:object_r:cupsd_var_run_t
 /usr/lib(64)?/cups/filter/.*	--	system_u:object_r:bin_t
 /usr/lib(64)?/cups/cgi-bin/.* --	system_u:object_r:bin_t
-/usr/bin/lpr\.cups	--	system_u:object_r:lpr_exec_t
-/usr/bin/lpq\.cups	--	system_u:object_r:lpr_exec_t
-/usr/bin/lprm\.cups	--	system_u:object_r:lpr_exec_t
 /usr/sbin/ptal-printd	--	system_u:object_r:ptal_exec_t
 /usr/sbin/ptal-mlcd	--	system_u:object_r:ptal_exec_t
 /var/run/ptal-printd(/.*)?	system_u:object_r:ptal_var_run_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/kerberos.fc policy-1.19.15/file_contexts/program/kerberos.fc
--- nsapolicy/file_contexts/program/kerberos.fc	2004-11-19 11:20:43.000000000 -0500
+++ policy-1.19.15/file_contexts/program/kerberos.fc	2004-12-22 11:18:14.000000000 -0500
@@ -9,4 +9,3 @@
 /var/log/krb5kdc\.log			system_u:object_r:krb5kdc_log_t
 /var/log/kadmind\.log			system_u:object_r:kadmind_log_t
 /usr(/local)?/bin/ksu		--	system_u:object_r:su_exec_t
-/usr/kerberos/sbin/login\.krb5	--	system_u:object_r:login_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/login.fc policy-1.19.15/file_contexts/program/login.fc
--- nsapolicy/file_contexts/program/login.fc	2003-11-26 13:01:07.000000000 -0500
+++ policy-1.19.15/file_contexts/program/login.fc	2004-12-22 11:18:14.000000000 -0500
@@ -1,2 +1,3 @@
 # login
 /bin/login		--	system_u:object_r:login_exec_t
+/usr/kerberos/sbin/login\.krb5	--	system_u:object_r:login_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/lpr.fc policy-1.19.15/file_contexts/program/lpr.fc
--- nsapolicy/file_contexts/program/lpr.fc	2003-11-26 13:01:07.000000000 -0500
+++ policy-1.19.15/file_contexts/program/lpr.fc	2004-12-22 11:18:14.000000000 -0500
@@ -1,4 +1,4 @@
 # lp utilities.
-/usr/bin/lpr		--	system_u:object_r:lpr_exec_t
-/usr/bin/lpq		--	system_u:object_r:lpr_exec_t
-/usr/bin/lprm		--	system_u:object_r:lpr_exec_t
+/usr/bin/lpr(\.cups)?	--	system_u:object_r:lpr_exec_t
+/usr/bin/lpq(\.cups)?	--	system_u:object_r:lpr_exec_t
+/usr/bin/lprm(\.cups)?	--	system_u:object_r:lpr_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/postgresql.fc policy-1.19.15/file_contexts/program/postgresql.fc
--- nsapolicy/file_contexts/program/postgresql.fc	2004-11-19 11:20:44.000000000 -0500
+++ policy-1.19.15/file_contexts/program/postgresql.fc	2004-12-22 11:18:14.000000000 -0500
@@ -4,6 +4,7 @@
 /usr/bin/pg_dump	--	system_u:object_r:postgresql_exec_t
 /usr/bin/pg_dumpall	--	system_u:object_r:postgresql_exec_t
 /usr/bin/pg_resetxlog	--	system_u:object_r:postgresql_exec_t
+/usr/bin/initdb		--	system_u:object_r:postgresql_exec_t
 
 # not sure whether the following binaries need labelling
 /usr/bin/createlang	--	system_u:object_r:postgresql_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/udev.fc policy-1.19.15/file_contexts/program/udev.fc
--- nsapolicy/file_contexts/program/udev.fc	2004-11-19 11:20:44.000000000 -0500
+++ policy-1.19.15/file_contexts/program/udev.fc	2004-12-22 11:18:14.000000000 -0500
@@ -8,5 +8,5 @@
 /etc/udev/scripts/.+	-- system_u:object_r:udev_helper_exec_t
 /etc/hotplug\.d/default/udev.* -- system_u:object_r:udev_helper_exec_t
 /dev/udev\.tbl	--	system_u:object_r:udev_tbl_t
-/dev/\.udev\.tdb --	system_u:object_r:udev_tbl_t
+/dev/\.udev\.tdb(/.*)?	system_u:object_r:udev_tdb_t
 /sbin/wait_for_sysfs -- system_u:object_r:udev_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te policy-1.19.15/macros/global_macros.te
--- nsapolicy/macros/global_macros.te	2004-12-21 10:59:58.000000000 -0500
+++ policy-1.19.15/macros/global_macros.te	2004-12-22 12:56:43.883461279 -0500
@@ -233,8 +233,8 @@
 role system_r types $1_t;
 
 # Inherit and use descriptors from init.
-allow $1_t init_t:fd use;
-allow $1_t init_t:process sigchld;
+allow $1_t { unconfined_t init_t }:fd use;
+allow $1_t { unconfined_t init_t }:process sigchld;
 allow $1_t self:process { signal_perms fork };
 
 uses_shlib($1_t)
@@ -242,7 +242,7 @@
 allow $1_t { self proc_t }:dir r_dir_perms;
 allow $1_t { self proc_t }:lnk_file read;
 
-allow $1_t device_t:dir { getattr search };
+r_dir_file($1_t, device_t)
 allow $1_t null_device_t:chr_file rw_file_perms;
 dontaudit $1_t console_device_t:chr_file rw_file_perms;
 dontaudit $1_t unpriv_userdomain:fd use;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/network_macros.te policy-1.19.15/macros/network_macros.te
--- nsapolicy/macros/network_macros.te	2004-11-24 14:44:37.000000000 -0500
+++ policy-1.19.15/macros/network_macros.te	2004-12-22 11:18:14.000000000 -0500
@@ -144,11 +144,13 @@
 can_network_tcp($1, `$2')
 can_network_udp($1, `$2')
 
+ifdef(`mount.te', `
 #
 # Allow the domain to send NFS client requests via the socket
 # created by mount.
 #
 allow $1 mount_t:udp_socket rw_socket_perms;
+')
 
 ')dnl end can_network definition
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/dbusd_macros.te policy-1.19.15/macros/program/dbusd_macros.te
--- nsapolicy/macros/program/dbusd_macros.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.15/macros/program/dbusd_macros.te	2004-12-22 11:18:14.000000000 -0500
@@ -54,25 +54,25 @@
 #
 # Define a new derived domain for connecting to dbus_type
 # from domain_prefix_t. 
-define(`dbusd_client',`')
-ifdef(`dbusd.te',`
 undefine(`dbusd_client')
 define(`dbusd_client',`
 
+ifdef(`dbusd.te',`
 # Derived type used for connection
 type $2_dbusd_$1_t;
 type_change $2_t $1_dbusd_t:dbus $2_dbusd_$1_t;
 
+# SE-DBus specific permissions
+allow $2_dbusd_$1_t { $1_dbusd_t self }:dbus send_msg;
+
 # For connecting to the bus
 allow $2_t $1_dbusd_t:unix_stream_socket connectto;
+
+') dnl endif dbusd.te
 ifelse(`system', `$1', `
 allow { $2_t } { var_run_t system_dbusd_var_run_t }:dir search;
 allow { $2_t } system_dbusd_var_run_t:sock_file write;
-',`
-') dnl endif system
-# SE-DBus specific permissions
-allow $2_dbusd_$1_t { $1_dbusd_t self }:dbus send_msg;
-') dnl endif dbusd.te
+',`') dnl endif system
 ')
 
 # can_dbusd_converse(dbus_type, domain_prefix_a, domain_prefix_b)
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/assert.te policy-1.19.15/targeted/assert.te
--- nsapolicy/targeted/assert.te	2004-11-30 16:05:23.000000000 -0500
+++ policy-1.19.15/targeted/assert.te	2004-12-22 11:18:14.000000000 -0500
@@ -22,10 +22,10 @@
 
 # Confined domains must never touch an unconfined domain except to
 # send SIGCHLD for child termination notifications.
-neverallow { domain - unconfined_t } unconfined_t:process ~sigchld;
+neverallow { domain -unconfined_t -unrestricted } unconfined_t:process ~sigchld;
 
 # Confined domains must never see unconfined domain's /proc/pid entries.
-neverallow { domain - unconfined_t } unconfined_t:dir { getattr search };
+neverallow { domain -unconfined_t -unrestricted } unconfined_t:dir { getattr search };
 
 #
 # Verify that every type that can be entered by
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/program/initrc.te policy-1.19.15/targeted/domains/program/initrc.te
--- nsapolicy/targeted/domains/program/initrc.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.15/targeted/domains/program/initrc.te	1969-12-31 19:00:00.000000000 -0500
@@ -1,16 +0,0 @@
-#DESC Initrc - System initialization scripts
-#
-# Authors:  Daniel Walsh <dwalsh@redhat.com>
-#
-
-#################################
-#
-# Rules for the initrc_t domain.
-#
-# initrc_exec_t is the type of the rc.sysinit and other programs.
-# This domain is defined just for targeted policy to allow easy conversion to
-# strict policy.  
-#
-type initrc_exec_t, file_type, sysadmfile, exec_type;
-type run_init_exec_t, file_type, sysadmfile, exec_type;
-typealias var_run_t alias initrc_var_run_t;
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/program/init.te policy-1.19.15/targeted/domains/program/init.te
--- nsapolicy/targeted/domains/program/init.te	2004-09-20 15:41:01.000000000 -0400
+++ policy-1.19.15/targeted/domains/program/init.te	1969-12-31 19:00:00.000000000 -0500
@@ -1,18 +0,0 @@
-#DESC Init - Process initialization
-#
-# Authors:  Daniel Walsh <dwalsh@redhat.com>
-#
-
-#################################
-#
-# Rules for the init_t domain.
-#
-# init_exec_t is the type of the init program.
-# initctl_t is the type of the named pipe created 
-# by init during initialization.  This pipe is used
-# to communicate with init.
-# This domain is defined just for targeted policy to allow easy conversion to
-# strict policy.  /sbin/init will get this policy.
-#
-type init_exec_t, file_type, sysadmfile, exec_type;
-type initctl_t, file_type, sysadmfile, dev_fs;
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/program/udev.te policy-1.19.15/targeted/domains/program/udev.te
--- nsapolicy/targeted/domains/program/udev.te	2004-09-20 15:41:01.000000000 -0400
+++ policy-1.19.15/targeted/domains/program/udev.te	2004-12-22 11:18:14.000000000 -0500
@@ -13,4 +13,5 @@
 #
 type udev_exec_t, file_type, sysadmfile, exec_type;
 type udev_helper_exec_t, file_type, sysadmfile, exec_type;
-type udev_tbl_t, file_type, sysadmfile, dev_fs;
+type udev_tdb_t, file_type, sysadmfile, dev_fs;
+typealias udev_tdb_t alias udev_tbl_t;
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/unconfined.te policy-1.19.15/targeted/domains/unconfined.te
--- nsapolicy/targeted/domains/unconfined.te	2004-11-20 22:29:10.000000000 -0500
+++ policy-1.19.15/targeted/domains/unconfined.te	2004-12-22 11:18:14.000000000 -0500
@@ -13,11 +13,12 @@
 # Define some type aliases to help with compatibility with
 # macros and domains from the "strict" policy.
 typealias bin_t alias su_exec_t;
-typealias unconfined_t alias { kernel_t init_t initrc_t sysadm_t rpm_t rpm_script_t logrotate_t };
-type mount_t, domain;
-type initrc_devpts_t, ptyfile;
+typealias unconfined_t alias { kernel_t sysadm_t rpm_t rpm_script_t logrotate_t };
 define(`admin_tty_type', `{ tty_device_t devpts_t }')
 
+#type of rundir to communicate with dbus
+type system_dbusd_var_run_t, file_type, sysadmfile;
+
 # User home directory type.
 type user_home_t, file_type, sysadmfile;
 type user_home_dir_t, file_type, sysadmfile;
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.19.15/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-08-20 13:57:29.000000000 -0400
+++ policy-1.19.15/tunables/distro.tun	2004-12-22 11:18:14.000000000 -0500
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.19.15/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-12-11 06:31:22.000000000 -0500
+++ policy-1.19.15/tunables/tunable.tun	2004-12-22 11:18:14.000000000 -0500
@@ -1,27 +1,24 @@
-# Allow users to execute the mount command
-dnl define(`user_can_mount')
-
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

--------------060806030300050108060800--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

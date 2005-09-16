Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8JHuBNs020496
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 13:56:11 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8JHqGeY009483
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 17:52:16 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j8JHqB8f025858
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 13:52:11 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j8JHqBDv025857
	for selinux@tycho.nsa.gov; Mon, 19 Sep 2005 13:52:11 -0400
Message-ID: <432B043B.9020305@redhat.com>
Date: Fri, 16 Sep 2005 13:43:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Latest Diffs
Content-Type: multipart/mixed;
 boundary="------------020904010808010803090406"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020904010808010803090406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add can_access_pty macro to handle pty output.

FIxes to make initrc scripts work

Allow login to work with pam_console and alsa

mcs transition rules

Allow users to interact with alsa.

Many fixes for amanda

added nsswithch_domain for any apps that communicate using nsswitch. 
Consolodates can_ypbind, can_ldap, can_resolve, can_winbind.

Allow httpd to run as relay.

FIxes for apmd and audit, bluetooth and automount

More features for hplip under cups.

dovecot needs to be able to write to mail_spool_t

mysql can connect out to other mysql ports.


Added openct, pegusus, readahead policies, roundup

Allow squid to relay additional protocols.

Remove mqueue genfscon entry

Change makefile to default to MCS policy.

Add dhcpd and pegasus ports

remove sysadm_r role from unconfined_t

Add capifs_t support.




-- 



--------------020904010808010803090406
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/crond.te policy-1.27.1/domains/program/crond.te
--- nsapolicy/domains/program/crond.te	2005-09-16 11:17:08.000000000 -0400
+++ policy-1.27.1/domains/program/crond.te	2005-09-16 11:35:39.000000000 -0400
@@ -106,7 +106,7 @@
 
 # Inherit and use descriptors from initrc for anacron.
 allow system_crond_t initrc_t:fd use;
-allow system_crond_t initrc_devpts_t:chr_file { read write };
+can_access_pty(system_crond_t, initrc)
 
 # Use capabilities.
 allow system_crond_t self:capability { dac_read_search chown setgid setuid fowner net_bind_service fsetid };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/fsadm.te policy-1.27.1/domains/program/fsadm.te
--- nsapolicy/domains/program/fsadm.te	2005-09-16 11:17:08.000000000 -0400
+++ policy-1.27.1/domains/program/fsadm.te	2005-09-16 11:35:39.000000000 -0400
@@ -102,10 +102,10 @@
 allow fsadm_t kernel_t:system syslog_console;
 
 # Access terminals.
-allow fsadm_t { initrc_devpts_t admin_tty_type devtty_t console_device_t }:chr_file rw_file_perms;
+can_access_pty(fsadm_t, initrc)
+allow fsadm_t { admin_tty_type devtty_t console_device_t }:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow fsadm_t sysadm_gph_t:fd use;')
 allow fsadm_t privfd:fd use;
-allow fsadm_t devpts_t:dir { getattr search };
 
 read_locale(fsadm_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/hostname.te policy-1.27.1/domains/program/hostname.te
--- nsapolicy/domains/program/hostname.te	2005-09-16 11:17:08.000000000 -0400
+++ policy-1.27.1/domains/program/hostname.te	2005-09-16 11:35:39.000000000 -0400
@@ -24,5 +24,5 @@
 ifdef(`distro_redhat', `
 allow hostname_t tmpfs_t:chr_file rw_file_perms;
 ')
-allow hostname_t initrc_devpts_t:chr_file { read write };
+can_access_pty(hostname_t, initrc)
 allow hostname_t initrc_t:fd use;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ifconfig.te policy-1.27.1/domains/program/ifconfig.te
--- nsapolicy/domains/program/ifconfig.te	2005-09-16 11:17:08.000000000 -0400
+++ policy-1.27.1/domains/program/ifconfig.te	2005-09-16 11:35:39.000000000 -0400
@@ -52,7 +52,8 @@
 allow ifconfig_t self:udp_socket create_socket_perms;
 
 # Access terminals.
-allow ifconfig_t { user_tty_type initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
+can_access_pty(ifconfig_t, initrc)
+allow ifconfig_t { user_tty_type admin_tty_type }:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow ifconfig_t sysadm_gph_t:fd use;')
 
 allow ifconfig_t tun_tap_device_t:chr_file { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te policy-1.27.1/domains/program/initrc.te
--- nsapolicy/domains/program/initrc.te	2005-09-16 11:17:08.000000000 -0400
+++ policy-1.27.1/domains/program/initrc.te	2005-09-16 11:35:39.000000000 -0400
@@ -214,7 +214,15 @@
 allow initrc_t file_type:{ dir_file_class_set socket_class_set } getattr;
 allow initrc_t self:capability sys_admin;
 allow initrc_t device_t:dir create;
-
+# wants to delete /poweroff and other files 
+allow initrc_t root_t:file unlink;
+# wants to read /.fonts directory
+allow initrc_t default_t:file { getattr read };
+ifdef(`xserver.te', `
+# wants to cleanup xserver log dir
+allow initrc_t xserver_log_t:dir rw_dir_perms;
+allow initrc_t xserver_log_t:file unlink;
+')
 ')dnl end distro_redhat
 
 allow initrc_t system_map_t:{ file lnk_file } r_file_perms;
@@ -322,3 +330,6 @@
 ifdef(`dbusd.te', `
 allow initrc_t system_dbusd_var_run_t:sock_file write;
 ')
+
+# Slapd needs to read cert files from its initscript
+r_dir_file(initrc_t, cert_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ldconfig.te policy-1.27.1/domains/program/ldconfig.te
--- nsapolicy/domains/program/ldconfig.te	2005-09-12 16:40:28.000000000 -0400
+++ policy-1.27.1/domains/program/ldconfig.te	2005-09-16 11:35:39.000000000 -0400
@@ -16,7 +16,8 @@
 
 domain_auto_trans({ sysadm_t initrc_t }, ldconfig_exec_t, ldconfig_t)
 dontaudit ldconfig_t device_t:dir search;
-allow ldconfig_t { initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
+can_access_pty(ldconfig_t, initrc)
+allow ldconfig_t admin_tty_type:chr_file rw_file_perms;
 allow ldconfig_t privfd:fd use;
 
 uses_shlib(ldconfig_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/load_policy.te policy-1.27.1/domains/program/load_policy.te
--- nsapolicy/domains/program/load_policy.te	2005-09-12 16:40:28.000000000 -0400
+++ policy-1.27.1/domains/program/load_policy.te	2005-09-16 11:35:39.000000000 -0400
@@ -45,11 +45,9 @@
 allow load_policy_t root_t:dir search;
 allow load_policy_t etc_t:dir search;
 
-# Read the devpts root directory (needed?)  
-allow load_policy_t devpts_t:dir r_dir_perms;
-
 # Other access
-allow load_policy_t { admin_tty_type initrc_devpts_t devtty_t }:chr_file { read write ioctl getattr };
+can_access_pty(load_policy_t, initrc)
+allow load_policy_t { admin_tty_type devtty_t }:chr_file { read write ioctl getattr };
 uses_shlib(load_policy_t)
 allow load_policy_t self:capability dac_override;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/login.te policy-1.27.1/domains/program/login.te
--- nsapolicy/domains/program/login.te	2005-09-12 16:40:29.000000000 -0400
+++ policy-1.27.1/domains/program/login.te	2005-09-16 11:35:39.000000000 -0400
@@ -62,6 +62,11 @@
 
 ifdef(`pamconsole.te', `
 rw_dir_create_file($1_login_t, pam_var_console_t)
+domain_auto_trans($1_login_t, pam_console_exec_t, pam_console_t)
+')
+
+ifdef(`alsa.te', `
+domain_auto_trans($1_login_t, alsa_exec_t, alsa_t)
 ')
 
 # Use capabilities
@@ -200,23 +205,20 @@
 # since very weak authentication is used.
 login_spawn_domain(remote_login, unpriv_userdomain)
 
-allow remote_login_t devpts_t:dir search;
 allow remote_login_t userpty_type:chr_file { setattr write };
 
 # Use the pty created by rlogind.
 ifdef(`rlogind.te', `
-allow remote_login_t rlogind_devpts_t:chr_file { setattr rw_file_perms };
-
+can_access_pty(remote_login_t, rlogind)
 # Relabel ptys created by rlogind.
-allow remote_login_t rlogind_devpts_t:chr_file { relabelfrom relabelto };
+allow remote_login_t rlogind_devpts_t:chr_file { setattr relabelfrom relabelto };
 ')
 
 # Use the pty created by telnetd.
 ifdef(`telnetd.te', `
-allow remote_login_t telnetd_devpts_t:chr_file { setattr rw_file_perms };
-
+can_access_pty(remote_login_t, telnetd)
 # Relabel ptys created by telnetd.
-allow remote_login_t telnetd_devpts_t:chr_file { relabelfrom relabelto };
+allow remote_login_t telnetd_devpts_t:chr_file { setattr relabelfrom relabelto };
 ')
 
 allow remote_login_t ptyfile:chr_file { getattr relabelfrom relabelto ioctl };
@@ -225,3 +227,8 @@
 # Allow remote login to resolve host names (passed in via the -h switch)
 can_resolve(remote_login_t)
 
+ifdef(`use_mcs', `
+ifdef(`getty.te', `
+range_transition getty_t login_exec_t s0 - s0:c0.c127;
+')
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/modutil.te policy-1.27.1/domains/program/modutil.te
--- nsapolicy/domains/program/modutil.te	2005-09-12 16:40:29.000000000 -0400
+++ policy-1.27.1/domains/program/modutil.te	2005-09-16 11:35:39.000000000 -0400
@@ -59,7 +59,8 @@
 allow depmod_t modules_object_t:file unlink;
 
 # Access terminals.
-allow depmod_t { console_device_t initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
+can_access_pty(depmod_t, initrc)
+allow depmod_t { console_device_t admin_tty_type }:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow depmod_t sysadm_gph_t:fd use;')
 
 # Read System.map from home directories.
@@ -97,7 +98,8 @@
 allow insmod_t usr_t:file { getattr read };
 
 allow insmod_t privfd:fd use;
-allow insmod_t { initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
+can_access_pty(insmod_t, initrc)
+allow insmod_t admin_tty_type:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow insmod_t sysadm_gph_t:fd use;')
 
 allow insmod_t { agp_device_t apm_bios_t }:chr_file { read write };
@@ -138,8 +140,9 @@
 
 allow insmod_t fs_t:filesystem getattr;
 allow insmod_t sysfs_t:dir search;
-allow insmod_t { usbfs_t usbdevfs_t debugfs_t }:dir search;
+allow insmod_t { usbfs_t usbdevfs_t }:dir search;
 allow insmod_t { usbfs_t usbdevfs_t debugfs_t }:filesystem mount;
+r_dir_file(insmod_t, debugfs_t)
 
 # Rules for /proc/sys/kernel/tainted
 read_sysctl(insmod_t)
@@ -162,7 +165,6 @@
 domain_auto_trans(privmodule, insmod_exec_t, insmod_t)
 can_exec(insmod_t, { insmod_exec_t shell_exec_t bin_t sbin_t etc_t })
 allow insmod_t devtty_t:chr_file rw_file_perms;
-allow update_modules_t devpts_t:dir search;
 allow insmod_t privmodule:process sigchld;
 dontaudit sysadm_t self:capability sys_module;
 
@@ -197,8 +199,8 @@
 
 allow update_modules_t device_t:dir { getattr search };
 allow update_modules_t { console_device_t devtty_t }:chr_file rw_file_perms;
-allow update_modules_t { initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
-allow update_modules_t devpts_t:dir search;
+can_access_pty(update_modules_t, initrc)
+allow update_modules_t admin_tty_type:chr_file rw_file_perms;
 
 can_exec(update_modules_t, insmod_exec_t)
 allow update_modules_t urandom_device_t:chr_file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/mount.te policy-1.27.1/domains/program/mount.te
--- nsapolicy/domains/program/mount.te	2005-09-12 16:40:29.000000000 -0400
+++ policy-1.27.1/domains/program/mount.te	2005-09-16 11:35:39.000000000 -0400
@@ -16,7 +16,8 @@
 role sysadm_r types mount_t;
 role system_r types mount_t;
 
-allow mount_t { initrc_devpts_t console_device_t }:chr_file { read write };
+can_access_pty(mount_t, initrc)
+allow mount_t console_device_t:chr_file { read write };
 
 domain_auto_trans(initrc_t, mount_exec_t, mount_t)
 allow mount_t init_t:fd use;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/netutils.te policy-1.27.1/domains/program/netutils.te
--- nsapolicy/domains/program/netutils.te	2005-09-12 16:40:28.000000000 -0400
+++ policy-1.27.1/domains/program/netutils.te	2005-09-16 11:35:39.000000000 -0400
@@ -55,7 +55,8 @@
 
 # Access terminals.
 allow netutils_t privfd:fd use;
-allow netutils_t { initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
+can_access_pty(netutils_t, initrc)
+allow netutils_t admin_tty_type:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow netutils_t sysadm_gph_t:fd use;')
 allow netutils_t proc_t:dir search;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/restorecon.te policy-1.27.1/domains/program/restorecon.te
--- nsapolicy/domains/program/restorecon.te	2005-09-16 11:17:08.000000000 -0400
+++ policy-1.27.1/domains/program/restorecon.te	2005-09-16 11:35:39.000000000 -0400
@@ -19,7 +19,7 @@
 role sysadm_r types restorecon_t;
 role secadm_r types restorecon_t;
 
-allow restorecon_t initrc_devpts_t:chr_file { read write ioctl };
+can_access_pty(restorecon_t, initrc)
 allow restorecon_t { tty_device_t admin_tty_type user_tty_type devtty_t }:chr_file { read write ioctl };
 
 domain_auto_trans({ initrc_t sysadm_t secadm_t }, restorecon_exec_t, restorecon_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/setfiles.te policy-1.27.1/domains/program/setfiles.te
--- nsapolicy/domains/program/setfiles.te	2005-09-12 16:40:29.000000000 -0400
+++ policy-1.27.1/domains/program/setfiles.te	2005-09-16 11:35:39.000000000 -0400
@@ -22,7 +22,7 @@
 ifdef(`distro_redhat', `
 domain_auto_trans(initrc_t, setfiles_exec_t, setfiles_t)
 ')
-allow setfiles_t initrc_devpts_t:chr_file { read write ioctl };
+can_access_pty(hostname_t, initrc)
 allow setfiles_t { ttyfile ptyfile tty_device_t admin_tty_type devtty_t }:chr_file { read write ioctl };
 
 allow setfiles_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ssh.te policy-1.27.1/domains/program/ssh.te
--- nsapolicy/domains/program/ssh.te	2005-09-16 11:17:08.000000000 -0400
+++ policy-1.27.1/domains/program/ssh.te	2005-09-16 11:35:39.000000000 -0400
@@ -153,6 +153,7 @@
 #
 sshd_program_domain(sshd)
 if (ssh_sysadm_login) {
+allow sshd_t devpts_t:dir r_dir_perms;
 sshd_spawn_domain(sshd, userdomain, { sysadm_devpts_t userpty_type })
 } else {
 sshd_spawn_domain(sshd, unpriv_userdomain, userpty_type)
@@ -178,7 +179,7 @@
 allow { sshd_t sshd_extern_t } self:process signal;
 } else {
 ')
-allow { sshd_t sshd_extern_t } initrc_devpts_t:chr_file rw_file_perms;
+can_access_pty({ sshd_t sshd_extern_t }, initrc)
 allow { sshd_t sshd_extern_t } self:capability net_bind_service;
 allow { sshd_t sshd_extern_t } ssh_port_t:tcp_socket name_bind;
 
@@ -231,3 +232,6 @@
 allow ssh_keygen_t self:unix_stream_socket create_stream_socket_perms;
 allow ssh_keygen_t sysadm_tty_device_t:chr_file { read write };
 allow ssh_keygen_t urandom_device_t:chr_file { getattr read };
+ifdef(`use_mcs', `
+range_transition initrc_t sshd_exec_t s0 - s0:c0.c127;
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/su.te policy-1.27.1/domains/program/su.te
--- nsapolicy/domains/program/su.te	2005-09-12 16:40:28.000000000 -0400
+++ policy-1.27.1/domains/program/su.te	2005-09-16 11:35:39.000000000 -0400
@@ -12,3 +12,10 @@
 
 # Everything else is in the su_domain macro in
 # macros/program/su_macros.te.
+
+ifdef(`use_mcs', `
+ifdef(`targeted_policy', `
+range_transition unconfined_t su_exec_t s0 - s0:c0.c127;
+domain_auto_trans(unconfined_t, su_exec_t, sysadm_su_t)
+')
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/syslogd.te policy-1.27.1/domains/program/syslogd.te
--- nsapolicy/domains/program/syslogd.te	2005-09-12 16:40:28.000000000 -0400
+++ policy-1.27.1/domains/program/syslogd.te	2005-09-16 11:35:39.000000000 -0400
@@ -33,7 +33,7 @@
 tmp_domain(syslogd)
 
 # read files in /etc
-allow syslogd_t etc_t:file r_file_perms;
+allow syslogd_t { etc_runtime_t etc_t }:file r_file_perms;
 
 # Use capabilities.
 allow syslogd_t self:capability { dac_override net_admin net_bind_service sys_resource sys_tty_config };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/alsa.te policy-1.27.1/domains/program/unused/alsa.te
--- nsapolicy/domains/program/unused/alsa.te	2005-09-16 11:17:08.000000000 -0400
+++ policy-1.27.1/domains/program/unused/alsa.te	2005-09-16 11:35:39.000000000 -0400
@@ -11,6 +11,8 @@
 allow alsa_t self:unix_stream_socket create_stream_socket_perms;
 allow alsa_t self:unix_dgram_socket create_socket_perms;
 allow unpriv_userdomain alsa_t:sem { unix_read unix_write associate read write };
+allow unpriv_userdomain alsa_t:shm { unix_read unix_write create_shm_perms };
+
 type alsa_etc_rw_t, file_type, sysadmfile, usercanread;
 rw_dir_create_file(alsa_t,alsa_etc_rw_t)
 allow alsa_t self:capability { setgid setuid ipc_owner };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/amanda.te policy-1.27.1/domains/program/unused/amanda.te
--- nsapolicy/domains/program/unused/amanda.te	2005-09-12 16:40:28.000000000 -0400
+++ policy-1.27.1/domains/program/unused/amanda.te	2005-09-16 11:35:39.000000000 -0400
@@ -84,7 +84,6 @@
 
 # configuration files -> read only
 allow amanda_t amanda_config_t:file { getattr read };
-allow amanda_t amanda_config_t:dir search;
 
 # access to amanda_amandates_t
 allow amanda_t amanda_amandates_t:file { getattr lock read write };
@@ -97,43 +96,18 @@
 allow amanda_t amanda_data_t:file { read write };
 
 # access to proc_t
-allow amanda_t proc_t:dir { getattr search };
 allow amanda_t proc_t:file { getattr read };
 
 # access to etc_t and similar
-allow amanda_t etc_t:dir { getattr search };
 allow amanda_t etc_t:file { getattr read };
 allow amanda_t etc_runtime_t:file { getattr read };
 
-# access to var_t and similar
-allow amanda_t var_t:dir search;
-allow amanda_t var_lib_t:dir search;
-allow amanda_t amanda_var_lib_t:dir search;
-
 # access to amanda_gnutarlists_t (/var/lib/amanda/gnutar-lists)
-allow amanda_t amanda_gnutarlists_t:dir { add_name read remove_name search write };
-allow amanda_t amanda_gnutarlists_t:file { create getattr read rename setattr unlink write };
-
-# access to var_run_t
-allow amanda_t var_run_t:dir search;
-
-# access to var_log_t
-allow amanda_t var_log_t:dir getattr;
-
-# access to var_spool_t
-allow amanda_t var_spool_t:dir getattr;
-
-# access to amanda_usr_lib_t
-allow amanda_t amanda_usr_lib_t:dir search;
+rw_dir_create_file(amanda_t, amanda_gnutarlists_t)
 
 # access to device_t and similar
-allow amanda_t device_t:dir search;
-allow amanda_t devpts_t:dir getattr;
 allow amanda_t devtty_t:chr_file { read write };
 
-# access to boot_t
-allow amanda_t boot_t:dir getattr;
-
 # access to fs_t
 allow amanda_t fs_t:filesystem getattr;
 
@@ -192,18 +166,8 @@
 ########################
 
 # access to user_home_t
-allow amanda_t { user_home_dir_type user_home_type }:dir { search getattr read };
 allow amanda_t user_home_type:file { getattr read };
 
-# access to file_t ( /floppy, /cdrom )
-allow amanda_t mnt_t:dir getattr;
-
-###########
-# Dontaudit
-###########
-dontaudit amanda_t lost_found_t:dir { getattr read };
-	
-	
 ##############################################################################
 # AMANDA RECOVER DECLARATIONS
 ##############################################################################
@@ -301,22 +265,17 @@
 #
 allow inetd_t amanda_port_t:{ tcp_socket udp_socket } name_bind;
 
-allow amanda_t file_type:dir {getattr read search };
+#amanda needs to look at fs_type directories to decide whether it should backup
+allow amanda_t { fs_type file_type }:dir {getattr read search };
 allow amanda_t file_type:{ lnk_file file chr_file blk_file } {getattr read };
 allow amanda_t device_type:{ blk_file chr_file } getattr;
 allow amanda_t fixed_disk_device_t:blk_file read;
 domain_auto_trans(amanda_t, fsadm_exec_t, fsadm_t)
 
-dontaudit amanda_t file_type:sock_file getattr;
+allow amanda_t file_type:sock_file getattr;
 logdir_domain(amanda)
 
-dontaudit amanda_t autofs_t:dir { getattr read search };
-dontaudit amanda_t binfmt_misc_fs_t:dir getattr;
-dontaudit amanda_t nfs_t:dir { getattr read };
-dontaudit amanda_t proc_t:dir read;
 dontaudit amanda_t proc_t:lnk_file read;
-dontaudit amanda_t rpc_pipefs_t:dir { getattr read };
-dontaudit amanda_t security_t:dir { getattr read };
-dontaudit amanda_t sysfs_t:dir { getattr read };
 dontaudit amanda_t unlabeled_t:file getattr;
-dontaudit amanda_t usbfs_t:dir getattr;
+#amanda wants to check attributes on fifo_files
+allow amanda_t file_type:fifo_file getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/anaconda.te policy-1.27.1/domains/program/unused/anaconda.te
--- nsapolicy/domains/program/unused/anaconda.te	2005-09-12 16:40:28.000000000 -0400
+++ policy-1.27.1/domains/program/unused/anaconda.te	2005-09-16 11:35:39.000000000 -0400
@@ -17,11 +17,6 @@
 role system_r types ldconfig_t;
 domain_auto_trans(anaconda_t, ldconfig_exec_t, ldconfig_t)
 
-ifdef(`su.te', `
-role system_r types sysadm_su_t;
-domain_auto_trans(anaconda_t, su_exec_t, sysadm_su_t)
-')
-
 # Run other rc scripts in the anaconda_t domain.
 domain_auto_trans(anaconda_t, initrc_exec_t, initrc_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.27.1/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2005-09-16 11:17:08.000000000 -0400
+++ policy-1.27.1/domains/program/unused/apache.te	2005-09-16 11:35:39.000000000 -0400
@@ -113,9 +113,12 @@
 can_network_server(httpd_t)
 can_kerberos(httpd_t)
 can_resolve(httpd_t)
-can_ypbind(httpd_t)
-can_ldap(httpd_t)
+nsswitch_domain(httpd_t)
 allow httpd_t { http_port_t http_cache_port_t }:tcp_socket name_bind;
+# allow httpd to connect to mysql/posgresql 
+allow httpd_t { postgresql_port_t mysqld_port_t }:tcp_socket name_connect;
+# allow httpd to work as a relay
+allow httpd_t { gopher_port_t ftp_port_t http_port_t http_cache_port_t }:tcp_socket name_connect;
 
 if (httpd_can_network_connect) {
 can_network_client(httpd_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apmd.te policy-1.27.1/domains/program/unused/apmd.te
--- nsapolicy/domains/program/unused/apmd.te	2005-09-16 11:17:08.000000000 -0400
+++ policy-1.27.1/domains/program/unused/apmd.te	2005-09-16 11:35:39.000000000 -0400
@@ -47,6 +47,7 @@
 
 # acpid also has a logfile
 log_domain(apmd)
+tmp_domain(apmd)
 
 ifdef(`distro_suse', `
 var_lib_domain(apmd)
@@ -140,3 +141,10 @@
 allow apmd_t user_tty_type:chr_file rw_file_perms;
 # Access /dev/apm_bios.
 allow initrc_t apm_bios_t:chr_file { setattr getattr read };
+
+ifdef(`logrotate.te', `
+allow apmd_t logrotate_t:fd use;
+')dnl end if logrotate.te
+allow apmd_t devpts_t:dir { getattr search };
+allow apmd_t security_t:dir search;
+r_dir_file(apmd_t, usr_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/auditd.te policy-1.27.1/domains/program/unused/auditd.te
--- nsapolicy/domains/program/unused/auditd.te	2005-09-12 16:40:28.000000000 -0400
+++ policy-1.27.1/domains/program/unused/auditd.te	2005-09-16 11:35:39.000000000 -0400
@@ -65,3 +65,5 @@
 allow auditctl_t privfd:fd use;
 
 
+allow auditd_t sbin_t:dir search;
+can_exec(auditd_t, sbin_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/automount.te policy-1.27.1/domains/program/unused/automount.te
--- nsapolicy/domains/program/unused/automount.te	2005-09-12 16:40:28.000000000 -0400
+++ policy-1.27.1/domains/program/unused/automount.te	2005-09-16 11:35:39.000000000 -0400
@@ -34,7 +34,9 @@
 can_exec(automount_t, { etc_t automount_etc_t })
 
 can_network_server(automount_t)
+can_resolve(automount_t)
 can_ypbind(automount_t)
+can_ldap(automount_t)
 
 ifdef(`fsadm.te', `
 domain_auto_trans(automount_t, fsadm_exec_t, fsadm_t)
@@ -56,6 +58,7 @@
 
 allow automount_t { bin_t sbin_t }:dir search;
 can_exec(automount_t, mount_exec_t)
+can_exec(automount_t, shell_exec_t)
 
 allow mount_t autofs_t:dir getattr;
 dontaudit automount_t var_t:dir write;
@@ -73,3 +76,4 @@
 
 allow automount_t var_lib_t:dir search;
 allow automount_t var_lib_nfs_t:dir search;
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/bluetooth.te policy-1.27.1/domains/program/unused/bluetooth.te
--- nsapolicy/domains/program/unused/bluetooth.te	2005-09-16 11:17:08.000000000 -0400
+++ policy-1.27.1/domains/program/unused/bluetooth.te	2005-09-16 11:35:39.000000000 -0400
@@ -11,11 +11,16 @@
 daemon_domain(bluetooth)
 
 file_type_auto_trans(bluetooth_t, var_run_t, bluetooth_var_run_t, sock_file)
+file_type_auto_trans(bluetooth_t, bluetooth_conf_t, bluetooth_conf_rw_t)
 
 tmp_domain(bluetooth)
 
 # Use capabilities.
 allow bluetooth_t self:capability { net_admin net_raw sys_tty_config };
+allow bluetooth_t self:process getsched;
+allow bluetooth_t proc_t:file { getattr read };
+
+allow bluetooth_t self:shm create_shm_perms;
 
 lock_domain(bluetooth)
 
@@ -35,6 +40,7 @@
 
 # bluetooth_conf_t is the type of the /etc/bluetooth dir.
 type bluetooth_conf_t, file_type, sysadmfile;
+type bluetooth_conf_rw_t, file_type, sysadmfile;
 
 # Read /etc/bluetooth
 allow bluetooth_t bluetooth_conf_t:dir search;
@@ -44,5 +50,14 @@
 allow bluetooth_t usbfs_t:dir r_dir_perms;
 allow bluetooth_t usbfs_t:file rw_file_perms; 
 allow bluetooth_t bin_t:dir search;
-can_exec(bluetooth_t, bin_t)
+can_exec(bluetooth_t, { bin_t shell_exec_t })
+allow bluetooth_t bin_t:lnk_file read;
+
+#Handle bluetooth serial devices
+allow bluetooth_t tty_device_t:chr_file rw_file_perms;
+allow bluetooth_t self:fifo_file rw_file_perms;
+allow bluetooth_t etc_t:file { getattr read };
+r_dir_file(bluetooth_t, fonts_t)
+allow bluetooth_t urandom_device_t:chr_file r_file_perms;
+allow bluetooth_t usr_t:file { getattr read };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.27.1/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2005-09-16 11:17:08.000000000 -0400
+++ policy-1.27.1/domains/program/unused/cups.te	2005-09-16 11:35:39.000000000 -0400
@@ -188,6 +188,7 @@
 # Uses networking to talk to the daemons
 allow hplip_t self:unix_dgram_socket create_socket_perms;
 allow hplip_t self:unix_stream_socket create_socket_perms;
+allow hplip_t self:rawip_socket create_socket_perms;
 
 # for python
 can_exec(hplip_t, bin_t)
@@ -196,6 +197,9 @@
 allow hplip_t proc_t:file r_file_perms;
 allow hplip_t urandom_device_t:chr_file { getattr read };
 allow hplip_t usr_t:{ file lnk_file } r_file_perms;
+allow hplip_t devpts_t:dir search;
+allow hplip_t devpts_t:chr_file { getattr ioctl };
+
 
 dontaudit cupsd_t selinux_config_t:dir search;
 dontaudit cupsd_t selinux_config_t:file { getattr read };
@@ -231,12 +235,13 @@
 allow cupsd_config_t cupsd_t:{ file lnk_file } { getattr read };
 can_ps(cupsd_config_t, cupsd_t)
 
-allow cupsd_config_t self:capability chown;
+allow cupsd_config_t self:capability { chown sys_tty_config };
 
 rw_dir_create_file(cupsd_config_t, cupsd_etc_t)
 rw_dir_create_file(cupsd_config_t, cupsd_rw_etc_t)
 file_type_auto_trans(cupsd_config_t, cupsd_etc_t, cupsd_rw_etc_t, file)
 file_type_auto_trans(cupsd_config_t, var_t, cupsd_rw_etc_t, file)
+allow cupsd_config_t var_t:lnk_file read;
 
 can_network_tcp(cupsd_config_t)
 can_ypbind(cupsd_config_t)
@@ -311,3 +316,7 @@
 r_dir_file(cupsd_lpd_t, cupsd_etc_t)
 r_dir_file(cupsd_lpd_t, cupsd_rw_etc_t)
 allow cupsd_lpd_t ipp_port_t:tcp_socket name_connect;
+ifdef(`use_mcs', `
+range_transition initrc_t cupsd_exec_t s0 - s0:c0.c127;
+')
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cyrus.te policy-1.27.1/domains/program/unused/cyrus.te
--- nsapolicy/domains/program/unused/cyrus.te	2005-09-16 11:17:09.000000000 -0400
+++ policy-1.27.1/domains/program/unused/cyrus.te	2005-09-16 11:35:39.000000000 -0400
@@ -42,7 +42,7 @@
 create_dir_file(cyrus_t, mail_spool_t)
 allow cyrus_t var_spool_t:dir search;
 
-ifdef(`saslaudthd.te', `
+ifdef(`saslauthd.te', `
 allow cyrus_t saslauthd_var_run_t:dir search;
 allow cyrus_t saslauthd_var_run_t:sock_file { read write };
 allow cyrus_t saslauthd_t:unix_stream_socket { connectto };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dbusd.te policy-1.27.1/domains/program/unused/dbusd.te
--- nsapolicy/domains/program/unused/dbusd.te	2005-09-16 11:17:09.000000000 -0400
+++ policy-1.27.1/domains/program/unused/dbusd.te	2005-09-16 11:35:39.000000000 -0400
@@ -12,7 +12,7 @@
 
 # dac_override: /var/run/dbus is owned by messagebus on Debian
 allow system_dbusd_t self:capability { dac_override setgid setuid };
-can_ypbind(system_dbusd_t)
+nsswitch_domain(system_dbusd_t)
 
 # I expect we need more than this
 
@@ -23,3 +23,5 @@
 can_exec(system_dbusd_t, sbin_t)
 allow system_dbusd_t self:fifo_file { read write };
 allow system_dbusd_t self:unix_stream_socket connectto;
+allow system_dbusd_t self:unix_stream_socket connectto;
+allow system_dbusd_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dhcpc.te policy-1.27.1/domains/program/unused/dhcpc.te
--- nsapolicy/domains/program/unused/dhcpc.te	2005-09-16 11:17:09.000000000 -0400
+++ policy-1.27.1/domains/program/unused/dhcpc.te	2005-09-16 11:35:39.000000000 -0400
@@ -134,7 +134,6 @@
 allow dhcpc_t home_root_t:dir search;
 allow initrc_t dhcpc_state_t:file { getattr read };
 dontaudit dhcpc_t var_lock_t:dir search;
-dontaudit dhcpc_t selinux_config_t:dir search;
 allow dhcpc_t self:netlink_route_socket r_netlink_socket_perms;
 dontaudit dhcpc_t domain:dir getattr;
 allow dhcpc_t initrc_var_run_t:file rw_file_perms;
@@ -145,6 +144,7 @@
 ifdef(`ypbind.te', `
 domain_auto_trans(dhcpc_t, ypbind_exec_t, ypbind_t)
 allow dhcpc_t ypbind_var_run_t:file { r_file_perms unlink };
+allow dhcpc_t ypbind_t:process signal;
 ')
 ifdef(`ntpd.te', `
 domain_auto_trans(dhcpc_t, ntpd_exec_t, ntpd_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dovecot.te policy-1.27.1/domains/program/unused/dovecot.te
--- nsapolicy/domains/program/unused/dovecot.te	2005-09-12 16:40:28.000000000 -0400
+++ policy-1.27.1/domains/program/unused/dovecot.te	2005-09-16 11:35:39.000000000 -0400
@@ -43,7 +43,9 @@
 can_kerberos(dovecot_t)
 
 allow dovecot_t tmp_t:dir search;
-rw_dir_file(dovecot_t, mail_spool_t)
+rw_dir_create_file(dovecot_t, mail_spool_t)
+
+
 create_dir_file(dovecot_t, dovecot_spool_t)
 create_dir_file(mta_delivery_agent, dovecot_spool_t)
 allow dovecot_t mail_spool_t:lnk_file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hwclock.te policy-1.27.1/domains/program/unused/hwclock.te
--- nsapolicy/domains/program/unused/hwclock.te	2005-09-16 11:17:09.000000000 -0400
+++ policy-1.27.1/domains/program/unused/hwclock.te	2005-09-16 11:35:39.000000000 -0400
@@ -47,3 +46,4 @@
 # for when /usr is not mounted
 dontaudit hwclock_t file_t:dir search;
 allow hwclock_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
+r_dir_file(hwclock_t, etc_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/kudzu.te policy-1.27.1/domains/program/unused/kudzu.te
--- nsapolicy/domains/program/unused/kudzu.te	2005-09-16 11:17:09.000000000 -0400
+++ policy-1.27.1/domains/program/unused/kudzu.te	2005-09-16 11:35:39.000000000 -0400
@@ -20,7 +20,7 @@
 allow kudzu_t ramfs_t:dir search;
 allow kudzu_t ramfs_t:sock_file write;
 allow kudzu_t self:capability { dac_override sys_admin sys_rawio net_admin sys_tty_config mknod };
-allow kudzu_t modules_conf_t:file { getattr read unlink };
+allow kudzu_t modules_conf_t:file { getattr read unlink rename };
 allow kudzu_t modules_object_t:dir r_dir_perms;
 allow kudzu_t { modules_object_t modules_dep_t }:file { getattr read };
 allow kudzu_t mouse_device_t:chr_file { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mta.te policy-1.27.1/domains/program/unused/mta.te
--- nsapolicy/domains/program/unused/mta.te	2005-09-16 11:17:09.000000000 -0400
+++ policy-1.27.1/domains/program/unused/mta.te	2005-09-16 11:35:39.000000000 -0400
@@ -72,3 +72,7 @@
 
 allow system_mail_t etc_runtime_t:file { getattr read };
 allow system_mail_t { random_device_t urandom_device_t }:chr_file { getattr read };
+ifdef(`targeted_policy', `
+typealias system_mail_t alias sysadm_mail_t;
+')
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mysqld.te policy-1.27.1/domains/program/unused/mysqld.te
--- nsapolicy/domains/program/unused/mysqld.te	2005-09-16 11:17:09.000000000 -0400
+++ policy-1.27.1/domains/program/unused/mysqld.te	2005-09-16 11:35:39.000000000 -0400
@@ -12,7 +12,7 @@
 #
 daemon_domain(mysqld, `, nscd_client_domain')
 
-allow mysqld_t mysqld_port_t:tcp_socket name_bind;
+allow mysqld_t mysqld_port_t:tcp_socket { name_bind name_connect };
 
 allow mysqld_t mysqld_var_run_t:sock_file create_file_perms;
 
@@ -42,7 +42,7 @@
 create_dir_file(mysqld_t, mysqld_db_t)
 allow mysqld_t var_lib_t:dir { getattr search };
 
-can_network_server(mysqld_t)
+can_network(mysqld_t)
 can_ypbind(mysqld_t)
 
 # read config files
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/NetworkManager.te policy-1.27.1/domains/program/unused/NetworkManager.te
--- nsapolicy/domains/program/unused/NetworkManager.te	2005-09-16 11:17:08.000000000 -0400
+++ policy-1.27.1/domains/program/unused/NetworkManager.te	2005-09-16 11:35:39.000000000 -0400
@@ -11,7 +11,7 @@
 # NetworkManager_t is the domain for the NetworkManager daemon. 
 # NetworkManager_exec_t is the type of the NetworkManager executable.
 #
-daemon_domain(NetworkManager, `, nscd_client_domain, privsysmod' )
+daemon_domain(NetworkManager, `, nscd_client_domain, privsysmod, mlsfileread' )
 
 can_network(NetworkManager_t)
 allow NetworkManager_t port_type:tcp_socket name_connect;
@@ -109,3 +109,4 @@
 ')
 allow NetworkManager_t var_lib_t:dir search;
 dontaudit NetworkManager_t user_tty_type:chr_file { read write };
+dontaudit NetworkManager_t security_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ntpd.te policy-1.27.1/domains/program/unused/ntpd.te
--- nsapolicy/domains/program/unused/ntpd.te	2005-09-16 11:17:09.000000000 -0400
+++ policy-1.27.1/domains/program/unused/ntpd.te	2005-09-16 11:35:39.000000000 -0400
@@ -54,7 +54,7 @@
 # for cron jobs
 # system_crond_t is not right, cron is not doing what it should
 ifdef(`crond.te', `
-system_crond_entry(ntpd_exec_t, ntpd_t)
+system_crond_entry(ntpdate_exec_t, ntpd_t)
 ')
 
 can_exec(ntpd_t, initrc_exec_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/openct.te policy-1.27.1/domains/program/unused/openct.te
--- nsapolicy/domains/program/unused/openct.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.27.1/domains/program/unused/openct.te	2005-09-16 11:35:39.000000000 -0400
@@ -0,0 +1,16 @@
+#DESC openct - read files in page cache 
+#
+# Author: Dan Walsh (dwalsh@redhat.com)
+#
+
+#################################
+#
+# Declarations for openct
+#
+
+daemon_domain(openct)
+#
+# openct asks for these
+#
+rw_dir_file(openct_t, usbfs_t)
+allow openct_t etc_t:file r_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/pamconsole.te policy-1.27.1/domains/program/unused/pamconsole.te
--- nsapolicy/domains/program/unused/pamconsole.te	2005-09-12 16:40:28.000000000 -0400
+++ policy-1.27.1/domains/program/unused/pamconsole.te	2005-09-16 11:35:39.000000000 -0400
@@ -25,6 +25,7 @@
 # for /var/run/console.lock checking
 allow pam_console_t { var_t var_run_t }:dir search;
 r_dir_file(pam_console_t, pam_var_console_t)
+dontaudit pam_console_t pam_var_console_t:file write;
 
 # Allow to set attributes on /dev entries
 allow pam_console_t device_t:dir { getattr read };
@@ -48,3 +49,4 @@
 allow initrc_t pam_var_console_t:dir rw_dir_perms;
 allow initrc_t pam_var_console_t:file unlink;
 allow pam_console_t file_context_t:file { getattr read };
+nsswitch_domain(pam_console_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/pegasus.te policy-1.27.1/domains/program/unused/pegasus.te
--- nsapolicy/domains/program/unused/pegasus.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.27.1/domains/program/unused/pegasus.te	2005-09-16 11:35:39.000000000 -0400
@@ -0,0 +1,31 @@
+#DESC pegasus - The Open Group Pegasus CIM/WBEM Server 
+#
+# Author:  Jason Vas Dias <jvdias@redhat.com>
+# Package: tog-pegasus
+# 
+#################################
+#
+# Rules for the pegasus domain
+#
+daemon_domain(pegasus, `, nscd_client_domain')
+type pegasus_data_t, file_type, sysadmfile;
+type pegasus_conf_t, file_type, sysadmfile;
+type pegasus_mof_t, file_type, sysadmfile;
+type pegasus_conf_exec_t, file_type, exec_type, sysadmfile;
+allow pegasus_t self:capability { dac_override net_bind_service }; 
+can_network_tcp(pegasus_t);
+nsswitch_domain(pegasus_t);
+allow pegasus_t pegasus_var_run_t:sock_file { create setattr };
+allow pegasus_t self:unix_dgram_socket create_socket_perms;
+allow pegasus_t self:unix_stream_socket create_stream_socket_perms;
+allow pegasus_t { pegasus_http_port_t pegasus_https_port_t }:tcp_socket { name_bind name_connect };
+allow pegasus_t proc_t:file { getattr read };
+allow pegasus_t sysctl_vm_t:dir search;
+allow pegasus_t initrc_var_run_t:file { read write lock };
+allow pegasus_t urandom_device_t:chr_file { getattr read };
+r_dir_file(pegasus_t, etc_t)
+r_dir_file(pegasus_t, var_lib_t)
+r_dir_file(pegasus_t, pegasus_mof_t)
+rw_dir_create_file(pegasus_t, pegasus_conf_t)
+rw_dir_create_file(pegasus_t, pegasus_data_t)
+rw_dir_create_file(pegasus_conf_exec_t, pegasus_conf_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postfix.te policy-1.27.1/domains/program/unused/postfix.te
--- nsapolicy/domains/program/unused/postfix.te	2005-09-12 16:40:29.000000000 -0400
+++ policy-1.27.1/domains/program/unused/postfix.te	2005-09-16 11:35:39.000000000 -0400
@@ -329,7 +329,8 @@
 domain_auto_trans(postfix_pipe_t, procmail_exec_t, procmail_t)
 ')
 ifdef(`sendmail.te', `
-allow sendmail_t postfix_etc_t:dir search;
+r_dir_file(sendmail_t, postfix_etc_t)
+allow sendmail_t postfix_spool_t:dir search;
 ')
 
 # Program for creating database files
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/pppd.te policy-1.27.1/domains/program/unused/pppd.te
--- nsapolicy/domains/program/unused/pppd.te	2005-09-16 11:17:09.000000000 -0400
+++ policy-1.27.1/domains/program/unused/pppd.te	2005-09-16 11:35:39.000000000 -0400
@@ -54,6 +54,7 @@
 can_exec(pppd_t, { shell_exec_t bin_t sbin_t etc_t ifconfig_exec_t })
 allow pppd_t { bin_t sbin_t }:dir search;
 allow pppd_t { sbin_t bin_t }:lnk_file read;
+dontaudit  ifconfig_t pppd_t:fd use;
 
 # Access /dev/ppp.
 allow pppd_t ppp_device_t:chr_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/procmail.te policy-1.27.1/domains/program/unused/procmail.te
--- nsapolicy/domains/program/unused/procmail.te	2005-09-12 16:40:28.000000000 -0400
+++ policy-1.27.1/domains/program/unused/procmail.te	2005-09-16 11:35:39.000000000 -0400
@@ -19,8 +19,7 @@
 uses_shlib(procmail_t)
 allow procmail_t device_t:dir search;
 can_network_server(procmail_t)
-can_ypbind(procmail_t)
-can_winbind(procmail_t)
+nsswitch_domain(procmail_t)
 
 allow procmail_t self:capability { sys_nice chown setuid setgid dac_override };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/readahead.te policy-1.27.1/domains/program/unused/readahead.te
--- nsapolicy/domains/program/unused/readahead.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.27.1/domains/program/unused/readahead.te	2005-09-16 11:35:39.000000000 -0400
@@ -0,0 +1,21 @@
+#DESC readahead - read files in page cache 
+#
+# Author: Dan Walsh (dwalsh@redhat.com)
+#
+
+#################################
+#
+# Declarations for readahead
+#
+
+daemon_domain(readahead)
+#
+# readahead asks for these
+#
+allow readahead_t { file_type -secure_file_type }:{ file lnk_file } { getattr read };
+allow readahead_t { file_type -secure_file_type }:dir r_dir_perms;
+dontaudit readahead_t shadow_t:file { getattr read };
+allow readahead_t { device_t device_type }:{ lnk_file chr_file blk_file } getattr;
+dontaudit readahead_t file_type:sock_file getattr;
+allow readahead_t proc_t:file { getattr read };
+dontaudit readahead_t device_type:blk_file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/roundup.te policy-1.27.1/domains/program/unused/roundup.te
--- nsapolicy/domains/program/unused/roundup.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.27.1/domains/program/unused/roundup.te	2005-09-16 11:35:39.000000000 -0400
@@ -0,0 +1,29 @@
+# Roundup Issue Tracking System
+#
+# Authors:  W. Michael Petullo <redhat@flyn.org
+#
+daemon_domain(roundup)
+var_lib_domain(roundup)
+can_network(roundup_t)
+allow roundup_t http_cache_port_t:tcp_socket name_bind;
+allow roundup_t smtp_port_t:tcp_socket name_connect;
+
+# execute python
+allow roundup_t bin_t:dir r_dir_perms;
+can_exec(roundup_t, bin_t)
+allow roundup_t bin_t:lnk_file read;
+
+allow roundup_t self:capability { setgid setuid };
+
+allow roundup_t self:unix_stream_socket create_stream_socket_perms;
+
+ifdef(`mysqld.te', `
+allow roundup_t mysqld_db_t:dir search;
+allow roundup_t mysqld_var_run_t:sock_file write;
+allow roundup_t mysqld_t:unix_stream_socket connectto;
+')
+
+# /usr/share/mysql/charsets/Index.xml
+allow roundup_t usr_t:file { getattr read };
+allow roundup_t urandom_device_t:chr_file { getattr read };
+allow roundup_t etc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpcd.te policy-1.27.1/domains/program/unused/rpcd.te
--- nsapolicy/domains/program/unused/rpcd.te	2005-09-12 16:40:28.000000000 -0400
+++ policy-1.27.1/domains/program/unused/rpcd.te	2005-09-16 11:35:39.000000000 -0400
@@ -19,7 +19,7 @@
 can_network($1_t)
 allow $1_t port_type:tcp_socket name_connect;
 can_ypbind($1_t)
-allow $1_t etc_t:file { getattr read };
+allow $1_t { etc_runtime_t etc_t }:file { getattr read };
 read_locale($1_t)
 allow $1_t self:capability net_bind_service;
 dontaudit $1_t self:capability net_admin;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/samba.te policy-1.27.1/domains/program/unused/samba.te
--- nsapolicy/domains/program/unused/samba.te	2005-09-16 11:17:10.000000000 -0400
+++ policy-1.27.1/domains/program/unused/samba.te	2005-09-16 11:35:39.000000000 -0400
@@ -25,6 +25,9 @@
 # not sure why it needs this
 tmp_domain(smbd)
 
+# Allow samba to search mnt_t for potential mounted dirs
+allow smbd_t mnt_t:dir r_dir_perms;
+
 ifdef(`crond.te', `
 allow system_crond_t samba_etc_t:file { read getattr lock };
 allow system_crond_t samba_log_t:file { read getattr lock };
@@ -47,9 +50,8 @@
 
 # Use the network.
 can_network(smbd_t)
-can_ldap(smbd_t)
+nsswitch_domain(smbd_t)
 can_kerberos(smbd_t)
-can_winbind(smbd_t)
 allow smbd_t { smbd_port_t ipp_port_t }:tcp_socket name_connect;
 
 allow smbd_t urandom_device_t:chr_file { getattr read };
@@ -75,6 +77,11 @@
 allow smbd_t samba_log_t:dir ra_dir_perms;
 dontaudit smbd_t samba_log_t:dir remove_name;
 
+ifdef(`hide_broken_symptoms', `
+dontaudit smbd_t { devpts_t boot_t default_t tmpfs_t }:dir getattr;
+dontaudit smbd_t devpts_t:dir getattr;
+')
+
 allow smbd_t usr_t:file { getattr read };
 
 # Access Samba shares.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/snmpd.te policy-1.27.1/domains/program/unused/snmpd.te
--- nsapolicy/domains/program/unused/snmpd.te	2005-09-12 16:40:28.000000000 -0400
+++ policy-1.27.1/domains/program/unused/snmpd.te	2005-09-16 11:35:39.000000000 -0400
@@ -22,8 +22,9 @@
 
 # for the .index file
 var_lib_domain(snmpd)
-file_type_auto_trans(snmpd_t, var_t, snmpd_var_lib_t, dir)
+file_type_auto_trans(snmpd_t, var_t, snmpd_var_lib_t, { dir sock_file })
 file_type_auto_trans(snmpd_t, { usr_t var_t }, snmpd_var_lib_t, file)
+allow snmpd_t snmpd_var_lib_t:sock_file create_file_perms;
 
 log_domain(snmpd)
 # for /usr/share/snmp/mibs
@@ -33,7 +34,7 @@
 can_udp_send(snmpd_t, sysadm_t)
 
 allow snmpd_t self:unix_dgram_socket create_socket_perms;
-allow snmpd_t self:unix_stream_socket create_socket_perms;
+allow snmpd_t self:unix_stream_socket create_stream_socket_perms;
 allow snmpd_t etc_t:lnk_file read;
 allow snmpd_t { etc_t etc_runtime_t }:file r_file_perms;
 allow snmpd_t { random_device_t urandom_device_t }:chr_file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/squid.te policy-1.27.1/domains/program/unused/squid.te
--- nsapolicy/domains/program/unused/squid.te	2005-09-12 16:40:29.000000000 -0400
+++ policy-1.27.1/domains/program/unused/squid.te	2005-09-16 11:35:39.000000000 -0400
@@ -60,7 +60,7 @@
 can_tcp_connect(web_client_domain, squid_t)
 
 # tcp port 8080 and udp port 3130 is http_cache_port_t (see net_contexts)
-allow squid_t http_cache_port_t:{ tcp_socket udp_socket } name_bind;
+allow squid_t { gopher_port_t ftp_port_t http_port_t http_cache_port_t }:{ tcp_socket udp_socket } name_bind;
 allow squid_t { gopher_port_t ftp_port_t http_port_t http_cache_port_t }:tcp_socket name_connect;
 
 # to allow running programs from /usr/lib/squid (IE unlinkd)
@@ -81,4 +81,5 @@
 ifdef(`winbind.te', `
 domain_auto_trans(squid_t, winbind_helper_exec_t, winbind_helper_t)
 allow winbind_helper_t squid_t:tcp_socket rw_socket_perms;
+allow winbind_helper_t squid_log_t:file ra_file_perms;
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.27.1/domains/program/unused/udev.te
--- nsapolicy/domains/program/unused/udev.te	2005-09-16 11:17:10.000000000 -0400
+++ policy-1.27.1/domains/program/unused/udev.te	2005-09-16 11:35:39.000000000 -0400
@@ -140,7 +140,13 @@
 r_dir_file(udev_t, domain)
 allow udev_t modules_dep_t:file r_file_perms;
 
+nsswitch_domain(udev_t)
+
 ifdef(`unlimitedUtils', `
 unconfined_domain(udev_t) 
 ')
 dontaudit hostname_t udev_t:fd use;
+ifdef(`use_mcs', `
+range_transition kernel_t udev_exec_t s0 - s0:c0.c127;
+range_transition initrc_t udev_exec_t s0 - s0:c0.c127;
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/winbind.te policy-1.27.1/domains/program/unused/winbind.te
--- nsapolicy/domains/program/unused/winbind.te	2005-09-12 16:40:29.000000000 -0400
+++ policy-1.27.1/domains/program/unused/winbind.te	2005-09-16 11:35:39.000000000 -0400
@@ -44,6 +44,7 @@
 r_dir_file(winbind_t, samba_etc_t)
 allow winbind_helper_t self:unix_dgram_socket create_socket_perms;
 allow winbind_helper_t self:unix_stream_socket create_stream_socket_perms;
+allow winbind_helper_t samba_var_t:dir search;
 allow winbind_helper_t winbind_var_run_t:dir r_dir_perms;
 can_winbind(winbind_helper_t)
 allow winbind_helper_t privfd:fd use;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xdm.te policy-1.27.1/domains/program/unused/xdm.te
--- nsapolicy/domains/program/unused/xdm.te	2005-09-12 16:40:28.000000000 -0400
+++ policy-1.27.1/domains/program/unused/xdm.te	2005-09-16 11:35:39.000000000 -0400
@@ -371,3 +371,6 @@
 dontaudit xdm_t ice_tmp_t:dir { getattr setattr };
 
 #### Also see xdm_macros.te
+ifdef(`use_mcs', `
+range_transition initrc_t xdm_exec_t s0 - s0:c0.c127;
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ypserv.te policy-1.27.1/domains/program/unused/ypserv.te
--- nsapolicy/domains/program/unused/ypserv.te	2005-09-12 16:40:28.000000000 -0400
+++ policy-1.27.1/domains/program/unused/ypserv.te	2005-09-16 11:35:39.000000000 -0400
@@ -39,3 +39,4 @@
 ')
 allow ypserv_t reserved_port_t:{ udp_socket tcp_socket } name_bind;
 dontaudit ypserv_t reserved_port_type:{ tcp_socket udp_socket } name_bind;
+can_exec(ypserv_t, bin_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/useradd.te policy-1.27.1/domains/program/useradd.te
--- nsapolicy/domains/program/useradd.te	2005-09-16 11:17:08.000000000 -0400
+++ policy-1.27.1/domains/program/useradd.te	2005-09-16 11:35:39.000000000 -0400
@@ -67,6 +67,7 @@
 
 # for when /root is the cwd
 dontaudit $1_t sysadm_home_dir_t:dir search;
+nsswitch_domain($1_t)
 ')
 user_group_add_program(useradd)
 
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/distros.fc policy-1.27.1/file_contexts/distros.fc
--- nsapolicy/file_contexts/distros.fc	2005-09-12 16:40:27.000000000 -0400
+++ policy-1.27.1/file_contexts/distros.fc	2005-09-16 11:35:39.000000000 -0400
@@ -99,6 +99,7 @@
 /usr/lib(64)?/.*/program/librecentfile\.so 	--  system_u:object_r:texrel_shlib_t
 /usr/lib(64)?/.*/program/libsvx680li\.so	--  system_u:object_r:texrel_shlib_t
 /usr/lib(64)?/.*/program/libcomphelp4gcc3\.so  	--  system_u:object_r:texrel_shlib_t
+/usr/lib(64)?/.*/program/libsoffice\.so  	--  system_u:object_r:texrel_shlib_t
 
 # Fedora Extras packages: ladspa, imlib2, ocaml
 /usr/lib/ladspa/analogue_osc_1416\.so		-- system_u:object_r:texrel_shlib_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/bluetooth.fc policy-1.27.1/file_contexts/program/bluetooth.fc
--- nsapolicy/file_contexts/program/bluetooth.fc	2005-09-12 16:40:27.000000000 -0400
+++ policy-1.27.1/file_contexts/program/bluetooth.fc	2005-09-16 11:35:39.000000000 -0400
@@ -1,5 +1,6 @@
 # bluetooth
 /etc/bluetooth(/.*)?		system_u:object_r:bluetooth_conf_t
+/etc/bluetooth/link_key		system_u:object_r:bluetooth_conf_rw_t
 /usr/bin/rfcomm		--	system_u:object_r:bluetooth_exec_t
 /usr/sbin/hcid		--	system_u:object_r:bluetooth_exec_t
 /usr/sbin/sdpd		--	system_u:object_r:bluetooth_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/dhcpc.fc policy-1.27.1/file_contexts/program/dhcpc.fc
--- nsapolicy/file_contexts/program/dhcpc.fc	2005-09-12 16:40:27.000000000 -0400
+++ policy-1.27.1/file_contexts/program/dhcpc.fc	2005-09-16 11:35:39.000000000 -0400
@@ -4,6 +4,7 @@
 /etc/dhclient.*conf	--	system_u:object_r:dhcp_etc_t
 /etc/dhclient-script	--	system_u:object_r:dhcp_etc_t
 /sbin/dhcpcd		--	system_u:object_r:dhcpc_exec_t
+/sbin/dhcdbd		--	system_u:object_r:dhcpc_exec_t
 /sbin/dhclient.*	--	system_u:object_r:dhcpc_exec_t
 /var/lib/dhcp(3)?/dhclient.*	system_u:object_r:dhcpc_state_t
 /var/lib/dhcpcd(/.*)?		system_u:object_r:dhcpc_state_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/ipsec.fc policy-1.27.1/file_contexts/program/ipsec.fc
--- nsapolicy/file_contexts/program/ipsec.fc	2005-09-12 16:40:27.000000000 -0400
+++ policy-1.27.1/file_contexts/program/ipsec.fc	2005-09-16 11:35:39.000000000 -0400
@@ -21,6 +21,7 @@
 /usr/lib(64)?/ipsec/spi	--	system_u:object_r:ipsec_exec_t
 /usr/local/lib(64)?/ipsec/spi --	system_u:object_r:ipsec_exec_t
 /var/run/pluto(/.*)?		system_u:object_r:ipsec_var_run_t
+/var/racoon(/.*)?		system_u:object_r:ipsec_var_run_t
 
 # Kame
 /usr/sbin/racoon	--	system_u:object_r:ipsec_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/openct.fc policy-1.27.1/file_contexts/program/openct.fc
--- nsapolicy/file_contexts/program/openct.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.27.1/file_contexts/program/openct.fc	2005-09-16 11:35:39.000000000 -0400
@@ -0,0 +1,2 @@
+/usr/sbin/openct-control	-- 	system_u:object_r:openct_exec_t
+/var/run/openct(/.*)?			system_u:object_r:openct_var_run_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/pegasus.fc policy-1.27.1/file_contexts/program/pegasus.fc
--- nsapolicy/file_contexts/program/pegasus.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.27.1/file_contexts/program/pegasus.fc	2005-09-16 11:35:39.000000000 -0400
@@ -0,0 +1,11 @@
+# File Contexts for The Open Group Pegasus (tog-pegasus) cimserver
+/usr/sbin/cimserver		--	system_u:object_r:pegasus_exec_t
+/usr/sbin/cimconfig		-- 	system_u:object_r:pegasus_conf_exec_t
+/usr/sbin/cimuser		-- 	system_u:object_r:pegasus_conf_exec_t
+/usr/sbin/cimauth		-- 	system_u:object_r:pegasus_conf_exec_t
+/usr/sbin/init_repository	-- 	system_u:object_r:pegasus_exec_t
+/usr/lib(64)?/Pegasus/providers/.*\.so.*	system_u:object_r:shlib_t
+/etc/Pegasus(/.*)?			system_u:object_r:pegasus_conf_t
+/var/lib/Pegasus(/.*)?	                system_u:object_r:pegasus_data_t
+/var/run/tog-pegasus(/.*)?              system_u:object_r:pegasus_var_run_t
+/usr/share/Pegasus/mof(/.*)?/.*\.mof    system_u:object_r:pegasus_mof_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/pppd.fc policy-1.27.1/file_contexts/program/pppd.fc
--- nsapolicy/file_contexts/program/pppd.fc	2005-09-16 11:17:11.000000000 -0400
+++ policy-1.27.1/file_contexts/program/pppd.fc	2005-09-16 11:35:39.000000000 -0400
@@ -20,6 +20,6 @@
 /etc/ppp/plugins/rp-pppoe\.so 	--	system_u:object_r:shlib_t
 /etc/ppp/resolv\.conf 	--	system_u:object_r:pppd_etc_rw_t
 # Fix pptp sockets
-/var/run/pptp(/.*)?	--	system_u:object_r:pptp_var_run_t
+/var/run/pptp(/.*)?		system_u:object_r:pptp_var_run_t
 # Fix /etc/ppp {up,down} family scripts (see man pppd)
 /etc/ppp/(auth|ip(v6|x)?)-(up|down)	--	system_u:object_r:pppd_script_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/readahead.fc policy-1.27.1/file_contexts/program/readahead.fc
--- nsapolicy/file_contexts/program/readahead.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.27.1/file_contexts/program/readahead.fc	2005-09-16 11:35:39.000000000 -0400
@@ -0,0 +1 @@
+/usr/sbin/readahead -- system_u:object_r:readahead_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/roundup.fc policy-1.27.1/file_contexts/program/roundup.fc
--- nsapolicy/file_contexts/program/roundup.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.27.1/file_contexts/program/roundup.fc	2005-09-16 11:35:39.000000000 -0400
@@ -0,0 +1,2 @@
+/usr/bin/roundup-server         --      system_u:object_r:roundup_exec_t
+/var/lib/roundup(/.*)?          --      system_u:object_r:roundup_var_lib_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/rpm.fc policy-1.27.1/file_contexts/program/rpm.fc
--- nsapolicy/file_contexts/program/rpm.fc	2005-09-12 16:40:27.000000000 -0400
+++ policy-1.27.1/file_contexts/program/rpm.fc	2005-09-16 11:52:41.000000000 -0400
@@ -23,3 +23,7 @@
 /var/lib/YaST2(/.*)?			system_u:object_r:rpm_var_lib_t
 /var/log/YaST2(/.*)?			system_u:object_r:rpm_log_t
 ')
+
+ifdef(`mls_policy', `
+/sbin/cpio			--	system_u:object_r:rpm_exec_t
+')
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/xdm.fc policy-1.27.1/file_contexts/program/xdm.fc
--- nsapolicy/file_contexts/program/xdm.fc	2005-09-12 16:40:27.000000000 -0400
+++ policy-1.27.1/file_contexts/program/xdm.fc	2005-09-16 11:35:39.000000000 -0400
@@ -3,7 +3,7 @@
 /usr/X11R6/bin/[xgkw]dm	--	system_u:object_r:xdm_exec_t
 /opt/kde3/bin/kdm	--	system_u:object_r:xdm_exec_t
 /usr/bin/gpe-dm		--	system_u:object_r:xdm_exec_t
-/usr/bin/gdm-binary	--	system_u:object_r:xdm_exec_t
+/usr/(s)?bin/gdm-binary	--	system_u:object_r:xdm_exec_t
 /var/[xgk]dm(/.*)?		system_u:object_r:xserver_log_t
 /usr/var/[xgkw]dm(/.*)?		system_u:object_r:xserver_log_t
 /var/log/[kw]dm\.log	--	system_u:object_r:xserver_log_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/ypserv.fc policy-1.27.1/file_contexts/program/ypserv.fc
--- nsapolicy/file_contexts/program/ypserv.fc	2005-09-12 16:40:27.000000000 -0400
+++ policy-1.27.1/file_contexts/program/ypserv.fc	2005-09-16 11:35:39.000000000 -0400
@@ -1,3 +1,4 @@
 # ypserv
 /usr/sbin/ypserv		--	system_u:object_r:ypserv_exec_t
+/usr/lib/yp/.+			--	system_u:object_r:bin_t
 /etc/ypserv\.conf		--	system_u:object_r:ypserv_conf_t
diff --exclude-from=exclude -N -u -r nsapolicy/genfs_contexts policy-1.27.1/genfs_contexts
--- nsapolicy/genfs_contexts	2005-09-12 16:40:26.000000000 -0400
+++ policy-1.27.1/genfs_contexts	2005-09-16 11:35:39.000000000 -0400
@@ -94,7 +94,7 @@
 genfscon debugfs /			system_u:object_r:debugfs_t
 genfscon inotifyfs /			system_u:object_r:inotifyfs_t
 genfscon hugetlbfs /			system_u:object_r:hugetlbfs_t
-genfscon mqueue /			system_u:object_r:mqueue_t
+genfscon capifs /			system_u:object_r:capifs_t
 
 # needs more work
 genfscon eventpollfs / system_u:object_r:eventpollfs_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/core_macros.te policy-1.27.1/macros/core_macros.te
--- nsapolicy/macros/core_macros.te	2005-09-12 16:40:27.000000000 -0400
+++ policy-1.27.1/macros/core_macros.te	2005-09-16 11:35:39.000000000 -0400
@@ -620,6 +620,9 @@
 # Label pty files with a derived type.
 type_transition $1_t devpts_t:chr_file $1_devpts_t;
 
+# allow searching /dev/pts
+allow $1_t devpts_t:dir { getattr read search };
+
 # Read and write my pty files.
 allow $1_t $1_devpts_t:chr_file { setattr rw_file_perms };
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te policy-1.27.1/macros/global_macros.te
--- nsapolicy/macros/global_macros.te	2005-09-16 11:17:11.000000000 -0400
+++ policy-1.27.1/macros/global_macros.te	2005-09-16 11:35:39.000000000 -0400
@@ -157,6 +157,11 @@
 r_dir_file($1, locale_t)
 ')
 
+define(`can_access_pty', `
+allow $1 devpts_t:dir r_dir_perms;
+allow $1 $2_devpts_t:chr_file rw_file_perms;
+')
+
 ###################################
 #
 # access_terminal(domain, typeprefix)
@@ -166,8 +171,7 @@
 define(`access_terminal', `
 allow $1 $2_tty_device_t:chr_file { read write getattr ioctl };
 allow $1 devtty_t:chr_file { read write getattr ioctl };
-allow $1 devpts_t:dir { read search getattr };
-allow $1 $2_devpts_t:chr_file { read write getattr ioctl };
+can_access_pty($1, $2)
 ') 
 
 #
diff --exclude-from=exclude -N -u -r nsapolicy/macros/network_macros.te policy-1.27.1/macros/network_macros.te
--- nsapolicy/macros/network_macros.te	2005-09-16 11:17:11.000000000 -0400
+++ policy-1.27.1/macros/network_macros.te	2005-09-16 11:35:39.000000000 -0400
@@ -153,7 +153,8 @@
 ')dnl end can_network definition
 
 define(`can_resolve',`
-can_network_udp($1, `dns_port_t')
+can_network_client($1, `dns_port_t')
+allow $1 dns_port_t:tcp_socket name_connect;
 ')
 
 define(`can_portmap',`
@@ -173,3 +174,17 @@
 allow $1 winbind_var_run_t:sock_file { getattr read write };
 ')
 ')
+
+
+#################################
+#
+# nsswitch_domain(domain)
+#
+# Permissions for looking up uid/username mapping via nsswitch
+#
+define(`nsswitch_domain', `
+can_resolve($1)
+can_ypbind($1)
+can_ldap($1)
+can_winbind($1)
+')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/apache_macros.te policy-1.27.1/macros/program/apache_macros.te
--- nsapolicy/macros/program/apache_macros.te	2005-09-16 11:17:11.000000000 -0400
+++ policy-1.27.1/macros/program/apache_macros.te	2005-09-16 11:35:39.000000000 -0400
@@ -38,7 +38,7 @@
 allow httpd_$1_script_t etc_runtime_t:file { getattr read };
 read_locale(httpd_$1_script_t)
 allow httpd_$1_script_t fs_t:filesystem getattr;
-allow httpd_$1_script_t self:unix_stream_socket create_stream_socket_perms;
+allow httpd_$1_script_t self:unix_stream_socket { create_stream_socket_perms connectto };
 
 allow httpd_$1_script_t { self proc_t }:file r_file_perms;
 allow httpd_$1_script_t { self proc_t }:dir r_dir_perms;
@@ -49,7 +49,7 @@
 }
 
 if (httpd_enable_cgi && httpd_can_network_connect) {
-can_network(httpd_$1_script_t)
+can_network_client(httpd_$1_script_t)
 allow httpd_$1_script_t port_type:tcp_socket name_connect;
 }
 
@@ -83,7 +83,9 @@
 # Allow the script interpreters to run the scripts.  So
 # the perl executable will be able to run a perl script
 #########################################################################
+allow httpd_$1_script_t httpd_$1_script_exec_t:dir r_dir_perms;
 can_exec_any(httpd_$1_script_t)
+
 allow httpd_$1_script_t etc_t:file { getattr read };
 dontaudit httpd_$1_script_t selinux_config_t:dir search;
 
@@ -193,4 +195,11 @@
 create_dir_file($1_crond_t, httpd_$1_content_t)
 ')
 
+ifdef(`ftpd.te', `
+if (ftp_home_dir) {
+create_dir_file(ftpd_t, httpd_$1_content_t)
+}
+')
+
+
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/cdrecord_macros.te policy-1.27.1/macros/program/cdrecord_macros.te
--- nsapolicy/macros/program/cdrecord_macros.te	2005-09-16 11:17:11.000000000 -0400
+++ policy-1.27.1/macros/program/cdrecord_macros.te	2005-09-16 11:35:39.000000000 -0400
@@ -41,7 +41,7 @@
 
 allow $1_cdrecord_t self:capability { ipc_lock sys_nice setuid dac_override sys_rawio };
 allow $1_cdrecord_t self:process { getsched setsched fork sigchld sigkill };
-allow $1_cdrecord_t $1_devpts_t:chr_file rw_file_perms;
+can_access_pty($1_cdrecord_t, $1)
 allow $1_cdrecord_t $1_home_t:dir search;
 allow $1_cdrecord_t $1_home_dir_t:dir r_dir_perms;
 allow $1_cdrecord_t $1_home_t:file r_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/i18n_input_macros.te policy-1.27.1/macros/program/i18n_input_macros.te
--- nsapolicy/macros/program/i18n_input_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.27.1/macros/program/i18n_input_macros.te	2005-09-16 11:35:39.000000000 -0400
@@ -0,0 +1,21 @@
+#
+# Macros for i18n_input
+#
+
+#
+# Authors:  Dan Walsh <dwalsh@redhat.com> 
+#
+
+#
+# i18n_input_domain(domain)
+#
+ifdef(`i18n_input.te', `
+define(`i18n_input_domain', `
+allow i18n_input_t $1_home_dir_t:dir { getattr search };
+r_dir_file(i18n_input_t, $1_home_t)
+if (use_nfs_home_dirs) { r_dir_file(i18n_input_t, nfs_t) }
+if (use_samba_home_dirs) { r_dir_file(i18n_input_t, cifs_t) }
+')
+')
+
+
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mta_macros.te policy-1.27.1/macros/program/mta_macros.te
--- nsapolicy/macros/program/mta_macros.te	2005-09-12 16:40:26.000000000 -0400
+++ policy-1.27.1/macros/program/mta_macros.te	2005-09-16 11:35:39.000000000 -0400
@@ -34,7 +34,7 @@
 
 uses_shlib($1_mail_t)
 can_network_client_tcp($1_mail_t)
-allow $1_mail_t port_type:tcp_socket name_connect;
+allow $1_mail_t { smtp_port_t port_type }:tcp_socket name_connect;
 can_resolve($1_mail_t)
 can_ypbind($1_mail_t)
 allow $1_mail_t self:unix_dgram_socket create_socket_perms;
@@ -68,7 +68,7 @@
 allow system_mail_t system_crond_tmp_t:file { read getattr ioctl };
 allow mta_user_agent system_crond_tmp_t:file { read getattr };
 ')
-allow system_mail_t initrc_devpts_t:chr_file { read write getattr };
+can_access_pty(system_mail_t, initrc)
 
 ', `
 # For when the user wants to send mail via port 25 localhost
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/pyzor_macros.te policy-1.27.1/macros/program/pyzor_macros.te
--- nsapolicy/macros/program/pyzor_macros.te	2005-09-12 16:40:26.000000000 -0400
+++ policy-1.27.1/macros/program/pyzor_macros.te	2005-09-16 11:35:39.000000000 -0400
@@ -64,6 +64,6 @@
 
 # Allow pyzor to be run by hand.  Needed by any action other than
 # invocation from a spam filter.
-allow $1_pyzor_t $1_devpts_t:chr_file rw_file_perms;
+can_access_pty($1_pyzor_t, $1)
 allow $1_pyzor_t sshd_t:fd use;
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/razor_macros.te policy-1.27.1/macros/program/razor_macros.te
--- nsapolicy/macros/program/razor_macros.te	2005-09-12 16:40:26.000000000 -0400
+++ policy-1.27.1/macros/program/razor_macros.te	2005-09-16 11:35:39.000000000 -0400
@@ -70,6 +70,6 @@
 
 # Allow razor to be run by hand.  Needed by any action other than
 # invocation from a spam filter.
-allow $1_razor_t $1_devpts_t:chr_file rw_file_perms;
+can_access_pty($1_razor_t, $1)
 allow $1_razor_t sshd_t:fd use;
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/su_macros.te policy-1.27.1/macros/program/su_macros.te
--- nsapolicy/macros/program/su_macros.te	2005-09-16 11:17:12.000000000 -0400
+++ policy-1.27.1/macros/program/su_macros.te	2005-09-16 11:35:39.000000000 -0400
@@ -54,7 +54,7 @@
 allow $1_su_t self:process { setsched setrlimit };
 allow $1_su_t device_t:dir search;
 allow $1_su_t self:process { fork sigchld };
-can_ypbind($1_su_t)
+nsswitch_domain($1_su_t)
 r_dir_file($1_su_t, selinux_config_t)
 
 dontaudit $1_su_t shadow_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/uml_macros.te policy-1.27.1/macros/program/uml_macros.te
--- nsapolicy/macros/program/uml_macros.te	2005-09-12 16:40:26.000000000 -0400
+++ policy-1.27.1/macros/program/uml_macros.te	2005-09-16 11:35:39.000000000 -0400
@@ -81,7 +81,7 @@
 allow uml_net_t $1_uml_t:unix_stream_socket { read write };
 allow uml_net_t $1_uml_t:unix_dgram_socket { read write };
 dontaudit uml_net_t privfd:fd use;
-allow uml_net_t $1_uml_devpts_t:chr_file { read write };
+can_access_pty(uml_net_t, $1_uml)
 dontaudit uml_net_t $1_uml_rw_t:dir { getattr search };
 ')dnl end ifdef uml_net.te
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/user_macros.te policy-1.27.1/macros/user_macros.te
--- nsapolicy/macros/user_macros.te	2005-09-12 16:40:26.000000000 -0400
+++ policy-1.27.1/macros/user_macros.te	2005-09-16 11:35:39.000000000 -0400
@@ -121,6 +121,7 @@
 # user domains.
 ifelse($1, sysadm, `',`
 ifdef(`apache.te', `apache_user_domain($1)')
+ifdef(`i18n_input.te', `i18n_input_domain($1)')
 ')
 ifdef(`slocate.te', `locate_domain($1)')
 ifdef(`lockdev.te', `lockdev_domain($1)')
diff --exclude-from=exclude -N -u -r nsapolicy/Makefile policy-1.27.1/Makefile
--- nsapolicy/Makefile	2005-09-16 11:17:08.000000000 -0400
+++ policy-1.27.1/Makefile	2005-09-16 11:36:31.000000000 -0400
@@ -16,7 +16,7 @@
 MLS=n
 
 # Set to y if MCS is enabled in the policy
-MCS=n
+MCS=y
 
 FLASKDIR = flask/
 PREFIX = /usr
@@ -29,15 +29,10 @@
 VERS := $(shell $(CHECKPOLICY) $(POLICYCOMPAT) -V |cut -f 1 -d ' ')
 PREVERS := 19
 KERNVERS := $(shell cat /selinux/policyvers)
+MLSENABLED := $(shell cat /selinux/mls)
 POLICYVER := policy.$(VERS)
 TOPDIR = $(DESTDIR)/etc/selinux
 TYPE=strict
-ifeq ($(MLS),y)
-TYPE=mls
-endif
-ifeq ($(MCS),y)
-TYPE=mcs
-endif
 
 INSTALLDIR = $(TOPDIR)/$(TYPE)
 POLICYPATH = $(INSTALLDIR)/policy
@@ -89,8 +84,12 @@
 all:  policy
 
 tmp/valid_fc: $(LOADPATH) $(FC) 
+ifeq ($(CHECKPOLMLS), -M)
+ifeq ($(MLSENABLED),1)
 	@echo "Validating file contexts files ..."	
 	$(SETFILES) -q -c $(LOADPATH) $(FC)
+endif
+endif
 	@touch tmp/valid_fc
 
 install: $(FCPATH) $(APPFILES) $(ROOTFILES) $(USERPATH)/local.users
@@ -160,7 +159,7 @@
 	@mkdir -p $(POLICYPATH)
 	$(CHECKPOLICY) $(CHECKPOLMLS) -o $@ policy.conf
 ifneq ($(VERS),$(PREVERS))
-	$(CHECKPOLICY) -c $(PREVERS) -o $(POLICYPATH)/policy.$(PREVERS) policy.conf
+	$(CHECKPOLICY) $(CHECKPOLMLS) -c $(PREVERS) -o $(POLICYPATH)/policy.$(PREVERS) policy.conf
 endif
 
 # Note: Can't use install, so not sure how to deal with mode, user, and group
@@ -170,8 +169,12 @@
 
 $(POLICYVER):  policy.conf $(FC) $(CHECKPOLICY)
 	$(CHECKPOLICY) $(CHECKPOLMLS) -o $@ policy.conf
+ifeq ($(CHECKPOLMLS), -M)
+ifeq (1, $(MLSENABLED))
 	@echo "Validating file contexts files ..."
 	$(SETFILES) -q -c $(POLICYVER) $(FC)
+endif
+endif
 
 reload tmp/load: $(LOADPATH) 
 	@echo "Loading Policy ..."
@@ -355,10 +358,9 @@
 	@for file in $(USER_FILES); do \
 		echo "Converting $$file"; \
 		sed -r -e 's/\;/ level s0 range s0;/' $$file | \
-		sed -r -e 's/(user (root|system_u).*);/\1 - s0:c0.c127;/' > $$file.new; \
+		sed -r -e 's/(user (user_u|root|system_u).*);/\1 - s0:c0.c127;/' > $$file.new; \
 		mv $$file.new $$file; \
 	done
-	@sed -e '/sid kernel/s/s0/s0 - s0:c0.c127/' initial_sid_contexts > initial_sid_contexts.new && mv initial_sid_contexts.new initial_sid_contexts
 	@echo "Enabling MCS in the Makefile"
 	@sed "s/MCS=y/MCS=y/" Makefile > Makefile.new
 	@mv Makefile.new Makefile
diff --exclude-from=exclude -N -u -r nsapolicy/mcs policy-1.27.1/mcs
--- nsapolicy/mcs	2005-09-15 16:13:03.000000000 -0400
+++ policy-1.27.1/mcs	2005-09-16 11:35:39.000000000 -0400
@@ -200,9 +200,23 @@
 #
 # Only files are constrained by MCS at this stage.
 #
-mlsconstrain file { read write setattr append unlink link rename
+mlsconstrain file { write setattr append unlink link rename
 		    create ioctl lock execute } (h1 dom h2);
 
+mlsconstrain file { read } ((h1 dom h2) or 
+			    ( t1 == mlsfileread ));
+
+
+# new file labels must be dominated by the relabeling subject's clearance
+mlsconstrain { dir file lnk_file chr_file blk_file sock_file fifo_file } { relabelfrom relabelto }
+	( h1 dom h2 );
+
+define(`nogetattr_file_perms', `{ create ioctl read lock write setattr append 
+link unlink rename relabelfrom relabelto }')
+
+define(`nogetattr_dir_perms', `{ create read lock setattr ioctl link unlink 
+rename search add_name remove_name reparent write rmdir relabelfrom 
+relabelto }')
 
 # XXX
 #
diff --exclude-from=exclude -N -u -r nsapolicy/net_contexts policy-1.27.1/net_contexts
--- nsapolicy/net_contexts	2005-09-16 11:17:08.000000000 -0400
+++ policy-1.27.1/net_contexts	2005-09-16 11:35:39.000000000 -0400
@@ -50,6 +50,10 @@
 portcon tcp 53 system_u:object_r:dns_port_t
 
 portcon udp 67  system_u:object_r:dhcpd_port_t
+portcon udp 647  system_u:object_r:dhcpd_port_t
+portcon tcp 647  system_u:object_r:dhcpd_port_t
+portcon udp 847  system_u:object_r:dhcpd_port_t
+portcon tcp 847  system_u:object_r:dhcpd_port_t
 portcon udp 68  system_u:object_r:dhcpc_port_t
 portcon udp 70 system_u:object_r:gopher_port_t
 portcon tcp 70 system_u:object_r:gopher_port_t
@@ -164,6 +168,8 @@
 portcon tcp 50000 system_u:object_r:hplip_port_t
 portcon tcp 50002 system_u:object_r:hplip_port_t
 portcon tcp 5900  system_u:object_r:vnc_port_t 
+portcon tcp 5988  system_u:object_r:pegasus_http_port_t
+portcon tcp 5989  system_u:object_r:pegasus_https_port_t
 portcon tcp 6000  system_u:object_r:xserver_port_t
 portcon tcp 6001  system_u:object_r:xserver_port_t
 portcon tcp 6002  system_u:object_r:xserver_port_t
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/appconfig/root_default_contexts policy-1.27.1/targeted/appconfig/root_default_contexts
--- nsapolicy/targeted/appconfig/root_default_contexts	2005-09-12 16:40:26.000000000 -0400
+++ policy-1.27.1/targeted/appconfig/root_default_contexts	2005-09-16 11:35:39.000000000 -0400
@@ -1,2 +1,6 @@
 system_r:unconfined_t	system_r:unconfined_t
 system_r:initrc_t	system_r:unconfined_t
+system_r:local_login_t system_r:unconfined_t
+system_r:remote_login_t system_r:unconfined_t
+system_r:rshd_t		system_r:unconfined_t
+system_r:crond_t	system_r:unconfined_t
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/program/ssh.te policy-1.27.1/targeted/domains/program/ssh.te
--- nsapolicy/targeted/domains/program/ssh.te	2005-09-12 16:40:26.000000000 -0400
+++ policy-1.27.1/targeted/domains/program/ssh.te	2005-09-16 11:35:39.000000000 -0400
@@ -17,3 +17,6 @@
 type sshd_key_t, file_type, sysadmfile;
 type sshd_var_run_t, file_type, sysadmfile;
 domain_auto_trans(initrc_t, sshd_exec_t, sshd_t)
+ifdef(`use_mcs', `
+range_transition initrc_t sshd_exec_t s0 - s0:c0.c127;
+')
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/program/xdm.te policy-1.27.1/targeted/domains/program/xdm.te
--- nsapolicy/targeted/domains/program/xdm.te	2005-09-12 16:40:26.000000000 -0400
+++ policy-1.27.1/targeted/domains/program/xdm.te	2005-09-16 11:35:39.000000000 -0400
@@ -20,3 +20,7 @@
 type xdm_tmp_t, file_type, sysadmfile;
 domain_auto_trans(initrc_t, xdm_exec_t, xdm_t)
 domain_auto_trans(init_t, xdm_exec_t, xdm_t)
+ifdef(`use_mcs', `
+range_transition init_t xdm_exec_t s0 - s0:c0.c127;
+range_transition initrc_t xdm_exec_t s0 - s0:c0.c127;
+')
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/unconfined.te policy-1.27.1/targeted/domains/unconfined.te
--- nsapolicy/targeted/domains/unconfined.te	2005-09-12 16:40:26.000000000 -0400
+++ policy-1.27.1/targeted/domains/unconfined.te	2005-09-16 11:35:39.000000000 -0400
@@ -7,15 +7,14 @@
 type unconfined_t, domain, privuser, privhome, privrole, privowner, admin, auth_write, fs_domain, privmem;
 role system_r types unconfined_t;
 role user_r types unconfined_t;
-role sysadm_r types unconfined_t;
 unconfined_domain(unconfined_t)
 allow domain unconfined_t:fd use;
 allow domain unconfined_t:process sigchld;
 
 # Define some type aliases to help with compatibility with
 # macros and domains from the "strict" policy.
-typealias bin_t alias su_exec_t;
 typealias unconfined_t alias { logrotate_t sendmail_t sshd_t secadm_t sysadm_t rpm_t rpm_script_t xdm_t };
+
 typeattribute tty_device_t admin_tty_type;
 typeattribute devpts_t admin_tty_type;
 
@@ -63,6 +62,7 @@
 bool use_samba_home_dirs false;
 
 ifdef(`samba.te', `samba_domain(user)')
+ifdef(`i18n_input.te', `i18n_input_domain(user)')
 
 # Allow system to run with NIS
 bool allow_ypbind false;
@@ -77,3 +77,14 @@
 allow domain self:process execmem;
 }
 
+#Removing i18n_input from targeted for now, since wants to read users homedirs
+typealias bin_t alias i18n_input_exec_t;
+typealias unconfined_t alias i18n_input_t;
+typealias var_run_t alias i18n_input_var_run_t;
+# Needed to get su working
+bool secure_mode false;
+typealias unconfined_t alias { sysadm_chkpwd_t };
+typealias tmp_t alias { sysadm_tmp_t sshd_tmp_t };
+su_domain(sysadm)
+typeattribute sysadm_su_t unrestricted;
+role system_r types sysadm_su_t;
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.27.1/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2005-09-12 16:40:26.000000000 -0400
+++ policy-1.27.1/tunables/distro.tun	2005-09-16 11:35:39.000000000 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.27.1/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2005-09-12 16:40:26.000000000 -0400
+++ policy-1.27.1/tunables/tunable.tun	2005-09-16 11:35:39.000000000 -0400
@@ -1,5 +1,5 @@
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
 dnl define(`unlimitedUtils')
@@ -17,7 +17,7 @@
 
 # Do not audit things that we know to be broken but which
 # are not security risks
-dnl define(`hide_broken_symptoms')
+define(`hide_broken_symptoms')
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
diff --exclude-from=exclude -N -u -r nsapolicy/types/file.te policy-1.27.1/types/file.te
--- nsapolicy/types/file.te	2005-09-16 11:17:12.000000000 -0400
+++ policy-1.27.1/types/file.te	2005-09-16 11:35:39.000000000 -0400
@@ -307,8 +307,7 @@
 type hugetlbfs_t, mount_point, fs_type,  sysadmfile;
 allow hugetlbfs_t self:filesystem associate;
 
-type mqueue_t, mount_point, fs_type,  sysadmfile;
-allow mqueue_t self:filesystem associate;
+typealias file_t alias  mqueue_t;
 
 # udev_runtime_t is the type of the udev table file
 type udev_runtime_t, file_type, sysadmfile;
@@ -325,6 +324,9 @@
 type inotifyfs_t, fs_type, sysadmfile;
 allow inotifyfs_t self:filesystem associate;
 
+type capifs_t, fs_type, sysadmfile;
+allow capifs_t self:filesystem associate;
+
 # removable_t is the default type of all removable media
 type removable_t, file_type, sysadmfile, usercanread;
 allow removable_t self:filesystem associate;
diff --exclude-from=exclude -N -u -r nsapolicy/types/network.te policy-1.27.1/types/network.te
--- nsapolicy/types/network.te	2005-09-16 11:17:12.000000000 -0400
+++ policy-1.27.1/types/network.te	2005-09-16 11:35:39.000000000 -0400
@@ -120,6 +120,8 @@
 type zebra_port_t, port_type;
 type i18n_input_port_t, port_type;
 type vnc_port_t, port_type;
+type pegasus_http_port_t, port_type;
+type pegasus_https_port_t, port_type;
 type openvpn_port_t, port_type;
 type clamd_port_t, port_type, reserved_port_type;
 type transproxy_port_t, port_type;
diff --exclude-from=exclude -N -u -r nsapolicy/types/security.te policy-1.27.1/types/security.te
--- nsapolicy/types/security.te	2005-09-12 16:40:26.000000000 -0400
+++ policy-1.27.1/types/security.te	2005-09-16 11:35:39.000000000 -0400
@@ -19,6 +19,10 @@
 # the security server policy configuration.
 #
 type policy_config_t, file_type, secadmfile;
+# Since libselinux attempts to read these by default, most domains 
+# do not need it.
+dontaudit domain selinux_config_t:dir search;
+dontaudit domain selinux_config_t:file { getattr read };
 
 #
 # policy_src_t is the type of the policy source

--------------020904010808010803090406--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

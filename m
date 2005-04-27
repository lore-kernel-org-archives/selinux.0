Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3TCaRgA002249
	for <selinux@tycho.nsa.gov>; Fri, 29 Apr 2005 08:36:27 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3TCZsU2013343
	for <selinux@tycho.nsa.gov>; Fri, 29 Apr 2005 12:35:54 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id j3TCaxe3006908
	for <selinux@tycho.nsa.gov>; Fri, 29 Apr 2005 08:36:59 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1/Submit) id j3TCaxgA006907
	for selinux@tycho.nsa.gov; Fri, 29 Apr 2005 08:36:59 -0400
Message-ID: <42700179.3000905@redhat.com>
Date: Wed, 27 Apr 2005 17:17:45 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>, Jim Carter <jwcart2@epoch.ncsc.mil>
Subject: Latest diffs.
Content-Type: multipart/mixed;
 boundary="------------030604060605010508080403"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030604060605010508080403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Many changes made allow targeted policy to run closer to strict.  Almost 
all of non-userspace is now protected via SELinux.

Run kernel in unconfined_domain for targeted.  (Might be necessary for 
strict).

move user_ttyfile_stat boolean out of getty and into user.te

Small fixes to support mgetty

A couple of changes to allow policy upgrades to this policy.  
(syslog_mod changes).

Remove false check for rhgb.te from init.te

Allow users to mount on src_t

Small fixes for amanda

Add tmpfile attribute to  amavisd_quaranteen

Add transitionbool to daemon_sub_domain, mainly to turn off httpd_suexec 
transitioning.

Allow apmd_t to do it's thing on targeted policy.

Auditd fixes by Paul Moore.

Allow cardmgr_t to work on targeted policy

Implement web_client_domain name_connect rules;

Cleanup of consoletype.te for targeted.  I think this domain needs some 
review.

Add yp support for cups.

Remove some garbarge from cyrus.te

Allow hald to run on targeted domain

Allow hotplug to run on targeted domain

Fixes for latest version of NetworkManager.  Have not changed the case.  
I have no opinion on it.

Fixed and cleanup of ntpd.te

Fixes for initrc writing samba_etc_t

Change don't to "do not"

Cleanup compat.te for targetd policy

Several changes for file_context for FC4

Remove hotplug, udev, initial_sid_contexts from targeted directory.  We 
are going to use the real ones.

kernel now runs as root:system_r:kernel_t in targeted policy just like 
strict









-- 



--------------030604060605010508080403
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/misc/kernel.te policy-1.23.13/domains/misc/kernel.te
--- nsapolicy/domains/misc/kernel.te	2005-04-27 10:28:48.000000000 -0400
+++ policy-1.23.13/domains/misc/kernel.te	2005-04-26 10:00:08.000000000 -0400
@@ -63,4 +63,6 @@
 # /proc/sys/kernel/modprobe is set to /bin/true if not using modules.
 can_exec(kernel_t, bin_t)
 
-
+ifdef(`targeted_policy', `
+unconfined_domain(kernel_t)
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/fsadm.te policy-1.23.13/domains/program/fsadm.te
--- nsapolicy/domains/program/fsadm.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.23.13/domains/program/fsadm.te	2005-04-25 15:18:00.000000000 -0400
@@ -100,7 +100,7 @@
 allow fsadm_t kernel_t:system syslog_console;
 
 # Access terminals.
-allow fsadm_t { initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
+allow fsadm_t { initrc_devpts_t admin_tty_type devtty_t }:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow fsadm_t sysadm_gph_t:fd use;')
 allow fsadm_t privfd:fd use;
 allow fsadm_t devpts_t:dir { getattr search };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/getty.te policy-1.23.13/domains/program/getty.te
--- nsapolicy/domains/program/getty.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.23.13/domains/program/getty.te	2005-04-25 15:18:00.000000000 -0400
@@ -23,18 +23,9 @@
 allow getty_t self:unix_dgram_socket create_socket_perms;
 allow getty_t self:unix_stream_socket create_socket_perms;
 
-# to allow w to display everyone...
-bool user_ttyfile_stat false;
-if (user_ttyfile_stat) {
-allow userdomain ttyfile:chr_file getattr;
-}
-
 # Use capabilities.
 allow getty_t self:capability { dac_override chown sys_resource sys_tty_config };
 
-# fbgetty needs fsetid for some reason
-#allow getty_t self:capability fsetid;
-
 read_locale(getty_t)
 
 # Run login in local_login_t domain.
@@ -51,10 +42,13 @@
 # Chown, chmod, read and write ttys.
 allow getty_t tty_device_t:chr_file { setattr rw_file_perms };
 allow getty_t ttyfile:chr_file { setattr rw_file_perms };
-allow getty_t initrc_devpts_t:chr_file rw_file_perms; 
+dontaudit getty_t initrc_devpts_t:chr_file rw_file_perms; 
 
 # for error condition handling
 allow getty_t fs_t:filesystem getattr;
 
 lock_domain(getty)
 r_dir_file(getty_t, sysfs_t)
+# for mgetty
+var_run_domain(getty)
+allow getty_t self:capability { fowner fsetid };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/hostname.te policy-1.23.13/domains/program/hostname.te
--- nsapolicy/domains/program/hostname.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.23.13/domains/program/hostname.te	2005-04-25 15:48:24.000000000 -0400
@@ -24,3 +24,4 @@
 ifdef(`distro_redhat', `
 allow hostname_t tmpfs_t:chr_file rw_file_perms;
 ')
+allow hostname_t initrc_devpts_t:chr_file { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te policy-1.23.13/domains/program/initrc.te
--- nsapolicy/domains/program/initrc.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.23.13/domains/program/initrc.te	2005-04-25 15:18:00.000000000 -0400
@@ -253,6 +253,7 @@
 allow unconfined_t initrc_t:dbus { acquire_svc send_msg };
 allow initrc_t unconfined_t:dbus { acquire_svc send_msg };
 domain_trans(initrc_t, shell_exec_t, unconfined_t)
+allow initrc_t unconfined_t:system syslog_mod;
 ', `
 run_program(sysadm_t, sysadm_r, init, initrc_exec_t, initrc_t)
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/init.te policy-1.23.13/domains/program/init.te
--- nsapolicy/domains/program/init.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.23.13/domains/program/init.te	2005-04-27 16:52:24.000000000 -0400
@@ -82,6 +82,7 @@
 # Modify utmp.
 allow init_t var_run_t:file rw_file_perms;
 allow init_t initrc_var_run_t:file { setattr rw_file_perms };
+can_unix_connect(init_t, initrc_t)
 
 # For /var/run/shutdown.pid.
 var_run_domain(init)
@@ -131,10 +132,9 @@
 
 allow init_t lib_t:file { getattr read };
 
-ifdef(`rhgb.te', `
 allow init_t devtty_t:chr_file { read write };
 allow init_t ramfs_t:dir search;
-')
+allow init_t ramfs_t:sock_file write;
 r_dir_file(init_t, sysfs_t)
 
 r_dir_file(init_t, selinux_config_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/klogd.te policy-1.23.13/domains/program/klogd.te
--- nsapolicy/domains/program/klogd.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.23.13/domains/program/klogd.te	2005-04-25 15:18:00.000000000 -0400
@@ -43,3 +43,6 @@
 # Read /boot/System.map*
 allow klogd_t system_map_t:file r_file_perms;
 allow klogd_t boot_t:dir r_dir_perms;
+ifdef(`targeted_policy', `
+allow klogd_t unconfined_t:system syslog_mod;
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/load_policy.te policy-1.23.13/domains/program/load_policy.te
--- nsapolicy/domains/program/load_policy.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.23.13/domains/program/load_policy.te	2005-04-25 15:18:00.000000000 -0400
@@ -39,6 +39,7 @@
 # only allow read of policy config files
 allow load_policy_t policy_src_t:dir search;
 r_dir_file(load_policy_t, policy_config_t)
+r_dir_file(load_policy_t, selinux_config_t)
 
 # directory search permissions for path to binary policy files
 allow load_policy_t root_t:dir search;
@@ -57,5 +58,3 @@
 allow load_policy_t fs_t:filesystem getattr;
 
 read_locale(load_policy_t)
-r_dir_file(load_policy_t, selinux_config_t)
-allow load_policy_t proc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/mount.te policy-1.23.13/domains/program/mount.te
--- nsapolicy/domains/program/mount.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.23.13/domains/program/mount.te	2005-04-27 10:42:39.000000000 -0400
@@ -40,6 +40,7 @@
 allow mount_t default_t:dir mounton;
 allow mount_t file_t:dir mounton;
 allow mount_t usr_t:dir mounton;
+allow mount_t src_t:dir mounton;
 allow mount_t var_t:dir mounton;
 allow mount_t proc_t:dir mounton;
 allow mount_t root_t:dir mounton;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/amanda.te policy-1.23.13/domains/program/unused/amanda.te
--- nsapolicy/domains/program/unused/amanda.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.23.13/domains/program/unused/amanda.te	2005-04-26 12:02:46.000000000 -0400
@@ -303,6 +303,7 @@
 
 allow amanda_t file_type:dir {getattr read search };
 allow amanda_t file_type:{ lnk_file file chr_file blk_file } {getattr read };
+allow amanda_t fixed_disk_device_t:blk_file getattr;
 dontaudit amanda_t file_type:sock_file getattr;
 logdir_domain(amanda)
 
@@ -310,6 +311,7 @@
 dontaudit amanda_t binfmt_misc_fs_t:dir getattr;
 dontaudit amanda_t nfs_t:dir { getattr read };
 dontaudit amanda_t proc_t:dir read;
+dontaudit amanda_t proc_t:lnk_file read;
 dontaudit amanda_t rpc_pipefs_t:dir { getattr read };
 dontaudit amanda_t security_t:dir { getattr read };
 dontaudit amanda_t sysfs_t:dir { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/amavis.te policy-1.23.13/domains/program/unused/amavis.te
--- nsapolicy/domains/program/unused/amavis.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.23.13/domains/program/unused/amavis.te	2005-04-25 15:18:00.000000000 -0400
@@ -13,7 +13,7 @@
 type amavisd_lib_t, file_type, sysadmfile;
 
 # Virus and spam found and quarantined.
-type amavisd_quarantine_t, file_type, sysadmfile;
+type amavisd_quarantine_t, file_type, sysadmfile, tmpfile;
 
 # Differentiate between the port where amavisd receives mail, and the
 # port where it returns cleaned mail back to the MTA.
@@ -118,8 +118,3 @@
 dontaudit amavisd_t shadow_t:file { getattr read };
 dontaudit amavisd_t sysadm_devpts_t:chr_file { read write };
 
-# Tmp reaper
-ifdef(`tmpreaper.te', `
-allow tmpreaper_t amavisd_quarantine_t:dir { read search getattr setattr unlink };
-allow tmpreaper_t amavisd_quarantine_t:file getattr;
-')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.23.13/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.23.13/domains/program/unused/apache.te	2005-04-25 15:18:00.000000000 -0400
@@ -290,7 +290,7 @@
 allow httpd_helper_t httpd_log_t:file { append };
 
 ########################################
-# When the admin starts the server, the server wants to acess
+# When the admin starts the server, the server wants to access
 # the TTY or PTY associated with the session. The httpd appears
 # to run correctly without this permission, so the permission
 # are dontaudited here. 
@@ -322,7 +322,7 @@
 # The following are types for SUEXEC,which runs user scripts as their
 # own user ID
 #
-daemon_sub_domain(httpd_t, httpd_suexec)
+daemon_sub_domain(httpd_t, httpd_suexec, `, transitionbool')
 allow httpd_t httpd_suexec_exec_t:file read;
 
 #########################################################
@@ -361,12 +361,6 @@
 allow httpd_suexec_t autofs_t:dir { search getattr };
 tmp_domain(httpd_suexec)
 
-ifdef(`mta.te', `
-# apache should set close-on-exec
-dontaudit httpd_suexec_t httpd_t:unix_stream_socket { read write };
-dontaudit { system_mail_t mta_user_agent } { httpd_t httpd_sys_script_t }:unix_stream_socket { read write };
-')
-
 if (httpd_enable_cgi && httpd_unified ifdef(`targeted_policy', ` && ! httpd_disable_trans')) {
 domain_auto_trans(httpd_suexec_t, httpdcontent, httpd_sys_script_t)
 domain_auto_trans(sysadm_t, httpdcontent, httpd_sys_script_t)
@@ -374,7 +368,6 @@
 if (httpd_enable_cgi && httpd_unified && httpd_builtin_scripting ifdef(`targeted_policy', ` && ! httpd_disable_trans')) {
 domain_auto_trans(httpd_t, httpdcontent, httpd_sys_script_t)
 create_dir_file(httpd_t, httpdcontent)
-can_exec(httpd_t, httpdcontent )
 }
 if (httpd_enable_cgi) {
 domain_auto_trans(httpd_t, httpd_unconfined_script_exec_t, httpd_unconfined_script_t)
@@ -396,9 +389,10 @@
 r_dir_file(httpd_sys_script_t, squirrelmail_spool_t)
 
 ifdef(`mta.te', `
+# apache should set close-on-exec
+dontaudit httpd_suexec_t httpd_t:unix_stream_socket { read write };
+dontaudit { system_mail_t mta_user_agent } { httpd_t httpd_sys_script_t }:unix_stream_socket { read write };
 dontaudit system_mail_t httpd_log_t:file { append getattr };
 allow system_mail_t httpd_squirrelmail_t:file { append read };
 dontaudit system_mail_t httpd_t:tcp_socket { read write };
 ')
-
-allow httpd_t var_t:file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apmd.te policy-1.23.13/domains/program/unused/apmd.te
--- nsapolicy/domains/program/unused/apmd.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.23.13/domains/program/unused/apmd.te	2005-04-25 16:03:20.000000000 -0400
@@ -108,6 +108,7 @@
 #
 # Allow it to run killof5 and pidof
 #
+typeattribute apmd_t unrestricted;
 r_dir_file(apmd_t, domain)
 
 # Same for apm/acpid scripts
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/auditd.te policy-1.23.13/domains/program/unused/auditd.te
--- nsapolicy/domains/program/unused/auditd.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.23.13/domains/program/unused/auditd.te	2005-04-25 15:18:00.000000000 -0400
@@ -2,6 +2,8 @@
 #
 # Authors: Colin Walters <walters@verbum.org>
 #
+# Some fixes by Paul Moore <paul.moore@hp.com>
+# 
 define(`audit_manager_domain', `
 allow $1 auditd_etc_t:file rw_file_perms;
 create_dir_file($1, auditd_log_t)
@@ -15,10 +17,10 @@
 allow auditd_t self:capability { audit_write audit_control sys_nice };
 allow auditd_t etc_t:file { getattr read };
 
-# Don't use logdir_domain since this is a security file
+# Do not use logdir_domain since this is a security file
 type auditd_log_t, file_type, secure_file_type;
-file_type_auto_trans(auditd_t, var_log_t, auditd_log_t, file)
-allow auditd_t auditd_log_t:dir { setattr rw_dir_perms };
+allow auditd_t var_log_t:dir search;
+rw_dir_create_file(auditd_t, auditd_log_t)
 
 can_exec(auditd_t, init_exec_t)
 
@@ -43,7 +45,14 @@
 ifdef(`separate_secadm', `', `
 audit_manager_domain(sysadm_t)
 ')
+allow initrc_t auditd_etc_t:file r_file_perms;
+
+role system_r types auditctl_t;
+domain_auto_trans(initrc_t, auditctl_exec_t, auditctl_t)
+
 dontaudit auditctl_t local_login_t:fd use;
 allow auditctl_t proc_t:dir search;
 allow auditctl_t sysctl_kernel_t:dir search;
 allow auditctl_t sysctl_kernel_t:file read;
+allow auditd_t self:process setsched;
+dontaudit auditctl_t init_t:fd use; 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cardmgr.te policy-1.23.13/domains/program/unused/cardmgr.te
--- nsapolicy/domains/program/unused/cardmgr.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.23.13/domains/program/unused/cardmgr.te	2005-04-26 09:57:58.000000000 -0400
@@ -61,7 +61,9 @@
 allow cardmgr_t proc_t:file { getattr read ioctl };
 
 # Read /proc/PID directories for all domains (for fuser).
-can_ps(cardmgr_t, domain)
+can_ps(cardmgr_t, domain -unrestricted)
+dontaudit cardmgr_t unrestricted:dir search;
+
 allow cardmgr_t device_type:{ chr_file blk_file } getattr;
 allow cardmgr_t ttyfile:chr_file getattr;
 dontaudit cardmgr_t ptyfile:chr_file getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/clamav.te policy-1.23.13/domains/program/unused/clamav.te
--- nsapolicy/domains/program/unused/clamav.te	2005-04-27 10:28:50.000000000 -0400
+++ policy-1.23.13/domains/program/unused/clamav.te	2005-04-25 15:18:00.000000000 -0400
@@ -22,7 +22,7 @@
 # Freshclam
 #
 
-daemon_base_domain(freshclam)
+daemon_base_domain(freshclam, `, web_client_domain')
 read_locale(freshclam_t)
 
 # not sure why it needs this
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/consoletype.te policy-1.23.13/domains/program/unused/consoletype.te
--- nsapolicy/domains/program/unused/consoletype.te	2005-04-27 10:28:50.000000000 -0400
+++ policy-1.23.13/domains/program/unused/consoletype.te	2005-04-25 15:18:00.000000000 -0400
@@ -19,29 +19,28 @@
 uses_shlib(consoletype_t)
 general_domain_access(consoletype_t)
 
+ifdef(`targeted_policy', `', `
 domain_auto_trans(initrc_t, consoletype_exec_t, consoletype_t)
 
-allow consoletype_t tty_device_t:chr_file { getattr ioctl write };
-allow consoletype_t devtty_t:chr_file { read write };
-allow consoletype_t initrc_devpts_t:chr_file { read write getattr ioctl };
-
 ifdef(`xdm.te', `
 domain_auto_trans(xdm_t, consoletype_exec_t, consoletype_t)
 allow consoletype_t xdm_tmp_t:file { read write };
 ')
 
-allow consoletype_t { kernel_t init_t initrc_t privfd sysadm_t }:fd use;
-allow consoletype_t admin_tty_type:chr_file rw_file_perms;
 ifdef(`hotplug.te', `
 domain_auto_trans(hotplug_t, consoletype_exec_t, consoletype_t)
 ')
+')
+
+allow consoletype_t {admin_tty_type tty_device_t devtty_t initrc_devpts_t }:chr_file rw_file_perms;
+
+allow consoletype_t { kernel_t init_t initrc_t privfd sysadm_t }:fd use;
 
 # Use capabilities.
 allow consoletype_t self:capability sys_admin;
 
 allow consoletype_t console_device_t:chr_file { getattr ioctl read write };
 allow consoletype_t initrc_t:fifo_file write;
-allow consoletype_t tty_device_t:chr_file read;
 allow consoletype_t nfs_t:file write;
 allow consoletype_t sysadm_t:fifo_file rw_file_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.23.13/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2005-04-27 10:28:50.000000000 -0400
+++ policy-1.23.13/domains/program/unused/cups.te	2005-04-25 15:18:00.000000000 -0400
@@ -17,6 +17,7 @@
 type cupsd_rw_etc_t, file_type, sysadmfile, usercanread;
 
 can_network(cupsd_t)
+can_ypbind(cupsd_t)
 allow cupsd_t port_type:tcp_socket name_connect;
 logdir_domain(cupsd)
 
@@ -203,6 +204,7 @@
 file_type_auto_trans(cupsd_config_t, cupsd_etc_t, cupsd_rw_etc_t, file)
 
 can_network_tcp(cupsd_config_t)
+can_ypbind(cupsd_config_t)
 allow cupsd_config_t port_type:tcp_socket name_connect;
 can_tcp_connect(cupsd_config_t, cupsd_t)
 allow cupsd_config_t self:fifo_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cyrus.te policy-1.23.13/domains/program/unused/cyrus.te
--- nsapolicy/domains/program/unused/cyrus.te	2005-04-27 10:28:50.000000000 -0400
+++ policy-1.23.13/domains/program/unused/cyrus.te	2005-04-26 11:29:42.000000000 -0400
@@ -15,8 +15,6 @@
 allow cyrus_t self:capability { dac_override net_bind_service setgid setuid sys_resource };
 allow cyrus_t self:process setrlimit;
 
-allow initrc_su_t cyrus_var_lib_t:dir search;
-
 can_network(cyrus_t)
 allow cyrus_t port_type:tcp_socket name_connect;
 can_ypbind(cyrus_t)
@@ -35,7 +33,6 @@
 allow cyrus_t proc_t:file { getattr read };
 allow cyrus_t sysadm_devpts_t:chr_file { read write };
 
-allow cyrus_t staff_t:fd use;
 allow cyrus_t var_lib_t:dir search;
 
 allow cyrus_t etc_runtime_t:file { read getattr };
@@ -43,6 +40,5 @@
 system_crond_entry(cyrus_exec_t, cyrus_t)
 allow system_crond_t cyrus_var_lib_t:dir rw_dir_perms;
 allow system_crond_t cyrus_var_lib_t:file create_file_perms;
-allow system_crond_su_t cyrus_var_lib_t:dir search;
 ')
 allow cyrus_t mail_port_t:tcp_socket name_bind;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.23.13/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2005-04-27 10:28:51.000000000 -0400
+++ policy-1.23.13/domains/program/unused/hald.te	2005-04-25 15:18:00.000000000 -0400
@@ -93,3 +93,7 @@
 ifdef(`lvm.te', `
 allow hald_t lvm_control_t:chr_file r_file_perms;
 ')
+ifdef(`targeted_policy', `
+allow unconfined_t hald_t:dbus send_msg;
+allow hald_t unconfined_t:dbus send_msg;
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hotplug.te policy-1.23.13/domains/program/unused/hotplug.te
--- nsapolicy/domains/program/unused/hotplug.te	2005-04-27 10:28:51.000000000 -0400
+++ policy-1.23.13/domains/program/unused/hotplug.te	2005-04-25 15:18:00.000000000 -0400
@@ -83,7 +83,9 @@
 allow hotplug_t self:file getattr;
 
 domain_auto_trans(kernel_t, hotplug_exec_t, hotplug_t)
+ifdef(`mount.te', `
 domain_auto_trans(hotplug_t, mount_exec_t, mount_t)
+')
 domain_auto_trans(hotplug_t, ifconfig_exec_t, ifconfig_t)
 ifdef(`updfstab.te', `
 domain_auto_trans(hotplug_t, updfstab_exec_t, updfstab_t)
@@ -154,10 +156,4 @@
 domain_auto_trans(hotplug_t, sendmail_exec_t, system_mail_t) 
 ')
 
-allow restorecon_t hotplug_t:fd use;
-
-ifdef(`unlimitedUtils', `
-unconfined_domain(hotplug_t) 
-')
-
 allow kernel_t hotplug_etc_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/NetworkManager.te policy-1.23.13/domains/program/unused/NetworkManager.te
--- nsapolicy/domains/program/unused/NetworkManager.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.23.13/domains/program/unused/NetworkManager.te	2005-04-27 16:52:07.000000000 -0400
@@ -35,11 +35,14 @@
 #
 # Communicate with Caching Name Server
 #
+ifdef(`named.te', `
 allow NetworkManager_t named_zone_t:dir search;
 rw_dir_create_file(NetworkManager_t, named_cache_t)
 domain_auto_trans(NetworkManager_t, named_exec_t, named_t)
 allow named_t NetworkManager_t:udp_socket { read write };
+allow named_t NetworkManager_t:netlink_route_socket { read write };
 allow NetworkManager_t named_t:process signal;
+')
 
 allow NetworkManager_t selinux_config_t:dir search;
 allow NetworkManager_t selinux_config_t:file { getattr read };
@@ -87,3 +90,4 @@
 domain_auto_trans(NetworkManager_t, insmod_exec_t, insmod_t)
 allow NetworkManager_t self:netlink_route_socket r_netlink_socket_perms;
 
+domain_auto_trans(NetworkManager_t, initrc_exec_t, initrc_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ntpd.te policy-1.23.13/domains/program/unused/ntpd.te
--- nsapolicy/domains/program/unused/ntpd.te	2005-04-27 10:28:52.000000000 -0400
+++ policy-1.23.13/domains/program/unused/ntpd.te	2005-04-27 08:00:35.000000000 -0400
@@ -14,7 +14,6 @@
 
 type ntpdate_exec_t, file_type, sysadmfile, exec_type;
 domain_auto_trans(initrc_t, ntpdate_exec_t, ntpd_t)
-allow sysadm_t ntp_port_t:udp_socket name_bind;
 
 logdir_domain(ntpd)
 
@@ -26,7 +25,7 @@
 allow ntpd_t ntp_drift_t:file create_file_perms;
 
 # for SSP
-allow ntpd_t urandom_device_t:chr_file read;
+allow ntpd_t urandom_device_t:chr_file { getattr read };
 
 allow ntpd_t self:capability { kill setgid setuid sys_time net_bind_service ipc_lock sys_chroot };
 dontaudit ntpd_t self:capability { net_admin };
@@ -45,6 +44,7 @@
 allow ntpd_t ntp_port_t:tcp_socket name_connect;
 can_ypbind(ntpd_t)
 allow ntpd_t ntp_port_t:udp_socket name_bind;
+allow sysadm_t ntp_port_t:udp_socket name_bind;
 allow ntpd_t self:unix_dgram_socket create_socket_perms;
 allow ntpd_t self:unix_stream_socket create_socket_perms;
 allow ntpd_t self:netlink_route_socket r_netlink_socket_perms;
@@ -85,4 +85,5 @@
 allow ntpd_t winbind_var_run_t:dir r_dir_perms;
 allow ntpd_t winbind_var_run_t:sock_file rw_file_perms;
 ')
-allow sysadm_t ntp_port_t:udp_socket name_bind;
+# For clock devices like wwvb1
+allow ntpd_t device_t:lnk_file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/portmap.te policy-1.23.13/domains/program/unused/portmap.te
--- nsapolicy/domains/program/unused/portmap.te	2005-04-27 10:28:52.000000000 -0400
+++ policy-1.23.13/domains/program/unused/portmap.te	2005-04-25 15:18:00.000000000 -0400
@@ -58,13 +58,14 @@
 domain_auto_trans(initrc_t, portmap_helper_exec_t, portmap_helper_t)
 dontaudit portmap_helper_t self:capability { net_admin };
 allow portmap_helper_t self:capability { net_bind_service };
-allow portmap_helper_t { var_run_t initrc_var_run_t } :file rw_file_perms;
+allow portmap_helper_t initrc_var_run_t:file rw_file_perms;
+file_type_auto_trans(portmap_helper_t, var_run_t, portmap_var_run_t, file)
 allow portmap_helper_t self:netlink_route_socket r_netlink_socket_perms;
 can_network(portmap_helper_t)
 allow portmap_helper_t port_type:tcp_socket name_connect;
 can_ypbind(portmap_helper_t)
 dontaudit portmap_helper_t admin_tty_type:chr_file rw_file_perms;
 allow portmap_helper_t etc_t:file { getattr read };
-dontaudit portmap_helper_t userdomain:fd use;
+dontaudit portmap_helper_t { userdomain privfd }:fd use;
 allow portmap_helper_t reserved_port_t:{ tcp_socket udp_socket } name_bind;
 dontaudit portmap_helper_t reserved_port_type:{ tcp_socket udp_socket } name_bind;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/samba.te policy-1.23.13/domains/program/unused/samba.te
--- nsapolicy/domains/program/unused/samba.te	2005-04-27 10:28:52.000000000 -0400
+++ policy-1.23.13/domains/program/unused/samba.te	2005-04-25 15:18:58.000000000 -0400
@@ -133,6 +133,7 @@
 # Access samba config
 allow smbmount_t samba_etc_t:file r_file_perms;
 allow smbmount_t samba_etc_t:dir r_dir_perms;
+allow initrc_t samba_etc_t:file rw_file_perms;
 
 # Write samba log
 allow smbmount_t samba_log_t:file create_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/snmpd.te policy-1.23.13/domains/program/unused/snmpd.te
--- nsapolicy/domains/program/unused/snmpd.te	2005-04-27 10:28:53.000000000 -0400
+++ policy-1.23.13/domains/program/unused/snmpd.te	2005-04-26 15:34:21.000000000 -0400
@@ -37,7 +37,7 @@
 allow snmpd_t self:unix_stream_socket create_socket_perms;
 allow snmpd_t etc_t:lnk_file read;
 allow snmpd_t { etc_t etc_runtime_t }:file r_file_perms;
-allow snmpd_t urandom_device_t:chr_file read;
+allow snmpd_t { random_device_t urandom_device_t }:chr_file { getattr read };
 allow snmpd_t self:capability { dac_override kill net_bind_service net_admin sys_nice sys_tty_config };
 
 allow snmpd_t proc_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/squid.te policy-1.23.13/domains/program/unused/squid.te
--- nsapolicy/domains/program/unused/squid.te	2005-04-27 10:28:53.000000000 -0400
+++ policy-1.23.13/domains/program/unused/squid.te	2005-04-25 15:18:00.000000000 -0400
@@ -55,9 +55,7 @@
 can_network(squid_t)
 if (squid_connect_any) {
 allow squid_t port_type:tcp_socket name_connect;
-} else {
-allow squid_t { http_port_t http_cache_port_t }:tcp_socket name_connect;
-}
+} 
 can_ypbind(squid_t)
 can_tcp_connect(web_client_domain, squid_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/tinydns.te policy-1.23.13/domains/program/unused/tinydns.te
--- nsapolicy/domains/program/unused/tinydns.te	2005-04-27 10:28:53.000000000 -0400
+++ policy-1.23.13/domains/program/unused/tinydns.te	2005-04-25 15:18:00.000000000 -0400
@@ -36,7 +36,7 @@
 can_udp_send(domain, tinydns_t)
 can_udp_send(tinydns_t, domain)
 # tinydns itself doesn't do zone transfers
-# so we don't need to have it tcp_connect
+# so we do not need to have it tcp_connect
 
 #read configuration files
 r_dir_file(tinydns_t, tinydns_conf_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.23.13/domains/program/unused/udev.te
--- nsapolicy/domains/program/unused/udev.te	2005-04-27 10:28:53.000000000 -0400
+++ policy-1.23.13/domains/program/unused/udev.te	2005-04-25 21:41:17.000000000 -0400
@@ -33,7 +33,7 @@
 allow udev_t self:unix_stream_socket {connectto create_stream_socket_perms};
 allow udev_t self:unix_dgram_socket create_socket_perms;
 allow udev_t self:fifo_file rw_file_perms;
-allow udev_t device_t:file rw_file_perms;
+allow udev_t device_t:file { unlink rw_file_perms };
 allow udev_t device_t:sock_file create_file_perms;
 allow udev_t device_t:lnk_file create_lnk_perms;
 allow udev_t { device_t device_type }:{ chr_file blk_file } { relabelfrom relabelto create_file_perms };
@@ -76,7 +76,6 @@
 allow udev_t initrc_var_run_t:file r_file_perms;
 dontaudit udev_t initrc_var_run_t:file write;
 
-domain_auto_trans(initrc_t, udev_exec_t, udev_t)
 domain_auto_trans(kernel_t, udev_exec_t, udev_t)
 domain_auto_trans(udev_t, restorecon_exec_t, restorecon_t)
 ifdef(`hide_broken_symptoms', `
@@ -87,7 +86,6 @@
 ifdef(`xdm.te', `
 allow udev_t xdm_var_run_t:file { getattr read };
 ')
-dontaudit udev_t staff_home_dir_t:dir search;
 
 ifdef(`hotplug.te', `
 r_dir_file(udev_t, hotplug_etc_t)
@@ -140,3 +138,7 @@
 ')
 r_dir_file(udev_t, domain)
 allow udev_t modules_dep_t:file r_file_perms;
+
+ifdef(`unlimitedUtils', `
+unconfined_domain(udev_t) 
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/webalizer.te policy-1.23.13/domains/program/unused/webalizer.te
--- nsapolicy/domains/program/unused/webalizer.te	2005-04-27 10:28:54.000000000 -0400
+++ policy-1.23.13/domains/program/unused/webalizer.te	2005-04-25 15:18:00.000000000 -0400
@@ -4,7 +4,7 @@
 #
 # Depends: apache.te
 
-application_domain(webalizer)
+application_domain(webalizer, `, nscd_client_domain')
 # to use from cron
 system_crond_entry(webalizer_exec_t,webalizer_t)
 role system_r types webalizer_t;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/user.te policy-1.23.13/domains/user.te
--- nsapolicy/domains/user.te	2005-04-27 10:28:48.000000000 -0400
+++ policy-1.23.13/domains/user.te	2005-04-25 15:18:00.000000000 -0400
@@ -132,3 +132,10 @@
 # "ps aux" and "ls -l /dev/pts" make too much noise without this
 dontaudit unpriv_userdomain ptyfile:chr_file getattr;
 
+# to allow w to display everyone...
+bool user_ttyfile_stat false;
+
+if (user_ttyfile_stat) {
+allow userdomain ttyfile:chr_file getattr;
+}
+
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/distros.fc policy-1.23.13/file_contexts/distros.fc
--- nsapolicy/file_contexts/distros.fc	2005-04-20 15:40:35.000000000 -0400
+++ policy-1.23.13/file_contexts/distros.fc	2005-04-25 15:18:00.000000000 -0400
@@ -37,6 +37,7 @@
 /usr/share/texmf/web2c/mktexupd	--	system_u:object_r:bin_t
 /usr/share/ssl/certs(/.*)?		system_u:object_r:cert_t
 /usr/share/ssl/private(/.*)?		system_u:object_r:cert_t
+/etc/pki(/.*)?		system_u:object_r:cert_t
 /usr/share/ssl/misc(/.*)?		system_u:object_r:bin_t
 #
 # /emul/ia32-linux/usr
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/apache.fc policy-1.23.13/file_contexts/program/apache.fc
--- nsapolicy/file_contexts/program/apache.fc	2005-04-20 15:40:35.000000000 -0400
+++ policy-1.23.13/file_contexts/program/apache.fc	2005-04-26 11:39:32.000000000 -0400
@@ -47,3 +47,6 @@
 /var/lib/htdig(/.*)?		system_u:object_r:httpd_sys_content_t
 /etc/htdig(/.*)?		system_u:object_r:httpd_sys_content_t
 /var/spool/gosa(/.*)?		system_u:object_r:httpd_sys_script_rw_t
+ifdef(`targeted_policy', `', `
+/var/spool/cron/apache		-- 	system_u:object_r:user_cron_spool_t
+')
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/compat.fc policy-1.23.13/file_contexts/program/compat.fc
--- nsapolicy/file_contexts/program/compat.fc	2005-04-20 08:58:41.000000000 -0400
+++ policy-1.23.13/file_contexts/program/compat.fc	2005-04-27 17:13:39.000000000 -0400
@@ -1,19 +1,23 @@
+ifdef(`setfiles.te', `', `
 # setfiles
 /usr/sbin/setfiles.*	--	system_u:object_r:setfiles_exec_t
+')
 
+ifdef(`mount.te', `', `
 # mount
 /bin/mount.*			--	system_u:object_r:mount_exec_t
 /bin/umount.*			--	system_u:object_r:mount_exec_t
-# restorecon
-/sbin/restorecon	--	system_u:object_r:restorecon_exec_t
-/bin/hostname		--	system_u:object_r:hostname_exec_t
-# consoletype
-/sbin/consoletype	--	system_u:object_r:consoletype_exec_t
+')
+ifdef(`loadkeys.te', `', `
 # loadkeys
 /bin/unikeys		--	system_u:object_r:loadkeys_exec_t
 /bin/loadkeys		--	system_u:object_r:loadkeys_exec_t
+')
+ifdef(`dmesg.te', `', `
 # dmesg
 /bin/dmesg	--	system_u:object_r:dmesg_exec_t
+')
+ifdef(`fsadm.te', `', `
 # fs admin utilities
 /sbin/fsck.*		--	system_u:object_r:fsadm_exec_t
 /sbin/mkfs.*		--	system_u:object_r:fsadm_exec_t
@@ -50,6 +54,9 @@
 /sbin/partx		--	system_u:object_r:fsadm_exec_t
 /usr/bin/partition_uuid	--	system_u:object_r:fsadm_exec_t
 /sbin/partprobe		--	system_u:object_r:fsadm_exec_t
+')
+ifdef(`kudzu.te', `', `
 # kudzu
 /usr/sbin/kudzu	--	system_u:object_r:kudzu_exec_t
 /sbin/kmodule	--	system_u:object_r:kudzu_exec_t
+')
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/crack.fc policy-1.23.13/file_contexts/program/crack.fc
--- nsapolicy/file_contexts/program/crack.fc	2005-04-20 15:40:35.000000000 -0400
+++ policy-1.23.13/file_contexts/program/crack.fc	2005-04-26 10:25:01.000000000 -0400
@@ -1,4 +1,5 @@
 # crack - for password checking
+/usr/sbin/cracklib-[a-z]*	--	system_u:object_r:crack_exec_t
 /usr/sbin/crack_[a-z]*	--	system_u:object_r:crack_exec_t
 /var/cache/cracklib(/.*)?	system_u:object_r:crack_db_t
 /usr/lib(64)?/cracklib_dict.* --	system_u:object_r:crack_db_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/getty.fc policy-1.23.13/file_contexts/program/getty.fc
--- nsapolicy/file_contexts/program/getty.fc	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.13/file_contexts/program/getty.fc	2005-04-25 15:18:00.000000000 -0400
@@ -1,3 +1,5 @@
 # getty
 /sbin/.*getty		--	system_u:object_r:getty_exec_t
 /etc/mgetty(/.*)?		system_u:object_r:getty_etc_t
+/var/run/mgetty\.pid.*	--	system_u:object_r:getty_var_run_t
+/var/log/mgetty\.log.*	--	system_u:object_r:getty_log_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/i18n_input.fc policy-1.23.13/file_contexts/program/i18n_input.fc
--- nsapolicy/file_contexts/program/i18n_input.fc	2005-04-25 14:48:59.000000000 -0400
+++ policy-1.23.13/file_contexts/program/i18n_input.fc	2005-04-27 10:30:39.000000000 -0400
@@ -4,5 +4,8 @@
 /usr/bin/iiimd		        --     system_u:object_r:i18n_input_exec_t
 /usr/bin/httx                   --     system_u:object_r:i18n_input_exec_t
 /usr/bin/htt_xbe                --     system_u:object_r:i18n_input_exec_t
+/usr/bin/iiimx                  --     system_u:object_r:i18n_input_exec_t
+/usr/lib/iiim/iiim-xbe          --     system_u:object_r:i18n_input_exec_t
 /usr/lib(64)?/im/.*\.so.*       --     system_u:object_r:shlib_t
+/usr/lib(64)?/iiim/.*\.so.*     --     system_u:object_r:shlib_t
 /var/run/iiim(/.*)?		       system_u:object_r:i18n_input_var_run_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/lvm.fc policy-1.23.13/file_contexts/program/lvm.fc
--- nsapolicy/file_contexts/program/lvm.fc	2005-04-20 15:40:35.000000000 -0400
+++ policy-1.23.13/file_contexts/program/lvm.fc	2005-04-25 15:41:19.000000000 -0400
@@ -12,7 +12,6 @@
 /etc/lvm/lock(/.*)?		system_u:object_r:lvm_lock_t
 /var/lock/lvm(/.*)?		system_u:object_r:lvm_lock_t
 /dev/lvm		-c	system_u:object_r:fixed_disk_device_t
-/dev/mapper/.*		-b	system_u:object_r:fixed_disk_device_t
 /dev/mapper/control	-c	system_u:object_r:lvm_control_t
 /lib/lvm-10/.*		--	system_u:object_r:lvm_exec_t
 /lib/lvm-200/.*		--	system_u:object_r:lvm_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/portmap.fc policy-1.23.13/file_contexts/program/portmap.fc
--- nsapolicy/file_contexts/program/portmap.fc	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.13/file_contexts/program/portmap.fc	2005-04-25 15:18:00.000000000 -0400
@@ -7,3 +7,4 @@
 /usr/sbin/pmap_dump	--	system_u:object_r:portmap_helper_exec_t
 /usr/sbin/pmap_set	--	system_u:object_r:portmap_helper_exec_t
 ')
+/var/run/portmap.upgrade-state -- system_u:object_r:portmap_var_run_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/traceroute.fc policy-1.23.13/file_contexts/program/traceroute.fc
--- nsapolicy/file_contexts/program/traceroute.fc	2005-04-25 14:48:59.000000000 -0400
+++ policy-1.23.13/file_contexts/program/traceroute.fc	2005-04-25 15:18:00.000000000 -0400
@@ -2,7 +2,6 @@
 /bin/traceroute.*	--	system_u:object_r:traceroute_exec_t
 /bin/tracepath.*	--	system_u:object_r:traceroute_exec_t
 /sbin/rdisc		--	system_u:object_r:traceroute_exec_t
-/sbin/arping		--	system_u:object_r:traceroute_exec_t
 /usr/(s)?bin/traceroute.* --	system_u:object_r:traceroute_exec_t
 /usr/bin/lft		--	system_u:object_r:traceroute_exec_t
 /usr/bin/nmap		--	system_u:object_r:traceroute_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/webalizer.fc policy-1.23.13/file_contexts/program/webalizer.fc
--- nsapolicy/file_contexts/program/webalizer.fc	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.13/file_contexts/program/webalizer.fc	2005-04-25 15:18:00.000000000 -0400
@@ -1 +1,3 @@
 #
+/usr/bin/webalizer	--	system_u:object_r:webalizer_exec_t
+/var/lib/webalizer(/.*)		system_u:object_r:webalizer_var_lib_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.23.13/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2005-04-20 15:40:35.000000000 -0400
+++ policy-1.23.13/file_contexts/types.fc	2005-04-26 08:20:01.000000000 -0400
@@ -58,7 +58,7 @@
 
 #
 # Mount points; do not relabel subdirectories, since
-# we don't want to change any removable media by default.
+# we don not want to change any removable media by default.
 /mnt(/[^/]*)?		-d	system_u:object_r:mnt_t
 /mnt/[^/]*/.*			<<none>>
 /media(/[^/]*)?		-d	system_u:object_r:mnt_t
@@ -157,6 +157,7 @@
 /dev/i2o/hd[^/]*	-b	system_u:object_r:fixed_disk_device_t
 /dev/ubd[^/]*		-b	system_u:object_r:fixed_disk_device_t
 /dev/cciss/[^/]*	-b	system_u:object_r:fixed_disk_device_t
+/dev/mapper/.*		-b	system_u:object_r:fixed_disk_device_t
 /dev/ida/[^/]*	-b	system_u:object_r:fixed_disk_device_t
 /dev/dasd[^/]*	-b	system_u:object_r:fixed_disk_device_t
 /dev/flash[^/]*	-b	system_u:object_r:fixed_disk_device_t
@@ -461,6 +462,11 @@
 /usr/share/gnucash/finance-quote-helper -- system_u:object_r:bin_t
 
 #
+# Turboprint
+#
+/usr/share/turboprint/lib(/.*)? 	--     system_u:object_r:bin_t
+
+#
 # initrd mount point, only used during boot
 #
 /initrd			-d	system_u:object_r:root_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.23.13/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2005-04-27 10:28:54.000000000 -0400
+++ policy-1.23.13/macros/base_user_macros.te	2005-04-25 15:18:00.000000000 -0400
@@ -317,7 +317,7 @@
 allow $1_t devtty_t:chr_file rw_file_perms;
 allow $1_t null_device_t:chr_file rw_file_perms;
 allow $1_t zero_device_t:chr_file { rw_file_perms execute };
-allow $1_t { random_device_t urandom_device_t }:chr_file { getattr read ioctl };
+allow $1_t { random_device_t urandom_device_t }:chr_file ra_file_perms;
 #
 # Added to allow reading of cdrom
 #
diff --exclude-from=exclude -N -u -r nsapolicy/macros/core_macros.te policy-1.23.13/macros/core_macros.te
--- nsapolicy/macros/core_macros.te	2005-04-27 10:28:54.000000000 -0400
+++ policy-1.23.13/macros/core_macros.te	2005-04-25 15:18:00.000000000 -0400
@@ -361,6 +361,7 @@
 # Get the selinuxfs mount point via /proc/self/mounts.
 allow $1 proc_t:dir search;
 allow $1 proc_t:lnk_file read;
+allow $1 proc_t:file { getattr read };
 allow $1 self:dir search;
 allow $1 self:file { getattr read };
 # Access selinuxfs.
diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te policy-1.23.13/macros/global_macros.te
--- nsapolicy/macros/global_macros.te	2005-04-27 10:28:54.000000000 -0400
+++ policy-1.23.13/macros/global_macros.te	2005-04-25 15:18:00.000000000 -0400
@@ -406,8 +406,19 @@
 
 role system_r types $2_t;
 
+ifelse(index(`$3',`transitionbool'), -1, `
+
+domain_auto_trans($1, $2_exec_t, $2_t)
+
+', `
+
+bool $2_disable_trans false;
+
+if (! $2_disable_trans) {
 domain_auto_trans($1, $2_exec_t, $2_t)
+}
 
+');
 # Inherit and use descriptors from parent.
 allow $2_t $1:fd use;
 allow $2_t $1:process sigchld;
@@ -712,6 +723,7 @@
 if (allow_execmod) {
 # Allow text relocations on system shared libraries, e.g. libGL.
 allow $1 texrel_shlib_t:file execmod;
+allow $1 home_type:file execmod;
 }
 
 # Create/access any System V IPC objects.
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/cdrecord_macros.te policy-1.23.13/macros/program/cdrecord_macros.te
--- nsapolicy/macros/program/cdrecord_macros.te	2005-04-27 10:28:54.000000000 -0400
+++ policy-1.23.13/macros/program/cdrecord_macros.te	2005-04-25 15:18:00.000000000 -0400
@@ -40,7 +40,7 @@
 allow $1_cdrecord_t etc_t:file { getattr read };
 
 # allow searching for cdrom-drive
-allow $1_cdrecord_t device_t:dir { getattr search };
+allow $1_cdrecord_t device_t:dir r_dir_perms;
 allow $1_cdrecord_t device_t:lnk_file { getattr read };
 
 # allow cdrecord to write the CD
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.23.13/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2005-04-27 10:28:55.000000000 -0400
+++ policy-1.23.13/macros/program/mozilla_macros.te	2005-04-25 15:18:00.000000000 -0400
@@ -32,7 +32,7 @@
 file_browse_domain($1_mozilla_t)
 
 can_network_client($1_mozilla_t)
-allow $1_mozilla_t { ftp_port_t http_port_t }:tcp_socket name_connect;
+allow $1_mozilla_t ftp_port_t:tcp_socket name_connect;
 #allow $1_mozilla_t port_type:tcp_socket name_connect;
 
 uses_shlib($1_mozilla_t)
diff --exclude-from=exclude -N -u -r nsapolicy/man/man8/httpd_selinux.8 policy-1.23.13/man/man8/httpd_selinux.8
--- nsapolicy/man/man8/httpd_selinux.8	2005-04-07 22:22:56.000000000 -0400
+++ policy-1.23.13/man/man8/httpd_selinux.8	2005-04-25 15:18:00.000000000 -0400
@@ -90,6 +90,12 @@
 setsebool -P httpd_can_network_connect 1
 
 .TP
+You can disable suexec transition, set httpd_suexec_disable_trans deny this
+.br
+
+setsebool -P httpd_suexec_disable_trans 1
+
+.TP
 You can disable SELinux protection for the httpd daemon by executing:
 .br
 
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/appconfig/default_contexts policy-1.23.13/targeted/appconfig/default_contexts
--- nsapolicy/targeted/appconfig/default_contexts	2005-02-24 14:51:10.000000000 -0500
+++ policy-1.23.13/targeted/appconfig/default_contexts	2005-04-25 15:18:00.000000000 -0400
@@ -1,5 +1,6 @@
 system_r:unconfined_t	system_r:unconfined_t
 system_r:initrc_t	system_r:unconfined_t
+system_r:local_login_t system_r:unconfined_t
 system_r:remote_login_t system_r:unconfined_t
 system_r:rshd_t		system_r:unconfined_t
 system_r:crond_t	system_r:unconfined_t
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/program/compat.te policy-1.23.13/targeted/domains/program/compat.te
--- nsapolicy/targeted/domains/program/compat.te	2005-04-27 10:28:56.000000000 -0400
+++ policy-1.23.13/targeted/domains/program/compat.te	2005-04-26 11:45:35.000000000 -0400
@@ -1,8 +1,3 @@
-typealias sbin_t alias setfiles_exec_t;
 typealias bin_t alias mount_exec_t;
-typealias sbin_t alias restorecon_exec_t;
-typealias sbin_t alias consoletype_exec_t;
-typealias bin_t alias loadkeys_exec_t;
 typealias bin_t alias dmesg_exec_t;
-typealias sbin_t alias fsadm_exec_t;
-typealias sbin_t alias kudzu_exec_t;
+typealias bin_t alias loadkeys_exec_t;
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/program/crond.te policy-1.23.13/targeted/domains/program/crond.te
--- nsapolicy/targeted/domains/program/crond.te	2005-04-27 10:28:56.000000000 -0400
+++ policy-1.23.13/targeted/domains/program/crond.te	2005-04-26 08:38:04.000000000 -0400
@@ -18,7 +18,6 @@
 type system_cron_spool_t, file_type, sysadmfile;
 type sysadm_cron_spool_t, file_type, sysadmfile;
 type crond_log_t, file_type, sysadmfile;
-type crond_var_run_t, file_type, sysadmfile;
 role system_r types crond_t;
 domain_auto_trans(initrc_t, crond_exec_t, crond_t)
 domain_auto_trans(initrc_t, anacron_exec_t, crond_t)
@@ -30,3 +29,4 @@
 allow crond_t initrc_t:dbus send_msg;
 allow crond_t unconfined_t:dbus send_msg;
 allow crond_t unconfined_t:process transition;
+var_run_domain(crond)
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/program/hotplug.te policy-1.23.13/targeted/domains/program/hotplug.te
--- nsapolicy/targeted/domains/program/hotplug.te	2005-04-27 10:28:56.000000000 -0400
+++ policy-1.23.13/targeted/domains/program/hotplug.te	1969-12-31 19:00:00.000000000 -0500
@@ -1,17 +0,0 @@
-#DESC Hotplug - Hardware event manager
-#
-# Authors:  Daniel Walsh <dwalsh@redhat.com>
-#
-
-#################################
-#
-# Rules for the hotplug domain.
-#
-# hotplug_exec_t is the type of the /sbin/hotplug and other programs.
-# This domain is defined just for targeted policy to allow easy conversion to
-# strict policy.  
-#
-type hotplug_t, domain;
-type hotplug_exec_t, file_type, sysadmfile, exec_type;
-typealias var_run_t alias hotplug_var_run_t;
-typealias etc_t alias hotplug_etc_t;
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/program/sendmail.te policy-1.23.13/targeted/domains/program/sendmail.te
--- nsapolicy/targeted/domains/program/sendmail.te	2005-04-27 10:28:56.000000000 -0400
+++ policy-1.23.13/targeted/domains/program/sendmail.te	2005-04-25 16:05:32.000000000 -0400
@@ -12,6 +12,7 @@
 #
 type sendmail_exec_t, file_type, sysadmfile, exec_type;
 type sendmail_log_t, file_type, sysadmfile;
-type sendmail_var_run_t, file_type, sysadmfile;
 type etc_mail_t, file_type, sysadmfile;
 domain_auto_trans(initrc_t, sendmail_exec_t, sendmail_t)
+var_run_domain(sendmail)
+
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/program/udev.te policy-1.23.13/targeted/domains/program/udev.te
--- nsapolicy/targeted/domains/program/udev.te	2005-04-27 10:28:56.000000000 -0400
+++ policy-1.23.13/targeted/domains/program/udev.te	1969-12-31 19:00:00.000000000 -0500
@@ -1,17 +0,0 @@
-#DESC udev - Linux configurable dynamic device naming support
-#
-# Authors:  Daniel Walsh <dwalsh@redhat.com>
-#
-
-#################################
-#
-# Rules for the udev domain.
-#
-# udev_exec_t is the type of the /sbin/udev and other programs.
-# This domain is defined just for targeted policy to allow easy conversion to
-# strict policy.  
-#
-type udev_exec_t, file_type, sysadmfile, exec_type;
-type udev_helper_exec_t, file_type, sysadmfile, exec_type;
-type udev_tdb_t, file_type, sysadmfile, dev_fs;
-typealias udev_tdb_t alias udev_tbl_t;
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/program/xdm.te policy-1.23.13/targeted/domains/program/xdm.te
--- nsapolicy/targeted/domains/program/xdm.te	2005-04-27 10:28:56.000000000 -0400
+++ policy-1.23.13/targeted/domains/program/xdm.te	2005-04-25 15:18:00.000000000 -0400
@@ -20,3 +20,4 @@
 type xdm_var_lib_t, file_type, sysadmfile;
 type xdm_tmp_t, file_type, sysadmfile;
 domain_auto_trans(initrc_t, xdm_exec_t, xdm_t)
+domain_auto_trans(init_t, xdm_exec_t, xdm_t)
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/unconfined.te policy-1.23.13/targeted/domains/unconfined.te
--- nsapolicy/targeted/domains/unconfined.te	2005-04-27 10:28:56.000000000 -0400
+++ policy-1.23.13/targeted/domains/unconfined.te	2005-04-25 15:18:00.000000000 -0400
@@ -15,7 +15,7 @@
 # Define some type aliases to help with compatibility with
 # macros and domains from the "strict" policy.
 typealias bin_t alias su_exec_t;
-typealias unconfined_t alias { kernel_t logrotate_t sendmail_t sshd_t secadm_t sysadm_t rpm_t rpm_script_t xdm_t };
+typealias unconfined_t alias { logrotate_t sendmail_t sshd_t secadm_t sysadm_t rpm_t rpm_script_t xdm_t };
 typeattribute tty_device_t admin_tty_type;
 typeattribute devpts_t admin_tty_type;
 
@@ -42,6 +42,7 @@
 attribute sysadm_file_type;
 
 allow unconfined_t unlabeled_t:filesystem *;
+allow unconfined_t self:system syslog_read;
 allow unlabeled_t self:filesystem associate;
 
 # Support NFS home directories
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/initial_sid_contexts policy-1.23.13/targeted/initial_sid_contexts
--- nsapolicy/targeted/initial_sid_contexts	2005-02-24 14:51:10.000000000 -0500
+++ policy-1.23.13/targeted/initial_sid_contexts	1969-12-31 19:00:00.000000000 -0500
@@ -1,47 +0,0 @@
-# FLASK
-
-#
-# Define the security context for each initial SID
-# sid sidname   context
-
-# Initial state is unconfined in the relaxed policy.
-sid kernel	user_u:system_r:unconfined_t
-sid security	system_u:object_r:security_t
-sid unlabeled	system_u:object_r:unlabeled_t
-sid fs		system_u:object_r:fs_t
-sid file	system_u:object_r:file_t
-# Persistent label mapping is gone.  This initial SID can be removed.
-sid file_labels	system_u:object_r:unlabeled_t
-# init_t is still used, but an initial SID is no longer required.
-sid init	system_u:object_r:unlabeled_t
-# any_socket is no longer used.
-sid any_socket 	system_u:object_r:unlabeled_t
-sid port	system_u:object_r:port_t
-sid netif	system_u:object_r:netif_t
-# netmsg is no longer used.
-sid netmsg	system_u:object_r:unlabeled_t
-sid node	system_u:object_r:node_t
-# These sockets are now labeled with the kernel SID,
-# and do not require their own initial SIDs.
-sid igmp_packet system_u:object_r:unlabeled_t
-sid icmp_socket system_u:object_r:unlabeled_t
-sid tcp_socket  system_u:object_r:unlabeled_t
-# Most of the sysctl SIDs are now computed at runtime
-# from genfs_contexts, so the corresponding initial SIDs
-# are no longer required.
-sid sysctl_modprobe	system_u:object_r:unlabeled_t
-# But we still need the base sysctl initial SID as a default.
-sid sysctl	system_u:object_r:sysctl_t
-sid sysctl_fs	system_u:object_r:unlabeled_t
-sid sysctl_kernel	system_u:object_r:unlabeled_t
-sid sysctl_net	system_u:object_r:unlabeled_t
-sid sysctl_net_unix	system_u:object_r:unlabeled_t
-sid sysctl_vm	system_u:object_r:unlabeled_t
-sid sysctl_dev	system_u:object_r:unlabeled_t
-# No longer used, can be removed.
-sid kmod	system_u:object_r:unlabeled_t
-sid policy	system_u:object_r:unlabeled_t
-sid scmp_packet	system_u:object_r:unlabeled_t
-sid devnull	system_u:object_r:null_device_t
-
-# FLASK
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.23.13/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.13/tunables/distro.tun	2005-04-25 15:18:00.000000000 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.23.13/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2005-04-14 15:01:54.000000000 -0400
+++ policy-1.23.13/tunables/tunable.tun	2005-04-25 15:18:00.000000000 -0400
@@ -2,7 +2,7 @@
 dnl define(`user_can_mount')
 
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
 dnl define(`unlimitedUtils')
@@ -20,11 +20,11 @@
 
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
diff --exclude-from=exclude -N -u -r nsapolicy/types/network.te policy-1.23.13/types/network.te
--- nsapolicy/types/network.te	2005-04-27 10:28:56.000000000 -0400
+++ policy-1.23.13/types/network.te	2005-04-25 15:18:00.000000000 -0400
@@ -31,6 +31,7 @@
 type http_cache_port_t, port_type, reserved_port_type;
 type http_port_t, port_type, reserved_port_type;
 
+allow web_client_domain { http_cache_port_t http_port_t }:tcp_socket name_connect;
 ifdef(`cyrus.te', `define(`use_pop')')
 ifdef(`courier.te', `define(`use_pop')')
 ifdef(`perdition.te', `define(`use_pop')')

--------------030604060605010508080403--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

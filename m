Message-ID: <41F6A47E.9010407@redhat.com>
Date: Tue, 25 Jan 2005 14:56:46 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Updated policy
Content-Type: multipart/mixed;
 boundary="------------000705050509080106000606"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000705050509080106000606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Many changes to allow policy to support telnetd, rlogind and rshd.

allow mount_t binfmt_misc_fs_t:dir mounton;
Required to run wine.

Changes to allow setfiles/restorecon to read default_context_t 
(customizable files)

Fixes for postgresql.te

Elimination of gpg execmod change.  The gpg rpm was fixed in rawhide.

Fixes for targeted crond to run as unconfined and still have transitions 
work.



--------------000705050509080106000606
Content-Type: text/x-patch;
 name="policy-20050124.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-20050124.patch"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/admin.te policy-1.21.3/domains/admin.te
--- nsapolicy/domains/admin.te	2005-01-20 15:55:00.000000000 -0500
+++ policy-1.21.3/domains/admin.te	2005-01-25 08:53:09.000000000 -0500
@@ -7,7 +7,7 @@
 ifdef(`direct_sysadm_daemon', `, priv_system_role')
 ; dnl end of sysadm_t type declaration
 
-allow privhome home_root_t:dir search;
+allow privhome home_root_t:dir { getattr search };
 
 # system_r is authorized for sysadm_t for single-user mode.
 role system_r types sysadm_t; 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/login.te policy-1.21.3/domains/program/login.te
--- nsapolicy/domains/program/login.te	2005-01-24 12:08:36.000000000 -0500
+++ policy-1.21.3/domains/program/login.te	2005-01-25 08:53:09.000000000 -0500
@@ -130,6 +130,11 @@
 
 allow $1_login_t mouse_device_t:chr_file { getattr setattr };
 
+ifdef(`targeted_policy',`
+unconfined_domain($1_login_t)
+domain_auto_trans($1_login_t, shell_exec_t, unconfined_t)
+')
+
 ')dnl end login_domain macro
 #################################
 #
@@ -212,5 +217,18 @@
 # Relabel ptys created by rlogind.
 allow remote_login_t rlogind_devpts_t:chr_file { relabelfrom relabelto };
 ')
+
+# Use the pty created by telnetd.
+ifdef(`telnetd.te', `
+allow remote_login_t telnetd_devpts_t:chr_file { setattr rw_file_perms };
+
+# Relabel ptys created by telnetd.
+allow remote_login_t telnetd_devpts_t:chr_file { relabelfrom relabelto };
+')
+
 allow remote_login_t ptyfile:chr_file { getattr relabelfrom relabelto ioctl };
 allow remote_login_t fs_t:filesystem { getattr };
+
+# Allow remote login to resolve host names (passed in via the -h switch)
+can_resolve(remote_login_t)
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/mount.te policy-1.21.3/domains/program/mount.te
--- nsapolicy/domains/program/mount.te	2005-01-24 16:57:04.000000000 -0500
+++ policy-1.21.3/domains/program/mount.te	2005-01-25 08:53:09.000000000 -0500
@@ -49,6 +49,7 @@
 allow mount_t devpts_t:dir mounton;
 allow mount_t usbdevfs_t:dir mounton;
 allow mount_t sysfs_t:dir mounton;
+allow mount_t binfmt_misc_fs_t:dir mounton;
 allow mount_t nfs_t:dir mounton;
 allow mount_t nfs_t:dir search;
 # nfsv4 has a filesystem to mount for its userspace daemons
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/restorecon.te policy-1.21.3/domains/program/restorecon.te
--- nsapolicy/domains/program/restorecon.te	2005-01-20 15:55:01.000000000 -0500
+++ policy-1.21.3/domains/program/restorecon.te	2005-01-25 08:53:09.000000000 -0500
@@ -59,6 +59,5 @@
 allow restorecon_t kernel_t:fd use;
 allow restorecon_t kernel_t:fifo_file { read write };
 allow restorecon_t kernel_t:unix_dgram_socket { read write };
-r_dir_file(restorecon_t, selinux_config_t)
-r_dir_file(restorecon_t, file_context_t)
+r_dir_file(restorecon_t, { selinux_config_t file_context_t default_context_t } )
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/setfiles.te policy-1.21.3/domains/program/setfiles.te
--- nsapolicy/domains/program/setfiles.te	2005-01-20 15:55:02.000000000 -0500
+++ policy-1.21.3/domains/program/setfiles.te	2005-01-25 08:53:09.000000000 -0500
@@ -36,7 +36,7 @@
 # Get security policy decisions.
 can_getsecurity(setfiles_t)
 
-r_dir_file(setfiles_t, { policy_src_t policy_config_t file_context_t selinux_config_t })
+r_dir_file(setfiles_t, { policy_src_t policy_config_t file_context_t selinux_config_t default_context_t })
 
 allow setfiles_t file_type:dir r_dir_perms;
 allow setfiles_t { file_type unlabeled_t device_type }:dir_file_class_set { getattr relabelfrom };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postgresql.te policy-1.21.3/domains/program/unused/postgresql.te
--- nsapolicy/domains/program/unused/postgresql.te	2005-01-24 12:08:36.000000000 -0500
+++ policy-1.21.3/domains/program/unused/postgresql.te	2005-01-25 08:53:09.000000000 -0500
@@ -105,8 +105,8 @@
 allow postgresql_t devpts_t:dir search;
 
 allow postgresql_t { bin_t sbin_t }:dir search;
-allow postgresql_t { bin_t sbin_t }:lnk_file read;
-allow postgresql_t postgresql_exec_t:lnk_file read;
+allow postgresql_t { bin_t sbin_t }:lnk_file { getattr read };
+allow postgresql_t postgresql_exec_t:lnk_file { getattr read };
 
 allow postgresql_t self:sem create_sem_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/samba.te policy-1.21.3/domains/program/unused/samba.te
--- nsapolicy/domains/program/unused/samba.te	2005-01-24 16:57:05.000000000 -0500
+++ policy-1.21.3/domains/program/unused/samba.te	2005-01-25 08:53:09.000000000 -0500
@@ -120,10 +120,3 @@
 # Support Samba sharing of home directories
 bool samba_enable_home_dirs false;
 
-if ( samba_enable_home_dirs ) {
-allow smbd_t home_root_t:dir { getattr search };
-allow smbd_t home_dir_type:dir { getattr search };
-allow smbd_t home_type:dir create_dir_perms;
-dontaudit smbd_t home_type:{ sock_file fifo_file chr_file blk_file } r_file_perms;
-}
-
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/distros.fc policy-1.21.3/file_contexts/distros.fc
--- nsapolicy/file_contexts/distros.fc	2005-01-20 15:55:14.000000000 -0500
+++ policy-1.21.3/file_contexts/distros.fc	2005-01-25 08:53:09.000000000 -0500
@@ -10,6 +10,7 @@
 /usr/share/system-config-httpd/system-config-httpd -- system_u:object_r:bin_t
 /usr/share/system-config-services/system-config-services -- system_u:object_r:bin_t
 /usr/share/system-logviewer/system-logviewer\.py -- system_u:object_r:bin_t
+/usr/share/system-config-lvm/system-config-lvm.py -- system_u:object_r:bin_t
 /usr/share/system-config-date/system-config-date\.py -- system_u:object_r:bin_t
 /usr/share/system-config-display/system-config-display -- system_u:object_r:bin_t
 /usr/share/system-config-keyboard/system-config-keyboard -- system_u:object_r:bin_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/udev.fc policy-1.21.3/file_contexts/program/udev.fc
--- nsapolicy/file_contexts/program/udev.fc	2005-01-20 15:55:20.000000000 -0500
+++ policy-1.21.3/file_contexts/program/udev.fc	2005-01-25 08:53:09.000000000 -0500
@@ -8,5 +8,5 @@
 /etc/udev/scripts/.+	-- system_u:object_r:udev_helper_exec_t
 /etc/hotplug\.d/default/udev.* -- system_u:object_r:udev_helper_exec_t
 /dev/udev\.tbl	--	system_u:object_r:udev_tbl_t
-/dev/\.udev\.tdb	--	system_u:object_r:udev_tdb_t
+/dev/\.udev\.tdb(/.*)?	--	system_u:object_r:udev_tdb_t
 /sbin/wait_for_sysfs -- system_u:object_r:udev_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gpg_macros.te policy-1.21.3/macros/program/gpg_macros.te
--- nsapolicy/macros/program/gpg_macros.te	2005-01-24 16:57:05.000000000 -0500
+++ policy-1.21.3/macros/program/gpg_macros.te	2005-01-25 08:54:05.000000000 -0500
@@ -23,10 +23,7 @@
 
 # Transition from the user domain to the derived domain.
 domain_auto_trans($1_t, gpg_exec_t, $1_gpg_t)
-#
-# Is this Ok?
-# 
-allow $1_gpg_t gpg_exec_t:file execmod;
+
 can_network($1_gpg_t)
 can_ypbind($1_gpg_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.21.3/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2005-01-24 12:08:37.000000000 -0500
+++ policy-1.21.3/macros/program/mozilla_macros.te	2005-01-25 08:53:09.000000000 -0500
@@ -25,7 +25,7 @@
 allow $1_mozilla_t $1_t:process signull;
 
 # Set resource limits and scheduling info.
-allow $1_mozilla_t self:process { setrlimit setsched };
+allow $1_mozilla_t self:process { execmem setrlimit setsched };
 
 allow $1_mozilla_t usr_t:{ lnk_file file } { getattr read };
 allow $1_mozilla_t var_lib_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/x_client_macros.te policy-1.21.3/macros/program/x_client_macros.te
--- nsapolicy/macros/program/x_client_macros.te	2005-01-20 15:55:26.000000000 -0500
+++ policy-1.21.3/macros/program/x_client_macros.te	2005-01-25 08:53:09.000000000 -0500
@@ -144,6 +144,7 @@
 ')
 
 # Access the terminal.
+allow $1_$2_t devpts_t:dir search;
 allow $1_$2_t $1_tty_device_t:chr_file rw_file_perms;
 allow $1_$2_t $1_devpts_t:chr_file rw_file_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/program/crond.te policy-1.21.3/targeted/domains/program/crond.te
--- nsapolicy/targeted/domains/program/crond.te	2005-01-24 16:57:06.000000000 -0500
+++ policy-1.21.3/targeted/domains/program/crond.te	2005-01-25 13:54:41.000000000 -0500
@@ -19,5 +19,10 @@
 type sysadm_cron_spool_t, file_type, sysadmfile;
 type crond_log_t, file_type, sysadmfile;
 type crond_var_run_t, file_type, sysadmfile;
-domain_auto_trans(initrc_t, crond_exec_t, crond_t)
-domain_auto_trans(initrc_t, anacron_exec_t, crond_t)
+domain_auto_trans(initrc_t, crond_exec_t, system_crond_t)
+domain_auto_trans(initrc_t, anacron_exec_t, system_crond_t)
+unconfined_domain(system_crond_t)
+# Access log files
+file_type_auto_trans(system_crond_t, var_log_t, crond_log_t, file)
+file_type_auto_trans(system_crond_t, user_home_dir_t, user_home_t)
+file_type_auto_trans(system_crond_t, tmp_t, system_crond_tmp_t)
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/unconfined.te policy-1.21.3/targeted/domains/unconfined.te
--- nsapolicy/targeted/domains/unconfined.te	2005-01-24 16:57:06.000000000 -0500
+++ policy-1.21.3/targeted/domains/unconfined.te	2005-01-25 08:53:09.000000000 -0500
@@ -4,7 +4,7 @@
 # is not explicitly confined.  It has no restrictions.
 # It needs to be carefully protected from the confined domains.
 
-type unconfined_t, domain, privuser, privrole, privowner, admin, auth_write, fs_domain, privmem;
+type unconfined_t, domain, privuser, privhome, privrole, privowner, admin, auth_write, fs_domain, privmem;
 role system_r types unconfined_t;
 role user_r types unconfined_t;
 role sysadm_r types unconfined_t;
@@ -23,7 +23,8 @@
 type user_home_t, file_type, sysadmfile, home_type;
 type user_home_dir_t, file_type, sysadmfile, home_dir_type;
 file_type_auto_trans(unconfined_t, home_root_t, user_home_dir_t, dir)
-file_type_auto_trans(unconfined_t, user_home_dir_t, user_home_t)
+allow privhome home_root_t:dir { getattr search };
+file_type_auto_trans(privhome, user_home_dir_t, user_home_t)
 
 define(`user_typealias', `
 ifelse($1,`user',`',`
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.21.3/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-08-20 13:57:29.000000000 -0400
+++ policy-1.21.3/tunables/distro.tun	2005-01-25 08:53:09.000000000 -0500
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.21.3/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2005-01-20 15:55:28.000000000 -0500
+++ policy-1.21.3/tunables/tunable.tun	2005-01-25 08:53:09.000000000 -0500
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

--------------000705050509080106000606--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4JK44gA017382
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 16:04:04 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4JK09xP029090
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 20:00:09 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id j4JK17xS030274
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 16:01:07 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1/Submit) id j4JK17VX030273
	for selinux@tycho.nsa.gov; Thu, 19 May 2005 16:01:07 -0400
Message-ID: <428CE032.8040501@redhat.com>
Date: Thu, 19 May 2005 14:51:30 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>, Jim Carter <jwcart2@epoch.ncsc.mil>
Subject: Latest Diff
Content-Type: multipart/mixed;
 boundary="------------020007090500020309050608"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020007090500020309050608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added attribute privkmsg for all domains that need to read kernel messages.

Added secadmfile for all files that only the secadm_r can deal with.

Added From Ivan:
        mount_point attribute to indicate files/directories that can be 
mounted on.
        read_fonts
        fontconfig
        getattr patches
        gift patches



Added several fixes from Russell
        Procmail, setfiles from initrc,
        lost+found changes

Changed a bunch of ":file read" -> ":file {getattr read }"

Don't transition to depmod from uncofined_t for targeted

ssh needs to be able to append to faillog, Needs to check shells in /sbin

Remove use_syslogng boolean.

Multiple fixes to amanda.

Fixes to anaconda domain so it will run in targeted policy

Allow httpd_suexec_t to run on homedirs.

Allow acpid to write to /proc/power

Fixes to automout domain

Move ipp_port_t into common area so other domains can work with it.

Rearrange cups.te ifdef(`hald.te', `  ...

Add ddcprobe.te

Fix move of cert file to /etc/pki and fix ability for certain domains to 
read cert files.

Fix ftpd.te (Needed ability to rw home dirs and auth_control capability)

Remove some "user_" domain stuff that leaked into domains/program tree.

Hal needs more privs.

Hotplug needs more privs

Many fixes for lvm.te to make lvm work.  Also added clvmd domain.

Allow mysql to setsched

Fixes for gssd domain (needs setuid and access to rpc_pipefs)

smb needs to communicate with cups.

Move

-file_type_auto_trans(sysadm_xauth_t, staff_home_dir_t, staff_home_xauth_t)

to

user.te

Handle creation of flag files in /  (poweroff, .autorelabel, .autofsck ...)
 
Change
+/etc/sysconfig/network-scripts/ifcfg-.+ -- system_u:object_r:net_conf_t

So that NetworkManager can rewrite them.

Fixes for bluetooth

Got a little more liberal with definitions of shlib_t under /usr/lib, 
/opt and /usr/local

Fix some of the man pages

Allow snmpd to read /proc/XXX/cmdline




































-- 



--------------020007090500020309050608
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/assert.te policy-1.23.16/assert.te
--- nsapolicy/assert.te	2005-04-27 10:28:48.000000000 -0400
+++ policy-1.23.16/assert.te	2005-05-18 15:50:12.000000000 -0400
@@ -75,13 +75,7 @@
 #
 # Verify that /proc/kmsg is only accessible to klogd.
 #
-ifdef(`klogd.te', `
-neverallow {domain -klogd_t -unrestricted } proc_kmsg_t:file ~stat_file_perms;
-', `
-ifdef(`syslogd.te', `
-neverallow {domain -syslogd_t -unrestricted } proc_kmsg_t:file ~stat_file_perms;
-')dnl end if syslogd
-')dnl end if klogd
+neverallow {domain -privkmsg -unrestricted } proc_kmsg_t:file ~stat_file_perms;
 
 #
 # Verify that /proc/kcore is inaccessible.
diff --exclude-from=exclude -N -u -r nsapolicy/attrib.te policy-1.23.16/attrib.te
--- nsapolicy/attrib.te	2005-05-07 00:41:08.000000000 -0400
+++ policy-1.23.16/attrib.te	2005-05-18 15:50:12.000000000 -0400
@@ -121,6 +121,13 @@
 # tagged with this attribute.
 attribute privmem;
 
+# The privkmsg attribute identifies every domain that can 
+# read kernel messages (/proc/kmsg)
+# This attribute is used in the TE assertions to verify
+# that such access is limited to domains that are explicitly
+# tagged with this attribute.
+attribute privkmsg;
+
 # The privfd attribute identifies every domain that should have
 # file handles inherited widely (IE sshd_t and getty_t).
 attribute privfd;
@@ -258,6 +265,11 @@
 # in TE rules to grant such access for administrator domains.
 attribute sysadmfile;
 
+# The secadmfile attribute identifies all types assigned to files 
+# that should be only accessible to security administrators.  It is used
+# in TE rules to grant such access for security administrator domains.
+attribute secadmfile;
+
 # The fs_type attribute identifies all types assigned to filesystems
 # (not limited to persistent filesystems).
 # It is used in TE rules to permit certain domains to mount
@@ -265,6 +277,12 @@
 # overall filesystem statistics.
 attribute fs_type;
 
+# The mount_point attribute identifies all types that can serve
+# as a mount point (for the mount binary). It is used in the mount 
+# policy to grant mounton permission, and in other domains to grant 
+# getattr permission over all the mount points.
+attribute mount_point;
+
 # The exec_type attribute identifies all types assigned
 # to entrypoint executables for domains.  This attribute is 
 # used in TE rules and assertions that should be applied to all 
diff --exclude-from=exclude -N -u -r nsapolicy/constraints policy-1.23.16/constraints
--- nsapolicy/constraints	2005-02-24 14:51:10.000000000 -0500
+++ policy-1.23.16/constraints	2005-05-18 15:50:12.000000000 -0400
@@ -61,6 +61,10 @@
 ')
 ifdef(`userhelper.te', 
 	`or (t1 == userhelperdomain)')
+ifdef(`postfix.te', `
+ifdef(`direct_sysadm_daemon',
+	`or (t1 == sysadm_mail_t and t2 == system_mail_t and r2 == system_r )')
+')
 	 or (t1 == priv_system_role and r2 == system_r )
         );
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/crond.te policy-1.23.16/domains/program/crond.te
--- nsapolicy/domains/program/crond.te	2005-04-27 10:28:48.000000000 -0400
+++ policy-1.23.16/domains/program/crond.te	2005-05-18 15:50:12.000000000 -0400
@@ -37,7 +37,7 @@
 
 # read files in /etc
 allow system_crond_t etc_t:file r_file_perms;
-allow system_crond_t etc_runtime_t:file read;
+allow system_crond_t etc_runtime_t:file { getattr read };
 
 allow system_crond_t { sysfs_t rpc_pipefs_t }:dir getattr;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/fsadm.te policy-1.23.16/domains/program/fsadm.te
--- nsapolicy/domains/program/fsadm.te	2005-05-02 14:06:54.000000000 -0400
+++ policy-1.23.16/domains/program/fsadm.te	2005-05-18 15:50:12.000000000 -0400
@@ -29,6 +29,7 @@
 
 # for /dev/shm
 allow fsadm_t tmpfs_t:dir { getattr search };
+allow fsadm_t tmpfs_t:file { read write };
 
 base_file_read_access(fsadm_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te policy-1.23.16/domains/program/initrc.te
--- nsapolicy/domains/program/initrc.te	2005-05-16 11:28:11.000000000 -0400
+++ policy-1.23.16/domains/program/initrc.te	2005-05-18 15:50:12.000000000 -0400
@@ -131,7 +131,7 @@
 # Update /var/log/wtmp and /var/log/dmesg.
 allow initrc_t wtmp_t:file { setattr rw_file_perms };
 allow initrc_t var_log_t:dir rw_dir_perms;
-allow initrc_t var_log_t:file { setattr rw_file_perms };
+allow initrc_t var_log_t:file create_file_perms;
 allow initrc_t lastlog_t:file { setattr rw_file_perms };
 allow initrc_t logfile:file { read append };
 
@@ -153,9 +153,6 @@
 # Kill all processes.
 allow initrc_t domain:process signal_perms;
 
-# Read and unlink /var/run/*.pid files.
-allow initrc_t pidfile:file { getattr read unlink };
-
 # Write to /dev/urandom.
 allow initrc_t { random_device_t urandom_device_t }:chr_file rw_file_perms;
 
@@ -229,9 +226,13 @@
 allow initrc_t { home_root_t home_type }:dir r_dir_perms;
 allow initrc_t home_type:file r_file_perms;
 
+# Read and unlink /var/run/*.pid files.
+allow initrc_t pidfile:file { getattr read unlink };
+
 # for system start scripts
 allow initrc_t pidfile:dir { rmdir rw_dir_perms };
 allow initrc_t pidfile:sock_file unlink;
+
 rw_dir_create_file(initrc_t, var_lib_t)
 
 # allow start scripts to clean /tmp
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/init.te policy-1.23.16/domains/program/init.te
--- nsapolicy/domains/program/init.te	2005-05-02 14:06:54.000000000 -0400
+++ policy-1.23.16/domains/program/init.te	2005-05-19 09:58:14.000000000 -0400
@@ -142,6 +142,6 @@
 # file descriptors inherited from the rootfs.
 dontaudit init_t root_t:{ file chr_file } { read write }; 
 ifdef(`targeted_policy', `
-typeattribute init_t unrestricted;
+unconfined_domain(init_t)
 ')
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/klogd.te policy-1.23.16/domains/program/klogd.te
--- nsapolicy/domains/program/klogd.te	2005-05-02 14:06:54.000000000 -0400
+++ policy-1.23.16/domains/program/klogd.te	2005-05-18 15:50:12.000000000 -0400
@@ -8,7 +8,7 @@
 #
 # Rules for the klogd_t domain.
 #
-daemon_domain(klogd, `, privmem')
+daemon_domain(klogd, `, privmem, privkmsg')
 
 tmp_domain(klogd)
 allow klogd_t proc_t:dir r_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ldconfig.te policy-1.23.16/domains/program/ldconfig.te
--- nsapolicy/domains/program/ldconfig.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.23.16/domains/program/ldconfig.te	2005-05-18 15:50:12.000000000 -0400
@@ -39,7 +39,7 @@
 ')
 
 allow ldconfig_t { var_t var_lib_t }:dir search;
-allow ldconfig_t proc_t:file read;
+allow ldconfig_t proc_t:file { getattr read };
 ifdef(`hide_broken_symptoms', `
 ifdef(`unconfined.te',`
 dontaudit ldconfig_t unconfined_t:tcp_socket { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/modutil.te policy-1.23.16/domains/program/modutil.te
--- nsapolicy/domains/program/modutil.te	2005-05-07 00:41:09.000000000 -0400
+++ policy-1.23.16/domains/program/modutil.te	2005-05-18 15:50:12.000000000 -0400
@@ -30,7 +30,9 @@
 domain_auto_trans(initrc_t, depmod_exec_t, depmod_t)
 allow depmod_t { bin_t sbin_t }:dir search;
 can_exec(depmod_t, depmod_exec_t)
+ifdef(`targeted_policy', `', `
 domain_auto_trans(sysadm_t, depmod_exec_t, depmod_t)
+')
 
 # Inherit and use descriptors from init and login programs.
 allow depmod_t { init_t privfd }:fd use;
@@ -115,6 +117,7 @@
 allow insmod_t { var_t var_log_t }:dir search;
 ifdef(`xserver.te', `
 allow insmod_t xserver_log_t:file getattr;
+allow insmod_t xserver_misc_device_t:chr_file { read write };
 ')
 rw_dir_create_file(insmod_t, var_log_ksyms_t)
 allow insmod_t { etc_t etc_runtime_t }:file { getattr read };
@@ -150,7 +153,7 @@
 allow insmod_t mtrr_device_t:file write;
 
 # Read /proc/sys/kernel/hotplug.
-allow insmod_t sysctl_hotplug_t:file read;
+allow insmod_t sysctl_hotplug_t:file { getattr read };
 
 allow insmod_t device_t:dir read;
 allow insmod_t devpts_t:dir { getattr search };
@@ -229,5 +232,3 @@
 
 tmp_domain(update_modules)
 ')dnl end IS_INITRD
-
-
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/mount.te policy-1.23.16/domains/program/mount.te
--- nsapolicy/domains/program/mount.te	2005-05-02 14:06:54.000000000 -0400
+++ policy-1.23.16/domains/program/mount.te	2005-05-18 15:50:12.000000000 -0400
@@ -37,29 +37,9 @@
 
 # Mount, remount and unmount file systems.
 allow mount_t fs_type:filesystem mount_fs_perms;
-allow mount_t default_t:dir mounton;
-allow mount_t file_t:dir mounton;
-allow mount_t usr_t:dir mounton;
-allow mount_t src_t:dir mounton;
-allow mount_t var_t:dir mounton;
-allow mount_t proc_t:dir mounton;
-allow mount_t root_t:dir mounton;
-allow mount_t home_root_t:dir mounton;
-allow mount_t tmp_t:dir mounton;
-allow mount_t mnt_t:dir mounton;
-allow mount_t devpts_t:dir mounton;
-allow mount_t usbdevfs_t:dir mounton;
-allow mount_t sysfs_t:dir mounton;
-allow mount_t nfs_t:dir mounton;
+allow mount_t mount_point:dir mounton;
 allow mount_t nfs_t:dir search;
-# nfsv4 has a filesystem to mount for its userspace daemons
-allow mount_t var_lib_nfs_t:dir mounton;
-
-# On some RedHat systems, /boot is a mount point
-allow mount_t boot_t:dir mounton;
-allow mount_t device_t:dir mounton;
-# mount binfmt_misc on /proc/sys/fs/binfmt_misc
-allow mount_t sysctl_t:dir { mounton search };
+allow mount_t sysctl_t:dir search;
 
 allow mount_t root_t:filesystem unmount;
 
@@ -99,11 +79,7 @@
 allow mount_t userdomain:fd use;
 can_exec(mount_t, { sbin_t bin_t })
 allow mount_t device_t:dir r_dir_perms;
-ifdef(`distro_redhat', `
 allow mount_t tmpfs_t:chr_file { read write };
-allow mount_t tmpfs_t:dir mounton;
-')
-
 
 # tries to read /init
 dontaudit mount_t root_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/passwd.te policy-1.23.16/domains/program/passwd.te
--- nsapolicy/domains/program/passwd.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.23.16/domains/program/passwd.te	2005-05-18 15:50:12.000000000 -0400
@@ -145,6 +145,7 @@
 
 # make sure that getcon succeeds
 allow passwd_t userdomain:dir search;
-allow passwd_t userdomain:file read;
+allow passwd_t userdomain:file { getattr read };
 allow passwd_t userdomain:process getattr;
 
+allow passwd_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/restorecon.te policy-1.23.16/domains/program/restorecon.te
--- nsapolicy/domains/program/restorecon.te	2005-05-07 00:41:09.000000000 -0400
+++ policy-1.23.16/domains/program/restorecon.te	2005-05-18 15:50:12.000000000 -0400
@@ -51,8 +51,8 @@
 allow restorecon_t fs_t:filesystem getattr;
 allow restorecon_t fs_type:dir r_dir_perms;
 
-allow restorecon_t etc_runtime_t:file read;
-allow restorecon_t etc_t:file read;
+allow restorecon_t etc_runtime_t:file { getattr read };
+allow restorecon_t etc_t:file { getattr read };
 allow restorecon_t proc_t:file { getattr read };
 dontaudit restorecon_t proc_t:lnk_file { getattr read };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/setfiles.te policy-1.23.16/domains/program/setfiles.te
--- nsapolicy/domains/program/setfiles.te	2005-05-16 11:28:11.000000000 -0400
+++ policy-1.23.16/domains/program/setfiles.te	2005-05-18 15:50:12.000000000 -0400
@@ -19,6 +19,9 @@
 role sysadm_r types setfiles_t;
 role secadm_r types setfiles_t;
 
+ifdef(`distro_redhat', `
+domain_auto_trans(initrc_t, setfiles_exec_t, setfiles_t)
+')
 allow setfiles_t initrc_devpts_t:chr_file { read write ioctl };
 allow setfiles_t { ttyfile ptyfile tty_device_t admin_tty_type devtty_t }:chr_file { read write ioctl };
 
@@ -26,9 +29,6 @@
 
 domain_auto_trans(secadmin, setfiles_exec_t, setfiles_t)
 allow setfiles_t { userdomain privfd initrc_t init_t }:fd use;
-ifdef(`distro_redhat', `
-domain_auto_trans(initrc_t, setfiles_exec_t, setfiles_t)
-')
 
 uses_shlib(setfiles_t)
 allow setfiles_t self:capability { dac_override dac_read_search fowner };
@@ -56,8 +56,8 @@
 
 read_locale(setfiles_t)
 
-allow setfiles_t etc_runtime_t:file read;
-allow setfiles_t etc_t:file read;
+allow setfiles_t etc_runtime_t:file { getattr read };
+allow setfiles_t etc_t:file { getattr read };
 allow setfiles_t proc_t:file { getattr read };
 dontaudit setfiles_t proc_t:lnk_file { getattr read };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ssh.te policy-1.23.16/domains/program/ssh.te
--- nsapolicy/domains/program/ssh.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.23.16/domains/program/ssh.te	2005-05-18 15:50:12.000000000 -0400
@@ -229,3 +229,5 @@
 allow ssh_keygen_t self:unix_stream_socket create_stream_socket_perms;
 allow ssh_keygen_t sysadm_tty_device_t:chr_file { read write };
 allow ssh_keygen_t urandom_device_t:chr_file { getattr read };
+allow sshd_t faillog_t:file { append getattr };
+allow sshd_t sbin_t:file getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/syslogd.te policy-1.23.16/domains/program/syslogd.te
--- nsapolicy/domains/program/syslogd.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.23.16/domains/program/syslogd.te	2005-05-18 15:50:12.000000000 -0400
@@ -14,9 +14,9 @@
 # by syslogd.
 #
 ifdef(`klogd.te', `
-daemon_domain(syslogd)
+daemon_domain(syslogd, `, privkmsg')
 ', `
-daemon_domain(syslogd, `, privmem')
+daemon_domain(syslogd, `, privmem, privkmsg')
 ')
 
 # can_network is for the UDP socket
@@ -95,16 +95,13 @@
 #
 dontaudit syslogd_t file_t:dir search;
 allow syslogd_t { tmpfs_t devpts_t }:dir search;
-dontaudit syslogd_t unlabeled_t:file read;
+dontaudit syslogd_t unlabeled_t:file { getattr read };
 dontaudit syslogd_t { userpty_type devpts_t }:chr_file getattr;
 allow syslogd_t self:netlink_route_socket r_netlink_socket_perms;
 ifdef(`targeted_policy', `
 allow syslogd_t var_run_t:fifo_file { ioctl read write };
 ')
 
-bool use_syslogng false;
-
-if (use_syslogng) {
 # Allow access to /proc/kmsg for syslog-ng
 allow syslogd_t proc_t:dir search;
 allow syslogd_t proc_kmsg_t:file { getattr read };
@@ -113,4 +110,3 @@
 allow syslogd_t var_log_t:dir { create setattr };
 allow syslogd_t syslogd_port_t:tcp_socket name_bind;
 allow syslogd_t rsh_port_t:tcp_socket name_connect;
-}
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/amanda.te policy-1.23.16/domains/program/unused/amanda.te
--- nsapolicy/domains/program/unused/amanda.te	2005-05-02 14:06:54.000000000 -0400
+++ policy-1.23.16/domains/program/unused/amanda.te	2005-05-18 15:50:12.000000000 -0400
@@ -303,11 +303,11 @@
 
 allow amanda_t file_type:dir {getattr read search };
 allow amanda_t file_type:{ lnk_file file chr_file blk_file } {getattr read };
-allow amanda_t fixed_disk_device_t:blk_file getattr;
+allow amanda_t device_type:{ blk_file chr_file } getattr;
 dontaudit amanda_t file_type:sock_file getattr;
 logdir_domain(amanda)
 
-dontaudit amanda_t autofs_t:dir { getattr read };
+dontaudit amanda_t autofs_t:dir { getattr read search };
 dontaudit amanda_t binfmt_misc_fs_t:dir getattr;
 dontaudit amanda_t nfs_t:dir { getattr read };
 dontaudit amanda_t proc_t:dir read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/amavis.te policy-1.23.16/domains/program/unused/amavis.te
--- nsapolicy/domains/program/unused/amavis.te	2005-05-07 00:41:09.000000000 -0400
+++ policy-1.23.16/domains/program/unused/amavis.te	2005-05-18 15:50:12.000000000 -0400
@@ -23,7 +23,7 @@
 daemon_domain(amavisd)
 tmp_domain(amavisd)
 
-allow initrc_t amavisd_etc_t:file read;
+allow initrc_t amavisd_etc_t:file { getattr read };
 allow initrc_t amavisd_lib_t:dir { search read write rmdir remove_name unlink };
 allow initrc_t amavisd_lib_t:file unlink;
 allow initrc_t amavisd_var_run_t:dir setattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/anaconda.te policy-1.23.16/domains/program/unused/anaconda.te
--- nsapolicy/domains/program/unused/anaconda.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.23.16/domains/program/unused/anaconda.te	2005-05-18 15:50:12.000000000 -0400
@@ -17,13 +17,17 @@
 role system_r types ldconfig_t;
 domain_auto_trans(anaconda_t, ldconfig_exec_t, ldconfig_t)
 
+ifdef(`su.te', `
 role system_r types sysadm_su_t;
 domain_auto_trans(anaconda_t, su_exec_t, sysadm_su_t)
+')
 
 # Run other rc scripts in the anaconda_t domain.
 domain_auto_trans(anaconda_t, initrc_exec_t, initrc_t)
 
+ifdef(`dmesg.te', `
 domain_auto_trans(anaconda_t, dmesg_exec_t, dmesg_t)
+')
 
 ifdef(`distro_redhat', `
 file_type_auto_trans(anaconda_t, boot_t, boot_runtime_t, file)
@@ -44,4 +48,6 @@
 role system_r types sysadm_ssh_agent_t;
 domain_auto_trans(anaconda_t, ssh_agent_exec_t, sysadm_ssh_agent_t)
 ')
+ifdef(`passwd.te', `
 domain_auto_trans(anaconda_t , admin_passwd_exec_t, sysadm_passwd_t)
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.23.16/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2005-05-02 14:06:54.000000000 -0400
+++ policy-1.23.16/domains/program/unused/apache.te	2005-05-19 07:29:44.000000000 -0400
@@ -54,15 +54,6 @@
 #
 type httpd_config_t, file_type, sysadmfile;
 
-append_logdir_domain(httpd)
-#can read /etc/httpd/logs
-allow httpd_t httpd_log_t:lnk_file read;
-
-# For /etc/init.d/apache2 reload
-can_tcp_connect(httpd_t, httpd_t)
-
-can_tcp_connect(web_client_domain, httpd_t)
-
 # httpd_modules_t is the type given to module files (libraries) 
 # that come with Apache /etc/httpd/modules and /usr/lib/apache
 #
@@ -75,7 +66,16 @@
 
 # httpd_exec_t is the type give to the httpd executable.
 #
-daemon_domain(httpd, `, privmail')
+daemon_domain(httpd, `, privmail, nscd_client_domain')
+
+append_logdir_domain(httpd)
+#can read /etc/httpd/logs
+allow httpd_t httpd_log_t:lnk_file read;
+
+# For /etc/init.d/apache2 reload
+can_tcp_connect(httpd_t, httpd_t)
+
+can_tcp_connect(web_client_domain, httpd_t)
 
 can_exec(httpd_t, httpd_exec_t)
 file_type_auto_trans(httpd_t, var_run_t, httpd_var_run_t, sock_file)
@@ -233,7 +233,8 @@
 allow httpd_t bin_t:dir search;
 allow httpd_t sbin_t:dir search;
 allow httpd_t httpd_log_t:dir remove_name;
-r_dir_file(httpd_t, fonts_t)
+
+read_fonts(httpd_t)
 
 allow httpd_t self:netlink_route_socket { bind create getattr nlmsg_read read write };
 
@@ -256,8 +257,7 @@
 typealias httpd_sys_script_exec_t alias httpd_user_script_exec_t;
 
 if (httpd_enable_homedirs) {
-allow httpd_sys_script_t user_home_dir_t:dir { getattr search };
-allow httpd_t user_home_dir_t:dir { getattr search };
+allow { httpd_t httpd_sys_script_t httpd_suexec_t } user_home_dir_t:dir { getattr search };
 }
 ') dnl targeted policy
 
@@ -323,7 +323,7 @@
 # own user ID
 #
 daemon_sub_domain(httpd_t, httpd_suexec, `, transitionbool')
-allow httpd_t httpd_suexec_exec_t:file read;
+allow httpd_t httpd_suexec_exec_t:file { getattr read };
 
 #########################################################
 # Permissions for running child processes and scripts
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apmd.te policy-1.23.16/domains/program/unused/apmd.te
--- nsapolicy/domains/program/unused/apmd.te	2005-05-07 00:41:09.000000000 -0400
+++ policy-1.23.16/domains/program/unused/apmd.te	2005-05-18 15:50:12.000000000 -0400
@@ -32,6 +32,8 @@
 allow apmd_t device_t:lnk_file read;
 allow apmd_t proc_t:file { getattr read };
 can_sysctl(apmd_t)
+allow apmd_t sysfs_t:file write;
+
 allow apmd_t self:unix_dgram_socket create_socket_perms;
 allow apmd_t self:unix_stream_socket create_stream_socket_perms;
 allow apmd_t self:fifo_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/auditd.te policy-1.23.16/domains/program/unused/auditd.te
--- nsapolicy/domains/program/unused/auditd.te	2005-05-07 00:41:09.000000000 -0400
+++ policy-1.23.16/domains/program/unused/auditd.te	2005-05-18 15:50:12.000000000 -0400
@@ -23,12 +23,10 @@
 rw_dir_create_file(auditd_t, auditd_log_t)
 
 can_exec(auditd_t, init_exec_t)
-
-can_exec(auditd_t, init_exec_t)
 allow auditd_t initctl_t:fifo_file write;
 
 type auditctl_t, domain, privlog;
-type auditctl_exec_t, file_type, sysadmfile;
+type auditctl_exec_t, file_type, exec_type, sysadmfile;
 uses_shlib(auditctl_t)
 allow auditctl_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay nlmsg_readpriv };
 allow auditctl_t self:capability { audit_write audit_control };
@@ -53,7 +51,11 @@
 dontaudit auditctl_t local_login_t:fd use;
 allow auditctl_t proc_t:dir search;
 allow auditctl_t sysctl_kernel_t:dir search;
-allow auditctl_t sysctl_kernel_t:file read;
+allow auditctl_t sysctl_kernel_t:file { getattr read };
 allow auditd_t self:process setsched;
 dontaudit auditctl_t init_t:fd use; 
 allow auditctl_t initrc_devpts_t:chr_file { read write };
+allow auditd_t self:file { getattr read };
+ifdef(`rpm.te', `
+allow auditctl_t rpm_script_t:fd use;
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/automount.te policy-1.23.16/domains/program/unused/automount.te
--- nsapolicy/domains/program/unused/automount.te	2005-05-07 00:41:09.000000000 -0400
+++ policy-1.23.16/domains/program/unused/automount.te	2005-05-18 15:50:12.000000000 -0400
@@ -25,7 +25,7 @@
 
 allow automount_t { etc_t etc_runtime_t }:file { getattr read };
 allow automount_t proc_t:file { getattr read };
-allow automount_t self:process { setpgid setsched };
+allow automount_t self:process { getpgid setpgid setsched };
 allow automount_t self:capability { sys_nice dac_override };
 allow automount_t self:unix_stream_socket create_socket_perms;
 allow automount_t self:unix_dgram_socket create_socket_perms;
@@ -63,7 +63,7 @@
 allow userdomain autofs_t:dir r_dir_perms;
 allow kernel_t autofs_t:dir { getattr ioctl read search };
 
-allow automount_t home_root_t:dir getattr;
+allow automount_t { boot_t home_root_t }:dir getattr;
 allow automount_t mnt_t:dir { getattr search };
 
 can_exec(initrc_t, automount_etc_t)
@@ -71,4 +71,5 @@
 # Need something like the following
 # file_type_auto_trans(automount_t, file_type, automount_tmp_t, dir)
 
-
+allow automount_t var_lib_t:dir search;
+allow automount_t var_lib_nfs_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/bluetooth.te policy-1.23.16/domains/program/unused/bluetooth.te
--- nsapolicy/domains/program/unused/bluetooth.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.23.16/domains/program/unused/bluetooth.te	2005-05-18 15:50:12.000000000 -0400
@@ -39,4 +39,6 @@
 allow bluetooth_t bluetooth_conf_t:dir search;
 allow bluetooth_t bluetooth_conf_t:file { getattr read ioctl };
 #/usr/sbin/hid2hci causes the following
-allow initrc_t usbfs_t:file { read };
+allow initrc_t usbfs_t:file { getattr read };
+allow bluetooth_t usbfs_t:dir r_dir_perms;
+allow bluetooth_t usbfs_t:file rw_file_perms; 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.23.16/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2005-05-07 00:41:09.000000000 -0400
+++ policy-1.23.16/domains/program/unused/cups.te	2005-05-19 10:56:19.000000000 -0400
@@ -11,7 +11,6 @@
 # cupsd_t is the domain of cupsd.
 # cupsd_exec_t is the type of the cupsd executable.
 #
-type ipp_port_t, port_type, reserved_port_type;
 daemon_domain(cupsd, `, auth_chkpwd, nscd_client_domain')
 etcdir_domain(cupsd)
 type cupsd_rw_etc_t, file_type, sysadmfile, usercanread;
@@ -82,6 +81,11 @@
 allow cupsd_t self:capability { dac_read_search kill setgid setuid fsetid net_bind_service fowner chown dac_override sys_tty_config };
 dontaudit cupsd_t self:capability net_admin;
 
+#
+# /usr/lib/cups/backend/serial needs sys_admin
+# Need new context to run under???
+allow cupsd_t self:capability sys_admin;
+
 allow cupsd_t self:process setsched;
 
 # for /var/lib/defoma
@@ -111,7 +115,7 @@
 can_exec(cupsd_t, { shell_exec_t bin_t sbin_t })
 
 # They will also invoke ghostscript, which needs to read fonts
-r_dir_file(cupsd_t, fonts_t)
+read_fonts(cupsd_t)
 
 # Read /usr/lib/gconv/gconv-modules.* and /usr/lib/python2.2/.*
 allow cupsd_t lib_t:file { read getattr };
@@ -173,8 +177,6 @@
 allow cupsd_t userdomain:dbus send_msg;
 ')
 
-ifdef(`hald.te', `
-
 # CUPS configuration daemon
 daemon_domain(cupsd_config)
 
@@ -202,6 +204,7 @@
 rw_dir_create_file(cupsd_config_t, cupsd_etc_t)
 rw_dir_create_file(cupsd_config_t, cupsd_rw_etc_t)
 file_type_auto_trans(cupsd_config_t, cupsd_etc_t, cupsd_rw_etc_t, file)
+file_type_auto_trans(cupsd_config_t, var_t, cupsd_rw_etc_t, file)
 
 can_network_tcp(cupsd_config_t)
 can_ypbind(cupsd_config_t)
@@ -214,13 +217,23 @@
 dbusd_client(system, cupsd_config)
 allow cupsd_config_t userdomain:dbus send_msg;
 allow cupsd_config_t system_dbusd_t:dbus { send_msg acquire_svc };
-allow cupsd_t hald_t:dbus send_msg;
 allow userdomain cupsd_config_t:dbus send_msg;
+')dnl end if dbusd.te
+
+ifdef(`hald.te', `
+
+ifdef(`dbusd.te', `
+allow cupsd_t hald_t:dbus send_msg;
 allow cupsd_config_t hald_t:dbus send_msg;
-allow hald_t cupsd_config_t:dbus send_msg;
 allow hald_t cupsd_t:dbus send_msg;
 ')dnl end if dbusd.te
 
+allow hald_t cupsd_config_t:process signal;
+domain_auto_trans(hald_t, cupsd_config_exec_t, cupsd_config_t)
+
+') dnl end if hald.te
+
+
 can_exec(cupsd_config_t, { bin_t sbin_t shell_exec_t })
 ifdef(`hostname.te', `
 can_exec(cupsd_t, hostname_exec_t)
@@ -241,7 +254,6 @@
 
 allow cupsd_config_t urandom_device_t:chr_file { getattr read };
 
-domain_auto_trans(hald_t, cupsd_config_exec_t, cupsd_config_t)
 ifdef(`logrotate.te', `
 allow cupsd_config_t logrotate_t:fd use;
 ')dnl end if logrotate.te
@@ -252,10 +264,11 @@
 
 # Alternatives asks for this
 allow cupsd_config_t initrc_exec_t:file getattr;
-') dnl end if hald.te
 ifdef(`targeted_policy', `
 can_unix_connect(cupsd_t, initrc_t)
 allow cupsd_t initrc_t:dbus send_msg;
 allow initrc_t cupsd_t:dbus send_msg;
-allow cupsd_t unconfined_t:dbus send_msg;
+allow { cupsd_config_t cupsd_t } unconfined_t:dbus send_msg;
+allow unconfined_t cupsd_config_t:dbus send_msg;
+allow { cupsd_t cupsd_config_t } unconfined_t:fifo_file read;
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ddcprobe.te policy-1.23.16/domains/program/unused/ddcprobe.te
--- nsapolicy/domains/program/unused/ddcprobe.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.23.16/domains/program/unused/ddcprobe.te	2005-05-18 15:50:12.000000000 -0400
@@ -0,0 +1,42 @@
+#DESC ddcprobe - output ddcprobe results from kudzu
+#
+# Author: dan walsh <dwalsh@redhat.com>
+#
+
+type ddcprobe_t, domain, privmem;
+type ddcprobe_exec_t, file_type, exec_type, sysadmfile;
+
+# Allow execution by the sysadm
+role sysadm_r types ddcprobe_t;
+role system_r types ddcprobe_t;
+domain_auto_trans(sysadm_t, ddcprobe_exec_t, ddcprobe_t)
+
+uses_shlib(ddcprobe_t)
+
+# Allow terminal access
+access_terminal(ddcprobe_t, sysadm)
+
+# Allow ddcprobe to read /dev/mem
+allow ddcprobe_t memory_device_t:chr_file read;
+allow ddcprobe_t memory_device_t:chr_file { execute write };
+allow ddcprobe_t self:process execmem;
+allow ddcprobe_t zero_device_t:chr_file { execute read };
+
+allow ddcprobe_t proc_t:dir search;
+allow ddcprobe_t proc_t:file { getattr read };
+can_exec(ddcprobe_t, sbin_t)
+allow ddcprobe_t user_tty_type:chr_file rw_file_perms;
+allow ddcprobe_t userdomain:fd use;
+read_sysctl(ddcprobe_t)
+allow ddcprobe_t urandom_device_t:chr_file { getattr read };
+allow ddcprobe_t { bin_t sbin_t }:dir r_dir_perms;
+allow ddcprobe_t self:capability { sys_rawio sys_admin };
+
+allow ddcprobe_t { etc_t etc_runtime_t }:file { getattr read };
+allow ddcprobe_t kudzu_exec_t:file getattr;
+allow ddcprobe_t lib_t:file { getattr read };
+read_locale(ddcprobe_t)
+allow ddcprobe_t modules_object_t:dir search;
+allow ddcprobe_t modules_dep_t:file { getattr read };
+allow ddcprobe_t usr_t:file { getattr read };
+allow ddcprobe_t kernel_t:system syslog_console;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dhcpd.te policy-1.23.16/domains/program/unused/dhcpd.te
--- nsapolicy/domains/program/unused/dhcpd.te	2005-04-27 10:28:50.000000000 -0400
+++ policy-1.23.16/domains/program/unused/dhcpd.te	2005-05-18 15:50:12.000000000 -0400
@@ -15,7 +15,7 @@
 # dhcpd_exec_t is the type of the dhcpdd executable.
 # The dhcpd_t can be used for other DHCPC related files as well.
 #
-daemon_domain(dhcpd)
+daemon_domain(dhcpd, `, nscd_client_domain')
 
 allow dhcpd_t dhcpd_port_t:udp_socket name_bind;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dovecot.te policy-1.23.16/domains/program/unused/dovecot.te
--- nsapolicy/domains/program/unused/dovecot.te	2005-04-27 10:28:50.000000000 -0400
+++ policy-1.23.16/domains/program/unused/dovecot.te	2005-05-18 15:50:12.000000000 -0400
@@ -34,8 +34,7 @@
 allow dovecot_t pop_port_t:tcp_socket name_bind;
 allow dovecot_t urandom_device_t:chr_file { getattr read };
 allow dovecot_t cert_t:dir search;
-allow dovecot_t dovecot_cert_t:file { getattr read };
-allow dovecot_t cert_t:dir search;
+r_dir_file(dovecot_t, dovecot_cert_t)
 
 allow dovecot_t { self proc_t }:file { getattr read };
 allow dovecot_t self:fifo_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/fontconfig.te policy-1.23.16/domains/program/unused/fontconfig.te
--- nsapolicy/domains/program/unused/fontconfig.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.23.16/domains/program/unused/fontconfig.te	2005-05-18 15:50:12.000000000 -0400
@@ -0,0 +1,7 @@
+#
+# Fontconfig related types 
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+
+# Look in fontconfig_macros.te
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ftpd.te policy-1.23.16/domains/program/unused/ftpd.te
--- nsapolicy/domains/program/unused/ftpd.te	2005-04-27 10:28:50.000000000 -0400
+++ policy-1.23.16/domains/program/unused/ftpd.te	2005-05-18 15:50:12.000000000 -0400
@@ -9,7 +9,7 @@
 #
 # Rules for the ftpd_t domain 
 #
-daemon_domain(ftpd, `, auth_chkpwd')
+daemon_domain(ftpd, `, auth_chkpwd, nscd_client_domain')
 etc_domain(ftpd)
 
 can_network(ftpd_t)
@@ -69,7 +69,7 @@
 tmpfs_domain(ftpd)
 
 # Use capabilities.
-allow ftpd_t self:capability { chown fowner fsetid setgid setuid net_bind_service sys_chroot sys_nice sys_resource };
+allow ftpd_t self:capability { chown fowner fsetid setgid setuid net_bind_service sys_chroot sys_nice sys_resource audit_control };
 
 # Append to /var/log/wtmp.
 allow ftpd_t wtmp_t:file { getattr append };
@@ -100,6 +100,8 @@
 if (ftp_home_dir) {
 # allow access to /home
 allow ftpd_t home_root_t:dir { getattr search };
+allow ftpd_t home_dir_type:dir r_dir_perms;
+create_dir_file(ftpd_t, home_type)
 }
 if (use_nfs_home_dirs && ftp_home_dir) {
 	r_dir_file(ftpd_t, nfs_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/gpg.te policy-1.23.16/domains/program/unused/gpg.te
--- nsapolicy/domains/program/unused/gpg.te	2005-04-27 10:28:50.000000000 -0400
+++ policy-1.23.16/domains/program/unused/gpg.te	2005-05-18 15:50:12.000000000 -0400
@@ -8,7 +8,7 @@
 type gpg_exec_t, file_type, sysadmfile, exec_type;
 type gpg_helper_exec_t, file_type, sysadmfile, exec_type;
 
-allow sysadm_gpg_t { home_root_t user_home_dir_t }:dir search;
+allow sysadm_gpg_t { home_root_t user_home_dir_type }:dir search;
 allow sysadm_gpg_t ptyfile:chr_file rw_file_perms;
 
 # Allow gpg exec stack
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.23.16/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2005-05-07 00:41:09.000000000 -0400
+++ policy-1.23.16/domains/program/unused/hald.te	2005-05-18 15:50:12.000000000 -0400
@@ -36,7 +36,7 @@
 
 allow hald_t self:netlink_kobject_uevent_socket create_socket_perms;
 allow hald_t self:netlink_route_socket r_netlink_socket_perms;
-allow hald_t self:capability { net_admin sys_admin dac_override dac_read_search mknod };
+allow hald_t self:capability { net_admin sys_admin dac_override dac_read_search mknod sys_rawio };
 can_network_server(hald_t)
 can_ypbind(hald_t)
 
@@ -64,10 +64,8 @@
 ifdef(`hotplug.te', `
 r_dir_file(hald_t, hotplug_etc_t)
 ')
-allow hald_t usbdevfs_t:dir search;
-allow hald_t usbdevfs_t:file { getattr read };
-allow hald_t usbfs_t:dir search;
-allow hald_t usbfs_t:file { getattr read };
+allow hald_t fs_type:dir { search getattr };
+allow hald_t { usbdevfs_t usbfs_t }:file { getattr read };
 allow hald_t bin_t:lnk_file read;
 r_dir_file(hald_t, { selinux_config_t default_context_t } )
 allow hald_t initrc_t:dbus send_msg;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hotplug.te policy-1.23.16/domains/program/unused/hotplug.te
--- nsapolicy/domains/program/unused/hotplug.te	2005-05-07 00:41:09.000000000 -0400
+++ policy-1.23.16/domains/program/unused/hotplug.te	2005-05-18 15:50:12.000000000 -0400
@@ -29,7 +29,7 @@
 
 # get info from /proc
 r_dir_file(hotplug_t, proc_t)
-allow hotplug_t self:file { getattr read };
+allow hotplug_t self:file { getattr read ioctl };
 
 allow hotplug_t devtty_t:chr_file rw_file_perms;
 
@@ -129,7 +129,7 @@
 allow hotplug_t lib_t:file { getattr read };
 
 allow hotplug_t self:capability { net_admin sys_tty_config mknod };
-allow hotplug_t sysfs_t:dir { getattr read search };
+allow hotplug_t sysfs_t:dir { getattr read search write };
 allow hotplug_t sysfs_t:file { getattr read };
 allow hotplug_t sysfs_t:lnk_file { getattr read };
 allow hotplug_t udev_runtime_t:file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/kudzu.te policy-1.23.16/domains/program/unused/kudzu.te
--- nsapolicy/domains/program/unused/kudzu.te	2005-05-16 11:28:12.000000000 -0400
+++ policy-1.23.16/domains/program/unused/kudzu.te	2005-05-18 15:50:12.000000000 -0400
@@ -26,7 +26,6 @@
 allow kudzu_t mouse_device_t:chr_file { read write };
 allow kudzu_t proc_net_t:dir r_dir_perms;
 allow kudzu_t { proc_net_t proc_t }:file { getattr read };
-allow kudzu_t proc_t:lnk_file getattr;
 allow kudzu_t { fixed_disk_device_t removable_device_t }:blk_file rw_file_perms;
 allow kudzu_t scsi_generic_device_t:chr_file r_file_perms;
 allow kudzu_t { bin_t sbin_t }:dir { getattr search };
@@ -109,3 +108,4 @@
 ')
 
 allow kudzu_t initrc_t:unix_stream_socket connectto;
+allow kudzu_t net_conf_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/lpd.te policy-1.23.16/domains/program/unused/lpd.te
--- nsapolicy/domains/program/unused/lpd.te	2005-04-27 10:28:51.000000000 -0400
+++ policy-1.23.16/domains/program/unused/lpd.te	2005-05-18 15:50:12.000000000 -0400
@@ -20,7 +20,7 @@
 
 allow lpd_t lpd_var_run_t:sock_file create_file_perms;
 
-r_dir_file(lpd_t, fonts_t)
+read_fonts(lpd_t)
 
 type printer_t, file_type, sysadmfile, dev_fs;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/lvm.te policy-1.23.16/domains/program/unused/lvm.te
--- nsapolicy/domains/program/unused/lvm.te	2005-05-07 00:41:09.000000000 -0400
+++ policy-1.23.16/domains/program/unused/lvm.te	2005-05-18 15:50:12.000000000 -0400
@@ -18,7 +18,6 @@
 type lvm_metadata_t, file_type, sysadmfile;
 type lvm_control_t, device_type, dev_fs;
 etcdir_domain(lvm)
-allow lvm_t var_t:dir search;
 lock_domain(lvm)
 allow lvm_t lvm_lock_t:dir rw_dir_perms;
 
@@ -35,7 +34,7 @@
 allow lvm_t self:unix_dgram_socket create_socket_perms;
 
 r_dir_file(lvm_t, proc_t)
-allow lvm_t self:file r_file_perms;
+allow lvm_t self:file rw_file_perms;
 
 # Read system variables in /proc/sys
 read_sysctl(lvm_t)
@@ -65,7 +64,7 @@
 allow lvm_t { random_device_t urandom_device_t }:chr_file { getattr read ioctl };
 
 # DAC overrides and mknod for modifying /dev entries (vgmknodes)
-allow lvm_t self:capability { dac_override ipc_lock sys_admin sys_nice mknod };
+allow lvm_t self:capability { dac_override ipc_lock sys_admin sys_nice sys_resource mknod };
 
 # Write to /etc/lvm, /etc/lvmtab, /etc/lvmtab.d
 file_type_auto_trans(lvm_t, { etc_t lvm_etc_t }, lvm_metadata_t, file)
@@ -108,7 +107,7 @@
 ')
 dontaudit lvm_t initctl_t:fifo_file getattr;
 allow lvm_t sbin_t:dir search;
-dontaudit lvm_t sbin_t:file getattr;
+dontaudit lvm_t sbin_t:file { getattr read };
 allow lvm_t lvm_control_t:chr_file rw_file_perms;
 allow initrc_t lvm_control_t:chr_file { getattr read unlink };
 allow initrc_t device_t:chr_file create;
@@ -122,3 +121,18 @@
 
 # it has no reason to need this
 dontaudit lvm_t proc_kcore_t:file getattr;
+allow lvm_t var_t:dir { search getattr };
+allow lvm_t ramfs_t:filesystem unmount;
+
+# cluster LVM daemon
+daemon_domain(clvmd)
+can_network(clvmd_t)
+can_ypbind(clvmd_t)
+allow clvmd_t self:capability net_bind_service;
+allow clvmd_t self:socket create_socket_perms;
+allow clvmd_t self:fifo_file { read write };
+allow clvmd_t self:file { getattr read };
+allow clvmd_t self:unix_stream_socket { connectto create_stream_socket_perms };
+allow clvmd_t reserved_port_t:tcp_socket name_bind;
+dontaudit clvmd_t reserved_port_type:tcp_socket name_bind;
+dontaudit clvmd_t selinux_config_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mrtg.te policy-1.23.16/domains/program/unused/mrtg.te
--- nsapolicy/domains/program/unused/mrtg.te	2005-04-27 10:28:51.000000000 -0400
+++ policy-1.23.16/domains/program/unused/mrtg.te	2005-05-18 15:50:12.000000000 -0400
@@ -81,7 +81,7 @@
 
 # for uptime
 allow mrtg_t var_run_t:dir search;
-allow mrtg_t initrc_var_run_t:file read;
+allow mrtg_t initrc_var_run_t:file { getattr read };
 dontaudit mrtg_t initrc_var_run_t:file { write lock };
 allow mrtg_t etc_runtime_t:file { getattr read };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mta.te policy-1.23.16/domains/program/unused/mta.te
--- nsapolicy/domains/program/unused/mta.te	2005-04-27 10:28:51.000000000 -0400
+++ policy-1.23.16/domains/program/unused/mta.te	2005-05-18 15:50:12.000000000 -0400
@@ -23,6 +23,7 @@
 # targeted policy.  We could move these rules permanantly here.
 ifdef(`postfix.te', `', `can_exec_any(system_mail_t)')
 allow system_mail_t self:dir { search };
+allow system_mail_t self:lnk_file read;
 r_dir_file(system_mail_t, { proc_t proc_net_t })
 allow system_mail_t fs_t:filesystem getattr;
 allow system_mail_t { var_t var_spool_t }:dir getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mysqld.te policy-1.23.16/domains/program/unused/mysqld.te
--- nsapolicy/domains/program/unused/mysqld.te	2005-04-27 10:28:51.000000000 -0400
+++ policy-1.23.16/domains/program/unused/mysqld.te	2005-05-18 15:50:12.000000000 -0400
@@ -35,7 +35,7 @@
 allow initrc_t mysqld_log_t:file { write append setattr ioctl };
 
 allow mysqld_t self:capability { dac_override setgid setuid net_bind_service };
-allow mysqld_t self:process getsched;
+allow mysqld_t self:process { setsched getsched };
 
 allow mysqld_t proc_t:file { getattr read };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nx_server.te policy-1.23.16/domains/program/unused/nx_server.te
--- nsapolicy/domains/program/unused/nx_server.te	2005-04-27 10:28:52.000000000 -0400
+++ policy-1.23.16/domains/program/unused/nx_server.te	2005-05-18 15:50:12.000000000 -0400
@@ -51,7 +51,7 @@
 
 allow nx_server_t devtty_t:chr_file { read write };
 allow nx_server_t sysctl_kernel_t:dir search;
-allow nx_server_t sysctl_kernel_t:file read;
+allow nx_server_t sysctl_kernel_t:file { getattr read };
 allow nx_server_t urandom_device_t:chr_file read;
 # for reading the config files; maybe a separate type, 
 # but users need to be able to also read the config
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/pamconsole.te policy-1.23.16/domains/program/unused/pamconsole.te
--- nsapolicy/domains/program/unused/pamconsole.te	2005-05-07 00:41:09.000000000 -0400
+++ policy-1.23.16/domains/program/unused/pamconsole.te	2005-05-18 15:50:12.000000000 -0400
@@ -46,4 +46,5 @@
 allow pam_console_t xdm_var_run_t:file { getattr read };
 ')
 allow initrc_t pam_var_console_t:dir rw_dir_perms;
+allow initrc_t pam_var_console_t:file unlink;
 allow pam_console_t file_context_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/pppd.te policy-1.23.16/domains/program/unused/pppd.te
--- nsapolicy/domains/program/unused/pppd.te	2005-04-27 10:28:52.000000000 -0400
+++ policy-1.23.16/domains/program/unused/pppd.te	2005-05-18 15:50:12.000000000 -0400
@@ -46,7 +46,7 @@
 ifdef(`postfix.te', `
 allow pppd_t postfix_etc_t:dir search;
 allow pppd_t postfix_etc_t:file r_file_perms;
-allow pppd_t postfix_master_exec_t:file read;
+allow pppd_t postfix_master_exec_t:file { getattr read };
 allow postfix_postqueue_t pppd_t:fd use;
 allow postfix_postqueue_t pppd_t:process sigchld;
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/procmail.te policy-1.23.16/domains/program/unused/procmail.te
--- nsapolicy/domains/program/unused/procmail.te	2005-04-27 10:28:52.000000000 -0400
+++ policy-1.23.16/domains/program/unused/procmail.te	2005-05-18 15:50:12.000000000 -0400
@@ -57,6 +57,9 @@
 
 # for spamassasin
 allow procmail_t usr_t:file { getattr ioctl read };
+ifdef(`spamassassin.te', `
+can_exec(procmail_t, spamassassin_exec_t)
+')
 
 # Search /var/run.
 allow procmail_t var_run_t:dir { getattr search };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/qmail.te policy-1.23.16/domains/program/unused/qmail.te
--- nsapolicy/domains/program/unused/qmail.te	2005-04-27 10:28:52.000000000 -0400
+++ policy-1.23.16/domains/program/unused/qmail.te	2005-05-18 15:50:12.000000000 -0400
@@ -82,7 +82,7 @@
 allow qmail_rspawn_t { bin_t sbin_t }:dir search;
 
 qmaild_sub_domain(qmail_rspawn_t, qmail_remote)
-allow qmail_rspawn_t qmail_remote_exec_t:file read;
+allow qmail_rspawn_t qmail_remote_exec_t:file { getattr read };
 can_network_server(qmail_remote_t)
 can_ypbind(qmail_remote_t)
 allow qmail_remote_t qmail_spool_t:dir search;
@@ -96,10 +96,10 @@
 
 # privhome will do until we get a separate maildir type
 qmaild_sub_domain(qmail_lspawn_t, qmail_local, `, privhome, mta_delivery_agent')
-allow qmail_lspawn_t qmail_local_exec_t:file read;
+allow qmail_lspawn_t qmail_local_exec_t:file { getattr read };
 allow qmail_local_t self:process { fork signal_perms };
 domain_auto_trans(qmail_local_t, qmail_queue_exec_t, qmail_queue_t)
-allow qmail_local_t qmail_queue_exec_t:file read;
+allow qmail_local_t qmail_queue_exec_t:file { getattr read };
 allow qmail_local_t qmail_spool_t:file { ioctl read };
 allow qmail_local_t self:fifo_file write;
 allow qmail_local_t sbin_t:dir search;
@@ -128,7 +128,7 @@
 can_ypbind(qmail_tcp_env_t)
 
 qmaild_sub_domain(qmail_tcp_env_t, qmail_smtpd)
-allow qmail_tcp_env_t qmail_smtpd_exec_t:file read;
+allow qmail_tcp_env_t qmail_smtpd_exec_t:file { getattr read };
 can_network_server(qmail_smtpd_t)
 can_ypbind(qmail_smtpd_t)
 allow qmail_smtpd_t inetd_t:fd use;
@@ -139,7 +139,7 @@
 allow qmail_smtpd_t self:tcp_socket create_socket_perms;
 allow qmail_smtpd_t sbin_t:dir search;
 domain_auto_trans(qmail_smtpd_t, qmail_queue_exec_t, qmail_queue_t)
-allow qmail_smtpd_t qmail_queue_exec_t:file read;
+allow qmail_smtpd_t qmail_queue_exec_t:file { getattr read };
 
 qmaild_sub_domain(user_mail_domain, qmail_inject, `, mta_user_agent')
 allow qmail_inject_t self:process { fork signal_perms };
@@ -158,7 +158,7 @@
 qmaild_sub_domain(qmail_inject_t, qmail_queue, `, mta_user_agent')
 role sysadm_r types qmail_queue_t;
 in_user_role(qmail_queue_t)
-allow qmail_inject_t qmail_queue_exec_t:file read;
+allow qmail_inject_t qmail_queue_exec_t:file { getattr read };
 rw_dir_create_file(qmail_queue_t, qmail_spool_t)
 allow qmail_queue_t qmail_spool_t:fifo_file { read write };
 allow qmail_queue_t { qmail_start_t qmail_lspawn_t }:fd use;
@@ -171,10 +171,10 @@
 allow qmail_queue_t sysadm_t:fd use;
 allow qmail_queue_t sysadm_t:fifo_file write;
 
-allow user_crond_t qmail_etc_t:dir search;
-allow user_crond_t qmail_etc_t:file read;
+allow user_crond_domain qmail_etc_t:dir search;
+allow user_crond_domain qmail_etc_t:file { getattr read };
 
-qmaild_sub_domain(user_crond_t, qmail_serialmail)
+qmaild_sub_domain(user_crond_domain, qmail_serialmail)
 in_user_role(qmail_serialmail_t)
 can_network_server(qmail_serialmail_t)
 can_ypbind(qmail_serialmail_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rhgb.te policy-1.23.16/domains/program/unused/rhgb.te
--- nsapolicy/domains/program/unused/rhgb.te	2005-04-27 10:28:52.000000000 -0400
+++ policy-1.23.16/domains/program/unused/rhgb.te	2005-05-18 15:50:12.000000000 -0400
@@ -43,9 +43,6 @@
 allow rhgb_t port_type:tcp_socket name_connect;
 can_ypbind(rhgb_t)
 
-# for fonts
-allow rhgb_t usr_t:{ file lnk_file } { getattr read };
-
 # for running setxkbmap
 r_dir_file(rhgb_t, xkb_var_lib_t)
 
@@ -68,8 +65,7 @@
 tmpfs_domain(rhgb)
 allow xdm_xserver_t rhgb_tmpfs_t:file { read write };
 
-allow rhgb_t fonts_t:dir { getattr read search };
-allow rhgb_t fonts_t:file { getattr read };
+read_fonts(rhgb_t)
 
 # for nscd
 dontaudit rhgb_t var_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpcd.te policy-1.23.16/domains/program/unused/rpcd.te
--- nsapolicy/domains/program/unused/rpcd.te	2005-04-27 10:28:52.000000000 -0400
+++ policy-1.23.16/domains/program/unused/rpcd.te	2005-05-18 15:50:12.000000000 -0400
@@ -140,3 +140,6 @@
 r_dir_file(gssd_t, proc_net_t)
 allow gssd_t rpc_pipefs_t:dir r_dir_perms;
 allow gssd_t rpc_pipefs_t:sock_file { read write };
+allow gssd_t rpc_pipefs_t:file r_file_perms;
+allow gssd_t self:capability setuid;
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/samba.te policy-1.23.16/domains/program/unused/samba.te
--- nsapolicy/domains/program/unused/samba.te	2005-05-02 14:06:54.000000000 -0400
+++ policy-1.23.16/domains/program/unused/samba.te	2005-05-18 15:50:12.000000000 -0400
@@ -46,7 +46,8 @@
 allow smbd_t self:capability { setgid setuid sys_resource net_bind_service lease dac_override dac_read_search };
 
 # Use the network.
-can_network_server(smbd_t)
+can_network(smbd_t)
+allow smbd_t ipp_port_t:tcp_socket name_connect;
 
 allow smbd_t urandom_device_t:chr_file { getattr read };
 
@@ -108,6 +109,7 @@
 allow nmbd_t samba_log_t:file { create ra_file_perms };
 allow nmbd_t var_log_t:dir search;
 allow nmbd_t samba_log_t:dir ra_dir_perms;
+allow nmbd_t etc_t:file { getattr read };
 ifdef(`cups.te', `
 allow smbd_t cupsd_rw_etc_t:file { getattr read };
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/saslauthd.te policy-1.23.16/domains/program/unused/saslauthd.te
--- nsapolicy/domains/program/unused/saslauthd.te	2005-04-27 10:28:52.000000000 -0400
+++ policy-1.23.16/domains/program/unused/saslauthd.te	2005-05-18 15:50:12.000000000 -0400
@@ -15,7 +15,7 @@
 allow saslauthd_t net_conf_t:file r_file_perms;
 
 allow saslauthd_t self:file r_file_perms;
-allow saslauthd_t proc_t:file read;
+allow saslauthd_t proc_t:file { getattr read };
 
 allow saslauthd_t urandom_device_t:chr_file { getattr read }; 
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/slapd.te policy-1.23.16/domains/program/unused/slapd.te
--- nsapolicy/domains/program/unused/slapd.te	2005-04-27 10:28:53.000000000 -0400
+++ policy-1.23.16/domains/program/unused/slapd.te	2005-05-19 10:23:01.000000000 -0400
@@ -31,7 +31,7 @@
 can_tcp_connect(domain, slapd_t)
 
 # Use capabilities  should not need kill...
-allow slapd_t self:capability { kill setgid setuid net_bind_service net_raw };
+allow slapd_t self:capability { kill setgid setuid net_bind_service net_raw dac_override dac_read_search };
 allow slapd_t self:process setsched;
 
 allow slapd_t proc_t:file r_file_perms;
@@ -49,7 +49,7 @@
 allow slapd_t etc_runtime_t:file { getattr read };
 
 # for startup script
-allow initrc_t slapd_etc_t:file read;
+allow initrc_t slapd_etc_t:file { getattr read };
 
 allow slapd_t etc_t:dir r_dir_perms;
 
@@ -58,3 +58,4 @@
 allow slapd_t usr_t:file { read getattr };
 allow slapd_t urandom_device_t:chr_file { getattr read };
 allow slapd_t self:netlink_route_socket r_netlink_socket_perms;
+r_dir_file(slapd_t, cert_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/snmpd.te policy-1.23.16/domains/program/unused/snmpd.te
--- nsapolicy/domains/program/unused/snmpd.te	2005-05-02 14:06:54.000000000 -0400
+++ policy-1.23.16/domains/program/unused/snmpd.te	2005-05-19 11:34:15.000000000 -0400
@@ -8,7 +8,7 @@
 #
 # Rules for the snmpd_t domain.
 #
-daemon_domain(snmpd)
+daemon_domain(snmpd, `, nscd_client_domain')
 
 #temp
 allow snmpd_t var_t:dir getattr;
@@ -78,6 +78,7 @@
 allow snmpd_t proc_net_t:dir search;
 allow snmpd_t proc_net_t:file r_file_perms;
 
-dontaudit snmpd_t domain:dir { getattr search };
+allow snmpd_t domain:dir { getattr search };
+allow snmpd_t domain:file { getattr read };
 
 dontaudit snmpd_t selinux_config_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/snort.te policy-1.23.16/domains/program/unused/snort.te
--- nsapolicy/domains/program/unused/snort.te	2005-04-27 10:28:53.000000000 -0400
+++ policy-1.23.16/domains/program/unused/snort.te	2005-05-18 15:50:12.000000000 -0400
@@ -28,6 +28,6 @@
 allow snort_t self:unix_stream_socket create_socket_perms;
 
 # for start script
-allow initrc_t snort_etc_t:file read;
+allow initrc_t snort_etc_t:file { getattr read };
 
-dontaudit snort_t { etc_runtime_t proc_t }:file read;
+dontaudit snort_t { etc_runtime_t proc_t }:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/sxid.te policy-1.23.16/domains/program/unused/sxid.te
--- nsapolicy/domains/program/unused/sxid.te	2005-04-27 10:28:53.000000000 -0400
+++ policy-1.23.16/domains/program/unused/sxid.te	2005-05-18 15:50:12.000000000 -0400
@@ -31,7 +31,7 @@
 allow sxid_t { device_t device_type }:{ chr_file blk_file } getattr;
 allow sxid_t ttyfile:chr_file getattr;
 allow sxid_t file_type:dir { getattr read search };
-allow sxid_t sysadmfile:file read;
+allow sxid_t sysadmfile:file { getattr read };
 allow sxid_t fs_type:dir { getattr read search };
 
 # Use the network.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.23.16/domains/program/unused/udev.te
--- nsapolicy/domains/program/unused/udev.te	2005-05-07 00:41:10.000000000 -0400
+++ policy-1.23.16/domains/program/unused/udev.te	2005-05-18 15:50:12.000000000 -0400
@@ -142,3 +142,4 @@
 ifdef(`unlimitedUtils', `
 unconfined_domain(udev_t) 
 ')
+dontaudit hostname_t udev_t:fd use;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/uml_net.te policy-1.23.16/domains/program/unused/uml_net.te
--- nsapolicy/domains/program/unused/uml_net.te	2005-04-27 10:28:53.000000000 -0400
+++ policy-1.23.16/domains/program/unused/uml_net.te	2005-05-18 15:50:12.000000000 -0400
@@ -15,7 +15,7 @@
 uses_shlib(uml_net_t)
 allow uml_net_t devtty_t:chr_file { read write };
 allow uml_net_t etc_runtime_t:file { getattr read };
-allow uml_net_t etc_t:file read;
+allow uml_net_t etc_t:file { getattr read };
 allow uml_net_t { proc_t sysctl_t sysctl_net_t }:dir search;
 allow uml_net_t proc_t:file { getattr read };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/winbind.te policy-1.23.16/domains/program/unused/winbind.te
--- nsapolicy/domains/program/unused/winbind.te	2005-04-27 10:28:54.000000000 -0400
+++ policy-1.23.16/domains/program/unused/winbind.te	2005-05-19 07:32:26.000000000 -0400
@@ -8,7 +8,7 @@
 # Declarations for winbind
 #
 
-daemon_domain(winbind, `, privhome, auth_chkpwd')
+daemon_domain(winbind, `, privhome, auth_chkpwd, nscd_client_domain')
 log_domain(winbind)
 allow winbind_t etc_t:file r_file_perms;
 allow winbind_t etc_t:lnk_file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xauth.te policy-1.23.16/domains/program/unused/xauth.te
--- nsapolicy/domains/program/unused/xauth.te	2005-04-27 10:28:54.000000000 -0400
+++ policy-1.23.16/domains/program/unused/xauth.te	2005-05-18 15:50:12.000000000 -0400
@@ -9,7 +9,5 @@
 #
 type xauth_exec_t, file_type, sysadmfile, exec_type;
 
-file_type_auto_trans(sysadm_xauth_t, staff_home_dir_t, staff_home_xauth_t)
-
 # Everything else is in the xauth_domain macro in
 # macros/program/xauth_macros.te.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xdm.te policy-1.23.16/domains/program/unused/xdm.te
--- nsapolicy/domains/program/unused/xdm.te	2005-05-07 00:41:11.000000000 -0400
+++ policy-1.23.16/domains/program/unused/xdm.te	2005-05-18 15:50:12.000000000 -0400
@@ -78,7 +78,7 @@
 allow unpriv_userdomain xdm_xserver_t:unix_stream_socket connectto;
 allow unpriv_userdomain xdm_xserver_t:shm r_shm_perms;
 allow unpriv_userdomain xdm_xserver_t:fd use;
-allow unpriv_userdomain xdm_xserver_tmpfs_t:file read;
+allow unpriv_userdomain xdm_xserver_tmpfs_t:file { getattr read };
 allow xdm_xserver_t unpriv_userdomain:shm rw_shm_perms;
 allow xdm_xserver_t unpriv_userdomain:fd use;
 
@@ -96,7 +96,7 @@
 allow sysadm_t xdm_xserver_t:unix_stream_socket connectto;
 allow sysadm_t xdm_xserver_t:shm r_shm_perms;
 allow sysadm_t xdm_xserver_t:fd use;
-allow sysadm_t xdm_xserver_tmpfs_t:file read;
+allow sysadm_t xdm_xserver_tmpfs_t:file { getattr read };
 allow xdm_xserver_t sysadm_t:shm rw_shm_perms;
 allow xdm_xserver_t sysadm_t:fd use;
 }
@@ -145,7 +145,7 @@
 allow { xdm_t unpriv_userdomain } xdm_xserver_t:unix_stream_socket connectto;
 allow { xdm_t unpriv_userdomain } xdm_xserver_t:shm rw_shm_perms;
 allow { xdm_t unpriv_userdomain } xdm_xserver_t:fd use;
-allow { xdm_t unpriv_userdomain } xdm_xserver_tmpfs_t:file read;
+allow { xdm_t unpriv_userdomain } xdm_xserver_tmpfs_t:file { getattr read };
 allow xdm_xserver_t { xdm_t unpriv_userdomain }:shm rw_shm_perms;
 allow xdm_xserver_t { xdm_t unpriv_userdomain }:fd use;
 
@@ -225,7 +225,9 @@
 
 # Read /usr/share/terminfo/l/linux and /usr/share/icons/default/index.theme...
 allow xdm_t usr_t:{ lnk_file file } { getattr read };
-r_dir_file(xdm_t, fonts_t)
+
+# Read fonts
+read_fonts(xdm_t)
 
 # Do not audit attempts to write to index files under /usr
 dontaudit xdm_t usr_t:file write;
@@ -265,7 +267,7 @@
 
 # Insert video drivers.  
 allow xdm_xserver_t self:capability mknod;
-allow xdm_xserver_t sysctl_modprobe_t:file read;
+allow xdm_xserver_t sysctl_modprobe_t:file { getattr read };
 domain_auto_trans(xdm_xserver_t, insmod_exec_t, insmod_t)
 allow insmod_t xdm_t:fd use;
 allow insmod_t xserver_log_t:file write;
@@ -317,18 +319,17 @@
 rw_dir_create_file(xdm_t, pam_var_console_t)
 ')
 
-allow xdm_t var_log_t:file read;
+allow xdm_t var_log_t:file { getattr read };
 allow xdm_t self:capability { sys_nice sys_rawio net_bind_service };
 allow xdm_t self:process setrlimit;
 allow xdm_t wtmp_t:file { getattr read };
 
 domain_auto_trans(initrc_t, xserver_exec_t, xdm_xserver_t)
 #
-# Poweroff wants to create the /root/poweroff directory when run from xdm
-# Seems to work without it.
+# Poweroff wants to create the /poweroff file when run from xdm
 #
-dontaudit xdm_t root_t:dir { add_name write };
-dontaudit xdm_t root_t:file create;
+file_type_auto_trans(xdm_t, root_t, etc_runtime_t, file)
+
 #
 # xdm tries to bind to biff_port_t
 #
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xfs.te policy-1.23.16/domains/program/unused/xfs.te
--- nsapolicy/domains/program/unused/xfs.te	2005-04-27 10:28:54.000000000 -0400
+++ policy-1.23.16/domains/program/unused/xfs.te	2005-05-18 15:50:12.000000000 -0400
@@ -37,9 +37,8 @@
 allow xfs_t self:unix_stream_socket create_stream_socket_perms;
 allow xfs_t self:unix_dgram_socket create_socket_perms;
 
-# Read /usr/X11R6/lib/X11/fonts/.* and /usr/share/fonts/.*
-allow xfs_t fonts_t:dir search;
-allow xfs_t fonts_t:file { getattr read };
+# Read fonts
+read_fonts(xfs_t)
 
 # Unlink the xfs socket.
 allow initrc_t xfs_tmp_t:dir rw_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/yam.te policy-1.23.16/domains/program/unused/yam.te
--- nsapolicy/domains/program/unused/yam.te	2005-05-06 16:46:27.000000000 -0400
+++ policy-1.23.16/domains/program/unused/yam.te	2005-05-18 15:50:12.000000000 -0400
@@ -125,7 +125,7 @@
 allow yam_crond_t default_t:dir search;
 
 # Don't know why init tries to read this.
-allow initrc_t yam_etc_t:file read;
+allow initrc_t yam_etc_t:file { getattr read };
 
 
 ##########
diff --exclude-from=exclude -N -u -r nsapolicy/domains/user.te policy-1.23.16/domains/user.te
--- nsapolicy/domains/user.te	2005-05-02 14:06:54.000000000 -0400
+++ policy-1.23.16/domains/user.te	2005-05-18 15:50:12.000000000 -0400
@@ -78,6 +78,12 @@
 dontaudit $1_su_t { sysadm_home_t staff_home_t }:dir rw_dir_perms;
 dontaudit $1_su_t { sysadm_home_t staff_home_t }:file create_file_perms;
 ') dnl ifdef su.te
+ifdef(`xauth.te', `
+file_type_auto_trans($1_xauth_t, sysadm_home_dir_t, sysadm_home_xauth_t,file)
+')
+ifdef(`userhelper.te', `
+file_type_auto_trans($1_userhelper_t, sysadm_home_dir_t, sysadm_home_xauth_t,file)
+')
 ')
 
 # Privileged user domain
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/distros.fc policy-1.23.16/file_contexts/distros.fc
--- nsapolicy/file_contexts/distros.fc	2005-05-07 00:41:12.000000000 -0400
+++ policy-1.23.16/file_contexts/distros.fc	2005-05-18 15:50:12.000000000 -0400
@@ -1,6 +1,7 @@
 ifdef(`distro_redhat', `
 /usr/share/system-config-network(/netconfig)?/[^/]+\.py -- system_u:object_r:bin_t
 /etc/sysconfig/networking/profiles/.*/resolv\.conf -- system_u:object_r:net_conf_t
+/etc/sysconfig/network-scripts/ifcfg-.+ -- system_u:object_r:net_conf_t
 /etc/sysconfig/network-scripts/.*resolv\.conf -- system_u:object_r:net_conf_t
 /usr/share/rhn/rhn_applet/applet\.py -- system_u:object_r:bin_t
 /usr/share/rhn/rhn_applet/eggtrayiconmodule\.so -- system_u:object_r:shlib_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/bluetooth.fc policy-1.23.16/file_contexts/program/bluetooth.fc
--- nsapolicy/file_contexts/program/bluetooth.fc	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.16/file_contexts/program/bluetooth.fc	2005-05-18 15:50:12.000000000 -0400
@@ -4,4 +4,5 @@
 /usr/sbin/hcid		--	system_u:object_r:bluetooth_exec_t
 /usr/sbin/sdpd		--	system_u:object_r:bluetooth_exec_t
 /usr/sbin/hciattach	--	system_u:object_r:bluetooth_exec_t
-/var/run/sdp		--	system_u:object_r:bluetooth_var_run_t
+/var/run/sdp		-s	system_u:object_r:bluetooth_var_run_t
+/usr/sbin/hid2hci	--	system_u:object_r:bluetooth_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/ddcprobe.fc policy-1.23.16/file_contexts/program/ddcprobe.fc
--- nsapolicy/file_contexts/program/ddcprobe.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.23.16/file_contexts/program/ddcprobe.fc	2005-05-18 15:50:12.000000000 -0400
@@ -0,0 +1 @@
+/usr/sbin/ddcprobe      --		system_u:object_r:ddcprobe_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/dovecot.fc policy-1.23.16/file_contexts/program/dovecot.fc
--- nsapolicy/file_contexts/program/dovecot.fc	2005-03-21 22:32:19.000000000 -0500
+++ policy-1.23.16/file_contexts/program/dovecot.fc	2005-05-18 15:50:12.000000000 -0400
@@ -10,6 +10,7 @@
 ')
 /usr/share/ssl/certs/dovecot\.pem --	system_u:object_r:dovecot_cert_t
 /usr/share/ssl/private/dovecot\.pem --	system_u:object_r:dovecot_cert_t
+/etc/pki/dovecot(/.*)?			system_u:object_r:dovecot_cert_t
 /var/run/dovecot(-login)?(/.*)?		system_u:object_r:dovecot_var_run_t
 /usr/lib(64)?/dovecot/.+	--		system_u:object_r:bin_t
 /var/spool/dovecot(/.*)?		system_u:object_r:dovecot_spool_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/fontconfig.fc policy-1.23.16/file_contexts/program/fontconfig.fc
--- nsapolicy/file_contexts/program/fontconfig.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.23.16/file_contexts/program/fontconfig.fc	2005-05-18 15:50:12.000000000 -0400
@@ -0,0 +1,2 @@
+HOME_DIR/\.fonts(/.*)?				system_u:object_r:ROLE_fonts_t	
+HOME_DIR/\.fonts.cache-1		--	system_u:object_r:ROLE_fonts_cache_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/initrc.fc policy-1.23.16/file_contexts/program/initrc.fc
--- nsapolicy/file_contexts/program/initrc.fc	2005-04-14 15:01:54.000000000 -0400
+++ policy-1.23.16/file_contexts/program/initrc.fc	2005-05-18 15:50:12.000000000 -0400
@@ -38,5 +38,11 @@
 /etc/nohotplug		--	system_u:object_r:etc_runtime_t
 ifdef(`distro_redhat', `
 /halt			--	system_u:object_r:etc_runtime_t
+/fastboot 		--	system_u:object_r:etc_runtime_t
+/fsckoptions 		--	system_u:object_r:etc_runtime_t
+/forcefsck 		--	system_u:object_r:etc_runtime_t
+/poweroff		--	system_u:object_r:etc_runtime_t
 /\.autofsck		--	system_u:object_r:etc_runtime_t
+/\.autorelabel		--	system_u:object_r:etc_runtime_t
 ')
+
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/lvm.fc policy-1.23.16/file_contexts/program/lvm.fc
--- nsapolicy/file_contexts/program/lvm.fc	2005-05-02 14:06:56.000000000 -0400
+++ policy-1.23.16/file_contexts/program/lvm.fc	2005-05-18 15:50:12.000000000 -0400
@@ -65,3 +65,5 @@
 /sbin/pvs          --      system_u:object_r:lvm_exec_t
 /sbin/vgs          --      system_u:object_r:lvm_exec_t
 /sbin/multipathd   --      system_u:object_r:lvm_exec_t
+/var/cache/multipathd(/.*)? system_u:object_r:lvm_metadata_t
+/usr/sbin/clvmd   --      system_u:object_r:clvmd_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/ntpd.fc policy-1.23.16/file_contexts/program/ntpd.fc
--- nsapolicy/file_contexts/program/ntpd.fc	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.16/file_contexts/program/ntpd.fc	2005-05-18 15:50:12.000000000 -0400
@@ -1,7 +1,7 @@
 /var/lib/ntp(/.*)?			system_u:object_r:ntp_drift_t
 /etc/ntp/data(/.*)?			system_u:object_r:ntp_drift_t
-/etc/ntp(d)?\.conf(.sv)?	--	system_u:object_r:net_conf_t
-/etc/ntp/step-tickers		--	system_u:object_r:net_conf_t
+/etc/ntp(d)?\.conf.*	--	system_u:object_r:net_conf_t
+/etc/ntp/step-tickers.*		--	system_u:object_r:net_conf_t
 /usr/sbin/ntpd			--	system_u:object_r:ntpd_exec_t
 /usr/sbin/ntpdate		--	system_u:object_r:ntpdate_exec_t
 /var/log/ntpstats(/.*)?			system_u:object_r:ntpd_log_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/traceroute.fc policy-1.23.16/file_contexts/program/traceroute.fc
--- nsapolicy/file_contexts/program/traceroute.fc	2005-05-16 11:28:12.000000000 -0400
+++ policy-1.23.16/file_contexts/program/traceroute.fc	2005-05-18 15:50:12.000000000 -0400
@@ -1,9 +1,6 @@
 # traceroute
 /bin/traceroute.*	--	system_u:object_r:traceroute_exec_t
 /bin/tracepath.*	--	system_u:object_r:traceroute_exec_t
-ifdef(`rdisc.te', `', `
-/sbin/rdisc		--	system_u:object_r:traceroute_exec_t
-')
 /usr/(s)?bin/traceroute.* --	system_u:object_r:traceroute_exec_t
 /usr/bin/lft		--	system_u:object_r:traceroute_exec_t
 /usr/bin/nmap		--	system_u:object_r:traceroute_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.23.16/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2005-05-07 00:41:12.000000000 -0400
+++ policy-1.23.16/file_contexts/types.fc	2005-05-18 15:50:12.000000000 -0400
@@ -58,7 +58,7 @@
 
 #
 # Mount points; do not relabel subdirectories, since
-# we don not want to change any removable media by default.
+# we do not want to change any removable media by default.
 /mnt(/[^/]*)?		-d	system_u:object_r:mnt_t
 /mnt/[^/]*/.*			<<none>>
 /media(/[^/]*)?		-d	system_u:object_r:mnt_t
@@ -262,7 +262,7 @@
 #
 /opt(/.*)?			system_u:object_r:usr_t
 /opt/.*/lib(64)?(/.*)?				system_u:object_r:lib_t
-/opt/.*/lib(64)?/.*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
+/opt/.*/.*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
 /opt/.*/libexec(/.*)?	system_u:object_r:bin_t
 /opt/.*/bin(/.*)?		system_u:object_r:bin_t
 /opt/.*/sbin(/.*)?		system_u:object_r:sbin_t
@@ -357,6 +357,7 @@
 
 # nvidia share libraries
 /usr(/.*)?/nvidia/.*\.so(\..*)?	-- system_u:object_r:texrel_shlib_t
+/usr/lib(64)?(/.*)?/libnvidia.*\.so(\.[^/]*)*	--	system_u:object_r:texrel_shlib_t
 /usr/X11R6/lib/libXvMCNVIDIA\.so.* 	-- system_u:object_r:texrel_shlib_t
 
 # libGL
@@ -383,6 +384,9 @@
 /usr/local/src(/.*)?		system_u:object_r:src_t
 /usr/local/man(/.*)?		system_u:object_r:man_t
 /usr/local/.*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
+/usr(/local)?/lib/wine/.*\.so   --	system_u:object_r:texrel_shlib_t
+/usr(/local)?/lib/libfame-.*\.so.*    --	system_u:object_r:texrel_shlib_t
+
 
 #
 # /usr/X11R6/man
@@ -440,14 +444,23 @@
 #
 # Lost and found directories.
 #
-/lost\+found(/.*)?		system_u:object_r:lost_found_t
-/usr/lost\+found(/.*)?		system_u:object_r:lost_found_t
-/boot/lost\+found(/.*)?		system_u:object_r:lost_found_t
-HOME_ROOT/lost\+found(/.*)?	system_u:object_r:lost_found_t
-/var/lost\+found(/.*)?		system_u:object_r:lost_found_t
-/tmp/lost\+found(/.*)?		system_u:object_r:lost_found_t
-/usr/local/lost\+found(/.*)?	system_u:object_r:lost_found_t
-
+/lost\+found		-d	system_u:object_r:lost_found_t
+/lost\+found/.*			<<none>>
+/usr/lost\+found	-d	system_u:object_r:lost_found_t
+/usr/lost\+found/.*		<<none>>
+/boot/lost\+found	-d	system_u:object_r:lost_found_t
+/boot/lost\+found/.*		<<none>>
+HOME_ROOT/lost\+found	-d	system_u:object_r:lost_found_t
+HOME_ROOT/lost\+found/.*	<<none>>
+/var/lost\+found	-d	system_u:object_r:lost_found_t
+/var/lost\+found/.*		<<none>>
+/tmp/lost\+found	-d	system_u:object_r:lost_found_t
+/tmp/lost\+found/.*		<<none>>
+/var/tmp/lost\+found	-d	system_u:object_r:lost_found_t
+/var/tmp/lost\+found/.*		<<none>>
+/usr/local/lost\+found	-d	system_u:object_r:lost_found_t
+/usr/local/lost\+found/.*	<<none>>
+  
 #
 # system localization
 #
diff --exclude-from=exclude -N -u -r nsapolicy/macros/admin_macros.te policy-1.23.16/macros/admin_macros.te
--- nsapolicy/macros/admin_macros.te	2005-04-27 10:28:54.000000000 -0400
+++ policy-1.23.16/macros/admin_macros.te	2005-05-18 15:50:12.000000000 -0400
@@ -203,14 +203,9 @@
 # policy management infrastructure is in place so that an administrator
 # cannot directly manipulate policy files with arbitrary programs.
 #
-allow $1 policy_src_t:file create_file_perms;
-allow $1 policy_src_t:lnk_file create_lnk_perms;
-allow $1 policy_src_t:dir create_dir_perms;
-
-# Violates the goal of limiting write access to checkpolicy.
-# But presently necessary for installing the file_contexts file.
-create_dir_file($1, policy_config_t)
-r_dir_file($1, selinux_config_t)
+allow $1 secadmfile:file { relabelto relabelfrom create_file_perms };
+allow $1 secadmfile:lnk_file { relabelto relabelfrom create_lnk_perms };
+allow $1 secadmfile:dir { relabelto relabelfrom create_dir_perms };
 
 # Set an exec context, e.g. for runcon.
 can_setexec($1)
@@ -218,9 +213,5 @@
 # Set a context other than the default one for newly created files.
 can_setfscreate($1)
 
-create_dir_file($1, { default_context_t file_context_t selinux_config_t })
-
-allow $1 { default_context_t file_context_t selinux_config_t }:file { relabelfrom relabelto };
-
 ') 
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.23.16/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2005-05-02 14:06:57.000000000 -0400
+++ policy-1.23.16/macros/base_user_macros.te	2005-05-19 10:43:06.000000000 -0400
@@ -68,14 +68,21 @@
 allow $1_t dri_device_t:chr_file getattr;
 dontaudit $1_t dri_device_t:chr_file rw_file_perms;
 
-file_browse_domain($1_t)
+# Supress ls denials:
+# getattr() - ls -l
+# search_dir() - symlink path resolution
+# read_dir() - deep ls: ls parent/...
+
+dontaudit_getattr($1_t)
+dontaudit_search_dir($1_t)
+dontaudit_read_dir($1_t)
 
 # allow ptrace
 can_ptrace($1_t, $1_t)
 
 # Create, access, and remove files in home directory.
 file_type_auto_trans($1_t, $1_home_dir_t, $1_home_t)
-allow $1_t $1_home_t:notdevfile_class_set { relabelfrom relabelto };
+allow $1_t $1_home_t:{ notdevfile_class_set dir } { relabelfrom relabelto };
 can_setfscreate($1_t)
 
 allow $1_t autofs_t:dir { search getattr };
@@ -191,6 +198,8 @@
 ifdef(`mplayer.te', `mplayer_domains($1)')
 ifdef(`gift.te', `gift_domains($1)')
 
+fontconfig_domain($1)
+
 # Instantiate a derived domain for user cron jobs.
 ifdef(`crond.te', `crond_domain($1)')
 
@@ -350,6 +359,9 @@
 allow $1_t default_t:notdevfile_class_set r_file_perms;
 }
 
+# Read mime types
+read_fonts($1_t, $1)
+
 read_sysctl($1_t);
 
 #
diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te policy-1.23.16/macros/global_macros.te
--- nsapolicy/macros/global_macros.te	2005-05-07 00:41:12.000000000 -0400
+++ policy-1.23.16/macros/global_macros.te	2005-05-18 15:50:12.000000000 -0400
@@ -156,7 +156,6 @@
 r_dir_file($1, locale_t)
 ')
 
-
 ###################################
 #
 # access_terminal(domain, typeprefix)
@@ -620,23 +619,25 @@
 allow $1_t etc_t:dir r_dir_perms;
 ')
 
-# Do not flood message log, if the user does a browse
-define(`file_browse_domain', `
+# Dontaudit macros to prevent flooding the log
 
-# Regular files/directories that are not security sensitive
+define(`dontaudit_getattr', `
 dontaudit $1 file_type - secure_file_type:dir_file_class_set getattr; 
-dontaudit $1 file_type - secure_file_type:dir { read search };
-
-# /dev
-dontaudit $1 dev_fs:dir_file_class_set getattr;
-dontaudit $1 dev_fs:dir { read search };
-
-# /proc
-dontaudit $1 sysctl_t:dir_file_class_set getattr;
-dontaudit $1 proc_fs:dir { read search };
-
-')dnl end file_browse_domain
-
+dontaudit $1 unlabeled_t:dir_file_class_set getattr;
+dontaudit $1 { fs_type proc_fs dev_fs sysctl_type }:dir_file_class_set getattr;
+')dnl end dontaudit_getattr 
+
+define(`dontaudit_search_dir', `
+dontaudit $1 file_type - secure_file_type:dir search;
+dontaudit $1 unlabeled_t:dir search;
+dontaudit $1 { fs_type proc_fs dev_fs sysctl_type }:dir search;
+')dnl end dontaudit_search_dir
+
+define(`dontaudit_read_dir', `
+dontaudit $1 file_type - secure_file_type:dir read;
+dontaudit $1 unlabeled_t:dir read;
+dontaudit $1 { fs_type proc_fs dev_fs sysctl_type }:dir read;
+')dnl end dontaudit_read_dir
 
 # Define legacy_domain  for legacy binaries (java)
 # "legacy" binary == lacks PT_GNU_STACK header, i.e. built with an old
@@ -762,3 +763,12 @@
 ')
 
 ')dnl end unconfined_domain
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+# read_fonts(domain, role_prefix) - 
+#         allow domain to read fonts, optionally per/user
+#  
+define(`read_fonts', `
+r_dir_file($1, fonts_t)
+')
+
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/apache_macros.te policy-1.23.16/macros/program/apache_macros.te
--- nsapolicy/macros/program/apache_macros.te	2005-04-27 10:28:54.000000000 -0400
+++ policy-1.23.16/macros/program/apache_macros.te	2005-05-18 15:50:12.000000000 -0400
@@ -101,7 +101,7 @@
 # Allow the scripts to read, read/write, append to the specified directories
 # or files
 ############################################################################
-r_dir_file(httpd_$1_script_t, fonts_t)
+read_fonts(httpd_$1_script_t)
 r_dir_file(httpd_$1_script_t, httpd_$1_script_ro_t)
 create_dir_file(httpd_$1_script_t, httpd_$1_script_rw_t)
 ra_dir_file(httpd_$1_script_t, httpd_$1_script_ra_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/fontconfig_macros.te policy-1.23.16/macros/program/fontconfig_macros.te
--- nsapolicy/macros/program/fontconfig_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.23.16/macros/program/fontconfig_macros.te	2005-05-18 15:50:12.000000000 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gift_macros.te policy-1.23.16/macros/program/gift_macros.te
--- nsapolicy/macros/program/gift_macros.te	2005-04-27 10:28:54.000000000 -0400
+++ policy-1.23.16/macros/program/gift_macros.te	2005-05-18 15:50:12.000000000 -0400
@@ -17,9 +17,10 @@
 domain_auto_trans($1_t, gift_exec_t, $1_gift_t)
 role $1_r types $1_gift_t;
 
-# X access, Home files 
+# X access, Home files, /tmp
 x_client_domain($1_gift, $1)
 home_domain($1, gift)
+tmp_domain($1_gift)
 
 uses_shlib($1_gift_t)
 read_locale($1_gift_t)
@@ -32,6 +33,7 @@
 
 # Self permissions
 allow $1_gift_t self:process getsched;
+allow $1_gift_t self:fifo_file { read write };
 
 # Fonts, icons
 r_dir_file($1_gift_t, usr_t)
@@ -104,7 +106,7 @@
 home_domain_access($1_giftd_t, $1, gift)
 	
 # Allow networking
-allow $1_giftd_t port_t:tcp_socket name_bind;
+allow $1_giftd_t port_t:tcp_socket { name_bind name_connect };
 allow $1_giftd_t port_t:udp_socket name_bind;
 can_network_server($1_giftd_t)
 can_network_client($1_giftd_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gpg_agent_macros.te policy-1.23.16/macros/program/gpg_agent_macros.te
--- nsapolicy/macros/program/gpg_agent_macros.te	2005-05-16 11:28:12.000000000 -0400
+++ policy-1.23.16/macros/program/gpg_agent_macros.te	2005-05-18 15:50:12.000000000 -0400
@@ -88,7 +88,7 @@
 allow { $1_gpg_agent_t $1_gpg_pinentry_t } xdm_t:fd use;
 ')dnl end ig xdm.te
 
-r_dir_file($1_gpg_pinentry_t, fonts_t)
+read_fonts($1_gpg_pinentry_t, $1)
 # read kde font cache
 allow $1_gpg_pinentry_t usr_t:file { getattr read };
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/irc_macros.te policy-1.23.16/macros/program/irc_macros.te
--- nsapolicy/macros/program/irc_macros.te	2005-04-27 10:28:55.000000000 -0400
+++ policy-1.23.16/macros/program/irc_macros.te	2005-05-18 15:50:12.000000000 -0400
@@ -66,7 +66,7 @@
 dontaudit $1_irc_t var_run_t:dir search;
 
 # allow utmp access
-allow $1_irc_t initrc_var_run_t:file read;
+allow $1_irc_t initrc_var_run_t:file { getattr read };
 dontaudit $1_irc_t initrc_var_run_t:file lock;
 
 # access files under /tmp
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/java_macros.te policy-1.23.16/macros/program/java_macros.te
--- nsapolicy/macros/program/java_macros.te	2005-04-27 10:28:55.000000000 -0400
+++ policy-1.23.16/macros/program/java_macros.te	2005-05-18 15:50:12.000000000 -0400
@@ -4,7 +4,7 @@
 # Macros for javaplugin (java plugin) domains.
 #
 #
-# javaplugin_domain(domain_prefix, user)
+# javaplugin_domain(domain_prefix, role)
 #
 # Define a derived domain for the javaplugin program when executed by
 # a web browser.  
@@ -44,7 +44,8 @@
 allow $1_javaplugin_t sysctl_vm_t:dir search;
 
 tmp_domain($1_javaplugin)
-r_dir_file($1_javaplugin_t,{ fonts_t usr_t etc_t })
+read_fonts($1_javaplugin_t, $2)
+r_dir_file($1_javaplugin_t,{ usr_t etc_t })
 
 # Search bin directory under javaplugin for javaplugin executable
 allow $1_javaplugin_t bin_t:dir search;
@@ -91,7 +92,4 @@
 dontaudit $1_javaplugin_t tmpfs_t:file { execute read write };
 dontaudit $1_javaplugin_t $1_home_t:file { execute setattr };
 
-# Do not audit read/getattr of .fonts-cache-1
-dontaudit $1_javaplugin_t $1_home_t:file { read getattr };
-
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.23.16/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2005-05-02 14:06:57.000000000 -0400
+++ policy-1.23.16/macros/program/mozilla_macros.te	2005-05-18 15:50:12.000000000 -0400
@@ -16,7 +16,8 @@
 # provided separately in domains/program/mozilla.te. 
 #
 define(`mozilla_domain',`
-type $1_mozilla_t, domain, web_client_domain, privlog;
+
+type $1_mozilla_t, domain, web_client_domain, nscd_client_domain, privlog;
 
 # Type transition
 if (! disable_mozilla_trans) {
@@ -28,8 +29,12 @@
 home_domain($1, mozilla)
 x_client_domain($1_mozilla, $1)
 
-# Browse files
-file_browse_domain($1_mozilla_t)
+# GNOME Open/Save As dialogs
+dontaudit_getattr($1_mozilla_t)
+dontaudit_search_dir($1_mozilla_t)
+
+# Look for plugins 
+allow $1_mozilla_t bin_t:dir { getattr read search };
 
 can_network_client($1_mozilla_t)
 allow $1_mozilla_t ftp_port_t:tcp_socket name_connect;
@@ -54,6 +59,12 @@
 allow $1_mozilla_t self:process { fork signal_perms setrlimit setsched getsched };
 
 allow $1_mozilla_t usr_t:{ lnk_file file } { getattr read };
+
+# Access /proc
+allow $1_mozilla_t proc_t:dir search;
+allow $1_mozilla_t proc_t:file { getattr read };
+allow $1_mozilla_t proc_t:lnk_file read;
+
 allow $1_mozilla_t var_lib_t:file { getattr read };
 allow $1_mozilla_t { random_device_t urandom_device_t }:chr_file { getattr ioctl read };
 allow $1_mozilla_t self:socket create_socket_perms;
@@ -66,8 +77,6 @@
 can_exec($1_mozilla_t, bin_t)
 allow $1_mozilla_t bin_t:lnk_file read;
 allow $1_mozilla_t device_t:dir r_dir_perms;
-allow $1_mozilla_t proc_t:file { getattr read };
-allow $1_mozilla_t proc_t:lnk_file read;
 allow $1_mozilla_t self:dir search;
 allow $1_mozilla_t self:lnk_file read;
 r_dir_file($1_mozilla_t, proc_net_t)
@@ -87,20 +96,6 @@
 # Execute downloaded programs.
 can_exec($1_mozilla_t, $1_mozilla_tmp_t)
 
-# Use printer
-ifdef(`lpr.te', `
-domain_auto_trans($1_mozilla_t, lpr_exec_t, $1_lpr_t)
-
-# Print document
-allow $1_lpr_t $1_mozilla_tmp_t:file rw_file_perms;
-
-# Suppress history.fop denial
-dontaudit $1_lpr_t $1_mozilla_home_t:file { read write };
-
-dontaudit $1_lpr_t $1_mozilla_t:tcp_socket { read write };
-dontaudit $1_lpr_t $1_mozilla_t:unix_stream_socket { read write };
-')
-
 # ORBit sockets
 file_type_auto_trans($1_mozilla_t, $1_tmp_t, $1_mozilla_tmp_t)
 can_unix_connect($1_t, $1_mozilla_t)
@@ -144,6 +139,21 @@
 javaplugin_domain($1_mozilla, $1)
 ')
 
+
+# Use printer
+ifdef(`lpr.te', `
+domain_auto_trans($1_mozilla_t, lpr_exec_t, $1_lpr_t)
+
+# Print document
+allow $1_lpr_t $1_mozilla_tmp_t:file rw_file_perms;
+
+# Suppress history.fop denial
+dontaudit $1_lpr_t $1_mozilla_home_t:file { read write };
+
+dontaudit $1_lpr_t $1_mozilla_t:tcp_socket { read write };
+dontaudit $1_lpr_t $1_mozilla_t:unix_stream_socket { read write };
+')
+
 # Mplayer plugin
 ifdef(`mplayer.te', `
 domain_auto_trans($1_mozilla_t, mplayer_exec_t, $1_mplayer_t)
@@ -151,9 +161,10 @@
 # Read mozilla content in /tmp
 r_dir_file($1_mplayer_t, $1_mozilla_tmp_t);
 
-# FIXME: why does it need this?
+# Suppress history.fop denial
 dontaudit $1_mplayer_t $1_mozilla_home_t:file write;
-allow $1_mplayer_t $1_mozilla_t:unix_stream_socket { read write };
+
+dontaudit $1_mplayer_t $1_mozilla_t:unix_stream_socket { read write };
 ')dnl end if mplayer.te  
 
 if (allow_execmem) {
@@ -162,6 +173,7 @@
 if (allow_execmod) {
 allow $1_mozilla_t texrel_shlib_t:file execmod;
 }
+
 dbusd_client(system, $1_mozilla)
 ifdef(`apache.te', `
 ifelse($1, sysadm, `', `
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mplayer_macros.te policy-1.23.16/macros/program/mplayer_macros.te
--- nsapolicy/macros/program/mplayer_macros.te	2005-04-27 10:28:55.000000000 -0400
+++ policy-1.23.16/macros/program/mplayer_macros.te	2005-05-18 15:50:12.000000000 -0400
@@ -6,9 +6,9 @@
 # mplayer_domains(user) declares domains for mplayer, gmplayer,
 # and mencoder
 
-##############################################
-#    mplayer_common(user, mplayer domain)    #
-##############################################
+#####################################################
+#    mplayer_common(role_prefix, mplayer_domain)    #
+#####################################################
 
 define(`mplayer_common',`
 
@@ -62,32 +62,32 @@
 }
 ')
 
-############################
-#  mplayer_domain(user)    #
-############################
+###################################
+#  mplayer_domain(role_prefix)    #
+###################################
 
 define(`mplayer_domain',`
 
-type $1_mplayer_t, domain;
+type $1_mplayer_t, domain, nscd_client_domain;
 
 # Type transition
 domain_auto_trans($1_t, mplayer_exec_t, $1_mplayer_t)
 role $1_r types $1_mplayer_t;
 
-# Home access, X access, Browse files
+# Home access, X access
 home_domain($1, mplayer)
 x_client_domain($1_mplayer, $1)
-file_browse_domain($1_mplayer_t)
 
 # Mplayer common stuff
 mplayer_common($1, mplayer)
 
 # Fork 
 allow $1_mplayer_t self:process { fork signal_perms getsched };
+allow $1_mplayer_t self:fifo_file rw_file_perms;
 
 # Audio, alsa.conf
 allow $1_mplayer_t sound_device_t:chr_file rw_file_perms;
-allow $1_mplayer_t etc_t:file read;
+allow $1_mplayer_t etc_t:file { getattr read };
 
 # RTC clock 
 allow $1_mplayer_t clock_device_t:chr_file { ioctl read };
@@ -101,11 +101,30 @@
 allow $1_mplayer_t $1_mplayer_tmpfs_t:file execute;
 }
 
+#======gmplayer gui==========#
+# File dialogs
+dontaudit_getattr($1_mplayer_t)
+dontaudit_read_dir($1_mplayer_t)
+dontaudit_search_dir($1_mplayer_t)
+
+# Unfortunately the ancient file dialog starts in /
+allow $1_mplayer_t home_root_t:dir read;
+
+# Read /etc/mtab
+allow $1_mplayer_t etc_runtime_t:file { read getattr };
+
+# Run bash/sed (??) 
+allow $1_mplayer_t bin_t:dir search;
+allow $1_mplayer_t bin_t:lnk_file read;
+can_exec($1_mplayer_t, bin_t)
+can_exec($1_mplayer_t, shell_exec_t)
+#============================#
+
 ') dnl end mplayer_domain
 
-############################
-#  mencoder_domain(user)   #
-############################
+###################################
+#  mencoder_domain(role_prefix)   #
+###################################
 
 define(`mencoder_domain',`
 
@@ -125,7 +144,7 @@
 ') dnl end mencoder_domain
 
 #############################
-#  mplayer_domains(user)    #
+#  mplayer_domains(role)    #
 #############################
 
 define(`mplayer_domains', `
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/userhelper_macros.te policy-1.23.16/macros/program/userhelper_macros.te
--- nsapolicy/macros/program/userhelper_macros.te	2005-04-27 10:28:55.000000000 -0400
+++ policy-1.23.16/macros/program/userhelper_macros.te	2005-05-18 15:50:12.000000000 -0400
@@ -96,7 +96,7 @@
 allow $1_userhelper_t fs_t:filesystem getattr;
 
 # for some PAM modules and for cwd
-dontaudit $1_userhelper_t { home_root_t home_type }:dir search;
+allow $1_userhelper_t { home_root_t $1_home_dir_t }:dir search;
 
 allow $1_userhelper_t proc_t:dir search;
 allow $1_userhelper_t proc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/x_client_macros.te policy-1.23.16/macros/program/x_client_macros.te
--- nsapolicy/macros/program/x_client_macros.te	2005-04-27 10:28:55.000000000 -0400
+++ policy-1.23.16/macros/program/x_client_macros.te	2005-05-18 15:50:12.000000000 -0400
@@ -74,7 +74,7 @@
 allow $1_t self:shm create_shm_perms;
 
 # allow X client to read all font files
-r_dir_file($1_t, fonts_t)
+read_fonts($1_t, $2)
 
 # Allow connections to X server.
 ifdef(`xserver.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/Makefile policy-1.23.16/Makefile
--- nsapolicy/Makefile	2005-05-16 11:28:11.000000000 -0400
+++ policy-1.23.16/Makefile	2005-05-18 15:50:12.000000000 -0400
@@ -220,8 +220,8 @@
 $(FC): $(ALL_TUNABLES) tmp/program_used_flags.te $(FCFILES) domains/program domains/misc file_contexts/program file_contexts/misc users /etc/passwd
 	@echo "Building file contexts files..."
 	@m4 $(M4PARAM) $(ALL_TUNABLES) tmp/program_used_flags.te $(FCFILES) > $@.tmp
-	@grep -v -e HOME -e ROLE $@.tmp > $@
-	@grep -e HOME -e ROLE $@.tmp  > $(HOMEDIR_TEMPLATE)
+	@grep -v -e HOME -e ROLE -e USER $@.tmp > $@
+	@grep -e HOME -e ROLE -e USER $@.tmp  > $(HOMEDIR_TEMPLATE)
 	@-rm $@.tmp
 
 # Create a tags-file for the policy:
diff --exclude-from=exclude -N -u -r nsapolicy/man/man8/ftpd_selinux.8 policy-1.23.16/man/man8/ftpd_selinux.8
--- nsapolicy/man/man8/ftpd_selinux.8	2005-03-11 15:31:07.000000000 -0500
+++ policy-1.23.16/man/man8/ftpd_selinux.8	2005-05-18 15:50:12.000000000 -0400
@@ -43,7 +43,7 @@
 .TP
 setsebool -P ftpd_disable_trans 1
 .br
-system vsftpd restart
+service vsftpd restart
 .TP
 system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
 .SH AUTHOR	
diff --exclude-from=exclude -N -u -r nsapolicy/man/man8/httpd_selinux.8 policy-1.23.16/man/man8/httpd_selinux.8
--- nsapolicy/man/man8/httpd_selinux.8	2005-05-02 14:06:57.000000000 -0400
+++ policy-1.23.16/man/man8/httpd_selinux.8	2005-05-18 15:50:12.000000000 -0400
@@ -101,7 +101,7 @@
 
 setsebool -P httpd_disable_trans 1
 .br
-system httpd restart
+service httpd restart
 
 .TP
 system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
diff --exclude-from=exclude -N -u -r nsapolicy/man/man8/kerberos_selinux.8 policy-1.23.16/man/man8/kerberos_selinux.8
--- nsapolicy/man/man8/kerberos_selinux.8	2005-02-24 14:51:10.000000000 -0500
+++ policy-1.23.16/man/man8/kerberos_selinux.8	2005-05-18 15:50:12.000000000 -0400
@@ -16,11 +16,11 @@
 
 setsebool -P krb5kdc_disable_trans 1
 .br
-system krb5kdc restart
+service krb5kdc restart
 .br
 setsebool -P kadmind_disable_trans booleans 1
 .br
-system kadmind restart
+service kadmind restart
 
 .TP
 system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
diff --exclude-from=exclude -N -u -r nsapolicy/man/man8/named_selinux.8 policy-1.23.16/man/man8/named_selinux.8
--- nsapolicy/man/man8/named_selinux.8	2005-02-24 14:51:10.000000000 -0500
+++ policy-1.23.16/man/man8/named_selinux.8	2005-05-18 15:50:12.000000000 -0400
@@ -17,7 +17,7 @@
 .TP
 setsebool -P named_disable_trans 1
 .br
-system named restart
+service named restart
 .TP
 system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
 .SH AUTHOR	
diff --exclude-from=exclude -N -u -r nsapolicy/man/man8/rsync_selinux.8 policy-1.23.16/man/man8/rsync_selinux.8
--- nsapolicy/man/man8/rsync_selinux.8	2005-02-24 14:51:10.000000000 -0500
+++ policy-1.23.16/man/man8/rsync_selinux.8	2005-05-18 15:50:12.000000000 -0400
@@ -25,7 +25,7 @@
 .TP
 setsebool -P rsync_disable_trans 1
 .br
-system xinetd restart
+service xinetd restart
 .TP
 system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
 .SH AUTHOR	
diff --exclude-from=exclude -N -u -r nsapolicy/man/man8/samba_selinux.8 policy-1.23.16/man/man8/samba_selinux.8
--- nsapolicy/man/man8/samba_selinux.8	2005-02-24 14:51:10.000000000 -0500
+++ policy-1.23.16/man/man8/samba_selinux.8	2005-05-18 15:50:12.000000000 -0400
@@ -41,7 +41,7 @@
 
 setsebool -P smbd_disable_trans 1
 .br
-system smb restart
+service smb restart
 .TP
 system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
 .SH AUTHOR	
diff --exclude-from=exclude -N -u -r nsapolicy/net_contexts policy-1.23.16/net_contexts
--- nsapolicy/net_contexts	2005-05-16 11:28:11.000000000 -0400
+++ policy-1.23.16/net_contexts	2005-05-18 15:50:12.000000000 -0400
@@ -106,10 +106,8 @@
 portcon udp 517 system_u:object_r:ktalkd_port_t
 portcon udp 518 system_u:object_r:ktalkd_port_t
 ')
-ifdef(`cups.te', `
 portcon tcp 631 system_u:object_r:ipp_port_t
 portcon udp 631 system_u:object_r:ipp_port_t
-')
 portcon tcp 88 system_u:object_r:kerberos_port_t
 portcon udp 88 system_u:object_r:kerberos_port_t
 portcon tcp 464 system_u:object_r:kerberos_admin_port_t
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/assert.te policy-1.23.16/targeted/assert.te
--- nsapolicy/targeted/assert.te	2005-04-27 10:28:56.000000000 -0400
+++ policy-1.23.16/targeted/assert.te	2005-05-19 11:37:34.000000000 -0400
@@ -25,7 +25,7 @@
 neverallow { domain -unrestricted } unconfined_t:process ~sigchld;
 
 # Confined domains must never see unconfined domain's /proc/pid entries.
-neverallow { domain -unrestricted } unconfined_t:dir { getattr search };
+neverallow { domain -unrestricted -snmpd_t } unconfined_t:dir { getattr search };
 
 #
 # Verify that every type that can be entered by
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/unconfined.te policy-1.23.16/targeted/domains/unconfined.te
--- nsapolicy/targeted/domains/unconfined.te	2005-05-02 14:06:57.000000000 -0400
+++ policy-1.23.16/targeted/domains/unconfined.te	2005-05-18 15:50:12.000000000 -0400
@@ -77,3 +77,8 @@
 
 # allow reading of default file context
 bool read_default_t true;
+
+if (allow_execmem) {
+allow domain self:process execmem;
+}
+
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.23.16/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.16/tunables/distro.tun	2005-05-18 15:50:12.000000000 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.23.16/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2005-04-14 15:01:54.000000000 -0400
+++ policy-1.23.16/tunables/tunable.tun	2005-05-18 15:50:12.000000000 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/types/device.te policy-1.23.16/types/device.te
--- nsapolicy/types/device.te	2005-04-27 10:28:56.000000000 -0400
+++ policy-1.23.16/types/device.te	2005-05-18 15:50:12.000000000 -0400
@@ -10,7 +10,7 @@
 #
 # device_t is the type of /dev.
 #
-type device_t, file_type, dev_fs;
+type device_t, file_type, mount_point, dev_fs;
 
 #
 # null_device_t is the type of /dev/null.
diff --exclude-from=exclude -N -u -r nsapolicy/types/devpts.te policy-1.23.16/types/devpts.te
--- nsapolicy/types/devpts.te	2005-04-27 10:28:56.000000000 -0400
+++ policy-1.23.16/types/devpts.te	2005-05-18 15:50:12.000000000 -0400
@@ -16,6 +16,6 @@
 # devpts_t is the type of the devpts file system and 
 # the type of the root directory of the file system.
 #
-type devpts_t, fs_type;
+type devpts_t, mount_point, fs_type;
 
 
diff --exclude-from=exclude -N -u -r nsapolicy/types/file.te policy-1.23.16/types/file.te
--- nsapolicy/types/file.te	2005-05-07 00:41:13.000000000 -0400
+++ policy-1.23.16/types/file.te	2005-05-18 15:50:12.000000000 -0400
@@ -23,37 +23,37 @@
 type eventpollfs_t, fs_type;
 type futexfs_t, fs_type;
 type bdev_t, fs_type;
-type usbfs_t, fs_type;
+type usbfs_t, mount_point, fs_type;
 type nfsd_fs_t, fs_type;
 type rpc_pipefs_t, fs_type;
-type binfmt_misc_fs_t, fs_type;
+type binfmt_misc_fs_t, mount_point, fs_type;
 
 #
 # file_t is the default type of a file that has not yet been
 # assigned an extended attribute (EA) value (when using a filesystem
 # that supports EAs).
 #
-type file_t, file_type, sysadmfile;
+type file_t, file_type, mount_point, sysadmfile;
 
 # default_t is the default type for files that do not
 # match any specification in the file_contexts configuration
 # other than the generic /.* specification.
-type default_t, file_type, sysadmfile;
+type default_t, file_type, mount_point, sysadmfile;
 
 #
 # root_t is the type for the root directory.
 #
-type root_t, file_type, sysadmfile;
+type root_t, file_type, mount_point, sysadmfile;
 
 #
 # mnt_t is the type for mount points such as /mnt/cdrom
-type mnt_t, file_type, sysadmfile;
+type mnt_t, file_type, mount_point, sysadmfile;
 
 #
 # home_root_t is the type for the directory where user home directories
 # are created
 #
-type home_root_t, file_type, sysadmfile;
+type home_root_t, file_type, mount_point, sysadmfile;
 
 #
 # lost_found_t is the type for the lost+found directories.
@@ -64,7 +64,7 @@
 # boot_t is the type for files in /boot,
 # including the kernel.
 #
-type boot_t, file_type, sysadmfile;
+type boot_t, file_type, mount_point, sysadmfile;
 # system_map_t is for the system.map files in /boot
 type system_map_t, file_type, sysadmfile;
 
@@ -77,7 +77,7 @@
 #
 # tmp_t is the type of /tmp and /var/tmp.
 #
-type tmp_t, file_type, sysadmfile, tmpfile;
+type tmp_t, file_type, mount_point, sysadmfile, tmpfile;
 
 #
 # etc_t is the type of the system etc directories.
@@ -171,17 +171,17 @@
 #
 # usr_t is the type for /usr.
 #
-type usr_t, file_type, sysadmfile;
+type usr_t, file_type, mount_point, sysadmfile;
 
 #
 # src_t is the type of files in the system src directories.
 #
-type src_t, file_type, sysadmfile;
+type src_t, file_type, mount_point, sysadmfile;
 
 #
 # var_t is the type for /var.
 #
-type var_t, file_type,  sysadmfile;
+type var_t, file_type, mount_point, sysadmfile;
 
 #
 # Types for subdirectories of /var.
@@ -190,7 +190,7 @@
 type var_log_t, file_type, sysadmfile, logfile;
 type faillog_t, file_type, sysadmfile, logfile;
 type var_lock_t, file_type, sysadmfile, lockfile;
-type var_lib_t, file_type, sysadmfile;
+type var_lib_t, mount_point, file_type, sysadmfile;
 # for /var/{spool,lib}/texmf index files
 type tetex_data_t, file_type, sysadmfile, tmpfile;
 type var_spool_t, file_type, sysadmfile, tmpfile;
@@ -203,7 +203,7 @@
 type lastlog_t, file_type, sysadmfile, logfile;
 
 # Type for /var/lib/nfs.
-type var_lib_nfs_t, file_type, sysadmfile, usercanread;
+type var_lib_nfs_t, file_type, mount_point, sysadmfile, usercanread;
 
 #
 # wtmp_t is the type of /var/log/wtmp.
@@ -275,9 +275,9 @@
 # Allow the pty to be associated with the file system.
 allow devpts_t self:filesystem associate;
 
-type tmpfs_t, file_type, sysadmfile, fs_type;
-allow { tmpfs_t tmpfile } tmpfs_t:filesystem associate;
-allow tmpfile tmp_t:filesystem associate;
+type tmpfs_t, file_type, mount_point, sysadmfile, fs_type;
+allow { logfile tmpfs_t tmpfile home_type } tmpfs_t:filesystem associate;
+allow { logfile tmpfile home_type } tmp_t:filesystem associate;
 ifdef(`distro_redhat', `
 allow { dev_fs ttyfile } { tmpfs_t tmp_t }:filesystem associate;
 ')
@@ -285,10 +285,10 @@
 type autofs_t, fs_type, noexattrfile, sysadmfile;
 allow autofs_t self:filesystem associate;
 
-type usbdevfs_t, fs_type, noexattrfile, sysadmfile;
+type usbdevfs_t, fs_type, mount_point, noexattrfile, sysadmfile;
 allow usbdevfs_t self:filesystem associate;
 
-type sysfs_t, fs_type,  sysadmfile;
+type sysfs_t, mount_point, fs_type,  sysadmfile;
 allow sysfs_t self:filesystem associate;
 
 type iso9660_t, fs_type, noexattrfile, sysadmfile;
diff --exclude-from=exclude -N -u -r nsapolicy/types/network.te policy-1.23.16/types/network.te
--- nsapolicy/types/network.te	2005-05-02 14:06:57.000000000 -0400
+++ policy-1.23.16/types/network.te	2005-05-18 15:50:12.000000000 -0400
@@ -30,6 +30,7 @@
 type nmbd_port_t, port_type, reserved_port_type;
 type http_cache_port_t, port_type, reserved_port_type;
 type http_port_t, port_type, reserved_port_type;
+type ipp_port_t, port_type, reserved_port_type;
 
 allow web_client_domain { http_cache_port_t http_port_t }:tcp_socket name_connect;
 ifdef(`cyrus.te', `define(`use_pop')')
diff --exclude-from=exclude -N -u -r nsapolicy/types/nfs.te policy-1.23.16/types/nfs.te
--- nsapolicy/types/nfs.te	2005-04-27 10:28:56.000000000 -0400
+++ policy-1.23.16/types/nfs.te	2005-05-18 15:50:12.000000000 -0400
@@ -13,7 +13,7 @@
 # The nfs_*_t types are used for specific NFS
 # servers in net_contexts or net_contexts.mls.
 #
-type nfs_t, fs_type;
+type nfs_t, mount_point, fs_type;
 
 #
 # Allow NFS files to be associated with an NFS file system.
diff --exclude-from=exclude -N -u -r nsapolicy/types/procfs.te policy-1.23.16/types/procfs.te
--- nsapolicy/types/procfs.te	2005-04-27 10:28:56.000000000 -0400
+++ policy-1.23.16/types/procfs.te	2005-05-18 15:50:12.000000000 -0400
@@ -14,7 +14,7 @@
 # proc_mdstat_t is the type of /proc/mdstat.
 # proc_net_t is the type of /proc/net.
 #
-type proc_t, fs_type, proc_fs;
+type proc_t, fs_type, mount_point, proc_fs;
 type proc_kmsg_t, proc_fs;
 type proc_kcore_t, proc_fs;
 type proc_mdstat_t, proc_fs;
@@ -35,7 +35,7 @@
 # These types are applied to both the entries in
 # /proc/sys and the corresponding sysctl parameters.
 #
-type sysctl_t, sysctl_type;
+type sysctl_t, mount_point, sysctl_type;
 type sysctl_fs_t, sysctl_type;
 type sysctl_kernel_t, sysctl_type;
 type sysctl_modprobe_t, sysctl_type;
diff --exclude-from=exclude -N -u -r nsapolicy/types/security.te policy-1.23.16/types/security.te
--- nsapolicy/types/security.te	2005-04-27 10:28:56.000000000 -0400
+++ policy-1.23.16/types/security.te	2005-05-18 15:50:12.000000000 -0400
@@ -12,32 +12,32 @@
 # the permissions in the security class.  It is also
 # applied to selinuxfs inodes.
 #
-type security_t, fs_type;
+type security_t, mount_point, fs_type;
 
 #
 # policy_config_t is the type of /etc/security/selinux/*
 # the security server policy configuration.
 #
-type policy_config_t, file_type;
+type policy_config_t, file_type, secadmfile;
 
 #
 # policy_src_t is the type of the policy source
 # files.
 #
-type policy_src_t, file_type;
+type policy_src_t, file_type, secadmfile;
 
 
 #
 # default_context_t is the type applied to 
 # /etc/selinux/*/contexts/*
 #
-type default_context_t, file_type, login_contexts;
+type default_context_t, file_type, login_contexts, secadmfile;
 
 #
 # file_context_t is the type applied to 
 # /etc/selinux/*/contexts/files
 #
-type file_context_t, file_type;
+type file_context_t, file_type, secadmfile;
 
 #
 # no_access_t is the type for objects that should
@@ -49,6 +49,6 @@
 # selinux_config_t is the type applied to 
 # /etc/selinux/config
 #
-type selinux_config_t, file_type;
+type selinux_config_t, file_type, secadmfile;
 
 

--------------020007090500020309050608--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

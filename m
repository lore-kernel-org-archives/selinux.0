Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9CEucrT012134
	for <selinux@tycho.nsa.gov>; Tue, 12 Oct 2004 10:56:38 -0400 (EDT)
Received: from moss-huskies.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9CEtQsX009096
	for <selinux@tycho.nsa.gov>; Tue, 12 Oct 2004 14:55:26 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11) with ESMTP id i9CEvvS4002750
	for <selinux@tycho.nsa.gov>; Tue, 12 Oct 2004 10:57:57 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11/Submit) id i9CEvvKG002749
	for selinux@tycho.nsa.gov; Tue, 12 Oct 2004 10:57:57 -0400
Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9CDNVrT011493
	for <selinux@tycho.nsa.gov>; Tue, 12 Oct 2004 09:23:32 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9CDNSRg026691
	for <selinux@tycho.nsa.gov>; Tue, 12 Oct 2004 13:23:29 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Tue, 12 Oct 2004 15:23:26 +0200
Date: Tue, 12 Oct 2004 15:24:05 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: cleanup: remove superfluous braces
Message-Id: <20041012132404.GA5488@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--EuxKj2iCbKjpUGkD
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Another global search&replace:
remove all superfluous braces. IMO this makes the policy easier to read.
Patch is relative to my earlier cleanup patch.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="braces-cleanup.patch"
Content-Transfer-Encoding: quoted-printable

diff -urN orig/assert.te mod/assert.te
--- orig/assert.te	2004-09-11 14:31:46.000000000 +0200
+++ mod/assert.te	2004-10-12 15:14:12.000000000 +0200
@@ -131,8 +131,8 @@
 # and the ordinary passwd program without a transition to another domain.
 #
 ifdef(`passwd.te', `
-neverallow passwd_t ~{ passwd_exec_t }:file entrypoint;
-neverallow sysadm_passwd_t ~{ admin_passwd_exec_t }:file entrypoint;
+neverallow passwd_t ~passwd_exec_t:file entrypoint;
+neverallow sysadm_passwd_t ~admin_passwd_exec_t:file entrypoint;
 neverallow { passwd_t sysadm_passwd_t } ~{ bin_t sbin_t shell_exec_t ld_so=
_t }:file execute_no_trans;
 ')
=20
diff -urN orig/domains/program/checkpolicy.te mod/domains/program/checkpoli=
cy.te
--- orig/domains/program/checkpolicy.te	2004-09-16 15:07:08.000000000 +0200
+++ mod/domains/program/checkpolicy.te	2004-10-12 15:14:11.000000000 +0200
@@ -61,5 +61,5 @@
=20
 allow checkpolicy_t fs_t:filesystem getattr;
 allow checkpolicy_t console_device_t:chr_file { read write };
-allow checkpolicy_t init_t:fd { use };
-allow checkpolicy_t selinux_config_t:dir { search };
+allow checkpolicy_t init_t:fd use;
+allow checkpolicy_t selinux_config_t:dir search;
diff -urN orig/domains/program/crond.te mod/domains/program/crond.te
--- orig/domains/program/crond.te	2004-10-11 10:03:20.000000000 +0200
+++ mod/domains/program/crond.te	2004-10-12 15:14:11.000000000 +0200
@@ -68,7 +68,7 @@
 allow crond_t etc_t:file { getattr read };
 allow crond_t etc_t:lnk_file read;
=20
-allow crond_t default_t:dir { search };
+allow crond_t default_t:dir search;
=20
 # crond tries to search /root.  Not sure why.
 allow crond_t sysadm_home_dir_t:dir r_dir_perms;
@@ -184,14 +184,14 @@
 ifdef(`su.te', `
 su_restricted_domain(system_crond,system)
 role system_r types system_crond_su_t;
-allow system_crond_su_t crond_t:fifo_file { ioctl };
+allow system_crond_su_t crond_t:fifo_file ioctl;
 ')
 allow system_crond_t self:passwd rootok;
 #
 # prelink tells init to restart it self, we either need to allow or dontau=
dit
 #
-allow system_crond_t initctl_t:fifo_file { write };
-dontaudit userdomain system_crond_t:fd { use };
+allow system_crond_t initctl_t:fifo_file write;
+dontaudit userdomain system_crond_t:fd use;
=20
 r_dir_file(crond_t, selinux_config_t)
=20
diff -urN orig/domains/program/dmesg.te mod/domains/program/dmesg.te
--- orig/domains/program/dmesg.te	2004-09-11 14:31:46.000000000 +0200
+++ mod/domains/program/dmesg.te	2004-10-12 15:14:11.000000000 +0200
@@ -20,7 +20,7 @@
 allow dmesg_t self:capability sys_admin;
 allow dmesg_t kernel_t:system { syslog_read syslog_console syslog_mod };
 allow dmesg_t admin_tty_type:chr_file { getattr read write };
-allow dmesg_t sysadm_tty_device_t:chr_file { ioctl };
+allow dmesg_t sysadm_tty_device_t:chr_file ioctl;
 allow dmesg_t var_log_t:file { getattr write };
 read_locale(dmesg_t)
=20
diff -urN orig/domains/program/fsadm.te mod/domains/program/fsadm.te
--- orig/domains/program/fsadm.te	2004-09-25 19:52:49.000000000 +0200
+++ mod/domains/program/fsadm.te	2004-10-12 15:14:11.000000000 +0200
@@ -116,4 +116,4 @@
 # Access to /initrd devices
 allow fsadm_t { file_t unlabeled_t }:dir rw_dir_perms;
 allow fsadm_t { file_t unlabeled_t }:blk_file rw_file_perms;
-allow fsadm_t usbfs_t:dir { getattr };
+allow fsadm_t usbfs_t:dir getattr;
diff -urN orig/domains/program/hostname.te mod/domains/program/hostname.te
--- orig/domains/program/hostname.te	2004-09-30 15:55:41.000000000 +0200
+++ mod/domains/program/hostname.te	2004-10-12 15:14:11.000000000 +0200
@@ -14,7 +14,7 @@
 allow hostname_t { user_tty_type admin_tty_type }:chr_file { getattr read =
write };
 read_locale(hostname_t)
 allow hostname_t userdomain:fd use;
-dontaudit hostname_t kernel_t:fd { use };
+dontaudit hostname_t kernel_t:fd use;
 allow hostname_t net_conf_t:file { getattr read };
 allow hostname_t self:unix_stream_socket create_stream_socket_perms;
 dontaudit hostname_t var_t:dir search;
diff -urN orig/domains/program/initrc.te mod/domains/program/initrc.te
--- orig/domains/program/initrc.te	2004-10-12 15:13:58.000000000 +0200
+++ mod/domains/program/initrc.te	2004-10-12 15:14:11.000000000 +0200
@@ -293,7 +293,7 @@
 allow initrc_t sysfs_t:file { getattr read };
 allow initrc_t sysfs_t:lnk_file { getattr read };
 allow initrc_t udev_runtime_t:file rw_file_perms;
-allow initrc_t device_type:chr_file { setattr };
+allow initrc_t device_type:chr_file setattr;
 allow initrc_t binfmt_misc_fs_t:dir { getattr search };
 allow initrc_t binfmt_misc_fs_t:file { getattr ioctl write };
 ifdef(`pam.te', `
@@ -308,8 +308,8 @@
 # Wants to remove udev.tbl
 #
 allow initrc_t device_t:dir rw_dir_perms;
-allow initrc_t device_t:lnk_file { unlink };
-allow initrc_t self:process { getsched };
+allow initrc_t device_t:lnk_file unlink;
+allow initrc_t self:process getsched;
=20
 r_dir_file(initrc_t,selinux_config_t)
=20
diff -urN orig/domains/program/ldconfig.te mod/domains/program/ldconfig.te
--- orig/domains/program/ldconfig.te	2004-07-12 23:41:13.000000000 +0200
+++ mod/domains/program/ldconfig.te	2004-10-12 15:14:11.000000000 +0200
@@ -30,4 +30,4 @@
 allow ldconfig_t etc_t:lnk_file read;
=20
 allow ldconfig_t fs_t:filesystem getattr;
-allow ldconfig_t tmp_t:dir { search };
+allow ldconfig_t tmp_t:dir search;
diff -urN orig/domains/program/login.te mod/domains/program/login.te
--- orig/domains/program/login.te	2004-09-11 14:31:46.000000000 +0200
+++ mod/domains/program/login.te	2004-10-12 15:14:11.000000000 +0200
@@ -70,8 +70,8 @@
=20
 # Use capabilities
 allow $1_login_t self:capability { dac_override chown fowner fsetid kill s=
etgid setuid net_bind_service sys_nice sys_resource sys_tty_config };
-allow $1_login_t self:process { setrlimit };
-dontaudit $1_login_t sysfs_t:dir { search };
+allow $1_login_t self:process setrlimit;
+dontaudit $1_login_t sysfs_t:dir search;
=20
 # Set exec context.
 can_setexec($1_login_t)
@@ -87,7 +87,7 @@
=20
 # FIXME: what is this for?
 ifdef(`xdm.te', `
-allow xdm_t $1_login_t:process { signull };
+allow xdm_t $1_login_t:process signull;
 ')
=20
 ifdef(`crack.te', `
@@ -117,20 +117,20 @@
 allow $1_login_t mail_spool_t:file getattr;
 allow $1_login_t mail_spool_t:lnk_file read;
=20
-dontaudit $1_login_t krb5_conf_t:file { write };
+dontaudit $1_login_t krb5_conf_t:file write;
 allow $1_login_t krb5_conf_t:file { getattr read };
 # Get security policy decisions.
 can_getsecurity($1_login_t)
=20
 # allow read access to default_contexts in /etc/security
 allow $1_login_t default_context_t:file r_file_perms;
-allow $1_login_t default_context_t:dir { search };
+allow $1_login_t default_context_t:dir search;
 r_dir_file($1_login_t, selinux_config_t)
=20
 can_ypbind($1_login_t)
=20
 allow $1_login_t mouse_device_t:chr_file { getattr setattr };
-dontaudit $1_login_t init_t:fd { use };
+dontaudit $1_login_t init_t:fd use;
 ')dnl end login_domain macro
 #################################
 #
diff -urN orig/domains/program/logrotate.te mod/domains/program/logrotate.te
--- orig/domains/program/logrotate.te	2004-09-11 14:31:46.000000000 +0200
+++ mod/domains/program/logrotate.te	2004-10-12 15:14:11.000000000 +0200
@@ -42,7 +42,7 @@
=20
 # it should not require this
 allow logrotate_t {staff_home_dir_t sysadm_home_dir_t}:dir { getattr searc=
h };
-dontaudit logrotate_t {staff_home_dir_t sysadm_home_dir_t}:dir { read };
+dontaudit logrotate_t {staff_home_dir_t sysadm_home_dir_t}:dir read;
=20
 # create lock files
 rw_dir_create_file(logrotate_t, var_lock_t)
@@ -86,7 +86,7 @@
 ifdef(`squid.te', `
 allow squid_t { system_crond_t crond_t }:fd use;
 allow squid_t crond_t:fifo_file { read write };
-allow squid_t system_crond_t:fifo_file { write };
+allow squid_t system_crond_t:fifo_file write;
 allow squid_t self:capability kill;
 ')
=20
@@ -137,7 +137,7 @@
 dontaudit consoletype_t logrotate_t:fd use;
 ')
=20
-allow logrotate_t syslogd_t:unix_dgram_socket { sendto };
+allow logrotate_t syslogd_t:unix_dgram_socket sendto;
=20
 domain_auto_trans(logrotate_t, initrc_exec_t, initrc_t)
=20
diff -urN orig/domains/program/modutil.te mod/domains/program/modutil.te
--- orig/domains/program/modutil.te	2004-09-21 22:24:43.000000000 +0200
+++ mod/domains/program/modutil.te	2004-10-12 15:14:11.000000000 +0200
@@ -89,8 +89,8 @@
 allow insmod_t { bin_t sbin_t }:dir search;
 allow insmod_t { bin_t sbin_t }:lnk_file read;
=20
-allow insmod_t self:dir { search };
-allow insmod_t self:lnk_file { read };
+allow insmod_t self:dir search;
+allow insmod_t self:lnk_file read;
=20
 allow insmod_t usr_t:file { getattr read };
=20
@@ -110,7 +110,7 @@
=20
 allow insmod_t { var_t var_log_t }:dir search;
 ifdef(`xserver.te', `
-allow insmod_t xserver_log_t:file { getattr };
+allow insmod_t xserver_log_t:file getattr;
 ')
 rw_dir_create_file(insmod_t, var_log_ksyms_t)
 allow insmod_t { etc_t etc_runtime_t }:file { getattr read };
@@ -138,7 +138,7 @@
 allow insmod_t { proc_t sysctl_t sysctl_kernel_t }:dir search;
 allow insmod_t sysctl_kernel_t:file { setattr rw_file_perms };
 allow insmod_t proc_t:file { getattr read };
-allow insmod_t proc_t:lnk_file { read };
+allow insmod_t proc_t:lnk_file read;
=20
 # Write to /proc/mtrr.
 allow insmod_t mtrr_device_t:file write;
@@ -146,9 +146,9 @@
 # Read /proc/sys/kernel/hotplug.
 allow insmod_t sysctl_hotplug_t:file read;
=20
-allow insmod_t device_t:dir { read };
+allow insmod_t device_t:dir read;
 allow insmod_t devpts_t:dir { getattr search };
-dontaudit insmod_t sound_device_t:chr_file { read };
+dontaudit insmod_t sound_device_t:chr_file read;
=20
 type insmod_exec_t, file_type, exec_type, sysadmfile;
 domain_auto_trans(privmodule, insmod_exec_t, insmod_t)
diff -urN orig/domains/program/mount.te mod/domains/program/mount.te
--- orig/domains/program/mount.te	2004-10-11 10:03:20.000000000 +0200
+++ mod/domains/program/mount.te	2004-10-12 15:14:11.000000000 +0200
@@ -48,11 +48,11 @@
 allow mount_t mnt_t:dir mounton;
 allow mount_t devpts_t:dir mounton;
 allow mount_t usbdevfs_t:dir mounton;
-allow mount_t sysfs_t:dir { mounton };
+allow mount_t sysfs_t:dir mounton;
 allow mount_t nfs_t:dir mounton;
-allow mount_t nfs_t:dir { search };
+allow mount_t nfs_t:dir search;
 # nfsv4 has a filesystem to mount for its userspace daemons
-allow mount_t var_lib_nfs_t:dir { mounton };
+allow mount_t var_lib_nfs_t:dir mounton;
=20
 # On some RedHat systems, /boot is a mount point
 allow mount_t boot_t:dir mounton;
@@ -84,20 +84,20 @@
 # for localization
 allow mount_t lib_t:file { getattr read };
 ifdef(`automount.te', `
-allow mount_t autofs_t:dir { read };
+allow mount_t autofs_t:dir read;
 ')
-allow mount_t fs_t:filesystem { relabelfrom };
+allow mount_t fs_t:filesystem relabelfrom;
 #
 # This rule needs to be generalized.  Only admin, initrc should have it.
 #
 allow mount_t file_type:filesystem { unmount mount relabelto };
=20
-allow mount_t mnt_t:dir { getattr };
+allow mount_t mnt_t:dir getattr;
 dontaudit mount_t kernel_t:fd use;
 allow mount_t userdomain:fd use;
 can_exec(mount_t, { sbin_t bin_t })
 allow mount_t device_t:dir r_dir_perms;
 ifdef(`distro_redhat', `
 allow mount_t tmpfs_t:chr_file { read write };
-allow mount_t tmpfs_t:dir { mounton };
+allow mount_t tmpfs_t:dir mounton;
 ')
diff -urN orig/domains/program/netutils.te mod/domains/program/netutils.te
--- orig/domains/program/netutils.te	2004-07-12 23:41:13.000000000 +0200
+++ mod/domains/program/netutils.te	2004-10-12 15:14:11.000000000 +0200
@@ -54,7 +54,7 @@
 allow netutils_t privfd:fd use;
 allow netutils_t { initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow netutils_t sysadm_gph_t:fd use;')
-allow netutils_t proc_t:dir { search };
+allow netutils_t proc_t:dir search;
=20
 # for nscd
 dontaudit netutils_t var_t:dir search;
diff -urN orig/domains/program/passwd.te mod/domains/program/passwd.te
--- orig/domains/program/passwd.te	2004-10-11 10:03:21.000000000 +0200
+++ mod/domains/program/passwd.te	2004-10-12 15:14:11.000000000 +0200
@@ -91,7 +91,7 @@
 allow chfn_t etc_t:dir rw_dir_perms;
 allow chfn_t etc_t:file create_file_perms;
 allow chfn_t proc_t:file { getattr read };
-allow chfn_t self:file { write };
+allow chfn_t self:file write;
=20
 in_user_role(passwd_t)
 in_user_role(chfn_t)
@@ -122,7 +122,7 @@
=20
 # allow vipw to exec the editor
 allow sysadm_passwd_t { root_t bin_t sbin_t }:dir search;
-allow sysadm_passwd_t { bin_t }:lnk_file read;
+allow sysadm_passwd_t bin_t:lnk_file read;
 can_exec(sysadm_passwd_t, { shell_exec_t bin_t })
 r_dir_file(sysadm_passwd_t, usr_t)
=20
diff -urN orig/domains/program/restorecon.te mod/domains/program/restorecon=
=2Ete
--- orig/domains/program/restorecon.te	2004-09-15 19:01:05.000000000 +0200
+++ mod/domains/program/restorecon.te	2004-10-12 15:14:11.000000000 +0200
@@ -57,7 +57,7 @@
 dontaudit restorecon_t proc_t:lnk_file { getattr read };
=20
 allow restorecon_t device_t:file { read write };
-allow restorecon_t kernel_t:fd { use };
+allow restorecon_t kernel_t:fd use;
 allow restorecon_t kernel_t:fifo_file { read write };
 allow restorecon_t kernel_t:unix_dgram_socket { read write };
 r_dir_file(restorecon_t, selinux_config_t)
diff -urN orig/domains/program/setfiles.te mod/domains/program/setfiles.te
--- orig/domains/program/setfiles.te	2004-09-11 14:31:46.000000000 +0200
+++ mod/domains/program/setfiles.te	2004-10-12 15:14:11.000000000 +0200
@@ -53,4 +53,4 @@
=20
 # for config files in a home directory
 allow setfiles_t home_type:file r_file_perms;
-dontaudit setfiles_t sysadm_tty_device_t:chr_file { relabelfrom };
+dontaudit setfiles_t sysadm_tty_device_t:chr_file relabelfrom;
diff -urN orig/domains/program/ssh.te mod/domains/program/ssh.te
--- orig/domains/program/ssh.te	2004-10-11 10:03:21.000000000 +0200
+++ mod/domains/program/ssh.te	2004-10-12 15:14:11.000000000 +0200
@@ -221,9 +221,9 @@
=20
=20
 ifdef(`automount.te', `
-allow sshd_t autofs_t:dir { search };
+allow sshd_t autofs_t:dir search;
 ')
-dontaudit sshd_t krb5_conf_t:file { write };
+dontaudit sshd_t krb5_conf_t:file write;
 allow sshd_t krb5_conf_t:file { getattr read };
=20
 # ssh_keygen_t is the type of the ssh-keygen program when run at install t=
ime
diff -urN orig/domains/program/sulogin.te mod/domains/program/sulogin.te
--- orig/domains/program/sulogin.te	2004-10-11 10:03:21.000000000 +0200
+++ mod/domains/program/sulogin.te	2004-10-12 15:14:11.000000000 +0200
@@ -34,10 +34,10 @@
 allow sulogin_t bin_t:dir r_dir_perms;
 allow sulogin_t proc_t:dir r_dir_perms;
 allow sulogin_t proc_t:notdevfile_class_set r_file_perms;
-allow sulogin_t root_t:dir { search };
+allow sulogin_t root_t:dir search;
=20
 allow sulogin_t sysadm_devpts_t:chr_file { getattr ioctl read write };
-allow sulogin_t { staff_home_dir_t sysadm_home_dir_t }:dir { search };
+allow sulogin_t { staff_home_dir_t sysadm_home_dir_t }:dir search;
 allow sulogin_t default_context_t:file { getattr read };
=20
 r_dir_file(sulogin_t, selinux_config_t)
diff -urN orig/domains/program/syslogd.te mod/domains/program/syslogd.te
--- orig/domains/program/syslogd.te	2004-10-11 10:03:21.000000000 +0200
+++ mod/domains/program/syslogd.te	2004-10-12 15:14:11.000000000 +0200
@@ -44,7 +44,7 @@
 # Create and bind to /dev/log or /var/run/log.
 file_type_auto_trans(syslogd_t, { device_t var_run_t }, devlog_t, sock_fil=
e)
 allow syslogd_t self:unix_dgram_socket create_socket_perms;
-allow syslogd_t self:unix_dgram_socket { sendto };
+allow syslogd_t self:unix_dgram_socket sendto;
 allow syslogd_t self:unix_stream_socket create_stream_socket_perms;
 allow syslogd_t self:fifo_file rw_file_perms;
 allow syslogd_t devlog_t:unix_stream_socket name_bind;
@@ -94,5 +94,5 @@
 # /initrd is not umounted before minilog starts
 #
 dontaudit syslogd_t file_t:dir search;
-allow syslogd_t { tmpfs_t devpts_t }:dir { search };
+allow syslogd_t { tmpfs_t devpts_t }:dir search;
 dontaudit syslogd_t unlabeled_t:file read;
diff -urN orig/domains/program/tmpreaper.te mod/domains/program/tmpreaper.te
--- orig/domains/program/tmpreaper.te	2004-09-11 14:31:46.000000000 +0200
+++ mod/domains/program/tmpreaper.te	2004-10-12 15:14:11.000000000 +0200
@@ -29,7 +29,7 @@
 allow tmpreaper_t device_t:dir { getattr search };
 allow tmpreaper_t urandom_device_t:chr_file { getattr read };
 rw_dir_file(tmpreaper_t, var_spool_t)
-allow tmpreaper_t var_spool_t:dir { setattr };
+allow tmpreaper_t var_spool_t:dir setattr;
=20
 ifdef(`distro_redhat', `
 # for the Red Hat tmpreaper program which also manages tetex indexes
diff -urN orig/domains/program/unused/amanda.te mod/domains/program/unused/=
amanda.te
--- orig/domains/program/unused/amanda.te	2004-10-11 10:03:21.000000000 +02=
00
+++ mod/domains/program/unused/amanda.te	2004-10-12 15:14:11.000000000 +0200
@@ -84,7 +84,7 @@
=20
 # configuration files -> read only
 allow amanda_t amanda_config_t:file { getattr read };
-allow amanda_t amanda_config_t:dir { search };
+allow amanda_t amanda_config_t:dir search;
=20
 # access to amanda_amandates_t
 allow amanda_t amanda_amandates_t:file { getattr lock read write };
@@ -106,43 +106,43 @@
 allow amanda_t etc_runtime_t:file { getattr read };
=20
 # access to var_t and similar
-allow amanda_t var_t:dir { search };
-allow amanda_t var_lib_t:dir { search };
-allow amanda_t amanda_var_lib_t:dir { search };
+allow amanda_t var_t:dir search;
+allow amanda_t var_lib_t:dir search;
+allow amanda_t amanda_var_lib_t:dir search;
=20
 # access to amanda_gnutarlists_t (/var/lib/amanda/gnutar-lists)
 allow amanda_t amanda_gnutarlists_t:dir { add_name read remove_name search=
 write };
 allow amanda_t amanda_gnutarlists_t:file { create getattr read rename seta=
ttr unlink write };
=20
 # access to var_run_t
-allow amanda_t var_run_t:dir { search };
+allow amanda_t var_run_t:dir search;
=20
 # access to var_log_t
-allow amanda_t var_log_t:dir { getattr };
+allow amanda_t var_log_t:dir getattr;
=20
 # access to var_spool_t
-allow amanda_t var_spool_t:dir { getattr };
+allow amanda_t var_spool_t:dir getattr;
=20
 # access to amanda_usr_lib_t
-allow amanda_t amanda_usr_lib_t:dir { search };
+allow amanda_t amanda_usr_lib_t:dir search;
=20
 # access to device_t and similar
-allow amanda_t device_t:dir { search };
+allow amanda_t device_t:dir search;
 allow amanda_t null_device_t:chr_file { getattr read write };
-allow amanda_t devpts_t:dir { getattr };
-allow amanda_t fixed_disk_device_t:blk_file { getattr };
-allow amanda_t removable_device_t:blk_file { getattr };
+allow amanda_t devpts_t:dir getattr;
+allow amanda_t fixed_disk_device_t:blk_file getattr;
+allow amanda_t removable_device_t:blk_file getattr;
 allow amanda_t devtty_t:chr_file { read write };
=20
 # access to boot_t
-allow amanda_t boot_t:dir { getattr };
+allow amanda_t boot_t:dir getattr;
=20
 # access to fs_t
-allow amanda_t fs_t:filesystem { getattr };
+allow amanda_t fs_t:filesystem getattr;
=20
 # access to sysctl_kernel_t ( proc/sys/kernel/* )
-allow amanda_t sysctl_kernel_t:dir { search };
-allow amanda_t sysctl_kernel_t:file { read };
+allow amanda_t sysctl_kernel_t:dir search;
+allow amanda_t sysctl_kernel_t:file read;
=20
=20
 #####################
@@ -163,7 +163,7 @@
=20
 allow amanda_t self:capability { chown dac_override setuid };
 allow amanda_t self:process { fork sigchld };
-allow amanda_t self:unix_dgram_socket { create };
+allow amanda_t self:unix_dgram_socket create;
=20
=20
 ###################################
@@ -188,7 +188,7 @@
 # inetd permissions
 ###################
=20
-allow inetd_t amanda_usr_lib_t:dir { search };
+allow inetd_t amanda_usr_lib_t:dir search;
=20
=20
 ########################
@@ -200,7 +200,7 @@
 allow amanda_t user_home_type:file { getattr read };
=20
 # access to file_t ( /floppy, /cdrom )
-allow amanda_t mnt_t:dir { getattr };
+allow amanda_t mnt_t:dir getattr;
=20
 ###########
 # Dontaudit
@@ -241,7 +241,7 @@
 allow amanda_recover_t self:process { fork sigkill sigstop sigchld signal =
};
 allow amanda_recover_t self:capability { fowner fsetid setgid setuid chown=
 dac_override net_bind_service };
 allow amanda_recover_t shell_exec_t:file { execute execute_no_trans getatt=
r read };
-allow amanda_recover_t local_login_t:fd { use };
+allow amanda_recover_t local_login_t:fd use;
=20
=20
 # amrecover network and process communication
@@ -258,7 +258,7 @@
 ############################
=20
 # access to etc_t and similar
-allow amanda_recover_t etc_t:dir { search };
+allow amanda_recover_t etc_t:dir search;
 allow amanda_recover_t etc_t:file { getattr read };
 allow amanda_recover_t etc_runtime_t:file { getattr read };
=20
@@ -267,19 +267,19 @@
 allow amanda_recover_t amanda_recover_dir_t:file { append create getattr s=
etattr unlink };
=20
 # access to var_t and var_run_t
-allow amanda_recover_t var_t:dir { search };
-allow amanda_recover_t var_run_t:dir { search };
+allow amanda_recover_t var_t:dir search;
+allow amanda_recover_t var_run_t:dir search;
=20
 # access to proc_t
-allow amanda_recover_t proc_t:dir { search };
+allow amanda_recover_t proc_t:dir search;
 allow amanda_recover_t proc_t:file { getattr read };
=20
 # access to sysctl_kernel_t
-allow amanda_recover_t sysctl_kernel_t:dir { search };
-allow amanda_recover_t sysctl_kernel_t:file { read };
+allow amanda_recover_t sysctl_kernel_t:dir search;
+allow amanda_recover_t sysctl_kernel_t:file read;
=20
 # access to dev_t and similar
-allow amanda_recover_t device_t:dir { search };
+allow amanda_recover_t device_t:dir search;
 allow amanda_recover_t devtty_t:chr_file { read write };
 allow amanda_recover_t null_device_t:chr_file { getattr write };
=20
@@ -296,11 +296,11 @@
 # access to amanda_tmp_t and tmp_t
 allow amanda_recover_t amanda_tmp_t:dir { add_name remove_name search writ=
e };
 allow amanda_recover_t amanda_tmp_t:file { append create getattr setattr u=
nlink };
-allow amanda_recover_t tmp_t:dir { search };
+allow amanda_recover_t tmp_t:dir search;
=20
 #
 #  Rules to allow amanda to be run as a service in xinetd
 #
 type amanda_port_t, port_type;
-allow inetd_t amanda_port_t:{ tcp_socket udp_socket } { name_bind };
+allow inetd_t amanda_port_t:{ tcp_socket udp_socket } name_bind;
=20
diff -urN orig/domains/program/unused/anaconda.te mod/domains/program/unuse=
d/anaconda.te
--- orig/domains/program/unused/anaconda.te	2004-09-11 14:31:46.000000000 +=
0200
+++ mod/domains/program/unused/anaconda.te	2004-10-12 15:14:11.000000000 +0=
200
@@ -235,7 +235,7 @@
 allow anaconda_t sysfs_t:file { getattr read };
 allow anaconda_t sysfs_t:lnk_file { getattr read };
 allow anaconda_t udev_runtime_t:file rw_file_perms;
-allow anaconda_t device_type:chr_file { setattr };
+allow anaconda_t device_type:chr_file setattr;
=20
 # for lsof in shutdown scripts
 allow anaconda_t security_t:dir getattr;
diff -urN orig/domains/program/unused/apache.te mod/domains/program/unused/=
apache.te
--- orig/domains/program/unused/apache.te	2004-10-11 10:03:21.000000000 +02=
00
+++ mod/domains/program/unused/apache.te	2004-10-12 15:14:11.000000000 +0200
@@ -40,7 +40,7 @@
=20
 append_logdir_domain(httpd)
 #can read /etc/httpd/logs
-allow httpd_t httpd_log_t:lnk_file { read };
+allow httpd_t httpd_log_t:lnk_file read;
=20
 # For /etc/init.d/apache2 reload
 can_tcp_connect(httpd_t, httpd_t)
@@ -232,14 +232,14 @@
 # connect to mysql
 ifdef(`mysqld.te', `
 can_unix_connect(httpd_php_t, mysqld_t)
-allow httpd_php_t mysqld_var_run_t:dir { search };
-allow httpd_php_t mysqld_var_run_t:sock_file { write };
-allow httpd_t mysqld_db_t:dir { search };
+allow httpd_php_t mysqld_var_run_t:dir search;
+allow httpd_php_t mysqld_var_run_t:sock_file write;
+allow httpd_t mysqld_db_t:dir search;
 allow httpd_t mysqld_db_t:sock_file rw_file_perms;
 ')
-allow httpd_t bin_t:dir { search };
-allow httpd_t sbin_t:dir { search };
-allow httpd_t httpd_log_t:dir { remove_name };
+allow httpd_t bin_t:dir search;
+allow httpd_t sbin_t:dir search;
+allow httpd_t httpd_log_t:dir remove_name;
=20
 allow httpd_t self:netlink_route_socket { bind create getattr nlmsg_read r=
ead write };
=20
@@ -269,7 +269,7 @@
 dontaudit httpd_t admin_tty_type:chr_file rw_file_perms;
=20
 allow httpd_t krb5_conf_t:file { getattr read };
-dontaudit httpd_t krb5_conf_t:file { write };
+dontaudit httpd_t krb5_conf_t:file write;
=20
 ifdef(`targeted_policy', `
 typealias httpd_sys_content_t alias httpd_user_content_t;
diff -urN orig/domains/program/unused/apmd.te mod/domains/program/unused/ap=
md.te
--- orig/domains/program/unused/apmd.te	2004-09-11 14:31:46.000000000 +0200
+++ mod/domains/program/unused/apmd.te	2004-10-12 15:14:11.000000000 +0200
@@ -53,7 +53,7 @@
=20
 # controlling an orderly resume of PCMCIA requires creating device
 # nodes 254,{0,1,2} for some reason.
-allow apmd_t self:capability { mknod };
+allow apmd_t self:capability mknod;
=20
 # Access /dev/apm_bios.
 allow apmd_t apm_bios_t:chr_file rw_file_perms;
@@ -71,7 +71,7 @@
 # to quiet fuser and ps
 # setuid for fuser, dac* for ps
 dontaudit apmd_t self:capability { setuid dac_override dac_read_search };
-dontaudit apmd_t domain:{ socket_class_set } getattr;
+dontaudit apmd_t domain:socket_class_set getattr;
 dontaudit apmd_t { file_type fs_type }:notdevfile_class_set getattr;
 dontaudit apmd_t device_type:devfile_class_set getattr;
 dontaudit apmd_t home_type:dir { search getattr };
@@ -99,7 +99,7 @@
 #
 # apmd tells the machine to shutdown requires the following
 #
-allow apmd_t initctl_t:fifo_file { write };
+allow apmd_t initctl_t:fifo_file write;
 allow apmd_t initrc_var_run_t:file { read write lock };
=20
 #
diff -urN orig/domains/program/unused/automount.te mod/domains/program/unus=
ed/automount.te
--- orig/domains/program/unused/automount.te	2004-09-11 14:31:46.000000000 =
+0200
+++ mod/domains/program/unused/automount.te	2004-10-12 15:14:11.000000000 +=
0200
@@ -26,7 +26,7 @@
 allow automount_t { etc_t etc_runtime_t }:file { getattr read };
 allow automount_t proc_t:file { getattr read };
 allow automount_t self:process { setpgid setsched };
-allow automount_t self:capability { sys_nice };
+allow automount_t self:capability sys_nice;
 allow automount_t self:unix_stream_socket create_socket_perms;
 allow automount_t self:unix_dgram_socket create_socket_perms;
=20
@@ -63,7 +63,7 @@
 allow userdomain autofs_t:dir r_dir_perms;
 allow kernel_t autofs_t:dir { getattr ioctl read search };
=20
-allow automount_t home_root_t:dir { getattr };
+allow automount_t home_root_t:dir getattr;
 allow automount_t mnt_t:dir { getattr search };
=20
 allow initrc_t automount_etc_t:file { getattr read };
diff -urN orig/domains/program/unused/backup.te mod/domains/program/unused/=
backup.te
--- orig/domains/program/unused/backup.te	2004-09-11 14:31:46.000000000 +02=
00
+++ mod/domains/program/unused/backup.te	2004-10-12 15:14:11.000000000 +0200
@@ -47,7 +47,7 @@
=20
 allow backup_t self:fifo_file rw_file_perms;
 allow backup_t self:process { signal sigchld fork };
-allow backup_t self:capability { dac_override };
+allow backup_t self:capability dac_override;
=20
 rw_dir_file(backup_t, backup_store_t)
 allow backup_t backup_store_t:file { create setattr };
diff -urN orig/domains/program/unused/ciped.te mod/domains/program/unused/c=
iped.te
--- orig/domains/program/unused/ciped.te	2004-09-11 14:31:46.000000000 +0200
+++ mod/domains/program/unused/ciped.te	2004-10-12 15:14:11.000000000 +0200
@@ -11,7 +11,7 @@
 can_ypbind(ciped_t)
 allow ciped_t cipe_port_t:udp_socket name_bind;
=20
-allow ciped_t devpts_t:dir { search };
+allow ciped_t devpts_t:dir search;
 allow ciped_t devtty_t:chr_file { read write };
 allow ciped_t etc_runtime_t:file { getattr read };
 allow ciped_t etc_t:file { getattr read };
diff -urN orig/domains/program/unused/comsat.te mod/domains/program/unused/=
comsat.te
--- orig/domains/program/unused/comsat.te	2004-10-11 10:03:21.000000000 +02=
00
+++ mod/domains/program/unused/comsat.te	2004-10-12 15:14:11.000000000 +0200
@@ -15,6 +15,6 @@
 allow comsat_t initrc_var_run_t:file r_file_perms;
 dontaudit comsat_t initrc_var_run_t:file write;
 allow comsat_t mail_spool_t:dir r_dir_perms;
-allow comsat_t mail_spool_t:lnk_file { read };
-allow comsat_t var_spool_t:dir { search };
-dontaudit comsat_t sysadm_tty_device_t:chr_file { getattr };
+allow comsat_t mail_spool_t:lnk_file read;
+allow comsat_t var_spool_t:dir search;
+dontaudit comsat_t sysadm_tty_device_t:chr_file getattr;
diff -urN orig/domains/program/unused/consoletype.te mod/domains/program/un=
used/consoletype.te
--- orig/domains/program/unused/consoletype.te	2004-09-28 09:34:16.00000000=
0 +0200
+++ mod/domains/program/unused/consoletype.te	2004-10-12 15:14:11.000000000=
 +0200
@@ -41,7 +41,7 @@
 allow consoletype_t console_device_t:chr_file { getattr ioctl read write };
 allow consoletype_t initrc_t:fifo_file write;
 allow consoletype_t tty_device_t:chr_file read;
-allow consoletype_t nfs_t:file { write };
+allow consoletype_t nfs_t:file write;
 allow consoletype_t sysadm_t:fifo_file rw_file_perms;
=20
 ifdef(`lpd.te', `
@@ -54,6 +54,6 @@
 ifdef(`distro_redhat', `
 allow consoletype_t tmpfs_t:chr_file { getattr ioctl read write };
 ')
-allow consoletype_t firstboot_t:fifo_file { write };
-dontaudit consoletype_t proc_t:file { read };
-dontaudit consoletype_t root_t:file { read };
+allow consoletype_t firstboot_t:fifo_file write;
+dontaudit consoletype_t proc_t:file read;
+dontaudit consoletype_t root_t:file read;
diff -urN orig/domains/program/unused/cpuspeed.te mod/domains/program/unuse=
d/cpuspeed.te
--- orig/domains/program/unused/cpuspeed.te	2004-03-17 19:26:05.000000000 +=
0100
+++ mod/domains/program/unused/cpuspeed.te	2004-10-12 15:14:11.000000000 +0=
200
@@ -4,7 +4,7 @@
 #
=20
 daemon_base_domain(cpuspeed)
-allow cpuspeed_t sysfs_t:dir { search };
+allow cpuspeed_t sysfs_t:dir search;
 allow cpuspeed_t sysfs_t:file rw_file_perms;
 allow cpuspeed_t proc_t:dir r_dir_perms;
 allow cpuspeed_t proc_t:file { getattr read };
diff -urN orig/domains/program/unused/cups.te mod/domains/program/unused/cu=
ps.te
--- orig/domains/program/unused/cups.te	2004-10-11 10:03:21.000000000 +0200
+++ mod/domains/program/unused/cups.te	2004-10-12 15:14:11.000000000 +0200
@@ -45,7 +45,7 @@
 ')
=20
 ifdef(`inetd.te', `
-allow inetd_t printer_port_t:tcp_socket { name_bind };
+allow inetd_t printer_port_t:tcp_socket name_bind;
 domain_auto_trans(inetd_t, cupsd_exec_t, cupsd_t)
 ')
=20
@@ -125,7 +125,7 @@
 #
 # lots of errors generated requiring the following
 #
-allow cupsd_t self:capability { net_admin };
+allow cupsd_t self:capability net_admin;
 allow cupsd_t self:netlink_route_socket { bind create getattr nlmsg_read r=
ead write };
 #
 # Satisfy readahead
@@ -136,7 +136,7 @@
 r_dir_file(cupsd_t, usercanread)
 ifdef(`samba.te', `
 rw_dir_file(cupsd_t, samba_var_t)
-allow smbd_t cupsd_etc_t:dir { search };
+allow smbd_t cupsd_etc_t:dir search;
 ')
=20
 ifdef(`pam.te', `
@@ -148,28 +148,28 @@
 etcdir_domain(ptal)
 allow ptal_t ptal_var_run_t:fifo_file create_file_perms;
 allow ptal_t ptal_var_run_t:sock_file create_file_perms;
-allow ptal_t self:capability { chown };
+allow ptal_t self:capability chown;
 allow ptal_t self:{ unix_dgram_socket unix_stream_socket } create_socket_p=
erms;
 allow ptal_t self:unix_stream_socket { listen accept };
 allow ptal_t self:fifo_file rw_file_perms;
-allow ptal_t device_t:dir { read };
+allow ptal_t device_t:dir read;
 allow ptal_t printer_device_t:chr_file { ioctl read write };
 allow ptal_t { etc_t etc_runtime_t }:file { getattr read };
 r_dir_file(ptal_t, usbdevfs_t)
 r_dir_file(ptal_t, usbfs_t)
 allow cupsd_t ptal_var_run_t:sock_file { write setattr };
-allow cupsd_t ptal_t:unix_stream_socket { connectto };
-allow cupsd_t ptal_var_run_t:dir { search };
+allow cupsd_t ptal_t:unix_stream_socket connectto;
+allow cupsd_t ptal_var_run_t:dir search;
 dontaudit ptal_t { sysadm_home_dir_t staff_home_dir_t }:dir { getattr sear=
ch };
=20
 dontaudit cupsd_t selinux_config_t:dir search;
 dontaudit cupsd_t selinux_config_t:file { getattr read };
=20
 ifdef(`hald.te', `
-allow cupsd_t hald_t:dbus { send_msg };
-allow hald_t cupsd_t:dbus { send_msg };
+allow cupsd_t hald_t:dbus send_msg;
+allow hald_t cupsd_t:dbus send_msg;
 allow hald_t cupsd_etc_t:dir search;
 allow hald_t printconf_t:file { getattr read };
 domain_auto_trans(hald_t, cupsd_exec_t, cupsd_t)
 ')
-allow cupsd_t userdomain:dbus { send_msg };
+allow cupsd_t userdomain:dbus send_msg;
diff -urN orig/domains/program/unused/cyrus.te mod/domains/program/unused/c=
yrus.te
--- orig/domains/program/unused/cyrus.te	2004-05-04 21:35:53.000000000 +0200
+++ mod/domains/program/unused/cyrus.te	2004-10-12 15:14:11.000000000 +0200
@@ -14,7 +14,7 @@
 type cyrus_var_lib_t, file_type, sysadmfile;
=20
 allow cyrus_t self:capability { dac_override net_bind_service setgid setui=
d sys_resource };
-allow cyrus_t self:process { setrlimit };
+allow cyrus_t self:process setrlimit;
=20
 allow initrc_su_t cyrus_var_lib_t:dir search;
=20
@@ -29,19 +29,19 @@
 read_sysctl(cyrus_t)
 tmp_domain(cyrus)
 ifdef(`use_pop', `
-allow cyrus_t pop_port_t:tcp_socket { name_bind };
+allow cyrus_t pop_port_t:tcp_socket name_bind;
 ')
-allow cyrus_t proc_t:dir { search };
+allow cyrus_t proc_t:dir search;
 allow cyrus_t proc_t:file { getattr read };
 allow cyrus_t sysadm_devpts_t:chr_file { read write };
=20
-allow cyrus_t staff_t:fd { use };
-allow cyrus_t var_lib_t:dir { search };
+allow cyrus_t staff_t:fd use;
+allow cyrus_t var_lib_t:dir search;
=20
 allow cyrus_t etc_runtime_t:file { read getattr };
 ifdef(`crond.te', `
 system_crond_entry(cyrus_exec_t, cyrus_t)
 allow system_crond_t cyrus_var_lib_t:dir rw_dir_perms;
 allow system_crond_t cyrus_var_lib_t:file create_file_perms;
-allow system_crond_su_t cyrus_var_lib_t:dir { search };
+allow system_crond_su_t cyrus_var_lib_t:dir search;
 ')
diff -urN orig/domains/program/unused/devfsd.te mod/domains/program/unused/=
devfsd.te
--- orig/domains/program/unused/devfsd.te	2004-09-11 14:31:46.000000000 +02=
00
+++ mod/domains/program/unused/devfsd.te	2004-10-12 15:14:11.000000000 +0200
@@ -18,7 +18,7 @@
 allow devfsd_t urandom_device_t:chr_file read;
=20
 # for startup scripts
-can_exec(devfsd_t, { bin_t })
+can_exec(devfsd_t, bin_t)
 allow devfsd_t self:fifo_file rw_file_perms;
 allow devfsd_t proc_t:dir r_dir_perms;
 allow devfsd_t { etc_t etc_runtime_t proc_t }:file r_file_perms;
diff -urN orig/domains/program/unused/dhcpc.te mod/domains/program/unused/d=
hcpc.te
--- orig/domains/program/unused/dhcpc.te	2004-10-11 10:03:21.000000000 +0200
+++ mod/domains/program/unused/dhcpc.te	2004-10-12 15:14:11.000000000 +0200
@@ -127,8 +127,8 @@
=20
 domain_auto_trans(dhcpc_t, hostname_exec_t, hostname_t)
 dontaudit dhcpc_t { ttyfile ptyfile tty_device_t }:chr_file { read write };
-allow dhcpc_t { userdomain kernel_t }:fd { use };
+allow dhcpc_t { userdomain kernel_t }:fd use;
=20
-allow dhcpc_t home_root_t:dir { search };
+allow dhcpc_t home_root_t:dir search;
 allow initrc_t dhcpc_state_t:file { getattr read };
-dontaudit dhcpc_t var_lock_t:dir { search };
+dontaudit dhcpc_t var_lock_t:dir search;
diff -urN orig/domains/program/unused/dovecot.te mod/domains/program/unused=
/dovecot.te
--- orig/domains/program/unused/dovecot.te	2004-09-15 19:01:06.000000000 +0=
200
+++ mod/domains/program/unused/dovecot.te	2004-10-12 15:14:11.000000000 +02=
00
@@ -12,7 +12,7 @@
 type dovecot_cert_t, file_type, sysadmfile;
=20
 allow dovecot_t self:capability { dac_override dac_read_search chown net_b=
ind_service setgid setuid sys_chroot };
-allow dovecot_t self:process { setrlimit };
+allow dovecot_t self:process setrlimit;
 can_network(dovecot_t)
 can_ypbind(dovecot_t)
 allow dovecot_t self:unix_dgram_socket create_socket_perms;
@@ -20,18 +20,18 @@
 can_unix_connect(dovecot_t, self)
=20
 allow dovecot_t etc_t:file { getattr read };
-allow dovecot_t initrc_var_run_t:file { getattr };
+allow dovecot_t initrc_var_run_t:file getattr;
 allow dovecot_t bin_t:dir { getattr search };
 can_exec(dovecot_t, bin_t)
=20
 allow dovecot_t pop_port_t:tcp_socket name_bind;
-allow dovecot_t urandom_device_t:chr_file { read };
+allow dovecot_t urandom_device_t:chr_file read;
 allow dovecot_t dovecot_cert_t:file { getattr read };
=20
 allow dovecot_t { self proc_t }:file { getattr read };
 allow dovecot_t self:fifo_file rw_file_perms;
=20
-dontaudit dovecot_t krb5_conf_t:file { write };
+dontaudit dovecot_t krb5_conf_t:file write;
 allow dovecot_t krb5_conf_t:file { getattr read };
=20
 daemon_sub_domain(dovecot_t, dovecot_auth, `, auth')
diff -urN orig/domains/program/unused/dpkg.te mod/domains/program/unused/dp=
kg.te
--- orig/domains/program/unused/dpkg.te	2004-09-23 11:38:29.000000000 +0200
+++ mod/domains/program/unused/dpkg.te	2004-10-12 15:14:11.000000000 +0200
@@ -202,7 +202,7 @@
 allow { apt_t dpkg_t } sysctl_kernel_t:dir { getattr search };
 allow { apt_t dpkg_t } sysctl_kernel_t:file r_file_perms;
=20
-allow dpkg_t sysctl_t:dir { search };
+allow dpkg_t sysctl_t:dir search;
=20
 allow dpkg_t console_device_t:chr_file rw_file_perms;
=20
diff -urN orig/domains/program/unused/firstboot.te mod/domains/program/unus=
ed/firstboot.te
--- orig/domains/program/unused/firstboot.te	2004-10-12 15:13:58.000000000 =
+0200
+++ mod/domains/program/unused/firstboot.te	2004-10-12 15:14:11.000000000 +=
0200
@@ -42,17 +42,17 @@
 allow firstboot_t initrc_exec_t:file { getattr read };
 allow firstboot_t initrc_var_run_t:file r_file_perms;
 allow firstboot_t lib_t:file { getattr read };
-allow firstboot_t local_login_t:fd { use };
+allow firstboot_t local_login_t:fd use;
 read_locale(firstboot_t)
=20
-allow firstboot_t proc_t:dir { search };
+allow firstboot_t proc_t:dir search;
 allow firstboot_t { devtty_t sysadm_tty_device_t }:chr_file rw_file_perms;
 allow firstboot_t usr_t:file r_file_perms;
=20
-allow firstboot_t etc_t:file { write };
+allow firstboot_t etc_t:file write;
=20
 # Allow write to utmp file
-allow firstboot_t initrc_var_run_t:file { write };
+allow firstboot_t initrc_var_run_t:file write;
=20
 allow firstboot_t krb5_conf_t:file { getattr read };
 allow firstboot_t net_conf_t:file { getattr read };
@@ -61,7 +61,7 @@
 rw_dir_file(firstboot_t, samba_etc_t)
 ')
=20
-dontaudit firstboot_t shadow_t:file { getattr };
+dontaudit firstboot_t shadow_t:file getattr;
=20
 role system_r types initrc_t;
 #role_transition firstboot_r initrc_exec_t system_r;
@@ -77,13 +77,13 @@
 ifdef(`consoletype.te', `
 allow consoletype_t devtty_t:chr_file { read write };
 allow consoletype_t etc_t:file { getattr read };
-allow consoletype_t firstboot_t:fd { use };
+allow consoletype_t firstboot_t:fd use;
 ')
=20
 allow firstboot_t etc_t:{ file lnk_file } create_file_perms;
=20
 allow firstboot_t self:capability { dac_override setgid };
-allow firstboot_t self:dir { search };
+allow firstboot_t self:dir search;
 allow firstboot_t self:file { read write };
 allow firstboot_t self:lnk_file read;
 can_setfscreate(firstboot_t)
@@ -91,26 +91,26 @@
=20
 allow firstboot_t modules_conf_t:file { getattr read };
 allow firstboot_t modules_dep_t:file { getattr read };
-allow firstboot_t modules_object_t:dir { search };
+allow firstboot_t modules_object_t:dir search;
 allow firstboot_t net_conf_t:file rw_file_perms;
 allow firstboot_t netif_lo_t:netif { tcp_recv tcp_send };
 allow firstboot_t node_t:node { tcp_recv tcp_send };
=20
 allow firstboot_t port_t:tcp_socket { recv_msg send_msg };
-allow firstboot_t proc_t:lnk_file { read };
+allow firstboot_t proc_t:lnk_file read;
=20
 can_getsecurity(firstboot_t)
=20
 dontaudit firstboot_t sysadm_t:process { noatsecure rlimitinh siginh trans=
ition };
 read_sysctl(firstboot_t)
=20
-allow firstboot_t var_run_t:dir { getattr };
-allow firstboot_t var_t:dir { getattr };
+allow firstboot_t var_run_t:dir getattr;
+allow firstboot_t var_t:dir getattr;
 allow hostname_t devtty_t:chr_file { read write };
-allow hostname_t firstboot_t:fd { use };
+allow hostname_t firstboot_t:fd use;
 ifdef(`iptables.te', `
 allow iptables_t devtty_t:chr_file { read write };
-allow iptables_t firstboot_t:fd { use };
+allow iptables_t firstboot_t:fd use;
 allow iptables_t firstboot_t:fifo_file write;
 ')
 can_network(firstboot_t)
diff -urN orig/domains/program/unused/ftpd.te mod/domains/program/unused/ft=
pd.te
--- orig/domains/program/unused/ftpd.te	2004-10-11 10:03:21.000000000 +0200
+++ mod/domains/program/unused/ftpd.te	2004-10-12 15:14:11.000000000 +0200
@@ -86,11 +86,11 @@
 allow ftpd_t proc_t:file { getattr read };
=20
 dontaudit ftpd_t sysadm_home_dir_t:dir getattr;
-dontaudit ftpd_t krb5_conf_t:file { write };
+dontaudit ftpd_t krb5_conf_t:file write;
 dontaudit ftpd_t selinux_config_t:dir search;
 allow ftpd_t krb5_conf_t:file { getattr read };
 ifdef(`automount.te', `
-allow ftpd_t autofs_t:dir { search };
+allow ftpd_t autofs_t:dir search;
 ')
 allow ftpd_t self:file { getattr read };
 tmp_domain(ftpd)
@@ -103,4 +103,4 @@
 allow ftpd_t nfs_t:file r_file_perms;
 }
 ')dnl end if nfs_home_dirs
-dontaudit ftpd_t selinux_config_t:dir { search };
+dontaudit ftpd_t selinux_config_t:dir search;
diff -urN orig/domains/program/unused/hald.te mod/domains/program/unused/ha=
ld.te
--- orig/domains/program/unused/hald.te	2004-10-12 15:13:58.000000000 +0200
+++ mod/domains/program/unused/hald.te	2004-10-12 15:14:11.000000000 +0200
@@ -19,7 +19,7 @@
 allow hald_t self:unix_dgram_socket create_socket_perms;
=20
 ifdef(`dbusd.te', `
-allow hald_t system_dbusd_t:dbus { acquire_svc };
+allow hald_t system_dbusd_t:dbus acquire_svc;
 dbusd_client(system, hald_t)
 ')
=20
@@ -29,7 +29,7 @@
 allow hald_t self:fifo_file rw_file_perms;
 allow hald_t usr_t:file { getattr read };
=20
-allow hald_t bin_t:file { getattr };
+allow hald_t bin_t:file getattr;
 allow hald_t self:netlink_route_socket r_netlink_socket_perms;
 allow hald_t self:capability { net_admin sys_admin dac_override dac_read_s=
earch };
 can_network(hald_t)
@@ -39,12 +39,12 @@
 allow hald_t { fixed_disk_device_t removable_device_t }:blk_file { getattr=
 read ioctl };
 allow hald_t event_device_t:chr_file { getattr read ioctl };
 allow hald_t printer_device_t:chr_file rw_file_perms;
-allow hald_t urandom_device_t:chr_file { read };
+allow hald_t urandom_device_t:chr_file read;
=20
 ifdef(`updfstab.te', `
 domain_auto_trans(hald_t, updfstab_exec_t, updfstab_t)
-allow updfstab_t hald_t:dbus { send_msg };
-allow hald_t updfstab_t:dbus { send_msg };
+allow updfstab_t hald_t:dbus send_msg;
+allow hald_t updfstab_t:dbus send_msg;
 ')
 ifdef(`udev.te', `
 domain_auto_trans(hald_t, udev_exec_t, udev_t)
@@ -60,4 +60,4 @@
 allow hald_t usbfs_t:dir search;
 allow hald_t usbfs_t:file { getattr read };
 allow hald_t bin_t:lnk_file read;
-dontaudit hald_t selinux_config_t:dir { search };
+dontaudit hald_t selinux_config_t:dir search;
diff -urN orig/domains/program/unused/hotplug.te mod/domains/program/unused=
/hotplug.te
--- orig/domains/program/unused/hotplug.te	2004-10-11 10:03:21.000000000 +0=
200
+++ mod/domains/program/unused/hotplug.te	2004-10-12 15:14:11.000000000 +02=
00
@@ -44,7 +44,7 @@
 can_exec(hotplug_t, { hotplug_exec_t bin_t sbin_t ls_exec_t shell_exec_t h=
otplug_etc_t etc_t })
 ifdef(`hostname.te', `
 can_exec(hotplug_t, hostname_exec_t)
-dontaudit hostname_t hotplug_t:fd { use };
+dontaudit hostname_t hotplug_t:fd use;
 ')
 ifdef(`netutils.te', `
 ifdef(`distro_redhat', `
@@ -137,11 +137,11 @@
 allow hotplug_t sysfs_t:lnk_file { getattr read };
 allow hotplug_t udev_runtime_t:file rw_file_perms;
 ifdef(`lpd.te', `
-allow hotplug_t printer_device_t:chr_file { setattr };
+allow hotplug_t printer_device_t:chr_file setattr;
 ')
-allow hotplug_t fixed_disk_device_t:blk_file { setattr };
-allow hotplug_t removable_device_t:blk_file { setattr };
-allow hotplug_t sound_device_t:chr_file { setattr };
+allow hotplug_t fixed_disk_device_t:blk_file setattr;
+allow hotplug_t removable_device_t:blk_file setattr;
+allow hotplug_t sound_device_t:chr_file setattr;
=20
 ifdef(`udev.te', `
 domain_auto_trans(hotplug_t, { udev_exec_t udev_helper_exec_t }, udev_t)
diff -urN orig/domains/program/unused/imazesrv.te mod/domains/program/unuse=
d/imazesrv.te
--- orig/domains/program/unused/imazesrv.te	2004-03-23 21:58:08.000000000 +=
0100
+++ mod/domains/program/unused/imazesrv.te	2004-10-12 15:14:11.000000000 +0=
200
@@ -23,7 +23,7 @@
=20
 can_network(imazesrv_t)
=20
-allow imazesrv_t self:capability { net_bind_service };
+allow imazesrv_t self:capability net_bind_service;
=20
 r_dir_file(imazesrv_t, etc_t)
=20
diff -urN orig/domains/program/unused/ipsec.te mod/domains/program/unused/i=
psec.te
--- orig/domains/program/unused/ipsec.te	2004-10-12 15:13:58.000000000 +0200
+++ mod/domains/program/unused/ipsec.te	2004-10-12 15:14:11.000000000 +0200
@@ -46,7 +46,7 @@
 allow { ipsec_t ipsec_mgmt_t } { init_t initrc_t privfd }:fd use;
=20
 # I do not know where this pesky pipe is...
-allow ipsec_t initrc_t:fifo_file { write };
+allow ipsec_t initrc_t:fifo_file write;
=20
 allow ipsec_t ipsec_conf_file_t:file { getattr read ioctl };
 allow ipsec_t ipsec_key_file_t:file { getattr read ioctl };
@@ -91,7 +91,7 @@
=20
 # need access to /proc/sys/net/ipsec/icmp
 allow ipsec_mgmt_t sysctl_t:file write;
-allow ipsec_mgmt_t sysctl_net_t:dir { search };
+allow ipsec_mgmt_t sysctl_net_t:dir search;
 allow ipsec_mgmt_t sysctl_net_t:file { write setattr };
=20
 # whack needs to be able to read/write pluto.ctl
@@ -138,16 +138,16 @@
=20
 # allow pluto to search the root directory (not sure why, but mostly harml=
ess)
 # Are these all really necessary?
-allow ipsec_t var_t:dir { search };
-allow ipsec_t bin_t:dir { search };
+allow ipsec_t var_t:dir search;
+allow ipsec_t bin_t:dir search;
 allow ipsec_t device_t:dir { getattr search };
 allow ipsec_mgmt_t device_t:dir { getattr search read };
 dontaudit ipsec_mgmt_t tty_device_t:chr_file getattr;
 dontaudit ipsec_mgmt_t devpts_t:dir getattr;
 allow ipsec_mgmt_t etc_t:lnk_file read;
-allow ipsec_mgmt_t var_t:dir { search };
-allow ipsec_mgmt_t sbin_t:dir { search };
-allow ipsec_mgmt_t bin_t:dir { search };
+allow ipsec_mgmt_t var_t:dir search;
+allow ipsec_mgmt_t sbin_t:dir search;
+allow ipsec_mgmt_t bin_t:dir search;
 allow ipsec_mgmt_t ipsec_var_run_t:file { getattr read };
=20
 # Startup scripts
@@ -210,8 +210,8 @@
 allow ipsec_mgmt_t self:capability { sys_tty_config dac_read_search };
 read_locale(ipsec_mgmt_t)
 var_run_domain(ipsec_mgmt)
-dontaudit ipsec_mgmt_t default_t:dir { getattr };
-dontaudit ipsec_mgmt_t default_t:file { getattr };
+dontaudit ipsec_mgmt_t default_t:dir getattr;
+dontaudit ipsec_mgmt_t default_t:file getattr;
 allow ipsec_mgmt_t tmpfs_t:dir { getattr read };
 allow ipsec_mgmt_t self:key_socket { create setopt };
 can_exec(ipsec_mgmt_t, initrc_exec_t)
@@ -220,7 +220,7 @@
 ifdef(`consoletype.te', `
 can_exec(ipsec_mgmt_t, consoletype_exec_t )
 ')
-dontaudit ipsec_mgmt_t selinux_config_t:dir { search };
+dontaudit ipsec_mgmt_t selinux_config_t:dir search;
 dontaudit ipsec_t ttyfile:chr_file { read write };
 allow ipsec_t self:capability { dac_override dac_read_search };
-allow ipsec_t reserved_port_t:udp_socket { name_bind };
+allow ipsec_t reserved_port_t:udp_socket name_bind;
diff -urN orig/domains/program/unused/iptables.te mod/domains/program/unuse=
d/iptables.te
--- orig/domains/program/unused/iptables.te	2004-10-12 15:13:58.000000000 +=
0200
+++ mod/domains/program/unused/iptables.te	2004-10-12 15:14:11.000000000 +0=
200
@@ -39,7 +39,7 @@
 can_network(iptables_t)
=20
 allow iptables_t bin_t:file { execute execute_no_trans };
-allow iptables_t iptables_exec_t:file { execute_no_trans };
+allow iptables_t iptables_exec_t:file execute_no_trans;
 allow iptables_t self:capability { net_admin net_raw };
 allow iptables_t self:rawip_socket create_socket_perms;
=20
@@ -55,7 +55,7 @@
 allow iptables_t proc_t:file { getattr read };
=20
 # system-config-network appends to /var/log
-allow iptables_t var_log_t:file { append };
+allow iptables_t var_log_t:file append;
 ifdef(`firstboot.te', `
-allow iptables_t firstboot_t:fifo_file { write };
+allow iptables_t firstboot_t:fifo_file write;
 ')
diff -urN orig/domains/program/unused/jabberd.te mod/domains/program/unused=
/jabberd.te
--- orig/domains/program/unused/jabberd.te	2004-10-11 10:03:21.000000000 +0=
200
+++ mod/domains/program/unused/jabberd.te	2004-10-12 15:14:11.000000000 +02=
00
@@ -26,7 +26,7 @@
 allow jabberd_t self:unix_stream_socket create_socket_perms;
 allow jabberd_t self:fifo_file { read write getattr };
=20
-allow jabberd_t self:capability { dac_override };
+allow jabberd_t self:capability dac_override;
=20
 # allow any user domain to connect to jabber
 can_tcp_connect(userdomain, jabberd_t)
diff -urN orig/domains/program/unused/kerberos.te mod/domains/program/unuse=
d/kerberos.te
--- orig/domains/program/unused/kerberos.te	2004-10-12 15:13:58.000000000 +=
0200
+++ mod/domains/program/unused/kerberos.te	2004-10-12 15:14:11.000000000 +0=
200
@@ -56,16 +56,16 @@
 # Rules for Kerberos5 KDC daemon
 allow krb5kdc_t self:unix_dgram_socket create_socket_perms;
 allow krb5kdc_t self:unix_stream_socket create_socket_perms;
-allow krb5kdc_t krb5kdc_conf_t:dir { search };
+allow krb5kdc_t krb5kdc_conf_t:dir search;
 allow krb5kdc_t krb5kdc_conf_t:file r_file_perms;
 allow krb5kdc_t krb5kdc_principal_t:file r_file_perms;
-dontaudit krb5kdc_t krb5kdc_principal_t:file { write };
+dontaudit krb5kdc_t krb5kdc_principal_t:file write;
 allow krb5kdc_t locale_t:file { getattr read };
-dontaudit krb5kdc_t krb5kdc_conf_t:file { write };
+dontaudit krb5kdc_t krb5kdc_conf_t:file write;
 allow krb5kdc_t etc_t:dir { getattr search };
 allow krb5kdc_t etc_t:file { getattr read };
 allow krb5kdc_t krb5_conf_t:file r_file_perms;
-dontaudit krb5kdc_t krb5_conf_t:file { write };
+dontaudit krb5kdc_t krb5_conf_t:file write;
 tmp_domain(krb5kdc)
 log_domain(krb5kdc)
 allow krb5kdc_t urandom_device_t:chr_file { getattr read };
@@ -76,16 +76,16 @@
 #
 # Rules for Kerberos5 Kadmin daemon
 allow kadmind_t self:unix_dgram_socket { connect create write };
-allow kadmind_t krb5kdc_conf_t:dir { search };
+allow kadmind_t krb5kdc_conf_t:dir search;
 allow kadmind_t krb5kdc_conf_t:file r_file_perms;
 allow kadmind_t krb5kdc_principal_t:file { getattr lock read write setattr=
 };
 read_locale(kadmind_t)
-dontaudit kadmind_t krb5kdc_conf_t:file { write };
+dontaudit kadmind_t krb5kdc_conf_t:file write;
 tmp_domain(kadmind)
 log_domain(kadmind)
=20
 #
 # Allow user programs to talk to KDC
-allow krb5kdc_t userdomain:udp_socket { recvfrom };
-allow userdomain krb5kdc_t:udp_socket { recvfrom };
+allow krb5kdc_t userdomain:udp_socket recvfrom;
+allow userdomain krb5kdc_t:udp_socket recvfrom;
=20
diff -urN orig/domains/program/unused/kudzu.te mod/domains/program/unused/k=
udzu.te
--- orig/domains/program/unused/kudzu.te	2004-10-11 10:03:21.000000000 +0200
+++ mod/domains/program/unused/kudzu.te	2004-10-12 15:14:11.000000000 +0200
@@ -32,7 +32,7 @@
 allow kudzu_t usbfs_t:dir search;
 allow kudzu_t usbfs_t:file { getattr read };
 allow kudzu_t var_t:dir search;
-allow kudzu_t kernel_t:system { syslog_console };
+allow kudzu_t kernel_t:system syslog_console;
 allow kudzu_t self:udp_socket { create ioctl };
 allow kudzu_t var_lock_t:dir search;
 allow kudzu_t devpts_t:dir search;
@@ -61,7 +61,7 @@
 allow kudzu_t self:unix_dgram_socket create_socket_perms;
=20
 ifdef(`rhgb.te', `
-allow kudzu_t rhgb_t:unix_stream_socket { connectto };
+allow kudzu_t rhgb_t:unix_stream_socket connectto;
 ')
=20
 allow kudzu_t self:file { getattr read };
@@ -80,7 +80,7 @@
 allow kudzu_t sysfs_t:lnk_file read;
 file_type_auto_trans(kudzu_t, etc_t, etc_runtime_t, file)
 allow kudzu_t tape_device_t:chr_file r_file_perms;
-allow kudzu_t tmp_t:dir { search };
+allow kudzu_t tmp_t:dir search;
=20
 # for file systems that are not yet mounted
 dontaudit kudzu_t file_t:dir search;
diff -urN orig/domains/program/unused/lpd.te mod/domains/program/unused/lpd=
=2Ete
--- orig/domains/program/unused/lpd.te	2004-10-11 10:03:21.000000000 +0200
+++ mod/domains/program/unused/lpd.te	2004-10-12 15:14:11.000000000 +0200
@@ -94,7 +94,7 @@
 # running in the initrc_t domain can read the printer spool directory.
 # Perhaps executing /etc/rc.d/init.d/lpd should transition
 # to domain lpd_t, instead of waiting for executing lpd.
-allow initrc_t print_spool_t:dir { read };
+allow initrc_t print_spool_t:dir read;
=20
 # for defoma
 r_dir_file(lpd_t, readable_t)
@@ -152,5 +152,5 @@
 allow lpd_t etc_t:lnk_file read;
=20
 # checkpc needs similar permissions.
-allow checkpc_t printconf_t:file { getattr };
+allow checkpc_t printconf_t:file getattr;
 allow checkpc_t printconf_t:dir { getattr search read };
diff -urN orig/domains/program/unused/lrrd.te mod/domains/program/unused/lr=
rd.te
--- orig/domains/program/unused/lrrd.te	2004-09-11 14:31:46.000000000 +0200
+++ mod/domains/program/unused/lrrd.te	2004-10-12 15:14:11.000000000 +0200
@@ -38,8 +38,8 @@
 allow lrrd_t usr_t:file { read ioctl };
=20
 can_exec(lrrd_t, bin_t)
-allow lrrd_t bin_t:dir { search };
-allow lrrd_t usr_t:lnk_file { read };
+allow lrrd_t bin_t:dir search;
+allow lrrd_t usr_t:lnk_file read;
=20
 # Allow access to the lrrd databases
 create_dir_file(lrrd_t, lrrd_var_lib_t)
@@ -50,7 +50,7 @@
 allow lrrd_t { etc_t etc_runtime_t }:{ file lnk_file } { read getattr };
 # for accessing the output directory
 ifdef(`apache.te', `
-allow lrrd_t httpd_sys_content_t:dir { search };
+allow lrrd_t httpd_sys_content_t:dir search;
 ')
=20
 allow lrrd_t etc_t:dir search;
diff -urN orig/domains/program/unused/lvm.te mod/domains/program/unused/lvm=
=2Ete
--- orig/domains/program/unused/lvm.te	2004-10-11 10:03:22.000000000 +0200
+++ mod/domains/program/unused/lvm.te	2004-10-12 15:14:11.000000000 +0200
@@ -29,7 +29,7 @@
 domain_auto_trans(sysadm_t, lvm_exec_t, lvm_t)
=20
 # LVM will complain a lot if it cannot set its priority.
-allow lvm_t self:process { setsched };
+allow lvm_t self:process setsched;
=20
 allow lvm_t self:fifo_file rw_file_perms;
 allow lvm_t self:unix_dgram_socket create_socket_perms;
diff -urN orig/domains/program/unused/mailman.te mod/domains/program/unused=
/mailman.te
--- orig/domains/program/unused/mailman.te	2004-09-11 14:31:46.000000000 +0=
200
+++ mod/domains/program/unused/mailman.te	2004-10-12 15:14:11.000000000 +02=
00
@@ -99,4 +99,4 @@
=20
 # Handle mailman log files
 rw_dir_create_file(logrotate_t, mailman_log_t)
-allow logrotate_t mailman_data_t:dir { search };
+allow logrotate_t mailman_data_t:dir search;
diff -urN orig/domains/program/unused/mdadm.te mod/domains/program/unused/m=
dadm.te
--- orig/domains/program/unused/mdadm.te	2004-09-11 14:31:46.000000000 +0200
+++ mod/domains/program/unused/mdadm.te	2004-10-12 15:14:11.000000000 +0200
@@ -36,5 +36,5 @@
=20
 # Other random ignores
 dontaudit mdadm_t tmpfs_t:dir r_dir_perms;
-dontaudit mdadm_t initctl_t:fifo_file { getattr };
+dontaudit mdadm_t initctl_t:fifo_file getattr;
 var_run_domain(mdadm)
diff -urN orig/domains/program/unused/mrtg.te mod/domains/program/unused/mr=
tg.te
--- orig/domains/program/unused/mrtg.te	2004-09-11 14:31:46.000000000 +0200
+++ mod/domains/program/unused/mrtg.te	2004-10-12 15:14:11.000000000 +0200
@@ -95,4 +95,4 @@
=20
 allow mrtg_t self:capability { setgid setuid };
 can_exec(mrtg_t, hostname_exec_t)
-allow mrtg_t var_spool_t:dir { search };
+allow mrtg_t var_spool_t:dir search;
diff -urN orig/domains/program/unused/mysqld.te mod/domains/program/unused/=
mysqld.te
--- orig/domains/program/unused/mysqld.te	2004-10-11 10:03:22.000000000 +02=
00
+++ mod/domains/program/unused/mysqld.te	2004-10-12 15:14:11.000000000 +0200
@@ -30,7 +30,7 @@
=20
 allow mysqld_t self:fifo_file { read write };
 allow mysqld_t self:unix_stream_socket create_stream_socket_perms;
-allow initrc_t mysqld_t:unix_stream_socket { connectto };
+allow initrc_t mysqld_t:unix_stream_socket connectto;
 allow initrc_t mysqld_var_run_t:sock_file write;
=20
 allow initrc_t mysqld_log_t:file { write append setattr ioctl };
diff -urN orig/domains/program/unused/nscd.te mod/domains/program/unused/ns=
cd.te
--- orig/domains/program/unused/nscd.te	2004-10-11 10:03:22.000000000 +0200
+++ mod/domains/program/unused/nscd.te	2004-10-12 15:14:11.000000000 +0200
@@ -26,7 +26,7 @@
 allow domain nscd_var_run_t:sock_file rw_file_perms;
 allow domain { var_run_t var_t }:dir search;
 allow domain nscd_t:nscd { getpwd getgrp gethost };
-dontaudit domain nscd_t:fd { use };
+dontaudit domain nscd_t:fd use;
 dontaudit domain nscd_var_run_t:file { getattr read };
 dontaudit domain nscd_t:nscd { shmempwd shmemgrp shmemhost };
 ', `
@@ -34,7 +34,7 @@
 allow nscd_client_domain nscd_var_run_t:sock_file rw_file_perms;
 allow nscd_client_domain { var_run_t var_t }:dir search;
 allow nscd_client_domain nscd_t:nscd { getpwd getgrp gethost };
-dontaudit nscd_client_domain nscd_t:fd { use };
+dontaudit nscd_client_domain nscd_t:fd use;
 dontaudit nscd_client_domain nscd_var_run_t:file { getattr read };
 dontaudit nscd_client_domain nscd_t:nscd { shmempwd  shmemgrp shmemhost };
 ')dnl nscd_all_connect
diff -urN orig/domains/program/unused/nsd.te mod/domains/program/unused/nsd=
=2Ete
--- orig/domains/program/unused/nsd.te	2004-09-11 14:31:47.000000000 +0200
+++ mod/domains/program/unused/nsd.te	2004-10-12 15:14:11.000000000 +0200
@@ -38,7 +38,7 @@
 dontaudit nsd_crond_t sysadm_home_dir_t:dir { search getattr };
 dontaudit nsd_crond_t self:capability sys_nice;
 dontaudit nsd_crond_t domain:dir search;
-allow nsd_crond_t self:process { setsched };
+allow nsd_crond_t self:process setsched;
 can_ps(nsd_crond_t, nsd_t)
=20
 file_type_auto_trans(nsd_crond_t, nsd_conf_t, nsd_zone_t, file)
diff -urN orig/domains/program/unused/ntpd.te mod/domains/program/unused/nt=
pd.te
--- orig/domains/program/unused/ntpd.te	2004-10-11 10:03:22.000000000 +0200
+++ mod/domains/program/unused/ntpd.te	2004-10-12 15:14:11.000000000 +0200
@@ -68,5 +68,5 @@
 can_udp_send(sysadm_t, ntpd_t)
 can_udp_send(ntpd_t, ntpd_t)
 ifdef(`firstboot.te', `
-dontaudit ntpd_t firstboot_t:fd { use };
+dontaudit ntpd_t firstboot_t:fd use;
 ')
diff -urN orig/domains/program/unused/openca-ca.te mod/domains/program/unus=
ed/openca-ca.te
--- orig/domains/program/unused/openca-ca.te	2004-09-11 14:31:47.000000000 =
+0200
+++ mod/domains/program/unused/openca-ca.te	2004-10-12 15:14:11.000000000 +=
0200
@@ -36,14 +36,14 @@
=20
 allow httpd_t openca_ca_exec_t:file {execute getattr read};
 allow httpd_t openca_ca_t:process {signal sigkill sigstop};
-allow httpd_t openca_ca_t:process {transition};
+allow httpd_t openca_ca_t:process transition;
 allow httpd_t openca_ca_exec_t:dir r_dir_perms;
=20
 ##################################################################
 # Allow the script to get the file descriptor from the http deamon
 # and send sigchild to http deamon
 #################################################################
-allow openca_ca_t httpd_t:process {sigchld};
+allow openca_ca_t httpd_t:process sigchld;
 allow openca_ca_t httpd_t:fd use;
 allow openca_ca_t httpd_t:fifo_file {getattr write};
=20
@@ -61,8 +61,8 @@
 # The script needs to inherit the file descriptor and find the script it
 # needs to run
 ########################################################################
-allow openca_ca_t initrc_t:fd {use};
-allow openca_ca_t init_t:fd {use};
+allow openca_ca_t initrc_t:fd use;
+allow openca_ca_t init_t:fd use;
 allow openca_ca_t default_t:dir r_dir_perms;
 allow openca_ca_t random_device_t:chr_file r_file_perms;
=20
diff -urN orig/domains/program/unused/openvpn.te mod/domains/program/unused=
/openvpn.te
--- orig/domains/program/unused/openvpn.te	2004-07-26 22:16:10.000000000 +0=
200
+++ mod/domains/program/unused/openvpn.te	2004-10-12 15:14:11.000000000 +02=
00
@@ -21,11 +21,11 @@
 allow openvpn_t self:unix_stream_socket create_stream_socket_perms;
 allow openvpn_t self:unix_dgram_socket sendto;
 allow openvpn_t self:unix_stream_socket connectto;
-allow openvpn_t self:capability { net_admin };
+allow openvpn_t self:capability net_admin;
 r_dir_file(openvpn_t, sysctl_net_t)
=20
 can_network(openvpn_t)
-allow openvpn_t openvpn_port_t:udp_socket { name_bind };
+allow openvpn_t openvpn_port_t:udp_socket name_bind;
=20
 # OpenVPN executes a lot of helper programs and scripts
 allow openvpn_t { bin_t sbin_t }:dir { search getattr };
diff -urN orig/domains/program/unused/pamconsole.te mod/domains/program/unu=
sed/pamconsole.te
--- orig/domains/program/unused/pamconsole.te	2004-09-11 14:31:47.000000000=
 +0200
+++ mod/domains/program/unused/pamconsole.te	2004-10-12 15:14:11.000000000 =
+0200
@@ -33,10 +33,10 @@
 allow pam_console_t gpmctl_t:sock_file { getattr setattr };
 ')
 ifdef(`hotplug.te', `
-dontaudit pam_console_t hotplug_etc_t:dir { search };
-allow pam_console_t hotplug_t:fd { use };
+dontaudit pam_console_t hotplug_etc_t:dir search;
+allow pam_console_t hotplug_t:fd use;
 ')
-allow pam_console_t proc_t:file { read };
+allow pam_console_t proc_t:file read;
 ifdef(`xdm.te', `
 allow pam_console_t xdm_var_run_t:file { getattr read };
 ')
diff -urN orig/domains/program/unused/postfix.te mod/domains/program/unused=
/postfix.te
--- orig/domains/program/unused/postfix.te	2004-10-12 15:13:58.000000000 +0=
200
+++ mod/domains/program/unused/postfix.te	2004-10-12 15:14:11.000000000 +02=
00
@@ -192,7 +192,7 @@
 domain_auto_trans(postfix_local_t, procmail_exec_t, procmail_t)
 # for a bug in the postfix local program
 dontaudit procmail_t postfix_local_t:tcp_socket { read write };
-dontaudit procmail_t postfix_master_t:fd { use };
+dontaudit procmail_t postfix_master_t:fd use;
 ')
 allow postfix_local_t etc_aliases_t:file r_file_perms;
 allow postfix_local_t self:fifo_file rw_file_perms;
@@ -218,7 +218,7 @@
 allow postfix_cleanup_t postfix_private_t:dir search;
 allow postfix_cleanup_t postfix_private_t:sock_file rw_file_perms;
 allow postfix_cleanup_t postfix_master_t:unix_stream_socket connectto;
-allow postfix_cleanup_t { postfix_spool_bounce_t }:dir r_dir_perms;
+allow postfix_cleanup_t postfix_spool_bounce_t:dir r_dir_perms;
 allow postfix_cleanup_t self:process setrlimit;
=20
 allow user_mail_domain postfix_spool_t:dir r_dir_perms;
@@ -313,7 +313,7 @@
 create_dir_file(postfix_bounce_t, postfix_spool_t)
 allow postfix_master_t postfix_spool_bounce_t:dir create_dir_perms;
 allow postfix_master_t postfix_spool_bounce_t:file getattr;
-allow postfix_bounce_t self:capability { dac_read_search };
+allow postfix_bounce_t self:capability dac_read_search;
 allow postfix_bounce_t postfix_public_t:sock_file write;
 allow postfix_bounce_t self:tcp_socket create_socket_perms;
=20
@@ -329,7 +329,7 @@
 domain_auto_trans(postfix_pipe_t, procmail_exec_t, procmail_t)
 ')
 ifdef(`sendmail.te', `
-allow sendmail_t postfix_etc_t:dir { search };
+allow sendmail_t postfix_etc_t:dir search;
 ')
=20
 # Program for creating database files
@@ -340,7 +340,7 @@
 create_dir_file(postfix_map_t, postfix_etc_t)
 allow postfix_map_t self:unix_stream_socket create_stream_socket_perms;
 dontaudit postfix_map_t proc_t:dir { getattr read search };
-dontaudit postfix_map_t local_login_t:fd { use };
+dontaudit postfix_map_t local_login_t:fd use;
 allow postfix_master_t postfix_map_exec_t:file rx_file_perms;
 read_locale(postfix_map_t)
 allow postfix_map_t self:capability setgid;
diff -urN orig/domains/program/unused/prelink.te mod/domains/program/unused=
/prelink.te
--- orig/domains/program/unused/prelink.te	2004-09-11 14:31:47.000000000 +0=
200
+++ mod/domains/program/unused/prelink.te	2004-10-12 15:14:11.000000000 +02=
00
@@ -18,7 +18,7 @@
 allow system_crond_t prelink_log_t:dir rw_dir_perms;
 allow system_crond_t prelink_log_t:file create_file_perms;
 allow system_crond_t prelink_cache_t:file { getattr read unlink };
-allow prelink_t crond_log_t:file { append };
+allow prelink_t crond_log_t:file append;
 ')
=20
 logdir_domain(prelink)
@@ -39,7 +39,7 @@
 dontaudit prelink_t sysctl_t:dir search;
 allow prelink_t etc_runtime_t:file { getattr read };
 read_locale(prelink_t)
-allow prelink_t urandom_device_t:chr_file { read };
+allow prelink_t urandom_device_t:chr_file read;
 allow prelink_t proc_t:file { getattr read };
 #
 # prelink_cache_t is the type of /etc/prelink.cache.
diff -urN orig/domains/program/unused/qmail.te mod/domains/program/unused/q=
mail.te
--- orig/domains/program/unused/qmail.te	2004-10-12 15:13:58.000000000 +0200
+++ mod/domains/program/unused/qmail.te	2004-10-12 15:14:11.000000000 +0200
@@ -144,7 +144,7 @@
=20
 qmaild_sub_domain(user_mail_domain, qmail_inject, `, mta_user_agent')
 allow qmail_inject_t self:process { fork signal_perms };
-allow qmail_inject_t self:fifo_file { write };
+allow qmail_inject_t self:fifo_file write;
 allow qmail_inject_t sbin_t:dir search;
 role sysadm_r types qmail_inject_t;
 in_user_role(qmail_inject_t)
diff -urN orig/domains/program/unused/quota.te mod/domains/program/unused/q=
uota.te
--- orig/domains/program/unused/quota.te	2004-10-11 10:03:22.000000000 +0200
+++ mod/domains/program/unused/quota.te	2004-10-12 15:14:11.000000000 +0200
@@ -54,4 +54,4 @@
=20
 allow quota_t initrc_devpts_t:chr_file rw_file_perms;
=20
-allow quota_t proc_t:file { getattr };
+allow quota_t proc_t:file getattr;
diff -urN orig/domains/program/unused/radvd.te mod/domains/program/unused/r=
advd.te
--- orig/domains/program/unused/radvd.te	2004-03-03 21:53:51.000000000 +0100
+++ mod/domains/program/unused/radvd.te	2004-10-12 15:14:11.000000000 +0200
@@ -15,7 +15,7 @@
=20
 allow radvd_t self:{ rawip_socket unix_dgram_socket } rw_socket_perms;
=20
-allow radvd_t self:capability { net_raw };
+allow radvd_t self:capability net_raw;
 allow radvd_t self:{ unix_dgram_socket rawip_socket } create;
 allow radvd_t self:unix_stream_socket create_socket_perms;
=20
diff -urN orig/domains/program/unused/rhgb.te mod/domains/program/unused/rh=
gb.te
--- orig/domains/program/unused/rhgb.te	2004-10-11 10:03:22.000000000 +0200
+++ mod/domains/program/unused/rhgb.te	2004-10-12 15:14:11.000000000 +0200
@@ -37,7 +37,7 @@
 allow rhgb_t ramfs_t:filesystem { mount unmount };
 allow rhgb_t mnt_t:dir { search mounton };
 allow rhgb_t self:capability { sys_admin sys_tty_config };
-dontaudit rhgb_t var_run_t:dir { search };
+dontaudit rhgb_t var_run_t:dir search;
=20
 can_network(rhgb_t)
 can_ypbind(rhgb_t)
@@ -77,7 +77,7 @@
 # for a bug in the X server
 dontaudit insmod_t xdm_xserver_t:tcp_socket { read write };
 dontaudit insmod_t serial_device:chr_file { read write };
-dontaudit mount_t rhgb_gph_t:fd { use };
+dontaudit mount_t rhgb_gph_t:fd use;
 dontaudit mount_t rhgb_t:unix_stream_socket { read write };
 dontaudit mount_t ptmx_t:chr_file { read write };
 ')dnl end hide_broken_symptoms
@@ -85,9 +85,9 @@
 ifdef(`firstboot.te', `
 allow rhgb_t firstboot_rw_t:file r_file_perms;
 ')
-dontaudit rhgb_t tmp_t:dir { search };
-allow rhgb_t xdm_xserver_t:process { sigkill };
+dontaudit rhgb_t tmp_t:dir search;
+allow rhgb_t xdm_xserver_t:process sigkill;
 allow domain rhgb_devpts_t:chr_file { read write };
 ifdef(`fsadm.te', `
-dontaudit fsadm_t ramfs_t:fifo_file { write };
+dontaudit fsadm_t ramfs_t:fifo_file write;
 ')
diff -urN orig/domains/program/unused/rpcd.te mod/domains/program/unused/rp=
cd.te
--- orig/domains/program/unused/rpcd.te	2004-10-11 10:03:23.000000000 +0200
+++ mod/domains/program/unused/rpcd.te	2004-10-12 15:14:11.000000000 +0200
@@ -19,7 +19,7 @@
 allow $1_t self:capability net_bind_service;
=20
 allow $1_t var_t:dir { getattr search };
-allow $1_t var_lib_t:dir { search };
+allow $1_t var_lib_t:dir search;
 allow $1_t var_lib_nfs_t:dir create_dir_perms;
 allow $1_t var_lib_nfs_t:file create_file_perms;
 # do not log when it tries to bind to a port belonging to another domain
@@ -89,7 +89,7 @@
 create_dir_file(kernel_t,{ file_type -shadow_t })
 }
=20
-dontaudit kernel_t shadow_t:file { getattr };
+dontaudit kernel_t shadow_t:file getattr;
=20
 bool nfs_export_all_ro false;
=20
diff -urN orig/domains/program/unused/rpm.te mod/domains/program/unused/rpm=
=2Ete
--- orig/domains/program/unused/rpm.te	2004-10-11 10:03:23.000000000 +0200
+++ mod/domains/program/unused/rpm.te	2004-10-12 15:14:11.000000000 +0200
@@ -68,7 +68,7 @@
=20
 ifdef(`gpg.te', `
 # gpg wants this so it does not dump core on errors
-allow rpm_t self:process { setrlimit };
+allow rpm_t self:process setrlimit;
 ')
=20
 # for a bug in rm
@@ -115,7 +115,7 @@
 allow rpm_t { device_t device_type }:{ chr_file blk_file } { create_file_p=
erms relabelfrom relabelto };
 allow rpm_t ttyfile:chr_file unlink;
 allow rpm_script_t tty_device_t:chr_file getattr;
-allow rpm_script_t devpts_t:dir { search };
+allow rpm_script_t devpts_t:dir search;
 allow rpm_script_t {devpts_t devtty_t}:chr_file rw_file_perms;
=20
 allow { insmod_t depmod_t } rpm_t:fifo_file rw_file_perms;
@@ -179,7 +179,7 @@
 allow rpm_script_t devpts_t:dir r_dir_perms;
 allow rpm_script_t admin_tty_type:chr_file rw_file_perms;
 allow rpm_script_t etc_runtime_t:file { getattr read };
-allow rpm_script_t privfd:fd { use };
+allow rpm_script_t privfd:fd use;
 allow rpm_script_t rpm_tmp_t:file { getattr read ioctl };
=20
 allow rpm_script_t urandom_device_t:chr_file read;
@@ -214,10 +214,10 @@
 allow rpm_script_t nfs_t:filesystem getattr;
=20
 allow rpm_script_t fs_t:filesystem { getattr mount unmount };
-allow rpm_script_t rpm_script_tmp_t:dir { mounton };
+allow rpm_script_t rpm_script_tmp_t:dir mounton;
 can_exec(rpm_script_t, usr_t)
=20
-allow rpm_t mount_t:tcp_socket { write };
+allow rpm_t mount_t:tcp_socket write;
 create_dir_file(rpm_t, nfs_t)
 allow rpm_t { removable_t nfs_t }:filesystem getattr;
=20
@@ -227,8 +227,8 @@
 allow domain rpm_t:fd use;
=20
 ifdef(`ssh.te', `
-allow sshd_t rpm_script_t:fd { use };
-allow sshd_t rpm_t:fd { use };
+allow sshd_t rpm_script_t:fd use;
+allow sshd_t rpm_t:fd use;
 ')
=20
 dontaudit rpm_script_t shadow_t:file getattr;
@@ -243,12 +243,12 @@
=20
 type rpmbuild_exec_t, file_type, sysadmfile, exec_type;
 type rpmbuild_t, domain;
-allow rpmbuild_t policy_config_t:dir { search };
-allow rpmbuild_t policy_src_t:dir { search };
+allow rpmbuild_t policy_config_t:dir search;
+allow rpmbuild_t policy_src_t:dir search;
 allow rpmbuild_t policy_src_t:file { getattr read };
 can_getsecurity(rpmbuild_t)
=20
-allow rpm_script_t userdomain:process { signal };
+allow rpm_script_t userdomain:process signal;
=20
 ifdef(`unlimitedRPM', `
 unconfined_domain(rpm_t)
diff -urN orig/domains/program/unused/samba.te mod/domains/program/unused/s=
amba.te
--- orig/domains/program/unused/samba.te	2004-10-11 10:03:24.000000000 +0200
+++ mod/domains/program/unused/samba.te	2004-10-12 15:14:11.000000000 +0200
@@ -94,7 +94,7 @@
 allow nmbd_t nmbd_port_t:udp_socket name_bind;
=20
 # Use capabilities.
-allow nmbd_t self:capability { net_bind_service };
+allow nmbd_t self:capability net_bind_service;
=20
 # Use the network.
 can_network(nmbd_t)
diff -urN orig/domains/program/unused/saslauthd.te mod/domains/program/unus=
ed/saslauthd.te
--- orig/domains/program/unused/saslauthd.te	2004-06-24 14:50:07.000000000 =
+0200
+++ mod/domains/program/unused/saslauthd.te	2004-10-12 15:14:11.000000000 +=
0200
@@ -15,9 +15,9 @@
 allow saslauthd_t net_conf_t:file r_file_perms;
=20
 allow saslauthd_t self:file r_file_perms;
-allow saslauthd_t proc_t:file { read };
+allow saslauthd_t proc_t:file read;
=20
 allow saslauthd_t urandom_device_t:chr_file { getattr read };=20
=20
 # Needs investigation
-dontaudit saslauthd_t home_root_t:dir { getattr };
+dontaudit saslauthd_t home_root_t:dir getattr;
diff -urN orig/domains/program/unused/sendmail.te mod/domains/program/unuse=
d/sendmail.te
--- orig/domains/program/unused/sendmail.te	2004-10-11 10:03:24.000000000 +=
0200
+++ mod/domains/program/unused/sendmail.te	2004-10-12 15:14:11.000000000 +0=
200
@@ -97,5 +97,5 @@
 allow system_mail_t mqueue_spool_t:file create_file_perms;
=20
 allow system_mail_t sysctl_kernel_t:file read;
-dontaudit system_mail_t system_crond_tmp_t:file { append };
+dontaudit system_mail_t system_crond_tmp_t:file append;
 dontaudit sendmail_t admin_tty_type:chr_file { getattr ioctl };
diff -urN orig/domains/program/unused/seuser.te mod/domains/program/unused/=
seuser.te
--- orig/domains/program/unused/seuser.te	2004-03-17 19:26:05.000000000 +01=
00
+++ mod/domains/program/unused/seuser.te	2004-10-12 15:14:11.000000000 +0200
@@ -38,10 +38,10 @@
 allow seuser_t self:process { fork sigchld };
 allow seuser_t self:fifo_file read;
 allow seuser_t self:unix_stream_socket {create connect};
-allow seuser_t self:dir {search};
+allow seuser_t self:dir search;
 allow seuser_t self:file { read getattr };
=20
-allow seuser_t etc_t:dir { search };
+allow seuser_t etc_t:dir search;
 allow seuser_t etc_t:{lnk_file file} { read getattr};
 read_locale(seuser_t)
 allow seuser_t { var_run_t var_t}:dir search;
@@ -52,8 +52,8 @@
 allow seuser_t proc_t:dir search;
 allow seuser_t proc_t:{lnk_file file} { getattr read };
=20
-allow seuser_t root_t:dir { search };
-allow seuser_t staff_home_dir_t:dir {search };
+allow seuser_t root_t:dir search;
+allow seuser_t staff_home_dir_t:dir search;
 allow seuser_t home_root_t:dir { getattr search };
 allow seuser_t staff_home_dir_t:dir getattr;
 allow seuser_t default_t:file {read getattr};
@@ -126,10 +126,10 @@
 # Xserver section - To support our GUI interface,=20
 ############################################################
 # Permission to create files in /tmp/.X11-Unix
-#allow seuser_t sysadm_xserver_tmp_t:dir { search } ;
-#allow seuser_t sysadm_xserver_tmp_t:sock_file { write } ;
-#allow seuser_t user_xserver_tmp_t:dir { search } ;
-#allow seuser_t user_xserver_tmp_t:sock_file { write } ;
+#allow seuser_t sysadm_xserver_tmp_t:dir search ;
+#allow seuser_t sysadm_xserver_tmp_t:sock_file write ;
+#allow seuser_t user_xserver_tmp_t:dir search ;
+#allow seuser_t user_xserver_tmp_t:sock_file write ;
=20
 # Permission to establish a Unix stream connection to X server
 #can_unix_connect(seuser_t, user_xserver_t)
diff -urN orig/domains/program/unused/slocate.te mod/domains/program/unused=
/slocate.te
--- orig/domains/program/unused/slocate.te	2004-10-12 15:13:58.000000000 +0=
200
+++ mod/domains/program/unused/slocate.te	2004-10-12 15:14:11.000000000 +02=
00
@@ -26,8 +26,8 @@
 allow locate_t file_type:lnk_file r_file_perms;
 allow locate_t { root_dir_type file_type -shadow_t }:{ lnk_file sock_file =
fifo_file file } getattr;
 dontaudit locate_t { file_type -shadow_t }:{ lnk_file sock_file fifo_file =
file } read;
-dontaudit locate_t security_t:dir { getattr };
-dontaudit locate_t shadow_t:file { getattr };
+dontaudit locate_t security_t:dir getattr;
+dontaudit locate_t shadow_t:file getattr;
=20
 allow locate_t { ttyfile device_type device_t }:{ chr_file blk_file } geta=
ttr;
 allow locate_t unlabeled_t:dir_file_class_set getattr;
@@ -50,7 +50,7 @@
 can_exec(locate_t, bin_t)
=20
 dontaudit locate_t rpc_pipefs_t:dir r_dir_perms;
-dontaudit locate_t rpc_pipefs_t:file { getattr };
+dontaudit locate_t rpc_pipefs_t:file getattr;
=20
 #
 # Read Mtab file
@@ -69,4 +69,4 @@
 # which often refers to $1_locate_t for the user domains.
 typealias sysadm_t alias sysadm_locate_t;
=20
-allow locate_t userdomain:fd { use };
+allow locate_t userdomain:fd use;
diff -urN orig/domains/program/unused/slrnpull.te mod/domains/program/unuse=
d/slrnpull.te
--- orig/domains/program/unused/slrnpull.te	2004-10-11 10:03:24.000000000 +=
0200
+++ mod/domains/program/unused/slrnpull.te	2004-10-12 15:14:11.000000000 +0=
200
@@ -18,6 +18,6 @@
 create_dir_file(logrotate_t, slrnpull_spool_t)
 ')
 system_crond_entry(slrnpull_exec_t, slrnpull_t)
-allow userdomain slrnpull_spool_t:dir { search };
+allow userdomain slrnpull_spool_t:dir search;
 rw_dir_create_file(slrnpull_t, slrnpull_spool_t)
-allow slrnpull_t var_spool_t:dir { search };
+allow slrnpull_t var_spool_t:dir search;
diff -urN orig/domains/program/unused/snmpd.te mod/domains/program/unused/s=
nmpd.te
--- orig/domains/program/unused/snmpd.te	2004-10-11 10:03:24.000000000 +0200
+++ mod/domains/program/unused/snmpd.te	2004-10-12 15:14:11.000000000 +0200
@@ -49,8 +49,8 @@
 ifdef(`distro_redhat', `
 ifdef(`rpm.te', `
 r_dir_file(snmpd_t, rpm_var_lib_t)
-dontaudit snmpd_t rpm_var_lib_t:dir { write };
-dontaudit snmpd_t rpm_var_lib_t:file { write };
+dontaudit snmpd_t rpm_var_lib_t:dir write;
+dontaudit snmpd_t rpm_var_lib_t:file write;
 ')
 ')
=20
@@ -58,7 +58,7 @@
 allow snmpd_t initrc_var_run_t:file r_file_perms;
 dontaudit snmpd_t initrc_var_run_t:file write;
 dontaudit snmpd_t rpc_pipefs_t:dir getattr;
-allow snmpd_t rpc_pipefs_t:dir { getattr };
+allow snmpd_t rpc_pipefs_t:dir getattr;
 read_sysctl(snmpd_t)
 dontaudit snmpd_t { removable_device_t fixed_disk_device_t }:blk_file { ge=
tattr ioctl read };
 allow snmpd_t sysfs_t:dir { getattr read search };
@@ -72,4 +72,4 @@
=20
 dontaudit snmpd_t domain:dir { getattr search };
=20
-dontaudit snmpd_t selinux_config_t:dir { search };
+dontaudit snmpd_t selinux_config_t:dir search;
diff -urN orig/domains/program/unused/spamd.te mod/domains/program/unused/s=
pamd.te
--- orig/domains/program/unused/spamd.te	2004-10-11 10:03:24.000000000 +0200
+++ mod/domains/program/unused/spamd.te	2004-10-12 15:14:11.000000000 +0200
@@ -24,7 +24,7 @@
 dontaudit spamd_t sysadm_home_dir_t:dir getattr;
=20
 can_network(spamd_t)
-allow spamd_t self:capability { net_bind_service };
+allow spamd_t self:capability net_bind_service;
=20
 allow spamd_t proc_t:file { getattr read };
=20
@@ -63,5 +63,5 @@
 allow spamd_t nfs_t:file create_file_perms;
 ')dnl end if nfs_home_dirs
=20
-allow spamd_t home_root_t:dir { getattr };
+allow spamd_t home_root_t:dir getattr;
=20
diff -urN orig/domains/program/unused/squid.te mod/domains/program/unused/s=
quid.te
--- orig/domains/program/unused/squid.te	2004-10-12 15:13:58.000000000 +0200
+++ mod/domains/program/unused/squid.te	2004-10-12 15:14:11.000000000 +0200
@@ -35,7 +35,7 @@
 allow squid_t self:fifo_file rw_file_perms;
=20
 allow squid_t { sysctl_t sysctl_kernel_t }:dir search;
-allow squid_t { sysctl_kernel_t }:file read;
+allow squid_t sysctl_kernel_t:file read;
=20
 allow squid_t devtty_t:chr_file rw_file_perms;
=20
diff -urN orig/domains/program/unused/udev.te mod/domains/program/unused/ud=
ev.te
--- orig/domains/program/unused/udev.te	2004-10-12 15:13:58.000000000 +0200
+++ mod/domains/program/unused/udev.te	2004-10-12 15:14:11.000000000 +0200
@@ -50,8 +50,8 @@
 # to read the file_contexts file
 r_dir_file(udev_t, { selinux_config_t file_context_t default_context_t } )
=20
-allow udev_t policy_config_t:dir { search };
-allow udev_t proc_t:file { read };
+allow udev_t policy_config_t:dir search;
+allow udev_t proc_t:file read;
=20
 # Get security policy decisions.
 can_getsecurity(udev_t)
@@ -59,7 +59,7 @@
 # set file system create context
 can_setfscreate(udev_t)
=20
-allow udev_t kernel_t:fd { use };
+allow udev_t kernel_t:fd use;
 allow udev_t kernel_t:unix_dgram_socket { sendto ioctl read write };
=20
 allow udev_t initrc_var_run_t:file r_file_perms;
@@ -71,10 +71,10 @@
 ifdef(`hide_broken_symptoms', `
 dontaudit restorecon_t udev_t:unix_dgram_socket { read write };
 ')
-allow udev_t devpts_t:dir { search };
+allow udev_t devpts_t:dir search;
 allow udev_t etc_runtime_t:file { getattr read };
-allow udev_t etc_t:file { ioctl };
-allow udev_t proc_t:file { getattr };
+allow udev_t etc_t:file ioctl;
+allow udev_t proc_t:file getattr;
 ifdef(`xdm.te', `
 allow udev_t xdm_var_run_t:file { getattr read };
 ')
@@ -82,7 +82,7 @@
 ifdef(`hotplug.te', `
 r_dir_file(udev_t, hotplug_etc_t)
 ')
-allow udev_t var_log_t:dir { search };
+allow udev_t var_log_t:dir search;
=20
 ifdef(`pamconsole.te', `
 allow udev_t pam_var_console_t:dir search;
@@ -105,7 +105,7 @@
 dbusd_client(system, udev_t)
=20
 allow udev_t device_t:dir { relabelfrom relabelto create_dir_perms };
-allow udev_t sysctl_dev_t:dir { search };
+allow udev_t sysctl_dev_t:dir search;
 allow udev_t sysctl_dev_t:file { getattr read };
 allow udev_t sysctl_modprobe_t:file { getattr read };
 allow udev_t self:rawip_socket create_socket_perms;
diff -urN orig/domains/program/unused/uml_net.te mod/domains/program/unused=
/uml_net.te
--- orig/domains/program/unused/uml_net.te	2004-03-03 21:53:51.000000000 +0=
100
+++ mod/domains/program/unused/uml_net.te	2004-10-12 15:14:11.000000000 +02=
00
@@ -24,7 +24,7 @@
 dontaudit uml_net_t sysctl_net_t:file write;
=20
 dontaudit ifconfig_t uml_net_t:udp_socket { read write };
-dontaudit uml_net_t self:capability { sys_module };
+dontaudit uml_net_t self:capability sys_module;
=20
 allow uml_net_t tun_tap_device_t:chr_file { read write getattr ioctl };
 can_exec(uml_net_t, { shell_exec_t sbin_t })
diff -urN orig/domains/program/unused/updfstab.te mod/domains/program/unuse=
d/updfstab.te
--- orig/domains/program/unused/updfstab.te	2004-09-23 11:38:29.000000000 +=
0200
+++ mod/domains/program/unused/updfstab.te	2004-10-12 15:14:11.000000000 +0=
200
@@ -55,7 +55,7 @@
 ifdef(`pamconsole.te', `
 domain_auto_trans(updfstab_t, pam_console_exec_t, pam_console_t)
 ')
-allow updfstab_t kernel_t:system { syslog_console };
+allow updfstab_t kernel_t:system syslog_console;
 allow updfstab_t sysadm_tty_device_t:chr_file { read write };
 allow updfstab_t self:capability dac_override;
 dontaudit updfstab_t self:capability sys_admin;
@@ -68,4 +68,4 @@
 allow updfstab_t self:fifo_file { getattr read write ioctl };
 can_exec(updfstab_t, { sbin_t bin_t ls_exec_t } )
 dontaudit updfstab_t home_root_t:dir { getattr search };
-dontaudit updfstab_t { home_dir_type home_type }:dir { search };
+dontaudit updfstab_t { home_dir_type home_type }:dir search;
diff -urN orig/domains/program/unused/userhelper.te mod/domains/program/unu=
sed/userhelper.te
--- orig/domains/program/unused/userhelper.te	2004-07-08 08:57:11.000000000=
 +0200
+++ mod/domains/program/unused/userhelper.te	2004-10-12 15:14:11.000000000 =
+0200
@@ -18,5 +18,5 @@
 # macros/program/userhelper_macros.te.
=20
 ifdef(`xdm.te', `
-dontaudit xdm_t userhelper_conf_t:dir { search };
+dontaudit xdm_t userhelper_conf_t:dir search;
 ')
diff -urN orig/domains/program/unused/usernetctl.te mod/domains/program/unu=
sed/usernetctl.te
--- orig/domains/program/unused/usernetctl.te	2004-05-27 20:52:35.000000000=
 +0200
+++ mod/domains/program/unused/usernetctl.te	2004-10-12 15:14:11.000000000 =
+0200
@@ -47,12 +47,12 @@
 general_domain_access(usernetctl_t)
=20
 r_dir_file(usernetctl_t, proc_t)
-dontaudit usernetctl_t { domain - usernetctl_t }:dir { search };
+dontaudit usernetctl_t { domain - usernetctl_t }:dir search;
=20
 allow usernetctl_t userpty_type:chr_file rw_file_perms;
=20
 can_exec(usernetctl_t, { bin_t sbin_t shell_exec_t usernetctl_exec_t})
-can_exec(usernetctl_t, { etc_t })
+can_exec(usernetctl_t, etc_t)
=20
 r_dir_file(usernetctl_t, etc_t)
 allow usernetctl_t { var_t var_run_t }:dir { getattr read search };
diff -urN orig/domains/program/unused/utempter.te mod/domains/program/unuse=
d/utempter.te
--- orig/domains/program/unused/utempter.te	2004-10-12 15:13:58.000000000 +=
0200
+++ mod/domains/program/unused/utempter.te	2004-10-12 15:14:11.000000000 +0=
200
@@ -20,7 +20,7 @@
 domain_auto_trans(userdomain, utempter_exec_t, utempter_t)
=20
 # Use capabilities.
-allow utempter_t self:capability { setgid };
+allow utempter_t self:capability setgid;
=20
 allow utempter_t etc_t:file { getattr read };
=20
@@ -39,7 +39,7 @@
 # Inherit and use descriptors from login.
 allow utempter_t privfd:fd use;
 ifdef(`xdm.te', `
-allow utempter_t xdm_t:fd { use };
+allow utempter_t xdm_t:fd use;
 allow utempter_t xdm_t:fifo_file { write getattr };
 ')
=20
diff -urN orig/domains/program/unused/uwimapd.te mod/domains/program/unused=
/uwimapd.te
--- orig/domains/program/unused/uwimapd.te	2004-07-12 23:41:14.000000000 +0=
200
+++ mod/domains/program/unused/uwimapd.te	2004-10-12 15:14:11.000000000 +02=
00
@@ -22,7 +22,7 @@
 ifdef(`tcpd.te', `domain_auto_trans(tcpd_t, imapd_exec_t, imapd_t)')
=20
 #friendly stuff we dont want to see :)
-dontaudit imapd_t bin_t:dir { search };
+dontaudit imapd_t bin_t:dir search;
=20
 #read /etc/ for hostname nsswitch.conf
 allow imapd_t etc_t:file { getattr read };
@@ -34,7 +34,7 @@
 allow imapd_t net_conf_t:file { getattr read };
=20
 #urandom, for ssl
-allow imapd_t random_device_t:chr_file { read };
+allow imapd_t random_device_t:chr_file read;
 allow imapd_t urandom_device_t:chr_file { read getattr };
=20
 allow imapd_t self:fifo_file rw_file_perms;
@@ -43,5 +43,5 @@
 rw_dir_file(imapd_t, mail_spool_t)
=20
 #home directory
-allow imapd_t home_root_t:dir { search };
+allow imapd_t home_root_t:dir search;
 allow imapd_t self:file { read getattr };
diff -urN orig/domains/program/unused/vmware.te mod/domains/program/unused/=
vmware.te
--- orig/domains/program/unused/vmware.te	2004-09-25 19:52:49.000000000 +02=
00
+++ mod/domains/program/unused/vmware.te	2004-10-12 15:14:11.000000000 +0200
@@ -47,6 +47,6 @@
 ')
=20
 # Vmware create network devices
-allow kernel_t self:capability { net_admin };
+allow kernel_t self:capability net_admin;
 allow kernel_t self:netlink_route_socket { bind create getattr nlmsg_read =
nlmsg_write read write };
-allow kernel_t self:socket { create };
+allow kernel_t self:socket create;
diff -urN orig/domains/program/unused/watchdog.te mod/domains/program/unuse=
d/watchdog.te
--- orig/domains/program/unused/watchdog.te	2004-10-12 15:13:58.000000000 +=
0200
+++ mod/domains/program/unused/watchdog.te	2004-10-12 15:14:11.000000000 +0=
200
@@ -36,7 +36,7 @@
 # for orderly shutdown
 can_exec(watchdog_t, shell_exec_t)
 allow watchdog_t domain:process { signal_perms getsession };
-allow watchdog_t self:capability { kill };
+allow watchdog_t self:capability kill;
 allow watchdog_t sbin_t:dir search;
=20
 # for updating mtab on umount
diff -urN orig/domains/program/unused/webalizer.te mod/domains/program/unus=
ed/webalizer.te
--- orig/domains/program/unused/webalizer.te	2004-08-06 21:07:34.000000000 =
+0200
+++ mod/domains/program/unused/webalizer.te	2004-10-12 15:14:11.000000000 +=
0200
@@ -36,7 +36,7 @@
=20
 # can read /proc
 read_sysctl(webalizer_t)
-allow webalizer_t proc_t:dir { search };
+allow webalizer_t proc_t:dir search;
 allow webalizer_t proc_t:file r_file_perms;
=20
 # network
@@ -45,4 +45,4 @@
 #process communication inside webalizer itself
 general_domain_access(webalizer_t)
=20
-allow webalizer_t self:capability { dac_override };
+allow webalizer_t self:capability dac_override;
diff -urN orig/domains/program/unused/xdm.te mod/domains/program/unused/xdm=
=2Ete
--- orig/domains/program/unused/xdm.te	2004-10-12 15:13:58.000000000 +0200
+++ mod/domains/program/unused/xdm.te	2004-10-12 15:14:11.000000000 +0200
@@ -42,7 +42,7 @@
 type xdm_rw_etc_t, file_type, sysadmfile;
 typealias xdm_rw_etc_t alias etc_xdm_t;
=20
-allow xdm_t default_context_t:dir { search };
+allow xdm_t default_context_t:dir search;
 allow xdm_t default_context_t:file { read getattr };
=20
 can_network(xdm_t)
@@ -87,7 +87,7 @@
=20
 # gnome-session creates socket under /tmp/.ICE-unix/
 allow unpriv_userdomain xdm_tmp_t:dir rw_dir_perms;
-allow unpriv_userdomain xdm_tmp_t:sock_file { create };
+allow unpriv_userdomain xdm_tmp_t:sock_file create;
=20
 # Allow xdm logins as sysadm_r:sysadm_t
 bool xdm_sysadm_login false;
@@ -119,7 +119,7 @@
=20
 # Access devices.
 allow xdm_t device_t:dir { read search };
-allow xdm_t console_device_t:chr_file { setattr };
+allow xdm_t console_device_t:chr_file setattr;
 allow xdm_t framebuf_device_t:chr_file { getattr setattr };
 allow xdm_t mouse_device_t:chr_file { getattr setattr };
 allow xdm_t apm_bios_t:chr_file { setattr getattr read write };
@@ -148,7 +148,7 @@
=20
 # Remove /tmp/.X11-unix/X0.
 allow xdm_t xdm_xserver_tmp_t:dir { remove_name write };
-allow xdm_t xdm_xserver_tmp_t:sock_file { unlink };
+allow xdm_t xdm_xserver_tmp_t:sock_file unlink;
=20
 ifdef(`gpm.te', `
 # Talk to the console mouse server.
@@ -160,7 +160,7 @@
=20
 # Update utmp and wtmp.
 allow xdm_t initrc_var_run_t: file { read write lock };
-allow xdm_t wtmp_t:file { append };
+allow xdm_t wtmp_t:file append;
=20
 # Update lastlog.
 allow xdm_t lastlog_t:file rw_file_perms;
@@ -215,7 +215,7 @@
 dontaudit xdm_t misc_device_t:file_class_set rw_file_perms;
 dontaudit xdm_t removable_device_t:file_class_set rw_file_perms;
 dontaudit xdm_t scsi_generic_device_t:file_class_set rw_file_perms;
-dontaudit xdm_t devpts_t:dir { search };
+dontaudit xdm_t devpts_t:dir search;
=20
 # Do not audit denied probes of /proc.
 dontaudit xdm_t domain:dir r_dir_perms;
@@ -293,12 +293,12 @@
 #
 # Wants to delete .xsession-errors file
 #
-allow xdm_t user_home_type:file { unlink };
+allow xdm_t user_home_type:file unlink;
 #
 # Should fix exec of pam_timestamp_check is not closing xdm file descriptor
 #
 ifdef(`pam.te', `
-dontaudit pam_t xdm_t:fd { use };
+dontaudit pam_t xdm_t:fd use;
 allow xdm_t pam_var_run_t:dir create_dir_perms;
 allow xdm_t pam_var_run_t:file create_file_perms;
 allow pam_t xdm_t:fifo_file { getattr ioctl write };
@@ -307,11 +307,11 @@
 rw_dir_create_file(xdm_t, pam_var_console_t)
 ')
=20
-allow xdm_t var_log_t:file { read };
-dontaudit xdm_t krb5_conf_t:file { write };
+allow xdm_t var_log_t:file read;
+dontaudit xdm_t krb5_conf_t:file write;
 allow xdm_t krb5_conf_t:file { getattr read };
 allow xdm_t self:capability { sys_nice sys_rawio };
-allow xdm_t self:process { setrlimit };
+allow xdm_t self:process setrlimit;
 allow xdm_t wtmp_t:file { getattr read };
=20
 domain_auto_trans(initrc_t, xserver_exec_t, xdm_xserver_t)
@@ -320,11 +320,11 @@
 # Seems to work without it.
 #
 dontaudit xdm_t root_t:dir { add_name write };
-dontaudit xdm_t root_t:file { create };
+dontaudit xdm_t root_t:file create;
 #
 # xdm tries to bind to biff_port_t
 #
-dontaudit xdm_t port_type:tcp_socket { name_bind };
+dontaudit xdm_t port_type:tcp_socket name_bind;
=20
 # VNC v4 module in X server
 type vnc_port_t, port_type;
diff -urN orig/domains/program/unused/ypbind.te mod/domains/program/unused/=
ypbind.te
--- orig/domains/program/unused/ypbind.te	2004-10-12 15:13:58.000000000 +02=
00
+++ mod/domains/program/unused/ypbind.te	2004-10-12 15:14:11.000000000 +0200
@@ -37,5 +37,5 @@
 allow ypbind_t etc_t:file { getattr read };
 allow ypbind_t self:{ unix_dgram_socket unix_stream_socket } create_socket=
_perms;
 allow ypbind_t self:netlink_route_socket r_netlink_socket_perms;
-allow ypbind_t reserved_port_t:tcp_socket { name_bind };
-allow ypbind_t reserved_port_t:udp_socket { name_bind };
+allow ypbind_t reserved_port_t:tcp_socket name_bind;
+allow ypbind_t reserved_port_t:udp_socket name_bind;
diff -urN orig/domains/program/useradd.te mod/domains/program/useradd.te
--- orig/domains/program/useradd.te	2004-09-11 14:31:46.000000000 +0200
+++ mod/domains/program/useradd.te	2004-10-12 15:14:11.000000000 +0200
@@ -96,6 +96,6 @@
 dontaudit groupadd_t self:capability fsetid;
=20
 allow groupadd_t self:capability { setuid sys_resource };
-allow groupadd_t self:process { setrlimit };
+allow groupadd_t self:process setrlimit;
 allow groupadd_t initrc_var_run_t:file r_file_perms;
 dontaudit groupadd_t initrc_var_run_t:file write;
diff -urN orig/macros/base_user_macros.te mod/macros/base_user_macros.te
--- orig/macros/base_user_macros.te	2004-10-11 10:03:26.000000000 +0200
+++ mod/macros/base_user_macros.te	2004-10-12 15:14:12.000000000 +0200
@@ -41,7 +41,7 @@
 # Find CDROM devices
 r_dir_file($1_t, sysctl_dev_t)
 # for eject
-allow $1_t fixed_disk_device_t:blk_file { getattr };
+allow $1_t fixed_disk_device_t:blk_file getattr;
=20
 # open office is looking for the following
 dontaudit $1_t dri_device_t:chr_file rw_file_perms;
@@ -124,8 +124,8 @@
 # Allow graphical boot to check battery lifespan
 #
 ifdef(`apmd.te', `
-allow $1_t apmd_t:unix_stream_socket { connectto };
-allow $1_t apmd_var_run_t:sock_file { write };
+allow $1_t apmd_t:unix_stream_socket connectto;
+allow $1_t apmd_var_run_t:sock_file write;
 ')
=20
 #
@@ -195,8 +195,8 @@
 dbusd_client($1, $1_t)
 dbusd_domain($1)
 ifdef(`hald.te', `
-allow $1_t hald_t:dbus { send_msg };
-allow hald_t $1_t:dbus { send_msg };
+allow $1_t hald_t:dbus send_msg;
+allow hald_t $1_t:dbus send_msg;
 ') dnl end ifdef hald.te
 ') dnl end ifdef dbus.te
=20
@@ -230,7 +230,7 @@
 allow $1_t inetd_t:tcp_socket rw_stream_socket_perms;')
=20
 # Very permissive allowing every domain to see every type.
-allow $1_t kernel_t:system { ipc_info };
+allow $1_t kernel_t:system ipc_info;
=20
 # When the user domain runs ps, there will be a number of access
 # denials when ps tries to search /proc.  Do not audit these denials.
@@ -240,7 +240,7 @@
 #
 # Cups daemon running as user tries to write /etc/printcap
 #
-dontaudit $1_t usr_t:file { setattr };
+dontaudit $1_t usr_t:file setattr;
=20
 ifdef(`xserver.te', `
 # for /tmp/.ICE-unix
@@ -256,9 +256,9 @@
 allow $1_t xdm_xserver_tmp_t:sock_file { read write };
 allow $1_t xdm_xserver_tmp_t:dir search;
 allow $1_t xdm_xserver_t:unix_stream_socket connectto;
-allow $1_t xdm_var_run_t:dir { search };
+allow $1_t xdm_var_run_t:dir search;
 allow $1_t xdm_var_lib_t:file { getattr read };
-allow xdm_t $1_home_dir_t:dir { getattr };
+allow xdm_t $1_home_dir_t:dir getattr;
 ifdef(`xauth.te', `
 file_type_auto_trans(xdm_t, $1_home_dir_t, $1_home_xauth_t, file)
 ')
@@ -288,12 +288,12 @@
 #
 # Added to allow reading of cdrom
 #
-allow $1_t rpc_pipefs_t:dir { getattr };
-allow $1_t nfsd_fs_t:dir { getattr };
-allow $1_t binfmt_misc_fs_t:dir { getattr };
+allow $1_t rpc_pipefs_t:dir getattr;
+allow $1_t nfsd_fs_t:dir getattr;
+allow $1_t binfmt_misc_fs_t:dir getattr;
=20
 # /initrd is left mounted, various programs try to look at it
-dontaudit $1_t ramfs_t:dir { getattr };
+dontaudit $1_t ramfs_t:dir getattr;
=20
 #
 # Emacs wants this access
@@ -324,10 +324,10 @@
 #
 # Running ifconfig as a user generates the following
 #
-dontaudit $1_t $1_t:socket { create };
-dontaudit $1_t sysctl_net_t:dir { search };
+dontaudit $1_t $1_t:socket create;
+dontaudit $1_t sysctl_net_t:dir search;
=20
-dontaudit $1_t default_context_t:dir { search };
+dontaudit $1_t default_context_t:dir search;
=20
 ifdef(`rpcd.te', `
 create_dir_file($1_t,nfsd_rw_t);
diff -urN orig/macros/core_macros.te mod/macros/core_macros.te
--- orig/macros/core_macros.te	2004-09-23 11:38:29.000000000 +0200
+++ mod/macros/core_macros.te	2004-10-12 15:14:12.000000000 +0200
@@ -522,8 +522,8 @@
 define(`can_tcp_connect',`
 #allow $1 $2:tcp_socket { connectto recvfrom };
 #allow $2 $1:tcp_socket { acceptfrom recvfrom };
-#allow $2 kernel_t:tcp_socket { recvfrom };
-#allow $1 kernel_t:tcp_socket { recvfrom };
+#allow $2 kernel_t:tcp_socket recvfrom;
+#allow $1 kernel_t:tcp_socket recvfrom;
 ')
=20
 #################################
@@ -534,8 +534,8 @@
 # Irrelevant until we have labeled networking.
 #
 define(`can_udp_send',`
-#allow $1 $2:udp_socket { sendto };
-#allow $2 $1:udp_socket { recvfrom };
+#allow $1 $2:udp_socket sendto;
+#allow $2 $1:udp_socket recvfrom;
 ')
=20
=20
diff -urN orig/macros/global_macros.te mod/macros/global_macros.te
--- orig/macros/global_macros.te	2004-10-11 10:03:26.000000000 +0200
+++ mod/macros/global_macros.te	2004-10-12 15:14:12.000000000 +0200
@@ -568,7 +568,7 @@
 allow $1 port_type:{ tcp_socket udp_socket } { send_msg recv_msg };
=20
 # Bind to any network address.
-allow $1 port_type:{ tcp_socket udp_socket } { name_bind };
+allow $1 port_type:{ tcp_socket udp_socket } name_bind;
 allow $1 node_type:{ tcp_socket udp_socket rawip_socket } node_bind;
 allow $1 file_type:{ unix_stream_socket unix_dgram_socket } name_bind;
=20
diff -urN orig/macros/mini_user_macros.te mod/macros/mini_user_macros.te
--- orig/macros/mini_user_macros.te	2004-03-08 21:46:09.000000000 +0100
+++ mod/macros/mini_user_macros.te	2004-10-12 15:14:12.000000000 +0200
@@ -30,7 +30,7 @@
 allow $1_mini_t self:unix_stream_socket create_socket_perms;
 allow $1_mini_t self:fifo_file rw_file_perms;
 allow $1_mini_t self:process { fork sigchld setpgid };
-dontaudit $1_mini_t var_t:dir { search };
+dontaudit $1_mini_t var_t:dir search;
 allow $1_mini_t { bin_t sbin_t }:dir search;
=20
 dontaudit $1_mini_t device_t:dir { getattr read };
diff -urN orig/macros/program/apache_macros.te mod/macros/program/apache_ma=
cros.te
--- orig/macros/program/apache_macros.te	2004-09-11 14:31:47.000000000 +0200
+++ mod/macros/program/apache_macros.te	2004-10-12 15:14:12.000000000 +0200
@@ -88,7 +88,7 @@
=20
 domain_auto_trans(httpd_suexec_t, httpd_$1_script_exec_t, httpd_$1_script_=
t)
=20
-allow httpd_$1_script_t httpd_t:fifo_file { write };
+allow httpd_$1_script_t httpd_t:fifo_file write;
=20
 allow httpd_$1_script_t self:fifo_file rw_file_perms;
=20
diff -urN orig/macros/program/clamav_macros.te mod/macros/program/clamav_ma=
cros.te
--- orig/macros/program/clamav_macros.te	2004-09-11 14:31:47.000000000 +0200
+++ mod/macros/program/clamav_macros.te	2004-10-12 15:14:12.000000000 +0200
@@ -11,7 +11,7 @@
 #
 define(`can_clamd_connect',`
 allow $1_t clamd_var_run_t:dir search;
-allow $1_t clamd_var_run_t:sock_file { write };
+allow $1_t clamd_var_run_t:sock_file write;
 can_unix_connect($1_t, clamd_t)
 ')
=20
diff -urN orig/macros/program/crond_macros.te mod/macros/program/crond_macr=
os.te
--- orig/macros/program/crond_macros.te	2004-09-11 14:31:47.000000000 +0200
+++ mod/macros/program/crond_macros.te	2004-10-12 15:14:12.000000000 +0200
@@ -85,7 +85,7 @@
 allow $1_crond_t devtty_t:chr_file { read write };
 allow $1_crond_t var_t:dir r_dir_perms;
 allow $1_crond_t var_t:file { getattr read ioctl };
-allow $1_crond_t var_log_t:dir { search };
+allow $1_crond_t var_log_t:dir search;
=20
 # Use capabilities.
 allow $1_crond_t self:capability dac_override;
diff -urN orig/macros/program/crontab_macros.te mod/macros/program/crontab_=
macros.te
--- orig/macros/program/crontab_macros.te	2004-06-19 10:31:44.000000000 +02=
00
+++ mod/macros/program/crontab_macros.te	2004-10-12 15:14:12.000000000 +0200
@@ -41,8 +41,8 @@
 # Use capabilities dac_override is to create the file in the directory
 # under /tmp
 allow $1_crontab_t $1_crontab_t:capability { setuid setgid chown dac_overr=
ide };
-dontaudit $1_crontab_t proc_t:dir { search };
-dontaudit $1_crontab_t selinux_config_t:dir { search };
+dontaudit $1_crontab_t proc_t:dir search;
+dontaudit $1_crontab_t selinux_config_t:dir search;
=20
 # Type for temporary files.
 file_type_auto_trans($1_crontab_t, tmp_t, $1_tmp_t, file)
@@ -80,7 +80,7 @@
=20
 # Access the cron log file.
 allow $1_crontab_t crond_log_t:file r_file_perms;
-allow $1_crontab_t crond_log_t:file { append };
+allow $1_crontab_t crond_log_t:file append;
=20
 # Access terminals.
 allow $1_crontab_t device_t:dir search;
diff -urN orig/macros/program/dbusd_macros.te mod/macros/program/dbusd_macr=
os.te
--- orig/macros/program/dbusd_macros.te	2004-10-11 10:03:26.000000000 +0200
+++ mod/macros/program/dbusd_macros.te	2004-10-12 15:14:12.000000000 +0200
@@ -33,10 +33,10 @@
 allow $1_dbusd_t etc_t:file { getattr read };
 r_dir_file($1_dbusd_t, etc_dbusd_t)
 tmp_domain($1_dbusd)=20
-allow $1_dbusd_t self:process { fork };
+allow $1_dbusd_t self:process fork;
 ifdef(`xdm.te', `
-allow $1_dbusd_t xdm_t:fd { use };
-allow $1_dbusd_t xdm_t:fifo_file { write };
+allow $1_dbusd_t xdm_t:fd use;
+allow $1_dbusd_t xdm_t:fifo_file write;
 ')
=20
 allow $1_dbusd_t self:unix_stream_socket create_stream_socket_perms;
@@ -44,7 +44,7 @@
=20
 allow $1_dbusd_t urandom_device_t:chr_file { getattr read };
 allow $1_dbusd_t self:file { getattr read };
-allow $1_dbusd_t proc_t:file { read };
+allow $1_dbusd_t proc_t:file read;
=20
 ifdef(`pamconsole.te', `
 r_dir_file($1_dbusd_t, pam_var_console_t)
@@ -62,14 +62,14 @@
 undefine(`dbusd_client')
 define(`dbusd_client',`
 # For connecting to the bus
-allow $2 $1_dbusd_t:unix_stream_socket { connectto };
+allow $2 $1_dbusd_t:unix_stream_socket connectto;
 ifelse(`system', `$1', `
 allow { $2 } { var_run_t system_dbusd_var_run_t }:dir search;
-allow { $2 } system_dbusd_var_run_t:sock_file { write };
+allow { $2 } system_dbusd_var_run_t:sock_file write;
 ',`
 ') dnl endif system
 # SE-DBus specific permissions
-allow $2 { $1_dbusd_t self }:dbus { send_msg };
-allow $2 $1_dbusd_t:dbus { acquire_svc };
+allow $2 { $1_dbusd_t self }:dbus send_msg;
+allow $2 $1_dbusd_t:dbus acquire_svc;
 ') dnl endif dbusd.te
 ')
diff -urN orig/macros/program/games_domain.te mod/macros/program/games_doma=
in.te
--- orig/macros/program/games_domain.te	2004-07-12 23:41:25.000000000 +0200
+++ mod/macros/program/games_domain.te	2004-10-12 15:14:12.000000000 +0200
@@ -40,15 +40,15 @@
 can_unix_connect($1_t, $1_games_t)
 can_unix_connect($1_games_t, $1_t)
=20
-allow $1_games_t var_lib_t:dir { search };
+allow $1_games_t var_lib_t:dir search;
 r_dir_file($1_games_t, man_t)
 allow $1_games_t proc_t:file { read getattr };
-dontaudit $1_games_t devpts_t:dir { search };
+dontaudit $1_games_t devpts_t:dir search;
 ifdef(`mozilla.te', `=20
-dontaudit $1_games_t $1_mozilla_t:unix_stream_socket { connectto };
+dontaudit $1_games_t $1_mozilla_t:unix_stream_socket connectto;
 ')
-allow $1_games_t event_device_t:chr_file { getattr };
-allow $1_games_t mouse_device_t:chr_file { getattr };
+allow $1_games_t event_device_t:chr_file getattr;
+allow $1_games_t mouse_device_t:chr_file getattr;
 allow $1_games_t self:file { getattr read };
 ')dnl end if single_userdomain
 ')dnl end macro definition
diff -urN orig/macros/program/gpg_agent_macros.te mod/macros/program/gpg_ag=
ent_macros.te
--- orig/macros/program/gpg_agent_macros.te	2004-09-21 22:24:44.000000000 +=
0200
+++ mod/macros/program/gpg_agent_macros.te	2004-10-12 15:14:12.000000000 +0=
200
@@ -61,8 +61,8 @@
 tmp_domain($1_gpg_agent)
=20
 # gpg connect
-allow $1_gpg_t $1_gpg_agent_tmp_t:dir { search };
-allow $1_gpg_t $1_gpg_agent_tmp_t:sock_file { write };
+allow $1_gpg_t $1_gpg_agent_tmp_t:dir search;
+allow $1_gpg_t $1_gpg_agent_tmp_t:sock_file write;
 can_unix_connect($1_gpg_t, $1_gpg_agent_t)
=20
 # policy for pinentry
@@ -94,8 +94,8 @@
 # read kde font cache
 allow $1_gpg_pinentry_t usr_t:file { getattr read };
=20
-allow $1_gpg_pinentry_t { proc_t self }:dir { search };
-allow $1_gpg_pinentry_t { proc_t self }:lnk_file { read };
+allow $1_gpg_pinentry_t { proc_t self }:dir search;
+allow $1_gpg_pinentry_t { proc_t self }:lnk_file read;
 # read /proc/meminfo
 allow $1_gpg_pinentry_t proc_t:file read;
=20
diff -urN orig/macros/program/gpg_macros.te mod/macros/program/gpg_macros.te
--- orig/macros/program/gpg_macros.te	2004-09-11 14:31:47.000000000 +0200
+++ mod/macros/program/gpg_macros.te	2004-10-12 15:14:12.000000000 +0200
@@ -22,7 +22,7 @@
 typealias $1_t alias $1_gpg_t;
 typealias $1_home_t alias $1_gpg_secret_t;
 # if we have a single user domain then gpg needs SETUID access...
-allow $1_t self:capability { setuid };
+allow $1_t self:capability setuid;
 ', `
 type $1_gpg_t, domain, privlog;
 type $1_gpg_secret_t, file_type, homedirfile, sysadmfile;
diff -urN orig/macros/program/gph_macros.te mod/macros/program/gph_macros.te
--- orig/macros/program/gph_macros.te	2004-03-17 19:26:06.000000000 +0100
+++ mod/macros/program/gph_macros.te	2004-10-12 15:14:12.000000000 +0200
@@ -64,8 +64,8 @@
 # Allow gnome-pty-helper to update /var/log/lastlog
 # (the gnome-pty-helper in Red Hat Linux 7.1 does this):
 allow $1_gph_t lastlog_t:file rw_file_perms;
-allow $1_gph_t var_log_t:dir { search };
-allow $1_t $1_gph_t:process { signal };
+allow $1_gph_t var_log_t:dir search;
+allow $1_t $1_gph_t:process signal;
=20
 ifelse($2, `system', `
 # Create ptys for the system
diff -urN orig/macros/program/inetd_macros.te mod/macros/program/inetd_macr=
os.te
--- orig/macros/program/inetd_macros.te	2004-10-11 10:03:26.000000000 +0200
+++ mod/macros/program/inetd_macros.te	2004-10-12 15:14:12.000000000 +0200
@@ -40,8 +40,8 @@
 # for identd
 allow $1_t self:netlink_tcpdiag_socket r_netlink_socket_perms;
 allow $1_t self:capability { setuid setgid };
-allow $1_t home_root_t:dir { search };
-allow $1_t self:dir { search };
+allow $1_t home_root_t:dir search;
+allow $1_t self:dir search;
 allow $1_t self:file { getattr read };
 allow $1_t krb5_conf_t:file r_file_perms;
 dontaudit $1_t krb5_conf_t:file write;
@@ -49,17 +49,17 @@
 type $1_port_t, port_type, reserved_port_type;
 # Use sockets inherited from inetd.
 ifelse($2, `', `
-allow inetd_t $1_port_t:udp_socket { name_bind };
+allow inetd_t $1_port_t:udp_socket name_bind;
 allow $1_t inetd_t:udp_socket rw_socket_perms;
-allow inetd_t $1_port_t:tcp_socket { name_bind };
+allow inetd_t $1_port_t:tcp_socket name_bind;
 allow $1_t inetd_t:tcp_socket rw_stream_socket_perms;
 ')
 ifelse($2, tcp, `
-allow inetd_t $1_port_t:tcp_socket { name_bind };
+allow inetd_t $1_port_t:tcp_socket name_bind;
 allow $1_t inetd_t:tcp_socket rw_stream_socket_perms;
 ')
 ifelse($2, udp, `
-allow inetd_t $1_port_t:udp_socket { name_bind };
+allow inetd_t $1_port_t:udp_socket name_bind;
 allow $1_t inetd_t:udp_socket rw_socket_perms;
 ')
 ')
diff -urN orig/macros/program/lpr_macros.te mod/macros/program/lpr_macros.te
--- orig/macros/program/lpr_macros.te	2004-09-11 14:31:47.000000000 +0200
+++ mod/macros/program/lpr_macros.te	2004-10-12 15:14:12.000000000 +0200
@@ -61,7 +61,7 @@
 type $1_print_spool_t, file_type, sysadmfile;
 # Use this type when creating files in /var/spool/lpd and /var/spool/cups.
 file_type_auto_trans($1_lpr_t, print_spool_t, $1_print_spool_t, file)
-allow $1_lpr_t var_spool_t:dir { search };
+allow $1_lpr_t var_spool_t:dir search;
=20
 # for /dev/null
 allow $1_lpr_t device_t:dir search;
@@ -113,8 +113,8 @@
 ')dnl end if lpd.te
=20
 ifdef(`xdm.te', `
-allow $1_lpr_t xdm_t:fd { use };
-allow $1_lpr_t xdm_t:fifo_file { write };
+allow $1_lpr_t xdm_t:fd use;
+allow $1_lpr_t xdm_t:fifo_file write;
 ')
=20
 ifdef(`cups.te', `
diff -urN orig/macros/program/mount_macros.te mod/macros/program/mount_macr=
os.te
--- orig/macros/program/mount_macros.te	2004-05-24 00:55:04.000000000 +0200
+++ mod/macros/program/mount_macros.te	2004-10-12 15:14:12.000000000 +0200
@@ -53,11 +53,11 @@
=20
 read_locale($2_t)
=20
-allow $2_t home_root_t:dir { search };
-allow $2_t $1_home_dir_t:dir { search };
+allow $2_t home_root_t:dir search;
+allow $2_t $1_home_dir_t:dir search;
 allow $2_t noexattrfile:filesystem { mount unmount };
 allow $2_t mnt_t:dir { mounton search };
-allow $2_t sbin_t:dir { search };
+allow $2_t sbin_t:dir search;
=20
 # Access the terminal.
 allow $2_t $1_tty_device_t:chr_file { getattr read write ioctl };
diff -urN orig/macros/program/mozilla_macros.te mod/macros/program/mozilla_=
macros.te
--- orig/macros/program/mozilla_macros.te	2004-10-11 10:03:26.000000000 +02=
00
+++ mod/macros/program/mozilla_macros.te	2004-10-12 15:14:12.000000000 +0200
@@ -96,28 +96,28 @@
 allow $1_mozilla_t $1_home_t:{ file lnk_file } rw_file_perms;
 } dnl end if writehome
=20
-allow $1_mozilla_t $1_t:unix_stream_socket { connectto };
-allow $1_mozilla_t sysctl_net_t:dir { search };
-allow $1_mozilla_t sysctl_t:dir { search };
+allow $1_mozilla_t $1_t:unix_stream_socket connectto;
+allow $1_mozilla_t sysctl_net_t:dir search;
+allow $1_mozilla_t sysctl_t:dir search;
 dontaudit $1_mozilla_t boot_t:dir getattr;
 ifdef(`cups.te', `
-allow $1_mozilla_t cupsd_etc_t:dir { search };
+allow $1_mozilla_t cupsd_etc_t:dir search;
 ')
 allow $1_mozilla_t $1_t:tcp_socket { read write };
=20
 allow $1_mozilla_t mozilla_conf_t:file r_file_perms;
-dontaudit $1_mozilla_t bin_t:dir { getattr };
-dontaudit $1_mozilla_t port_type:tcp_socket { name_bind };
+dontaudit $1_mozilla_t bin_t:dir getattr;
+dontaudit $1_mozilla_t port_type:tcp_socket name_bind;
 dontaudit $1_mozilla_t dri_device_t:chr_file rw_file_perms;
 # Mozilla tries to delete .fonts.cache-1
-dontaudit $1_mozilla_t $1_home_t:file { unlink };
+dontaudit $1_mozilla_t $1_home_t:file unlink;
 dontaudit $1_mozilla_t tmpfile:file getattr;
=20
 ifdef(`xdm.te', `
 allow $1_mozilla_t xdm_t:fifo_file { write read };
 allow $1_mozilla_t xdm_tmp_t:dir search;
 allow $1_mozilla_t xdm_tmp_t:file { getattr read };
-allow $1_mozilla_t xdm_tmp_t:sock_file { write };
+allow $1_mozilla_t xdm_tmp_t:sock_file write;
 ')dnl end if xdm.te
 ')dnl end ifdef single_userdomain
 ')dnl end mozilla macro
diff -urN orig/macros/program/newrole_macros.te mod/macros/program/newrole_=
macros.te
--- orig/macros/program/newrole_macros.te	2004-09-11 14:31:47.000000000 +02=
00
+++ mod/macros/program/newrole_macros.te	2004-10-12 15:14:12.000000000 +0200
@@ -38,7 +38,7 @@
 allow $1_t shell_exec_t:file r_file_perms;
=20
 can_ypbind($1_t)
-dontaudit $1_t krb5_conf_t:file { write };
+dontaudit $1_t krb5_conf_t:file write;
 allow $1_t krb5_conf_t:file { getattr read };
 allow $1_t urandom_device_t:chr_file { getattr read };
=20
@@ -53,7 +53,7 @@
 can_setexec($1_t)
=20
 ifdef(`automount.te', `
-allow $1_t autofs_t:dir { search };
+allow $1_t autofs_t:dir search;
 ')
=20
 # Use capabilities.
diff -urN orig/macros/program/screen_macros.te mod/macros/program/screen_ma=
cros.te
--- orig/macros/program/screen_macros.te	2004-10-11 10:03:26.000000000 +0200
+++ mod/macros/program/screen_macros.te	2004-10-12 15:14:12.000000000 +0200
@@ -59,7 +59,7 @@
 # Write to utmp.
 allow $1_screen_t initrc_var_run_t:file rw_file_perms;
 ifdef(`utempter.te', `
-dontaudit $1_screen_t utempter_exec_t:file { execute };
+dontaudit $1_screen_t utempter_exec_t:file execute;
 ')
=20
 # create pty devices
@@ -79,19 +79,19 @@
 allow $1_t $1_screen_t:process signal;
 allow $1_screen_t self:capability { setuid setgid fsetid };
=20
-dontaudit $1_screen_t shadow_t:file { read };
+dontaudit $1_screen_t shadow_t:file read;
=20
-allow $1_screen_t tmp_t:dir { search };
+allow $1_screen_t tmp_t:dir search;
 can_network($1_screen_t)
 can_ypbind($1_screen_t)
=20
 # get stats
 allow $1_screen_t proc_t:dir search;
 allow $1_screen_t proc_t:lnk_file read;
-dontaudit $1_screen_t device_t:chr_file { getattr };
+dontaudit $1_screen_t device_t:chr_file getattr;
 allow $1_screen_t etc_t:{ file lnk_file } { read getattr };
 allow $1_screen_t self:dir { search read };
-allow $1_screen_t self:lnk_file { read };
+allow $1_screen_t self:lnk_file read;
 allow $1_screen_t device_t:dir search;
 allow $1_screen_t { home_root_t $1_home_dir_t }:dir search;
=20
diff -urN orig/macros/program/slocate_macros.te mod/macros/program/slocate_=
macros.te
--- orig/macros/program/slocate_macros.te	2004-09-11 14:31:47.000000000 +02=
00
+++ mod/macros/program/slocate_macros.te	2004-10-12 15:14:12.000000000 +0200
@@ -26,7 +26,7 @@
 allow $1_locate_t etc_t:file { getattr read };
 allow $1_locate_t self:unix_stream_socket create_socket_perms;
 r_dir_file($1_locate_t,var_lib_locate_t)
-allow $1_locate_t var_lib_t:dir { search };
+allow $1_locate_t var_lib_t:dir search;
=20
 # Transition from the user domain to this domain.
 domain_auto_trans($1_t, locate_exec_t, $1_locate_t)
diff -urN orig/macros/program/ssh_agent_macros.te mod/macros/program/ssh_ag=
ent_macros.te
--- orig/macros/program/ssh_agent_macros.te	2004-10-11 10:03:26.000000000 +=
0200
+++ mod/macros/program/ssh_agent_macros.te	2004-10-12 15:14:12.000000000 +0=
200
@@ -49,7 +49,7 @@
=20
 allow $1_ssh_agent_t proc_t:dir search;
 dontaudit $1_ssh_agent_t proc_t:{ lnk_file file } { getattr read };
-dontaudit $1_ssh_agent_t selinux_config_t:dir { search };
+dontaudit $1_ssh_agent_t selinux_config_t:dir search;
 read_sysctl($1_ssh_agent_t)
=20
 # Access the ssh temporary files. Should we have an own type here
@@ -87,7 +87,7 @@
 allow $1_ssh_t $1_ssh_agent_t:unix_stream_socket connectto;
=20
 ifdef(`xdm.te', `
-allow $1_ssh_agent_t xdm_t:fd { use };
+allow $1_ssh_agent_t xdm_t:fd use;
 allow $1_ssh_agent_t xdm_t:fifo_file { read write };
=20
 # kdm: sigchld
@@ -104,7 +104,7 @@
 allow $1_ssh_agent_t etc_t:file { getattr read };
 allow $1_ssh_agent_t lib_t:file { getattr read };
=20
-allow $1_ssh_agent_t self:dir { search };
+allow $1_ssh_agent_t self:dir search;
 allow $1_ssh_agent_t self:file { getattr read };
=20
 # Allow the ssh program to communicate with ssh-agent.
diff -urN orig/macros/program/ssh_macros.te mod/macros/program/ssh_macros.te
--- orig/macros/program/ssh_macros.te	2004-10-11 10:03:26.000000000 +0200
+++ mod/macros/program/ssh_macros.te	2004-10-12 15:14:12.000000000 +0200
@@ -157,7 +157,7 @@
 allow $1_ssh_t xdm_xserver_t:fd use;
 allow $1_ssh_t xdm_xserver_tmpfs_t:file read;
 allow $1_ssh_t krb5_conf_t:file { getattr read };
-dontaudit $1_ssh_t krb5_conf_t:file { write };
+dontaudit $1_ssh_t krb5_conf_t:file write;
 ')dnl end if xdm.te
 ')dnl end if single_userdomain
 ')dnl end macro definition
diff -urN orig/macros/program/sudo_macros.te mod/macros/program/sudo_macros=
=2Ete
--- orig/macros/program/sudo_macros.te	2004-09-11 14:31:47.000000000 +0200
+++ mod/macros/program/sudo_macros.te	2004-10-12 15:14:12.000000000 +0200
@@ -21,8 +21,8 @@
 ')
=20
 allow $1_sudo_t initrc_var_run_t:file rw_file_perms;
-allow $1_sudo_t sysctl_t:dir { search };
-allow $1_sudo_t { su_exec_t etc_t lib_t usr_t bin_t sbin_t exec_type } :fi=
le { getattr };
+allow $1_sudo_t sysctl_t:dir search;
+allow $1_sudo_t { su_exec_t etc_t lib_t usr_t bin_t sbin_t exec_type } :fi=
le getattr;
 allow $1_sudo_t { su_exec_t etc_t lib_t usr_t bin_t sbin_t exec_type } :ln=
k_file { getattr read };
 read_sysctl($1_sudo_t)
=20
diff -urN orig/macros/program/su_macros.te mod/macros/program/su_macros.te
--- orig/macros/program/su_macros.te	2004-09-11 14:31:47.000000000 +0200
+++ mod/macros/program/su_macros.te	2004-10-12 15:14:12.000000000 +0200
@@ -52,13 +52,13 @@
 r_dir_file($1_su_t, selinux_config_t)
=20
 dontaudit $1_su_t shadow_t:file { getattr read };
-dontaudit $1_su_t home_root_t:dir { search };
-dontaudit $1_su_t init_t:fd { use };
-allow $1_su_t var_lib_t:dir { search };
-allow $1_t $1_su_t:process { signal };
+dontaudit $1_su_t home_root_t:dir search;
+dontaudit $1_su_t init_t:fd use;
+allow $1_su_t var_lib_t:dir search;
+allow $1_t $1_su_t:process signal;
=20
 ifdef(`crond.te', `
-allow $1_su_t crond_t:fifo_file { read };
+allow $1_su_t crond_t:fifo_file read;
 ')
=20
 # Use capabilities.
@@ -87,7 +87,7 @@
 # Write to utmp.
 allow $1_su_t { var_t var_run_t }:dir search;
 allow $1_su_t initrc_var_run_t:file rw_file_perms;
-dontaudit $1_su_t krb5_conf_t:file { write };
+dontaudit $1_su_t krb5_conf_t:file write;
 allow $1_su_t krb5_conf_t:file { getattr read };
 ') dnl end su_restricted_domain
=20
@@ -157,7 +157,7 @@
 ')dnl end if single userdomain
=20
 ifdef(`cyrus.te', `
-allow $1_su_t cyrus_var_lib_t:dir { search };
+allow $1_su_t cyrus_var_lib_t:dir search;
 ')
 ifdef(`ssh.te', `
 # Access sshd cookie files.
@@ -166,8 +166,8 @@
 file_type_auto_trans($1_su_t, sshd_tmp_t, $1_tmp_t)
 ')
=20
-allow $1_su_t var_lib_t:dir { search };
-dontaudit $1_su_t init_t:fd { use };
+allow $1_su_t var_lib_t:dir search;
+dontaudit $1_su_t init_t:fd use;
 ')dnl end su_domain
=20
 ', `
diff -urN orig/macros/program/tvtime_macros.te mod/macros/program/tvtime_ma=
cros.te
--- orig/macros/program/tvtime_macros.te	2004-10-05 20:52:36.000000000 +0200
+++ mod/macros/program/tvtime_macros.te	2004-10-12 15:14:12.000000000 +0200
@@ -25,15 +25,15 @@
=20
 allow $1_tvtime_t urandom_device_t:chr_file read;
 allow $1_tvtime_t clock_device_t:chr_file { ioctl read };
-allow $1_tvtime_t kernel_t:system { ipc_info };
-allow $1_tvtime_t sound_device_t:chr_file { read };
+allow $1_tvtime_t kernel_t:system ipc_info;
+allow $1_tvtime_t sound_device_t:chr_file read;
 allow $1_tvtime_t $1_home_t:dir { getattr read search };
 allow $1_tvtime_t $1_home_t:file { getattr read };
 tmp_domain($1_tvtime)
 allow $1_tvtime_t self:capability { setuid sys_nice sys_resource };
-allow $1_tvtime_t self:process { setsched };
+allow $1_tvtime_t self:process setsched;
 allow $1_tvtime_t usr_t:file { getattr read };
-allow $1_tvtime_t xdm_tmp_t:dir { search };
+allow $1_tvtime_t xdm_tmp_t:dir search;
=20
 ')dnl end tvtime_domain
=20
diff -urN orig/macros/program/uml_macros.te mod/macros/program/uml_macros.te
--- orig/macros/program/uml_macros.te	2004-07-12 23:41:25.000000000 +0200
+++ mod/macros/program/uml_macros.te	2004-10-12 15:14:12.000000000 +0200
@@ -42,7 +42,7 @@
 ifdef(`xdm.te', `
 allow $1_uml_t xdm_xserver_tmp_t:dir search;
 ')dnl end if xdm.te
-allow $1_uml_t $1_xserver_tmp_t:sock_file { write };
+allow $1_uml_t $1_xserver_tmp_t:sock_file write;
 can_unix_connect($1_uml_t, $1_xserver_t)
 ')dnl end ifelse sysadm
 ')dnl end ifdef startx
diff -urN orig/macros/program/userhelper_macros.te mod/macros/program/userh=
elper_macros.te
--- orig/macros/program/userhelper_macros.te	2004-09-11 14:31:47.000000000 =
+0200
+++ mod/macros/program/userhelper_macros.te	2004-10-12 15:14:12.000000000 +=
0200
@@ -122,17 +122,17 @@
 allow $1_userhelper_t urandom_device_t:chr_file { getattr read };
=20
 ifdef(`automount.te', `
-allow $1_userhelper_t autofs_t:dir { search };
+allow $1_userhelper_t autofs_t:dir search;
 ')
-allow $1_userhelper_t sysctl_t:dir { search };
+allow $1_userhelper_t sysctl_t:dir search;
 role system_r types $1_userhelper_t;
 allow $1_userhelper_t krb5_conf_t:file { getattr read };
 r_dir_file($1_userhelper_t, nfs_t)
=20
 ifdef(`xdm.te', `
-allow $1_userhelper_t xdm_t:fd { use };
+allow $1_userhelper_t xdm_t:fd use;
 allow $1_userhelper_t xdm_t:fifo_file rw_file_perms;
-allow $1_userhelper_t xdm_var_run_t:dir { search };
+allow $1_userhelper_t xdm_var_run_t:dir search;
 ')
=20
 r_dir_file($1_userhelper_t, selinux_config_t)
diff -urN orig/macros/program/vmware_macros.te mod/macros/program/vmware_ma=
cros.te
--- orig/macros/program/vmware_macros.te	2004-09-24 17:42:14.000000000 +0200
+++ mod/macros/program/vmware_macros.te	2004-10-12 15:14:12.000000000 +0200
@@ -107,10 +107,10 @@
=20
 # Allow removable media and devices
 allow $1_vmware_t removable_device_t:blk_file r_file_perms;
-allow $1_vmware_t device_t:lnk_file { read };
+allow $1_vmware_t device_t:lnk_file read;
=20
 # Allow access to the real time clock device
-allow $1_vmware_t clock_device_t:chr_file { read };
+allow $1_vmware_t clock_device_t:chr_file read;
=20
 # Allow to attach to Xserver, and Xserver to attach back
 ifdef(`gnome-pty-helper.te', `
@@ -118,14 +118,14 @@
 ')
 ifdef(`startx.te', `
 allow $1_vmware_t $1_xserver_tmp_t:sock_file { unlink write };
-allow $1_vmware_t $1_xserver_tmp_t:dir { search };
-allow $1_vmware_t $1_xserver_t:unix_stream_socket { connectto };
+allow $1_vmware_t $1_xserver_tmp_t:dir search;
+allow $1_vmware_t $1_xserver_t:unix_stream_socket connectto;
 allow $1_xserver_t $1_vmware_t:shm r_shm_perms;
 allow $1_xserver_t $1_vmware_t:fd use;
 ')
=20
 # Allow filesystem read access
-allow $1_vmware_t fs_t:filesystem { getattr };
+allow $1_vmware_t fs_t:filesystem getattr;
=20
 ')
=20
diff -urN orig/macros/program/xserver_macros.te mod/macros/program/xserver_=
macros.te
--- orig/macros/program/xserver_macros.te	2004-10-11 10:03:26.000000000 +02=
00
+++ mod/macros/program/xserver_macros.te	2004-10-12 15:14:12.000000000 +0200
@@ -29,7 +29,7 @@
 allow $1_xserver_t sysctl_modprobe_t:file { getattr read };
 allow $1_xserver_t rpm_t:shm { unix_read unix_write read write associate g=
etattr };
 allow $1_xserver_t rpm_tmpfs_t:file { read write };
-allow $1_xserver_t rpm_t:fd { use };
+allow $1_xserver_t rpm_t:fd use;
=20
 ', `
 type $1_xserver_t, domain, privlog, privmem;
@@ -159,8 +159,8 @@
 allow $1_t $1_xserver_tmp_t:sock_file rw_file_perms;
 allow $1_t $1_xserver_tmp_t:dir r_dir_perms;
 ifdef(`xdm.te', `
-allow $1_t xdm_tmp_t:sock_file { unlink };
-allow $1_xserver_t xdm_var_run_t:dir { search };
+allow $1_t xdm_tmp_t:sock_file unlink;
+allow $1_xserver_t xdm_var_run_t:dir search;
 # for /tmp/.ICE-unix
 file_type_auto_trans($1_t, xdm_xserver_tmp_t, $1_tmp_t, sock_file)
 ')
@@ -200,7 +200,7 @@
 allow $1_xserver_t device_t:dir { create setattr };
 file_type_auto_trans($1_xserver_t, device_t, dri_device_t, chr_file)
 # brought on by rhgb
-allow $1_xserver_t mnt_t:dir { search };
+allow $1_xserver_t mnt_t:dir search;
=20
 allow $1_xserver_t tty_device_t:chr_file { setattr rw_file_perms };
=20
diff -urN orig/macros/user_macros.te mod/macros/user_macros.te
--- orig/macros/user_macros.te	2004-09-23 11:38:30.000000000 +0200
+++ mod/macros/user_macros.te	2004-10-12 15:14:12.000000000 +0200
@@ -70,7 +70,7 @@
 # Need the following rule to allow users to run vpnc
 #
 ifdef(`xserver.te', `
-allow $1_t xserver_port_t:tcp_socket { name_bind };
+allow $1_t xserver_port_t:tcp_socket name_bind;
 ')
=20
 # Allow users to run TCP servers (bind to ports and accept connection from
@@ -217,9 +217,9 @@
 # stop warnings about "ls -l" on directories with unlabelled files
 dontaudit $1_t default_t:{ dir file lnk_file } getattr;
 # Stop warnings about access to /dev/console
-dontaudit $1_t init_t:fd { use };
-dontaudit $1_t initrc_t:fd { use };
-allow $1_t initrc_t:fifo_file { write };
+dontaudit $1_t init_t:fd use;
+dontaudit $1_t initrc_t:fd use;
+allow $1_t initrc_t:fifo_file write;
 ifdef(`user_can_mount', `
 #
 #  Allow users to mount file systems like floppies and cdrom
@@ -227,12 +227,12 @@
 mount_domain($1, $1_mount, `, fs_domain')
 role $1_r types $1_mount_t;
 r_dir_file($1_t, mnt_t)
-allow $1_mount_t removable_device_t:blk_file { read };
-allow $1_mount_t iso9660_t:filesystem { relabelfrom };
+allow $1_mount_t removable_device_t:blk_file read;
+allow $1_mount_t iso9660_t:filesystem relabelfrom;
 allow $1_mount_t removable_t:filesystem { mount relabelto };
-allow $1_mount_t removable_t:dir { mounton };
-allow $1_mount_t xdm_t:fd { use };
-allow $1_mount_t xdm_t:fifo_file { write };
+allow $1_mount_t removable_t:dir mounton;
+allow $1_mount_t xdm_t:fd use;
+allow $1_mount_t xdm_t:fifo_file write;
 ')
=20
 #
diff -urN orig/targeted/domains/program/hotplug.te mod/targeted/domains/pro=
gram/hotplug.te
--- orig/targeted/domains/program/hotplug.te	2004-08-12 16:45:41.000000000 =
+0200
+++ mod/targeted/domains/program/hotplug.te	2004-10-12 15:14:12.000000000 +=
0200
@@ -12,5 +12,5 @@
 # strict policy. =20
 #
 type hotplug_exec_t, file_type, sysadmfile, exec_type;
-typealias var_run_t alias { hotplug_var_run_t };
-typealias etc_t alias { hotplug_etc_t };
+typealias var_run_t alias hotplug_var_run_t;
+typealias etc_t alias hotplug_etc_t;
diff -urN orig/targeted/domains/program/initrc.te mod/targeted/domains/prog=
ram/initrc.te
--- orig/targeted/domains/program/initrc.te	2004-08-12 16:45:41.000000000 +=
0200
+++ mod/targeted/domains/program/initrc.te	2004-10-12 15:14:12.000000000 +0=
200
@@ -13,4 +13,4 @@
 #
 type initrc_exec_t, file_type, sysadmfile, exec_type;
 type run_init_exec_t, file_type, sysadmfile, exec_type;
-typealias var_run_t alias { initrc_var_run_t };
+typealias var_run_t alias initrc_var_run_t;
diff -urN orig/targeted/domains/unconfined.te mod/targeted/domains/unconfin=
ed.te
--- orig/targeted/domains/unconfined.te	2004-10-12 15:13:58.000000000 +0200
+++ mod/targeted/domains/unconfined.te	2004-10-12 15:14:12.000000000 +0200
@@ -37,4 +37,4 @@
 user_typealias(user)
=20
 allow unconfined_t unlabeled_t:filesystem *;
-allow unlabeled_t self:filesystem { associate };
+allow unlabeled_t self:filesystem associate;

--vtzGhvizbBRQ85DL--

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBa9r0xWIrrrL0q+cRAox9AJ9XfyTu4YCHi6pO0VBi9PZ1xDoUagCfQoGx
VCzWMhKqRC8/Bzd/jRslWtg=
=/mzC
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

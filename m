Message-ID: <41741D58.2050700@redhat.com>
Date: Mon, 18 Oct 2004 15:45:28 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: More patches for policy.
Content-Type: multipart/mixed;
 boundary="------------080100040905000904070400"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080100040905000904070400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Some are repeats of previous supplied patch.  This one supersedes.

Dan

--------------080100040905000904070400
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/crond.te policy-1.17.32/domains/program/crond.te
--- nsapolicy/domains/program/crond.te	2004-10-07 08:02:01.000000000 -0400
+++ policy-1.17.32/domains/program/crond.te	2004-10-18 13:37:22.000000000 -0400
@@ -203,3 +203,11 @@
 r_dir_file(system_crond_t, file_context_t)
 can_getsecurity(system_crond_t)
 }
+allow system_crond_t removable_t:filesystem { getattr };
+#
+# Required for webalizer
+#
+ifdef(`apache.te', `
+allow system_crond_t httpd_log_t:file { getattr read };
+')
+dontaudit crond_t self:capability { sys_tty_config };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te policy-1.17.32/domains/program/initrc.te
--- nsapolicy/domains/program/initrc.te	2004-10-14 23:25:17.000000000 -0400
+++ policy-1.17.32/domains/program/initrc.te	2004-10-18 13:37:22.000000000 -0400
@@ -52,7 +52,7 @@
 allow initrc_t usbfs_t:file getattr;
 
 # allow initrc to fork and renice itself
-allow initrc_t self:process { fork sigchld setsched setpgid setrlimit };
+allow initrc_t self:process { fork sigchld setsched setpgid setrlimit getsched };
 
 # Can create ptys for open_init_pty
 can_create_pty(initrc)
@@ -143,6 +143,7 @@
 allow initrc_t var_log_t:dir rw_dir_perms;
 allow initrc_t var_log_t:file { setattr rw_file_perms };
 allow initrc_t lastlog_t:file { setattr rw_file_perms };
+allow initrc_t logfile:file { read append };
 
 # remove old locks
 allow initrc_t lockfile:dir rw_dir_perms;
@@ -309,10 +310,11 @@
 #
 allow initrc_t device_t:dir rw_dir_perms;
 allow initrc_t device_t:lnk_file { unlink };
-allow initrc_t self:process { getsched };
 
 r_dir_file(initrc_t,selinux_config_t)
 
+allow initrc_t file_type:{ dir_file_class_set socket_class_set } getattr;
+
 ifdef(`unlimitedRC', `
 unconfined_domain(initrc_t) 
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/login.te policy-1.17.32/domains/program/login.te
--- nsapolicy/domains/program/login.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.17.32/domains/program/login.te	2004-10-18 13:37:22.000000000 -0400
@@ -130,6 +130,7 @@
 can_ypbind($1_login_t)
 
 allow $1_login_t mouse_device_t:chr_file { getattr setattr };
+dontaudit $1_login_t init_t:fd { use };
 ')dnl end login_domain macro
 #################################
 #
@@ -206,5 +207,5 @@
 # Relabel ptys created by rlogind.
 allow remote_login_t rlogind_devpts_t:chr_file { relabelfrom relabelto };
 ')
-allow remote_login_t ptyfile:chr_file { getattr relabelfrom relabelto };
-
+allow remote_login_t ptyfile:chr_file { getattr relabelfrom relabelto ioctl };
+allow remote_login_t fs_t:filesystem { getattr };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ssh.te policy-1.17.32/domains/program/ssh.te
--- nsapolicy/domains/program/ssh.te	2004-10-09 21:06:13.000000000 -0400
+++ policy-1.17.32/domains/program/ssh.te	2004-10-18 13:37:22.000000000 -0400
@@ -241,3 +241,5 @@
 allow ssh_keygen_t self:unix_stream_socket create_stream_socket_perms;
 allow ssh_keygen_t sysadm_tty_device_t:chr_file { read write };
 allow ssh_keygen_t urandom_device_t:chr_file { getattr read };
+dontaudit sshd_t local_login_t:fd { use };
+dontaudit sshd_t sysadm_tty_device_t:chr_file { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/syslogd.te policy-1.17.32/domains/program/syslogd.te
--- nsapolicy/domains/program/syslogd.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.17.32/domains/program/syslogd.te	2004-10-18 13:37:22.000000000 -0400
@@ -94,4 +94,5 @@
 # /initrd is not umounted before minilog starts
 #
 dontaudit syslogd_t file_t:dir search;
-allow syslogd_t devpts_t:dir { search };
+allow syslogd_t { tmpfs_t devpts_t }:dir { search };
+dontaudit syslogd_t unlabeled_t:file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/acct.te policy-1.17.32/domains/program/unused/acct.te
--- nsapolicy/domains/program/unused/acct.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.17.32/domains/program/unused/acct.te	2004-10-18 13:37:22.000000000 -0400
@@ -21,11 +21,6 @@
 # for SSP
 allow acct_t urandom_device_t:chr_file read;
 
-ifdef(`logrotate.te', `
-can_exec(acct_t, logrotate_exec_t)
-r_dir_file(logrotate_t, acct_data_t)
-')
-
 type acct_data_t, file_type, sysadmfile;
 
 allow acct_t self:capability sys_pacct;
@@ -67,5 +62,7 @@
 allow acct_t { etc_t etc_runtime_t }:file { read getattr };
 
 ifdef(`logrotate.te', `
-allow logrotate_t acct_data_t:file create_file_perms;
+domain_auto_trans(logrotate_t, acct_exec_t, acct_t)
+allow logrotate_t acct_data_t:file { create_file_perms };
 ')
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/arpwatch.te policy-1.17.32/domains/program/unused/arpwatch.te
--- nsapolicy/domains/program/unused/arpwatch.te	2004-10-13 14:26:54.000000000 -0400
+++ policy-1.17.32/domains/program/unused/arpwatch.te	2004-10-18 13:37:22.000000000 -0400
@@ -20,3 +20,15 @@
 allow arpwatch_t arpwatch_t:unix_stream_socket create_stream_socket_perms;
 create_dir_file(arpwatch_t,arpwatch_data_t)
 allow arpwatch_t tmp_t:dir { search };
+tmp_domain(arpwatch)
+allow arpwatch_t net_conf_t:file { getattr read };
+allow arpwatch_t netif_lo_t:netif { udp_send };
+allow arpwatch_t sbin_t:dir { search };
+allow arpwatch_t sbin_t:lnk_file { read };
+can_network(arpwatch_t)
+can_ypbind(arpwatch_t)
+allow system_mail_t arpwatch_tmp_t:file rw_file_perms;
+ifdef(`postfix.te', `
+allow postfix_local_t arpwatch_data_t:dir { search };
+')
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/bluetooth.te policy-1.17.32/domains/program/unused/bluetooth.te
--- nsapolicy/domains/program/unused/bluetooth.te	2004-09-09 16:22:12.000000000 -0400
+++ policy-1.17.32/domains/program/unused/bluetooth.te	2004-10-18 13:37:22.000000000 -0400
@@ -35,3 +35,5 @@
 # Read /etc/bluetooth
 allow bluetooth_t bluetooth_conf_t:dir search;
 allow bluetooth_t bluetooth_conf_t:file { getattr read ioctl };
+#/usr/sbin/hid2hci causes the following
+allow initrc_t usbfs_t:file { read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/bootloader.te policy-1.17.32/domains/program/unused/bootloader.te
--- nsapolicy/domains/program/unused/bootloader.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.17.32/domains/program/unused/bootloader.te	2004-10-18 13:37:22.000000000 -0400
@@ -121,7 +121,7 @@
 allow bootloader_t proc_t:dir { getattr search };
 allow bootloader_t proc_t:file r_file_perms;
 allow bootloader_t proc_t:lnk_file { getattr read };
-allow bootloader_t proc_mdstat_t:file { getattr read };
+allow bootloader_t proc_mdstat_t:file r_file_perms;
 allow bootloader_t self:dir { getattr search read };
 allow bootloader_t sysctl_kernel_t:dir search;
 allow bootloader_t sysctl_kernel_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/canna.te policy-1.17.32/domains/program/unused/canna.te
--- nsapolicy/domains/program/unused/canna.te	2004-09-01 11:17:48.000000000 -0400
+++ policy-1.17.32/domains/program/unused/canna.te	2004-10-18 13:37:22.000000000 -0400
@@ -15,7 +15,8 @@
 logdir_domain(canna)
 var_lib_domain(canna)
 
-allow canna_t self:capability { setgid setuid };
+allow canna_t self:capability { setgid setuid net_bind_service };
+allow canna_t tmp_t:dir { search };
 allow canna_t self:unix_stream_socket { connectto create_stream_socket_perms};
 allow canna_t self:unix_dgram_socket create_stream_socket_perms;
 allow canna_t etc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.17.32/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2004-10-14 23:25:18.000000000 -0400
+++ policy-1.17.32/domains/program/unused/cups.te	2004-10-18 13:37:22.000000000 -0400
@@ -20,7 +20,6 @@
 
 can_network(cupsd_t)
 can_ypbind(cupsd_t)
-dbusd_client(system, cupsd_t)
 logdir_domain(cupsd)
 
 tmp_domain(cupsd)
@@ -170,6 +169,8 @@
 # CUPS configuration daemon
 daemon_domain(cupsd_config)
 
+allow cupsd_config_t devpts_t:dir search;
+
 ifdef(`distro_redhat', `
 ifdef(`rpm.te', `
 allow cupsd_config_t rpm_var_lib_t:dir { getattr search };
@@ -196,13 +197,18 @@
 can_tcp_connect(cupsd_config_t, cupsd_t)
 allow cupsd_config_t self:fifo_file rw_file_perms;
 
-dbusd_client(system, cupsd_config_t)
 allow cupsd_config_t self:unix_stream_socket create_socket_perms;
+ifdef(`dbusd.te', `
+dbusd_client(system, cupsd_t)
+dbusd_client(system, cupsd_config_t)
 allow cupsd_config_t userdomain:dbus { send_msg };
 allow userdomain cupsd_config_t:dbus { send_msg };
 allow cupsd_config_t hald_t:dbus { send_msg };
 allow hald_t cupsd_config_t:dbus { send_msg };
-
+allow cupsd_t userdomain:dbus { send_msg };
+allow cupsd_t hald_t:dbus { send_msg };
+allow hald_t cupsd_t:dbus { send_msg };
+')
 
 can_exec(cupsd_config_t, { bin_t sbin_t shell_exec_t })
 allow cupsd_config_t { bin_t sbin_t }:dir { search getattr };
@@ -218,3 +224,5 @@
 domain_auto_trans(hald_t, cupsd_config_exec_t, cupsd_config_t)
 
 ')
+# Alternatives asks for this
+allow cupsd_config_t initrc_exec_t:file { getattr };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ftpd.te policy-1.17.32/domains/program/unused/ftpd.te
--- nsapolicy/domains/program/unused/ftpd.te	2004-10-09 21:06:14.000000000 -0400
+++ policy-1.17.32/domains/program/unused/ftpd.te	2004-10-18 13:37:22.000000000 -0400
@@ -69,9 +69,8 @@
 
 # Append to /var/log/wtmp.
 allow ftpd_t wtmp_t:file { getattr append };
-
-# allow access to /home
-allow ftpd_t home_root_t:dir { getattr search };
+#kerberized ftp requires the following
+allow ftpd_t wtmp_t:file { write lock };
 
 # Create and modify /var/log/xferlog.
 type xferlog_t, file_type, sysadmfile, logfile;
@@ -97,10 +96,22 @@
 
 # Allow ftp to read/write files in the user home directories.
 bool ftp_home_dir false;
-ifdef(`nfs_home_dirs', `
 if (ftp_home_dir) {
+ifdef(`nfs_home_dirs', `
 allow ftpd_t nfs_t:dir r_dir_perms;
 allow ftpd_t nfs_t:file r_file_perms;
-}
+# dont allow access to /home
+dontaudit ftpd_t home_root_t:dir { getattr search };
 ')dnl end if nfs_home_dirs
+} 
+else 
+{
+# allow access to /home
+allow ftpd_t home_root_t:dir { getattr search };
+}
 dontaudit ftpd_t selinux_config_t:dir { search };
+#
+# Type for access to anon ftp
+#
+type ftpd_anon_t, file_type, sysadmfile;
+r_dir_file(ftpd_t,ftpd_anon_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.17.32/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2004-10-14 23:25:18.000000000 -0400
+++ policy-1.17.32/domains/program/unused/hald.te	2004-10-18 13:37:22.000000000 -0400
@@ -63,3 +63,4 @@
 dontaudit hald_t selinux_config_t:dir { search };
 allow hald_t initrc_t:dbus { send_msg };
 allow initrc_t hald_t:dbus { send_msg };
+allow hald_t etc_runtime_t:file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/named.te policy-1.17.32/domains/program/unused/named.te
--- nsapolicy/domains/program/unused/named.te	2004-10-09 21:06:14.000000000 -0400
+++ policy-1.17.32/domains/program/unused/named.te	2004-10-18 13:37:22.000000000 -0400
@@ -151,3 +151,6 @@
 dontaudit ndc_t sysadm_home_t:dir { getattr search read };
 ')
 allow ndc_t self:netlink_route_socket { bind create getattr nlmsg_read read write };
+dontaudit ndc_t sysadm_tty_device_t:chr_file { ioctl };
+# Allow init script to cp localtime to named_conf_t
+allow initrc_t named_conf_t:file { write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nscd.te policy-1.17.32/domains/program/unused/nscd.te
--- nsapolicy/domains/program/unused/nscd.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.17.32/domains/program/unused/nscd.te	2004-10-18 13:37:22.000000000 -0400
@@ -58,7 +58,7 @@
 allow nscd_t self:process { getattr setsched };
 allow nscd_t self:unix_dgram_socket create_socket_perms;
 allow nscd_t self:fifo_file { read write };
-allow nscd_t self:capability { kill setgid setuid net_bind_service };
+allow nscd_t self:capability { kill setgid setuid net_bind_service net_admin };
 
 # for when /etc/passwd has just been updated and has the wrong type
 allow nscd_t shadow_t:file getattr;
@@ -73,5 +73,8 @@
 r_dir_file(nscd_t, selinux_config_t)
 can_getsecurity(nscd_t)
 allow nscd_t self:netlink_selinux_socket create_socket_perms;
+allow nscd_t self:netlink_route_socket r_netlink_socket_perms;
+allow nscd_t tmp_t:dir { search getattr };
+allow nscd_t tmp_t:lnk_file { read };
 
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ntpd.te policy-1.17.32/domains/program/unused/ntpd.te
--- nsapolicy/domains/program/unused/ntpd.te	2004-10-09 21:06:14.000000000 -0400
+++ policy-1.17.32/domains/program/unused/ntpd.te	2004-10-18 13:37:22.000000000 -0400
@@ -50,7 +50,7 @@
 can_exec(ntpd_t, initrc_exec_t)
 allow ntpd_t self:fifo_file { read write getattr };
 allow ntpd_t etc_runtime_t:file r_file_perms;
-can_exec(ntpd_t, { bin_t shell_exec_t sbin_t ls_exec_t ntpd_exec_t })
+can_exec(ntpd_t, { bin_t shell_exec_t sbin_t ls_exec_t logrotate_exec_t ntpd_exec_t })
 allow ntpd_t { sbin_t bin_t }:dir search;
 allow ntpd_t bin_t:lnk_file read;
 allow ntpd_t sysctl_kernel_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/pamconsole.te policy-1.17.32/domains/program/unused/pamconsole.te
--- nsapolicy/domains/program/unused/pamconsole.te	2004-09-10 11:01:02.000000000 -0400
+++ policy-1.17.32/domains/program/unused/pamconsole.te	2004-10-18 13:37:22.000000000 -0400
@@ -40,3 +40,4 @@
 ifdef(`xdm.te', `
 allow pam_console_t xdm_var_run_t:file { getattr read };
 ')
+allow initrc_t pam_var_console_t:dir r_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postfix.te policy-1.17.32/domains/program/unused/postfix.te
--- nsapolicy/domains/program/unused/postfix.te	2004-10-14 23:25:18.000000000 -0400
+++ policy-1.17.32/domains/program/unused/postfix.te	2004-10-18 13:37:22.000000000 -0400
@@ -124,7 +124,7 @@
 allow postfix_master_t postfix_spool_maildrop_t:file { unlink rename getattr };
 allow postfix_master_t postfix_prng_t:file getattr;
 allow postfix_master_t privfd:fd use;
-allow postfix_master_t etc_aliases_t:file r_file_perms;
+allow postfix_master_t etc_aliases_t:file rw_file_perms;
 
 ifdef(`saslauthd.te',`
 allow postfix_smtpd_t saslauthd_var_run_t:dir { search getattr };
@@ -347,3 +347,5 @@
 allow postfix_map_t self:unix_dgram_socket create_socket_perms;
 dontaudit postfix_map_t var_t:dir search;
 can_network(postfix_map_t)
+allow postfix_local_t mail_spool_t:dir { remove_name };
+allow postfix_local_t mail_spool_t:file { unlink };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rlogind.te policy-1.17.32/domains/program/unused/rlogind.te
--- nsapolicy/domains/program/unused/rlogind.te	2004-10-14 23:25:18.000000000 -0400
+++ policy-1.17.32/domains/program/unused/rlogind.te	2004-10-18 13:37:22.000000000 -0400
@@ -14,6 +14,7 @@
 role system_r types rlogind_t;
 uses_shlib(rlogind_t)
 can_network(rlogind_t)
+can_ypbind(rlogind_t)
 type rlogind_exec_t, file_type, sysadmfile, exec_type;
 domain_auto_trans(inetd_t, rlogind_exec_t, rlogind_t)
 ifdef(`tcpd.te', `
@@ -32,7 +33,7 @@
 allow rlogind_t inetd_t:tcp_socket rw_stream_socket_perms;
 
 # Use capabilities.
-allow rlogind_t self:capability { net_bind_service setuid setgid fowner fsetid chown dac_override };
+allow rlogind_t self:capability { net_bind_service setuid setgid fowner fsetid chown dac_override sys_tty_config };
 
 # so telnetd can start a child process for the login
 allow rlogind_t self:process { fork signal_perms };
@@ -74,3 +75,12 @@
 # Modify /var/log/wtmp.
 allow rlogind_t var_log_t:dir search;
 allow rlogind_t wtmp_t:file rw_file_perms;
+allow rlogind_t krb5_conf_t:file { getattr read };
+dontaudit rlogind_t krb5_conf_t:file write;
+allow rlogind_t urandom_device_t:chr_file { getattr read };
+dontaudit rlogind_t selinux_config_t:dir search;
+allow rlogind_t staff_home_dir_t:dir search;
+allow rlogind_t proc_t:file read;
+allow rlogind_t self:file { getattr read };
+allow rlogind_t self:fifo_file rw_file_perms;
+allow rlogind_t fs_t:filesystem { getattr };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rshd.te policy-1.17.32/domains/program/unused/rshd.te
--- nsapolicy/domains/program/unused/rshd.te	2004-10-09 21:06:14.000000000 -0400
+++ policy-1.17.32/domains/program/unused/rshd.te	2004-10-18 13:37:22.000000000 -0400
@@ -26,3 +26,13 @@
 can_network(rshd_t)
 can_ypbind(rshd_t)
 
+allow rshd_t etc_t:file { getattr read };
+read_locale(rshd_t)
+allow rshd_t self:unix_dgram_socket create_socket_perms;
+allow rshd_t self:unix_stream_socket create_stream_socket_perms;
+allow rshd_t { home_root_t home_dir_type }:dir { search getattr };
+allow rshd_t krb5_conf_t:file { getattr read };
+dontaudit rshd_t krb5_conf_t:file write;
+allow rshd_t tmp_t:dir { search };
+allow rshd_t rlogind_tmp_t:file rw_file_perms;
+allow rshd_t urandom_device_t:chr_file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rsync.te policy-1.17.32/domains/program/unused/rsync.te
--- nsapolicy/domains/program/unused/rsync.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.17.32/domains/program/unused/rsync.te	2004-10-18 13:37:22.000000000 -0400
@@ -13,3 +13,6 @@
 inetd_child_domain(rsync)
 type rsync_data_t, file_type, sysadmfile;
 r_dir_file(rsync_t, rsync_data_t)
+ifdef(`ftpd.te', `
+r_dir_file(rsync_t, ftpd_anon_t)
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/slapd.te policy-1.17.32/domains/program/unused/slapd.te
--- nsapolicy/domains/program/unused/slapd.te	2004-10-09 21:06:15.000000000 -0400
+++ policy-1.17.32/domains/program/unused/slapd.te	2004-10-18 13:37:22.000000000 -0400
@@ -39,6 +39,7 @@
 
 # Allow access to the slapd databases
 create_dir_file(slapd_t, slapd_db_t)
+allow initrc_t slapd_db_t:dir r_dir_perms;
 allow slapd_t var_lib_t:dir r_dir_perms;
 
 # Allow access to write the replication log (should tighten this)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/tftpd.te policy-1.17.32/domains/program/unused/tftpd.te
--- nsapolicy/domains/program/unused/tftpd.te	2004-10-13 22:41:58.000000000 -0400
+++ policy-1.17.32/domains/program/unused/tftpd.te	2004-10-18 13:37:22.000000000 -0400
@@ -16,7 +16,7 @@
 type tftp_port_t, port_type, reserved_port_type;
 
 # tftpdir_t is the type of files in the /tftpboot directories.
-type tftpdir_t, file_type, sysadmfile;
+type tftpdir_t, file_type, root_dir_type, sysadmfile;
 r_dir_file(tftpd_t, tftpdir_t)
 
 domain_auto_trans(inetd_t, tftpd_exec_t, tftpd_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.17.32/domains/program/unused/udev.te
--- nsapolicy/domains/program/unused/udev.te	2004-10-13 22:41:58.000000000 -0400
+++ policy-1.17.32/domains/program/unused/udev.te	2004-10-18 13:37:22.000000000 -0400
@@ -54,7 +54,7 @@
 r_dir_file(udev_t, { selinux_config_t file_context_t default_context_t } )
 
 allow udev_t policy_config_t:dir { search };
-allow udev_t proc_t:file { getattr read };
+allow udev_t proc_t:file { getattr read ioctl };
 allow udev_t proc_kcore_t:file getattr;
 
 # Get security policy decisions.
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/ftpd.fc policy-1.17.32/file_contexts/program/ftpd.fc
--- nsapolicy/file_contexts/program/ftpd.fc	2004-03-17 13:26:06.000000000 -0500
+++ policy-1.17.32/file_contexts/program/ftpd.fc	2004-10-18 13:37:22.000000000 -0400
@@ -12,3 +12,4 @@
 /var/log/xferlog.*	--	system_u:object_r:xferlog_t
 /var/log/xferreport.*	--	system_u:object_r:xferlog_t
 /etc/cron\.monthly/proftpd --	system_u:object_r:ftpd_exec_t
+/var/ftp(/.*)?			system_u:object_r:ftpd_anon_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/hotplug.fc policy-1.17.32/file_contexts/program/hotplug.fc
--- nsapolicy/file_contexts/program/hotplug.fc	2004-07-26 16:16:11.000000000 -0400
+++ policy-1.17.32/file_contexts/program/hotplug.fc	2004-10-18 13:37:22.000000000 -0400
@@ -1,7 +1,9 @@
 # hotplug
 /etc/hotplug(/.*)?		system_u:object_r:hotplug_etc_t
 /sbin/hotplug		--	system_u:object_r:hotplug_exec_t
+/sbin/netplugd		--	system_u:object_r:hotplug_exec_t
 /etc/hotplug.d/default/default.* system_u:object_r:sbin_t
+/etc/netplug.d(/.*)? 	 	system_u:object_r:sbin_t
 /etc/hotplug/.*agent	--	system_u:object_r:sbin_t
 /etc/hotplug/.*rc	-- 	system_u:object_r:sbin_t
 /etc/hotplug/hotplug.functions --	system_u:object_r:sbin_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/innd.fc policy-1.17.32/file_contexts/program/innd.fc
--- nsapolicy/file_contexts/program/innd.fc	2004-06-16 13:33:37.000000000 -0400
+++ policy-1.17.32/file_contexts/program/innd.fc	2004-10-18 13:37:22.000000000 -0400
@@ -8,8 +8,41 @@
 /var/lib/news(/.*)?		system_u:object_r:innd_var_lib_t
 /var/run/news(/.*)?	 	system_u:object_r:innd_var_run_t
 /usr/sbin/in.nnrpd	--	system_u:object_r:innd_exec_t
-/usr/lib(64)?/news/bin/.*	--	system_u:object_r:innd_exec_t
 /usr/bin/inews		--	system_u:object_r:innd_exec_t
 /usr/bin/rnews		--	system_u:object_r:innd_exec_t
-/usr/lib/news/bin/innd 	--	system_u:object_r:innd_exec_t
-
+/usr/lib(64)?/news/bin(/.*)?		system_u:object_r:bin_t
+/usr/lib(64)?/news/bin/innd 	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/actsync	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/archive	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/batcher	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/buffchan	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/convdate	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/ctlinnd	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/cvtbatch	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/expire	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/expireover	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/fastrm	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/filechan	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/getlist	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/grephistory	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/inews	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/innconfval	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/innd	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/inndf	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/inndstart	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/innfeed	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/innxbatch	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/innxmit	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/makedbz	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/makehistory	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/newsrequeue	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/nnrpd	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/nntpget	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/ovdb_recover	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/overchan	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/prunehistory	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/rnews	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/shlock	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/shrinkfile	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/sm	--	system_u:object_r:innd_exec_t
+/usr/lib(64)?/news/bin/startinnfeed	--	system_u:object_r:innd_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/kerberos.fc policy-1.17.32/file_contexts/program/kerberos.fc
--- nsapolicy/file_contexts/program/kerberos.fc	2004-08-30 16:13:29.000000000 -0400
+++ policy-1.17.32/file_contexts/program/kerberos.fc	2004-10-18 13:37:22.000000000 -0400
@@ -9,3 +9,4 @@
 /var/log/krb5kdc.log			system_u:object_r:krb5kdc_log_t
 /var/log/kadmind.log			system_u:object_r:kadmind_log_t
 /usr(/local)?/bin/ksu		--	system_u:object_r:su_exec_t
+/usr/kerberos/sbin/login.krb5	--	system_u:object_r:login_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/postgresql.fc policy-1.17.32/file_contexts/program/postgresql.fc
--- nsapolicy/file_contexts/program/postgresql.fc	2004-07-07 16:46:41.000000000 -0400
+++ policy-1.17.32/file_contexts/program/postgresql.fc	2004-10-18 13:37:22.000000000 -0400
@@ -4,7 +4,6 @@
 /usr/bin/pg_dump	--	system_u:object_r:postgresql_exec_t
 /usr/bin/pg_dumpall	--	system_u:object_r:postgresql_exec_t
 /usr/bin/pg_resetxlog	--	system_u:object_r:postgresql_exec_t
-/etc/rc.d/init.d/postgresql --	system_u:object_r:postgresql_exec_t
 
 # not sure whether the following binaries need labelling
 /usr/bin/createlang	--	system_u:object_r:postgresql_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/snmpd.fc policy-1.17.32/file_contexts/program/snmpd.fc
--- nsapolicy/file_contexts/program/snmpd.fc	2004-06-16 13:33:37.000000000 -0400
+++ policy-1.17.32/file_contexts/program/snmpd.fc	2004-10-18 13:37:22.000000000 -0400
@@ -5,4 +5,5 @@
 /usr/share/snmp/mibs/\.index -- system_u:object_r:snmpd_var_lib_t
 /var/run/snmpd\.pid	--	system_u:object_r:snmpd_var_run_t
 /var/run/snmpd		-d	system_u:object_r:snmpd_var_run_t
-/var/log/snmbd.log	--	system_u:object_r:snmpd_log_t
+/var/net-snmp(/.*)		system_u:object_r:snmpd_var_lib_t
+/var/log/snmpd.log	--	system_u:object_r:snmpd_log_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/squid.fc policy-1.17.32/file_contexts/program/squid.fc
--- nsapolicy/file_contexts/program/squid.fc	2004-06-16 13:33:37.000000000 -0400
+++ policy-1.17.32/file_contexts/program/squid.fc	2004-10-18 13:37:22.000000000 -0400
@@ -3,6 +3,6 @@
 /var/cache/squid(/.*)?		system_u:object_r:squid_cache_t
 /var/spool/squid(/.*)?		system_u:object_r:squid_cache_t
 /var/log/squid(/.*)?		system_u:object_r:squid_log_t
-/etc/squid\.conf	--	system_u:object_r:squid_conf_t
+/etc/squid(/.*)?		system_u:object_r:squid_conf_t
 /var/run/squid\.pid	--	system_u:object_r:squid_var_run_t
 /usr/share/squid(/.*)?		system_u:object_r:squid_conf_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.17.32/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2004-10-13 22:41:58.000000000 -0400
+++ policy-1.17.32/macros/base_user_macros.te	2004-10-18 13:37:22.000000000 -0400
@@ -281,6 +281,7 @@
 
 # Get attributes of file systems.
 allow $1_t fs_type:filesystem getattr;
+allow $1_t removable_t:filesystem getattr;
 
 # Read and write /dev/tty and /dev/null.
 allow $1_t devtty_t:chr_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mount_macros.te policy-1.17.32/macros/program/mount_macros.te
--- nsapolicy/macros/program/mount_macros.te	2004-05-21 16:12:23.000000000 -0400
+++ policy-1.17.32/macros/program/mount_macros.te	2004-10-18 15:38:13.742555070 -0400
@@ -56,6 +56,8 @@
 allow $2_t home_root_t:dir { search };
 allow $2_t $1_home_dir_t:dir { search };
 allow $2_t noexattrfile:filesystem { mount unmount };
+allow $2_t fs_t:filesystem { getattr };
+allow $2_t removable_t:filesystem { mount unmount };
 allow $2_t mnt_t:dir { mounton search };
 allow $2_t sbin_t:dir { search };
 
@@ -63,7 +65,13 @@
 allow $2_t $1_tty_device_t:chr_file { getattr read write ioctl };
 allow $2_t $1_devpts_t:chr_file { getattr read write };
 ifdef(`gnome-pty-helper.te', `allow $2_t $1_gph_t:fd use;')
-')
+
+ifdef(`distro_redhat',`
+r_dir_file($2_t,pam_var_console_t)
+# mount config by default sets fscontext=removable_t
+allow $2_t dosfs_t:filesystem { relabelfrom };
+') dnl end distro_redhat
+') dnl end mount_domain
 
 # mount_loopback_privs(domain_prefix,dst_domain_prefix)
 #
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.17.32/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2004-10-07 08:02:02.000000000 -0400
+++ policy-1.17.32/macros/program/mozilla_macros.te	2004-10-18 13:37:22.000000000 -0400
@@ -112,6 +112,10 @@
 # Mozilla tries to delete .fonts.cache-1
 dontaudit $1_mozilla_t $1_home_t:file { unlink };
 dontaudit $1_mozilla_t tmpfile:file getattr;
+#
+# Eliminate errors from scanning with the 
+#
+dontaudit $1_mozilla_t file_type:dir getattr;
 
 ifdef(`xdm.te', `
 allow $1_mozilla_t xdm_t:fifo_file { write read };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/user_macros.te policy-1.17.32/macros/user_macros.te
--- nsapolicy/macros/user_macros.te	2004-10-14 23:25:20.000000000 -0400
+++ policy-1.17.32/macros/user_macros.te	2004-10-18 13:37:22.000000000 -0400
@@ -205,6 +205,8 @@
 
 dontaudit $1_t sysadm_home_t:dir { read search getattr };
 dontaudit $1_t sysadm_home_t:file { read getattr append };
+# gam_server fires off these when exploring with mozilla/nautilous
+dontaudit $1_t file_type:dir getattr;
 
 ifdef(`syslogd.te', `
 # Some programs that are left in $1_t will try to connect
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.17.32/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-08-20 13:57:29.000000000 -0400
+++ policy-1.17.32/tunables/distro.tun	2004-10-18 13:37:22.000000000 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.17.32/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-10-14 23:25:21.000000000 -0400
+++ policy-1.17.32/tunables/tunable.tun	2004-10-18 13:37:22.000000000 -0400
@@ -1,39 +1,39 @@
 # Allow all domains to connect to nscd
-dnl define(`nscd_all_connect')
+define(`nscd_all_connect')
 
 # Allow users to control network interfaces (also needs USERCTL=true)
 dnl define(`user_net_control')
 
 # Allow users to execute the mount command
-dnl define(`user_can_mount')
+define(`user_can_mount')
 
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
-dnl define(`unlimitedUtils')
+define(`unlimitedUtils')
 
 # Support NFS home directories
-dnl define(`nfs_home_dirs')
+define(`nfs_home_dirs')
 
 # Allow users to run games
-dnl define(`use_games')
+define(`use_games')
 
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
diff --exclude-from=exclude -N -u -r nsapolicy/types/file.te policy-1.17.32/types/file.te
--- nsapolicy/types/file.te	2004-10-14 23:25:21.000000000 -0400
+++ policy-1.17.32/types/file.te	2004-10-18 13:37:22.000000000 -0400
@@ -301,3 +301,4 @@
 
 # removable_t is the default type of all removable media
 type removable_t, file_type, sysadmfile, usercanread;
+allow removable_t self:filesystem associate;

--------------080100040905000904070400--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

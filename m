Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9E3Q1rT025354
	for <selinux@tycho.nsa.gov>; Wed, 13 Oct 2004 23:26:02 -0400 (EDT)
Message-ID: <416DF1BB.7040205@redhat.com>
Date: Wed, 13 Oct 2004 23:25:47 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: Russell Coker <russell@coker.com.au>, SELinux <selinux@tycho.nsa.gov>
Subject: New Patches
References: <200410132025.49472.russell@coker.com.au> <1097698713.28227.17.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1097698713.28227.17.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------040507030503030807000705"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040507030503030807000705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Many changes to rlogin, ftpd.

Fixes to arpwatch

Fixed for removable_t


--------------040507030503030807000705
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/crond.te policy-1.17.31/domains/program/crond.te
--- nsapolicy/domains/program/crond.te	2004-10-07 08:02:01.000000000 -0400
+++ policy-1.17.31/domains/program/crond.te	2004-10-13 23:15:03.823373511 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/login.te policy-1.17.31/domains/program/login.te
--- nsapolicy/domains/program/login.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.17.31/domains/program/login.te	2004-10-13 23:15:03.824373398 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ssh.te policy-1.17.31/domains/program/ssh.te
--- nsapolicy/domains/program/ssh.te	2004-10-09 21:06:13.000000000 -0400
+++ policy-1.17.31/domains/program/ssh.te	2004-10-13 23:15:03.824373398 -0400
@@ -241,3 +241,5 @@
 allow ssh_keygen_t self:unix_stream_socket create_stream_socket_perms;
 allow ssh_keygen_t sysadm_tty_device_t:chr_file { read write };
 allow ssh_keygen_t urandom_device_t:chr_file { getattr read };
+dontaudit sshd_t local_login_t:fd { use };
+dontaudit sshd_t sysadm_tty_device_t:chr_file { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/syslogd.te policy-1.17.31/domains/program/syslogd.te
--- nsapolicy/domains/program/syslogd.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.17.31/domains/program/syslogd.te	2004-10-13 23:15:03.825373285 -0400
@@ -94,4 +94,5 @@
 # /initrd is not umounted before minilog starts
 #
 dontaudit syslogd_t file_t:dir search;
-allow syslogd_t devpts_t:dir { search };
+allow syslogd_t { tmpfs_t devpts_t }:dir { search };
+dontaudit syslogd_t unlabeled_t:file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/acct.te policy-1.17.31/domains/program/unused/acct.te
--- nsapolicy/domains/program/unused/acct.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.17.31/domains/program/unused/acct.te	2004-10-13 23:15:03.826373172 -0400
@@ -23,7 +23,7 @@
 
 ifdef(`logrotate.te', `
 can_exec(acct_t, logrotate_exec_t)
-r_dir_file(logrotate_t, acct_data_t)
+rw_dir_file(logrotate_t, acct_data_t)
 ')
 
 type acct_data_t, file_type, sysadmfile;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/arpwatch.te policy-1.17.31/domains/program/unused/arpwatch.te
--- nsapolicy/domains/program/unused/arpwatch.te	2004-10-13 14:26:54.000000000 -0400
+++ policy-1.17.31/domains/program/unused/arpwatch.te	2004-10-13 23:21:24.229512909 -0400
@@ -20,3 +20,9 @@
 allow arpwatch_t arpwatch_t:unix_stream_socket create_stream_socket_perms;
 create_dir_file(arpwatch_t,arpwatch_data_t)
 allow arpwatch_t tmp_t:dir { search };
+tmp_domain(arpwatch)
+allow arpwatch_t net_conf_t:file { getattr read };
+allow arpwatch_t netif_lo_t:netif { udp_send };
+allow arpwatch_t sbin_t:dir { search };
+allow arpwatch_t sbin_t:lnk_file { read };
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/bootloader.te policy-1.17.31/domains/program/unused/bootloader.te
--- nsapolicy/domains/program/unused/bootloader.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.17.31/domains/program/unused/bootloader.te	2004-10-13 23:15:03.827373060 -0400
@@ -121,7 +121,7 @@
 allow bootloader_t proc_t:dir { getattr search };
 allow bootloader_t proc_t:file r_file_perms;
 allow bootloader_t proc_t:lnk_file { getattr read };
-allow bootloader_t proc_mdstat_t:file { getattr read };
+allow bootloader_t proc_mdstat_t:file r_file_perms;
 allow bootloader_t self:dir { getattr search read };
 allow bootloader_t sysctl_kernel_t:dir search;
 allow bootloader_t sysctl_kernel_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/canna.te policy-1.17.31/domains/program/unused/canna.te
--- nsapolicy/domains/program/unused/canna.te	2004-09-01 11:17:48.000000000 -0400
+++ policy-1.17.31/domains/program/unused/canna.te	2004-10-13 23:15:03.827373060 -0400
@@ -15,7 +15,8 @@
 logdir_domain(canna)
 var_lib_domain(canna)
 
-allow canna_t self:capability { setgid setuid };
+allow canna_t self:capability { setgid setuid net_bind_service };
+allow canna_t tmp_t:dir { search };
 allow canna_t self:unix_stream_socket { connectto create_stream_socket_perms};
 allow canna_t self:unix_dgram_socket create_stream_socket_perms;
 allow canna_t etc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.17.31/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.17.31/domains/program/unused/cups.te	2004-10-13 23:15:03.828372947 -0400
@@ -20,7 +20,6 @@
 
 can_network(cupsd_t)
 can_ypbind(cupsd_t)
-dbusd_client(system, cupsd_t)
 logdir_domain(cupsd)
 
 tmp_domain(cupsd)
@@ -188,13 +187,18 @@
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ftpd.te policy-1.17.31/domains/program/unused/ftpd.te
--- nsapolicy/domains/program/unused/ftpd.te	2004-10-09 21:06:14.000000000 -0400
+++ policy-1.17.31/domains/program/unused/ftpd.te	2004-10-13 23:21:35.811208827 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.17.31/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.17.31/domains/program/unused/hald.te	2004-10-13 23:15:03.829372834 -0400
@@ -63,3 +63,4 @@
 dontaudit hald_t selinux_config_t:dir { search };
 allow hald_t initrc_t:dbus { send_msg };
 allow initrc_t hald_t:dbus { send_msg };
+allow hald_t etc_runtime_t:file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/innd.te policy-1.17.31/domains/program/unused/innd.te
--- nsapolicy/domains/program/unused/innd.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.17.31/domains/program/unused/innd.te	2004-10-13 23:15:03.830372722 -0400
@@ -21,7 +21,7 @@
 r_dir_file(userdomain, { news_spool_t innd_var_lib_t innd_etc_t })
 
 can_exec(initrc_t, innd_etc_t)
-can_exec(innd_t, { innd_exec_t bin_t })
+can_exec(innd_t, { innd_exec_t bin_t shell_exec_t })
 ifdef(`hostname.te', `
 can_exec(innd_t, hostname_exec_t)
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ntpd.te policy-1.17.31/domains/program/unused/ntpd.te
--- nsapolicy/domains/program/unused/ntpd.te	2004-10-09 21:06:14.000000000 -0400
+++ policy-1.17.31/domains/program/unused/ntpd.te	2004-10-13 23:15:03.831372609 -0400
@@ -50,7 +50,7 @@
 can_exec(ntpd_t, initrc_exec_t)
 allow ntpd_t self:fifo_file { read write getattr };
 allow ntpd_t etc_runtime_t:file r_file_perms;
-can_exec(ntpd_t, { bin_t shell_exec_t sbin_t ls_exec_t ntpd_exec_t })
+can_exec(ntpd_t, { bin_t shell_exec_t sbin_t ls_exec_t logrotate_exec_t ntpd_exec_t })
 allow ntpd_t { sbin_t bin_t }:dir search;
 allow ntpd_t bin_t:lnk_file read;
 allow ntpd_t sysctl_kernel_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postfix.te policy-1.17.31/domains/program/unused/postfix.te
--- nsapolicy/domains/program/unused/postfix.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.17.31/domains/program/unused/postfix.te	2004-10-13 23:15:03.831372609 -0400
@@ -124,7 +124,7 @@
 allow postfix_master_t postfix_spool_maildrop_t:file { unlink rename getattr };
 allow postfix_master_t postfix_prng_t:file getattr;
 allow postfix_master_t privfd:fd use;
-allow postfix_master_t etc_aliases_t:file r_file_perms;
+allow postfix_master_t etc_aliases_t:file rw_file_perms;
 
 ifdef(`saslauthd.te',`
 allow postfix_smtpd_t saslauthd_var_run_t:dir { search getattr };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rlogind.te policy-1.17.31/domains/program/unused/rlogind.te
--- nsapolicy/domains/program/unused/rlogind.te	2004-10-09 21:06:14.000000000 -0400
+++ policy-1.17.31/domains/program/unused/rlogind.te	2004-10-13 23:15:03.832372496 -0400
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
-allow rlogind_t rlogind_t:capability { net_bind_service setuid setgid fowner fsetid chown dac_override };
+allow rlogind_t rlogind_t:capability { net_bind_service setuid setgid fowner fsetid chown dac_override sys_tty_config };
 
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rshd.te policy-1.17.31/domains/program/unused/rshd.te
--- nsapolicy/domains/program/unused/rshd.te	2004-10-09 21:06:14.000000000 -0400
+++ policy-1.17.31/domains/program/unused/rshd.te	2004-10-13 23:15:03.833372383 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/tftpd.te policy-1.17.31/domains/program/unused/tftpd.te
--- nsapolicy/domains/program/unused/tftpd.te	2004-10-13 22:41:58.000000000 -0400
+++ policy-1.17.31/domains/program/unused/tftpd.te	2004-10-13 23:15:03.833372383 -0400
@@ -16,7 +16,7 @@
 type tftp_port_t, port_type, reserved_port_type;
 
 # tftpdir_t is the type of files in the /tftpboot directories.
-type tftpdir_t, file_type, sysadmfile;
+type tftpdir_t, file_type, root_dir_type, sysadmfile;
 r_dir_file(tftpd_t, tftpdir_t)
 
 domain_auto_trans(inetd_t, tftpd_exec_t, tftpd_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xdm.te policy-1.17.31/domains/program/unused/xdm.te
--- nsapolicy/domains/program/unused/xdm.te	2004-10-06 09:18:32.000000000 -0400
+++ policy-1.17.31/domains/program/unused/xdm.te	2004-10-13 23:15:03.834372271 -0400
@@ -310,7 +310,7 @@
 allow xdm_t var_log_t:file { read };
 dontaudit xdm_t krb5_conf_t:file { write };
 allow xdm_t krb5_conf_t:file { getattr read };
-allow xdm_t xdm_t:capability { sys_nice sys_rawio };
+allow xdm_t self:capability { sys_nice sys_rawio net_bind_service };
 allow xdm_t xdm_t:process { setrlimit };
 allow xdm_t wtmp_t:file { getattr read };
 
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/ftpd.fc policy-1.17.31/file_contexts/program/ftpd.fc
--- nsapolicy/file_contexts/program/ftpd.fc	2004-03-17 13:26:06.000000000 -0500
+++ policy-1.17.31/file_contexts/program/ftpd.fc	2004-10-13 23:15:03.835372158 -0400
@@ -12,3 +12,4 @@
 /var/log/xferlog.*	--	system_u:object_r:xferlog_t
 /var/log/xferreport.*	--	system_u:object_r:xferlog_t
 /etc/cron\.monthly/proftpd --	system_u:object_r:ftpd_exec_t
+/var/ftp(/.*)?			system_u:object_r:ftpd_anon_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/kerberos.fc policy-1.17.31/file_contexts/program/kerberos.fc
--- nsapolicy/file_contexts/program/kerberos.fc	2004-08-30 16:13:29.000000000 -0400
+++ policy-1.17.31/file_contexts/program/kerberos.fc	2004-10-13 23:15:03.835372158 -0400
@@ -9,3 +9,4 @@
 /var/log/krb5kdc.log			system_u:object_r:krb5kdc_log_t
 /var/log/kadmind.log			system_u:object_r:kadmind_log_t
 /usr(/local)?/bin/ksu		--	system_u:object_r:su_exec_t
+/usr/kerberos/sbin/login.krb5	--	system_u:object_r:login_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/snmpd.fc policy-1.17.31/file_contexts/program/snmpd.fc
--- nsapolicy/file_contexts/program/snmpd.fc	2004-06-16 13:33:37.000000000 -0400
+++ policy-1.17.31/file_contexts/program/snmpd.fc	2004-10-13 23:15:03.836372045 -0400
@@ -5,4 +5,5 @@
 /usr/share/snmp/mibs/\.index -- system_u:object_r:snmpd_var_lib_t
 /var/run/snmpd\.pid	--	system_u:object_r:snmpd_var_run_t
 /var/run/snmpd		-d	system_u:object_r:snmpd_var_run_t
-/var/log/snmbd.log	--	system_u:object_r:snmpd_log_t
+/var/net-snmp(/.*)		system_u:object_r:snmpd_var_lib_t
+/var/log/snmpd.log	--	system_u:object_r:snmpd_log_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.17.31/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2004-10-13 22:41:58.000000000 -0400
+++ policy-1.17.31/macros/base_user_macros.te	2004-10-13 23:15:03.836372045 -0400
@@ -281,6 +281,7 @@
 
 # Get attributes of file systems.
 allow $1_t fs_type:filesystem getattr;
+allow $1_t removable_t:filesystem getattr;
 
 # Read and write /dev/tty and /dev/null.
 allow $1_t devtty_t:chr_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mount_macros.te policy-1.17.31/macros/program/mount_macros.te
--- nsapolicy/macros/program/mount_macros.te	2004-05-21 16:12:23.000000000 -0400
+++ policy-1.17.31/macros/program/mount_macros.te	2004-10-13 23:15:03.837371932 -0400
@@ -56,6 +56,8 @@
 allow $2_t home_root_t:dir { search };
 allow $2_t $1_home_dir_t:dir { search };
 allow $2_t noexattrfile:filesystem { mount unmount };
+allow $2_t fs_t:filesystem { getattr };
+allow $2_t removable_t:filesystem { mount unmount };
 allow $2_t mnt_t:dir { mounton search };
 allow $2_t sbin_t:dir { search };
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.17.31/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-08-20 13:57:29.000000000 -0400
+++ policy-1.17.31/tunables/distro.tun	2004-10-13 23:15:03.837371932 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.17.31/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-09-27 20:48:36.000000000 -0400
+++ policy-1.17.31/tunables/tunable.tun	2004-10-13 23:15:03.838371820 -0400
@@ -1,42 +1,39 @@
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
-
-# Allow ypbind to run with NIS
-dnl define(`allow_ypbind')
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
diff --exclude-from=exclude -N -u -r nsapolicy/types/file.te policy-1.17.31/types/file.te
--- nsapolicy/types/file.te	2004-09-22 16:19:14.000000000 -0400
+++ policy-1.17.31/types/file.te	2004-10-13 23:15:03.839371707 -0400
@@ -301,3 +301,4 @@
 
 # removable_t is the default type of all removable media
 type removable_t, file_type, sysadmfile, usercanread;
+allow removable_t self:filesystem associate;

--------------040507030503030807000705--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

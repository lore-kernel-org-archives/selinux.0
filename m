Message-ID: <4165B9AA.8090803@redhat.com>
Date: Thu, 07 Oct 2004 17:48:26 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: More SELinux fixes.
Content-Type: multipart/mixed;
 boundary="------------000305020807000107090503"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000305020807000107090503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Major fixup/cleanup of rpcd for nfs.

Fixes for ypbind.

Please eliminate space before "udp" in inetd_child calls.  This will not 
work correctly with the space.

Added reserved_port_type attribute for all ports less than 1024.  NIS is 
causing problems generating avc messages
on these ports for random name_bind.  Want to be able to tell system to 
don't audit these.   Might want to add a boolean
to specifiy whether using NIS or not.

misc fixes.

Dan

--------------000305020807000107090503
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/attrib.te policy-1.17.29/attrib.te
--- nsapolicy/attrib.te	2004-09-15 15:59:54.000000000 -0400
+++ policy-1.17.29/attrib.te	2004-10-07 17:41:56.845879967 -0400
@@ -296,6 +296,9 @@
 # Identifies all types assigned to port numbers to control binding.
 attribute port_type;
 
+# Identifies all types assigned to reserved port (<1024) numbers to control binding.
+attribute reserved_port_type;
+
 # Identifies all types assigned to network interfaces to control
 # operations on the interface (XXX obsolete, not supported via LSM) 
 # and to control traffic sent or received on the interface.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/mount.te policy-1.17.29/domains/program/mount.te
--- nsapolicy/domains/program/mount.te	2004-09-27 20:48:35.000000000 -0400
+++ policy-1.17.29/domains/program/mount.te	2004-10-07 17:40:00.785076302 -0400
@@ -72,7 +72,7 @@
 can_udp_send(portmap_t, mount_t)
 allow mount_t rpc_pipefs_t:dir search;
 ')
-dontaudit mount_t port_type:{tcp_socket udp_socket} name_bind;
+dontaudit mount_t reserved_port_type:{tcp_socket udp_socket} name_bind;
 
 #
 # required for mount.smbfs
@@ -93,7 +93,8 @@
 allow mount_t file_type:filesystem { unmount mount relabelto };
 
 allow mount_t mnt_t:dir { getattr };
-dontaudit mount_t { userdomain kernel_t}:fd use;
+dontaudit mount_t kernel_t:fd use;
+allow mount_t userdomain:fd use;
 can_exec(mount_t, { sbin_t bin_t })
 allow mount_t device_t:dir r_dir_perms;
 ifdef(`distro_redhat', `
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ssh.te policy-1.17.29/domains/program/ssh.te
--- nsapolicy/domains/program/ssh.te	2004-09-09 16:22:12.000000000 -0400
+++ policy-1.17.29/domains/program/ssh.te	2004-10-07 17:40:06.769393525 -0400
@@ -19,7 +19,7 @@
 type sshd_exec_t, file_type, exec_type, sysadmfile;
 type sshd_key_t, file_type, sysadmfile;
 
-type ssh_port_t, port_type;
+type ssh_port_t, port_type, reserved_port_type;
 
 define(`sshd_program_domain', `
 # privowner is for changing the identity on the terminal device
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/syslogd.te policy-1.17.29/domains/program/syslogd.te
--- nsapolicy/domains/program/syslogd.te	2004-10-07 08:02:01.000000000 -0400
+++ policy-1.17.29/domains/program/syslogd.te	2004-10-07 17:40:10.781935798 -0400
@@ -88,7 +88,7 @@
 allow syslogd_t tty_device_t:chr_file { getattr write ioctl append };
 
 # Allow name_bind for remote logging
-type syslogd_port_t, port_type;
+type syslogd_port_t, port_type, reserved_port_type;
 allow syslogd_t syslogd_port_t:udp_socket name_bind;
 #
 # /initrd is not umounted before minilog starts
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.17.29/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2004-09-22 16:19:12.000000000 -0400
+++ policy-1.17.29/domains/program/unused/apache.te	2004-10-07 17:29:53.660573397 -0400
@@ -19,7 +19,7 @@
 #  the user CGI scripts, then relabel rule for user_r should be removed.
 #
 ###############################################################################
-type http_port_t, port_type;
+type http_port_t, port_type, reserved_port_type;
 
 # Allow httpd cgi support
 bool httpd_enable_cgi false;
@@ -234,6 +234,8 @@
 can_unix_connect(httpd_php_t, mysqld_t)
 allow httpd_php_t mysqld_var_run_t:dir { search };
 allow httpd_php_t mysqld_var_run_t:sock_file { write };
+allow httpd_t mysqld_db_t:dir { search };
+allow httpd_t mysqld_db_t:sock_file rw_file_perms;
 ')
 allow httpd_t bin_t:dir { search };
 allow httpd_t sbin_t:dir { search };
@@ -253,11 +255,6 @@
 }
 ')dnl end if nfs_home_dirs
 
-ifdef(`mysql.te', `
-allow httpd_t mysqld_db_t:dir { search };
-allow httpd_t mysqld_db_t:sock_file rw_socket_perms;
-')
-
 #
 # Allow users to mount additional directories as http_source
 #
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/bootloader.te policy-1.17.29/domains/program/unused/bootloader.te
--- nsapolicy/domains/program/unused/bootloader.te	2004-08-27 16:51:30.000000000 -0400
+++ policy-1.17.29/domains/program/unused/bootloader.te	2004-10-07 17:24:28.485441537 -0400
@@ -121,6 +121,7 @@
 allow bootloader_t proc_t:dir { getattr search };
 allow bootloader_t proc_t:file r_file_perms;
 allow bootloader_t proc_t:lnk_file { getattr read };
+allow bootloader_t proc_mdstat_t:file r_file_perms;
 allow bootloader_t self:dir { getattr search read };
 allow bootloader_t sysctl_kernel_t:dir search;
 allow bootloader_t sysctl_kernel_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/comsat.te policy-1.17.29/domains/program/unused/comsat.te
--- nsapolicy/domains/program/unused/comsat.te	2004-10-06 09:18:32.000000000 -0400
+++ policy-1.17.29/domains/program/unused/comsat.te	2004-10-07 17:24:28.486441423 -0400
@@ -11,7 +11,7 @@
 # comsat_exec_t is the type of the comsat executable.
 #
 
-inetd_child_domain(comsat, udp)
+inetd_child_domain(comsat,udp)
 allow comsat_t initrc_var_run_t:file r_file_perms;
 dontaudit comsat_t initrc_var_run_t:file write;
 allow comsat_t mail_spool_t:dir r_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.17.29/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2004-10-06 09:18:32.000000000 -0400
+++ policy-1.17.29/domains/program/unused/cups.te	2004-10-07 17:30:34.084011000 -0400
@@ -11,7 +11,7 @@
 # cupsd_t is the domain of cupsd.
 # cupsd_exec_t is the type of the cupsd executable.
 #
-type ipp_port_t, port_type;
+type ipp_port_t, port_type, reserved_port_type;
 daemon_domain(cupsd, `, auth_chkpwd, nscd_client_domain')
 etcdir_domain(cupsd)
 typealias cupsd_etc_t alias etc_cupsd_t;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dhcpc.te policy-1.17.29/domains/program/unused/dhcpc.te
--- nsapolicy/domains/program/unused/dhcpc.te	2004-09-29 07:36:46.000000000 -0400
+++ policy-1.17.29/domains/program/unused/dhcpc.te	2004-10-07 17:31:07.542237378 -0400
@@ -15,7 +15,7 @@
 # dhcpc_exec_t is the type of the dhcpcd executable.
 # The dhcpc_t can be used for other DHCPC related files as well.
 #
-type dhcpc_port_t, port_type;
+type dhcpc_port_t, port_type, reserved_port_type;
 
 daemon_domain(dhcpc)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/fingerd.te policy-1.17.29/domains/program/unused/fingerd.te
--- nsapolicy/domains/program/unused/fingerd.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.17.29/domains/program/unused/fingerd.te	2004-10-07 17:32:03.462935221 -0400
@@ -12,7 +12,7 @@
 #
 daemon_domain(fingerd)
 
-type fingerd_port_t, port_type;
+type fingerd_port_t, port_type, reserved_port_type;
 etcdir_domain(fingerd)
 typealias fingerd_etc_t alias etc_fingerd_t;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ftpd.te policy-1.17.29/domains/program/unused/ftpd.te
--- nsapolicy/domains/program/unused/ftpd.te	2004-09-30 20:48:48.000000000 -0400
+++ policy-1.17.29/domains/program/unused/ftpd.te	2004-10-07 17:32:31.063826755 -0400
@@ -9,8 +9,8 @@
 #
 # Rules for the ftpd_t domain 
 #
-type ftp_port_t, port_type;
-type ftp_data_port_t, port_type;
+type ftp_port_t, port_type, reserved_port_type;
+type ftp_data_port_t, port_type, reserved_port_type;
 daemon_domain(ftpd, `, auth_chkpwd')
 etc_domain(ftpd)
 typealias ftpd_etc_t alias etc_ftpd_t;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/i18n_input.te policy-1.17.29/domains/program/unused/i18n_input.te
--- nsapolicy/domains/program/unused/i18n_input.te	2004-10-07 08:02:01.000000000 -0400
+++ policy-1.17.29/domains/program/unused/i18n_input.te	2004-10-07 17:24:28.486441423 -0400
@@ -32,3 +32,4 @@
 allow i18n_input_t etc_t:file r_file_perms;
 allow i18n_input_t self:unix_dgram_socket create_socket_perms;
 allow i18n_input_t self:unix_stream_socket create_stream_socket_perms;
+allow i18n_input_t i18n_input_var_run_t:sock_file create_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/inetd.te policy-1.17.29/domains/program/unused/inetd.te
--- nsapolicy/domains/program/unused/inetd.te	2004-10-06 09:18:32.000000000 -0400
+++ policy-1.17.29/domains/program/unused/inetd.te	2004-10-07 17:33:13.884006794 -0400
@@ -10,8 +10,8 @@
 # Rules for the inetd_t domain and
 # the inetd_child_t domain.
 #
-type telnet_port_t, port_type;
-type biff_port_t, port_type;
+type telnet_port_t, port_type, reserved_port_type;
+type biff_port_t, port_type, reserved_port_type;
 
 #################################
 #
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/innd.te policy-1.17.29/domains/program/unused/innd.te
--- nsapolicy/domains/program/unused/innd.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.17.29/domains/program/unused/innd.te	2004-10-07 17:33:29.488251060 -0400
@@ -7,7 +7,7 @@
 
 # Types for the server port and news spool.
 #
-type innd_port_t, port_type;
+type innd_port_t, port_type, reserved_port_type;
 type news_spool_t, file_type, sysadmfile;
 
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/kerberos.te policy-1.17.29/domains/program/unused/kerberos.te
--- nsapolicy/domains/program/unused/kerberos.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.17.29/domains/program/unused/kerberos.te	2004-10-07 17:34:13.697278778 -0400
@@ -16,8 +16,8 @@
 #
 # Rules for the krb5kdc_t,kadmind_t domains.
 #
-type kerberos_port_t, port_type;
-type kerberos_admin_port_t, port_type;
+type kerberos_port_t, port_type, reserved_port_type;
+type kerberos_admin_port_t, port_type, reserved_port_type;
 type kerberos_master_port_t, port_type;
 
 daemon_domain(krb5kdc)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ktalkd.te policy-1.17.29/domains/program/unused/ktalkd.te
--- nsapolicy/domains/program/unused/ktalkd.te	2004-10-06 09:18:32.000000000 -0400
+++ policy-1.17.29/domains/program/unused/ktalkd.te	2004-10-07 17:24:28.487441309 -0400
@@ -10,4 +10,4 @@
 # ktalkd_exec_t is the type of the ktalkd executable.
 #
 
-inetd_child_domain(ktalkd, udp)
+inetd_child_domain(ktalkd,udp)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/lpd.te policy-1.17.29/domains/program/unused/lpd.te
--- nsapolicy/domains/program/unused/lpd.te	2004-09-09 16:22:12.000000000 -0400
+++ policy-1.17.29/domains/program/unused/lpd.te	2004-10-07 17:34:33.679032292 -0400
@@ -15,7 +15,7 @@
 # printer_t is the type of the Unix domain socket created
 # by lpd.
 #
-type printer_port_t, port_type;
+type printer_port_t, port_type, reserved_port_type;
 daemon_domain(lpd)
 
 allow lpd_t lpd_var_run_t:sock_file create_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mta.te policy-1.17.29/domains/program/unused/mta.te
--- nsapolicy/domains/program/unused/mta.te	2004-09-22 16:19:12.000000000 -0400
+++ policy-1.17.29/domains/program/unused/mta.te	2004-10-07 17:35:10.387906603 -0400
@@ -13,7 +13,7 @@
 ifdef(`sendmail.te', `', `
 type sendmail_exec_t, file_type, exec_type, sysadmfile;
 ')
-type smtp_port_t, port_type;
+type smtp_port_t, port_type, reserved_port_type;
 
 
 # create a system_mail_t domain for daemons, init scripts, etc when they run
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/named.te policy-1.17.29/domains/program/unused/named.te
--- nsapolicy/domains/program/unused/named.te	2004-09-22 16:19:12.000000000 -0400
+++ policy-1.17.29/domains/program/unused/named.te	2004-10-07 17:35:25.596197849 -0400
@@ -10,7 +10,7 @@
 #
 # Rules for the named_t domain.
 #
-type rndc_port_t, port_type;
+type rndc_port_t, port_type, reserved_port_type;
 
 daemon_domain(named, `, nscd_client_domain')
 tmp_domain(named)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nscd.te policy-1.17.29/domains/program/unused/nscd.te
--- nsapolicy/domains/program/unused/nscd.te	2004-09-22 16:19:12.000000000 -0400
+++ policy-1.17.29/domains/program/unused/nscd.te	2004-10-07 17:26:44.804943879 -0400
@@ -73,3 +73,6 @@
 r_dir_file(nscd_t, selinux_config_t)
 can_getsecurity(nscd_t)
 allow nscd_t self:netlink_selinux_socket create_socket_perms;
+
+dontaudit nscd_t reserved_port_type:{ tcp_socket udp_socket } name_bind;
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ntpd.te policy-1.17.29/domains/program/unused/ntpd.te
--- nsapolicy/domains/program/unused/ntpd.te	2004-09-27 20:48:35.000000000 -0400
+++ policy-1.17.29/domains/program/unused/ntpd.te	2004-10-07 17:35:49.503512261 -0400
@@ -10,7 +10,7 @@
 #
 daemon_domain(ntpd, `, nscd_client_domain')
 type ntp_drift_t, file_type, sysadmfile;
-type ntp_port_t, port_type;
+type ntp_port_t, port_type, reserved_port_type;
 
 logdir_domain(ntpd)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/portmap.te policy-1.17.29/domains/program/unused/portmap.te
--- nsapolicy/domains/program/unused/portmap.te	2004-09-15 15:59:55.000000000 -0400
+++ policy-1.17.29/domains/program/unused/portmap.te	2004-10-07 17:36:17.399379454 -0400
@@ -18,7 +18,7 @@
 allow portmap_t self:unix_dgram_socket create_socket_perms;
 allow portmap_t self:unix_stream_socket create_stream_socket_perms;
 
-type portmap_port_t, port_type;
+type portmap_port_t, port_type, reserved_port_type;
 
 tmp_domain(portmap)
 
@@ -52,5 +52,3 @@
 # Use capabilities
 allow portmap_t self:capability { net_bind_service setuid setgid };
 
-# do not log when it tries to bind to a port belonging to another domain
-#dontaudit portmap_t port_type:{ tcp_socket udp_socket } name_bind;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rhgb.te policy-1.17.29/domains/program/unused/rhgb.te
--- nsapolicy/domains/program/unused/rhgb.te	2004-10-06 09:18:32.000000000 -0400
+++ policy-1.17.29/domains/program/unused/rhgb.te	2004-10-07 17:24:28.488441195 -0400
@@ -22,6 +22,7 @@
 allow rhgb_t proc_t:file { getattr read };
 
 allow rhgb_t devtty_t:chr_file { read write };
+allow rhgb_t tty_device_t:chr_file { ioctl read write };
 
 read_locale(rhgb_t)
 allow rhgb_t { etc_t etc_runtime_t }:file { getattr read };
@@ -35,7 +36,7 @@
 
 allow rhgb_t ramfs_t:filesystem { mount unmount };
 allow rhgb_t mnt_t:dir { search mounton };
-allow rhgb_t rhgb_t:capability { sys_admin };
+allow rhgb_t self:capability { sys_admin sys_tty_config };
 dontaudit rhgb_t var_run_t:dir { search };
 
 can_network(rhgb_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rlogind.te policy-1.17.29/domains/program/unused/rlogind.te
--- nsapolicy/domains/program/unused/rlogind.te	2004-03-23 15:58:08.000000000 -0500
+++ policy-1.17.29/domains/program/unused/rlogind.te	2004-10-07 17:37:07.537750836 -0400
@@ -9,7 +9,7 @@
 #
 # Rules for the rlogind_t domain.
 #
-type rlogin_port_t, port_type;
+type rlogin_port_t, port_type, reserved_port_type;
 type rlogind_t, domain, privlog, auth_chkpwd, privfd;
 role system_r types rlogind_t;
 uses_shlib(rlogind_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpcd.te policy-1.17.29/domains/program/unused/rpcd.te
--- nsapolicy/domains/program/unused/rpcd.te	2004-10-01 15:05:31.000000000 -0400
+++ policy-1.17.29/domains/program/unused/rpcd.te	2004-10-07 17:39:24.209252642 -0400
@@ -8,11 +8,12 @@
 
 #################################
 #
-# Rules for the rpcd_t domain.
+# Rules for the rpcd_t and nfsd_t domain.
 #
 define(`rpc_domain', `
 daemon_base_domain($1)
 can_network($1_t)
+can_ypbind($1_t)
 allow $1_t etc_t:file { getattr read };
 read_locale($1_t)
 allow $1_t self:capability net_bind_service;
@@ -21,6 +22,15 @@
 allow $1_t var_lib_t:dir { search };
 allow $1_t var_lib_nfs_t:dir create_dir_perms;
 allow $1_t var_lib_nfs_t:file create_file_perms;
+# do not log when it tries to bind to a port belonging to another domain
+dontaudit $1_t reserved_port_type:{ tcp_socket udp_socket } name_bind;
+allow $1_t self:netlink_route_socket r_netlink_socket_perms;
+allow $1_t self:unix_dgram_socket create_socket_perms;
+allow $1_t self:unix_stream_socket create_stream_socket_perms;
+# bind to arbitary unused ports
+allow $1_t port_t:{ tcp_socket udp_socket } name_bind;
+allow $1_t sysctl_rpc_t:dir search;
+allow $1_t sysctl_rpc_t:file rw_file_perms;
 ')
 
 type exports_t, file_type, sysadmfile;
@@ -31,34 +41,20 @@
 #
 rpc_domain(rpcd)
 var_run_domain(rpcd)
+allow rpcd_t rpcd_var_run_t:dir setattr;
 
 # for rpc.rquotad
 allow rpcd_t sysctl_t:dir r_dir_perms;
-
-allow rpcd_t self:unix_dgram_socket create_socket_perms;
-allow rpcd_t self:unix_stream_socket create_socket_perms;
 allow rpcd_t self:fifo_file rw_file_perms;
-allow rpcd_t self:netlink_route_socket r_netlink_socket_perms;
 
 # rpcd_t needs to talk to the portmap_t domain
 can_udp_send(rpcd_t, portmap_t)
 
-# bind to arbitary unused ports
-allow rpcd_t port_t:{ tcp_socket udp_socket } name_bind;
-
-# do not log when it tries to bind to a port belonging to another domain
-dontaudit rpcd_t port_type:{ tcp_socket udp_socket } name_bind;
-
-# for /var/run/rpc.statd/ directory
-allow rpcd_t rpcd_var_run_t:dir { setattr rw_dir_perms };
-r_dir_file(rpcd_t, var_yp_t);
-
+allow initrc_t exports_t:file r_file_perms;
 ifdef(`distro_redhat', `
-allow rpcd_t self:capability { chown dac_override setgid setuid };
+allow rpcd_t self:capability { chown dac_override setgid setuid net_admin };
 # for /etc/rc.d/init.d/nfs to create /etc/exports
-allow initrc_t exports_t:file rw_file_perms;
-', `
-allow initrc_t exports_t:file r_file_perms;
+allow initrc_t exports_t:file write;
 ')
 
 allow rpcd_t self:file { getattr read };
@@ -75,19 +71,13 @@
 
 # for /proc/fs/nfs/exports - should we have a new type?
 allow nfsd_t proc_t:file r_file_perms;
-allow nfsd_t self:unix_dgram_socket create_socket_perms;
-allow nfsd_t self:unix_stream_socket create_stream_socket_perms;
 allow nfsd_t exports_t:file { getattr read };
 
 allow nfsd_t nfsd_fs_t:filesystem mount;
 allow nfsd_t nfsd_fs_t:dir search;
 allow nfsd_t nfsd_fs_t:file rw_file_perms;
-allow nfsd_t sysctl_rpc_t:dir search;
-allow nfsd_t sysctl_rpc_t:file rw_file_perms;
 allow initrc_t sysctl_rpc_t:dir search;
 allow initrc_t sysctl_rpc_t:file rw_file_perms;
-allow rpcd_t sysctl_rpc_t:dir search;
-allow rpcd_t sysctl_rpc_t:file rw_file_perms;
 
 type nfsd_rw_t, file_type, sysadmfile, usercanread;
 type nfsd_ro_t, file_type, sysadmfile, usercanread;
@@ -99,11 +89,14 @@
 create_dir_file(kernel_t,{ file_type -shadow_t })
 }
 
+dontaudit kernel_t shadow_t:file { getattr };
+
 bool nfs_export_all_ro false;
 
 if(nfs_export_all_ro) {
 allow nfsd_t { file_type -shadow_t }:dir r_dir_perms;
 r_dir_file(kernel_t,{ file_type -shadow_t })
+
 }
 allow nfsd_t { nfsd_rw_t nfsd_ro_t }:dir r_dir_perms;
 create_dir_file(kernel_t, nfsd_rw_t);
@@ -116,15 +109,17 @@
 # does not really need this, but it is easier to just allow it
 allow nfsd_t var_run_t:dir search;
 
-allow nfsd_t self:capability { sys_admin sys_resource };
+allow nfsd_t self:capability { sys_admin sys_resource net_admin };
 allow nfsd_t fs_t:filesystem getattr;
 
 can_udp_send(nfsd_t, portmap_t)
 can_udp_send(portmap_t, nfsd_t)
 
 can_tcp_connect(nfsd_t, portmap_t)
-allow nfsd_t port_t:{ udp_socket tcp_socket } name_bind;
 
 # for exportfs and rpc.mountd
 allow nfsd_t tmp_t:dir getattr;
+
 r_dir_file(rpcd_t, rpc_pipefs_t)
+allow rpcd_t rpc_pipefs_t:sock_file { read write };
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rshd.te policy-1.17.29/domains/program/unused/rshd.te
--- nsapolicy/domains/program/unused/rshd.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.17.29/domains/program/unused/rshd.te	2004-10-07 17:37:16.155783617 -0400
@@ -9,7 +9,7 @@
 #
 # Rules for the rshd_t domain.
 #
-type rsh_port_t, port_type;
+type rsh_port_t, port_type, reserved_port_type;
 daemon_sub_domain(inetd_t, rshd)
 
 ifdef(`tcpd.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/samba.te policy-1.17.29/domains/program/unused/samba.te
--- nsapolicy/domains/program/unused/samba.te	2004-08-18 08:42:50.000000000 -0400
+++ policy-1.17.29/domains/program/unused/samba.te	2004-10-07 17:37:36.879458053 -0400
@@ -41,7 +41,7 @@
 general_domain_access(smbd_t)
 general_proc_read_access(smbd_t)
 
-type smbd_port_t, port_type;
+type smbd_port_t, port_type, reserved_port_type;
 allow smbd_t smbd_port_t:tcp_socket name_bind;
 
 # Use capabilities.
@@ -90,7 +90,7 @@
 general_domain_access(nmbd_t)
 general_proc_read_access(nmbd_t)
 
-type nmbd_port_t, port_type;
+type nmbd_port_t, port_type, reserved_port_type;
 allow nmbd_t nmbd_port_t:udp_socket name_bind;
 
 # Use capabilities.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/sendmail.te policy-1.17.29/domains/program/unused/sendmail.te
--- nsapolicy/domains/program/unused/sendmail.te	2004-10-07 08:02:01.000000000 -0400
+++ policy-1.17.29/domains/program/unused/sendmail.te	2004-10-07 17:24:28.489441081 -0400
@@ -99,3 +99,5 @@
 allow system_mail_t sysctl_kernel_t:file read;
 dontaudit system_mail_t system_crond_tmp_t:file { append };
 dontaudit sendmail_t admin_tty_type:chr_file { getattr ioctl };
+allow sendmail_t initrc_var_run_t:file { getattr read };
+dontaudit sendmail_t initrc_var_run_t:file { lock write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/slapd.te policy-1.17.29/domains/program/unused/slapd.te
--- nsapolicy/domains/program/unused/slapd.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.17.29/domains/program/unused/slapd.te	2004-10-07 17:37:46.329397736 -0400
@@ -12,7 +12,7 @@
 #
 daemon_domain(slapd)
 
-type ldap_port_t, port_type;
+type ldap_port_t, port_type, reserved_port_type;
 allow slapd_t ldap_port_t:tcp_socket name_bind;
 
 etc_domain(slapd)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/snmpd.te policy-1.17.29/domains/program/unused/snmpd.te
--- nsapolicy/domains/program/unused/snmpd.te	2004-10-06 09:18:32.000000000 -0400
+++ policy-1.17.29/domains/program/unused/snmpd.te	2004-10-07 17:37:50.655912312 -0400
@@ -16,7 +16,7 @@
 can_network(snmpd_t)
 can_ypbind(snmpd_t)
 
-type snmp_port_t, port_type;
+type snmp_port_t, port_type, reserved_port_type;
 allow snmpd_t snmp_port_t:{ udp_socket tcp_socket } name_bind;
 
 etc_domain(snmpd)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/spamd.te policy-1.17.29/domains/program/unused/spamd.te
--- nsapolicy/domains/program/unused/spamd.te	2004-08-18 08:42:50.000000000 -0400
+++ policy-1.17.29/domains/program/unused/spamd.te	2004-10-07 17:38:12.609445542 -0400
@@ -9,7 +9,7 @@
 
 tmp_domain(spamd)
 
-type spamd_port_t, port_type;
+type spamd_port_t, port_type, reserved_port_type;
 allow spamd_t spamd_port_t:tcp_socket name_bind;
 
 general_domain_access(spamd_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/tftpd.te policy-1.17.29/domains/program/unused/tftpd.te
--- nsapolicy/domains/program/unused/tftpd.te	2004-03-23 15:58:08.000000000 -0500
+++ policy-1.17.29/domains/program/unused/tftpd.te	2004-10-07 17:38:27.479741975 -0400
@@ -13,10 +13,10 @@
 #
 daemon_domain(tftpd)
 
-type tftp_port_t, port_type;
+type tftp_port_t, port_type, reserved_port_type;
 
 # tftpdir_t is the type of files in the /tftpboot directories.
-type tftpdir_t, file_type, sysadmfile;
+type tftpdir_t, file_type, root_dir_type, sysadmfile;
 r_dir_file(tftpd_t, tftpdir_t)
 
 domain_auto_trans(inetd_t, tftpd_exec_t, tftpd_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.17.29/domains/program/unused/udev.te
--- nsapolicy/domains/program/unused/udev.te	2004-10-06 09:18:32.000000000 -0400
+++ policy-1.17.29/domains/program/unused/udev.te	2004-10-07 17:24:28.490440967 -0400
@@ -105,6 +105,8 @@
 dbusd_client(system, udev_t)
 
 allow udev_t device_t:dir { relabelfrom relabelto create_dir_perms };
+allow udev_t sysctl_dev_t:dir { search };
+allow udev_t sysctl_dev_t:file { getattr read };
 allow udev_t sysctl_modprobe_t:file { getattr read };
 allow udev_t udev_t:rawip_socket create_socket_perms;
 dontaudit  udev_t domain:dir r_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ypbind.te policy-1.17.29/domains/program/unused/ypbind.te
--- nsapolicy/domains/program/unused/ypbind.te	2004-07-30 14:39:45.000000000 -0400
+++ policy-1.17.29/domains/program/unused/ypbind.te	2004-10-07 17:24:28.491440853 -0400
@@ -15,7 +15,7 @@
 tmp_domain(ypbind)
 
 # Use capabilities.
-allow ypbind_t ypbind_t:capability net_bind_service;
+allow ypbind_t self:capability { net_admin net_bind_service };
 
 # Use the network.
 can_network(ypbind_t)
@@ -35,4 +35,7 @@
 allow ypbind_t var_yp_t:file create_file_perms;
 allow initrc_t var_yp_t:dir { getattr read };
 allow ypbind_t etc_t:file { getattr read };
-allow ypbind_t self:unix_stream_socket create_socket_perms;
+allow ypbind_t self:{ unix_dgram_socket unix_stream_socket } create_socket_perms;
+allow ypbind_t self:netlink_route_socket r_netlink_socket_perms;
+allow ypbind_t reserved_port_t:tcp_socket { name_bind };
+allow ypbind_t reserved_port_t:udp_socket { name_bind };
diff --exclude-from=exclude -N -u -r nsapolicy/genfs_contexts policy-1.17.29/genfs_contexts
--- nsapolicy/genfs_contexts	2004-10-07 08:02:00.000000000 -0400
+++ policy-1.17.29/genfs_contexts	2004-10-07 17:24:28.491440853 -0400
@@ -87,6 +87,7 @@
 
 # nfs
 genfscon nfs /				system_u:object_r:nfs_t
+genfscon nfs4 /				system_u:object_r:nfs_t
 
 # reiserfs - until xattr security support works properly
 genfscon reiserfs /			system_u:object_r:nfs_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.17.29/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2004-10-06 09:18:33.000000000 -0400
+++ policy-1.17.29/macros/base_user_macros.te	2004-10-07 17:24:28.492440739 -0400
@@ -45,6 +45,8 @@
 
 # open office is looking for the following
 dontaudit $1_t dri_device_t:chr_file rw_file_perms;
+# Do not flood message log, if the user does ls /dev 
+dontaudit $1_t dev_fs:dir_file_class_set getattr;
 
 # allow ptrace
 can_ptrace($1_t, $1_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/chkpwd_macros.te policy-1.17.29/macros/program/chkpwd_macros.te
--- nsapolicy/macros/program/chkpwd_macros.te	2004-10-01 15:05:32.000000000 -0400
+++ policy-1.17.29/macros/program/chkpwd_macros.te	2004-10-07 17:24:28.492440739 -0400
@@ -27,6 +27,7 @@
 role system_r types system_chkpwd_t;
 dontaudit auth_chkpwd shadow_t:file { getattr read };
 allow auth_chkpwd sbin_t:dir search;
+dontaudit $1_chkpwd_t tty_device_t:chr_file rw_file_perms;
 ', `
 domain_auto_trans($1_t, chkpwd_exec_t, $1_chkpwd_t)
 allow $1_t sbin_t:dir search;
@@ -51,9 +52,6 @@
 allow $1_chkpwd_t etc_t:file { getattr read };
 allow $1_chkpwd_t self:unix_dgram_socket create_socket_perms;
 allow $1_chkpwd_t self:unix_stream_socket create_socket_perms;
-ifdef(`targeted_policy', `
-allow $1_chkpwd_t tty_device_t:chr_file { read write };
-')
 read_locale($1_chkpwd_t)
 
 # Use capabilities.
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/inetd_macros.te policy-1.17.29/macros/program/inetd_macros.te
--- nsapolicy/macros/program/inetd_macros.te	2004-10-06 09:18:33.000000000 -0400
+++ policy-1.17.29/macros/program/inetd_macros.te	2004-10-07 17:28:18.332348120 -0400
@@ -46,7 +46,7 @@
 allow $1_t krb5_conf_t:file r_file_perms;
 dontaudit $1_t krb5_conf_t:file write;
 allow $1_t urandom_device_t:chr_file { getattr read };
-type $1_port_t, port_type;
+type $1_port_t, port_type, reserved_port_type;
 # Use sockets inherited from inetd.
 ifelse($2, `', `
 allow inetd_t $1_port_t:udp_socket { name_bind };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_macros.te policy-1.17.29/macros/program/ssh_macros.te
--- nsapolicy/macros/program/ssh_macros.te	2004-10-06 09:18:33.000000000 -0400
+++ policy-1.17.29/macros/program/ssh_macros.te	2004-10-07 17:24:28.493440625 -0400
@@ -117,7 +117,7 @@
 
 # for /bin/sh used to execute xauth
 dontaudit $1_ssh_t proc_t:dir search;
-dontaudit $1_ssh_t proc_t:file { getattr read };
+dontaudit $1_ssh_t proc_t:{ lnk_file file } { getattr read };
 can_exec($1_ssh_t, shell_exec_t)
 
 # Inherit and use descriptors from gnome-pty-helper.
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/xserver_macros.te policy-1.17.29/macros/program/xserver_macros.te
--- nsapolicy/macros/program/xserver_macros.te	2004-10-06 09:18:33.000000000 -0400
+++ policy-1.17.29/macros/program/xserver_macros.te	2004-10-07 17:24:28.494440511 -0400
@@ -64,7 +64,7 @@
 
 allow xdm_xserver_t init_t:fd use;
 
-dontaudit xdm_xserver_t sysadm_home_dir_t:dir { read search };
+dontaudit xdm_xserver_t homedirfile:dir { read search };
 ', `
 # The user role is authorized for this domain.
 role $1_r types $1_xserver_t;
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.17.29/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-08-20 13:57:29.000000000 -0400
+++ policy-1.17.29/tunables/distro.tun	2004-10-07 17:24:28.494440511 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.17.29/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-09-27 20:48:36.000000000 -0400
+++ policy-1.17.29/tunables/tunable.tun	2004-10-07 17:24:28.495440398 -0400
@@ -1,42 +1,42 @@
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
 
 # Allow ypbind to run with NIS
-dnl define(`allow_ypbind')
+define(`allow_ypbind')
 
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

--------------000305020807000107090503--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

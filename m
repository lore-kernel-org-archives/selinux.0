Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7UIxKrT007224
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 14:59:21 -0400 (EDT)
Message-ID: <41337903.7020308@redhat.com>
Date: Mon, 30 Aug 2004 14:59:15 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: russell@coker.com.au, SELinux <selinux@tycho.nsa.gov>
Subject: Previous patch broken.
References: <20040823215636.GD13677@lkcl.net>	 <200408242147.44485.russell@coker.com.au> <1093640980.24188.47.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1093640980.24188.47.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------040503080907080507070309"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040503080907080507070309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------040503080907080507070309
Content-Type: text/plain;
 name="policy-20040830.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-20040830.patch"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/crond.te policy-1.17.7/domains/program/crond.te
--- nsapolicy/domains/program/crond.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.7/domains/program/crond.te	2004-08-30 14:54:52.328858521 -0400
@@ -81,11 +81,13 @@
 ifdef(`distro_redhat', `
 # Run the rpm program in the rpm_t domain. Allow creation of RPM log files
 # via redirection of standard out.
+ifdef(`rpm.te', `
 allow crond_t rpm_log_t: file create_file_perms;
 
 system_crond_entry(rpm_exec_t, rpm_t)
 allow system_crond_t rpm_log_t:file create_file_perms;
 ')
+')
 
 allow system_crond_t var_log_t:file r_file_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te policy-1.17.7/domains/program/initrc.te
--- nsapolicy/domains/program/initrc.te	2004-08-30 09:49:15.000000000 -0400
+++ policy-1.17.7/domains/program/initrc.te	2004-08-30 14:54:52.329858406 -0400
@@ -12,12 +12,14 @@
 # initrc_exec_t is the type of the init program.
 #
 # do not use privmail for sendmail as it creates a type transition conflict
-type initrc_t, ifdef(`unlimitedRC', `admin, etc_writer, fs_domain, privmem, auth_write, unrestricted, ') domain, privlog, privowner, privmodule, ifdef(`sendmail.te', `', `privmail,') sysctl_kernel_writer;
 ifdef(`sendmail.te', `
+# do not use privmail for sendmail as it creates a type transition conflict
+type initrc_t, ifdef(`unlimitedRC', `admin, etc_writer, fs_domain, privmem, auth_write, unrestricted, ') domain, privlog, privowner, privmodule, sysctl_kernel_writer;
 allow system_mail_t initrc_t:fd use;
 allow system_mail_t initrc_t:fifo_file write;
+', `
+type initrc_t, ifdef(`unlimitedRC', `admin, etc_writer, fs_domain, privmem,auth_write, unrestricted, ') domain, privlog, privowner, privmodule, sysctl_kernel_writer, privmail;
 ')
-
 role system_r types initrc_t;
 uses_shlib(initrc_t);
 can_ypbind(initrc_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ssh.te policy-1.17.7/domains/program/ssh.te
--- nsapolicy/domains/program/ssh.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.7/domains/program/ssh.te	2004-08-30 14:54:52.330858292 -0400
@@ -232,6 +232,7 @@
 
 # Type for the ssh executable.
 type ssh_exec_t, file_type, exec_type, sysadmfile;
+can_exec(sshd_t, ssh_exec_t)
 
 # Everything else is in the ssh_domain macro in
 # macros/program/ssh_macros.te.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/syslogd.te policy-1.17.7/domains/program/syslogd.te
--- nsapolicy/domains/program/syslogd.te	2004-08-30 09:49:15.000000000 -0400
+++ policy-1.17.7/domains/program/syslogd.te	2004-08-30 14:54:52.331858177 -0400
@@ -95,3 +95,6 @@
 #
 dontaudit syslogd_t file_t:dir search;
 allow syslogd_t devpts_t:dir { search };
+# For tageted policy tries to read /init
+dontaudit syslogd_t root_t:file { getattr read };
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.17.7/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2004-08-30 09:49:15.000000000 -0400
+++ policy-1.17.7/domains/program/unused/apache.te	2004-08-30 14:54:52.331858177 -0400
@@ -41,6 +41,7 @@
 append_logdir_domain(httpd)
 #can read /etc/httpd/logs
 allow httpd_t httpd_log_t:lnk_file { read };
+allow httpd_t httpd_log_t:dir { remove_name };
 
 # For /etc/init.d/apache2 reload
 can_tcp_connect(httpd_t, httpd_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/canna.te policy-1.17.7/domains/program/unused/canna.te
--- nsapolicy/domains/program/unused/canna.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.7/domains/program/unused/canna.te	2004-08-30 14:54:52.332858063 -0400
@@ -40,4 +40,3 @@
 can_unix_connect(i18n_input_t, canna_t)
 ')
 
-allow canna_t tmp_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.17.7/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2004-08-30 09:49:15.000000000 -0400
+++ policy-1.17.7/domains/program/unused/cups.te	2004-08-30 14:54:52.332858063 -0400
@@ -157,5 +157,6 @@
 allow cupsd_t ptal_var_run_t:dir { search };
 dontaudit ptal_t { sysadm_home_dir_t staff_home_dir_t }:dir { getattr search };
 
+allow cupsd_t printer_device_t:fifo_file rw_file_perms;
 dontaudit cupsd_t selinux_config_t:dir search;
 dontaudit cupsd_t selinux_config_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dbusd.te policy-1.17.7/domains/program/unused/dbusd.te
--- nsapolicy/domains/program/unused/dbusd.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.7/domains/program/unused/dbusd.te	2004-08-30 14:55:40.446348342 -0400
@@ -32,3 +32,4 @@
 
 # SE-DBus specific permissions
 allow { dbus_client_domain userdomain } { dbusd_t self }:dbus { send_msg };
+domain_auto_trans(userdomain, dbusd_exec_t, dbusd_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dovecot.te policy-1.17.7/domains/program/unused/dovecot.te
--- nsapolicy/domains/program/unused/dovecot.te	2004-08-30 09:49:15.000000000 -0400
+++ policy-1.17.7/domains/program/unused/dovecot.te	2004-08-30 14:54:52.334857834 -0400
@@ -11,7 +11,7 @@
 
 type dovecot_cert_t, file_type, sysadmfile;
 
-allow dovecot_t self:capability { dac_override dac_read_search chown net_bind_service setgid setuid sys_chroot };
+allow dovecot_t self:capability { chown net_bind_service setgid setuid sys_chroot dac_override dac_read_search };
 allow dovecot_t self:process { setrlimit };
 can_network(dovecot_t)
 can_ypbind(dovecot_t)
@@ -19,8 +19,13 @@
 allow dovecot_t self:unix_stream_socket create_stream_socket_perms;
 can_unix_connect(dovecot_t, self)
 
+# For SSL certificates
+allow dovecot_t usr_t:file { getattr read };
+
 allow dovecot_t etc_t:file { getattr read };
 allow dovecot_t initrc_var_run_t:file { getattr };
+# Dovecot sub-binaries are lib_t on Debian and bin_t on Fedora
+allow dovecot_t lib_t:file { execute execute_no_trans };
 allow dovecot_t bin_t:dir { getattr search };
 can_exec(dovecot_t, bin_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ftpd.te policy-1.17.7/domains/program/unused/ftpd.te
--- nsapolicy/domains/program/unused/ftpd.te	2004-08-30 09:49:15.000000000 -0400
+++ policy-1.17.7/domains/program/unused/ftpd.te	2004-08-30 14:54:52.334857834 -0400
@@ -101,3 +101,4 @@
 allow ftpd_t nfs_t:file r_file_perms;
 }
 ')dnl end if nfs_home_dirs
+dontaudit ftpd_t selinux_config_t:dir { search };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.17.7/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2004-08-30 09:49:15.000000000 -0400
+++ policy-1.17.7/domains/program/unused/hald.te	2004-08-30 14:54:52.335857719 -0400
@@ -33,7 +33,10 @@
 allow hald_t { fixed_disk_device_t removable_device_t }:blk_file { getattr read ioctl };
 allow hald_t event_device_t:chr_file { getattr read };
 
-ifdef(`updfstab.te', `domain_auto_trans(hald_t, updfstab_exec_t, updfstab_t)')
+ifdef(`updfstab.te', `
+domain_auto_trans(hald_t, updfstab_exec_t, updfstab_t)
+allow updfstab_t hald_t:dbus { send_msg };
+')
 ifdef(`udev.te', `
 domain_auto_trans(hald_t, udev_exec_t, udev_t)
 allow udev_t hald_t:unix_dgram_socket sendto;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hotplug.te policy-1.17.7/domains/program/unused/hotplug.te
--- nsapolicy/domains/program/unused/hotplug.te	2004-08-30 09:49:15.000000000 -0400
+++ policy-1.17.7/domains/program/unused/hotplug.te	2004-08-30 14:54:52.335857719 -0400
@@ -137,7 +137,6 @@
 
 ifdef(`udev.te', `
 domain_auto_trans(hotplug_t, { udev_exec_t udev_helper_exec_t }, udev_t)
-allow hotplug_t udev_helper_exec_t:lnk_file read;
 ')
 
 file_type_auto_trans(hotplug_t, etc_t, etc_runtime_t, file)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/iptables.te policy-1.17.7/domains/program/unused/iptables.te
--- nsapolicy/domains/program/unused/iptables.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.7/domains/program/unused/iptables.te	2004-08-30 14:54:52.336857605 -0400
@@ -23,10 +23,9 @@
 # to allow rules to be saved on reboot
 allow iptables_t initrc_tmp_t:file rw_file_perms;
 
-type iptables_var_run_t, file_type, sysadmfile, pidfile;
-
 domain_auto_trans(iptables_t, ifconfig_exec_t, ifconfig_t)
-file_type_auto_trans(iptables_t, var_run_t, iptables_var_run_t, file)
+allow iptables_t var_t:dir search;
+var_run_domain(iptables)
 
 allow iptables_t self:process { fork signal_perms };
 
@@ -57,4 +56,3 @@
 
 # system-config-network appends to /var/log
 allow iptables_t var_log_t:file { append };
-allow iptables_t var_t:dir { search };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mdadm.te policy-1.17.7/domains/program/unused/mdadm.te
--- nsapolicy/domains/program/unused/mdadm.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.7/domains/program/unused/mdadm.te	2004-08-30 14:54:52.337857491 -0400
@@ -28,7 +28,6 @@
 # Ignore attempts to read every device file
 dontaudit mdadm_t device_type:{ chr_file blk_file } getattr;
 dontaudit mdadm_t device_t:{ fifo_file file dir chr_file blk_file } { read getattr };
-dontaudit mdadm_t device_t:dir r_dir_perms;
 dontaudit mdadm_t devpts_t:dir r_dir_perms;
 
 # Ignore attempts to read/write sysadmin tty
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/openca-ca.te policy-1.17.7/domains/program/unused/openca-ca.te
--- nsapolicy/domains/program/unused/openca-ca.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.7/domains/program/unused/openca-ca.te	2004-08-30 14:54:52.337857491 -0400
@@ -39,11 +39,6 @@
 allow httpd_t openca_ca_t:process {transition};
 allow httpd_t openca_ca_exec_t:dir r_dir_perms;
 
-#############################################################
-# Allow the script access to the library files so it can run
-#############################################################
-can_exec(openca_ca_t, lib_t)
-
 ##################################################################
 # Allow the script to get the file descriptor from the http deamon
 # and send sigchild to http deamon
@@ -52,6 +47,16 @@
 allow openca_ca_t httpd_t:fd use;
 allow openca_ca_t httpd_t:fifo_file {getattr write};
 
+############################################
+# Allow scripts to append to http logs
+#########################################
+allow openca_ca_t httpd_log_t:file { append getattr };
+
+#############################################################
+# Allow the script access to the library files so it can run
+#############################################################
+can_exec(openca_ca_t, lib_t)
+
 ########################################################################
 # The script needs to inherit the file descriptor and find the script it
 # needs to run
@@ -79,11 +84,6 @@
 ##############################################################################
 allow openca_ca_t openca_ca_exec_t:dir search;
 
-############################################
-# Allow scripts to append to http logs
-#########################################
-allow openca_ca_t httpd_log_t:file { append getattr };
-
 #
 # Allow access to writeable files under /etc/openca
 #
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/portmap.te policy-1.17.7/domains/program/unused/portmap.te
--- nsapolicy/domains/program/unused/portmap.te	2004-08-30 09:49:15.000000000 -0400
+++ policy-1.17.7/domains/program/unused/portmap.te	2004-08-30 14:54:52.338857376 -0400
@@ -26,6 +26,7 @@
 
 # portmap binds to arbitary ports
 allow portmap_t port_t:{ udp_socket tcp_socket } name_bind;
+allow portmap_t reserved_port_t:{ udp_socket tcp_socket } name_bind;
 
 allow portmap_t etc_t:file { getattr read };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpm.te policy-1.17.7/domains/program/unused/rpm.te
--- nsapolicy/domains/program/unused/rpm.te	2004-08-30 09:49:15.000000000 -0400
+++ policy-1.17.7/domains/program/unused/rpm.te	2004-08-30 14:54:52.339857262 -0400
@@ -10,7 +10,7 @@
 # var_log_rpm_t is the type for rpm log files (/var/log/rpmpkgs*)
 # var_lib_rpm_t is the type for rpm files in /var/lib
 #
-type rpm_t, domain, admin, etc_writer, privlog, privowner, privmem, priv_system_role, fs_domain, privfd ifdef(`unlimitedRPM', `,auth_write, unrestricted');
+type rpm_t, domain, admin, etc_writer, privlog, privowner, privmem, priv_system_role, fs_domain, privfd ifdef(`unlimitedRPM', `, unrestricted, auth_write');
 role system_r types rpm_t;
 uses_shlib(rpm_t)
 type rpm_exec_t, file_type, sysadmfile, exec_type;
@@ -60,7 +60,6 @@
 allow rpm_t devtty_t:chr_file rw_file_perms;
 
 domain_auto_trans(rpm_t, ldconfig_exec_t, ldconfig_t)
-domain_auto_trans(rpm_t, initrc_exec_t, initrc_t)
 
 ifdef(`cups.te', `
 r_dir_file(cupsd_t, rpm_var_lib_t)
@@ -116,7 +115,7 @@
 
 allow { insmod_t depmod_t } rpm_t:fifo_file rw_file_perms;
 
-type rpm_script_t, domain, admin, etc_writer, privlog, privowner, privmodule, privmem, fs_domain, privfd, priv_system_role ifdef(`unlimitedRPM', `,auth_write, unrestricted');
+type rpm_script_t, domain, admin, etc_writer, privlog, privowner, privmodule, privmem, fs_domain, privfd, priv_system_role ifdef(`unlimitedRPM', `, unrestricted, auth_write');
 # policy for rpm scriptlet
 role system_r types rpm_script_t;
 uses_shlib(rpm_script_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.17.7/domains/program/unused/udev.te
--- nsapolicy/domains/program/unused/udev.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.7/domains/program/unused/udev.te	2004-08-30 14:54:52.340857147 -0400
@@ -16,7 +16,6 @@
 etc_domain(udev)
 typealias udev_etc_t alias etc_udev_t;
 type udev_helper_exec_t, file_type, sysadmfile, exec_type;
-r_dir_file(udev_t, udev_helper_exec_t)
 can_exec(udev_t, udev_helper_exec_t)
 
 #
@@ -32,19 +31,20 @@
 allow udev_t device_t:blk_file create_file_perms;
 allow udev_t device_t:chr_file create_file_perms;
 allow udev_t device_t:sock_file create_file_perms;
-allow udev_t etc_t:file { getattr read execute };
+allow udev_t device_t:lnk_file create_lnk_perms;
+allow udev_t etc_t:file { getattr read };
 allow udev_t { bin_t sbin_t }:dir r_dir_perms;
 allow udev_t { sbin_t bin_t }:lnk_file read;
-can_exec(udev_t, { shell_exec_t bin_t sbin_t } )
+allow udev_t bin_t:lnk_file read;
+can_exec(udev_t, { shell_exec_t bin_t sbin_t etc_t } )
 can_exec(udev_t, udev_exec_t)
-can_exec(udev_t, hostname_exec_t)
-can_exec(udev_t, iptables_exec_t)
 r_dir_file(udev_t, sysfs_t)
 allow udev_t sysadm_tty_device_t:chr_file { read write };
 allow udev_t { device_t device_type }:{chr_file blk_file} { relabelfrom relabelto create_file_perms };
 	
-# to read the file_contexts file?
-r_dir_file(udev_t, policy_config_t)
+# to read the file_contexts file
+allow udev_t { selinux_config_t default_context_t }:dir search;
+allow udev_t default_context_t:file { getattr read };
 
 allow udev_t policy_config_t:dir { search };
 allow udev_t proc_t:file { read };
@@ -52,6 +52,9 @@
 # Get security policy decisions.
 can_getsecurity(udev_t)
 
+# set file system create context
+can_setfscreate(udev_t)
+
 allow udev_t kernel_t:fd { use };
 allow udev_t kernel_t:unix_dgram_socket { sendto ioctl read write };
 
@@ -61,7 +64,9 @@
 domain_auto_trans(initrc_t, udev_exec_t, udev_t)
 domain_auto_trans(kernel_t, udev_exec_t, udev_t)
 domain_auto_trans(udev_t, restorecon_exec_t, restorecon_t)
-allow restorecon_t udev_t:unix_dgram_socket { read write };
+ifdef(`hide_broken_symptoms', `
+dontaudit restorecon_t udev_t:unix_dgram_socket { read write };
+')
 allow udev_t devpts_t:dir { search };
 allow udev_t etc_runtime_t:file { getattr read };
 allow udev_t etc_t:file { ioctl };
@@ -79,12 +84,11 @@
 can_exec(udev_t, consoletype_exec_t)
 ')
 domain_auto_trans(udev_t, ifconfig_exec_t, ifconfig_t)
-allow ifconfig_t udev_t:unix_dgram_socket { read write };
+ifdef(`hide_broken_symptoms', `
+dontaudit ifconfig_t udev_t:unix_dgram_socket { read write };
+')
 
 dontaudit udev_t file_t:dir search;
-allow udev_t device_t:lnk_file create_file_perms;
-allow udev_t var_lock_t:dir { search };
-allow udev_t var_lock_t:file { getattr read };
 ifdef(`dhcpc.te', `
 domain_auto_trans(udev_t, dhcpc_exec_t, dhcpc_t)
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xdm.te policy-1.17.7/domains/program/unused/xdm.te
--- nsapolicy/domains/program/unused/xdm.te	2004-08-30 09:49:15.000000000 -0400
+++ policy-1.17.7/domains/program/unused/xdm.te	2004-08-30 14:54:52.341857033 -0400
@@ -28,7 +28,7 @@
 # for xdmctl
 allow xdm_t xdm_var_run_t:fifo_file create_file_perms;
 allow initrc_t xdm_var_run_t:fifo_file unlink;
-file_type_auto_trans(xdm_t, var_run_t, xdm_var_run_t, fifo_file)
+file_type_auto_trans(xdm_t, var_run_t, xdm_var_run_t, { fifo_file dir })
 
 tmp_domain(xdm)
 var_lib_domain(xdm)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xfs.te policy-1.17.7/domains/program/unused/xfs.te
--- nsapolicy/domains/program/unused/xfs.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.7/domains/program/unused/xfs.te	2004-08-30 14:54:52.341857033 -0400
@@ -40,4 +40,3 @@
 # Read /usr/X11R6/lib/X11/fonts/.* and /usr/share/fonts/.*
 allow xfs_t fonts_t:dir search;
 allow xfs_t fonts_t:file { getattr read };
-allow xfs_t tmpfs_t:dir { search };
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/dovecot.fc policy-1.17.7/file_contexts/program/dovecot.fc
--- nsapolicy/file_contexts/program/dovecot.fc	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.7/file_contexts/program/dovecot.fc	2004-08-30 14:54:52.342856918 -0400
@@ -1,6 +1,12 @@
 # for Dovecot POP and IMAP server
 /usr/sbin/dovecot		--	system_u:object_r:dovecot_exec_t
+ifdef(`distro_redhat', `
 /usr/libexec/dovecot/dovecot-auth --	system_u:object_r:dovecot_auth_exec_t
+')
+ifdef(`distro_debian', `
+/usr/lib/dovecot/dovecot-auth	--	system_u:object_r:dovecot_auth_exec_t
+/usr/lib/dovecot/.+		--	system_u:object_r:bin_t
+')
 /usr/share/ssl/certs/dovecot.pem --	system_u:object_r:dovecot_cert_t
 /usr/share/ssl/private/dovecot.pem --	system_u:object_r:dovecot_cert_t
 /var/run/dovecot(-login)?(/.*)?		system_u:object_r:dovecot_var_run_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/initrc.fc policy-1.17.7/file_contexts/program/initrc.fc
--- nsapolicy/file_contexts/program/initrc.fc	2004-08-30 09:49:16.000000000 -0400
+++ policy-1.17.7/file_contexts/program/initrc.fc	2004-08-30 14:54:52.342856918 -0400
@@ -13,7 +13,9 @@
 /var/run/setmixer_flag	--	system_u:object_r:initrc_var_run_t
 # run_init
 /usr/sbin/run_init	--	system_u:object_r:run_init_exec_t
+ifdef(`distro_debian', `
 /usr/sbin/open_init_pty	--	system_u:object_r:initrc_exec_t
+')
 /etc/nologin.*		--	system_u:object_r:etc_runtime_t
 /etc/nohotplug		--	system_u:object_r:etc_runtime_t
 /halt                   --      system_u:object_r:etc_runtime_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/mailman.fc policy-1.17.7/file_contexts/program/mailman.fc
--- nsapolicy/file_contexts/program/mailman.fc	2004-08-30 09:49:16.000000000 -0400
+++ policy-1.17.7/file_contexts/program/mailman.fc	2004-08-30 14:54:52.343856804 -0400
@@ -4,7 +4,6 @@
 /usr/lib/cgi-bin/mailman/.* -- system_u:object_r:mailman_cgi_exec_t
 /usr/lib/mailman/cron/.*	-- system_u:object_r:mailman_queue_exec_t
 /usr/lib/mailman/mail/wrapper -- system_u:object_r:mailman_mail_exec_t
-/usr/lib/mailman/bin/mailmanctl -- system_u:object_r:mailman_mail_exec_t
 /usr/mailman/mail/wrapper 	-- system_u:object_r:mailman_mail_exec_t
 /var/lib/mailman(/.*)?	   system_u:object_r:mailman_data_t
 /var/lib/mailman/archives(/.*)?	system_u:object_r:mailman_archive_t
@@ -14,8 +13,6 @@
 ifdef(`distro_redhat', `
 /var/mailman/cgi-bin/.*		-- system_u:object_r:mailman_cgi_exec_t
 /var/mailman/data(/.*)?		   system_u:object_r:mailman_data_t
-/var/mailman/pythonlib(/.*)?	   system_u:object_r:mailman_data_t
-/var/mailman/Mailman(/.*)?	   system_u:object_r:mailman_data_t
 /var/mailman/locks(/.*)?	   system_u:object_r:mailman_lock_t
 /var/mailman/cron		-d system_u:object_r:bin_t
 /var/mailman/cron/.+		-- system_u:object_r:mailman_queue_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/udev.fc policy-1.17.7/file_contexts/program/udev.fc
--- nsapolicy/file_contexts/program/udev.fc	2004-08-30 09:49:16.000000000 -0400
+++ policy-1.17.7/file_contexts/program/udev.fc	2004-08-30 14:54:52.343856804 -0400
@@ -3,7 +3,8 @@
 /sbin/udev	--	system_u:object_r:udev_exec_t
 /sbin/udevd	--	system_u:object_r:udev_exec_t
 /usr/bin/udevinfo --	system_u:object_r:udev_exec_t
-/etc/dev\.d(/.*)? 	system_u:object_r:udev_helper_exec_t
-/etc/hotplug.d/default/udev.* system_u:object_r:udev_helper_exec_t
+/etc/dev\.d/.+	--	system_u:object_r:udev_helper_exec_t
+/etc/udev/scripts/.+	-- system_u:object_r:udev_helper_exec_t
+/etc/hotplug.d/default/udev.* -- system_u:object_r:udev_helper_exec_t
 /dev/udev\.tbl	--	system_u:object_r:udev_tbl_t
 /dev/\.udev\.tdb --	system_u:object_r:udev_tbl_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/xfs.fc policy-1.17.7/file_contexts/program/xfs.fc
--- nsapolicy/file_contexts/program/xfs.fc	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.7/file_contexts/program/xfs.fc	2004-08-30 14:54:52.344856689 -0400
@@ -1,3 +1,4 @@
 # xfs
 /tmp/\.font-unix(/.*)?		system_u:object_r:xfs_tmp_t
 /usr/X11R6/bin/xfs	--	system_u:object_r:xfs_exec_t
+/usr/X11R6/bin/xfs-xtt	--	system_u:object_r:xfs_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.17.7/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2004-08-30 09:49:15.000000000 -0400
+++ policy-1.17.7/file_contexts/types.fc	2004-08-30 14:54:52.345856575 -0400
@@ -217,7 +217,7 @@
 /u?dev/amixer.*		-c	system_u:object_r:sound_device_t
 /u?dev/snd/.*		-c	system_u:object_r:sound_device_t
 /u?dev/n?[hs]t[0-9].*	-c	system_u:object_r:tape_device_t
-/u?dev/n?(raw)?[qr]ft[0-3] -c	system_u:object_r:tape_device_t
+/u?dev/(n?raw)?[qr]ft[0-3] -c	system_u:object_r:tape_device_t
 /u?dev/n?z?qft[0-3]	-c	system_u:object_r:tape_device_t
 /u?dev/n?tpqic[12].*	-c	system_u:object_r:tape_device_t
 /u?dev/ht[0-1]		-b	system_u:object_r:tape_device_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/core_macros.te policy-1.17.7/macros/core_macros.te
--- nsapolicy/macros/core_macros.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.7/macros/core_macros.te	2004-08-30 14:54:52.346856460 -0400
@@ -590,7 +590,7 @@
 #
 define(`can_create_pty',`
 base_pty_perms($1)
-pty_slave_label($1, `$2')
+pty_slave_label($1, $2)
 ')
 
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te policy-1.17.7/macros/global_macros.te
--- nsapolicy/macros/global_macros.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.7/macros/global_macros.te	2004-08-30 14:54:52.347856346 -0400
@@ -598,7 +598,6 @@
 
 # Set user information and skip authentication.
 allow $1 self:passwd *;
-
 allow $1 self:dbus *;
 allow $1 self:nscd *;
-')
+')dnl end unconfined_domain
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/screen_macros.te policy-1.17.7/macros/program/screen_macros.te
--- nsapolicy/macros/program/screen_macros.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.7/macros/program/screen_macros.te	2004-08-30 14:54:52.348856232 -0400
@@ -48,9 +48,8 @@
 ifdef(`gnome-pty-helper.te', `allow $1_screen_t $1_gph_t:fd use;')
 
 allow $1_screen_t $1_home_screen_t:{ file lnk_file } r_file_perms;
-allow $1_t $1_home_screen_t:{ file lnk_file } create_file_perms;
-allow $1_t $1_home_screen_t:{ file lnk_file } { relabelfrom relabelto };
-
+allow $1_t $1_home_screen_t:file { create_file_perms relabelfrom relabelto };
+allow $1_t $1_home_screen_t:lnk_file { create_lnk_perms relabelfrom relabelto };
 ifdef(`nfs_home_dirs', `
 r_dir_file($1_screen_t, nfs_t)
 ')dnl end if nfs_home_dirs
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/xserver_macros.te policy-1.17.7/macros/program/xserver_macros.te
--- nsapolicy/macros/program/xserver_macros.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.7/macros/program/xserver_macros.te	2004-08-30 14:54:52.348856232 -0400
@@ -241,6 +241,7 @@
 
 allow $1_xserver_t var_lib_t:dir search;
 rw_dir_create_file($1_xserver_t, var_lib_xkb_t)
+dontaudit $1_xserver_t selinux_config_t:dir { search };
 
 # for fonts
 r_dir_file($1_xserver_t, fonts_t)
diff --exclude-from=exclude -N -u -r nsapolicy/Makefile policy-1.17.7/Makefile
--- nsapolicy/Makefile	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.7/Makefile	2004-08-30 14:54:52.349856117 -0400
@@ -146,6 +146,7 @@
 	@grep -v "^/root" $@.tmp > $@.root
 	@/usr/sbin/genhomedircon . $@.root  > $@
 	@grep "^/root" $@.tmp >> $@
+	@for i in /proc/ide/hd*/media; do grep -q cdrom $$i && echo $$i | awk -F / '{ print "/dev/"$$4"\t-b\tsystem_u:object_r:removable_device_t"}' >> $@ || true; done 
 	@-rm $@.tmp $@.root
 
 clean:
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.17.7/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.7/tunables/distro.tun	2004-08-30 14:54:52.349856117 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.17.7/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.7/tunables/tunable.tun	2004-08-30 14:54:52.350856003 -0400
@@ -5,40 +5,40 @@
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
 
 # Allow sysadm_t to do almost everything
 dnl define(`unrestricted_admin')
 
 # Allow the read/write/create on any NFS file system
-dnl define(`nfs_export_all_rw')
+define(`nfs_export_all_rw')
 
 # Allow users to unrestricted access
 dnl define(`unlimitedUsers')
@@ -48,9 +48,11 @@
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
-dnl define(`user_canbe_sysadm')
+define(`user_canbe_sysadm')
 
 # Allow xinetd to run unconfined, including any services it starts
 # that do not have a domain transition explicitly defined.
 dnl define(`unlimitedInetd')
 
+# Allow spamassasin to do DNS lookups
+dnl define(`spamassasin_can_network')

--------------040503080907080507070309--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

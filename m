Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7O8IlrT024334
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 04:18:47 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7O8HxMZ021481
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 08:18:00 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 082E261AFB
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 18:18:44 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 09991-04 for <selinux@tycho.nsa.gov>;
	Tue, 24 Aug 2004 18:18:43 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 11AEE61AFA
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 18:18:43 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id B9DA5B5889
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 18:18:40 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: policy patch
Date: Tue, 24 Aug 2004 18:18:40 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gnvKBsfv+pDoLOp"
Message-Id: <200408241818.40064.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_gnvKBsfv+pDoLOp
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

diff1 removes some unnecessary dontaudit lines from syslogd.te, if there is to 
be one single domain accessing devpts_t:chr_file then syslogd_t is not it, 
and if a log file gets type unlabeled_t then it's something we want audited.

httpd_t does not need search access to devpts_t (it is not granted access to 
any device node under /dev/pts).  httpd_suexec_t does not need 
net_bind_service (all it does it call setuid() and execute a script), it's 
access attempts of /var/run are the usual nscd stuff that gets a dontaudit 
rule.

It seems that only Red Hat has bootloader_t needing access to 
modules_object_t:lnk_file.

cpucontrol_t sometimes needs getattr access to a sym-link in /dev, no harm in 
granting it.

There should never be a printer_device_t:fifo_file object, there is no 
file_contexts entry assigning printer_device_t to a fifo_file object, so I 
remove the access to this invalid combination.

dovecot_cert_t is used for SSL certificates.  If there are any certificates 
labeled as usr_t then that's a bug in the file_contexts file.  I'll change 
the contexts of the files to use bin_t for sub-binaries on Debian as well as 
Red Hat (as well as putting some conditionals into the .fc file).

I changed ftpd.te to have the domain_auto_trans(inetd, part inside 
if(!ftpd_is_daemon).

Change hald.te to work with the latest version in Fedora.  I didn't want to 
give it read access to hard disks, but it seems that's he way things are 
going.

Changed hotplug.te to allow it to run arping on Red Hat, and to be a hald 
client (maybe we need a hald_client_domain attribute).

Allows lvm_t to create unix_dgram_socket objects.


-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_gnvKBsfv+pDoLOp
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff1"

diff -ru /usr/src/se/policy/domains/program/syslogd.te ./domains/program/syslogd.te
--- /usr/src/se/policy/domains/program/syslogd.te	2004-08-24 16:01:13.000000000 +1000
+++ ./domains/program/syslogd.te	2004-07-08 21:30:48.000000000 +1000
@@ -94,6 +94,3 @@
 #
 dontaudit syslogd_t file_t:dir search;
 allow syslogd_t devpts_t:dir { search };
-dontaudit syslogd_t devpts_t:chr_file { read write };
-
-dontaudit syslogd_t unlabeled_t:file { read };
diff -ru /usr/src/se/policy/domains/program/unused/apache.te ./domains/program/unused/apache.te
--- /usr/src/se/policy/domains/program/unused/apache.te	2004-08-15 15:45:15.000000000 +1000
+++ ./domains/program/unused/apache.te	2004-08-24 16:07:09.000000000 +1000
@@ -68,7 +69,6 @@
 
 allow httpd_t { random_device_t urandom_device_t }:chr_file { getattr ioctl read };
 
-allow httpd_t devpts_t:dir { search };
 allow httpd_t sysctl_kernel_t:dir search;
 allow httpd_t sysctl_kernel_t:file read;
 
@@ -88,11 +88,10 @@
 # Permissions for running child processes and scripts
 ##########################################################
 
-allow httpd_suexec_t self:capability { setuid setgid net_bind_service };
+allow httpd_suexec_t self:capability { setuid setgid };
 
-allow httpd_suexec_t var_run_t:dir { search };
-allow httpd_suexec_t var_t:dir { search };
-allow httpd_suexec_t var_log_t:dir search;
+dontaudit httpd_suexec_t var_run_t:dir search;
+allow httpd_suexec_t { var_t var_log_t }:dir search;
 allow httpd_suexec_t home_root_t:dir search;
 
 allow httpd_suexec_t httpd_log_t:dir search;
@@ -122,7 +121,10 @@
 
 uses_shlib(httpd_t)
 allow httpd_t { usr_t lib_t }:file { getattr read ioctl };
-allow httpd_t usr_t:lnk_file read;
+allow httpd_t usr_t:lnk_file { getattr read };
+
+# for apache2 memory mapped files
+var_lib_domain(httpd)
 
 # for tomcat
 r_dir_file(httpd_t, var_lib_t)
diff -ru /usr/src/se/policy/domains/program/unused/bootloader.te ./domains/program/unused/bootloader.te
--- /usr/src/se/policy/domains/program/unused/bootloader.te	2004-08-24 16:01:17.000000000 +1000
+++ ./domains/program/unused/bootloader.te	2004-08-24 16:07:33.000000000 +1000
@@ -65,7 +65,9 @@
 
 allow bootloader_t { modules_dep_t modules_object_t modules_conf_t }:file r_file_perms;
 allow bootloader_t modules_object_t:dir r_dir_perms;
+ifdef(`distro_redhat', `
 allow bootloader_t modules_object_t:lnk_file { getattr read };
+')
 
 # for ldd
 ifdef(`fsadm.te', `
diff -ru /usr/src/se/policy/domains/program/unused/cpucontrol.te ./domains/program/unused/cpucontrol.te
--- /usr/src/se/policy/domains/program/unused/cpucontrol.te	2004-08-24 16:01:19.000000000 +1000
+++ ./domains/program/unused/cpucontrol.te	2004-08-22 19:08:10.000000000 +1000
@@ -9,8 +9,8 @@
 
 # Access cpu devices.
 allow cpucontrol_t cpu_device_t:chr_file rw_file_perms;
+allow cpucontrol_t device_t:lnk_file { getattr read };
 allow initrc_t cpu_device_t:chr_file getattr;
-allow cpucontrol_t device_t:lnk_file { read };
 
 allow cpucontrol_t self:capability sys_rawio;
 
diff -ru /usr/src/se/policy/domains/program/unused/cups.te ./domains/program/unused/cups.te
--- /usr/src/se/policy/domains/program/unused/cups.te	2004-08-02 16:59:48.000000000 +1000
+++ ./domains/program/unused/cups.te	2004-08-24 16:10:02.000000000 +1000
@@ -152,11 +152,10 @@
 allow ptal_t printer_device_t:chr_file { ioctl read write };
 allow ptal_t { etc_t etc_runtime_t }:file { getattr read };
 r_dir_file(ptal_t, usbdevfs_t)
-allow cupsd_t ptal_var_run_t:sock_file { write setattr } ;
+allow cupsd_t ptal_var_run_t:sock_file { write setattr };
 allow cupsd_t ptal_t:unix_stream_socket { connectto };
 allow cupsd_t ptal_var_run_t:dir { search };
 dontaudit ptal_t { sysadm_home_dir_t staff_home_dir_t }:dir { getattr search };
 
-allow cupsd_t printer_device_t:fifo_file rw_file_perms;
 dontaudit cupsd_t selinux_config_t:dir search;
 dontaudit cupsd_t selinux_config_t:file { getattr read };
diff -ru /usr/src/se/policy/domains/program/unused/dovecot.te ./domains/program/unused/dovecot.te
--- /usr/src/se/policy/domains/program/unused/dovecot.te	2004-06-30 13:03:13.000000000 +1000
+++ ./domains/program/unused/dovecot.te	2004-08-24 16:19:10.000000000 +1000
@@ -11,20 +11,15 @@
 
 type dovecot_cert_t, file_type, sysadmfile;
 
-allow dovecot_t self:capability { chown net_bind_service setgid setuid sys_chroot dac_override dac_read_search };
+allow dovecot_t self:capability { dac_override dac_read_search chown net_bind_service setgid setuid sys_chroot };
 allow dovecot_t self:process { setrlimit };
 can_network(dovecot_t)
 allow dovecot_t self:unix_dgram_socket create_socket_perms;
 allow dovecot_t self:unix_stream_socket create_stream_socket_perms;
 can_unix_connect(dovecot_t, self)
 
-# For SSL certificates
-allow dovecot_t usr_t:file { getattr read };
-
 allow dovecot_t etc_t:file { getattr read };
 allow dovecot_t initrc_var_run_t:file { getattr };
-# Dovecot sub-binaries are lib_t on Debian and bin_t on Fedora
-allow dovecot_t lib_t:file { execute execute_no_trans };
 allow dovecot_t bin_t:dir { getattr search };
 can_exec(dovecot_t, bin_t)
 
diff -ru /usr/src/se/policy/domains/program/unused/ftpd.te ./domains/program/unused/ftpd.te
--- /usr/src/se/policy/domains/program/unused/ftpd.te	2004-08-08 22:16:26.000000000 +1000
+++ ./domains/program/unused/ftpd.te	2004-08-24 16:32:22.000000000 +1000
@@ -24,6 +24,7 @@
 
 allow ftpd_t bin_t:dir search;
 can_exec(ftpd_t, bin_t)
+allow ftpd_t bin_t:lnk_file read;
 allow ftpd_t { sysctl_t sysctl_kernel_t }:dir search;
 allow ftpd_t sysctl_kernel_t:file { getattr read };
 
@@ -32,14 +33,11 @@
 ifdef(`crond.te', `
 system_crond_entry(ftpd_exec_t, ftpd_t)
 can_exec(ftpd_t, { sbin_t shell_exec_t })
+allow ftpd_t usr_t:file { getattr read };
 ')
 
 allow ftpd_t ftp_data_port_t:tcp_socket name_bind;
 
-ifdef(`inetd.te', `
-domain_auto_trans(inetd_t, ftpd_exec_t, ftpd_t)
-')
-
 # Allow ftpd to run directly without inetd.
 bool ftpd_is_daemon false;
 if (ftpd_is_daemon) {
@@ -47,10 +45,10 @@
 allow ftpd_t ftp_port_t:tcp_socket name_bind;
 can_tcp_connect(userdomain, ftpd_t)
 }
-
 ifdef(`inetd.te', `
 if (!ftpd_is_daemon) {
 ifdef(`tcpd.te', `domain_auto_trans(tcpd_t, ftpd_exec_t, ftpd_t)')
+domain_auto_trans(inetd_t, ftpd_exec_t, ftpd_t)
 
 # Use sockets inherited from inetd.
 allow ftpd_t inetd_t:fd use;
@@ -87,11 +85,12 @@
 
 dontaudit ftpd_t sysadm_home_dir_t:dir getattr;
 dontaudit ftpd_t krb5_conf_t:file { write };
+dontaudit ftpd_t selinux_config_t:dir search;
 allow ftpd_t krb5_conf_t:file { getattr read };
 ifdef(`automount.te', `
 allow ftpd_t autofs_t:dir { search };
 ')
-allow ftpd_t self:file { read };
+allow ftpd_t self:file { getattr read };
 tmp_domain(ftpd)
 
 # Allow ftp to read/write files in the user home directories.
@@ -101,4 +100,4 @@
 allow ftpd_t nfs_t:dir r_dir_perms;
 allow ftpd_t nfs_t:file r_file_perms;
 }
-')
+')dnl end if nfs_home_dirs
diff -ru /usr/src/se/policy/domains/program/unused/hald.te ./domains/program/unused/hald.te
--- /usr/src/se/policy/domains/program/unused/hald.te	2004-08-18 22:42:50.000000000 +1000
+++ ./domains/program/unused/hald.te	2004-08-23 20:35:07.000000000 +1000
@@ -10,14 +10,15 @@
 #
 # hald_exec_t is the type of the hald executable.
 #
-daemon_domain(hald, `, dbus_client_domain')
+daemon_domain(hald, `, dbus_client_domain, fs_domain')
 
-allow hald_t etc_t:file { getattr read };
+allow hald_t { etc_t etc_runtime_t }:file { getattr read };
 allow hald_t self:unix_stream_socket create_stream_socket_perms;
+allow hald_t self:unix_dgram_socket create_socket_perms;
 
 allow hald_t dbusd_t:dbus { acquire_svc };
 
-allow hald_t self:file { getattr read };
+allow hald_t { self proc_t }:file { getattr read };
 
 allow hald_t { bin_t sbin_t }:dir search;
 allow hald_t hald_t:fifo_file rw_file_perms;
@@ -28,8 +29,14 @@
 allow hald_t self:capability { net_admin sys_admin };
 can_network(hald_t)
 
+allow hald_t fixed_disk_device_t:blk_file { getattr read };
+allow hald_t event_device_t:chr_file { getattr read };
+
 ifdef(`updfstab.te', `domain_auto_trans(hald_t, updfstab_exec_t, updfstab_t)')
-ifdef(`udev.te', `domain_auto_trans(hald_t, udev_exec_t, udev_t)')
+ifdef(`udev.te', `
+domain_auto_trans(hald_t, udev_exec_t, udev_t)
+allow udev_t hald_t:unix_dgram_socket sendto;
+')
 
 allow hald_t usbdevfs_t:dir search;
 allow hald_t usbdevfs_t:file { getattr read };
diff -ru /usr/src/se/policy/domains/program/unused/hotplug.te ./domains/program/unused/hotplug.te
--- /usr/src/se/policy/domains/program/unused/hotplug.te	2004-08-21 13:19:07.000000000 +1000
+++ ./domains/program/unused/hotplug.te	2004-08-23 16:37:52.000000000 +1000
@@ -17,14 +17,13 @@
 ')
 
 etcdir_domain(hotplug)
-typealias hotplug_etc_t alias etc_hotplug_t;
 
 allow hotplug_t self:fifo_file { read write getattr ioctl };
 allow hotplug_t self:unix_dgram_socket create_socket_perms;
 allow hotplug_t self:unix_stream_socket create_socket_perms;
 allow hotplug_t self:udp_socket create_socket_perms;
 
-allow hotplug_t sysctl_net_t:dir search;
+allow hotplug_t sysctl_net_t:dir r_dir_perms;
 allow hotplug_t sysctl_net_t:file { getattr read };
 
 # get info from /proc
@@ -43,12 +42,16 @@
 allow hotplug_t { bin_t sbin_t }:dir search;
 allow hotplug_t { bin_t sbin_t }:lnk_file read;
 can_exec(hotplug_t, { hotplug_exec_t bin_t sbin_t ls_exec_t shell_exec_t hotplug_etc_t etc_t })
-ifdef(`hostname.te', `
-can_exec(hotplug_t, hostname_exec_t)
-')
+ifdef(`hostname.te', `can_exec(hotplug_t, hostname_exec_t)')
+ifdef(`netutils.te', `
+ifdef(`distro_redhat', `
+# for arping used for static IP addresses on PCMCIA ethernet
+domain_auto_trans(hotplug_t, netutils_exec_t, netutils_t)
+')dnl end if distro_redhat
+')dnl end if netutils.te
 
 allow initrc_t usbdevfs_t:file { getattr read ioctl };
-allow initrc_t modules_dep_t:file { getattr read };
+allow initrc_t modules_dep_t:file { getattr read ioctl };
 r_dir_file(hotplug_t, usbdevfs_t)
 allow hotplug_t usbfs_t:dir r_dir_perms;
 allow hotplug_t usbfs_t:file { getattr read };
@@ -64,6 +67,10 @@
 allow hotplug_t var_lock_t:file getattr;
 ')
 
+ifdef(`hald.te', `
+allow hotplug_t hald_t:unix_dgram_socket sendto;
+')
+
 # for killall
 allow hotplug_t self:process { getsession getattr };
 allow hotplug_t self:file getattr;
@@ -129,8 +136,7 @@
 allow hotplug_t sound_device_t:chr_file { setattr };
 
 ifdef(`udev.te', `
-domain_auto_trans(hotplug_t, udev_exec_t, udev_t)
-domain_auto_trans(hotplug_t, udev_helper_exec_t, udev_t)
+domain_auto_trans(hotplug_t, { udev_exec_t udev_helper_exec_t }, udev_t)
 ')
 
 file_type_auto_trans(hotplug_t, etc_t, etc_runtime_t, file)
@@ -143,7 +149,7 @@
 domain_auto_trans(hotplug_t, sendmail_exec_t, system_mail_t) 
 ')
 
-allow restorecon_t hotplug_t:fd { use };
+allow restorecon_t hotplug_t:fd use;
 
 ifdef(`unlimitedUtils', `
 unconfined_domain(hotplug_t) 
diff -ru /usr/src/se/policy/domains/program/unused/lvm.te ./domains/program/unused/lvm.te
--- /usr/src/se/policy/domains/program/unused/lvm.te	2004-08-19 17:10:36.000000000 +1000
+++ ./domains/program/unused/lvm.te	2004-08-18 19:00:03.000000000 +1000
@@ -32,6 +32,7 @@
 allow lvm_t self:process { setsched };
 
 allow lvm_t self:fifo_file rw_file_perms;
+allow lvm_t self:unix_dgram_socket create_socket_perms;
 
 r_dir_file(lvm_t, proc_t)
 allow lvm_t self:file r_file_perms;

--Boundary-00=_gnvKBsfv+pDoLOp--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8B9sRrT023977
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 05:54:28 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8B9rT9R017788
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 09:53:31 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 1F09661AFD
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 19:54:22 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 20598-02 for <selinux@tycho.nsa.gov>;
	Sat, 11 Sep 2004 19:54:21 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 0D14861AFC
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 19:54:21 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 6FBECB5A0F
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 19:54:16 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: policy patch against latest CVS
Date: Sat, 11 Sep 2004 19:54:15 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_HtsQBEFB2kRBPdm"
Message-Id: <200409111954.15823.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_HtsQBEFB2kRBPdm
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch adds the dev_fs attribute in a few places where it was 
missed before and uses the dev_fs attribute for tmpfs_t:filesystem associate.

It puts all the tmpfs /dev stuff inside distro_redhat because currently no 
other distribution seems to be even considering doing this sort of thing (the 
feeling within the Gentoo camp appears to be strongly against it).  We could 
just as easily have a tmpfs_dev tunable for the same thing.

This patch removes one instance of ifdef(`devfsd.te'.  We should probably 
remove all the devfsd stuff and delete devfsd.te and devfsd.fc as I don't 
think we will ever support devfs again.

Removed some unneeded rules from the dovecot policy, someone added some 
supposedly Debian specific stuff which isn't needed for Debian, and we have a 
different type for certificates.

Trivial change to ipsec.te.

As previously discussed this patch removes a redundant allow rule from 
named.te.

lvm.fc is updated to the latest file location that is (AFAIK) used by everyone 
now).

Removed some redundant rules from user_macros.te.


I believe that this is all worthy of inclusion in the CVS.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_HtsQBEFB2kRBPdm
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru /usr/src/se/policy/attrib.te ./attrib.te
--- /usr/src/se/policy/attrib.te	2004-09-11 16:21:37.000000000 +1000
+++ ./attrib.te	2004-09-11 16:44:49.000000000 +1000
@@ -205,7 +205,7 @@
 # The device_type attribute identifies all types assigned to device nodes
 attribute device_type;
 
-# The dev_filesystem attribute identifies all types that may be assigned to
+# The dev_fs attribute identifies all types that may be assigned to
 # files, sockets, or pipes under /dev.
 attribute dev_fs;
 
diff -ru /usr/src/se/policy/domains/program/init.te ./domains/program/init.te
--- /usr/src/se/policy/domains/program/init.te	2004-09-11 16:21:43.000000000 +1000
+++ ./domains/program/init.te	2004-09-11 16:52:49.000000000 +1000
@@ -49,7 +49,10 @@
 ')
 
 # Create /dev/initctl.
-file_type_auto_trans(init_t, { device_t tmpfs_t }, initctl_t, fifo_file)
+file_type_auto_trans(init_t, device_t, initctl_t, fifo_file)
+ifdef(`distro_redhat', `
+file_type_auto_trans(init_t, tmpfs_t, initctl_t, fifo_file)
+')
 
 # Create ioctl.save.
 file_type_auto_trans(init_t, etc_t, etc_runtime_t, file)
@@ -114,7 +117,10 @@
 can_setbool(init_t)
 
 # Read and write the console and ttys.
-allow init_t { tmpfs_t tty_device_t console_device_t } :chr_file rw_file_perms;
+allow init_t { tty_device_t console_device_t } :chr_file rw_file_perms;
+ifdef(`distro_redhat', `
+allow init_t tmpfs_t:chr_file rw_file_perms;
+')
 allow init_t ttyfile:chr_file rw_file_perms;
 allow init_t ptyfile:chr_file rw_file_perms;
 
@@ -139,5 +145,3 @@
 
 # file descriptors inherited from the rootfs.
 dontaudit init_t root_t:{ file chr_file } { read write }; 
-
-rw_dir_file(init_t, tmpfs_t)
diff -ru /usr/src/se/policy/domains/program/mount.te ./domains/program/mount.te
--- /usr/src/se/policy/domains/program/mount.te	2004-09-11 16:21:43.000000000 +1000
+++ ./domains/program/mount.te	2004-09-11 16:53:53.000000000 +1000
@@ -60,9 +60,6 @@
 # mount binfmt_misc on /proc/sys/fs/binfmt_misc
 allow mount_t sysctl_t:dir { mounton search };
 
-ifdef(`devfsd.te', `
-allow mount_t device_t:filesystem { mount unmount };
-')
 allow mount_t root_t:filesystem unmount;
 
 ifdef(`portmap.te', `
@@ -98,6 +95,8 @@
 allow mount_t mnt_t:dir { getattr };
 dontaudit mount_t { userdomain kernel_t}:fd use;
 can_exec(mount_t, { sbin_t bin_t })
-dontaudit mount_t tmpfs_t:chr_file { read write };
 allow mount_t device_t:dir r_dir_perms;
+ifdef(`distro_redhat', `
+dontaudit mount_t tmpfs_t:chr_file { read write };
 allow mount_t tmpfs_t:dir { mounton };
+')
diff -ru /usr/src/se/policy/domains/program/restorecon.te ./domains/program/restorecon.te
--- /usr/src/se/policy/domains/program/restorecon.te	2004-09-11 16:21:43.000000000 +1000
+++ ./domains/program/restorecon.te	2004-09-11 16:55:22.000000000 +1000
@@ -41,8 +41,10 @@
 allow restorecon_t unlabeled_t:dir_file_class_set { getattr relabelfrom };
 allow restorecon_t unlabeled_t:dir read;
 allow restorecon_t device_type:{ chr_file blk_file } { getattr relabelfrom relabelto };
-allow restorecon_t { tmpfs_t device_t device_type }:{chr_file blk_file} { getattr relabelfrom relabelto };
-allow restorecon_t tmpfs_t:{chr_file blk_file} { read write };
+allow restorecon_t { device_t device_type }:{ chr_file blk_file } { getattr relabelfrom relabelto };
+ifdef(`distro_redhat', `
+allow restorecon_t tmpfs_t:{ chr_file blk_file } { rw_file_perms relabelfrom relabelto };
+')
 
 allow restorecon_t ptyfile:chr_file getattr;
 
diff -ru /usr/src/se/policy/domains/program/unused/cardmgr.te ./domains/program/unused/cardmgr.te
--- /usr/src/se/policy/domains/program/unused/cardmgr.te	2004-08-19 17:10:35.000000000 +1000
+++ ./domains/program/unused/cardmgr.te	2004-09-10 14:37:31.000000000 +1000
@@ -43,7 +43,7 @@
 allow cardmgr_t var_lib_t:file { getattr read };
 
 # Create device files in /tmp.
-type cardmgr_dev_t, file_type, sysadmfile, tmpfile, device_type;
+type cardmgr_dev_t, file_type, sysadmfile, tmpfile, device_type, dev_fs;
 ifdef(`tmpreaper.te', `
 allow tmpreaper_t cardmgr_dev_t:chr_file { getattr unlink };
 ')
diff -ru /usr/src/se/policy/domains/program/unused/consoletype.te ./domains/program/unused/consoletype.te
--- /usr/src/se/policy/domains/program/unused/consoletype.te	2004-09-11 16:21:44.000000000 +1000
+++ ./domains/program/unused/consoletype.te	2004-09-11 16:57:36.000000000 +1000
@@ -51,4 +51,6 @@
 ifdef(`pam.te', `
 allow consoletype_t pam_var_run_t:file { getattr read };
 ')
+ifdef(`distro_redhat', `
 dontaudit consoletype_t tmpfs_t:chr_file { read write };
+')
diff -ru /usr/src/se/policy/domains/program/unused/dovecot.te ./domains/program/unused/dovecot.te
--- /usr/src/se/policy/domains/program/unused/dovecot.te	2004-09-02 23:18:49.000000000 +1000
+++ ./domains/program/unused/dovecot.te	2004-09-09 04:31:46.000000000 +1000
@@ -19,13 +19,8 @@
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
 
diff -ru /usr/src/se/policy/domains/program/unused/gpm.te ./domains/program/unused/gpm.te
--- /usr/src/se/policy/domains/program/unused/gpm.te	2004-06-17 15:10:39.000000000 +1000
+++ ./domains/program/unused/gpm.te	2004-09-10 14:37:34.000000000 +1000
@@ -15,7 +15,7 @@
 #
 daemon_domain(gpm)
 
-type gpmctl_t, file_type, sysadmfile;
+type gpmctl_t, file_type, sysadmfile, dev_fs;
 
 tmp_domain(gpm)
 
diff -ru /usr/src/se/policy/domains/program/unused/ipsec.te ./domains/program/unused/ipsec.te
--- /usr/src/se/policy/domains/program/unused/ipsec.te	2004-09-11 16:21:44.000000000 +1000
+++ ./domains/program/unused/ipsec.te	2004-09-11 17:05:10.000000000 +1000
@@ -97,7 +97,7 @@
 # whack needs to be able to read/write pluto.ctl
 allow ipsec_mgmt_t ipsec_var_run_t:sock_file { read write };
 # and it wants to connect to a socket...
-allow ipsec_mgmt_t ipsec_mgmt_t:unix_stream_socket { create connect read write setopt };
+allow ipsec_mgmt_t self:unix_stream_socket create_stream_socket_perms;
 allow ipsec_mgmt_t ipsec_t:unix_stream_socket { connectto read write };
 
 # allow system administrator to use the ipsec script to look
@@ -207,7 +207,7 @@
 allow ipsec_t initrc_devpts_t:chr_file { getattr read write };
 allow ipsec_mgmt_t self:lnk_file read;
 
-allow ipsec_mgmt_t ipsec_mgmt_t:capability { sys_tty_config dac_read_search };
+allow ipsec_mgmt_t self:capability { sys_tty_config dac_read_search };
 read_locale(ipsec_mgmt_t)
 var_run_domain(ipsec_mgmt)
 dontaudit ipsec_mgmt_t default_t:dir { getattr };
@@ -222,5 +222,5 @@
 ')
 dontaudit ipsec_mgmt_t selinux_config_t:dir { search };
 dontaudit ipsec_t ttyfile:chr_file { read write };
-allow ipsec_t ipsec_t:capability { dac_override dac_read_search };
+allow ipsec_t self:capability { dac_override dac_read_search };
 allow ipsec_t reserved_port_t:udp_socket { name_bind };
diff -ru /usr/src/se/policy/domains/program/unused/named.te ./domains/program/unused/named.te
--- /usr/src/se/policy/domains/program/unused/named.te	2004-08-28 12:05:03.000000000 +1000
+++ ./domains/program/unused/named.te	2004-08-28 22:48:52.000000000 +1000
@@ -142,7 +142,6 @@
 allow ndc_t proc_t:dir search;
 allow ndc_t proc_t:file { getattr read };
 can_exec(ndc_t, { bin_t sbin_t shell_exec_t })
-allow ndc_t var_t:dir search;
 allow ndc_t named_var_run_t:file getattr;
 allow ndc_t named_zone_t:dir { read getattr };
 allow ndc_t named_zone_t:file getattr;
diff -ru /usr/src/se/policy/domains/program/unused/postgresql.te ./domains/program/unused/postgresql.te
--- /usr/src/se/policy/domains/program/unused/postgresql.te	2004-08-21 13:19:07.000000000 +1000
+++ ./domains/program/unused/postgresql.te	2004-09-08 23:08:57.000000000 +1000
@@ -17,6 +17,7 @@
 allow postgresql_t postgresql_var_run_t:sock_file create_file_perms;
 
 ifdef(`distro_debian', `
+can_exec(postgresql_t, initrc_exec_t)
 # gross hack
 domain_auto_trans(dpkg_t, postgresql_exec_t, postgresql_t)
 can_exec(postgresql_t, dpkg_exec_t)
diff -ru /usr/src/se/policy/domains/program/unused/udev.te ./domains/program/unused/udev.te
--- /usr/src/se/policy/domains/program/unused/udev.te	2004-09-11 16:21:45.000000000 +1000
+++ ./domains/program/unused/udev.te	2004-09-11 17:14:58.000000000 +1000
@@ -21,17 +21,23 @@
 #
 # Rules used for udev
 #
-type udev_tbl_t, file_type, sysadmfile;
+type udev_tbl_t, file_type, sysadmfile, dev_fs;
 file_type_auto_trans(udev_t, device_t, udev_tbl_t, file)
 allow udev_t self:capability { chown dac_override dac_read_search fowner fsetid sys_admin mknod };
 allow udev_t self:file { getattr read };
 allow udev_t self:unix_stream_socket {connectto create_stream_socket_perms};
 allow udev_t self:unix_dgram_socket create_socket_perms;
 allow udev_t self:fifo_file rw_file_perms;
-allow udev_t { tmpfs_t device_t }:blk_file create_file_perms;
-allow udev_t { tmpfs_t device_t }:chr_file create_file_perms;
-allow udev_t { tmpfs_t device_t }:sock_file create_file_perms;
-allow udev_t { tmpfs_t device_t }:lnk_file create_lnk_perms;
+allow udev_t device_t:sock_file create_file_perms;
+allow udev_t device_t:lnk_file create_lnk_perms;
+allow udev_t { device_t device_type }:{ chr_file blk_file } { relabelfrom relabelto create_file_perms };
+ifdef(`distro_redhat', `
+allow udev_t tmpfs_t:dir rw_dir_perms;
+allow udev_t tmpfs_t:sock_file create_file_perms;
+allow udev_t tmpfs_t:lnk_file create_lnk_perms;
+allow udev_t tmpfs_t:{ chr_file blk_file } { relabelfrom relabelto create_file_perms };
+allow udev_t tmpfs_t:dir search;
+')
 allow udev_t etc_t:file { getattr read };
 allow udev_t { bin_t sbin_t }:dir r_dir_perms;
 allow udev_t { sbin_t bin_t }:lnk_file read;
@@ -40,8 +46,7 @@
 can_exec(udev_t, udev_exec_t)
 r_dir_file(udev_t, sysfs_t)
 allow udev_t sysadm_tty_device_t:chr_file { read write };
-allow udev_t { tmpfs_t device_t device_type }:{chr_file blk_file} { relabelfrom relabelto create_file_perms };
-	
+
 # to read the file_contexts file
 r_dir_file(udev_t, { selinux_config_t file_context_t default_context_t } )
 
@@ -97,8 +102,6 @@
 domain_auto_trans(udev_t, dhcpc_exec_t, dhcpc_t)
 ')
 
-allow udev_t tmpfs_t:dir { search };
-rw_dir_create_file(udev_t, { device_t tmpfs_t })
 allow udev_t udev_helper_exec_t:dir r_dir_perms;
 
 dbusd_client(system, udev_t)
diff -ru /usr/src/se/policy/file_contexts/program/hald.fc ./file_contexts/program/hald.fc
--- /usr/src/se/policy/file_contexts/program/hald.fc	2004-09-11 16:21:46.000000000 +1000
+++ ./file_contexts/program/hald.fc	2004-09-11 19:16:02.000000000 +1000
@@ -1,4 +1,4 @@
-# hald - hardware informationd daemon
+# hald - hardware information daemon
 /usr/sbin/hald		--	system_u:object_r:hald_exec_t
 /usr/libexec/hal-hotplug-map -- system_u:object_r:hald_exec_t
 /etc/hal/device.d/printer_remove.hal -- system_u:object_r:hald_exec_t
diff -ru /usr/src/se/policy/file_contexts/program/lvm.fc ./file_contexts/program/lvm.fc
--- /usr/src/se/policy/file_contexts/program/lvm.fc	2004-08-21 13:19:08.000000000 +1000
+++ ./file_contexts/program/lvm.fc	2004-09-10 04:52:28.000000000 +1000
@@ -54,12 +54,7 @@
 /sbin/vgscan.static	--	system_u:object_r:lvm_exec_t
 /sbin/vgsplit		--	system_u:object_r:lvm_exec_t
 /sbin/vgwrapper		--	system_u:object_r:lvm_exec_t
-ifdef(`distro_redhat', `
-/usr/bin/cryptsetup	--	system_u:object_r:lvm_exec_t
-')
-ifdef(`distro_debian', `
 /sbin/cryptsetup	--	system_u:object_r:lvm_exec_t
-')
 /sbin/dmsetup      --      system_u:object_r:lvm_exec_t
 /sbin/dmsetup.static --    system_u:object_r:lvm_exec_t
 /sbin/lvm          --      system_u:object_r:lvm_exec_t
diff -ru /usr/src/se/policy/macros/user_macros.te ./macros/user_macros.te
--- /usr/src/se/policy/macros/user_macros.te	2004-09-03 14:10:35.000000000 +1000
+++ ./macros/user_macros.te	2004-09-11 19:37:22.000000000 +1000
@@ -22,11 +22,6 @@
 allow $1_t self:capability setuid;
 ')dnl end single_userdomain
 
-#
-# kdeinit wants this access
-#
-allow $1_t device_t:dir { getattr };
-
 # Type for home directory.
 type $1_home_dir_t, file_type, sysadmfile, home_dir_type, home_type, user_home_dir_type;
 type $1_home_t, file_type, sysadmfile, home_type, user_home_type;
@@ -80,16 +73,9 @@
 
 # Allow users to run TCP servers (bind to ports and accept connection from
 # the same domain and outside users)  disabling this forces FTP passive mode
-# and may change other protocols 
+# and may change other protocols
 if (user_tcp_server) {
-can_tcp_connect($1_t, $1_t)
 allow $1_t port_t:tcp_socket name_bind;
-
-# Connect data port to ftpd.
-ifdef(`ftpd.te', `can_tcp_connect(ftpd_t, $1_t)')
-
-# Connect second port to rshd.
-ifdef(`rshd.te', `can_tcp_connect(rshd_t, $1_t)')
 }
 
 # Allow system log read
diff -ru /usr/src/se/policy/types/file.te ./types/file.te
--- /usr/src/se/policy/types/file.te	2004-09-11 16:21:48.000000000 +1000
+++ ./types/file.te	2004-09-11 19:38:43.000000000 +1000
@@ -258,7 +258,9 @@
 # the default file system type.
 #
 allow { file_type device_type } fs_t:filesystem associate;
-allow { file_type device_type } tmpfs_t:filesystem associate;
+ifdef(`distro_redhat', `
+allow dev_fs tmpfs_t:filesystem associate;
+')
 
 # Allow the pty to be associated with the file system.
 allow devpts_t devpts_t:filesystem associate;

--Boundary-00=_HtsQBEFB2kRBPdm--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

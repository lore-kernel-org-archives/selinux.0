Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7O9bCrT024756
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 05:37:12 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7O9b8CV027198
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 09:37:09 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id D33DD61AFB
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 19:37:08 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 12859-03 for <selinux@tycho.nsa.gov>;
	Tue, 24 Aug 2004 19:37:08 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id EAAA561AFA
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 19:37:07 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 8E34BB5889
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 19:37:05 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: more policy patches
Date: Tue, 24 Aug 2004 19:37:04 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AxwKBeJ6yC/Xqbt"
Message-Id: <200408241937.04958.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_AxwKBeJ6yC/Xqbt
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch removes some more bogus access to devpts_t:chr_file.

prelink_t is not permitted to create sym-links of type bin_t or lib_t, so it 
makes no sense to allow it to unlink them AFAIK.  If for some strange reason 
this is not a silly thing to do then we need a comment in the policy to 
explain it.

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=120620
The above URL shows the resolution to the allow procmail_t mqueue_spool_t 
issue.  The user had stuffed up their procmail configuration.  It is quite 
fortunate for them that SE Linux revealed this error to them and allowed them 
to fix it.

Added a dontaudit in rpcd.te to stop "ls -l /etc" filling the logs with 
entries about exports_t.

Removed can_exec_any from xdm.te.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_AxwKBeJ6yC/Xqbt
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff2"

diff -ru /usr/src/se/policy/domains/program/unused/ntpd.te ./domains/program/unused/ntpd.te
--- /usr/src/se/policy/domains/program/unused/ntpd.te	2004-08-19 17:10:36.000000000 +1000
+++ ./domains/program/unused/ntpd.te	2004-08-05 13:40:26.000000000 +1000
@@ -66,5 +66,3 @@
 can_udp_send(ntpd_t, sysadm_t)
 can_udp_send(sysadm_t, ntpd_t)
 can_udp_send(ntpd_t, ntpd_t)
-
-dontaudit ntpd_t devpts_t:chr_file { read write };
diff -ru /usr/src/se/policy/domains/program/unused/portmap.te ./domains/program/unused/portmap.te
--- /usr/src/se/policy/domains/program/unused/portmap.te	2004-08-06 19:08:12.000000000 +1000
+++ ./domains/program/unused/portmap.te	2004-02-18 05:36:51.000000000 +1100
@@ -52,5 +52,3 @@
 
 # do not log when it tries to bind to a port belonging to another domain
 #dontaudit portmap_t port_type:{ tcp_socket udp_socket } name_bind;
-dontaudit portmap_t devpts_t:chr_file { read write };
-
diff -ru /usr/src/se/policy/domains/program/unused/prelink.te ./domains/program/unused/prelink.te
--- /usr/src/se/policy/domains/program/unused/prelink.te	2004-07-08 13:09:34.000000000 +1000
+++ ./domains/program/unused/prelink.te	2004-06-17 03:07:47.000000000 +1000
@@ -30,8 +30,6 @@
 allow prelink_t file_type:lnk_file r_file_perms;
 allow prelink_t file_type:file getattr;
 allow prelink_t { ifdef(`amanda.te', `amanda_usr_lib_t') admin_passwd_exec_t ifdef(`apache.te', `httpd_modules_t') ifdef(`xserver.te', `var_lib_xkb_t') ld_so_t su_exec_t shlib_t sbin_t bin_t lib_t exec_type }:file { create_file_perms execute relabelto relabelfrom };
-allow prelink_t { bin_t lib_t }:lnk_file { unlink };
-
 allow prelink_t ld_so_t:file execute_no_trans;
 
 allow prelink_t self:capability { chown dac_override fowner fsetid };
diff -ru /usr/src/se/policy/domains/program/unused/procmail.te ./domains/program/unused/procmail.te
--- /usr/src/se/policy/domains/program/unused/procmail.te	2004-07-08 13:09:34.000000000 +1000
+++ ./domains/program/unused/procmail.te	2004-05-05 05:07:47.000000000 +1000
@@ -71,4 +71,3 @@
 ifdef(`sendmail.te', `
 r_dir_file(procmail_t, etc_mail_t)
 ')
-allow procmail_t mqueue_spool_t:file { getattr read };
diff -ru /usr/src/se/policy/domains/program/unused/rpcd.te ./domains/program/unused/rpcd.te
--- /usr/src/se/policy/domains/program/unused/rpcd.te	2004-08-21 13:19:07.000000000 +1000
+++ ./domains/program/unused/rpcd.te	2004-08-21 13:22:58.000000000 +1000
@@ -24,6 +24,7 @@
 ')
 
 type exports_t, file_type, sysadmfile;
+dontaudit userdomain exports_t:file getattr;
 
 # rpcd_t is the domain of rpc daemons.
 # rpcd_exec_t is the type of rpc daemon programs.
diff -ru /usr/src/se/policy/domains/program/unused/rpm.te ./domains/program/unused/rpm.te
--- /usr/src/se/policy/domains/program/unused/rpm.te	2004-08-19 17:10:36.000000000 +1000
+++ ./domains/program/unused/rpm.te	2004-08-23 17:32:01.000000000 +1000
@@ -145,7 +144,7 @@
 can_exec_any(rpm_script_t)
 
 # Capabilties needed by rpm scripts utils
-allow rpm_script_t self:capability { chown dac_override fowner fsetid setgid setuid ipc_lock sys_chroot mknod };
+allow rpm_script_t self:capability { chown dac_override dac_read_search fowner fsetid setgid setuid ipc_lock sys_chroot mknod };
 
 # ideally we would not need this
 allow rpm_script_t { file_type - shadow_t }:dir create_dir_perms;
diff -ru /usr/src/se/policy/domains/program/unused/xdm.te ./domains/program/unused/xdm.te
--- /usr/src/se/policy/domains/program/unused/xdm.te	2004-08-19 17:10:37.000000000 +1000
+++ ./domains/program/unused/xdm.te	2004-07-08 16:05:36.000000000 +1000
@@ -106,7 +104,15 @@
 allow xdm_xserver_t xdm_tmp_t:sock_file create_file_perms;
 
 # Run helper programs.
-can_exec_any(xdm_t)
+allow xdm_t etc_t:file { getattr read };
+allow xdm_t bin_t:dir { getattr search };
+# lib_t is for running cpp
+can_exec(xdm_t, { shell_exec_t etc_t bin_t sbin_t lib_t })
+allow xdm_t { bin_t sbin_t }:lnk_file read;
+ifdef(`hostname.te', `can_exec(xdm_t, hostname_exec_t)')
+ifdef(`loadkeys.te', `can_exec(xdm_t, loadkeys_exec_t)')
+allow xdm_t xdm_xserver_t:process sigkill;
+allow xdm_t xdm_xserver_tmp_t:file unlink;
 
 # Access devices.
 allow xdm_t device_t:dir { read search };
diff -ru /usr/src/se/policy/domains/program/unused/xprint.te ./domains/program/unused/xprint.te
--- /usr/src/se/policy/domains/program/unused/xprint.te	2004-06-17 15:10:41.000000000 +1000
+++ ./domains/program/unused/xprint.te	2004-08-18 22:38:19.000000000 +1000
@@ -15,6 +15,7 @@
 allow initrc_t readable_t:dir r_dir_perms;
 allow initrc_t fonts_t:dir r_dir_perms;
 
+allow xprint_t var_lib_t:dir search;
 allow xprint_t fonts_t:dir r_dir_perms;
 allow xprint_t fonts_t:file { getattr read };
 
@@ -22,7 +23,7 @@
 can_exec(xprint_t, { bin_t sbin_t ls_exec_t shell_exec_t })
 allow xprint_t bin_t:lnk_file { getattr read };
 
-allow xprint_t tmp_t:dir search;
+allow xprint_t tmp_t:dir { getattr search };
 ifdef(`xdm.te', `
 allow xprint_t xdm_xserver_tmp_t:dir rw_dir_perms;
 allow xprint_t xdm_xserver_tmp_t:sock_file create_file_perms;
diff -ru /usr/src/se/policy/file_contexts/program/fsadm.fc ./file_contexts/program/fsadm.fc
--- /usr/src/se/policy/file_contexts/program/fsadm.fc	2004-03-27 00:46:44.000000000 +1100
+++ ./file_contexts/program/fsadm.fc	2004-08-18 15:36:04.000000000 +1000
@@ -26,6 +26,7 @@
 /sbin/blockdev		--	system_u:object_r:fsadm_exec_t
 /sbin/losetup.*		--	system_u:object_r:fsadm_exec_t
 /sbin/jfs_.*		--	system_u:object_r:fsadm_exec_t
+/sbin/lsraid		--	system_u:object_r:fsadm_exec_t
 /usr/sbin/smartctl	--	system_u:object_r:fsadm_exec_t
 /sbin/install-mbr	--	system_u:object_r:fsadm_exec_t
 /usr/bin/scsi_unique_id	--	system_u:object_r:fsadm_exec_t
diff -ru /usr/src/se/policy/file_contexts/program/initrc.fc ./file_contexts/program/initrc.fc
--- /usr/src/se/policy/file_contexts/program/initrc.fc	2004-07-15 10:22:53.000000000 +1000
+++ ./file_contexts/program/initrc.fc	2004-07-08 21:22:51.000000000 +1000
@@ -16,5 +16,3 @@
 /usr/sbin/open_init_pty	--	system_u:object_r:initrc_exec_t
 /etc/nologin.*		--	system_u:object_r:etc_runtime_t
 /etc/nohotplug		--	system_u:object_r:etc_runtime_t
-/halt                  --      system_u:object_r:etc_runtime_t
-/\.autofsck            --      system_u:object_r:etc_runtime_t
diff -ru /usr/src/se/policy/file_contexts/program/mailman.fc ./file_contexts/program/mailman.fc
--- /usr/src/se/policy/file_contexts/program/mailman.fc	2004-08-24 16:01:27.000000000 +1000
+++ ./file_contexts/program/mailman.fc	2004-08-21 13:22:58.000000000 +1000
@@ -4,6 +4,7 @@
 /usr/lib/cgi-bin/mailman/.* -- system_u:object_r:mailman_cgi_exec_t
 /usr/lib/mailman/cron/.*	-- system_u:object_r:mailman_queue_exec_t
 /usr/lib/mailman/mail/wrapper -- system_u:object_r:mailman_mail_exec_t
+/usr/lib/mailman/bin/mailmanctl -- system_u:object_r:mailman_mail_exec_t
 /usr/mailman/mail/wrapper 	-- system_u:object_r:mailman_mail_exec_t
 /var/lib/mailman(/.*)?	   system_u:object_r:mailman_data_t
 /var/lib/mailman/archives(/.*)?	system_u:object_r:mailman_archive_t
@@ -13,6 +14,8 @@
 ifdef(`distro_redhat', `
 /var/mailman/cgi-bin/.*		-- system_u:object_r:mailman_cgi_exec_t
 /var/mailman/data(/.*)?		   system_u:object_r:mailman_data_t
+/var/mailman/pythonlib(/.*)?	   system_u:object_r:mailman_data_t
+/var/mailman/Mailman(/.*)?	   system_u:object_r:mailman_data_t
 /var/mailman/locks(/.*)?	   system_u:object_r:mailman_lock_t
 /var/mailman/cron		-d system_u:object_r:bin_t
 /var/mailman/cron/.+		-- system_u:object_r:mailman_queue_exec_t
diff -ru /usr/src/se/policy/file_contexts/program/udev.fc ./file_contexts/program/udev.fc
--- /usr/src/se/policy/file_contexts/program/udev.fc	2004-08-19 17:10:44.000000000 +1000
+++ ./file_contexts/program/udev.fc	2004-08-17 13:24:19.000000000 +1000
@@ -5,5 +5,5 @@
 /usr/bin/udevinfo --	system_u:object_r:udev_exec_t
-/etc/dev.d(/.*)? 	system_u:object_r:udev_helper_exec_t
+/etc/dev\.d(/.*)? 	system_u:object_r:udev_helper_exec_t
 /etc/hotplug.d/default/udev.* system_u:object_r:udev_helper_exec_t
 /dev/udev\.tbl	--	system_u:object_r:udev_tbl_t
 /dev/\.udev\.tdb --	system_u:object_r:udev_tbl_t
diff -ru /usr/src/se/policy/file_contexts/types.fc ./file_contexts/types.fc
--- /usr/src/se/policy/file_contexts/types.fc	2004-08-24 16:01:25.000000000 +1000
+++ ./file_contexts/types.fc	2004-08-10 17:40:15.000000000 +1000
@@ -150,7 +150,6 @@
 /u?dev/ida/[^/]*	-b	system_u:object_r:fixed_disk_device_t
 /u?dev/dasd[^/]*	-b	system_u:object_r:fixed_disk_device_t
 /u?dev/flash[^/]*	-b	system_u:object_r:fixed_disk_device_t
-/u?dev/mdsp.*		-c	system_u:object_r:fixed_disk_device_t
 /u?dev/nb[^/]+		-b	system_u:object_r:fixed_disk_device_t
 /u?dev/ataraid/.*	-b	system_u:object_r:fixed_disk_device_t
 /u?dev/loop.*		-b	system_u:object_r:fixed_disk_device_t
diff -ru /usr/src/se/policy/genfs_contexts ./genfs_contexts
--- /usr/src/se/policy/genfs_contexts	2004-07-08 13:09:32.000000000 +1000
+++ ./genfs_contexts	2004-07-06 22:52:53.000000000 +1000
@@ -81,8 +82,8 @@
 genfscon ntfs /				system_u:object_r:dosfs_t
 
 # samba
-genfscon cifs /				system_u:object_r:sambafs_t
-genfscon smbfs /			system_u:object_r:sambafs_t
+genfscon cifs /				system_u:object_r:cifs_t
+genfscon smbfs /			system_u:object_r:cifs_t
 
 # nfs
 genfscon nfs /				system_u:object_r:nfs_t
diff -ru /usr/src/se/policy/macros/base_user_macros.te ./macros/base_user_macros.te
--- /usr/src/se/policy/macros/base_user_macros.te	2004-08-15 15:45:18.000000000 +1000
+++ ./macros/base_user_macros.te	2004-08-20 15:04:59.000000000 +1000
@@ -190,14 +192,9 @@
 
 # Gnome pannel binds to the following
 ifdef(`cups.te', `
-allow $1_t ipp_port_t:tcp_socket { name_bind };
 allow $1_t { cupsd_etc_t cupsd_rw_etc_t }:file { read getattr };
 ')
 
-ifdef(`use_pop', `
-allow $1_t pop_port_t:tcp_socket { name_bind };
-')
-
 # for perl
 dontaudit $1_t net_conf_t:file ioctl;
 

--Boundary-00=_AxwKBeJ6yC/Xqbt--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

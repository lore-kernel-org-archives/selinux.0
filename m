Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7JCvUrT026601
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2004 08:57:30 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7JCvOEE022999
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2004 12:57:27 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 7B9C761AF5
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2004 22:57:21 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 15753-04 for <selinux@tycho.nsa.gov>;
	Thu, 19 Aug 2004 22:57:20 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 996C561AF4
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2004 22:57:20 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 49C47B57DB
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2004 22:57:16 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: policy patches
Date: Thu, 19 Aug 2004 22:57:15 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rOKJB+EayykBNJC"
Message-Id: <200408192257.15688.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_rOKJB+EayykBNJC
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

diff1 makes the Makefile use M4PARAM for the file_contexts.

It makes a trivial change to fsadm_t access which satisfies some of the 
assertions I test with (no difference in production).

Removes devpts access from getty_t (it has no business doing such things, any 
time it tries to do so is a bug somewhere).

Makes a change to initrc_t needed for cryptsetup on Debian (unsure whether 
cryptsetup on Fedora will work the same way, it's quite likely - I think it's 
best if we copy the Debian cryptsetup stuff into Fedora).

Also it removes boot_t:lnk_file access from klogd_t, on Fedora the only 
boot_t:lnk_file is the GRUB menu.lst file (which klogd does not need access 
to), on Debian there are also some sym-links for LILO (which are in the same 
category).


diff makes some minor changes to the passwd policy to work with different 
editors for vipw and different versions of chfn.

Allows acct_t to execute logrotate.

Works with the latest version of amavis. 

Fixes the apmd policy to work with the device_type changes and some 
functionality that is commonly called from apm scripts.

Changes the capabilities in bluetooth.te to be in the same order as the header 
file.

Updates the calamaris policy to work with the latest version.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_rOKJB+EayykBNJC
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff1"

diff -ru /usr/src/se/policy/Makefile ./Makefile
--- /usr/src/se/policy/Makefile	2004-08-02 16:59:45.000000000 +1000
+++ ./Makefile	2004-08-19 21:22:13.000000000 +1000
@@ -140,7 +140,7 @@
 
 $(FC): $(FCFILES) $(ALL_TUNABLES) domains/program domains/misc file_contexts/program file_contexts/misc users /etc/passwd
 	@echo "Building file_contexts ..."
-	@m4 $(ALL_TUNABLES) $(FCFILES) > $@.tmp
+	@m4 $(M4PARAM) $(ALL_TUNABLES) $(FCFILES) > $@.tmp
 	@grep -v "^/root" $@.tmp > $@.root
 	@/usr/sbin/genhomedircon . $@.root  > $@
 	@grep "^/root" $@.tmp >> $@
diff -ru /usr/src/se/policy/domains/program/fsadm.te ./domains/program/fsadm.te
--- /usr/src/se/policy/domains/program/fsadm.te	2004-06-17 15:10:38.000000000 +1000
+++ ./domains/program/fsadm.te	2004-07-04 18:18:07.000000000 +1000
@@ -84,7 +84,8 @@
 
 # Access lost+found.
 allow fsadm_t lost_found_t:dir create_dir_perms;
-allow fsadm_t lost_found_t:notdevfile_class_set create_file_perms;
+allow fsadm_t lost_found_t:{ file sock_file fifo_file } create_file_perms;
+allow fsadm_t lost_found_t:lnk_file create_lnk_perms;
 
 allow fsadm_t file_t:dir { search read getattr rmdir create };
 
diff -ru /usr/src/se/policy/domains/program/getty.te ./domains/program/getty.te
--- /usr/src/se/policy/domains/program/getty.te	2004-08-04 20:26:43.000000000 +1000
+++ ./domains/program/getty.te	2004-08-15 15:53:57.000000000 +1000
@@ -52,8 +52,6 @@
 # Chown, chmod, read and write ttys.
 allow getty_t tty_device_t:chr_file { setattr rw_file_perms };
 allow getty_t ttyfile:chr_file { setattr rw_file_perms };
-allow getty_t initrc_devpts_t:chr_file { setattr rw_file_perms };
-dontaudit getty_t { user_devpts_t sysadm_devpts_t }:chr_file { read write };
 
 # for error condition handling
 allow getty_t fs_t:filesystem getattr;
diff -ru /usr/src/se/policy/domains/program/initrc.te ./domains/program/initrc.te
--- /usr/src/se/policy/domains/program/initrc.te	2004-08-02 16:59:47.000000000 +1000
+++ ./domains/program/initrc.te	2004-08-11 16:58:56.000000000 +1000
@@ -164,7 +164,10 @@
 allow initrc_t pidfile:file { getattr read unlink };
 
 # Write to /dev/urandom.
-allow initrc_t urandom_device_t:chr_file rw_file_perms;
+allow initrc_t { random_device_t urandom_device_t }:chr_file rw_file_perms;
+
+# for cryptsetup
+allow initrc_t fixed_disk_device_t:blk_file getattr;
 
 # Set device ownerships/modes.
 allow initrc_t framebuf_device_t:lnk_file read;
diff -ru /usr/src/se/policy/domains/program/klogd.te ./domains/program/klogd.te
--- /usr/src/se/policy/domains/program/klogd.te	2004-07-08 13:09:33.000000000 +1000
+++ ./domains/program/klogd.te	2004-06-17 03:07:45.000000000 +1000
@@ -43,5 +43,3 @@
 # Read /boot/System.map*
 allow klogd_t system_map_t:file r_file_perms;
 allow klogd_t boot_t:dir r_dir_perms;
-allow klogd_t boot_t:lnk_file { read };
-

--Boundary-00=_rOKJB+EayykBNJC
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru /usr/src/se/policy/domains/program/passwd.te ./domains/program/passwd.te
--- /usr/src/se/policy/domains/program/passwd.te	2004-06-17 15:10:38.000000000 +1000
+++ ./domains/program/passwd.te	2004-08-09 00:35:11.000000000 +1000
@@ -35,6 +35,9 @@
 
 allow $1_t etc_t:file create_file_perms;
 
+# read /etc/mtab
+allow $1_t etc_runtime_t:file { getattr read };
+
 # Allow etc_t symlinks for /etc/alternatives on Debian.
 allow $1_t etc_t:lnk_file read;
 
@@ -87,8 +90,8 @@
 dontaudit chfn_t shadow_t:file read;
 allow chfn_t etc_t:dir rw_dir_perms;
 allow chfn_t etc_t:file create_file_perms;
-allow chfn_t proc_t:file { read };
-allow chfn_t chfn_t:file { write };
+allow chfn_t proc_t:file { getattr read };
+allow chfn_t self:file { write };
 
 in_user_role(passwd_t)
 in_user_role(chfn_t)
@@ -118,9 +121,10 @@
 ')
 
 # allow vipw to exec the editor
-allow sysadm_passwd_t { root_t usr_t bin_t }:dir search;
+allow sysadm_passwd_t { root_t bin_t sbin_t }:dir search;
 allow sysadm_passwd_t { bin_t }:lnk_file read;
 can_exec(sysadm_passwd_t, { shell_exec_t bin_t })
+r_dir_file(sysadm_passwd_t, usr_t)
 
 # allow vipw to create temporary files under /var/tmp/vi.recover
 allow sysadm_passwd_t var_t:dir search;
@@ -133,6 +137,12 @@
 # for nscd lookups
 dontaudit sysadm_passwd_t var_run_t:dir search;
 
+# for /proc/meminfo
+allow sysadm_passwd_t proc_t:file { getattr read };
+
+dontaudit sysadm_passwd_t selinux_config_t:dir search;
+dontaudit sysadm_passwd_t devpts_t:dir search;
+
 # make sure that getcon succeeds
 allow passwd_t userdomain:dir search;
 allow passwd_t userdomain:file read;
diff -ru /usr/src/se/policy/domains/program/unused/acct.te ./domains/program/unused/acct.te
--- /usr/src/se/policy/domains/program/unused/acct.te	2004-06-17 15:10:39.000000000 +1000
+++ ./domains/program/unused/acct.te	2004-07-23 16:15:35.000000000 +1000
@@ -22,7 +22,7 @@
 allow acct_t urandom_device_t:chr_file read;
 
 ifdef(`logrotate.te', `
-allow acct_t logrotate_exec_t:file getattr;
+can_exec(acct_t, logrotate_exec_t)
 r_dir_file(logrotate_t, acct_data_t)
 ')
 
diff -ru /usr/src/se/policy/domains/program/unused/amavis.te ./domains/program/unused/amavis.te
--- /usr/src/se/policy/domains/program/unused/amavis.te	2004-08-04 20:26:43.000000000 +1000
+++ ./domains/program/unused/amavis.te	2004-08-16 20:24:12.000000000 +1000
@@ -20,8 +20,10 @@
 allow initrc_t amavisd_lib_t:file unlink;
 allow initrc_t amavisd_var_run_t:dir setattr;
 allow amavisd_t self:capability { chown dac_override setgid setuid };
+dontaudit amavisd_t self:capability sys_tty_config;
 
 allow amavisd_t usr_t:{ file lnk_file } { getattr read };
+dontaudit amavisd_t usr_t:file ioctl;
 
 # networking
 can_network(amavisd_t)
diff -ru /usr/src/se/policy/domains/program/unused/apmd.te ./domains/program/unused/apmd.te
--- /usr/src/se/policy/domains/program/unused/apmd.te	2004-08-02 16:59:47.000000000 +1000
+++ ./domains/program/unused/apmd.te	2004-08-03 15:08:13.000000000 +1000
@@ -72,12 +72,13 @@
 # setuid for fuser, dac* for ps
 dontaudit apmd_t self:capability { setuid dac_override dac_read_search };
 dontaudit apmd_t domain:{ socket_class_set } getattr;
-dontaudit apmd_t { file_type fs_type }:dir_file_class_set getattr;
+dontaudit apmd_t { file_type fs_type }:notdevfile_class_set getattr;
+dontaudit apmd_t device_type:devfile_class_set getattr;
 dontaudit apmd_t home_type:dir { search getattr };
 dontaudit apmd_t domain:key_socket getattr;
 dontaudit apmd_t domain:dir search;
 
-ifdef(`redhat', `
+ifdef(`redhat', `
 can_exec(apmd_t, apmd_var_run_t)
 # for /var/lock/subsys/network
 rw_dir_create_file(apmd_t, var_lock_t)
@@ -108,7 +109,16 @@
 
 # Same for apm/acpid scripts
 domain_auto_trans(apmd_t, initrc_exec_t, initrc_t)
+ifdef(`consoletype.te', `
+allow consoletype_t apmd_t:fd use;
+allow consoletype_t apmd_t:fifo_file write;
+')
+ifdef(`mount.te', `allow mount_t apmd_t:fd use;')
+ifdef(`crond.te', `domain_auto_trans(apmd_t, anacron_exec_t, system_crond_t)')
 
 ifdef(`mta.te', `
 domain_auto_trans(apmd_t, sendmail_exec_t, system_mail_t) 
 ')
+
+# for a find /dev operation that gets /dev/shm
+dontaudit apmd_t tmpfs_t:dir r_dir_perms;
diff -ru /usr/src/se/policy/domains/program/unused/backup.te ./domains/program/unused/backup.te
--- /usr/src/se/policy/domains/program/unused/backup.te	2004-07-13 09:07:59.000000000 +1000
+++ ./domains/program/unused/backup.te	2004-07-19 09:53:38.000000000 +1000
@@ -23,6 +23,9 @@
 rw_dir_create_file(system_crond_t, backup_store_t)
 ')
 
+# for SSP
+allow backup_t urandom_device_t:chr_file read;
+
 can_network(backup_t)
 uses_shlib(backup_t)
 
diff -ru /usr/src/se/policy/domains/program/unused/bluetooth.te ./domains/program/unused/bluetooth.te
--- /usr/src/se/policy/domains/program/unused/bluetooth.te	2004-05-30 16:26:57.000000000 +1000
+++ ./domains/program/unused/bluetooth.te	2004-07-05 00:03:10.000000000 +1000
@@ -15,7 +15,7 @@
 tmp_domain(bluetooth)
 
 # Use capabilities.
-allow bluetooth_t self:capability { net_raw sys_tty_config net_admin };
+allow bluetooth_t self:capability { net_admin net_raw sys_tty_config };
 
 rw_dir_create_file(bluetooth_t, var_lock_t)
 
diff -ru /usr/src/se/policy/domains/program/unused/calamaris.te ./domains/program/unused/calamaris.te
--- /usr/src/se/policy/domains/program/unused/calamaris.te	2004-03-27 00:46:44.000000000 +1100
+++ ./domains/program/unused/calamaris.te	2004-08-12 17:11:00.000000000 +1000
@@ -21,6 +21,8 @@
 allow calamaris_t var_log_squid_t:dir search;
 allow calamaris_t var_log_squid_t:file { getattr read };
 allow calamaris_t { usr_t lib_t }:file { getattr read };
+allow calamaris_t usr_t:lnk_file { getattr read };
+dontaudit calamaris_t usr_t:file ioctl;
 
 type calamaris_www_t, file_type, sysadmfile;
 ifdef(`apache.te', `
@@ -36,10 +38,13 @@
 allow calamaris_t device_t:dir search;
 allow calamaris_t devtty_t:chr_file { read write };
 
+allow calamaris_t urandom_device_t:chr_file { getattr read };
+
 allow calamaris_t self:process { fork signal_perms setsched };
 allow calamaris_t { proc_t sysctl_kernel_t }:dir search;
 allow calamaris_t { proc_t sysctl_kernel_t }:file { getattr read };
 allow calamaris_t { proc_t self }:lnk_file read;
+allow calamaris_t self:dir search;
 
 allow calamaris_t { bin_t sbin_t }:dir search;
 allow calamaris_t bin_t:lnk_file read;

--Boundary-00=_rOKJB+EayykBNJC--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

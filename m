Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA06911
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 10:10:27 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA16018
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 15:08:11 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id PAA16014
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 15:08:09 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 4CB3192668
	for <selinux@tycho.nsa.gov>; Wed,  4 Dec 2002 02:10:18 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id BCB2F66B
	for <selinux@tycho.nsa.gov>; Tue,  3 Dec 2002 16:10:12 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: new policy
Date: Tue, 3 Dec 2002 16:10:12 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_05UJMGMCQVXGKIN7TJ7I"
Message-Id: <200212031610.12318.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_05UJMGMCQVXGKIN7TJ7I
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

diff -ruN /tmp/policy/domains/program/hwclock.te ./domains/program/hwclock.te
--- /tmp/policy/domains/program/hwclock.te      2002-12-03 15:56:40.000000000 
+0
100
+++ ./domains/program/hwclock.te        2002-08-21 20:22:44.000000000 +0200
@@ -45,3 +45,5 @@
 allow hwclock_t ptyfile:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow hwclock_t sysadm_gph_t:fd use;')

+# hwclock needs to search file_t directories when run from rc.sysinit on RH8
+allow hwclock_t file_t:dir search;

For the above change that's recently committed, shouldn't it have 
ifdef(`rpm.te', around it?

I've attached another patch with the following features:

Don't audit an ioctl that the latest Perl does when the boot loader scripts 
read the modules dependency file.

Added a can_exec rule for the ftpd cron jobs.

Allow ipsec_mgmt_t to read it's own symlinks in /proc.

Added support for the new setup of modutils in Debian that apparently provides 
transperant support for 2.4.x and 2.5.x kernels.  I don't know if the 2.5.x 
functionality works properly, but this is required for 2.4.x to work 
properly.  RH probably doesn't need this yet, but they'll probably do the 
same thing when they support 2.6.x kernels.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_05UJMGMCQVXGKIN7TJ7I
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff"

diff -ru /tmp/policy/domains/program/bootloader.te ./domains/program/bootloader.te
--- /tmp/policy/domains/program/bootloader.te	2002-11-29 12:19:34.000000000 +0100
+++ ./domains/program/bootloader.te	2002-11-29 12:53:45.000000000 +0100
@@ -42,6 +42,7 @@
 allow bootloader_t { bin_t sbin_t }:lnk_file read;
 
 allow bootloader_t { modules_dep_t modules_object_t }:file read;
+dontaudit bootloader_t modules_dep_t:file ioctl;
 allow bootloader_t modules_object_t:dir { read search };
 allow bootloader_t modules_conf_t:file read;
 
diff -ru /tmp/policy/domains/program/ftpd.te ./domains/program/ftpd.te
--- /tmp/policy/domains/program/ftpd.te	2002-11-04 13:27:51.000000000 +0100
+++ ./domains/program/ftpd.te	2002-12-01 05:51:41.000000000 +0100
@@ -18,7 +18,10 @@
 ifdef(`inetd.te', `domain_auto_trans(inetd_t, ftpd_exec_t, ftpd_t)')
 ifdef(`tcpd.te', `domain_auto_trans(tcpd_t, ftpd_exec_t, ftpd_t)')
 
-ifdef(`crond.te', `system_crond_entry(ftpd_exec_t, ftpd_t)')
+ifdef(`crond.te', `
+system_crond_entry(ftpd_exec_t, ftpd_t)
+can_exec(ftpd_t, { bin_t sbin_t })
+')
 
 # Inherit and use descriptors from inetd.
 allow ftpd_t inetd_t:fd use;
diff -ru /tmp/policy/domains/program/ipsec.te ./domains/program/ipsec.te
--- /tmp/policy/domains/program/ipsec.te	2002-12-03 15:56:40.000000000 +0100
+++ ./domains/program/ipsec.te	2002-12-01 05:52:08.000000000 +0100
@@ -207,3 +207,4 @@
 
 allow ipsec_mgmt_t { initrc_devpts_t admin_tty_type }:chr_file { getattr read write ioctl };
 allow ipsec_t initrc_devpts_t:chr_file { getattr read write };
+allow ipsec_mgmt_t self:lnk_file read;
diff -ru /tmp/policy/domains/program/modutil.te ./domains/program/modutil.te
--- /tmp/policy/domains/program/modutil.te	2002-11-04 13:27:51.000000000 +0100
+++ ./domains/program/modutil.te	2002-12-03 11:53:14.000000000 +0100
@@ -21,6 +21,7 @@
 every_domain(depmod_t)
 type depmod_exec_t, file_type, exec_type, sysadmfile;
 domain_auto_trans(initrc_t, depmod_exec_t, depmod_t)
+can_exec(depmod_t, depmod_exec_t)
 type_transition init_t depmod_exec_t:process depmod_t;
 domain_auto_trans(sysadm_t, depmod_exec_t, depmod_t)
 
@@ -54,7 +55,10 @@
 allow insmod_t var_log_ksyms_t:dir create_dir_perms;
 
 ifdef(`crond.te', `
+# for old modutils
 rw_dir_create_file(system_crond_t, var_log_ksyms_t)
+# for new modutils that is 2.5 compatable
+can_exec(insmod_t, bin_t)
 ')
 
 #################################
@@ -67,6 +71,7 @@
 every_domain(insmod_t)
 type insmod_exec_t, file_type, exec_type, sysadmfile;
 domain_auto_trans({ initrc_t kernel_t }, insmod_exec_t, insmod_t)
+can_exec(insmod_t, insmod_exec_t)
 type_transition init_t insmod_exec_t:process insmod_t;
 allow insmod_t init_t:fd use;
 domain_auto_trans(sysadm_t, insmod_exec_t, insmod_t)
diff -ru /tmp/policy/file_contexts/program/modutil.fc ./file_contexts/program/modutil.fc
--- /tmp/policy/file_contexts/program/modutil.fc	2002-07-12 17:19:44.000000000 +0200
+++ ./file_contexts/program/modutil.fc	2002-12-02 14:35:06.000000000 +0100
@@ -2,9 +2,9 @@
 /etc/modules.conf(.old)?	system_u:object_r:modules_conf_t
 /lib/modules(/.*)?		system_u:object_r:modules_object_t
 /lib/modules/[^/]*/modules\..* system_u:object_r:modules_dep_t
-/sbin/depmod			system_u:object_r:depmod_exec_t
-#/sbin/modprobe			system_u:object_r:insmod_exec_t
-/sbin/insmod			system_u:object_r:insmod_exec_t
+/sbin/depmod.*			system_u:object_r:depmod_exec_t
+/sbin/modprobe.*		system_u:object_r:insmod_exec_t
+/sbin/insmod.*			system_u:object_r:insmod_exec_t
 /sbin/insmod.static		system_u:object_r:insmod_exec_t
-#/sbin/rmmod			system_u:object_r:insmod_exec_t
+/sbin/rmmod.*			system_u:object_r:insmod_exec_t
 /sbin/update-modules		system_u:object_r:update_modules_exec_t

--------------Boundary-00=_05UJMGMCQVXGKIN7TJ7I--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

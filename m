Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9ICncrT020474
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 08:49:38 -0400 (EDT)
Received: from kokytos.rz.informatik.uni-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9ICmNG3025126
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 12:48:24 GMT
Received: from hydrogenium.cip.ifi.lmu.de (hydrogenium.cip.ifi.lmu.de [141.84.214.74])
	by kokytos.rz.informatik.uni-muenchen.de (Postfix) with ESMTP id 9025F43638
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 14:43:32 +0200 (CEST)
Date: Mon, 18 Oct 2004 14:43:32 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
Message-ID: <20041018124332.GA5193@hydrogenium.cip.ifi.lmu.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

cdrecord deadlocks linux 2.6.8.1:

I have just written selinux policy for cdrecord. While writing this 
policy cdrecord constantly locked up the computer (even in permissive
mode). When booting with selinux=0 the problem went away.

After digging around for a while, the following seems to be happening:
* cdrecord calls sched_setscheduler()
* setscheduler (in kernel/sched.c) asks for CAP_SYS_NICE
* cdrecord doesn't have this capability
* selinux generates an audit message ==> deadlock

When I grant cdrecord CAP_SYS_NICE everything works fine.
I think SELinux shouldn't generate a log message in this case; like it
is already suppressed for setsched.

To test, add the attached policy, remove sys_nice from the allowed caps
and simply call cdrecord without parameters.

Thomas

-- 
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="cdrecord.patch"

diff -urN orig/domains/program/unused/cdrecord.te mod/domains/program/unused/cdrecord.te
--- orig/domains/program/unused/cdrecord.te	1970-01-01 01:00:00.000000000 +0100
+++ mod/domains/program/unused/cdrecord.te	2004-10-18 14:32:37.237650320 +0200
@@ -0,0 +1,9 @@
+# DESC cdrecord - record audio or data Compact Disks or Digital Versatile Disks from a master
+#
+# Author: Thomas Bleher <ThomasBleher@gmx.de>
+
+# Type for the cdrecord excutable.
+type cdrecord_exec_t, file_type, sysadmfile, exec_type;
+
+# everything else is in the cdrecord_domain macros in
+# macros/program/cdrecord_macros.te.
diff -urN orig/file_contexts/program/cdrecord.fc mod/file_contexts/program/cdrecord.fc
--- orig/file_contexts/program/cdrecord.fc	1970-01-01 01:00:00.000000000 +0100
+++ mod/file_contexts/program/cdrecord.fc	2004-10-18 14:32:49.467791056 +0200
@@ -0,0 +1,2 @@
+# cdrecord
+/usr/bin/cdrecord	--	system_u:object_r:cdrecord_exec_t
diff -urN orig/macros/base_user_macros.te mod/macros/base_user_macros.te
--- orig/macros/base_user_macros.te	2004-10-14 12:42:18.000000000 +0200
+++ mod/macros/base_user_macros.te	2004-10-18 14:33:47.317996488 +0200
@@ -167,6 +167,7 @@
 ifdef(`irc.te', `irc_domain($1)')
 ifdef(`using_spamassassin', `spamassassin_domain($1)')
 ifdef(`uml.te', `uml_domain($1)')
+ifdef(`cdrecord.te', `cdrecord_domain($1)')
 
 # Instantiate a derived domain for user cron jobs.
 ifdef(`crond.te', `crond_domain($1)')
diff -urN orig/macros/program/cdrecord_macros.te mod/macros/program/cdrecord_macros.te
--- orig/macros/program/cdrecord_macros.te	1970-01-01 01:00:00.000000000 +0100
+++ mod/macros/program/cdrecord_macros.te	2004-10-18 14:33:00.562104464 +0200
@@ -0,0 +1,42 @@
+# macros for the cdrecord domain
+# Author: Thomas Bleher <ThomasBleher@gmx.de>
+
+define(`cdrecord_domain', `
+type $1_cdrecord_t, domain;
+
+domain_auto_trans($1_t, cdrecord_exec_t, $1_cdrecord_t)
+
+# The user role is authorized for this domain.
+role $1_r types $1_cdrecord_t;
+
+uses_shlib($1_cdrecord_t)
+
+# allow ps to show cdrecord and allow the user to kill it 
+can_ps($1_t, $1_cdrecord_t)
+allow $1_t $1_cdrecord_t:process signal;
+
+# write to the user domain tty.
+allow $1_cdrecord_t $1_tty_device_t:chr_file rw_file_perms;
+allow $1_cdrecord_t $1_devpts_t:chr_file rw_file_perms;
+allow $1_cdrecord_t privfd:fd use;
+
+allow $1_cdrecord_t home_root_t:dir { search };
+
+# allow cdrecord to read user files
+r_dir_file($1_cdrecord_t, { $1_home_t $1_tmp_t })
+ifdef(`nfs_home_dirs', `
+r_dir_file($1_cdrecord_t, nfs_t)
+')dnl end if nfs_home_dirs
+
+# allow searching for cdrom-drive
+allow $1_cdrecord_t device_t:dir { getattr search };
+allow $1_cdrecord_t device_t:lnk_file { getattr read };
+
+# allow cdrecord to write the CD
+allow $1_cdrecord_t removable_device_t:blk_file { getattr ioctl read };
+allow $1_cdrecord_t scsi_generic_device_t:chr_file { getattr read write ioctl };
+
+allow $1_cdrecord_t self:capability { ipc_lock sys_nice setuid };
+allow $1_cdrecord_t self:process { getsched setsched };
+
+')

--gBBFr7Ir9EOA20Yy--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

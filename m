Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1JCTw97002159
	for <selinux@tycho.nsa.gov>; Tue, 19 Feb 2008 07:29:59 -0500
Received: from vidle.i.cz (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1JCTpSg001689
	for <selinux@tycho.nsa.gov>; Tue, 19 Feb 2008 12:29:57 GMT
Date: Tue, 19 Feb 2008 13:29:51 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
Subject: refpolicy: patch for Debian backup cron daily jobs
Message-ID: <20080219122951.GA23700@bobek.pm.i.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MW5yreqqjyrRcusr"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
this patch solves following denials on Debian:

audit(1203020199.510:16): avc:  denied  { execute } for  pid=1841 comm="aptitude" name="bash" dev=sda1 ino=81922 scontext=system_u:system_r:backup_t:s0 tcontext=system_u:object_r:shell_exec_t:s0 tclass=file
audit(1203020199.526:17): avc:  denied  { remove_name } for  pid=1847 comm="rm" name="aptitude.pkgstates.6.gz" dev=sda1 ino=213244 scontext=system_u:system_r:backup_t:s0 tcontext=system_u:object_r:backup_store_t:s0 tclass=dir
audit(1203020199.526:18): avc:  denied  { unlink } for  pid=1847 comm="rm" name="aptitude.pkgstates.6.gz" dev=sda1 ino=213244 scontext=system_u:system_r:backup_t:s0 tcontext=system_u:object_r:backup_store_t:s0 tclass=file
audit(1203020199.538:19): avc:  denied  { rename } for  pid=1848 comm="mv" name="aptitude.pkgstates.5.gz" dev=sda1 ino=213147 scontext=system_u:system_r:backup_t:s0 tcontext=system_u:object_r:backup_store_t:s0 tclass=file
audit(1203020212.719:22): avc:  denied  { fsetid } for  pid=1932 comm="cp" capability=4 scontext=system_u:system_r:backup_t:s0 tcontext=system_u:system_r:backup_t:s0 tclass=capability
audit(1203020212.759:23): avc:  denied  { execute } for  pid=1940 comm="standard" name="bash" dev=sda1 ino=81922 scontext=system_u:system_r:backup_t:s0 tcontext=system_u:object_r:shell_exec_t:s0 tclass=file

Aptitude backup script /etc/cron.daily/aptitude saves the aptitude state
into /var/backup. Cron backup script /etc/cron.daily/standard saves
shadow files and the dpkg status into /var/backup.

The utility savelog from debianutils is used for rotating state
information of aptitude and dpkg (unfortunately). Savelog context
(logrotate_exec_t) should be removed (no specialisation for log files
only). Log rotation cron jobs /etc/cron.{daily,weekly}/sysklogd has
logrotate_exec_t already and some init scipts that uses savelog for
rotating logs during the boot has persmissions already too. So this is
ok alone hope.

Attached patch adds context for /etc/cron.daily/{aptitude,standard}
backup_exec_t. Permission to execute shell and manage files under
/var/backup is granted further.

Hope, this can be included.
Thanks
-- 
Zito

--MW5yreqqjyrRcusr
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="backup.deb.patch"

Index: policy/modules/admin/backup.fc
===================================================================
--- policy/modules/admin/backup.fc	(revision 2610)
+++ policy/modules/admin/backup.fc	(working copy)
@@ -4,4 +4,6 @@
 # backup_store_t, Debian uses /var/backups
 
 #/usr/local/bin/backup-script	--	gen_context(system_u:object_r:backup_exec_t,s0)
+/etc/cron.daily/aptitude	--	gen_context(system_u:object_r:backup_exec_t,s0)
+/etc/cron.daily/standard	--	gen_context(system_u:object_r:backup_exec_t,s0)
 /var/backups(/.*)?			gen_context(system_u:object_r:backup_store_t,s0)
Index: policy/modules/admin/logrotate.fc
===================================================================
--- policy/modules/admin/logrotate.fc	(revision 2610)
+++ policy/modules/admin/logrotate.fc	(working copy)
@@ -3,7 +3,6 @@
 /usr/sbin/logrotate	--	gen_context(system_u:object_r:logrotate_exec_t,s0)
 
 ifdef(`distro_debian', `
-/usr/bin/savelog	--	gen_context(system_u:object_r:logrotate_exec_t,s0)
 /var/lib/logrotate(/.*)?	gen_context(system_u:object_r:logrotate_var_lib_t,s0)
 ', `
 /var/lib/logrotate\.status --	gen_context(system_u:object_r:logrotate_var_lib_t,s0)
Index: policy/modules/admin/backup.te
===================================================================
--- policy/modules/admin/backup.te	(revision 2610)
+++ policy/modules/admin/backup.te	(working copy)
@@ -27,7 +27,7 @@
 allow backup_t self:udp_socket create_socket_perms;
 
 allow backup_t backup_store_t:file setattr;
-create_files_pattern(backup_t,backup_store_t,backup_store_t)
+manage_files_pattern(backup_t,backup_store_t,backup_store_t)
 rw_files_pattern(backup_t,backup_store_t,backup_store_t)
 read_lnk_files_pattern(backup_t,backup_store_t,backup_store_t)
 
@@ -35,6 +35,7 @@
 kernel_read_kernel_sysctls(backup_t)
 
 corecmd_exec_bin(backup_t)
+corecmd_exec_shell(backup_t)
 
 corenet_all_recvfrom_unlabeled(backup_t)
 corenet_all_recvfrom_netlabel(backup_t)

--MW5yreqqjyrRcusr--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

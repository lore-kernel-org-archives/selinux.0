Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8NDWprT008957
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 09:32:51 -0400 (EDT)
Message-ID: <4152D07C.9060507@redhat.com>
Date: Thu, 23 Sep 2004 09:32:44 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Remove unrestricted_admin
References: <200409211526.37810.russell@coker.com.au> <1095884528.11254.6.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1095884528.11254.6.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------010901080709080001060509"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010901080709080001060509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Remove unrestricted_admin tunable.  This was a bad idea :^(

Add modutil for targteted to get relabel to work better.


--------------010901080709080001060509
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/admin.te policy-1.17.20/domains/admin.te
--- nsapolicy/domains/admin.te	2004-09-09 15:36:12.000000000 -0400
+++ policy-1.17.20/domains/admin.te	2004-09-23 09:29:42.799096131 -0400
@@ -4,7 +4,6 @@
 
 # sysadm_t is the system administrator domain.
 type sysadm_t, domain, privlog, privowner, admin, userdomain, web_client_domain, privhome, etc_writer, privmodule, nscd_client_domain
-ifdef(`unrestricted_admin', `, fs_domain, privmem, sysctl_kernel_writer, auth, auth_write, unrestricted')
 ifdef(`direct_sysadm_daemon', `, priv_system_role')
 ; dnl end of sysadm_t type declaration
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/fsadm.te policy-1.17.20/domains/program/fsadm.te
--- nsapolicy/domains/program/fsadm.te	2004-09-10 10:17:48.000000000 -0400
+++ policy-1.17.20/domains/program/fsadm.te	2004-09-23 09:29:14.470353752 -0400
@@ -49,12 +49,7 @@
 
 type fsadm_exec_t, file_type, sysadmfile, exec_type;
 domain_auto_trans(initrc_t, fsadm_exec_t, fsadm_t)
-ifdef(`unrestricted_admin', `
-allow sysadm_t fixed_disk_device_t:devfile_class_set rw_file_perms;
-allow sysadm_t removable_device_t:devfile_class_set rw_file_perms;
-', `
 domain_auto_trans(sysadm_t, fsadm_exec_t, fsadm_t)
-')
 
 tmp_domain(fsadm)
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/admin_macros.te policy-1.17.20/macros/admin_macros.te
--- nsapolicy/macros/admin_macros.te	2004-09-21 12:51:06.000000000 -0400
+++ policy-1.17.20/macros/admin_macros.te	2004-09-23 09:28:52.371898273 -0400
@@ -106,14 +106,10 @@
 # allow setting up tunnels
 allow $1_t tun_tap_device_t:chr_file rw_file_perms;
 
-ifdef(`unrestricted_admin', `
-unconfined_domain($1_t) 
-', `
 # run ls -l /dev
 allow $1_t device_t:dir r_dir_perms;
 allow $1_t { device_t device_type }:{ chr_file blk_file } getattr;
 allow $1_t ptyfile:chr_file getattr;
-')
 
 # Run programs from staff home directories.
 # Not ideal, but typical if users want to login as both sysadm_t or staff_t.
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/program/modutil.te policy-1.17.20/targeted/domains/program/modutil.te
--- nsapolicy/targeted/domains/program/modutil.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.20/targeted/domains/program/modutil.te	2004-09-23 09:26:44.919632619 -0400
@@ -0,0 +1,17 @@
+#DESC Modutil - Dynamic module utilities
+#
+# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
+# X-Debian-Packages: modutils
+#
+
+#################################
+#
+# Rules for the module utility domains.
+#
+type modules_dep_t, file_type, sysadmfile;
+type modules_conf_t, file_type, sysadmfile;
+type modules_object_t, file_type, sysadmfile;
+type depmod_exec_t, file_type, exec_type, sysadmfile;
+type insmod_exec_t, file_type, exec_type, sysadmfile;
+type update_modules_exec_t, file_type, exec_type, sysadmfile;
+
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.17.20/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-09-09 15:36:11.000000000 -0400
+++ policy-1.17.20/tunables/distro.tun	2004-09-23 09:26:44.920632503 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.17.20/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-09-23 09:26:36.631594339 -0400
+++ policy-1.17.20/tunables/tunable.tun	2004-09-23 09:27:08.175936391 -0400
@@ -1,51 +1,48 @@
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
-
-# Allow sysadm_t to do almost everything
-dnl define(`unrestricted_admin')
+define(`hide_broken_symptoms')
 
 # Allow the read/write/create on any NFS file system
-dnl define(`nfs_export_all_rw')
+define(`nfs_export_all_rw')
 
 # Allow the reading on any NFS file system
 dnl define(`nfs_export_all_ro')
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
-dnl define(`user_canbe_sysadm')
+define(`user_canbe_sysadm')
 
 # Allow xinetd to run unconfined, including any services it starts
 # that do not have a domain transition explicitly defined.

--------------010901080709080001060509--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

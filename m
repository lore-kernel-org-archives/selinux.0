Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6CE81rT002244
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 10:08:01 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6CE7ZDC008653
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 14:07:36 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 9B46061C9E
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2004 00:07:54 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 07600-01 for <selinux@tycho.nsa.gov>;
	Tue, 13 Jul 2004 00:07:53 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 8B9EA61C9D
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2004 00:07:53 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 28287B59A3
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2004 00:07:51 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: macros patch
Date: Tue, 13 Jul 2004 00:07:50 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2sp8AvnQROGJX37"
Message-Id: <200407130007.50642.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_2sp8AvnQROGJX37
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch adds a new create_lnk_perms macro and makes some changes to 
other macros to use it.

It makes sysadm_t not have access to create policy_src_t:{ sock_file 
fifo_file }.

It doesn't alow userdomain to have misc_device_t:notdevfile rw_file_perms 
access.

For chroot macros the domains for a chroot are not supposed to have NIS access 
(they are separate from the main processes), and they are not user domains.

I think that allowing user_games_t any form of write access to user_tmp_t 
(including setattr on a directory) is a bad idea.

print_spool_t should only apply to file, not sock_file, fifo_file, or 
lnk_file.

Referencing staff_home_dir_t in the screen policy is a mistake.  Generally any 
occurance of staff_home_dir_t or similar is a mistake.

I removed a couple of occurrences of can_exec_any().

user_t should not have privfd.  privfd is only for domains such as 
local_login_t and sshd_t.


Steve, I believe that this is worthy of CVS inclusion.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_2sp8AvnQROGJX37
Content-Type: text/x-diff;
  charset="us-ascii";
  name="macros.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="macros.diff"

diff -ru /usr/src/se/policy/macros/admin_macros.te ./macros/admin_macros.te
--- /usr/src/se/policy/macros/admin_macros.te	2004-07-11 17:37:13.000000000 +1000
+++ ./macros/admin_macros.te	2004-07-11 19:40:16.000000000 +1000
@@ -125,7 +124,8 @@
 # policy management infrastructure is in place so that an administrator
 # cannot directly manipulate policy files with arbitrary programs.
 #
-allow $1_t policy_src_t:notdevfile_class_set create_file_perms;
+allow $1_t policy_src_t:file create_file_perms;
+allow $1_t policy_src_t:lnk_file create_lnk_perms;
 allow $1_t policy_src_t:dir create_dir_perms;
 
 # Relabel all files.
@@ -133,7 +133,7 @@
 # sysadmfile to file_type (and change the assertion in assert.te that
 # only auth_write can relabel shadow_t)
 allow $1_t sysadmfile:dir { getattr read search relabelfrom relabelto };
-allow $1_t sysadmfile:file_class_set { getattr relabelfrom relabelto };
+allow $1_t sysadmfile:notdevfile_class_set { getattr relabelfrom relabelto };
 
 ifdef(`startx.te', `
 ifdef(`xserver.te', `
diff -ru /usr/src/se/policy/macros/base_user_macros.te ./macros/base_user_macros.te
--- /usr/src/se/policy/macros/base_user_macros.te	2004-07-11 17:37:13.000000000 +1000
+++ ./macros/base_user_macros.te	2004-07-05 23:19:47.000000000 +1000
@@ -172,7 +174,7 @@
 allow $1_t mouse_device_t:chr_file r_file_perms;
 ')
 # Access other miscellaneous devices.
-allow $1_t misc_device_t:file_class_set rw_file_perms;
+allow $1_t misc_device_t:{ chr_file blk_file } rw_file_perms;
 allow $1_t device_t:lnk_file { getattr read };
 
 #
diff -ru /usr/src/se/policy/macros/core_macros.te ./macros/core_macros.te
--- /usr/src/se/policy/macros/core_macros.te	2004-06-23 15:55:52.000000000 +1000
+++ ./macros/core_macros.te	2004-07-09 11:16:50.000000000 +1000
@@ -94,6 +94,11 @@
 define(`link_file_perms', `{ getattr link unlink rename }')
 
 #
+# Permissions for creating lnk_files.
+#
+define(`create_lnk_perms', `{ create read getattr setattr link unlink rename }')
+
+#
 # Permissions for creating and using files.
 # 
 define(`create_file_perms', `{ create ioctl read getattr lock write setattr append link unlink rename }')
@@ -195,37 +200,44 @@
 # 
 define(`r_dir_file', `
 allow $1 $2:dir r_dir_perms;
-allow $1 $2:{ file lnk_file } r_file_perms;
+allow $1 $2:file r_file_perms;
+allow $1 $2:lnk_file { getattr read };
 ')
 
 define(`rw_dir_file', `
 allow $1 $2:dir rw_dir_perms;
-allow $1 $2:{ file lnk_file } rw_file_perms;
+allow $1 $2:file rw_file_perms;
+allow $1 $2:lnk_file { getattr read };
 ')
 
 define(`ra_dir_file', `
 allow $1 $2:dir ra_dir_perms;
-allow $1 $2:{ file lnk_file } ra_file_perms;
+allow $1 $2:file ra_file_perms;
+allow $1 $2:lnk_file { getattr read };
 ')
 
 define(`ra_dir_create_file', `
 allow $1 $2:dir ra_dir_perms;
-allow $1 $2:{ file lnk_file } { create ra_file_perms };
+allow $1 $2:file { create ra_file_perms };
+allow $1 $2:lnk_file { create read getattr };
 ')
 
 define(`rw_dir_create_file', `
 allow $1 $2:dir rw_dir_perms;
-allow $1 $2:{ file lnk_file } create_file_perms;
+allow $1 $2:file create_file_perms;
+allow $1 $2:lnk_file create_lnk_perms;
 ')
 
 define(`create_dir_file', `
 allow $1 $2:dir create_dir_perms;
-allow $1 $2:{ file lnk_file } create_file_perms;
+allow $1 $2:file create_file_perms;
+allow $1 $2:lnk_file create_lnk_perms;
 ')
 
 define(`create_dir_notdevfile', `
 allow $1 $2:dir create_dir_perms;
-allow $1 $2:notdevfile_class_set create_file_perms;
+allow $1 $2:{ file sock_file fifo_file } create_file_perms;
+allow $1 $2:lnk_file create_lnk_perms;
 ')
 
 define(`create_append_log_file', `
@@ -441,13 +453,18 @@
 # Allow the process to create the file.
 #
 ifelse(`$4', `', `
-allow $1 $3:notdevfile_class_set create_file_perms;
+allow $1 $3:{ file sock_file fifo_file } create_file_perms;
+allow $1 $3:lnk_file create_lnk_perms;
 allow $1 $3:dir create_dir_perms;
 ', `
 ifelse(`$4', `dir', `
 allow $1 $3:$4 create_dir_perms;
 ', `
+ifelse(`$4', `lnk_file', `
+allow $1 $3:$4 create_lnk_perms;
+', `
 allow $1 $3:$4 create_file_perms;
+')dnl end ifelse lnk_file
 ')dnl end if dir
 ')dnl end if param 4 specified
 
diff -ru /usr/src/se/policy/macros/program/chroot_macros.te ./macros/program/chroot_macros.te
--- /usr/src/se/policy/macros/program/chroot_macros.te	2004-03-18 15:36:09.000000000 +1100
+++ ./macros/program/chroot_macros.te	2004-07-05 23:22:58.000000000 +1000
@@ -39,10 +39,10 @@
 # entry point for $2_super_t
 type $2_super_entry_t, file_type, sysadmfile, home_type, user_home_type;
 # $2_t is the base domain, has full access to $2_rw_t files
-type $2_t, domain, userdomain, unpriv_userdomain;
+type $2_t, domain;
 # $2_super_t is the super-chroot domain, can also write to $2_ro_t
 # but still can not access outside the chroot
-type $2_super_t, domain, userdomain, unpriv_userdomain;
+type $2_super_t, domain;
 allow $2_super_t chroot_tty_device:chr_file rw_file_perms;
 
 ifdef(`$1_chroot_def', `', `
@@ -119,7 +119,6 @@
 can_create_pty($2)
 can_create_pty($2_super)
 can_network({ $2_t $2_super_t })
-can_ypbind({ $2_t $2_super_t })
 allow { $2_t $2_super_t } null_device_t:chr_file rw_file_perms;
 allow $2_super_t { $2_rw_t $2_ro_t }:{ dir file } mounton;
 allow { $2_t $2_super_t } self:capability { dac_override kill };
diff -ru /usr/src/se/policy/macros/program/games_domain.te ./macros/program/games_domain.te
--- /usr/src/se/policy/macros/program/games_domain.te	2004-06-17 15:10:45.000000000 +1000
+++ ./macros/program/games_domain.te	2004-07-08 22:01:31.000000000 +1000
@@ -24,7 +24,6 @@
 create_dir_file($1_games_t, $1_home_t)
 
 create_dir_file($1_games_t, $1_tmp_t)
-allow $1_games_t $1_tmp_t:dir { setattr };
 allow $1_games_t $1_tmp_t:sock_file create_file_perms;
 
 dontaudit $1_games_t sysctl_t:dir search;
diff -ru /usr/src/se/policy/macros/program/lpr_macros.te ./macros/program/lpr_macros.te
--- /usr/src/se/policy/macros/program/lpr_macros.te	2004-06-17 15:10:45.000000000 +1000
+++ ./macros/program/lpr_macros.te	2004-07-05 23:25:01.000000000 +1000
@@ -81,7 +81,7 @@
 allow $1_lpr_t $1_home_t:{ file lnk_file } r_file_perms;  
 
 # Read and write shared files in the spool directory.
-allow $1_lpr_t print_spool_t:notdevfile_class_set rw_file_perms;
+allow $1_lpr_t print_spool_t:file rw_file_perms;
 
 # lpr can run in lightweight mode, without a local print spooler. If the
 # lpd policy is present, grant some permissions for this domain and the lpd
diff -ru /usr/src/se/policy/macros/program/mozilla_macros.te ./macros/program/mozilla_macros.te
--- /usr/src/se/policy/macros/program/mozilla_macros.te	2004-06-30 13:03:21.000000000 +1000
+++ ./macros/program/mozilla_macros.te	2004-07-05 18:40:47.000000000 +1000
@@ -56,7 +56,7 @@
 dontaudit $1_mozilla_t proc_t:dir read;
 
 allow $1_mozilla_t { var_t var_lib_t }:dir search;
-dontaudit $1_mozilla_t var_run_t:dir search;
+dontaudit $1_mozilla_t var_run_t:dir { getattr search };
 
 # Execute downloaded programs.
 can_exec($1_mozilla_t, $1_mozilla_rw_t)
diff -ru /usr/src/se/policy/macros/program/screen_macros.te ./macros/program/screen_macros.te
--- /usr/src/se/policy/macros/program/screen_macros.te	2004-06-30 13:03:21.000000000 +1000
+++ ./macros/program/screen_macros.te	2004-07-11 19:29:00.000000000 +1000
@@ -77,7 +77,6 @@
 allow $1_screen_t self:capability { setuid setgid fsetid };
 
 dontaudit $1_screen_t shadow_t:file { read };
-allow $1_screen_t staff_home_dir_t:dir { search };
 
 allow $1_screen_t tmp_t:dir { search };
 can_network($1_screen_t)
diff -ru /usr/src/se/policy/macros/program/ssh_macros.te ./macros/program/ssh_macros.te
--- /usr/src/se/policy/macros/program/ssh_macros.te	2004-06-17 15:10:45.000000000 +1000
+++ ./macros/program/ssh_macros.te	2004-07-08 13:58:20.000000000 +1000
@@ -100,9 +100,6 @@
 # Use capabilities.
 allow $1_ssh_t self:capability { setuid setgid dac_override dac_read_search };
 
-# Run helpers.
-can_exec_any($1_ssh_t)
-
 # Read the ssh key file.
 allow $1_ssh_t sshd_key_t:file r_file_perms;
 
diff -ru /usr/src/se/policy/macros/program/su_macros.te ./macros/program/su_macros.te
--- /usr/src/se/policy/macros/program/su_macros.te	2004-06-17 15:10:45.000000000 +1000
+++ ./macros/program/su_macros.te	2004-07-05 23:49:09.000000000 +1000
@@ -126,7 +121,6 @@
 allow $1_su_t { sysadm_tty_device_t sysadm_devpts_t }:chr_file { getattr ioctl };
 
 allow $1_su_t { home_root_t $1_home_dir_t }:dir search;
-create_dir_file($1_su_t, $1_home_dir_t)
 allow $1_su_t $1_home_t:file create_file_perms;
 ifdef(`user_canbe_sysadm', `
 allow $1_su_t home_dir_type:dir { search write };
diff -ru /usr/src/se/policy/macros/program/uml_macros.te ./macros/program/uml_macros.te
--- /usr/src/se/policy/macros/program/uml_macros.te	2004-06-17 15:10:45.000000000 +1000
+++ ./macros/program/uml_macros.te	2004-07-11 19:15:05.000000000 +1000
@@ -47,7 +47,9 @@
 ')dnl end ifelse sysadm
 ')dnl end ifdef startx
 
-allow $1_t { $1_uml_ro_t $1_uml_rw_t $1_uml_exec_t }:file_class_set { relabelfrom relabelto create_file_perms };
+allow $1_t { $1_uml_ro_t $1_uml_rw_t }:{ file sock_file fifo_file } { relabelfrom relabelto create_file_perms };
+allow $1_t $1_uml_exec_t:file { relabelfrom relabelto create_file_perms };
+allow $1_t { $1_uml_ro_t $1_uml_rw_t }:lnk_file { relabelfrom relabelto create_lnk_perms };
 allow $1_t { $1_uml_ro_t $1_uml_rw_t $1_uml_exec_t }:dir { relabelfrom relabelto create_dir_perms };
 r_dir_file($1_t, uml_ro_t)
 
diff -ru /usr/src/se/policy/macros/program/x_client_macros.te ./macros/program/x_client_macros.te
--- /usr/src/se/policy/macros/program/x_client_macros.te	2004-06-17 15:10:45.000000000 +1000
+++ ./macros/program/x_client_macros.te	2004-07-08 19:58:46.000000000 +1000
@@ -37,6 +37,7 @@
 
 # Transition from the user domain to the derived domain.
 domain_auto_trans($1_t, $2_exec_t, $1_$2_t)
+can_exec($1_$2_t, $2_exec_t)
 
 # The user role is authorized for this domain.
 role $1_r types $1_$2_t;
@@ -97,8 +99,12 @@
 allow $1_$2_t zero_device_t:chr_file rw_file_perms;
 allow $1_$2_t zero_device_t:chr_file x_file_perms;
 
-# Execute system programs.
-can_exec_any($1_$2_t)
+# allow using shared libraries and running programs
+uses_shlib($1_$2_t)
+allow $1_$2_t { bin_t sbin_t }:dir search;
+allow $1_$2_t bin_t:lnk_file read;
+can_exec($1_$2_t, { shell_exec_t bin_t })
+allow $1_$2_t etc_t:file { getattr read };
 
 # Inherit and use descriptors from gnome-pty-helper.
 ifdef(`gnome-pty-helper.te', `allow $1_$2_t $1_gph_t:fd use;')
diff -ru /usr/src/se/policy/macros/program/xserver_macros.te ./macros/program/xserver_macros.te
--- /usr/src/se/policy/macros/program/xserver_macros.te	2004-07-08 13:09:37.000000000 +1000
+++ ./macros/program/xserver_macros.te	2004-07-08 16:09:31.000000000 +1000
@@ -200,7 +200,10 @@
 allow $1_xserver_t tty_device_t:chr_file { setattr rw_file_perms };
 
 # Run helper programs in $1_xserver_t.
-can_exec_any($1_xserver_t)
+allow $1_xserver_t { bin_t sbin_t }:dir search;
+allow $1_xserver_t etc_t:file { getattr read };
+allow $1_xserver_t bin_t:lnk_file read;
+can_exec($1_xserver_t, { bin_t shell_exec_t })
 
 # Connect to xfs.
 ifdef(`xfs.te', `
diff -ru /usr/src/se/policy/macros/user_macros.te ./macros/user_macros.te
--- /usr/src/se/policy/macros/user_macros.te	2004-06-17 15:10:45.000000000 +1000
+++ ./macros/user_macros.te	2004-07-05 23:50:08.000000000 +1000
@@ -145,7 +145,7 @@
 define(`full_user_role', `
 
 # user_t/$1_t is an unprivileged users domain.
-type $1_t, domain, userdomain, unpriv_userdomain, web_client_domain, privfd
+type $1_t, domain, userdomain, unpriv_userdomain, web_client_domain
 ifdef(`unlimitedUsers', `,privhome, etc_writer, privmodule, privlog, privowner, admin, fs_domain, privmem, privowner, sysctl_kernel_writer, auth, auth_write')
 ;
 

--Boundary-00=_2sp8AvnQROGJX37--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8HC7frT001568
	for <selinux@tycho.nsa.gov>; Fri, 17 Sep 2004 08:07:42 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8HC7but017479
	for <selinux@tycho.nsa.gov>; Fri, 17 Sep 2004 12:07:39 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Policy patches
Date: Fri, 17 Sep 2004 22:07:21 +1000
Cc: jwcart2@epoch.ncsc.mil, SE Linux <selinux@tycho.nsa.gov>
References: <200409162151.44819.russell@coker.com.au> <1095346343.17251.6.camel@moss-lions.epoch.ncsc.mil> <414A0454.2060304@redhat.com>
In-Reply-To: <414A0454.2060304@redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5NtSBis/xNqmsQz"
Message-Id: <200409172207.21788.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_5NtSBis/xNqmsQz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

+dontaudit updfstab_t home_root_t:dir { getattr search };
+dontaudit updfstab_t { home_dir_type home_type }:dir { search };

Why is fstab-sync trying to access home directories?

+allow ttyfile tmpfs_t:filesystem { associate };

Better to just use the dev_fs attribute.  I have attached a patch to do this 
as well as clean up a few other minor issues with the macros directory.

The patch is against the latest CVS.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_5NtSBis/xNqmsQz
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru /usr/src/se/policy/macros/admin_macros.te macros/admin_macros.te
--- /usr/src/se/policy/macros/admin_macros.te	2004-09-09 04:23:06.000000000 +1000
+++ macros/admin_macros.te	2004-09-17 22:01:42.000000000 +1000
@@ -24,7 +24,7 @@
 tmp_domain($1)
 
 # Type for tty devices.
-type $1_tty_device_t, file_type, sysadmfile, ttyfile;
+type $1_tty_device_t, file_type, sysadmfile, ttyfile, dev_fs;
 
 # Inherit rules for ordinary users.
 base_user_domain($1)
diff -ru /usr/src/se/policy/macros/core_macros.te macros/core_macros.te
--- /usr/src/se/policy/macros/core_macros.te	2004-09-02 23:18:55.000000000 +1000
+++ macros/core_macros.te	2004-09-11 19:48:58.000000000 +1000
@@ -549,9 +549,6 @@
 # Access the pty master multiplexer.
 allow $1_t ptmx_t:chr_file rw_file_perms;
 
-ifdef(`devfsd.te', `
-allow $1_t device_t:filesystem getattr;
-')
 allow $1_t devpts_t:filesystem getattr;
 
 # allow searching /dev/pts
diff -ru /usr/src/se/policy/macros/program/gpg_agent_macros.te macros/program/gpg_agent_macros.te
--- /usr/src/se/policy/macros/program/gpg_agent_macros.te	2004-07-08 06:46:41.000000000 +1000
+++ macros/program/gpg_agent_macros.te	2004-09-12 14:47:09.000000000 +1000
@@ -94,9 +94,6 @@
 # read kde font cache
 allow $1_gpg_pinentry_t usr_t:file { getattr read };
 
-# pinentry-qt needs this (executes a KDE style library)
-allow $1_gpg_pinentry_t lib_t:file { execute };
-
 allow $1_gpg_pinentry_t { proc_t self }:dir { search };
 allow $1_gpg_pinentry_t { proc_t self }:lnk_file { read };
 # read /proc/meminfo
diff -ru /usr/src/se/policy/macros/program/mozilla_macros.te macros/program/mozilla_macros.te
--- /usr/src/se/policy/macros/program/mozilla_macros.te	2004-09-16 18:07:08.000000000 +1000
+++ macros/program/mozilla_macros.te	2004-09-16 21:47:34.000000000 +1000
@@ -71,8 +71,6 @@
 allow $1_lpr_t $1_mozilla_rw_t:file rw_file_perms;
 ')
 
-dontaudit $1_mozilla_t tmp_t:lnk_file read;
-
 #
 # This is another place where I sould like to allow system customization.
 # We need to allow the admin to select whether then want to allow mozilla
@@ -100,7 +99,7 @@
 file_type_auto_trans($1_mozilla_t, $1_home_t, $1_mozilla_rw_t)
 allow $1_mozilla_t $1_home_t:dir setattr;
 allow $1_mozilla_t $1_home_t:{ file lnk_file } rw_file_perms;
-} 
+} dnl end if writehome
 
 allow $1_mozilla_t $1_t:unix_stream_socket { connectto };
 allow $1_mozilla_t sysctl_net_t:dir { search };
diff -ru /usr/src/se/policy/macros/program/ssh_macros.te macros/program/ssh_macros.te
--- /usr/src/se/policy/macros/program/ssh_macros.te	2004-08-04 20:26:48.000000000 +1000
+++ macros/program/ssh_macros.te	2004-09-12 17:18:07.000000000 +1000
@@ -32,7 +32,7 @@
 allow $1_ssh_t autofs_t:dir { search getattr };
 ')
 ifdef(`nfs_home_dirs', `
-rw_dir_create_file($1_ssh_t, nfs_t)
+create_dir_file($1_ssh_t, nfs_t)
 ')dnl end if nfs_home_dirs
 
 # Transition from the user domain to the derived domain.
diff -ru /usr/src/se/policy/macros/program/userhelper_macros.te macros/program/userhelper_macros.te
--- /usr/src/se/policy/macros/program/userhelper_macros.te	2004-09-11 16:21:48.000000000 +1000
+++ macros/program/userhelper_macros.te	2004-09-11 19:24:48.000000000 +1000
@@ -17,7 +17,7 @@
 ifdef(`single_userdomain', `
 typealias $1_t alias $1_userhelper_t;
 ', `
-type $1_userhelper_t, domain, userhelperdomain, privlog, privrole, privowner, auth_chkpwd, privfd, privuser;
+type $1_userhelper_t, domain, userhelperdomain, privlog, privrole, privowner, auth_chkpwd, privfd ifdef(`user_canbe_sysadm', `, privuser');
 
 in_user_role($1_userhelper_t)
 role sysadm_r types $1_userhelper_t;
diff -ru /usr/src/se/policy/macros/program/xserver_macros.te macros/program/xserver_macros.te
--- /usr/src/se/policy/macros/program/xserver_macros.te	2004-09-16 18:07:09.000000000 +1000
+++ macros/program/xserver_macros.te	2004-09-14 01:22:44.000000000 +1000
@@ -132,7 +132,7 @@
 allow $1_xserver_t framebuf_device_t:chr_file rw_file_perms;
 allow $1_xserver_t device_t:lnk_file { getattr read };
 allow $1_xserver_t devtty_t:chr_file rw_file_perms;
-allow $1_xserver_t devtty_t:lnk_file read;
+allow $1_xserver_t zero_device_t:chr_file { read write execute };
 
 # Type for temporary files.
 tmp_domain($1_xserver)
@@ -199,14 +198,11 @@
 allow $1_xserver_t proc_t:dir r_dir_perms;
 
 # Create and access /dev/dri devices.
-allow $1_xserver_t device_t:dir { setattr rw_dir_perms };
-allow $1_xserver_t dri_device_t:chr_file create_file_perms;
+allow $1_xserver_t device_t:dir create;
+file_type_auto_trans($1_xserver_t, device_t, dri_device_t, chr_file)
 
 allow $1_xserver_t tty_device_t:chr_file { setattr rw_file_perms };
 
-# Do not flood audit logs due to device node creation attempts.
-dontaudit $1_xserver_t device_t:chr_file create;
-
 # Run helper programs in $1_xserver_t.
 allow $1_xserver_t { bin_t sbin_t }:dir search;
 allow $1_xserver_t etc_t:{ file lnk_file } { getattr read };
@@ -248,8 +242,6 @@
 
 allow $1_xserver_t var_lib_t:dir search;
 rw_dir_create_file($1_xserver_t, var_lib_xkb_t)
-dontaudit $1_xserver_t selinux_config_t:dir { search };
-allow $1_xserver_t device_t:dir { create };
 
 # for fonts
 r_dir_file($1_xserver_t, fonts_t)
diff -ru /usr/src/se/policy/macros/user_macros.te macros/user_macros.te
--- /usr/src/se/policy/macros/user_macros.te	2004-09-15 16:31:23.000000000 +1000
+++ macros/user_macros.te	2004-09-17 22:01:51.000000000 +1000
@@ -32,7 +32,7 @@
 can_create_pty($1, `, userpty_type, user_tty_type')
 
 #Type for tty devices.
-type $1_tty_device_t, file_type, sysadmfile, ttyfile, user_tty_type;
+type $1_tty_device_t, file_type, sysadmfile, ttyfile, user_tty_type, dev_fs;
  
 base_user_domain($1)
 

--Boundary-00=_5NtSBis/xNqmsQz--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

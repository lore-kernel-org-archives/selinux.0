Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1AJF1L9013621
	for <selinux@tycho.nsa.gov>; Thu, 10 Feb 2005 14:15:01 -0500 (EST)
Subject: Re: TTY question
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1108058666.3808.2.camel@cobra.ivg2.net>
References: <1107915334.6602.1.camel@cobra.ivg2.net>
	 <1107954368.17568.25.camel@moss-spartans.epoch.ncsc.mil>
	 <1108000939.5241.10.camel@cobra.ivg2.net>
	 <1108039573.22172.37.camel@moss-spartans.epoch.ncsc.mil>
	 <1108043320.326.1.camel@cobra.ivg2.net>
	 <1108058666.3808.2.camel@cobra.ivg2.net>
Content-Type: multipart/mixed; boundary="=-FEYIGHUV1tihwSwPSa8U"
Date: Thu, 10 Feb 2005 14:15:31 -0500
Message-Id: <1108062931.4443.3.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-FEYIGHUV1tihwSwPSa8U
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Does this look reasonable?

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-FEYIGHUV1tihwSwPSa8U
Content-Disposition: attachment; filename=global_macros_patch.diff
Content-Type: text/x-patch; name=global_macros_patch.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

--- global_macros.te	2005-02-10 13:01:08.000000000 -0500
+++ global_macros.new	2005-02-10 13:00:53.000000000 -0500
@@ -156,6 +156,19 @@
 r_dir_file($1, locale_t)
 ')
 
+###################################
+#
+# access_terminal(domain, typeprefix)
+#
+# Permissions for accessing the terminal
+#
+define(`access_terminal', `
+allow $1 $2_tty_device_t:chr_file rw_file_perms;
+allow $1 devtty_t:chr_file rw_file_perms;
+allow $1 devpts_t:dir r_dir_perms;
+allow $1 $2_devpts_t:chr_file rw_file_perms;
+') 
+
 #
 # general_proc_read_access(domain)
 #

--=-FEYIGHUV1tihwSwPSa8U
Content-Disposition: attachment; filename=program_macros_patch1.diff
Content-Type: text/x-patch; name=program_macros_patch1.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -rua program/cdrecord_macros.te program.new2/cdrecord_macros.te
--- program/cdrecord_macros.te	2005-02-10 13:11:06.000000000 -0500
+++ program.new2/cdrecord_macros.te	2005-02-10 13:11:32.000000000 -0500
@@ -17,8 +17,7 @@
 allow $1_t $1_cdrecord_t:process signal;
 
 # write to the user domain tty.
-allow $1_cdrecord_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_cdrecord_t $1_devpts_t:chr_file rw_file_perms;
+access_terminal($1_cdrecord_t, $1)
 allow $1_cdrecord_t privfd:fd use;
 
 allow $1_cdrecord_t $1_t:unix_stream_socket { getattr read write ioctl };
diff -rua program/chkpwd_macros.te program.new2/chkpwd_macros.te
--- program/chkpwd_macros.te	2005-02-10 13:17:47.000000000 -0500
+++ program.new2/chkpwd_macros.te	2005-02-10 13:18:26.000000000 -0500
@@ -44,8 +44,7 @@
 role system_r types sysadm_chkpwd_t;
 
 # Write to the user domain tty.
-allow $1_chkpwd_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_chkpwd_t $1_devpts_t:chr_file rw_file_perms;
+access_terminal($1_chkpwd_t, $1)
 
 allow $1_chkpwd_t privfd:fd use;
 
diff -rua program/clamav_macros.te program.new2/clamav_macros.te
--- program/clamav_macros.te	2005-02-10 13:42:50.000000000 -0500
+++ program.new2/clamav_macros.te	2005-02-10 13:43:15.000000000 -0500
@@ -48,8 +48,7 @@
 clamscan_domain($1)
 role $1_r types $1_clamscan_t;
 domain_auto_trans($1_t, clamscan_exec_t, $1_clamscan_t)
-allow $1_clamscan_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_clamscan_t $1_devpts_t:chr_file rw_file_perms;
+access_terminal($1_clamscan_t, $1)
 r_dir_file($1_clamscan_t,$1_home_t);
 r_dir_file($1_clamscan_t,$1_home_dir_t);
 allow $1_clamscan_t $1_home_t:file r_file_perms;
diff -rua program/crontab_macros.te program.new2/crontab_macros.te
--- program/crontab_macros.te	2005-02-10 13:41:57.000000000 -0500
+++ program.new2/crontab_macros.te	2005-02-10 13:42:23.000000000 -0500
@@ -87,8 +87,7 @@
 
 # Access terminals.
 allow $1_crontab_t device_t:dir search;
-allow $1_crontab_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_crontab_t $1_devpts_t:chr_file rw_file_perms;
+access_terminal($1_crontab_t, $1);
 
 allow $1_crontab_t fs_t:filesystem getattr;
 
diff -rua program/gpg_agent_macros.te program.new2/gpg_agent_macros.te
--- program/gpg_agent_macros.te	2005-02-10 13:23:26.000000000 -0500
+++ program.new2/gpg_agent_macros.te	2005-02-10 13:23:56.000000000 -0500
@@ -25,9 +25,7 @@
 allow $1_gpg_agent_t xdm_t:fd use;
 
 # Write to the user domain tty.
-allow $1_gpg_agent_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_gpg_agent_t $1_devpts_t:chr_file rw_file_perms;
-allow $1_gpg_agent_t devtty_t:chr_file { read write };
+access_terminal($1_gpg_agent_t, $1)
 
 # Allow the user shell to signal the gpg-agent program.
 allow $1_t $1_gpg_agent_t:process { signal sigkill };
diff -rua program/gpg_macros.te program.new2/gpg_macros.te
--- program/gpg_macros.te	2005-02-10 13:08:36.000000000 -0500
+++ program.new2/gpg_macros.te	2005-02-10 13:09:32.000000000 -0500
@@ -43,8 +43,7 @@
 allow $1_gpg_t self:unix_stream_socket create_stream_socket_perms;
 allow $1_gpg_t self:tcp_socket create_stream_socket_perms;
 
-allow $1_gpg_t devpts_t:dir search;
-allow $1_gpg_t { $1_devpts_t $1_tty_device_t }:chr_file rw_file_perms;
+access_terminal($1_gpg_t, $1)
 ifdef(`gnome-pty-helper.te', `allow $1_gpg_t $1_gph_t:fd use;')
 
 # Inherit and use descriptors
@@ -84,7 +83,6 @@
 }
 
 allow $1_gpg_t self:capability { ipc_lock setuid };
-allow $1_gpg_t devtty_t:chr_file rw_file_perms;
 rw_dir_create_file($1_gpg_t, $1_file_type)
 
 allow $1_gpg_t { etc_t usr_t }:dir r_dir_perms;
diff -rua program/irc_macros.te program.new2/irc_macros.te
--- program/irc_macros.te	2005-02-10 13:09:44.000000000 -0500
+++ program.new2/irc_macros.te	2005-02-10 13:10:38.000000000 -0500
@@ -47,14 +47,13 @@
 
 allow $1_irc_t usr_t:file { getattr read };
 
+access_terminal($1_irc_t, $1)
 uses_shlib($1_irc_t)
 allow $1_irc_t etc_t:file { read getattr };
 read_locale($1_irc_t)
 allow $1_irc_t fs_t:filesystem getattr;
 allow $1_irc_t var_t:dir search;
-allow $1_irc_t devpts_t:dir { getattr read search };
 allow $1_irc_t device_t:dir search;
-allow $1_irc_t devtty_t:chr_file rw_file_perms;
 allow $1_irc_t self:unix_stream_socket create_stream_socket_perms;
 allow $1_irc_t privfd:fd use;
 allow $1_irc_t proc_t:dir search;
@@ -62,10 +61,6 @@
 allow $1_irc_t self:dir search;
 dontaudit $1_irc_t var_run_t:dir search;
 
-# Write to the user domain tty.
-allow $1_irc_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_irc_t $1_devpts_t:chr_file rw_file_perms;
-
 # allow utmp access
 allow $1_irc_t initrc_var_run_t:file read;
 dontaudit $1_irc_t initrc_var_run_t:file lock;
diff -rua program/java_macros.te program.new2/java_macros.te
--- program/java_macros.te	2005-02-10 13:11:54.000000000 -0500
+++ program.new2/java_macros.te	2005-02-10 13:14:06.000000000 -0500
@@ -86,6 +86,7 @@
 
 legacy_domain($1_java)
 
+access_terminal($1_java_t, $2)
 uses_shlib($1_java_t)
 read_locale($1_java_t)
 rw_dir_file($1_java_t, $1_rw_t)
@@ -108,9 +109,6 @@
 
 dontaudit $1_java_t fonts_t:file execute;
 dontaudit $1_java_t sound_device_t:chr_file execute;
-dontaudit $1_java_t $2_devpts_t:chr_file { read write };
-dontaudit $1_java_t sysadm_devpts_t:chr_file { read write };
-dontaudit $1_java_t devtty_t:chr_file { read write };
 dontaudit $1_java_t tmpfs_t:file { execute read write };
 dontaudit $1_java_t $1_rw_t:file { execute setattr };
 
diff -rua program/lockdev_macros.te program.new2/lockdev_macros.te
--- program/lockdev_macros.te	2005-02-10 13:44:53.000000000 -0500
+++ program.new2/lockdev_macros.te	2005-02-10 13:45:26.000000000 -0500
@@ -36,7 +36,7 @@
 
 allow $1_lockdev_t device_t:dir search;
 allow $1_lockdev_t null_device_t:chr_file rw_file_perms;
-allow $1_lockdev_t { $1_tty_device_t $1_devpts_t }:chr_file rw_file_perms;
+access_terminal($1_lockdev_t, $1)
 dontaudit $1_lockdev_t root_t:dir search;
 
 uses_shlib($1_lockdev_t)
diff -rua program/lpr_macros.te program.new2/lpr_macros.te
--- program/lpr_macros.te	2005-02-10 13:27:15.000000000 -0500
+++ program.new2/lpr_macros.te	2005-02-10 13:27:40.000000000 -0500
@@ -64,8 +64,7 @@
 allow $1_lpr_t device_t:dir search;
 
 # Access the terminal.
-allow $1_lpr_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_lpr_t $1_devpts_t:chr_file rw_file_perms;
+access_terminal($1_lpr_t, $1)
 
 # Inherit and use descriptors from gnome-pty-helper.
 ifdef(`gnome-pty-helper.te', `allow $1_lpr_t $1_gph_t:fd use;')
diff -rua program/mount_macros.te program.new2/mount_macros.te
--- program/mount_macros.te	2005-02-10 13:28:05.000000000 -0500
+++ program.new2/mount_macros.te	2005-02-10 13:28:35.000000000 -0500
@@ -63,8 +63,7 @@
 allow $2_t sbin_t:lnk_file read;
 
 # Access the terminal.
-allow $2_t $1_tty_device_t:chr_file { getattr read write ioctl };
-allow $2_t $1_devpts_t:chr_file { getattr read write };
+access_terminal($2_t, $1)
 ifdef(`gnome-pty-helper.te', `allow $2_t $1_gph_t:fd use;')
 allow $2_t var_t:dir search;
 allow $2_t var_run_t:dir search;
diff -rua program/mplayer_macros.te program.new2/mplayer_macros.te
--- program/mplayer_macros.te	2005-02-10 13:39:27.000000000 -0500
+++ program.new2/mplayer_macros.te	2005-02-10 13:41:28.000000000 -0500
@@ -40,19 +40,11 @@
 allow $1_$2_t sysctl_kernel_t:dir search;
 allow $1_$2_t sysctl_kernel_t:file { getattr read };
 
-# allow ps
+# Allow ps, shared libs, locale, terminal access
 can_ps($1_t, $1_$2_t)
-
-# uses shared libraries
 uses_shlib($1_$2_t)
-
-# localization
 read_locale($1_$2_t)
-
-# Access the terminal.
-allow $1_$2_t devpts_t:dir { search };
-allow $1_$2_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_$2_t $1_devpts_t:chr_file rw_file_perms;
+access_terminal($1_$2_t, $1)
 
 # Required for win32 binary loader 
 allow $1_$2_t zero_device_t:chr_file { read write execute };
@@ -64,8 +56,6 @@
 allow $1_$2_t zero_device_t:chr_file execmod;
 }
 
-
-
 # Access to DVD/CD/V4L
 allow $1_$2_t device_t:dir r_dir_perms;
 allow $1_$2_t device_t:lnk_file { getattr read };
diff -rua program/mta_macros.te program.new2/mta_macros.te
--- program/mta_macros.te	2005-02-10 13:24:30.000000000 -0500
+++ program.new2/mta_macros.te	2005-02-10 13:26:00.000000000 -0500
@@ -87,10 +87,9 @@
 
 allow mta_user_agent $1_tmp_t:file { read getattr };
 
-allow mta_user_agent { $1_devpts_t $1_tty_device_t }:chr_file { getattr read write };
-
 # Write to the user domain tty.
-allow $1_mail_t { $1_tty_device_t $1_devpts_t devtty_t }:chr_file rw_file_perms;
+access_terminal(mta_user_agent, $1)
+access_terminal($1_mail_t, $1)
 
 # Inherit and use descriptors from gnome-pty-helper.
 ifdef(`gnome-pty-helper.te', `allow $1_mail_t $1_gph_t:fd use;')
diff -rua program/slocate_macros.te program.new2/slocate_macros.te
--- program/slocate_macros.te	2005-02-10 13:49:06.000000000 -0500
+++ program.new2/slocate_macros.te	2005-02-10 13:49:34.000000000 -0500
@@ -47,10 +47,7 @@
 allow $1_t $1_locate_t:process signal;
 
 uses_shlib($1_locate_t)
-
-# Write to the user domain tty.
-allow $1_locate_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_locate_t $1_devpts_t:chr_file rw_file_perms;
+access_terminal($1_locate_t, $1)
 
 allow $1_locate_t { home_root_t $1_home_dir_t $1_file_type }:dir { getattr search };
 allow $1_locate_t $1_file_type:{ file lnk_file } { getattr read };
diff -rua program/ssh_agent_macros.te program.new2/ssh_agent_macros.te
--- program/ssh_agent_macros.te	2005-02-10 13:49:59.000000000 -0500
+++ program.new2/ssh_agent_macros.te	2005-02-10 13:50:36.000000000 -0500
@@ -27,9 +27,7 @@
 allow $1_ssh_agent_t privfd:fd use;
 
 # Write to the user domain tty.
-allow $1_ssh_agent_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_ssh_agent_t $1_devpts_t:chr_file rw_file_perms;
-allow $1_ssh_agent_t devtty_t:chr_file { read write };
+access_terminal($1_ssh_agent_t, $1)
 
 # Allow the user shell to signal the ssh program.
 allow $1_t $1_ssh_agent_t:process signal;
diff -rua program/ssh_macros.te program.new2/ssh_macros.te
--- program/ssh_macros.te	2005-02-10 13:43:48.000000000 -0500
+++ program.new2/ssh_macros.te	2005-02-10 13:44:30.000000000 -0500
@@ -52,9 +52,6 @@
 
 base_file_read_access($1_ssh_t)
 
-# Read the devpts root directory.
-allow $1_ssh_t devpts_t:dir r_dir_perms;
-
 # Read /var.
 allow $1_ssh_t var_t:dir r_dir_perms;
 allow $1_ssh_t var_t:notdevfile_class_set r_file_perms;
@@ -77,8 +74,7 @@
 # Read /dev/urandom.
 allow $1_ssh_t urandom_device_t:chr_file r_file_perms;
 
-# Read and write /dev/tty and /dev/null.
-allow $1_ssh_t devtty_t:chr_file rw_file_perms;
+# Read and write /dev/null.
 allow $1_ssh_t { null_device_t zero_device_t }:chr_file rw_file_perms;
 
 # Grant permissions needed to create TCP and UDP sockets and
@@ -127,8 +123,7 @@
 ifdef(`gnome-pty-helper.te', `allow $1_ssh_t $1_gph_t:fd use;')
 
 # Write to the user domain tty.
-allow $1_ssh_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_ssh_t $1_devpts_t:chr_file rw_file_perms;
+access_terminal($1_ssh_t, $1)
 
 # Allow the user shell to signal the ssh program.
 allow $1_t $1_ssh_t:process signal;
diff -rua program/su_macros.te program.new2/su_macros.te
--- program/su_macros.te	2005-02-09 19:57:11.000000000 -0500
+++ program.new2/su_macros.te	2005-02-10 13:47:32.000000000 -0500
@@ -99,7 +99,7 @@
 }
 
 # Relabel ttys and ptys.
-allow $1_su_t { device_t devpts_t }:dir { getattr read search };
+allow $1_su_t device_t:dir { getattr read search };
 allow $1_su_t { ttyfile ptyfile }:chr_file { relabelfrom relabelto };
 
 # Close and re-open ttys and ptys to get the fd into the correct domain.
@@ -121,9 +121,7 @@
 role $1_r types $1_su_t;
 
 # Write to the user domain tty.
-allow $1_su_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_su_t $1_devpts_t:chr_file rw_file_perms;
-allow $1_su_t { sysadm_tty_device_t sysadm_devpts_t }:chr_file { getattr ioctl };
+access_terminal($1_su_t, $1)
 
 allow $1_su_t { home_root_t $1_home_dir_t }:dir search;
 allow $1_su_t $1_home_t:file create_file_perms;
diff -rua program/uml_macros.te program.new2/uml_macros.te
--- program/uml_macros.te	2005-02-10 13:21:39.000000000 -0500
+++ program.new2/uml_macros.te	2005-02-10 13:22:22.000000000 -0500
@@ -110,7 +110,6 @@
 dontaudit $1_uml_t initrc_var_run_t:file { write lock };
 
 allow $1_uml_t device_t:dir search;
-allow $1_uml_t devtty_t:chr_file rw_file_perms;
 allow $1_uml_t self:unix_stream_socket create_stream_socket_perms;
 allow $1_uml_t self:unix_dgram_socket create_socket_perms;
 allow $1_uml_t privfd:fd use;
@@ -121,8 +120,7 @@
 allow $1_uml_t proc_t:file write;
 
 # Write to the user domain tty.
-allow $1_uml_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_uml_t $1_devpts_t:chr_file rw_file_perms;
+access_terminal($1_uml_t, $1)
 
 # access config files
 allow $1_uml_t home_root_t:dir search;
diff -rua program/xauth_macros.te program.new2/xauth_macros.te
--- program/xauth_macros.te	2005-02-10 13:21:09.000000000 -0500
+++ program.new2/xauth_macros.te	2005-02-10 13:21:26.000000000 -0500
@@ -66,8 +66,7 @@
 allow $1_xauth_t fs_t:filesystem getattr;
 
 # Write to the user domain tty.
-allow $1_xauth_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_xauth_t $1_devpts_t:chr_file rw_file_perms;
+access_terminal($1_xauth_t, $1)
 
 # Scan /var/run.
 allow $1_xauth_t var_t:dir search;
diff -rua program/x_client_macros.te program.new2/x_client_macros.te
--- program/x_client_macros.te	2005-02-10 13:14:27.000000000 -0500
+++ program.new2/x_client_macros.te	2005-02-10 13:16:57.000000000 -0500
@@ -57,9 +57,9 @@
 allow $1_$2_t etc_runtime_t:file { getattr read };
 allow $1_$2_t etc_t:lnk_file read;
 allow $1_$2_t fs_t:filesystem getattr;
+access_terminal($1_$2_t, $1)
 read_locale($1_$2_t)
 r_dir_file($1_$2_t, readable_t)
-allow $1_$2_t devtty_t:chr_file { read write };
 allow $1_$2_t proc_t:dir search;
 allow $1_$2_t proc_t:lnk_file read;
 allow $1_$2_t self:dir search;
@@ -143,11 +143,6 @@
 can_tcp_connect($1_$2_t, sshd_t)
 ')
 
-# Access the terminal.
-allow $1_$2_t devpts_t:dir search;
-allow $1_$2_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_$2_t $1_devpts_t:chr_file rw_file_perms;
-
 # Read the home directory, e.g. for .Xauthority and to get to config files
 allow $1_$2_t home_root_t:dir { search getattr };
 file_type_auto_trans($1_$2_t, $1_home_dir_t, $1_$2_rw_t)

--=-FEYIGHUV1tihwSwPSa8U--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

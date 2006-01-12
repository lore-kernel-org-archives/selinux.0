Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0CLmOXf015203
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2006 16:48:24 -0500 (EST)
Received: from e31.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0CLlH5L003511
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2006 21:47:17 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k0CLmNsk008505
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2006 16:48:23 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k0CLoRNo176546
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2006 14:50:27 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k0CLmMN1001699
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2006 14:48:22 -0700
Received: from sergelap.hallyn.com (sig-9-65-93-217.mts.ibm.com [9.65.93.217])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id k0CLmLID001532
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2006 14:48:21 -0700
Date: Thu, 12 Jan 2006 15:48:19 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: sereference: screen policy
Message-ID: <20060112214819.GA8013@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Still getting the hang of the various existing interfaces, but this
policy at least lets me run screen as sysadm_u and user_u.  This
likely shouldn't go in as is since I doubt it's minimal due to clumsy
use of wrong interfaces, but I won't be looking at this again until
next week at earliest, so meanwhile here's what I've got.

thanks,
-serge

Index: refpolicy/policy/modules/apps/screen.if
===================================================================
--- /dev/null
+++ refpolicy/policy/modules/apps/screen.if
@@ -0,0 +1,153 @@
+## <summary>Screen policy</summary>
+
+#######################################
+## <summary>
+##	The per user domain template for the screen module.
+## </summary>
+## <desc>
+##	<p>
+##	This template creates a derived domains which are used
+##	for screen sessions.
+##	</p>
+##	<p>
+##	This template is invoked automatically for each user, and
+##	generally does not need to be invoked directly
+##	by policy writers.
+##	</p>
+##	<p>
+##	Based on Russel Coker's version for the strict policy
+##	</p>
+## </desc>
+## <param name="userdomain_prefix">
+##	The prefix of the user domain (e.g., user
+##	is the prefix for user_t).
+## </param>
+## <param name="user_domain">
+##	The type of the user domain.
+## </param>
+## <param name="user_role">
+##	The role associated with the user domain.
+## </param>
+#
+
+template(`screen_per_userdomain_template',`
+	type $1_screen_t;
+	domain_type($1_screen_t);
+	#domain_entry_file($1_screen_t,screen_exec_t)
+	domain_auto_trans($1_t, screen_exec_t, $1_screen_t)
+	domain_entry_file($1_screen_t, screen_exec_t)
+	allow $1_screen_t $1_t:process sigchld;
+	allow $1_t $1_screen_t:process sigchld;
+	allow $1_screen_t $1_t:fd use;
+	allow $1_t $1_screen_t:fd use;
+	allow $1_t $1_screen_t:fifo_file rw_file_perms;
+	role $3 types $1_screen_t;
+
+	files_read_etc_files($1_screen_t)
+	files_read_etc_runtime_files($1_screen_t)
+	files_search_home($1_screen_t)
+
+	libs_read_lib($1_screen_t)
+	libs_use_ld_so($1_screen_t)
+	libs_use_shared_libs($1_screen_t)
+
+	locallogin_use_fd($1_screen_t)
+	dev_read_urand($1_screen_t)
+
+	userdom_use_user_terminals($1, $1_screen_t)
+
+	files_create_tmp_files($1_screen_t, $1_tmp_t, { file dir })
+
+	allow $1_screen_t $1_home_t:file rw_file_perms;
+	allow $1_screen_t $1_tmp_t:file rw_file_perms;
+
+	# Revert to the user domain when a shell is executed.
+	domain_auto_trans($1_screen_t, { shell_exec_t bin_t }, $1_t)
+	domain_auto_trans($1_screen_t, $1_home_t, $1_t)
+
+	#if (use_nfs_home_dirs) {
+	#domain_auto_trans($1_screen_t, nfs_t, $1_t)
+	#}
+	#if (use_samba_home_dirs) {
+	#domain_auto_trans($1_screen_t, cifs_t, $1_t)
+	#}
+
+	# Write to utmp.
+	init_rw_script_pid($1_screen_t);
+
+	# create pty devices
+	allow $1_t $1_devpts_t:chr_file { rw_file_perms setattr getattr relabelfrom };
+	term_create_pty($1_t,$1_devpts_t)
+	allow $1_t devpts_t:chr_file rw_file_perms;
+	allow $1_screen_t bsdpty_device_t:chr_file rw_file_perms;
+
+	term_use_ptmx($1_screen_t)
+
+	# Create fifo
+	allow $1_screen_t var_t:dir search;
+	type_transition $1_screen_t var_run_t:dir screen_dir_t;
+	allow $1_screen_t var_run_t:dir create_dir_perms;
+	allow $1_screen_t screen_dir_t:dir create_dir_perms;
+	type $1_screen_var_run_t;
+	files_pid_file($1_screen_var_run_t)
+	type_transition $1_screen_t screen_dir_t:{ fifo_file file } $1_screen_var_run_t;
+	allow $1_screen_t $1_screen_var_run_t:fifo_file create_file_perms;
+
+	allow $1_screen_t self:process { fork signal_perms };
+	allow $1_t $1_screen_t:process signal;
+	allow $1_screen_t $1_t:process signal;
+	allow $1_screen_t self:capability { setuid setgid fsetid };
+
+	allow $1_screen_t tmp_t:dir search;
+	allow $1_screen_t port_type:tcp_socket name_connect;
+
+	allow $1_screen_t devpts_t:filesystem getattr;
+	allow $1_screen_t tmpfs_t:filesystem getattr;
+	allow $1_screen_t tmpfs_t:fifo_file getattr;
+	term_getattr_unallocated_ttys($1_screen_t)
+	dev_getattr_generic_blk_file($1_screen_t)
+	dev_getattr_generic_chr_file($1_screen_t)
+
+	term_use_generic_pty($1_screen_t)
+	term_setattr_all_user_ptys($1_screen_t)
+	term_use_all_terms($1_screen_t)
+	auth_read_shadow($1_screen_t)
+	allow sysadm_screen_t devpts_t:chr_file setattr;
+
+	optional_policy(`nis',`
+		nis_use_ypbind($1_screen_t)
+	')
+
+
+	# get stats
+	kernel_search_proc($1_screen_t)
+	kernel_list_proc($1_screen_t)
+	kernel_getattr_proc_files($1_screen_t)
+	kernel_read_proc_symlinks($1_screen_t)
+
+	files_read_etc_files($1_screen_t)
+	allow $1_screen_t self:dir { search read };
+	dev_list_all_dev_nodes($1_screen_t)
+	allow $1_screen_t self:lnk_file read;
+	allow $1_screen_t { $1_home_dir_t }:dir search;
+
+	files_search_home($1_screen_t)
+
+	# only for serges setup
+	allow $1_screen_t user_home_dir_t:dir search_dir_perms;
+
+	# Internal screen networking
+	allow $1_screen_t self:fd use;
+	allow $1_screen_t self:unix_stream_socket create_socket_perms;
+	allow $1_screen_t self:unix_dgram_socket create_socket_perms;
+
+	corecmd_exec_bin($1_screen_t)
+	miscfiles_read_localization($1_screen_t)
+
+	# Ok, well I need these too...
+	allow $1_screen_t device_t:file getattr;
+	allow $1_screen_t device_t:sock_file getattr;
+	allow $1_screen_t tmpfs_t:dir getattr;
+	allow $1_screen_t tty_device_t:lnk_file read;
+
+')
Index: refpolicy/policy/modules/apps/screen.te
===================================================================
--- /dev/null
+++ refpolicy/policy/modules/apps/screen.te
@@ -0,0 +1,11 @@
+policy_module(screen,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type screen_exec_t;
+files_type(screen_exec_t);
+type screen_dir_t;
+files_type(screen_dir_t);
Index: refpolicy/policy/modules/apps/screen.fc
===================================================================
--- /dev/null
+++ refpolicy/policy/modules/apps/screen.fc
@@ -0,0 +1,5 @@
+# screen
+/usr/bin/screen         --      system_u:object_r:screen_exec_t
+HOME_DIR/\.screenrc     --      system_u:object_r:ROLE_screen_ro_home_t
+/var/run/screens?/S-[^/]+       -d      system_u:object_r:screen_dir_t
+/var/run/screens?/S-[^/]+/.*    <<none>>
Index: refpolicy/policy/modules.conf
===================================================================
--- refpolicy.orig/policy/modules.conf
+++ refpolicy/policy/modules.conf
@@ -262,6 +262,13 @@ gpg = module
 irc = module
 
 # Layer: apps
+# Module: screen
+#
+# Screen policy
+# 
+screen = module
+
+# Layer: apps
 # Module: loadkeys
 #
 # Load keyboard mappings.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

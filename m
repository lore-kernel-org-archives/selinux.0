Message-ID: <48406667.4030804@redhat.com>
Date: Fri, 30 May 2008 16:41:11 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Ted X Toth <txtoth@gmail.com>
Subject: Here is my current diff on xserver policy.
Content-Type: multipart/mixed;
 boundary="------------070806010208030304070805"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070806010208030304070805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I threw away my XACe changes from my patch and decided to start again.

Here is my current xserver patch

I am looking at the X Server stuff and I have several questions about
using this policy.

First most X Apps will run under staff_t.

Some will run in an equivalence class staff_java_t, staff_mono_t.

These should have all the same access between each other

staff_t == staff_java_t == staff_mono_t

How do I do that with Xace policy interface.

I have staff_mozilla_t, and staff_nsplugin_t what interface to I add to
these to allow them to work with staff_t defined above?  How about if I
want to stop nsplugin from reading the cut buffer of staff_t?  I also
want to stop nsplugin from sniffing the keyboard  (xspy), and doing any
screen capture.

When I sudo to root, I use unconfined_t.  It starts X Apps up like
system-config-selinux.  How do I define the interactions between this X
Client and my staff_* windows?

My xserver runs as xdm_xserver_t but the current interfaces look like
they expect it to be labeled staff_xserver_t?

Last time I went through this exercise I ended up with a maze of twisty
little passages.

I don't think that anything I asked above is all that complicated but I
believe getting the policy correct will be difficult.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkhAZkcACgkQrlYvE4MpobNY2QCgtyEO5rLrsGO6Aa2uMGLw9wUz
+OAAoKqcO1hhxQDBfMrHJn3ruM/xsmYw
=smnl
-----END PGP SIGNATURE-----

--------------070806010208030304070805
Content-Type: text/plain;
 name="services_xserver.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="services_xserver.patch"

Subject: [PATCH] refpolicy: services_xserver changes
--text follows this line--
--- nsaserefpolicy/policy/modules/services/xserver.fc	2008-05-19 10:26:37.000000000 -0400
+++ serefpolicy-3.4.1/policy/modules/services/xserver.fc	2008-05-30 16:22:00.160785000 -0400
@@ -1,13 +1,14 @@
 #
 # HOME_DIR
 #
-HOME_DIR/\.fonts\.conf	--	gen_context(system_u:object_r:ROLE_fonts_config_t,s0)
-HOME_DIR/\.fonts(/.*)?		gen_context(system_u:object_r:ROLE_fonts_t,s0)
-HOME_DIR/\.fonts/auto(/.*)?	gen_context(system_u:object_r:ROLE_fonts_cache_t,s0)
-HOME_DIR/\.fonts\.cache-.* --	gen_context(system_u:object_r:ROLE_fonts_cache_t,s0)
-HOME_DIR/\.ICEauthority.* --	gen_context(system_u:object_r:ROLE_iceauth_home_t,s0)
-HOME_DIR/\.xauth.*	--	gen_context(system_u:object_r:ROLE_xauth_home_t,s0)
-HOME_DIR/\.Xauthority.*	--	gen_context(system_u:object_r:ROLE_xauth_home_t,s0)
+HOME_DIR/\.fonts(/.*)?		gen_context(system_u:object_r:fonts_home_t,s0)
+HOME_DIR/\.fontconfig(/.*)?	gen_context(system_u:object_r:fonts_config_home_t,s0)
+HOME_DIR/\.fonts\.conf	--	gen_context(system_u:object_r:fonts_config_home_t,s0)
+HOME_DIR/\.fonts/auto(/.*)?	gen_context(system_u:object_r:fonts_cache_home_t,s0)
+HOME_DIR/\.fonts\.cache-.* --	gen_context(system_u:object_r:fonts_cache_home_t,s0)
+HOME_DIR/\.ICEauthority.* --	gen_context(system_u:object_r:iceauth_home_t,s0)
+HOME_DIR/\.xauth.*	--	gen_context(system_u:object_r:xauth_home_t,s0)
+HOME_DIR/\.Xauthority.*	--	gen_context(system_u:object_r:xauth_home_t,s0)
 
 #
 # /dev
@@ -32,11 +33,6 @@
 /etc/X11/wdm/Xstartup.*	--	gen_context(system_u:object_r:xsession_exec_t,s0)
 /etc/X11/Xsession[^/]*	--	gen_context(system_u:object_r:xsession_exec_t,s0)
 
-ifdef(`distro_redhat',`
-/etc/gdm/PostSession/.*	--	gen_context(system_u:object_r:xsession_exec_t,s0)
-/etc/gdm/PreSession/.*	--	gen_context(system_u:object_r:xsession_exec_t,s0)
-')
-
 #
 # /opt
 #
@@ -58,7 +54,8 @@
 #
 
 /usr/(s)?bin/gdm-binary	--	gen_context(system_u:object_r:xdm_exec_t,s0)
-/usr/(s)?bin/[xgkw]dm	--	gen_context(system_u:object_r:xdm_exec_t,s0)
+/usr/bin/[xgkw]dm	--	gen_context(system_u:object_r:xdm_exec_t,s0)
+/usr/sbin/[xgkw]dm	--	gen_context(system_u:object_r:xdm_exec_t,s0)
 /usr/bin/gpe-dm		--	gen_context(system_u:object_r:xdm_exec_t,s0)
 /usr/bin/iceauth	--	gen_context(system_u:object_r:iceauth_exec_t,s0)
 /usr/bin/Xair		--	gen_context(system_u:object_r:xserver_exec_t,s0)
@@ -89,16 +86,23 @@
 
 /var/[xgk]dm(/.*)?		gen_context(system_u:object_r:xserver_log_t,s0)
 
-/var/lib/[xkw]dm(/.*)?		gen_context(system_u:object_r:xdm_var_lib_t,s0)
+/var/lib/[gxkw]dm(/.*)?		gen_context(system_u:object_r:xdm_var_lib_t,s0)
 /var/lib/xkb(/.*)?		gen_context(system_u:object_r:xkb_var_lib_t,s0)
+/var/lib/xorg(/.*)?		gen_context(system_u:object_r:xserver_var_lib_t,s0)
 
-/var/log/[kw]dm\.log	--	gen_context(system_u:object_r:xserver_log_t,s0)
+/var/log/[kw]dm\.log.*	--	gen_context(system_u:object_r:xserver_log_t,s0)
 /var/log/gdm(/.*)?		gen_context(system_u:object_r:xserver_log_t,s0)
 /var/log/XFree86.*	--	gen_context(system_u:object_r:xserver_log_t,s0)
 /var/log/Xorg.*		--	gen_context(system_u:object_r:xserver_log_t,s0)
+/var/log/nvidia-installer\.log.* --	gen_context(system_u:object_r:xserver_log_t,s0)
 
+/var/run/gdm(/.*)?	 	gen_context(system_u:object_r:xdm_var_run_t,s0)
+/var/run/gdm_socket	-s	gen_context(system_u:object_r:xdm_var_run_t,s0)
 /var/run/[gx]dm\.pid	--	gen_context(system_u:object_r:xdm_var_run_t,s0)
+/var/run/video.rom	--	gen_context(system_u:object_r:xserver_var_run_t,s0)
 /var/run/xdmctl(/.*)?		gen_context(system_u:object_r:xdm_var_run_t,s0)
+/var/run/xauth(/.*)?		gen_context(system_u:object_r:xdm_var_run_t,s0)
+/var/run/xorg(/.*)?		gen_context(system_u:object_r:xserver_var_run_t,s0)
 
 ifdef(`distro_suse',`
 /var/lib/pam_devperm/:0	--	gen_context(system_u:object_r:xdm_var_lib_t,s0)
--- nsaserefpolicy/policy/modules/services/xserver.if	2008-05-19 10:26:38.000000000 -0400
+++ serefpolicy-3.4.1/policy/modules/services/xserver.if	2008-05-30 16:24:12.019801000 -0400
@@ -128,18 +128,24 @@
 	dev_rw_agp($1_xserver_t)
 	dev_rw_framebuffer($1_xserver_t)
 	dev_manage_dri_dev($1_xserver_t)
-	dev_create_generic_dirs($1_xserver_t)
-	dev_setattr_generic_dirs($1_xserver_t)
+	dev_manage_generic_dirs($1_xserver_t)
 	# raw memory access is needed if not using the frame buffer
 	dev_read_raw_memory($1_xserver_t)
 	dev_wx_raw_memory($1_xserver_t)
 	# for other device nodes such as the NVidia binary-only driver
 	dev_rw_xserver_misc($1_xserver_t)
+	dev_setattr_xserver_misc_dev($1_xserver_t)
 	# read events - the synaptics touchpad driver reads raw events
 	dev_rw_input_dev($1_xserver_t)
 	dev_rwx_zero($1_xserver_t)
+	dev_read_urand($1_xserver_t)
+	dev_rw_generic_usb_dev($1_xserver_t)
+	dev_rw_generic_usb_pipes($1_xserver_t)
 
+	domain_mmap_low_type($1_xserver_t)
 	domain_mmap_low($1_xserver_t)
+	domain_read_all_domains_state($1_xserver_t)
+	domain_dontaudit_ptrace_all_domains($1_xserver_t)
 
 	files_read_etc_files($1_xserver_t)
 	files_read_etc_runtime_files($1_xserver_t)
@@ -153,7 +159,8 @@
 	fs_getattr_xattr_fs($1_xserver_t)
 	fs_search_nfs($1_xserver_t)
 	fs_search_auto_mountpoints($1_xserver_t)
-	fs_search_ramfs($1_xserver_t)
+	fs_manage_ramfs_files($1_xserver_t)
+	fs_list_inotifyfs($1_xserver_t)
 
 	selinux_validate_context($1_xserver_t)
 	selinux_compute_access_vector($1_xserver_t)
@@ -163,6 +170,9 @@
 
 	init_getpgid($1_xserver_t)
 
+	miscfiles_read_hwdata($1_xserver_t)
+
+	term_search_ptys($1_xserver_t)
 	term_setattr_unallocated_ttys($1_xserver_t)
 	term_use_unallocated_ttys($1_xserver_t)
 
@@ -270,6 +280,9 @@
 	gen_require(`
 		type iceauth_exec_t, xauth_exec_t;
 		attribute fonts_type, fonts_cache_type, fonts_config_type;
+		type fonts_home_t;
+		type fonts_cache_home_t;
+		type fonts_config_home_t;
 	')
 
 	##############################
@@ -280,35 +293,25 @@
 	xserver_common_domain_template($1)
 	role $3 types $1_xserver_t;
 
-	type $1_fonts_t, fonts_type;
-	userdom_user_home_content($1,$1_fonts_t)
-
-	type $1_fonts_cache_t, fonts_cache_type;
-	userdom_user_home_content($1,$1_fonts_cache_t)
-
-	type $1_fonts_config_t, fonts_config_type;
-	userdom_user_home_content($1,$1_fonts_cache_t)
+	typealias fonts_home_t alias $1_fonts_t;
+	typealias fonts_cache_home_t alias $1_fonts_cache_t;
+	typealias fonts_config_home_t alias $1_fonts_config_t;
 
 	type $1_iceauth_t;
 	domain_type($1_iceauth_t)
 	domain_entry_file($1_iceauth_t,iceauth_exec_t)
 	role $3 types $1_iceauth_t;
 
-	type $1_iceauth_home_t alias $1_iceauth_rw_t;
-	files_poly_member($1_iceauth_home_t)
-	userdom_user_home_content($1,$1_iceauth_home_t)
+	typealias iceauth_home_t alias $1_iceauth_rw_t;
+	typealias iceauth_home_t alias $1_iceauth_home_t;
 
 	type $1_xauth_t;
 	domain_type($1_xauth_t)
 	domain_entry_file($1_xauth_t,xauth_exec_t)
 	role $3 types $1_xauth_t;
 
-	type $1_xauth_home_t alias $1_xauth_rw_t, xauth_home_type;
-	files_poly_member($1_xauth_home_t)
-	userdom_user_home_content($1,$1_xauth_home_t)
-
-	type $1_xauth_tmp_t;
-	files_tmp_file($1_xauth_tmp_t)
+	typealias xauth_home_t alias $1_xauth_rw_t;
+	typealias xauth_home_t alias $1_xauth_home_t;
 
 	##############################
 	#
@@ -317,24 +320,24 @@
 
 	domtrans_pattern($1_xserver_t, xauth_exec_t, $1_xauth_t)
 
-	allow $1_xserver_t $1_xauth_home_t:file { getattr read };
+	allow $1_xserver_t xauth_home_t:file { getattr read };
 
 	domtrans_pattern($2, xserver_exec_t, $1_xserver_t)
 	allow $1_xserver_t $2:process signal;
 
 	allow $1_xserver_t $2:shm rw_shm_perms;
 
-	manage_dirs_pattern($2,$1_fonts_t,$1_fonts_t)
-	manage_files_pattern($2,$1_fonts_t,$1_fonts_t)
-	relabel_dirs_pattern($2,$1_fonts_t,$1_fonts_t)
-	relabel_files_pattern($2,$1_fonts_t,$1_fonts_t)
-
-	manage_dirs_pattern($2,$1_fonts_config_t,$1_fonts_config_t)
-	manage_files_pattern($2,$1_fonts_config_t,$1_fonts_config_t)
-	relabel_files_pattern($2,$1_fonts_config_t,$1_fonts_config_t)
+	manage_dirs_pattern($2,fonts_home_t,fonts_home_t)
+	manage_files_pattern($2,fonts_home_t,fonts_home_t)
+	relabel_dirs_pattern($2,fonts_home_t,fonts_home_t)
+	relabel_files_pattern($2,fonts_home_t,fonts_home_t)
+
+	manage_dirs_pattern($2,fonts_config_t,fonts_config_t)
+	manage_files_pattern($2,fonts_config_t,fonts_config_t)
+	relabel_files_pattern($2,fonts_config_t,fonts_config_t)
 
 	# For startup relabel
-	allow $2 $1_fonts_cache_t:{ dir file } { relabelto relabelfrom };
+	allow $2 fonts_cache_t:{ dir file } { relabelto relabelfrom };
 
 	stream_connect_pattern($2,$1_xserver_tmp_t,$1_xserver_tmp_t,$1_xserver_t)
 
@@ -375,12 +378,12 @@
 	allow $1_xauth_t self:process signal;
 	allow $1_xauth_t self:unix_stream_socket create_stream_socket_perms;
 
-	allow $1_xauth_t $1_xauth_home_t:file manage_file_perms;
-	userdom_user_home_dir_filetrans($1,$1_xauth_t,$1_xauth_home_t,file)
+	allow $1_xauth_t xauth_home_t:file manage_file_perms;
+	userdom_user_home_dir_filetrans($1,$1_xauth_t,xauth_home_t,file)
 
-	manage_dirs_pattern($1_xauth_t,$1_xauth_tmp_t,$1_xauth_tmp_t)
-	manage_files_pattern($1_xauth_t,$1_xauth_tmp_t,$1_xauth_tmp_t)
-	files_tmp_filetrans($1_xauth_t, $1_xauth_tmp_t, { file dir })
+	manage_dirs_pattern($1_xauth_t,xauth_tmp_t,xauth_tmp_t)
+	manage_files_pattern($1_xauth_t,xauth_tmp_t,xauth_tmp_t)
+	files_tmp_filetrans($1_xauth_t, xauth_tmp_t, { file dir })
 
 	domtrans_pattern($2, xauth_exec_t, $1_xauth_t)
 
@@ -389,11 +392,11 @@
 	# allow ps to show xauth
 	ps_process_pattern($2,$1_xauth_t)
 
-	allow $2 $1_xauth_home_t:file manage_file_perms;
-	allow $2 $1_xauth_home_t:file { relabelfrom relabelto };
+	allow $2 xauth_home_t:file manage_file_perms;
+	allow $2 xauth_home_t:file { relabelfrom relabelto };
 
-	allow xdm_t $1_xauth_home_t:file manage_file_perms;
-	userdom_user_home_dir_filetrans($1,xdm_t,$1_xauth_home_t,file)
+	allow xdm_t xauth_home_t:file manage_file_perms;
+	userdom_user_home_dir_filetrans($1,xdm_t,xauth_home_t,file)
 
 	domain_use_interactive_fds($1_xauth_t)
 
@@ -435,16 +438,16 @@
 
 	domtrans_pattern($2, iceauth_exec_t, $1_iceauth_t)
 
-	allow $1_iceauth_t $1_iceauth_home_t:file manage_file_perms;
-	userdom_user_home_dir_filetrans($1,$1_iceauth_t,$1_iceauth_home_t,file)
+	allow $1_iceauth_t iceauth_home_t:file manage_file_perms;
+	userdom_user_home_dir_filetrans($1,$1_iceauth_t,iceauth_home_t,file)
 
 	# allow ps to show iceauth
 	ps_process_pattern($2,$1_iceauth_t)
 
-	allow $2 $1_iceauth_home_t:file manage_file_perms;
-	allow $2 $1_iceauth_home_t:file { relabelfrom relabelto };
+	allow $2 iceauth_home_t:file manage_file_perms;
+	allow $2 iceauth_home_t:file { relabelfrom relabelto };
 
-	allow xdm_t $1_iceauth_home_t:file read_file_perms;
+	allow xdm_t iceauth_home_t:file read_file_perms;
 
 	fs_search_auto_mountpoints($1_iceauth_t)
 
@@ -610,7 +613,7 @@
 #	refpolicywarn(`$0() has been deprecated, please use xserver_user_x_domain_template instead.')
 	gen_require(`
 		type xdm_t, xdm_tmp_t;
-		type $1_xauth_home_t, $1_iceauth_home_t, $1_xserver_t, $1_xserver_tmpfs_t;
+		type xauth_home_t, iceauth_home_t, $1_xserver_t, $1_xserver_tmpfs_t;
 	')
 
 	allow $2 self:shm create_shm_perms;
@@ -618,8 +621,8 @@
 	allow $2 self:unix_stream_socket { connectto create_stream_socket_perms };
 
 	# Read .Xauthority file
-	allow $2 $1_xauth_home_t:file { getattr read };
-	allow $2 $1_iceauth_home_t:file { getattr read };
+	allow $2 xauth_home_t:file { getattr read };
+	allow $2 iceauth_home_t:file { getattr read };
 
 	# for when /tmp/.X11-unix is created by the system
 	allow $2 xdm_t:fd use;
@@ -880,7 +883,7 @@
 template(`xserver_user_x_domain_template',`
 	gen_require(`
 		type xdm_t, xdm_tmp_t;
-		type $1_xauth_home_t, $1_iceauth_home_t, $1_xserver_t, $1_xserver_tmpfs_t;
+		type xauth_home_t, iceauth_home_t, $1_xserver_t, $1_xserver_tmpfs_t;
 	')
 
 	allow $3 self:shm create_shm_perms;
@@ -888,8 +891,8 @@
 	allow $3 self:unix_stream_socket { connectto create_stream_socket_perms };
 
 	# Read .Xauthority file
-	allow $3 $1_xauth_home_t:file { getattr read };
-	allow $3 $1_iceauth_home_t:file { getattr read };
+	allow $3 xauth_home_t:file { getattr read };
+	allow $3 iceauth_home_t:file { getattr read };
 
 	# for when /tmp/.X11-unix is created by the system
 	allow $3 xdm_t:fd use;
@@ -952,26 +955,43 @@
 #
 template(`xserver_use_user_fonts',`
 	gen_require(`
-		type $1_fonts_t, $1_fonts_cache_t, $1_fonts_config_t;
+		type fonts_home_t, fonts_cache_home_t, fonts_config_home_t;
 	')
 
 	# Read per user fonts
-	allow $2 $1_fonts_t:dir list_dir_perms;
-	allow $2 $1_fonts_t:file read_file_perms;
+	read_files_pattern($2, fonts_home_t,  fonts_home_t)
 
 	# Manipulate the global font cache
-	manage_dirs_pattern($2,$1_fonts_cache_t,$1_fonts_cache_t)
-	manage_files_pattern($2,$1_fonts_cache_t,$1_fonts_cache_t)
+	manage_dirs_pattern($2,fonts_cache_home_t,fonts_cache_home_t)
+	manage_files_pattern($2,fonts_cache_home_t,fonts_cache_home_t)
 
 	# Read per user font config
-	allow $2 $1_fonts_config_t:dir list_dir_perms;
-	allow $2 $1_fonts_config_t:file read_file_perms;
+	allow $2 fonts_config_home_t:dir list_dir_perms;
+	allow $2 fonts_config_home_t:file read_file_perms;
 
 	userdom_search_user_home_dirs($1,$2)
 ')
 
 ########################################
 ## <summary>
+##	Get the attributes of xauth executable
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`xserver_getattr_xauth',`
+	gen_require(`
+		type xauth_exec_t;
+	')
+
+	allow $1 xauth_exec_t:file getattr;
+')
+
+########################################
+## <summary>
 ##	Transition to a user Xauthority domain.
 ## </summary>
 ## <desc>
@@ -1005,6 +1025,73 @@
 
 ########################################
 ## <summary>
+##	Read a user Xauthority domain.
+## </summary>
+## <desc>
+##	<p>
+##	read to a user Xauthority domain.
+##	</p>
+##	<p>
+##	This is a templated interface, and should only
+##	be called from a per-userdomain template.
+##	</p>
+## </desc>
+## <param name="userdomain_prefix">
+##	<summary>
+##	The prefix of the user domain (e.g., user
+##	is the prefix for user_t).
+##	</summary>
+## </param>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+template(`xserver_read_user_xauth',`
+	gen_require(`
+		type xauth_home_t;
+	')
+
+	allow $2 xauth_home_t:file { getattr read };
+')
+
+########################################
+## <summary>
+##	Read a user Iceauthority domain.
+## </summary>
+## <desc>
+##	<p>
+##	read to a user Iceauthority domain.
+##	</p>
+##	<p>
+##	This is a templated interface, and should only
+##	be called from a per-userdomain template.
+##	</p>
+## </desc>
+## <param name="userdomain_prefix">
+##	<summary>
+##	The prefix of the user domain (e.g., user
+##	is the prefix for user_t).
+##	</summary>
+## </param>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+template(`xserver_read_user_iceauth',`
+	gen_require(`
+		type iceauth_home_t;
+	')
+
+	# Read .Iceauthority file
+	allow $2 iceauth_home_t:file { getattr read };
+')
+
+########################################
+## <summary>
 ##	Transition to a user Xauthority domain.
 ## </summary>
 ## <desc>
@@ -1030,10 +1117,10 @@
 #
 template(`xserver_user_home_dir_filetrans_user_xauth',`
 	gen_require(`
-		type $1_xauth_home_t;
+		type xauth_home_t;
 	')
 
-	userdom_user_home_dir_filetrans($1, $2, $1_xauth_home_t, file)
+	userdom_user_home_dir_filetrans($1, $2, xauth_home_t, file)
 ')
 
 ########################################
@@ -1219,6 +1306,25 @@
 
 ########################################
 ## <summary>
+##	Connect to apmd over an unix stream socket.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`xserver_stream_connect',`
+	gen_require(`
+		type xdm_xserver_t, xserver_var_run_t;
+	')
+
+	files_search_pids($1)
+	stream_connect_pattern($1,xserver_var_run_t,xserver_var_run_t,xdm_xserver_t)
+')
+
+########################################
+## <summary>
 ##	Read xdm-writable configuration files.
 ## </summary>
 ## <param name="domain">
@@ -1273,6 +1379,7 @@
 	files_search_tmp($1)
 	allow $1 xdm_tmp_t:dir list_dir_perms;
 	create_sock_files_pattern($1,xdm_tmp_t,xdm_tmp_t)
+	allow $1 xdm_tmp_t:sock_file unlink;
 ')
 
 ########################################
@@ -1291,7 +1398,7 @@
 	')
 
 	files_search_pids($1)
-	allow $1 xdm_var_run_t:file read_file_perms;
+	read_files_pattern($1, xdm_var_run_t, xdm_var_run_t)
 ')
 
 ########################################
@@ -1314,6 +1421,24 @@
 
 ########################################
 ## <summary>
+##      dontaudit search of XDM var lib directories.
+## </summary>
+## <param name="domain">
+##      <summary>
+##      Domain allowed access.
+##      </summary>
+## </param>
+#
+interface(`xserver_dontaudit_xdm_lib_search',`
+	gen_require(`
+		type xdm_var_lib_t;
+	')
+
+	dontaudit $1 xdm_var_lib_t:dir search_dir_perms;
+')
+
+########################################
+## <summary>
 ##	Execute the X server in the XDM X server domain.
 ## </summary>
 ## <param name="domain">
@@ -1324,15 +1449,47 @@
 #
 interface(`xserver_domtrans_xdm_xserver',`
 	gen_require(`
-		type xdm_xserver_t, xserver_exec_t;
+		type xdm_xserver_t, xserver_exec_t, xdm_t;
 	')
 
  	allow $1 xdm_xserver_t:process siginh;
+ 	allow xdm_t $1:process sigchld;
 	domtrans_pattern($1,xserver_exec_t,xdm_xserver_t)
 ')
 
 ########################################
 ## <summary>
+##	Execute xsever in the xdm_xserver domain, and
+##	allow the specified role the xdm_xserver domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+## <param name="role">
+##	<summary>
+##	The role to be allowed the xdm_xserver domain.
+##	</summary>
+## </param>
+## <param name="terminal">
+##	<summary>
+##	The type of the terminal allow the xdm_xserver domain to use.
+##	</summary>
+## </param>
+#
+interface(`xserver_run_xdm_xserver',`
+	gen_require(`
+		type xdm_xserver_t;
+	')
+
+	xserver_domtrans_xdm_xserver($1)
+	role $2 types xdm_xserver_t;
+	allow xdm_xserver_t $3:chr_file rw_term_perms;
+')
+
+########################################
+## <summary>
 ##	Make an X session script an entrypoint for the specified domain.
 ## </summary>
 ## <param name="domain">
@@ -1482,7 +1639,7 @@
 		type xdm_xserver_tmp_t;
 	')
 
-	allow $1 xdm_xserver_tmp_t:file { getattr read };
+	read_files_pattern($1,xdm_xserver_tmp_t,xdm_xserver_tmp_t)
 ')
 
 ########################################
@@ -1674,6 +1831,65 @@
 
 ########################################
 ## <summary>
+##	Connect to apmd over an unix stream socket.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`xserver_xdm_stream_connect',`
+	gen_require(`
+		type xdm_t, xdm_var_run_t;
+	')
+
+	files_search_pids($1)
+	allow $1 xdm_var_run_t:sock_file write;
+	allow $1 xdm_t:unix_stream_socket connectto;
+')
+
+########################################
+## <summary>
+##	xdm xserver RW shared memory socket.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`xserver_xdm_rw_shm',`
+	gen_require(`
+		type xdm_xserver_t;
+	')
+
+	allow xdm_xserver_t $1:fd use;
+	allow $1 xdm_xserver_t:shm rw_shm_perms;
+	allow xdm_xserver_t $1:shm rw_shm_perms;
+
+')
+
+########################################
+## <summary>
+##	Ptrace XDM 
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit
+##	</summary>
+## </param>
+#
+interface(`xserver_ptrace_xdm',`
+	gen_require(`
+		type xdm_t;
+	')
+
+	allow $1 xdm_t:process ptrace;
+')
+
+########################################
+## <summary>
 ##	Interface to provide X object permissions on a given X server to
 ##	an X client domain.  Gives the domain complete control over the
 ##	display.
@@ -1691,3 +1907,82 @@
 
 	typeattribute $1 xserver_unconfined_type;
 ')
+
+########################################
+## <summary>
+##	Execute xserver files created in /var/run
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`xserver_exec_pid',`
+	gen_require(`
+		type xserver_var_run_t;
+	')
+
+	files_search_pids($1)
+	exec_files_pattern($1,xserver_var_run_t,xserver_var_run_t)
+')
+
+########################################
+## <summary>
+##	Write xserver files created in /var/run
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`xserver_write_pid',`
+	gen_require(`
+		type xserver_var_run_t;
+	')
+
+	files_search_pids($1)
+	write_files_pattern($1,xserver_var_run_t,xserver_var_run_t)
+')
+
+########################################
+## <summary>
+##	Read user homedir fonts.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`xserver_manage_home_fonts',`
+	gen_require(`
+		type fonts_home_t;
+	')
+
+	manage_dirs_pattern($1, fonts_home_t, fonts_home_t)
+	manage_files_pattern($1, fonts_home_t, fonts_home_t)
+	manage_lnk_files_pattern($1, fonts_home_t, fonts_home_t)
+')
+
+########################################
+## <summary>
+##	Read user homedir fonts.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`xserver_read_home_fonts',`
+	gen_require(`
+		type fonts_home_t;
+	')
+
+	read_files_pattern($1,fonts_home_t,fonts_home_t)
+	read_lnk_files_pattern($1,fonts_home_t,fonts_home_t)
+')
--- nsaserefpolicy/policy/modules/services/xserver.te	2008-05-19 10:26:37.000000000 -0400
+++ serefpolicy-3.4.1/policy/modules/services/xserver.te	2008-05-30 16:26:02.967410000 -0400
@@ -8,6 +8,14 @@
 
 ## <desc>
 ## <p>
+## Allows X clients to read the x devices (keyboard/mouse)
+## </p>
+## </desc>
+gen_tunable(allow_read_x_device,true)
+
+
+## <desc>
+## <p>
 ## Allows clients to write to the X server shared
 ## memory segments.
 ## </p>
@@ -16,6 +24,13 @@
 
 ## <desc>
 ## <p>
+## Allows XServer to execute writable memory
+## </p>
+## </desc>
+gen_tunable(allow_xserver_execmem,false)
+
+## <desc>
+## <p>
 ## Allow xdm logins as sysadm
 ## </p>
 ## </desc>
@@ -92,7 +107,7 @@
 files_lock_file(xdm_lock_t)
 
 type xdm_rw_etc_t;
-files_type(xdm_rw_etc_t)
+files_config_file(xdm_rw_etc_t)
 
 type xdm_var_lib_t;
 files_type(xdm_var_lib_t)
@@ -100,6 +115,12 @@
 type xdm_var_run_t;
 files_pid_file(xdm_var_run_t)
 
+type xserver_var_lib_t;
+files_type(xserver_var_lib_t)
+
+type xserver_var_run_t;
+files_pid_file(xserver_var_run_t)
+
 type xdm_tmp_t;
 files_tmp_file(xdm_tmp_t)
 typealias xdm_tmp_t alias ice_tmp_t;
@@ -122,6 +143,27 @@
 type xserver_log_t;
 logging_log_file(xserver_log_t)
 
+type fonts_cache_home_t, fonts_cache_type;
+userdom_user_home_content(user,fonts_cache_home_t)
+
+type fonts_home_t, fonts_type;
+userdom_user_home_content(user,fonts_home_t)
+
+type fonts_config_home_t, fonts_config_type;
+userdom_user_home_content(user,fonts_config_home_t)
+
+type user_iceauth_home_t;
+userdom_user_home_content(user,user_iceauth_home_t)
+
+type xauth_home_t, xauth_home_type;
+userdom_user_home_content(user,xauth_home_t)
+
+type admin_xauth_home_t;
+files_type(admin_xauth_home_t)
+
+type xauth_tmp_t;
+files_tmp_file(xauth_tmp_t)
+
 xserver_common_domain_template(xdm)
 xserver_common_x_domain_template(xdm,xdm,xdm_t)
 init_system_domain(xdm_xserver_t,xserver_exec_t)
@@ -142,6 +184,7 @@
 
 allow xdm_t self:capability { setgid setuid sys_resource kill sys_tty_config mknod chown dac_override dac_read_search fowner fsetid ipc_owner sys_nice sys_rawio net_bind_service };
 allow xdm_t self:process { setexec setpgid getsched setsched setrlimit signal_perms setkeycreate };
+allow xdm_t self:process { getattr getcap setcap };
 allow xdm_t self:fifo_file rw_fifo_file_perms;
 allow xdm_t self:shm create_shm_perms;
 allow xdm_t self:sem create_sem_perms;
@@ -154,6 +197,8 @@
 allow xdm_t self:key { search link write };
 
 allow xdm_t xconsole_device_t:fifo_file { getattr setattr };
+manage_dirs_pattern(xdm_t, xkb_var_lib_t, xkb_var_lib_t)
+manage_files_pattern(xdm_t, xkb_var_lib_t, xkb_var_lib_t)
 
 # Allow gdm to run gdm-binary
 can_exec(xdm_t, xdm_exec_t)
@@ -169,6 +214,8 @@
 manage_files_pattern(xdm_t,xdm_tmp_t,xdm_tmp_t)
 manage_sock_files_pattern(xdm_t,xdm_tmp_t,xdm_tmp_t)
 files_tmp_filetrans(xdm_t, xdm_tmp_t, { file dir sock_file })
+relabelfrom_dirs_pattern(xdm_t,xdm_tmp_t,xdm_tmp_t)
+relabelfrom_files_pattern(xdm_t,xdm_tmp_t,xdm_tmp_t)
 
 manage_dirs_pattern(xdm_t,xdm_tmpfs_t,xdm_tmpfs_t)
 manage_files_pattern(xdm_t,xdm_tmpfs_t,xdm_tmpfs_t)
@@ -176,15 +223,24 @@
 manage_fifo_files_pattern(xdm_t,xdm_tmpfs_t,xdm_tmpfs_t)
 manage_sock_files_pattern(xdm_t,xdm_tmpfs_t,xdm_tmpfs_t)
 fs_tmpfs_filetrans(xdm_t,xdm_tmpfs_t,{ dir file lnk_file sock_file fifo_file })
+fs_rw_tmpfs_files(xdm_xserver_t)
+fs_getattr_all_fs(xdm_t)
+fs_search_inotifyfs(xdm_t)
+fs_list_all(xdm_t)
+
+manage_files_pattern(xdm_t, fonts_home_t, fonts_home_t)
 
 manage_dirs_pattern(xdm_t,xdm_var_lib_t,xdm_var_lib_t)	
 manage_files_pattern(xdm_t,xdm_var_lib_t,xdm_var_lib_t)
-files_var_lib_filetrans(xdm_t,xdm_var_lib_t,file)
+files_var_lib_filetrans(xdm_t,xdm_var_lib_t,{ file dir })
+# Read machine-id
+files_read_var_lib_files(xdm_t)
 
 manage_dirs_pattern(xdm_t,xdm_var_run_t,xdm_var_run_t)
 manage_files_pattern(xdm_t,xdm_var_run_t,xdm_var_run_t)
 manage_fifo_files_pattern(xdm_t,xdm_var_run_t,xdm_var_run_t)
-files_pid_filetrans(xdm_t,xdm_var_run_t,{ dir file fifo_file })
+manage_sock_files_pattern(xdm_t,xdm_var_run_t,xdm_var_run_t)
+files_pid_filetrans(xdm_t,xdm_var_run_t,{ dir file fifo_file sock_file })
 
 allow xdm_t xdm_xserver_t:process signal;
 allow xdm_t xdm_xserver_t:unix_stream_socket connectto;
@@ -198,6 +254,7 @@
 allow xdm_t xdm_xserver_t:process { noatsecure siginh rlimitinh signal sigkill };
 
 allow xdm_t xdm_xserver_t:shm rw_shm_perms;
+read_files_pattern(xdm_t, xdm_xserver_t, xdm_xserver_t)
 
 # connect to xdm xserver over stream socket
 stream_connect_pattern(xdm_t,xdm_xserver_tmp_t,xdm_xserver_tmp_t,xdm_xserver_t)
@@ -229,6 +286,7 @@
 corenet_udp_sendrecv_all_ports(xdm_t)
 corenet_tcp_bind_all_nodes(xdm_t)
 corenet_udp_bind_all_nodes(xdm_t)
+corenet_udp_bind_xdmcp_port(xdm_t)
 corenet_tcp_connect_all_ports(xdm_t)
 corenet_sendrecv_all_client_packets(xdm_t)
 # xdm tries to bind to biff_port_t
@@ -241,6 +299,7 @@
 dev_getattr_mouse_dev(xdm_t)
 dev_setattr_mouse_dev(xdm_t)
 dev_rw_apm_bios(xdm_t)
+dev_rw_input_dev(xdm_t)
 dev_setattr_apm_bios_dev(xdm_t)
 dev_rw_dri(xdm_t)
 dev_rw_agp(xdm_t)
@@ -253,14 +312,15 @@
 dev_setattr_video_dev(xdm_t)
 dev_getattr_scanner_dev(xdm_t)
 dev_setattr_scanner_dev(xdm_t)
-dev_getattr_sound_dev(xdm_t)
-dev_setattr_sound_dev(xdm_t)
+dev_read_sound(xdm_t)
+dev_write_sound(xdm_t)
 dev_getattr_power_mgmt_dev(xdm_t)
 dev_setattr_power_mgmt_dev(xdm_t)
 
 domain_use_interactive_fds(xdm_t)
 # Do not audit denied probes of /proc.
 domain_dontaudit_read_all_domains_state(xdm_t)
+domain_dontaudit_ptrace_all_domains(xdm_t)
 
 files_read_etc_files(xdm_t)
 files_read_var_files(xdm_t)
@@ -271,9 +331,13 @@
 files_read_usr_files(xdm_t)
 # Poweroff wants to create the /poweroff file when run from xdm
 files_create_boot_flag(xdm_t)
+files_dontaudit_getattr_boot_dirs(xdm_t)
+files_dontaudit_write_usr_files(xdm_t)
 
 fs_getattr_all_fs(xdm_t)
 fs_search_auto_mountpoints(xdm_t)
+fs_rw_anon_inodefs_files(xdm_t)
+fs_mount_tmpfs(xdm_t)
 
 storage_dontaudit_read_fixed_disk(xdm_t)
 storage_dontaudit_write_fixed_disk(xdm_t)
@@ -282,6 +346,7 @@
 storage_dontaudit_raw_write_removable_device(xdm_t)
 storage_dontaudit_setattr_removable_dev(xdm_t)
 storage_dontaudit_rw_scsi_generic(xdm_t)
+storage_dontaudit_rw_fuse(xdm_t)
 
 term_setattr_console(xdm_t)
 term_use_unallocated_ttys(xdm_t)
@@ -290,6 +355,7 @@
 auth_domtrans_pam_console(xdm_t)
 auth_manage_pam_pid(xdm_t)
 auth_manage_pam_console_data(xdm_t)
+auth_signal_pam(xdm_t)
 auth_rw_faillog(xdm_t)
 auth_write_login_records(xdm_t)
 
@@ -301,21 +367,25 @@
 libs_exec_lib_files(xdm_t)
 
 logging_read_generic_logs(xdm_t)
+logging_send_audit_msgs(xdm_t)
 
 miscfiles_read_localization(xdm_t)
 miscfiles_read_fonts(xdm_t)
-
-sysnet_read_config(xdm_t)
+miscfiles_manage_localization(xdm_t)
 
 userdom_dontaudit_use_unpriv_user_fds(xdm_t)
 userdom_create_all_users_keys(xdm_t)
 # for .dmrc
-userdom_read_unpriv_users_home_content_files(xdm_t)
+unprivuser_read_home_content_files(xdm_t)
+unprivuser_dontaudit_write_home_content_files(xdm_t)
+
 # Search /proc for any user domain processes.
 userdom_read_all_users_state(xdm_t)
 userdom_signal_all_users(xdm_t)
-
-sysadm_dontaudit_search_home_dirs(xdm_t)
+#
+# Wants to delete .xsession-errors file
+#
+userdom_unlink_unpriv_users_home_content_files(xdm_t)
 
 xserver_rw_session_template(xdm,xdm_t,xdm_tmpfs_t)
 xserver_unconfined(xdm_t)
@@ -348,10 +418,12 @@
 
 optional_policy(`
 	alsa_domtrans(xdm_t)
+	alsa_read_rw_config(xdm_t)
 ')
 
 optional_policy(`
 	consolekit_dbus_chat(xdm_t)
+	consolekit_read_log(xdm_t)
 ')
 
 optional_policy(`
@@ -359,6 +431,19 @@
 ')
 
 optional_policy(`
+	dbus_per_role_template(xdm, xdm_t, system_r)
+	dbus_system_bus_client_template(xdm, xdm_t)
+
+	optional_policy(`
+		hal_dbus_chat(xdm_t)
+	')
+
+	optional_policy(`
+		networkmanager_dbus_chat(xdm_t)
+	')
+')
+
+optional_policy(`
 	# Talk to the console mouse server.
 	gpm_stream_connect(xdm_t)
 	gpm_setattr_gpmctl(xdm_t)
@@ -369,6 +454,10 @@
 ')
 
 optional_policy(`
+	gnome_exec_gconf(xdm_t)
+')
+
+optional_policy(`
 	loadkeys_exec(xdm_t)
 ')
 
@@ -382,16 +471,25 @@
 ')
 
 optional_policy(`
+	polkit_domtrans_auth(xdm_t)
+	polkit_read_lib(xdm_t)
+')
+
+optional_policy(`
 	seutil_sigchld_newrole(xdm_t)
 ')
 
 optional_policy(`
+	sysadm_dontaudit_search_home_dirs(xdm_t)
+')
+
+optional_policy(`
 	udev_read_db(xdm_t)
 ')
 
 optional_policy(`
-	unconfined_domain(xdm_t)
 	unconfined_domtrans(xdm_t)
+	unconfined_signal(xdm_t)
 
 	ifndef(`distro_redhat',`
 		allow xdm_t self:process { execheap execmem };
@@ -427,7 +525,7 @@
 allow xdm_xserver_t xdm_var_lib_t:file { getattr read };
 dontaudit xdm_xserver_t xdm_var_lib_t:dir search;
 
-allow xdm_xserver_t xdm_var_run_t:file { getattr read };
+read_files_pattern(xdm_xserver_t,xdm_var_run_t,xdm_var_run_t)
 
 # Label pid and temporary files with derived types.
 manage_files_pattern(xdm_xserver_t,xdm_tmp_t,xdm_tmp_t)
@@ -439,6 +537,15 @@
 can_exec(xdm_xserver_t, xkb_var_lib_t)
 files_search_var_lib(xdm_xserver_t)
 
+manage_dirs_pattern(xdm_xserver_t,xserver_var_lib_t,xserver_var_lib_t)	
+manage_files_pattern(xdm_xserver_t,xserver_var_lib_t,xserver_var_lib_t)
+files_var_lib_filetrans(xdm_xserver_t,xserver_var_lib_t,dir)
+
+manage_dirs_pattern(xdm_xserver_t,xserver_var_run_t,xserver_var_run_t)	
+manage_files_pattern(xdm_xserver_t,xserver_var_run_t,xserver_var_run_t)
+manage_sock_files_pattern(xdm_xserver_t,xdm_var_run_t,xdm_var_run_t)
+files_pid_filetrans(xdm_xserver_t,xserver_var_run_t,{ dir file })
+
 # VNC v4 module in X server
 corenet_tcp_bind_vnc_port(xdm_xserver_t)
 
@@ -450,10 +557,19 @@
 # xdm_xserver_t may no longer have any reason
 # to read ROLE_home_t - examine this in more detail
 # (xauth?)
-userdom_read_unpriv_users_home_content_files(xdm_xserver_t)
+unprivuser_read_home_content_files(xdm_xserver_t)
+unprivuser_manage_tmp_files(xdm_xserver_t)
 
 xserver_use_all_users_fonts(xdm_xserver_t)
 
+getty_use_fds(xdm_xserver_t)
+locallogin_use_fds(xdm_xserver_t)
+userdom_dontaudit_write_user_home_content_files(user, xdm_xserver_t)
+
+optional_policy(`
+	userhelper_search_config(xdm_xserver_t)
+')
+
 tunable_policy(`use_nfs_home_dirs',`
 	fs_manage_nfs_dirs(xdm_xserver_t)
 	fs_manage_nfs_files(xdm_xserver_t)
@@ -467,6 +583,22 @@
 ')
 
 optional_policy(`
+	dbus_system_bus_client_template(xdm_xserver, xdm_xserver_t)
+
+	optional_policy(`
+		hal_dbus_chat(xdm_xserver_t)
+	')
+')
+
+optional_policy(`
+	locallogin_use_fds(xdm_xserver_t)
+')
+
+optional_policy(`
+	mono_rw_shm(xdm_xserver_t)
+')
+
+optional_policy(`
 	resmgr_stream_connect(xdm_t)
 ')
 
@@ -476,16 +608,32 @@
 ')
 
 optional_policy(`
-	unconfined_domain_noaudit(xdm_xserver_t)
-	unconfined_domtrans(xdm_xserver_t)
+	rpm_dontaudit_rw_shm(xdm_xserver_t)
+	rpm_rw_tmpfs_files(xdm_xserver_t)
+')
 
-	ifndef(`distro_redhat',`
-		allow xdm_xserver_t self:process { execheap execmem };
-	')
+optional_policy(`
+	unconfined_rw_shm(xdm_xserver_t)
+	unconfined_execmem_rw_shm(xdm_xserver_t)
+	unconfined_rw_tmpfs_files(xdm_xserver_t)
 
-	ifdef(`distro_rhel4',`
-		allow xdm_xserver_t self:process { execheap execmem };
-	')
+	# xserver signals unconfined user on startx
+	unconfined_signal(xdm_xserver_t)
+	unconfined_getpgid(xdm_xserver_t)
+	unconfined_domain(xdm_xserver_t)
+')
+
+
+tunable_policy(`allow_xserver_execmem', `
+	allow xdm_xserver_t self:process { execheap execmem execstack };
+')
+
+ifndef(`distro_redhat',`
+	allow xdm_xserver_t self:process { execheap execmem };
+')
+
+ifdef(`distro_rhel4',`
+	allow xdm_xserver_t self:process { execheap execmem };
 ')
 
 ########################################

--------------070806010208030304070805
Content-Type: application/pgp-signature;
 name="services_xserver.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="services_xserver.patch.sig"

iEYEABECAAYFAkhAZmQACgkQrlYvE4MpobPRgACfUheRopRIf1K/k+aXCFldKR6NPh8AoONR
ep13j9FSKEhSzf8THRtTbzXH
--------------070806010208030304070805--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

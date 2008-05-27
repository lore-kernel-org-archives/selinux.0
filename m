Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4RBtUcP008302
	for <selinux@tycho.nsa.gov>; Tue, 27 May 2008 07:55:30 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4RBtTJm000670
	for <selinux@tycho.nsa.gov>; Tue, 27 May 2008 11:55:29 GMT
Message-ID: <483BF664.7040301@redhat.com>
Date: Tue, 27 May 2008 07:54:12 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: New domain for podsleuth
References: <4831B4AE.4010604@comcast.net> <1211816164.11188.178.camel@gorn.columbia.tresys.com>
In-Reply-To: <1211816164.11188.178.camel@gorn.columbia.tresys.com>
Content-Type: multipart/mixed;
 boundary="------------090101050206030009080202"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090101050206030009080202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christopher J. PeBenito wrote:
| On Mon, 2008-05-19 at 13:11 -0400, Daniel J Walsh wrote:
|> +hal_dbus_chat(podsleuth_t)
|> +
|> +optional_policy(`
|> +	dbus_system_bus_client_template(podsleuth,podsleuth_t)
|> +')
|
| Seems that either the hal dbus should go in the optional or dbus should
| become unconditional.  My guess is unconditional(?)
|
|> +gen_require(`
|> +	type hald_t;
|> +')
|> +
|> +podsleuth_domtrans(hald_t)
|
| :(
|
Update podsleuth patch along with patch for hal and policykit to make it
all work.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkg79mMACgkQrlYvE4MpobO95QCgiXA/qYDugExn2o4HpNguslxJ
t3QAn1VVacDYJCGOTmOWk8b/B7/B3DZD
=TbJq
-----END PGP SIGNATURE-----

--------------090101050206030009080202
Content-Type: text/plain;
 name="services_hal.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="services_hal.patch"

Subject: [PATCH] refpolicy: services_hal changes
--text follows this line--
--- nsaserefpolicy/policy/modules/services/hal.fc	2007-11-14 08:17:58.000000000 -0500
+++ serefpolicy-3.4.1/policy/modules/services/hal.fc	2008-05-27 07:34:21.000000000 -0400
@@ -8,6 +8,7 @@
 /usr/libexec/hal-hotplug-map 		--	gen_context(system_u:object_r:hald_exec_t,s0)
 /usr/libexec/hal-system-sonypic	 	--	gen_context(system_u:object_r:hald_sonypic_exec_t,s0)
 /usr/libexec/hald-addon-macbookpro-backlight --	gen_context(system_u:object_r:hald_mac_exec_t,s0)
+/usr/libexec/hald-addon-macbook-backlight --	gen_context(system_u:object_r:hald_mac_exec_t,s0)
 
 /usr/sbin/hald		--			gen_context(system_u:object_r:hald_exec_t,s0)
 
@@ -16,10 +17,13 @@
 /var/lib/hal(/.*)?				gen_context(system_u:object_r:hald_var_lib_t,s0)
 
 /var/log/pm-suspend\.log			gen_context(system_u:object_r:hald_log_t,s0)
+/var/log/pm(/.*)?				gen_context(system_u:object_r:hald_log_t,s0)
 
+/var/run/pm(/.*)?				gen_context(system_u:object_r:hald_var_run_t,s0)
+/var/run/pm-utils(/.*)?				gen_context(system_u:object_r:hald_var_run_t,s0)
+/var/run/hald(/.*)?				gen_context(system_u:object_r:hald_var_run_t,s0)
 /var/run/haldaemon\.pid	--	 		gen_context(system_u:object_r:hald_var_run_t,s0)
-/var/run/vbestate 	--			gen_context(system_u:object_r:hald_var_run_t,s0)
-
+/var/run/vbe.*	 	--			gen_context(system_u:object_r:hald_var_run_t,s0)
 ifdef(`distro_gentoo',`
 /var/lib/cache/hald(/.*)?			gen_context(system_u:object_r:hald_cache_t,s0)
 ')
--- nsaserefpolicy/policy/modules/services/hal.if	2008-05-09 11:59:10.000000000 -0400
+++ serefpolicy-3.4.1/policy/modules/services/hal.if	2008-05-27 07:34:21.000000000 -0400
@@ -195,7 +195,7 @@
 ## </summary>
 ## <param name="domain">
 ##	<summary>
-##	Domain allowed access.
+##	Domain to not audit
 ##	</summary>
 ## </param>
 #
@@ -302,3 +302,42 @@
 	files_search_pids($1)
 	allow $1 hald_var_run_t:file rw_file_perms;
 ')
+
+########################################
+## <summary>
+##	Send a SIGCHLD signal to hal.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`hal_getattr',`
+	gen_require(`
+		type hald_t;
+	')
+
+	allow $1 hald_t:process getattr;
+')
+
+########################################
+## <summary>
+##f	Read hal system state
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`hal_read_state',`
+	gen_require(`
+		type hald_t;
+	')
+	kernel_search_proc($1)
+	allow $1 hald_t:dir list_dir_perms;
+	read_files_pattern($1,hald_t,hald_t)
+	read_lnk_files_pattern($1,hald_t,hald_t)
+	dontaudit $1 hald_t:process ptrace;
+')
--- nsaserefpolicy/policy/modules/services/hal.te	2008-05-09 11:59:10.000000000 -0400
+++ serefpolicy-3.4.1/policy/modules/services/hal.te	2008-05-27 07:45:46.000000000 -0400
@@ -49,6 +49,9 @@
 type hald_var_lib_t;
 files_type(hald_var_lib_t)
 
+typealias hald_log_t alias pmtools_log_t;
+typealias hald_var_run_t alias pmtools_var_run_t;
+
 ########################################
 #
 # Local policy
@@ -57,7 +60,7 @@
 # execute openvt which needs setuid
 allow hald_t self:capability { chown setuid setgid kill net_admin sys_admin sys_nice dac_override dac_read_search mknod sys_rawio sys_tty_config };
 dontaudit hald_t self:capability {sys_ptrace sys_tty_config };
-allow hald_t self:process signal_perms;
+allow hald_t self:process { getattr signal_perms };
 allow hald_t self:fifo_file rw_fifo_file_perms;
 allow hald_t self:unix_stream_socket { create_stream_socket_perms connectto };
 allow hald_t self:unix_dgram_socket create_socket_perms;
@@ -70,7 +73,7 @@
 manage_files_pattern(hald_t,hald_cache_t,hald_cache_t)
 
 # log files for hald
-allow hald_t hald_log_t:file manage_file_perms;
+manage_files_pattern(hald_t, hald_log_t, hald_log_t)
 logging_log_filetrans(hald_t,hald_log_t,file)
 
 manage_dirs_pattern(hald_t,hald_tmp_t,hald_tmp_t)
@@ -82,8 +85,9 @@
 manage_files_pattern(hald_t,hald_var_lib_t,hald_var_lib_t)
 manage_sock_files_pattern(hald_t,hald_var_lib_t,hald_var_lib_t)
 
+manage_dirs_pattern(hald_t,hald_var_run_t,hald_var_run_t)
 manage_files_pattern(hald_t,hald_var_run_t,hald_var_run_t)
-files_pid_filetrans(hald_t,hald_var_run_t,file)
+files_pid_filetrans(hald_t,hald_var_run_t,{ dir file })
 
 kernel_read_system_state(hald_t)
 kernel_read_network_state(hald_t)
@@ -93,6 +97,7 @@
 kernel_rw_irq_sysctls(hald_t)
 kernel_rw_vm_sysctls(hald_t)
 kernel_write_proc_files(hald_t)
+kernel_setsched(hald_t)
 
 auth_read_pam_console_data(hald_t)
 
@@ -121,6 +126,7 @@
 dev_rw_power_management(hald_t)
 # hal is now execing pm-suspend
 dev_rw_sysfs(hald_t)
+dev_read_video_dev(hald_t)
 
 domain_use_interactive_fds(hald_t)
 domain_read_all_domains_state(hald_t)
@@ -155,6 +161,8 @@
 selinux_compute_relabel_context(hald_t)
 selinux_compute_user_contexts(hald_t)
 
+dev_read_raw_memory(hald_t)
+
 storage_raw_read_removable_device(hald_t)
 storage_raw_write_removable_device(hald_t)
 storage_raw_read_fixed_disk(hald_t)
@@ -172,6 +180,8 @@
 init_rw_utmp(hald_t)
 init_telinit(hald_t)
 
+fstools_getattr_swap_files(hald_t)
+
 libs_use_ld_so(hald_t)
 libs_use_shared_libs(hald_t)
 libs_exec_ld_so(hald_t)
@@ -245,6 +255,10 @@
 ')
 
 optional_policy(`
+	gpm_dontaudit_getattr_gpmctl(hald_t)
+')
+
+optional_policy(`
 	hotplug_read_config(hald_t)
 ')
 
@@ -266,6 +280,15 @@
 ')
 
 optional_policy(`
+	podsleuth_domtrans(hald_t)
+')
+
+optional_policy(`
+	polkit_domtrans_auth(hald_t)
+	polkit_read_lib(hald_t)
+')
+
+optional_policy(`
 	rpc_search_nfs_state_data(hald_t)
 ')
 
@@ -292,7 +315,8 @@
 #
 
 allow hald_acl_t self:capability { dac_override fowner };
-allow hald_acl_t self:fifo_file read_fifo_file_perms;
+allow hald_acl_t self:process { getattr signal };
+allow hald_acl_t self:fifo_file rw_fifo_file_perms;
 
 domtrans_pattern(hald_t, hald_acl_exec_t, hald_acl_t)
 allow hald_t hald_acl_t:process signal;
@@ -302,9 +326,14 @@
 manage_files_pattern(hald_acl_t,hald_var_lib_t,hald_var_lib_t)
 files_search_var_lib(hald_acl_t)
 
+manage_dirs_pattern(hald_acl_t,hald_var_run_t,hald_var_run_t)
+manage_files_pattern(hald_acl_t,hald_var_run_t,hald_var_run_t)
+files_pid_filetrans(hald_acl_t,hald_var_run_t,{ dir file })
+
 corecmd_exec_bin(hald_acl_t)
 
 dev_getattr_all_chr_files(hald_acl_t)
+dev_setattr_all_chr_files(hald_acl_t)
 dev_getattr_generic_usb_dev(hald_acl_t)
 dev_getattr_video_dev(hald_acl_t)
 dev_setattr_video_dev(hald_acl_t)
@@ -326,6 +355,11 @@
 
 miscfiles_read_localization(hald_acl_t)
 
+optional_policy(`
+	polkit_domtrans_auth(hald_acl_t)
+	polkit_read_lib(hald_acl_t)
+')
+
 ########################################
 #
 # Local hald mac policy
@@ -339,10 +373,14 @@
 manage_files_pattern(hald_mac_t,hald_var_lib_t,hald_var_lib_t)
 files_search_var_lib(hald_mac_t)
 
+dev_read_raw_memory(hald_mac_t)
 dev_write_raw_memory(hald_mac_t)
+dev_read_sysfs(hald_mac_t)
 
 files_read_usr_files(hald_mac_t)
 
+kernel_read_system_state(hald_mac_t)
+
 libs_use_ld_so(hald_mac_t)
 libs_use_shared_libs(hald_mac_t)
 
@@ -392,3 +430,7 @@
 libs_use_shared_libs(hald_keymap_t)
 
 miscfiles_read_localization(hald_keymap_t)
+
+# This is caused by a bug in hald and PolicyKit.  
+# Should be removed when this is fixed
+cron_read_system_job_lib_files(hald_t)

--------------090101050206030009080202
Content-Type: text/plain;
 name="services_podsleuth.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="services_podsleuth.patch"

Subject: [PATCH] refpolicy: services_podsleuth changes
--text follows this line--
--- nsaserefpolicy/policy/modules/services/podsleuth.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.4.1/policy/modules/services/podsleuth.fc	2008-05-27 07:34:21.000000000 -0400
@@ -0,0 +1,2 @@
+
+/usr/bin/podsleuth	--	gen_context(system_u:object_r:podsleuth_exec_t,s0)
--- nsaserefpolicy/policy/modules/services/podsleuth.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.4.1/policy/modules/services/podsleuth.if	2008-05-27 07:34:21.000000000 -0400
@@ -0,0 +1,54 @@
+
+## <summary>policy for podsleuth</summary>
+
+########################################
+## <summary>
+##	Execute a domain transition to run podsleuth.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`podsleuth_domtrans',`
+	gen_require(`
+		type podsleuth_t;
+                type podsleuth_exec_t;
+	')
+
+	domtrans_pattern($1,podsleuth_exec_t,podsleuth_t)
+')
+
+
+########################################
+## <summary>
+##	Execute podsleuth in the podsleuth domain, and
+##	allow the specified role the podsleuth domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access
+##	</summary>
+## </param>
+## <param name="role">
+##	<summary>
+##	The role to be allowed the podsleuth domain.
+##	</summary>
+## </param>
+## <param name="terminal">
+##	<summary>
+##	The type of the role's terminal.
+##	</summary>
+## </param>
+#
+interface(`podsleuth_run',`
+	gen_require(`
+		type podsleuth_t;
+	')
+
+	podsleuth_domtrans($1)
+	role $2 types podsleuth_t;
+	dontaudit podsleuth_t $3:chr_file rw_term_perms;
+')
+
--- nsaserefpolicy/policy/modules/services/podsleuth.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.4.1/policy/modules/services/podsleuth.te	2008-05-27 07:45:08.000000000 -0400
@@ -0,0 +1,37 @@
+policy_module(podsleuth,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type podsleuth_t;
+type podsleuth_exec_t;
+application_domain(podsleuth_t, podsleuth_exec_t)
+role system_r types podsleuth_t;
+
+########################################
+#
+# podsleuth local policy
+#
+allow podsleuth_t self:process { ptrace signal getsched execheap execmem };
+
+## internal communication is often done using fifo and unix sockets.
+allow podsleuth_t self:fifo_file rw_file_perms;
+allow podsleuth_t self:unix_stream_socket create_stream_socket_perms;
+
+dev_read_urand(podsleuth_t)
+
+kernel_read_system_state(podsleuth_t)
+
+files_read_etc_files(podsleuth_t)
+
+libs_use_ld_so(podsleuth_t)
+libs_use_shared_libs(podsleuth_t)
+
+miscfiles_read_localization(podsleuth_t)
+
+mono_exec(podsleuth_t)
+
+hal_dbus_chat(podsleuth_t)
+dbus_system_bus_client_template(podsleuth,podsleuth_t)

--------------090101050206030009080202
Content-Type: text/plain;
 name="services_polkit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="services_polkit.patch"

Subject: [PATCH] refpolicy: services_polkit changes
--text follows this line--
--- nsaserefpolicy/policy/modules/services/polkit.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.4.1/policy/modules/services/polkit.fc	2008-05-27 07:34:21.000000000 -0400
@@ -0,0 +1,9 @@
+
+/usr/libexec/polkit-read-auth-helper	--	gen_context(system_u:object_r:polkit_auth_exec_t,s0)
+/usr/libexec/polkit-grant-helper.*	--	gen_context(system_u:object_r:polkit_grant_exec_t,s0)
+/usr/libexec/polkit-resolve-exe-helper.* --	gen_context(system_u:object_r:polkit_resolve_exec_t,s0)
+/usr/libexec/polkitd			--	gen_context(system_u:object_r:polkit_exec_t,s0)
+
+/var/lib/PolicyKit(/.*)?			gen_context(system_u:object_r:polkit_var_lib_t,s0)
+/var/run/PolicyKit(/.*)?			gen_context(system_u:object_r:polkit_var_run_t,s0)
+/var/lib/PolicyKit-public(/.*)?			gen_context(system_u:object_r:polkit_var_lib_t,s0)
--- nsaserefpolicy/policy/modules/services/polkit.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.4.1/policy/modules/services/polkit.if	2008-05-27 07:34:21.000000000 -0400
@@ -0,0 +1,208 @@
+
+## <summary>policy for polkit_auth</summary>
+
+########################################
+## <summary>
+##	Execute a domain transition to run polkit_auth.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`polkit_domtrans_auth',`
+	gen_require(`
+		type polkit_auth_t;
+                type polkit_auth_exec_t;
+	')
+
+	domtrans_pattern($1,polkit_auth_exec_t,polkit_auth_t)
+')
+
+########################################
+## <summary>
+##	Search polkit lib directories.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`polkit_search_lib',`
+	gen_require(`
+		type polkit_var_lib_t;
+	')
+
+	allow $1 polkit_var_lib_t:dir search_dir_perms;
+	files_search_var_lib($1)
+')
+
+########################################
+## <summary>
+##	read polkit lib files
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`polkit_read_lib',`
+	gen_require(`
+		type polkit_var_lib_t;
+	')
+
+	files_search_var_lib($1)
+	read_files_pattern($1, polkit_var_lib_t,  polkit_var_lib_t)
+
+	# Broken placement
+	cron_read_system_job_lib_files($1)
+')
+
+########################################
+## <summary>
+##	Execute a domain transition to run polkit_grant.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`polkit_domtrans_grant',`
+	gen_require(`
+		type polkit_grant_t;
+                type polkit_grant_exec_t;
+	')
+
+	domtrans_pattern($1,polkit_grant_exec_t,polkit_grant_t)
+')
+
+########################################
+## <summary>
+##	Execute a domain transition to run polkit_resolve.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`polkit_domtrans_resolve',`
+	gen_require(`
+		type polkit_resolve_t;
+                type polkit_resolve_exec_t;
+	')
+
+	domtrans_pattern($1,polkit_resolve_exec_t,polkit_resolve_t)
+')
+
+########################################
+## <summary>
+##	Execute a policy_grant in the policy_grant domain, and
+##	allow the specified role the policy_grant domain,
+##	and use the caller's terminal.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <param name="role">
+##	<summary>
+##	The role to be allowed the load_policy domain.
+##	</summary>
+## </param>
+## <param name="terminal">
+##	<summary>
+##	The type of the terminal allow the load_policy domain to use.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`polkit_run_grant',`
+	gen_require(`
+		type polkit_grant_t;
+	')
+
+	polkit_domtrans_grant($1)
+	role $2 types polkit_grant_t;
+	allow polkit_grant_t $3:chr_file rw_term_perms;
+	allow $1 polkit_grant_t:process signal;
+	read_files_pattern(polkit_grant_t, $1, $1)
+	allow polkit_grant_t $1:process getattr;
+')
+
+########################################
+## <summary>
+##	Execute a policy_auth in the policy_auth domain, and
+##	allow the specified role the policy_auth domain,
+##	and use the caller's terminal.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <param name="role">
+##	<summary>
+##	The role to be allowed the load_policy domain.
+##	</summary>
+## </param>
+## <param name="terminal">
+##	<summary>
+##	The type of the terminal allow the load_policy domain to use.
+##	</summary>
+## </param>
+#
+interface(`polkit_run_auth',`
+	gen_require(`
+		type polkit_auth_t;
+	')
+
+	polkit_domtrans_auth($1)
+	role $2 types polkit_auth_t;
+	allow polkit_auth_t $3:chr_file rw_term_perms;
+')
+
+#######################################
+## <summary>
+##	The per role template for the nsplugin module.
+## </summary>
+## <desc>
+##	<p>
+##	This template creates a derived domains which are used
+##	for nsplugin web browser.
+##	</p>
+##	<p>
+##	This template is invoked automatically for each user, and
+##	generally does not need to be invoked directly
+##	by policy writers.
+##	</p>
+## </desc>
+## <param name="userdomain_prefix">
+##	<summary>
+##	The prefix of the user domain (e.g., user
+##	is the prefix for user_t).
+##	</summary>
+## </param>
+## <param name="user_domain">
+##	<summary>
+##	The type of the user domain.
+##	</summary>
+## </param>
+## <param name="user_role">
+##	<summary>
+##	The role associated with the user domain.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+template(`polkit_per_role_template',`
+	polkit_run_auth($2, $3, { $1_devpts_t $1_tty_device_t })
+	polkit_run_grant($2, $3, { $1_devpts_t $1_tty_device_t })
+	polkit_read_lib($2)
+')
+
--- nsaserefpolicy/policy/modules/services/polkit.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.4.1/policy/modules/services/polkit.te	2008-05-27 07:34:21.000000000 -0400
@@ -0,0 +1,195 @@
+policy_module(polkit_auth,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type polkit_t;
+type polkit_exec_t;
+init_daemon_domain(polkit_t, polkit_exec_t)
+
+type polkit_grant_t;
+type polkit_grant_exec_t;
+init_system_domain(polkit_grant_t, polkit_grant_exec_t)
+
+type polkit_resolve_t;
+type polkit_resolve_exec_t;
+init_system_domain(polkit_resolve_t, polkit_resolve_exec_t)
+
+type polkit_auth_t;
+type polkit_auth_exec_t;
+init_daemon_domain(polkit_auth_t, polkit_auth_exec_t)
+
+type polkit_var_lib_t;
+files_type(polkit_var_lib_t)
+
+type polkit_var_run_t;
+files_pid_file(polkit_var_run_t)
+
+########################################
+#
+# polkit local policy
+#
+
+allow polkit_t self:capability setgid;
+allow polkit_t self:process getattr;
+
+allow polkit_t self:unix_dgram_socket create_socket_perms;
+allow polkit_t self:fifo_file rw_file_perms;
+allow polkit_t self:unix_stream_socket create_stream_socket_perms;
+
+can_exec(polkit_t, polkit_exec_t)
+corecmd_exec_bin(polkit_t)
+
+domain_use_interactive_fds(polkit_t)
+
+files_read_etc_files(polkit_t)
+files_read_usr_files(polkit_t)
+
+fs_list_inotifyfs(polkit_t)
+
+kernel_read_kernel_sysctls(polkit_t)
+
+auth_use_nsswitch(polkit_t)
+
+libs_use_ld_so(polkit_t)
+libs_use_shared_libs(polkit_t)
+
+miscfiles_read_localization(polkit_t)
+
+logging_send_syslog_msg(polkit_t)
+
+manage_files_pattern(polkit_t, polkit_var_lib_t, polkit_var_lib_t)
+
+# pid file
+manage_dirs_pattern(polkit_t,polkit_var_run_t,polkit_var_run_t)
+manage_files_pattern(polkit_t,polkit_var_run_t,polkit_var_run_t)
+files_pid_filetrans(polkit_t,polkit_var_run_t, { file dir })
+
+optional_policy(`
+	dbus_system_domain(polkit_t, polkit_exec_t)
+	optional_policy(`
+		consolekit_dbus_chat(polkit_t)
+	')
+')
+
+########################################
+#
+# polkit_auth local policy
+#
+
+allow polkit_auth_t self:capability setgid;
+allow polkit_auth_t self:process { getattr };
+
+allow polkit_auth_t self:unix_dgram_socket create_socket_perms;
+allow polkit_auth_t self:fifo_file rw_file_perms;
+allow polkit_auth_t self:unix_stream_socket create_stream_socket_perms;
+
+can_exec(polkit_auth_t, polkit_auth_exec_t)
+corecmd_search_bin(polkit_auth_t)
+
+domain_use_interactive_fds(polkit_auth_t)
+
+files_read_etc_files(polkit_auth_t)
+files_read_usr_files(polkit_auth_t)
+
+auth_use_nsswitch(polkit_auth_t)
+
+libs_use_ld_so(polkit_auth_t)
+libs_use_shared_libs(polkit_auth_t)
+
+miscfiles_read_localization(polkit_auth_t)
+
+logging_send_syslog_msg(polkit_auth_t)
+
+manage_files_pattern(polkit_auth_t, polkit_var_lib_t, polkit_var_lib_t)
+
+# pid file
+manage_dirs_pattern(polkit_auth_t,polkit_var_run_t,polkit_var_run_t)
+manage_files_pattern(polkit_auth_t,polkit_var_run_t,polkit_var_run_t)
+files_pid_filetrans(polkit_auth_t,polkit_var_run_t, { file dir })
+
+unprivuser_append_home_content_files(polkit_auth_t)
+unprivuser_dontaudit_read_home_content_files(polkit_auth_t)
+
+optional_policy(`
+	dbus_system_bus_client_template(polkit_auth, polkit_auth_t)
+	consolekit_dbus_chat(polkit_auth_t)
+	dbus_system_domain(polkit_exec_t, polkit_t)
+')
+
+optional_policy(`
+	hal_getattr(polkit_auth_t)
+	hal_read_state(polkit_auth_t)
+')
+
+########################################
+#
+# polkit_grant local policy
+#
+
+allow polkit_grant_t self:capability setuid;
+allow polkit_grant_t self:process getattr;
+
+allow polkit_grant_t self:unix_dgram_socket create_socket_perms;
+allow polkit_grant_t self:fifo_file rw_file_perms;
+allow polkit_grant_t self:unix_stream_socket create_stream_socket_perms;
+
+can_exec(polkit_grant_t, polkit_grant_exec_t)
+corecmd_search_bin(polkit_grant_t)
+
+files_read_etc_files(polkit_grant_t)
+files_read_usr_files(polkit_grant_t)
+
+auth_use_nsswitch(polkit_grant_t)
+auth_domtrans_chk_passwd(polkit_grant_t)
+
+libs_use_ld_so(polkit_grant_t)
+libs_use_shared_libs(polkit_grant_t)
+
+miscfiles_read_localization(polkit_grant_t)
+
+logging_send_syslog_msg(polkit_grant_t)
+
+polkit_domtrans_auth(polkit_grant_t)
+
+manage_files_pattern(polkit_grant_t, polkit_var_lib_t, polkit_var_lib_t)
+userdom_read_all_users_state(polkit_grant_t)
+
+optional_policy(`
+	dbus_system_bus_client_template(polkit_grant, polkit_grant_t)
+	consolekit_dbus_chat(polkit_grant_t)
+')
+
+gen_require(`
+	type system_crond_var_lib_t;
+')
+manage_files_pattern(polkit_grant_t, system_crond_var_lib_t,  system_crond_var_lib_t)
+
+########################################
+#
+# polkit_resolve local policy
+#
+
+allow polkit_resolve_t self:capability setuid;
+allow polkit_resolve_t self:process getattr;
+
+allow polkit_resolve_t self:unix_dgram_socket create_socket_perms;
+allow polkit_resolve_t self:fifo_file rw_file_perms;
+allow polkit_resolve_t self:unix_stream_socket create_stream_socket_perms;
+
+can_exec(polkit_resolve_t, polkit_resolve_exec_t)
+corecmd_search_bin(polkit_resolve_t)
+
+files_read_etc_files(polkit_resolve_t)
+files_read_usr_files(polkit_resolve_t)
+
+auth_use_nsswitch(polkit_resolve_t)
+
+libs_use_ld_so(polkit_resolve_t)
+libs_use_shared_libs(polkit_resolve_t)
+
+miscfiles_read_localization(polkit_resolve_t)
+
+logging_send_syslog_msg(polkit_resolve_t)

--------------090101050206030009080202
Content-Type: application/octet-stream;
 name="services_hal.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="services_hal.patch.sig"

iEYEABECAAYFAkg79mMACgkQrlYvE4MpobNW+ACgi0dtvgiIe6qLHXS0dietMDEk+6cAoOtp
Nq4v+OfiNTKFvjkLZ59uECS/
--------------090101050206030009080202
Content-Type: application/octet-stream;
 name="services_podsleuth.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="services_podsleuth.patch.sig"

iEYEABECAAYFAkg79mMACgkQrlYvE4MpobOqdgCeP700NNpoQeKh6OnY+XmCTS3jkUQAoKA2
GztV1mc4vEPTlUufwwJS5Px7
--------------090101050206030009080202
Content-Type: application/octet-stream;
 name="services_polkit.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="services_polkit.patch.sig"

iEYEABECAAYFAkg79mMACgkQrlYvE4MpobMVygCeKGtzBGTH1EKo2RdWIhwcfkFGiOoAoIAi
4B1nWNVfQoIFP7swb7W9dPYw
--------------090101050206030009080202--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

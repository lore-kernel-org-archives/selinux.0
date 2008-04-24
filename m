Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3OIQakX027211
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2008 14:26:36 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3OIQYVQ000266
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2008 18:26:35 GMT
Message-ID: <4810D0AC.7060006@redhat.com>
Date: Thu, 24 Apr 2008 14:25:48 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>, selinux@tycho.nsa.gov,
        selinux-devel@lists.alioth.debian.org
Subject: Re: refpolicy: patch for gpg-agent
References: <20080220170300.GA13312@bobek.pm.i.cz> <1204660301.14217.26.camel@gorn> <20080321130315.GA21980@bobek.pm.i.cz> <1206544272.16113.228.camel@gorn> <20080415132602.GA6685@bobek.pm.i.cz> <20080424081407.GA20611@bobek.pm.i.cz>
In-Reply-To: <20080424081407.GA20611@bobek.pm.i.cz>
Content-Type: multipart/mixed;
 boundary="------------020202060107060305040504"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020202060107060305040504
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Václav Ovsík wrote:
> On Tue, Apr 15, 2008 at 03:26:02PM +0200, Václav Ovsík wrote:
> ...
>> Another patch is attached with the specific type for home file
>> (<ROLE>_gpg_agent_home_t). I hope, this is better than general write
> ...
> 
> I forgot file context... The attached patch adds one for fixed
> filename `.gpg-agent-info'.
> 
> Best Regards
> 
Current Fedora allows gpg_t to manage files in the homedirs, since it
needs to be able to read/write files in the homedir.  No reason to
isolate it.

The reason for this patch being large is that Fedora no longer separates
homedir labeling via Prefix, since this concept will not work in a
distributed homedir environment.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkgQ0KsACgkQrlYvE4MpobM2nACgyRQmsFLZI5YtoCQrrzkEwCww
22QAoLtrkiJd6DJ+CfoS4M989pRr33y7
=/Sa0
-----END PGP SIGNATURE-----

--------------020202060107060305040504
Content-Type: text/plain;
 name="apps_gpg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="apps_gpg.patch"

From:  dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: apps_gpg changes
--text follows this line--
--- nsaserefpolicy/policy/modules/apps/gpg.fc	2007-10-12 08:56:02.000000000 -0400
+++ serefpolicy-3.3.1/policy/modules/apps/gpg.fc	2008-04-21 11:02:48.167478000 -0400
@@ -1,9 +1,9 @@
-HOME_DIR/\.gnupg(/.+)?		gen_context(system_u:object_r:ROLE_gpg_secret_t,s0)
+HOME_DIR/\.gnupg(/.+)?		gen_context(system_u:object_r:user_gpg_secret_t,s0)
 
-/usr/bin/gpg(2)?	--	gen_context(system_u:object_r:gpg_exec_t,s0)
+/usr/bin/gpg2?		--	gen_context(system_u:object_r:gpg_exec_t,s0)
 /usr/bin/gpg-agent	--	gen_context(system_u:object_r:gpg_agent_exec_t,s0)
 /usr/bin/kgpg		--	gen_context(system_u:object_r:gpg_exec_t,s0)
 /usr/bin/pinentry.*	--	gen_context(system_u:object_r:pinentry_exec_t,s0)
 
-/usr/lib/gnupg/.*	--	gen_context(system_u:object_r:gpg_exec_t,s0)
-/usr/lib/gnupg/gpgkeys.* --	gen_context(system_u:object_r:gpg_helper_exec_t,s0)
+/usr/lib(64)?/gnupg/.*	--	gen_context(system_u:object_r:gpg_exec_t,s0)
+/usr/lib(64)?/gnupg/gpgkeys.* --	gen_context(system_u:object_r:gpg_helper_exec_t,s0)
--- nsaserefpolicy/policy/modules/apps/gpg.if	2007-07-23 10:20:12.000000000 -0400
+++ serefpolicy-3.3.1/policy/modules/apps/gpg.if	2008-04-21 11:02:48.173471000 -0400
@@ -38,6 +38,10 @@
 	gen_require(`
 		type gpg_exec_t, gpg_helper_exec_t;
 		type gpg_agent_exec_t, pinentry_exec_t;
+		type gpg_t, gpg_helper_t;
+		type gpg_agent_t, gpg_pinentry_t;
+		type user_gpg_agent_tmp_t;
+		type user_gpg_secret_t;
 	')
 
 	########################################
@@ -45,275 +49,62 @@
 	# Declarations
 	#
 
-	type $1_gpg_t;
-	application_domain($1_gpg_t,gpg_exec_t)
-	role $3 types $1_gpg_t;
-
-	type $1_gpg_agent_t;
-	application_domain($1_gpg_agent_t,gpg_agent_exec_t)
-	role $3 types $1_gpg_agent_t;
-
-	type $1_gpg_agent_tmp_t;
-	files_tmp_file($1_gpg_agent_tmp_t)
-
-	type $1_gpg_secret_t;
-	userdom_user_home_content($1,$1_gpg_secret_t)
-
-	type $1_gpg_helper_t;
-	application_domain($1_gpg_helper_t,gpg_helper_exec_t)
-	role $3 types $1_gpg_helper_t;
-
-	type $1_gpg_pinentry_t;
-	application_domain($1_gpg_pinentry_t,pinentry_exec_t)
-	role $3 types $1_gpg_pinentry_t;
+	typealias gpg_t alias $1_gpg_t;
+	role $3 types gpg_t;
 
-	########################################
-	#
-	# GPG local policy
-	#
-
-	allow $1_gpg_t self:capability { ipc_lock setuid };
-	allow { $2 $1_gpg_t } $1_gpg_t:process signal;
-	# setrlimit is for ulimit -c 0
-	allow $1_gpg_t self:process { setrlimit setcap setpgid };
-
-	allow $1_gpg_t self:fifo_file rw_fifo_file_perms;
-	allow $1_gpg_t self:tcp_socket create_stream_socket_perms;
-
-	# transition from the gpg domain to the helper domain
-	domtrans_pattern($1_gpg_t,gpg_helper_exec_t,$1_gpg_helper_t)
-
-	manage_files_pattern($1_gpg_t,$1_gpg_secret_t,$1_gpg_secret_t)
-	manage_lnk_files_pattern($1_gpg_t,$1_gpg_secret_t,$1_gpg_secret_t)
-	allow $1_gpg_t $1_gpg_secret_t:dir create_dir_perms;
- 	userdom_user_home_dir_filetrans($1, $1_gpg_t, $1_gpg_secret_t, dir)
-
-	# transition from the userdomain to the derived domain
-	domtrans_pattern($2,gpg_exec_t,$1_gpg_t)
-
-	# allow ps to show gpg
-	ps_process_pattern($2,$1_gpg_t)
-
-	corenet_all_recvfrom_unlabeled($1_gpg_t)
-	corenet_all_recvfrom_netlabel($1_gpg_t)
-	corenet_tcp_sendrecv_all_if($1_gpg_t)
-	corenet_udp_sendrecv_all_if($1_gpg_t)
-	corenet_tcp_sendrecv_all_nodes($1_gpg_t)
-	corenet_udp_sendrecv_all_nodes($1_gpg_t)
-	corenet_tcp_sendrecv_all_ports($1_gpg_t)
-	corenet_udp_sendrecv_all_ports($1_gpg_t)
-	corenet_tcp_connect_all_ports($1_gpg_t)
-	corenet_sendrecv_all_client_packets($1_gpg_t)
-
-	dev_read_rand($1_gpg_t)
-	dev_read_urand($1_gpg_t)
-
-	fs_getattr_xattr_fs($1_gpg_t)
-
-	domain_use_interactive_fds($1_gpg_t)
-
-	files_read_etc_files($1_gpg_t)
-	files_read_usr_files($1_gpg_t)
-	files_dontaudit_search_var($1_gpg_t)
-
-	libs_use_shared_libs($1_gpg_t)
-	libs_use_ld_so($1_gpg_t)
-
-	miscfiles_read_localization($1_gpg_t)
-
-	logging_send_syslog_msg($1_gpg_t)
-
-	sysnet_read_config($1_gpg_t)
-
-	userdom_use_user_terminals($1,$1_gpg_t)
+	typealias gpg_agent_t alias  $1_gpg_agent_t;
+	role $3 types gpg_agent_t;
 
-	optional_policy(`
-		nis_use_ypbind($1_gpg_t)
-	')
-
-	ifdef(`TODO',`
-	# Read content to encrypt/decrypt/sign
-	read_content($1_gpg_t, $1)
-
-	# Write content to encrypt/decrypt/sign
-	write_trusted($1_gpg_t, $1)
-	') dnl end TODO
-
-	########################################
-	#
-	# GPG helper local policy
-	#
-
-	# for helper programs (which automatically fetch keys)
-	# Note: this is only tested with the hkp interface. If you use eg the 
-	# mail interface you will likely need additional permissions.
-
-	allow $1_gpg_helper_t self:unix_stream_socket create_stream_socket_perms;
-	allow $1_gpg_helper_t self:tcp_socket { connect connected_socket_perms };
-	allow $1_gpg_helper_t self:udp_socket { connect connected_socket_perms };
-
-	# communicate with the user 
-	allow $1_gpg_helper_t $2:fd use;
-	allow $1_gpg_helper_t $2:fifo_file write;
+	typealias gpg_helper_t alias  $1_gpg_helper_t;
+	role $3 types gpg_helper_t;
 
-	dontaudit $1_gpg_helper_t $1_gpg_secret_t:file read;
+	typealias gpg_pinentry_t alias $1_gpg_pinentry_t;
+	role $3 types gpg_pinentry_t;
 
-	corenet_all_recvfrom_unlabeled($1_gpg_helper_t)
-	corenet_all_recvfrom_netlabel($1_gpg_helper_t)
-	corenet_tcp_sendrecv_all_if($1_gpg_helper_t)
-	corenet_raw_sendrecv_all_if($1_gpg_helper_t)
-	corenet_udp_sendrecv_all_if($1_gpg_helper_t)
-	corenet_tcp_sendrecv_all_nodes($1_gpg_helper_t)
-	corenet_udp_sendrecv_all_nodes($1_gpg_helper_t)
-	corenet_raw_sendrecv_all_nodes($1_gpg_helper_t)
-	corenet_tcp_sendrecv_all_ports($1_gpg_helper_t)
-	corenet_udp_sendrecv_all_ports($1_gpg_helper_t)
-	corenet_tcp_bind_all_nodes($1_gpg_helper_t)
-	corenet_udp_bind_all_nodes($1_gpg_helper_t)
-	corenet_tcp_connect_all_ports($1_gpg_helper_t)
-
-	dev_read_urand($1_gpg_helper_t)
-
-	files_read_etc_files($1_gpg_helper_t)
-	# for nscd
-	files_dontaudit_search_var($1_gpg_helper_t)
-
-	libs_use_ld_so($1_gpg_helper_t)
-	libs_use_shared_libs($1_gpg_helper_t)
-
-	sysnet_read_config($1_gpg_helper_t)
-
-	tunable_policy(`use_nfs_home_dirs',`
-		fs_dontaudit_rw_nfs_files($1_gpg_helper_t)
-	')
-
-	tunable_policy(`use_samba_home_dirs',`
-		fs_dontaudit_rw_cifs_files($1_gpg_helper_t)
+	ifelse(`$1',`user',`',`
+		typealias user_gpg_agent_tmp_t alias $1_gpg_agent_tmp_t;
+		typealias user_gpg_secret_t alias $1_gpg_secret_t;
 	')
 
-	optional_policy(`
-		xserver_use_xdm_fds($1_gpg_t)
-		xserver_rw_xdm_pipes($1_gpg_t)
-	')
-
-	########################################
-	#
-	# GPG agent local policy
-	#
+	# transition from the userdomain to the derived domain
+	domtrans_pattern($2,gpg_exec_t,gpg_t)
 
-	# rlimit: gpg-agent wants to prevent coredumps
-	allow $1_gpg_agent_t self:process setrlimit;
+	# Transition from the user domain to the derived domain.
+	domtrans_pattern($2, gpg_agent_exec_t, $1_gpg_agent_t)
 
-	allow $1_gpg_agent_t self:unix_stream_socket create_stream_socket_perms ;
-	allow $1_gpg_agent_t self:fifo_file rw_fifo_file_perms;
+	allow $2 gpg_t:process signal_perms;
 
-	# read and write ~/.gnupg (gpg-agent stores secret keys in ~/.gnupg/private-keys-v1.d )
-	manage_dirs_pattern($1_gpg_agent_t,$1_gpg_secret_t,$1_gpg_secret_t)
-	manage_files_pattern($1_gpg_agent_t,$1_gpg_secret_t,$1_gpg_secret_t)
-	manage_lnk_files_pattern($1_gpg_agent_t,$1_gpg_secret_t,$1_gpg_secret_t)
+	# Thunderbird leaks descriptors
+	dontaudit gpg_t $2:tcp_socket rw_socket_perms;
+	dontaudit gpg_t $2:udp_socket rw_socket_perms;
+	dontaudit gpg_helper_t $2:tcp_socket rw_socket_perms;
+	dontaudit gpg_helper_t $2:udp_socket rw_socket_perms;
+	#Leaked File Descriptors
+	dontaudit gpg_helper_t $2:unix_stream_socket rw_socket_perms;
+	dontaudit gpg_t $2:unix_stream_socket rw_socket_perms;
 
-	# allow gpg to connect to the gpg agent
-	stream_connect_pattern($1_gpg_t,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t,$1_gpg_agent_t)
+	# allow ps to show gpg
+	ps_process_pattern($2,gpg_t)
 
 	# allow ps to show gpg-agent
 	ps_process_pattern($2,$1_gpg_agent_t)
 
 	# Allow the user shell to signal the gpg-agent program.
-	allow $2 $1_gpg_agent_t:process { signal sigkill };
-
-	manage_dirs_pattern($2,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
-	manage_files_pattern($2,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
-	manage_sock_files_pattern($2,$1_gpg_agent_tmp_t,$1_gpg_agent_tmp_t)
-	files_tmp_filetrans($1_gpg_agent_t, $1_gpg_agent_tmp_t, { file sock_file dir })
-
-	# Transition from the user domain to the derived domain.
-	domtrans_pattern($2, gpg_agent_exec_t, $1_gpg_agent_t)
-
-	corecmd_search_bin($1_gpg_agent_t)
-
-	domain_use_interactive_fds($1_gpg_agent_t)
-
-	libs_use_ld_so($1_gpg_agent_t)
-	libs_use_shared_libs($1_gpg_agent_t)
-
-	miscfiles_read_localization($1_gpg_agent_t)
+	allow $2 gpg_agent_t:process signal_perms;
 
+	userdom_use_user_terminals($1,gpg_t)
 	# Write to the user domain tty.
-	userdom_use_user_terminals($1,$1_gpg_agent_t)
-	# read and write ~/.gnupg (gpg-agent stores secret keys in ~/.gnupg/private-keys-v1.d )
-	userdom_search_user_home_dirs($1,$1_gpg_agent_t)
-
-	tunable_policy(`use_nfs_home_dirs',`
-		fs_manage_nfs_dirs($1_gpg_agent_t)
-		fs_manage_nfs_files($1_gpg_agent_t)
-		fs_manage_nfs_symlinks($1_gpg_agent_t)
-	')
-
-	tunable_policy(`use_samba_home_dirs',`
-		fs_manage_cifs_dirs($1_gpg_agent_t)
-		fs_manage_cifs_files($1_gpg_agent_t)
-		fs_manage_cifs_symlinks($1_gpg_agent_t)
-	')
-
-	##############################
-	#
-	# Pinentry local policy
-	#
-
-	allow $1_gpg_pinentry_t self:unix_stream_socket { connect create getattr read shutdown write };
-	allow $1_gpg_pinentry_t self:fifo_file rw_fifo_file_perms;
-
-	# we need to allow gpg-agent to call pinentry so it can get the passphrase 
-	# from the user.
-	domtrans_pattern($1_gpg_agent_t,pinentry_exec_t,$1_gpg_pinentry_t)
-
-	# read /proc/meminfo
-	kernel_read_system_state($1_gpg_pinentry_t)
-
-	files_read_usr_files($1_gpg_pinentry_t)
-	# read /etc/X11/qtrc
-	files_read_etc_files($1_gpg_pinentry_t)
-
-	libs_use_ld_so($1_gpg_pinentry_t)
-	libs_use_shared_libs($1_gpg_pinentry_t)
-
-	miscfiles_read_fonts($1_gpg_pinentry_t)
-	miscfiles_read_localization($1_gpg_pinentry_t)
-
-	# for .Xauthority
-	userdom_read_user_home_content_files($1,$1_gpg_pinentry_t)
-
-	tunable_policy(`use_nfs_home_dirs',`
-		fs_read_nfs_files($1_gpg_pinentry_t)
-	')
-
-	tunable_policy(`use_samba_home_dirs',`
-		fs_read_cifs_files($1_gpg_pinentry_t)
-	')
-
-	optional_policy(`
-		xserver_stream_connect_xdm_xserver($1_gpg_pinentry_t)
-	')
+	userdom_use_user_terminals($1,gpg_agent_t)
 
-	ifdef(`TODO',`
-	allow $1_gpg_pinentry_t tmp_t:dir { getattr search };
-
-	# wants to put some lock files into the user home dir, seems to work fine without
-	dontaudit $1_gpg_pinentry_t $1_home_t:dir { read write };
-	dontaudit $1_gpg_pinentry_t $1_home_t:file write;
-
-	tunable_policy(`use_nfs_home_dirs',`
-		dontaudit $1_gpg_pinentry_t nfs_t:dir write;
-		dontaudit $1_gpg_pinentry_t nfs_t:file write;
-	')
+	# communicate with the user 
+	allow gpg_helper_t $2:fd use;
+	allow gpg_helper_t $2:fifo_file rw_fifo_file_perms;
 
-	tunable_policy(`use_samba_home_dirs',`
-		dontaudit $1_gpg_pinentry_t cifs_t:dir write;
-		dontaudit $1_gpg_pinentry_t cifs_t:file write;
-	')
+	userdom_manage_user_home_content_files(user, gpg_helper_t)
 
-	dontaudit $1_gpg_pinentry_t { sysctl_t sysctl_kernel_t }:dir { getattr search };
-	') dnl end TODO
+	manage_dirs_pattern($2,user_gpg_agent_tmp_t,user_gpg_agent_tmp_t)
+	manage_files_pattern($2,user_gpg_agent_tmp_t,user_gpg_agent_tmp_t)
+	manage_sock_files_pattern($2,user_gpg_agent_tmp_t,user_gpg_agent_tmp_t)
 ')
 
 ########################################
--- nsaserefpolicy/policy/modules/apps/gpg.te	2007-12-19 05:32:09.000000000 -0500
+++ serefpolicy-3.3.1/policy/modules/apps/gpg.te	2008-04-21 13:02:48.601482000 -0400
@@ -7,15 +7,241 @@
 #
 
 # Type for gpg or pgp executables.
+type gpg_t;
 type gpg_exec_t;
+application_domain(gpg_t,gpg_exec_t)
+
+type gpg_helper_t;
 type gpg_helper_exec_t;
-application_executable_file(gpg_exec_t)
-application_executable_file(gpg_helper_exec_t)
+application_domain(gpg_helper_t,gpg_helper_exec_t)
 
 # Type for the gpg-agent executable.
+type gpg_agent_t;
 type gpg_agent_exec_t;
-application_executable_file(gpg_agent_exec_t)
+application_domain(gpg_agent_t,gpg_agent_exec_t)
 
 # type for the pinentry executable
+type gpg_pinentry_t;
 type pinentry_exec_t;
-application_executable_file(pinentry_exec_t)
+application_domain(gpg_pinentry_t,pinentry_exec_t)
+
+type user_gpg_agent_tmp_t;
+files_tmp_file(user_gpg_agent_tmp_t)
+
+type user_gpg_secret_t;
+userdom_user_home_content(user,user_gpg_secret_t)
+
+########################################
+#
+# GPG local policy
+#
+
+allow gpg_t self:capability { ipc_lock setuid };
+allow gpg_t gpg_t:process signal;
+# setrlimit is for ulimit -c 0
+allow gpg_t self:process { setrlimit getcap setcap setpgid };
+
+allow gpg_t self:fifo_file rw_fifo_file_perms;
+allow gpg_t self:tcp_socket create_stream_socket_perms;
+
+manage_files_pattern(gpg_t,user_gpg_secret_t,user_gpg_secret_t)
+manage_lnk_files_pattern(gpg_t,user_gpg_secret_t,user_gpg_secret_t)
+allow gpg_t user_gpg_secret_t:dir create_dir_perms;
+userdom_user_home_dir_filetrans_user_home_content(user, gpg_t, file)
+userdom_user_home_dir_filetrans(user, gpg_t, user_gpg_secret_t, dir)
+userdom_manage_user_home_content_files(user,gpg_t)
+userdom_manage_user_tmp_files(user,gpg_t)
+userdom_unpriv_users_stream_connect(gpg_t)
+
+# transition from the gpg domain to the helper domain
+domtrans_pattern(gpg_t,gpg_helper_exec_t,gpg_helper_t)
+
+corenet_all_recvfrom_unlabeled(gpg_t)
+corenet_all_recvfrom_netlabel(gpg_t)
+corenet_tcp_sendrecv_all_if(gpg_t)
+corenet_udp_sendrecv_all_if(gpg_t)
+corenet_tcp_sendrecv_all_nodes(gpg_t)
+corenet_udp_sendrecv_all_nodes(gpg_t)
+corenet_tcp_sendrecv_all_ports(gpg_t)
+corenet_udp_sendrecv_all_ports(gpg_t)
+corenet_tcp_connect_all_ports(gpg_t)
+corenet_sendrecv_all_client_packets(gpg_t)
+
+dev_read_rand(gpg_t)
+dev_read_urand(gpg_t)
+
+fs_getattr_xattr_fs(gpg_t)
+fs_list_inotifyfs(gpg_t)
+
+domain_use_interactive_fds(gpg_t)
+
+files_read_etc_files(gpg_t)
+files_read_usr_files(gpg_t)
+files_dontaudit_search_var(gpg_t)
+
+auth_use_nsswitch(gpg_t)
+
+libs_use_shared_libs(gpg_t)
+libs_use_ld_so(gpg_t)
+
+miscfiles_read_localization(gpg_t)
+
+logging_send_syslog_msg(gpg_t)
+
+########################################
+#
+# GPG helper local policy
+#
+
+allow gpg_helper_t self:process { getsched setsched };
+
+# for helper programs (which automatically fetch keys)
+# Note: this is only tested with the hkp interface. If you use eg the 
+# mail interface you will likely need additional permissions.
+
+allow gpg_helper_t self:unix_stream_socket create_stream_socket_perms;
+allow gpg_helper_t self:tcp_socket { connect connected_socket_perms };
+allow gpg_helper_t self:udp_socket { connect connected_socket_perms };
+
+dontaudit gpg_helper_t user_gpg_secret_t:file read;
+
+corenet_all_recvfrom_unlabeled(gpg_helper_t)
+corenet_all_recvfrom_netlabel(gpg_helper_t)
+corenet_tcp_sendrecv_all_if(gpg_helper_t)
+corenet_raw_sendrecv_all_if(gpg_helper_t)
+corenet_udp_sendrecv_all_if(gpg_helper_t)
+corenet_tcp_sendrecv_all_nodes(gpg_helper_t)
+corenet_udp_sendrecv_all_nodes(gpg_helper_t)
+corenet_raw_sendrecv_all_nodes(gpg_helper_t)
+corenet_tcp_sendrecv_all_ports(gpg_helper_t)
+corenet_udp_sendrecv_all_ports(gpg_helper_t)
+corenet_tcp_bind_all_nodes(gpg_helper_t)
+corenet_udp_bind_all_nodes(gpg_helper_t)
+corenet_tcp_connect_all_ports(gpg_helper_t)
+
+files_read_etc_files(gpg_helper_t)
+
+fs_list_inotifyfs(gpg_helper_t)
+
+auth_use_nsswitch(gpg_helper_t)
+
+libs_use_ld_so(gpg_helper_t)
+libs_use_shared_libs(gpg_helper_t)
+
+tunable_policy(`use_nfs_home_dirs',`
+	fs_dontaudit_rw_nfs_files(gpg_helper_t)
+')
+
+tunable_policy(`use_samba_home_dirs',`
+	fs_dontaudit_rw_cifs_files(gpg_helper_t)
+')
+
+optional_policy(`
+	xserver_use_xdm_fds(gpg_t)
+	xserver_rw_xdm_pipes(gpg_t)
+')
+
+
+tunable_policy(`use_nfs_home_dirs',`
+	fs_manage_nfs_dirs(gpg_t)
+	fs_manage_nfs_files(gpg_t)
+')
+
+tunable_policy(`use_samba_home_dirs',`
+	fs_manage_cifs_dirs(gpg_t)
+	fs_manage_cifs_files(gpg_t)
+')
+
+########################################
+#
+# GPG agent local policy
+#
+
+# rlimit: gpg-agent wants to prevent coredumps
+allow gpg_agent_t self:process setrlimit;
+
+allow gpg_agent_t self:unix_stream_socket create_stream_socket_perms ;
+allow gpg_agent_t self:fifo_file rw_fifo_file_perms;
+
+# read and write ~/.gnupg (gpg-agent stores secret keys in ~/.gnupg/private-keys-v1.d )
+manage_dirs_pattern(gpg_agent_t,user_gpg_secret_t,user_gpg_secret_t)
+manage_files_pattern(gpg_agent_t,user_gpg_secret_t,user_gpg_secret_t)
+manage_lnk_files_pattern(gpg_agent_t,user_gpg_secret_t,user_gpg_secret_t)
+
+# allow gpg to connect to the gpg agent
+manage_dirs_pattern(gpg_agent_t,user_gpg_secret_t,user_gpg_secret_t)
+manage_files_pattern(gpg_agent_t,user_gpg_secret_t,user_gpg_secret_t)
+manage_lnk_files_pattern(gpg_agent_t,user_gpg_secret_t,user_gpg_secret_t)
+
+stream_connect_pattern(gpg_t,user_gpg_agent_tmp_t,user_gpg_agent_tmp_t,gpg_agent_t)
+
+manage_dirs_pattern(gpg_agent_t,user_gpg_agent_tmp_t,user_gpg_agent_tmp_t)
+manage_files_pattern(gpg_agent_t,user_gpg_agent_tmp_t,user_gpg_agent_tmp_t)
+manage_sock_files_pattern(gpg_agent_t,user_gpg_agent_tmp_t,user_gpg_agent_tmp_t)
+files_tmp_filetrans(gpg_agent_t, user_gpg_agent_tmp_t, { file sock_file dir })
+
+corecmd_search_bin(gpg_agent_t)
+
+domain_use_interactive_fds(gpg_agent_t)
+
+libs_use_ld_so(gpg_agent_t)
+libs_use_shared_libs(gpg_agent_t)
+
+miscfiles_read_localization(gpg_agent_t)
+
+# read and write ~/.gnupg (gpg-agent stores secret keys in ~/.gnupg/private-keys-v1.d )
+userdom_search_user_home_dirs(user,gpg_agent_t)
+
+tunable_policy(`use_nfs_home_dirs',`
+	fs_manage_nfs_dirs(gpg_agent_t)
+	fs_manage_nfs_files(gpg_agent_t)
+	fs_manage_nfs_symlinks(gpg_agent_t)
+')
+
+tunable_policy(`use_samba_home_dirs',`
+	fs_manage_cifs_dirs(gpg_agent_t)
+	fs_manage_cifs_files(gpg_agent_t)
+	fs_manage_cifs_symlinks(gpg_agent_t)
+')
+
+##############################
+#
+# Pinentry local policy
+#
+
+allow gpg_pinentry_t self:unix_stream_socket { connect create getattr read shutdown write };
+allow gpg_pinentry_t self:fifo_file rw_fifo_file_perms;
+
+# we need to allow gpg-agent to call pinentry so it can get the passphrase 
+# from the user.
+domtrans_pattern(gpg_agent_t,pinentry_exec_t,gpg_pinentry_t)
+
+# read /proc/meminfo
+kernel_read_system_state(gpg_pinentry_t)
+
+files_read_usr_files(gpg_pinentry_t)
+# read /etc/X11/qtrc
+files_read_etc_files(gpg_pinentry_t)
+
+libs_use_ld_so(gpg_pinentry_t)
+libs_use_shared_libs(gpg_pinentry_t)
+
+miscfiles_read_fonts(gpg_pinentry_t)
+miscfiles_read_localization(gpg_pinentry_t)
+
+# for .Xauthority
+userdom_read_user_home_content_files(user,gpg_pinentry_t)
+
+tunable_policy(`use_nfs_home_dirs',`
+	fs_read_nfs_files(gpg_pinentry_t)
+')
+
+tunable_policy(`use_samba_home_dirs',`
+	fs_read_cifs_files(gpg_pinentry_t)
+')
+
+optional_policy(`
+	xserver_stream_connect_xdm_xserver(gpg_pinentry_t)
+')
+
+

--------------020202060107060305040504
Content-Type: application/octet-stream;
 name="apps_gpg.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="apps_gpg.patch.sig"

iEYEABECAAYFAkgQ0KsACgkQrlYvE4MpobOOzgCePxLb19tjl+Jh0jgFgCHj+JmiRmkAoJyb
eX0iugYiCcX1WutiwEXTkzAB
--------------020202060107060305040504--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

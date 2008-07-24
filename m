Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6OC2ZwG021267
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 08:02:35 -0400
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6OC2XWE002262
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 12:02:34 GMT
Received: by nf-out-0910.google.com with SMTP id b21so1270159nfd.4
        for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 05:02:33 -0700 (PDT)
Subject: [refpolicy patch] merge irssi module with irc module.
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HmNWjg/UEwES8MJGF08+"
Date: Thu, 24 Jul 2008 14:02:30 +0200
Message-Id: <1216900950.29201.12.camel@sulphur.notebook.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-HmNWjg/UEwES8MJGF08+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This patch aims to merge my irssi module to the existing irc module.

Index: /home/domg472/Workspace/refpolicy1/policy/modules/apps/irc.te
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /home/domg472/Workspace/refpolicy1/policy/modules/apps/irc.te
(revision 2763)
+++ /home/domg472/Workspace/refpolicy1/policy/modules/apps/irc.te
(working copy)
@@ -6,5 +6,17 @@
 # Declarations
 #
=20
+## <desc>
+## <p>
+## Allow the IRC Client to bind to all
+## unreserved TCP ports, and to connect
+## to all ports.
+## </p>
+## </desc>
+gen_tunable(irc_unrestricted_tcp_network, false)
+
 type irc_exec_t;
 application_executable_file(irc_exec_t)
+
+type irc_etc_t;
+files_config_file(irc_etc_t)
Index: /home/domg472/Workspace/refpolicy1/policy/modules/apps/irc.if
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /home/domg472/Workspace/refpolicy1/policy/modules/apps/irc.if
(revision 2763)
+++ /home/domg472/Workspace/refpolicy1/policy/modules/apps/irc.if
(working copy)
@@ -51,6 +51,7 @@
 	application_domain($1_irc_t, $1_irc_exec_t)
=20
 	type $1_irc_home_t;
+	files_poly_member($1_irc_home_t)
 	userdom_user_home_content($1, $1_irc_home_t)
=20
 	type $1_irc_tmp_t;
@@ -61,15 +62,29 @@
 	# Local policy
 	#
=20
-	allow $1_irc_t self:unix_stream_socket create_stream_socket_perms;
-	allow $1_irc_t self:tcp_socket create_socket_perms;
-	allow $1_irc_t self:udp_socket create_socket_perms;
+	allow $1_irc_t self:fifo_file rw_fifo_file_perms;
+	allow $1_irc_t self:netlink_route_socket create_netlink_socket_perms;
+	allow $1_irc_t self:process signal;
+	allow $1_irc_t self:tcp_socket { accept listen create_socket_perms };
+	allow $1_irc_t self:udp_socket { create_socket_perms };
+	allow $1_irc_t self:unix_stream_socket { create_stream_socket_perms };
=20
+	read_files_pattern($1_irc_t, irc_etc_t, irc_etc_t)
+
 	manage_dirs_pattern($1_irc_t, $1_irc_home_t, $1_irc_home_t)
 	manage_files_pattern($1_irc_t, $1_irc_home_t, $1_irc_home_t)
 	manage_lnk_files_pattern($1_irc_t, $1_irc_home_t, $1_irc_home_t)
 	userdom_user_home_dir_filetrans($1, $1_irc_t, $1_irc_home_t,{ dir file
lnk_file })
+	userdom_search_user_home_dirs($1, $1_irc_t)
=20
+	manage_dirs_pattern($2, $1_irc_home_t, $1_irc_home_t)
+	manage_files_pattern($2, $1_irc_home_t, $1_irc_home_t)
+	manage_lnk_files_pattern($2, $1_irc_home_t, $1_irc_home_t)
+
+	relabel_dirs_pattern($2, $1_irc_home_t, $1_irc_home_t)
+	relabel_files_pattern($2, $1_irc_home_t, $1_irc_home_t)
+	relabel_lnk_files_pattern($2, $1_irc_home_t, $1_irc_home_t)
+
 	# access files under /tmp
 	manage_dirs_pattern($1_irc_t, $1_irc_tmp_t, $1_irc_tmp_t)
 	manage_files_pattern($1_irc_t, $1_irc_tmp_t, $1_irc_tmp_t)
@@ -85,10 +100,12 @@
=20
 	# allow ps to show irc
 	ps_process_pattern($2, $1_irc_t)
-	allow $2 $1_irc_t:process signal;
 =09
 	kernel_read_proc_symlinks($1_irc_t)
=20
+	corecmd_search_bin($1_irc_t)
+	corecmd_read_bin_symlinks($1_irc_t)
+
 	corenet_all_recvfrom_unlabeled($1_irc_t)
 	corenet_all_recvfrom_netlabel($1_irc_t)
 	corenet_tcp_sendrecv_generic_if($1_irc_t)
@@ -98,10 +115,9 @@
 	corenet_tcp_sendrecv_all_ports($1_irc_t)
 	corenet_udp_sendrecv_all_ports($1_irc_t)
 	corenet_sendrecv_ircd_client_packets($1_irc_t)
-	# cjp: this seems excessive:
-	corenet_tcp_connect_all_ports($1_irc_t)
-	corenet_sendrecv_all_client_packets($1_irc_t)
=20
+	dev_read_urand($1_irc_t)
+
 	domain_use_interactive_fds($1_irc_t)
=20
 	files_dontaudit_search_pids($1_irc_t)
@@ -124,6 +140,8 @@
=20
 	miscfiles_read_localization($1_irc_t)
=20
+	nscd_read_pid($1_irc_t)
+
 	# Inherit and use descriptors from newrole.
 	seutil_use_newrole_fds($1_irc_t)
=20
@@ -131,20 +149,68 @@
=20
 	# Write to the user domain tty.
 	userdom_use_user_terminals($1, $1_irc_t)
+	userdom_sigchld_all_users($1_irc_t)
=20
+	tunable_policy(`irc_unrestricted_tcp_network',`
+		corenet_tcp_bind_all_unreserved_ports($1_irc_t)
+		corenet_tcp_connect_all_ports($1_irc_t)
+		corenet_sendrecv_all_client_packets($1_irc_t)
+		corenet_sendrecv_all_server_packets($1_irc_t)
+	')
+
 	tunable_policy(`use_nfs_home_dirs',`
+		fs_search_auto_mountpoints($1_irc_t)
 		fs_manage_nfs_dirs($1_irc_t)
 		fs_manage_nfs_files($1_irc_t)
 		fs_manage_nfs_symlinks($1_irc_t)
 	')
=20
 	tunable_policy(`use_samba_home_dirs',`
+		fs_search_auto_mountpoints($1_irc_t)
 		fs_manage_cifs_dirs($1_irc_t)
 		fs_manage_cifs_files($1_irc_t)
 		fs_manage_cifs_symlinks($1_irc_t)
 	')
=20
 	optional_policy(`
+		automount_dontaudit_getattr_tmp_dirs($1_irc_t)
+	')
+
+	optional_policy(`
 		nis_use_ypbind($1_irc_t)
 	')
 ')
+
+########################################
+## <summary>
+##  Signal and trace the user IRC Client process.
+## </summary>
+## <desc>
+##	<p>
+##	Allows users to signal and trace the user IRC=20
+##	Client process.
+##	</p>
+##	<p>
+##	This is a templated interface, and should only
+##	be called from a per-userdomain template.
+##	</p>
+## </desc>
+## <param name=3D"userdomain_prefix">
+##	<summary>
+##	The prefix of the user domain (e.g., user
+##	is the prefix for user_t).
+##	</summary>
+## </param>
+## <param name=3D"domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+template(`irc_signal_user_irc',`
+	gen_require(`
+		type $1_irc_t;
+	')
+
+	allow $2 $1_irc_t:process { ptrace signal_perms };=09
+')
Index: /home/domg472/Workspace/refpolicy1/policy/modules/apps/irc.fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /home/domg472/Workspace/refpolicy1/policy/modules/apps/irc.fc
(revision 2763)
+++ /home/domg472/Workspace/refpolicy1/policy/modules/apps/irc.fc
(working copy)
@@ -1,11 +1,18 @@
 #
+# /etc
+#
+/etc/irssi\.conf                 --
gen_context(system_u:object_r:irc_etc_t,s0)
+
+#
 # /home
 #
 HOME_DIR/\.ircmotd	--	gen_context(system_u:object_r:ROLE_irc_home_t,s0)
+HOME_DIR/\.irssi(/.*)?
gen_context(system_u:object_r:ROLE_irc_home_t,s0)
=20
 #
 # /usr
 #
 /usr/bin/[st]irc		--	gen_context(system_u:object_r:irc_exec_t,s0)
 /usr/bin/ircII		--	gen_context(system_u:object_r:irc_exec_t,s0)
+/usr/bin/irssi                  --
gen_context(system_u:object_r:irc_exec_t,s0)
 /usr/bin/tinyirc		--	gen_context(system_u:object_r:irc_exec_t,s0)
Index: /home/domg472/Workspace/refpolicy1/policy/modules/system/userdomain.=
if
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /home/domg472/Workspace/refpolicy1/policy/modules/system/userdomain.if	=
(revision 2763)
+++ /home/domg472/Workspace/refpolicy1/policy/modules/system/userdomain.if	=
(working copy)
@@ -818,6 +818,10 @@
 	')
=20
 	optional_policy(`
+		irc_signal_user_irc($1, $1_t)
+	')
+
+	optional_policy(`
 		locate_read_lib_files($1_t)
 	')
=20

=20
--=20
Dominick Grift <domg472@gmail.com>

--=-HmNWjg/UEwES8MJGF08+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiIb1QACgkQL00QnzrVtlzLgwCbBw4bMoS1j1BnyJuqYc8N29cv
jdYAoJcG+K9CMZ3m1jJN3T0kIbkayR2l
=sPG/
-----END PGP SIGNATURE-----

--=-HmNWjg/UEwES8MJGF08+--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

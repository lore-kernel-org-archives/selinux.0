Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6MKTwsW029398
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 16:29:58 -0400
Received: from ik-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6MKTvT1010968
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 20:29:58 GMT
Received: by ik-out-1112.google.com with SMTP id c21so1448487ika.2
        for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 13:29:56 -0700 (PDT)
Subject: [refpolicy patch] adds irssi module.
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-C5D1rVrLk/Qcm++KvkuO"
Date: Tue, 22 Jul 2008 22:29:54 +0200
Message-Id: <1216758594.26661.9.camel@sulphur.notebook.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-C5D1rVrLk/Qcm++KvkuO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This patch aims to add a irssi module.

--- <unnamed>=20
+++ /home/domg472/Desktop/irssi/irssi.if=20
@@ -1,1 +1,192 @@
+## <summary>SELinux policy for the Irssi IRC Client.</summary>
+## <desc>
+## 	<p>
+## 	Applies SELinux security to Irssi IRC Client.
+## 	</p>
+## </desc>
=20
+#######################################
+## <summary>
+##  The per role template for the Irssi module.
+## </summary>
+## <desc>
+## 	<p>
+## 	This template creates derived domains which are used
+## 	for the Irssi IRC Client.
+## 	</p>
+## 	<p>
+## 	This template is invoked automatically for each user, and
+## 	generally does not need to be invoked directly
+## 	by policy writers.
+## 	</p>
+## </desc>
+## <param name=3D"userdomain_prefix">
+## 	<summary>
+## 	The prefix of the user domain (e.g., user
+## 	is the prefix for user_t).
+## 	</summary>
+## </param>
+## <param name=3D"user_domain">
+## 	<summary>
+## 	The type of the user domain.
+## 	</summary>
+## 	</param>
+## 	<param name=3D"user_role">
+## 	<summary>
+## 	The role associated with the user domain.
+## 	</summary>
+## </param>
+#
+template(`irssi_per_role_template',`
+	gen_require(`
+		type irssi_exec_t, irssi_etc_t;
+	')
+
+	########################################
+	#
+	#  Public declarations.
+	#
+	type $1_irssi_t;
+	application_domain($1_irssi_t, irssi_exec_t)
+	role $3 types $1_irssi_t;
+
+	type $1_irssi_home_t;
+	files_poly_member($1_irssi_home_t)
+	userdom_user_home_content($1, $1_irssi_home_t)
+
+	########################################
+	#
+	# Public policy.
+	#
+	allow $1_irssi_t self:fifo_file rw_fifo_file_perms;
+	allow $1_irssi_t self:process signal;
+	allow $1_irssi_t self:netlink_route_socket { write getattr read bind
create nlmsg_read };
+	allow $1_irssi_t self:tcp_socket { write accept getattr bind listen
setopt read getopt create connect };
+	allow $1_irssi_t self:udp_socket { write read create connect
getattr };
+
+	# Fix me. Userdom should call irssi_signal_user_irssi($1, $2)
+	allow $2 $1_irssi_t:process { ptrace signal_perms };
+
+	read_files_pattern($1_irssi_t, irssi_etc_t, irssi_etc_t)
+
+	manage_dirs_pattern($1_irssi_t, $1_irssi_home_t, $1_irssi_home_t)
+	manage_files_pattern($1_irssi_t, $1_irssi_home_t, $1_irssi_home_t)
+	manage_lnk_files_pattern($1_irssi_t, $1_irssi_home_t, $1_irssi_home_t)
+	userdom_user_home_dir_filetrans($1, $1_irssi_t, $1_irssi_home_t, { dir
file lnk_file })
+	userdom_search_user_home_dirs($1, $1_irssi_t)
+
+	manage_dirs_pattern($2, $1_irssi_home_t, $1_irssi_home_t)
+	manage_files_pattern($2, $1_irssi_home_t, $1_irssi_home_t)
+	manage_lnk_files_pattern($2, $1_irssi_home_t, $1_irssi_home_t)
+
+	relabel_dirs_pattern($2, $1_irssi_home_t, $1_irssi_home_t)
+	relabel_files_pattern($2, $1_irssi_home_t, $1_irssi_home_t)
+	relabel_lnk_files_pattern($2, $1_irssi_home_t, $1_irssi_home_t)
+
+	domain_auto_trans($2, irssi_exec_t, $1_irssi_t)
+
+	ps_process_pattern($2, $1_irssi_t)
+    =20
+	corecmd_search_bin($1_irssi_t)
+	corecmd_read_bin_symlinks($1_irssi_t)
+
+	corenet_tcp_connect_ircd_port($1_irssi_t)
+	corenet_sendrecv_ircd_client_packets($1_irssi_t)
+
+	corenet_all_recvfrom_netlabel($1_irssi_t)
+	corenet_all_recvfrom_unlabeled($1_irssi_t)
+
+ 	corenet_tcp_sendrecv_all_if($1_irssi_t)
+	corenet_tcp_sendrecv_all_nodes($1_irssi_t)
+
+ 	corenet_tcp_bind_all_nodes($1_irssi_t)
+	corenet_udp_bind_all_nodes($1_irssi_t)
+
+	dev_read_urand($1_irssi_t)
+
+	files_read_etc_files($1_irssi_t)
+	files_read_usr_files($1_irssi_t)
+
+	libs_exec_lib_files($1_irssi_t)
+	libs_use_ld_so($1_irssi_t)
+
+	miscfiles_read_localization($1_irssi_t)
+
+	nscd_read_pid($1_irssi_t)
+
+	sysnet_read_config($1_irssi_t)
+
+	userdom_use_user_terminals($1, $1_irssi_t)
+	userdom_sigchld_all_users($1_irssi_t)
+
+	tunable_policy(`irssi_use_full_network',`
+		corenet_tcp_bind_all_unreserved_ports($1_irssi_t)
+		corenet_tcp_connect_all_ports($1_irssi_t)
+		corenet_sendrecv_all_server_packets($1_irssi_t)
+		corenet_sendrecv_all_client_packets($1_irssi_t)
+	')
+     =20
+	tunable_policy(`use_nfs_home_dirs',`
+		fs_search_auto_mountpoints($1_irssi_t)
+		fs_manage_nfs_dirs($1_irssi_t)
+ 		fs_manage_nfs_files($1_irssi_t)
+ 		fs_manage_nfs_symlinks($1_irssi_t)
+	')
+
+	tunable_policy(`use_samba_home_dirs',`
+		fs_search_auto_mountpoints($1_irssi_t)
+		fs_manage_cifs_dirs($1_irssi_t)
+		fs_manage_cifs_files($1_irssi_t)
+ 		fs_manage_cifs_symlinks($1_irssi_t)
+	')
+
+	optional_policy(`
+		automount_dontaudit_getattr_tmp_dirs($1_irssi_t)
+	')
+
+	optional_policy(`
+		nis_use_ypbind($1_irssi_t)
+	')
+
+	# Required for FiSH
+	optional_policy(`
+		tunable_policy(`allow_execmem && allow_execstack',`
+			allow $1_irssi_t self:process { execmem execstack };
+		')
+	')
+')
+
+########################################
+## <summary>
+##  Signal and trace the user Irssi IRC Client process.
+## </summary>
+## <desc>
+##	<p>
+##	Allows users to signal and trace the user Irssi IRC=20
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
+template(`irssi_signal_user_irssi',`
+	gen_require(`
+		type $1_irssi_t;
+	')
+
+	allow $2 $1_irssi_t:process { ptrace signal_perms };=09
+')
+
--- <unnamed>=20
+++ /home/domg472/Desktop/irssi/irssi.te=20
@@ -1,1 +1,22 @@
=20
+policy_module(irssi, 1.0.0)=20
+
+########################################
+#
+# Private declarations.
+#
+
+## <desc>
+## <p>
+## Allow the Irssi IRC Client to connect to any port,
+## and to bind to any unreserved port.
+## </p>
+## </desc>
+gen_tunable(irssi_use_full_network, false)
+
+type irssi_exec_t;
+application_executable_file(irssi_exec_t)
+
+type irssi_etc_t;
+files_config_file(irssi_etc_t)
+
--- <unnamed>=20
+++ /home/domg472/Desktop/irssi/irssi.fc=20
@@ -1,1 +1,6 @@
+/etc/irssi.conf                 --
gen_context(system_u:object_r:irssi_etc_t,s0)
=20
+HOME_DIR/\.irssi(/.*)?
gen_context(system_u:object_r:ROLE_irssi_home_t,s0)
+
+/usr/bin/irssi                  --
gen_context(system_u:object_r:irssi_exec_t,s0)
+

--=20
Dominick Grift <domg472@gmail.com>

--=-C5D1rVrLk/Qcm++KvkuO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiGQ0AACgkQL00QnzrVtlxo7ACcC5QlVUaQFAY1mT440c3riJBa
Jz8AoJOSnYo21SX1CfO/3sJj8nJiwnxG
=6Njs
-----END PGP SIGNATURE-----

--=-C5D1rVrLk/Qcm++KvkuO--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

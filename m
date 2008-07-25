Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6PBfDvR000815
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 07:41:13 -0400
Received: from nf-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6PBfC1Q017408
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 11:41:12 GMT
Received: by nf-out-0910.google.com with SMTP id b21so1461445nfd.4
        for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 04:41:11 -0700 (PDT)
Subject: [refpolicy patch] latest try: merge irssi policy with irc module.
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FStSyN7nfhRnJJQzlA5i"
Date: Fri, 25 Jul 2008 13:41:07 +0200
Message-Id: <1216986067.3690.7.camel@sulphur.notebook.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-FStSyN7nfhRnJJQzlA5i
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Merge irssi policy with irc module.
My previous attempt was too coarse. (read_files_pattern instead of
read_file_perms), and the use of (userdom_sigchld_all_users)

=46rom ed2669a27729c95fadf4da0bf9f0f1e0d29abe90 Mon Sep 17 00:00:00 2001
From: Dominick Grift <domg472@gmail.com>
Date: Fri, 25 Jul 2008 13:26:37 +0200
Subject: [PATCH] Merge irssi with irc module.
 Add irc signal and ptrace interface calls to userdomain.

Signed-off-by: Dominick Grift <domg472@gmail.com>
---
 policy/modules/apps/irc.fc          |   11 +++-
 policy/modules/apps/irc.if          |  122
++++++++++++++++++++++++++++++++---
 policy/modules/apps/irc.te          |   12 ++++
 policy/modules/system/userdomain.if |    5 ++
 4 files changed, 138 insertions(+), 12 deletions(-)

diff --git a/policy/modules/apps/irc.fc b/policy/modules/apps/irc.fc
index 618588c..743f5cc 100644
--- a/policy/modules/apps/irc.fc
+++ b/policy/modules/apps/irc.fc
@@ -1,11 +1,18 @@
 #
+# /etc
+#
+/etc/irssi\.conf	--	gen_context(system_u:object_r:irc_etc_t,s0)
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
-/usr/bin/[st]irc		--	gen_context(system_u:object_r:irc_exec_t,s0)
+/usr/bin/[st]irc	--	gen_context(system_u:object_r:irc_exec_t,s0)
 /usr/bin/ircII		--	gen_context(system_u:object_r:irc_exec_t,s0)
-/usr/bin/tinyirc		--	gen_context(system_u:object_r:irc_exec_t,s0)
+/usr/bin/irssi		--	gen_context(system_u:object_r:irc_exec_t,s0)
+/usr/bin/tinyirc	--	gen_context(system_u:object_r:irc_exec_t,s0)
diff --git a/policy/modules/apps/irc.if b/policy/modules/apps/irc.if
index c778244..db7c8ca 100644
--- a/policy/modules/apps/irc.if
+++ b/policy/modules/apps/irc.if
@@ -51,6 +51,7 @@ template(`irc_per_role_template',`
 	application_domain($1_irc_t, $1_irc_exec_t)
=20
 	type $1_irc_home_t;
+	files_poly_member($1_irc_home_t)
 	userdom_user_home_content($1, $1_irc_home_t)
=20
 	type $1_irc_tmp_t;
@@ -61,14 +62,20 @@ template(`irc_per_role_template',`
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
+
+	allow $1_irc_t irc_etc_t:file read_file_perms;
=20
 	manage_dirs_pattern($1_irc_t, $1_irc_home_t, $1_irc_home_t)
 	manage_files_pattern($1_irc_t, $1_irc_home_t, $1_irc_home_t)
 	manage_lnk_files_pattern($1_irc_t, $1_irc_home_t, $1_irc_home_t)
-	userdom_user_home_dir_filetrans($1, $1_irc_t, $1_irc_home_t,{ dir file
lnk_file })
+	userdom_search_user_home_dirs($1, $1_irc_t)
+	userdom_user_home_dir_filetrans($1, $1_irc_t, $1_irc_home_t, { dir
file lnk_file })
=20
 	# access files under /tmp
 	manage_dirs_pattern($1_irc_t, $1_irc_tmp_t, $1_irc_tmp_t)
@@ -78,6 +85,14 @@ template(`irc_per_role_template',`
 	manage_sock_files_pattern($1_irc_t, $1_irc_tmp_t, $1_irc_tmp_t)
 	files_tmp_filetrans($1_irc_t, $1_irc_tmp_t, { file dir lnk_file
sock_file fifo_file })
=20
+	manage_dirs_pattern($2, $1_irc_home_t, $1_irc_home_t)
+	manage_files_pattern($2, $1_irc_home_t, $1_irc_home_t)
+	manage_lnk_files_pattern($2, $1_irc_home_t, $1_irc_home_t)
+
+	relabel_dirs_pattern($2, $1_irc_home_t, $1_irc_home_t)
+	relabel_files_pattern($2, $1_irc_home_t, $1_irc_home_t)
+	relabel_lnk_files_pattern($2, $1_irc_home_t, $1_irc_home_t)
+
 	# Transition from the user domain to the derived domain.
 	domtrans_pattern($2, irc_exec_t, $1_irc_t)
 =09
@@ -85,10 +100,12 @@ template(`irc_per_role_template',`
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
@@ -97,10 +114,10 @@ template(`irc_per_role_template',`
 	corenet_udp_sendrecv_all_nodes($1_irc_t)
 	corenet_tcp_sendrecv_all_ports($1_irc_t)
 	corenet_udp_sendrecv_all_ports($1_irc_t)
+	corenet_tcp_connect_ircd_port($1_irc_t)
 	corenet_sendrecv_ircd_client_packets($1_irc_t)
-	# cjp: this seems excessive:
-	corenet_tcp_connect_all_ports($1_irc_t)
-	corenet_sendrecv_all_client_packets($1_irc_t)
+
+	dev_read_urand($1_irc_t)
=20
 	domain_use_interactive_fds($1_irc_t)
=20
@@ -132,19 +149,104 @@ template(`irc_per_role_template',`
 	# Write to the user domain tty.
 	userdom_use_user_terminals($1, $1_irc_t)
=20
-	tunable_policy(`use_nfs_home_dirs',`
+	tunable_policy(`irc_unrestricted_tcp_network', `
+		corenet_tcp_bind_all_unreserved_ports($1_irc_t)
+		corenet_tcp_connect_all_ports($1_irc_t)
+		corenet_sendrecv_all_client_packets($1_irc_t)
+		corenet_sendrecv_all_server_packets($1_irc_t)
+	')
+
+	tunable_policy(`use_nfs_home_dirs', `
 		fs_manage_nfs_dirs($1_irc_t)
 		fs_manage_nfs_files($1_irc_t)
 		fs_manage_nfs_symlinks($1_irc_t)
 	')
=20
-	tunable_policy(`use_samba_home_dirs',`
+	tunable_policy(`use_samba_home_dirs', `
 		fs_manage_cifs_dirs($1_irc_t)
 		fs_manage_cifs_files($1_irc_t)
 		fs_manage_cifs_symlinks($1_irc_t)
 	')
=20
 	optional_policy(`
+		automount_dontaudit_getattr_tmp_dirs($1_irc_t)
+		fs_search_auto_mountpoints($1_irc_t)
+	')
+
+	optional_policy(`
 		nis_use_ypbind($1_irc_t)
 	')
+
+	optional_policy(`
+		nscd_read_pid($1_irc_t)
+	')
+')
+
+########################################
+## <summary>
+##  Send all signals and to user IRC Client=20
+##	processes.
+## </summary>
+## <desc>
+##	<p>
+##	Allows users to send all signals to user IRC=20
+##	client processes.
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
+template(`irc_send_all_signal_user_irc', `
+	gen_require(`
+		type $1_irc_t;
+	')
+
+	allow $2 $1_irc_t:process signal_perms;
+')
+
+########################################
+## <summary>
+##  Trace user IRC Client processes.
+## </summary>
+## <desc>
+##	<p>
+##	Allows users to trace user IRC=20
+##	Client processes.
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
+template(`irc_ptrace_user_irc', `
+	gen_require(`
+		type $1_irc_t;
+	')
+
+	allow $2 $1_irc_t:process ptrace;
 ')
diff --git a/policy/modules/apps/irc.te b/policy/modules/apps/irc.te
index 31208b6..186d98a 100644
--- a/policy/modules/apps/irc.te
+++ b/policy/modules/apps/irc.te
@@ -6,5 +6,17 @@ policy_module(irc, 1.4.0)
 # Declarations
 #
=20
+## <desc>
+## <p>
+## Allow IRC clients to bind TCP sockets to all
+## unreserved ports, and to connect
+## to all TCP ports.
+## </p>
+## </desc>
+gen_tunable(irc_unrestricted_tcp_network, false)
+
 type irc_exec_t;
 application_executable_file(irc_exec_t)
+
+type irc_etc_t;
+files_config_file(irc_etc_t)
diff --git a/policy/modules/system/userdomain.if
b/policy/modules/system/userdomain.if
index d52771f..4accb16 100644
--- a/policy/modules/system/userdomain.if
+++ b/policy/modules/system/userdomain.if
@@ -818,6 +818,11 @@ template(`userdom_common_user_template',`
 	')
=20
 	optional_policy(`
+		irc_send_all_signal_user_irc($1, $1_t)
+		irc_ptrace_user_irc($1, $1_t)
+	')
+
+	optional_policy(`
 		locate_read_lib_files($1_t)
 	')
=20
--=20
1.5.5.2

=46rom 9238a13b7bbc431798f6a41d30c5c684bf5b9780 Mon Sep 17 00:00:00 2001
From: Dominick Grift <domg472@gmail.com>
Date: Fri, 25 Jul 2008 13:35:06 +0200
Subject: [PATCH] Irc can send sigchld to user domain.

Signed-off-by: Dominick Grift <domg472@gmail.com>
---
 policy/modules/apps/irc.if |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/policy/modules/apps/irc.if b/policy/modules/apps/irc.if
index db7c8ca..c913a9d 100644
--- a/policy/modules/apps/irc.if
+++ b/policy/modules/apps/irc.if
@@ -69,6 +69,8 @@ template(`irc_per_role_template',`
 	allow $1_irc_t self:udp_socket { create_socket_perms };
 	allow $1_irc_t self:unix_stream_socket { create_stream_socket_perms };
=20
+	allow $1_irc_t $2:process sigchld;
+
 	allow $1_irc_t irc_etc_t:file read_file_perms;
=20
 	manage_dirs_pattern($1_irc_t, $1_irc_home_t, $1_irc_home_t)
--=20
1.5.5.2


--=20
Dominick Grift <domg472@gmail.com>

--=-FStSyN7nfhRnJJQzlA5i
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiJu80ACgkQL00QnzrVtlycOgCfQYqoKX84xsYGhhDRmd74keJF
2rAAoIkL6tYD68ZEcjao273ck5JAR6/t
=KBRR
-----END PGP SIGNATURE-----

--=-FStSyN7nfhRnJJQzlA5i--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

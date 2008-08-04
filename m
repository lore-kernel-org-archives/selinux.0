Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74CeJa1012530
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:40:19 -0400
Received: from palpatine.hardeman.nu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74CeDpq014748
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:40:13 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id 3C67526E
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:40:16 +0200 (CEST)
Message-Id: <20080804123736.226368715@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:35:06 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 10/35] qemu policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

None of these changes seem controversial, mostly a couple of new
interfaces, note that this patch relies on the xen patch.

Originally submitted Jul 19

Index: refpolicy/policy/modules/apps/qemu.if
===================================================================
--- refpolicy.orig/policy/modules/apps/qemu.if	2008-08-03 13:09:35.000000000 +0200
+++ refpolicy/policy/modules/apps/qemu.if	2008-08-03 17:17:33.000000000 +0200
@@ -104,7 +104,71 @@
 
 ########################################
 ## <summary>
-##	Execute a domain transition to run qemu unconfined.
+##	Execute qemu programs in the qemu domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <param name="role">
+##	<summary>
+##	The role to allow the PAM domain.
+##	</summary>
+## </param>
+## <param name="terminal">
+##	<summary>
+##	The type of the terminal allow the PAM domain to use.
+##	</summary>
+## </param>
+#
+interface(`qemu_runas',`
+	gen_require(`
+		type qemu_t;
+	')
+
+	qemu_domtrans($1)
+	allow qemu_t $3:chr_file rw_file_perms;
+')
+
+########################################
+## <summary>
+##	Execute qemu programs in the role.
+## </summary>
+## <param name="role">
+##	<summary>
+##	The role to allow the PAM domain.
+##	</summary>
+## </param>
+#
+interface(`qemu_role',`
+	gen_require(`
+		type qemu_t;
+	')
+	role $1 types qemu_t;
+')
+
+########################################
+## <summary>
+##	Execute qemu unconfined programs in the role.
+## </summary>
+## <param name="role">
+##	<summary>
+##	The role to allow the PAM domain.
+##	</summary>
+## </param>
+#
+interface(`qemu_unconfined_role',`
+	gen_require(`
+		type qemu_unconfined_t;
+	')
+	role $1 types qemu_unconfined_t;
+')
+
+
+########################################
+## <summary>
+##	Execute a domain transition to run qemu.
 ## </summary>
 ## <param name="domain">
 ## <summary>
@@ -122,6 +186,36 @@
 
 ########################################
 ## <summary>
+##	Execute qemu programs in the qemu unconfined domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <param name="role">
+##	<summary>
+##	The role to allow the PAM domain.
+##	</summary>
+## </param>
+## <param name="terminal">
+##	<summary>
+##	The type of the terminal allow the PAM domain to use.
+##	</summary>
+## </param>
+#
+interface(`qemu_runas_unconfined',`
+	gen_require(`
+		type qemu_unconfined_t;
+	')
+
+	qemu_domtrans_unconfined($1)
+	allow qemu_unconfined_t $3:chr_file rw_file_perms;
+')
+
+
+########################################
+## <summary>
 ##	Creates types and rules for a basic
 ##	qemu process domain.
 ## </summary>
@@ -133,24 +227,23 @@
 #
 template(`qemu_domain_template',`
 
-	##############################
-	#
-	# Local Policy
-	#
-
 	type $1_t;
 	domain_type($1_t)
 
 	type $1_tmp_t;
 	files_tmp_file($1_tmp_t)
 
+	type $1_tmpfs_t;
+	files_tmpfs_file($1_tmpfs_t)
+
 	##############################
 	#
 	# Local Policy
 	#
 
 	allow $1_t self:capability { dac_read_search dac_override };
-	allow $1_t self:process { execstack execmem signal getsched };
+	allow $1_t self:process { execstack execmem signal getsched signull };
+
 	allow $1_t self:fifo_file rw_file_perms;
 	allow $1_t self:shm create_shm_perms;
 	allow $1_t self:unix_stream_socket create_stream_socket_perms;
@@ -160,6 +253,11 @@
 	manage_files_pattern($1_t, $1_tmp_t, $1_tmp_t)
 	files_tmp_filetrans($1_t, $1_tmp_t, { file dir })
 
+	manage_dirs_pattern($1_t, $1_tmpfs_t, $1_tmpfs_t)
+	manage_files_pattern($1_t, $1_tmpfs_t, $1_tmpfs_t)
+	manage_lnk_files_pattern($1_t, $1_tmpfs_t, $1_tmpfs_t)
+	fs_tmpfs_filetrans($1_t, $1_tmpfs_t, { dir file lnk_file })
+
 	kernel_read_system_state($1_t)
 
 	corenet_all_recvfrom_unlabeled($1_t)
@@ -171,7 +269,10 @@
 	corenet_tcp_bind_vnc_port($1_t)
 	corenet_rw_tun_tap_dev($1_t)
 
-#	dev_rw_kvm($1_t)
+	dev_read_sound($1_t)
+	dev_write_sound($1_t)
+	dev_rw_kvm($1_t)
+	dev_rw_qemu($1_t)
 
 	domain_use_interactive_fds($1_t)
 
@@ -191,6 +292,8 @@
 	term_getattr_pty_fs($1_t)
 	term_use_generic_ptys($1_t)
 
+	auth_use_nsswitch($1_t)
+
 	libs_use_ld_so($1_t)
 	libs_use_shared_libs($1_t)
 
@@ -198,9 +301,9 @@
 
 	sysnet_read_config($1_t)
 
-#	optional_policy(`
-#		samba_domtrans_smb($1_t)
-#	')
+	optional_policy(`
+		samba_domtrans_smb($1_t)
+	')
 
 	optional_policy(`
 		virt_manage_images($1_t)
@@ -212,6 +315,24 @@
 		xserver_stream_connect_xdm_xserver($1_t)
 		xserver_read_xdm_tmp_files($1_t)
 		xserver_read_xdm_pid($1_t)
-#		xserver_xdm_rw_shm($1_t)
+		xserver_xdm_rw_shm($1_t)
 	')
 ')
+
+########################################
+## <summary>
+##	Set the schedule on qemu.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`qemu_setsched',`
+	gen_require(`
+		type qemu_t;
+	')
+
+	allow $1 qemu_t:process setsched;
+')
Index: refpolicy/policy/modules/apps/qemu.te
===================================================================
--- refpolicy.orig/policy/modules/apps/qemu.te	2008-08-03 13:09:35.000000000 +0200
+++ refpolicy/policy/modules/apps/qemu.te	2008-08-03 17:17:33.000000000 +0200
@@ -13,6 +13,20 @@
 ## </desc>
 gen_tunable(qemu_full_network, false)
 
+## <desc>
+## <p>
+## Allow qemu to use nfs file systems
+## </p>
+## </desc>
+gen_tunable(qemu_use_nfs, true)
+
+## <desc>
+## <p>
+## Allow qemu to use cifs/Samba file systems
+## </p>
+## </desc>
+gen_tunable(qemu_use_cifs, true)
+
 type qemu_exec_t;
 qemu_domain_template(qemu)
 application_domain(qemu_t, qemu_exec_t)
@@ -35,6 +49,22 @@
 	corenet_tcp_connect_all_ports(qemu_t)
 ')
 
+tunable_policy(`qemu_use_nfs',`
+	fs_manage_nfs_files(qemu_t)
+')
+
+tunable_policy(`qemu_use_cifs',`
+	fs_manage_cifs_dirs(qemu_t)
+')
+
+optional_policy(`
+	xen_rw_image_files(qemu_t)
+')
+
+optional_policy(`
+	xen_rw_image_files(qemu_t)
+')
+
 ########################################
 #
 # qemu_unconfined local policy

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

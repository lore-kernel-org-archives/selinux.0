Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6NE2ThO032519
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2008 10:02:29 -0400
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6NE2R2W016726
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2008 14:02:28 GMT
Received: by nf-out-0910.google.com with SMTP id b21so1068325nfd.4
        for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2008 07:02:27 -0700 (PDT)
Subject: [refpolicy patch 1/2] revisit and apply trivial redhat
	modifications to amanda module
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YX0aRbY8/WyvhbRsqnSR"
Date: Wed, 23 Jul 2008 16:02:20 +0200
Message-Id: <1216821740.14984.7.camel@sulphur.notebook.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-YX0aRbY8/WyvhbRsqnSR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This patch aims to clean up the amanda module and to apply trivial
redhat modifications to refpolicy amanda module.

Note: fstools_signal() call did not exist and there was also no redhat
patch for this interface, and so i created one myself.

However , i do not know for sure if only signal perm was meant with
fstools_signal:
http://people.fedoraproject.org/~dwalsh/SELinux/Policy/admin_amanda.patch

refer to [refpolicy patch 2/2] revisit and apply trivial modifications
to fstools module.

Index: /home/domg472/Workspace/refpolicy_trunk/policy/modules/admin/amanda.=
if
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /home/domg472/Workspace/refpolicy_trunk/policy/modules/admin/amanda.if	=
(revision 2761)
+++ /home/domg472/Workspace/refpolicy_trunk/policy/modules/admin/amanda.if	=
(working copy)
@@ -15,7 +15,7 @@
 		type amanda_recover_t, amanda_recover_exec_t;
 	')
=20
-	domtrans_pattern($1,amanda_recover_exec_t,amanda_recover_t)
+	domtrans_pattern($1, amanda_recover_exec_t, amanda_recover_t)
 ')
=20
 ########################################
@@ -47,7 +47,7 @@
=20
 	amanda_domtrans_recover($1)
 	role $2 types amanda_recover_t;
-	allow amanda_recover_t $3:chr_file rw_term_perms;
+	rw_chr_files_pattern(amanda_recover_t, $3, $3)=09
 ')
=20
 ########################################
@@ -65,8 +65,8 @@
 		type amanda_usr_lib_t;
 	')
=20
-	allow $1 amanda_usr_lib_t:dir search_dir_perms;
 	files_search_usr($1)
+	search_dirs_pattern($1, amanda_usr_lib_t, amanda_usr_lib_t)
 ')
=20
 ########################################
@@ -102,7 +102,7 @@
 		type amanda_dumpdates_t;
 	')
=20
-	allow $1 amanda_dumpdates_t:file rw_file_perms;
+	rw_files_pattern($1, amanda_dumpdates_t, amanda_dumpdates_t)
 ')
=20
 ########################################
@@ -120,8 +120,8 @@
 		type amanda_usr_lib_t;
 	')
=20
-	allow $1 amanda_usr_lib_t:dir manage_dir_perms;
 	files_search_usr($1)
+	manage_dirs_pattern($1, amanda_usr_lib_t, amanda_usr_lib_t)
 ')
=20
 ########################################
@@ -139,7 +139,8 @@
 		type amanda_log_t;
 	')
=20
-	allow $1 amanda_log_t:file { read_file_perms append_file_perms };
+	read_files_pattern($1, amanda_log_t, amanda_log_t)
+	append_files_pattern($1, amanda_log_t, amanda_log_t)
 ')
=20
 #######################################
@@ -158,6 +159,5 @@
 	')
=20
 	files_search_var_lib($1)
-	allow $1 amanda_var_lib_t:dir search_dir_perms;
-
+	search_dirs_pattern($1, amanda_var_lib_t, amanda_var_lib_t)
 ')
Index: /home/domg472/Workspace/refpolicy_trunk/policy/modules/admin/amanda.=
te
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /home/domg472/Workspace/refpolicy_trunk/policy/modules/admin/amanda.te	=
(revision 2761)
+++ /home/domg472/Workspace/refpolicy_trunk/policy/modules/admin/amanda.te	=
(working copy)
@@ -8,53 +8,44 @@
=20
 type amanda_t;
 type amanda_inetd_exec_t;
-inetd_service_domain(amanda_t,amanda_inetd_exec_t)
+inetd_service_domain(amanda_t, amanda_inetd_exec_t)
 role system_r types amanda_t;
=20
 type amanda_exec_t;
-domain_entry_file(amanda_t,amanda_exec_t)
+domain_entry_file(amanda_t, amanda_exec_t)
=20
 type amanda_log_t;
 logging_log_file(amanda_log_t)
=20
-# type for amanda configurations files
 type amanda_config_t;
 files_type(amanda_config_t)
=20
-# type for files in /usr/lib/amanda
 type amanda_usr_lib_t;
 files_type(amanda_usr_lib_t)
=20
-# type for all files in /var/lib/amanda
 type amanda_var_lib_t;
 files_type(amanda_var_lib_t)
=20
-# type for all files in /var/lib/amanda/gnutar-lists/
 type amanda_gnutarlists_t;
 files_type(amanda_gnutarlists_t)
=20
 type amanda_tmp_t;
 files_tmp_file(amanda_tmp_t)
=20
-# type for /etc/amandates
 type amanda_amandates_t;
 files_type(amanda_amandates_t)
=20
-# type for /etc/dumpdates
 type amanda_dumpdates_t;
 files_type(amanda_dumpdates_t)
=20
-# type for amanda data
 type amanda_data_t;
 files_type(amanda_data_t)
=20
-# type for amrecover
 type amanda_recover_t;
 type amanda_recover_exec_t;
-application_domain(amanda_recover_t,amanda_recover_exec_t)
+application_domain(amanda_recover_t, amanda_recover_exec_t)
 role system_r types amanda_recover_t;
=20
-# type for recover files ( restored data )
 type amanda_recover_dir_t;
 files_type(amanda_recover_dir_t)
=20
@@ -75,38 +66,31 @@
 allow amanda_t self:tcp_socket create_stream_socket_perms;
 allow amanda_t self:udp_socket create_socket_perms;
=20
-# access to amanda_amandates_t
-allow amanda_t amanda_amandates_t:file { getattr lock read write };
+can_exec(amanda_t, amanda_exec_t)
+can_exec(amanda_t, amanda_inetd_exec_t)
=20
-# configuration files -> read only
-allow amanda_t amanda_config_t:file { getattr read };
+manage_files_pattern(amanda_t, amanda_data_t, amanda_data_t)
=20
-# access to amandas data structure
-allow amanda_t amanda_data_t:dir { read search write };
-allow amanda_t amanda_data_t:file manage_file_perms;
+manage_files_pattern(amanda_t, amanda_gnutarlists_t,
amanda_gnutarlists_t)
+manage_lnk_files_pattern(amanda_t, amanda_gnutarlists_t,
amanda_gnutarlists_t)
=20
-# access to amanda_dumpdates_t
-allow amanda_t amanda_dumpdates_t:file { getattr lock read write };
-
-can_exec(amanda_t,amanda_exec_t)
-can_exec(amanda_t,amanda_inetd_exec_t)
-
-# access to amanda_gnutarlists_t (/var/lib/amanda/gnutar-lists)
-allow amanda_t amanda_gnutarlists_t:dir rw_dir_perms;
-allow amanda_t amanda_gnutarlists_t:file manage_file_perms;
-allow amanda_t amanda_gnutarlists_t:lnk_file manage_lnk_file_perms;
-
 manage_dirs_pattern(amanda_t,amanda_var_lib_t,amanda_var_lib_t)
 manage_files_pattern(amanda_t,amanda_var_lib_t,amanda_var_lib_t)
=20
-manage_files_pattern(amanda_t,amanda_log_t,amanda_log_t)
-manage_dirs_pattern(amanda_t,amanda_log_t,amanda_log_t)
-logging_log_filetrans(amanda_t,amanda_log_t,{ file dir })
+manage_files_pattern(amanda_t, amanda_log_t, amanda_log_t)
+manage_dirs_pattern(amanda_t, amanda_log_t, amanda_log_t)
+logging_log_filetrans(amanda_t, amanda_log_t, { file dir })
=20
-manage_files_pattern(amanda_t,amanda_tmp_t,amanda_tmp_t)
-manage_dirs_pattern(amanda_t,amanda_tmp_t,amanda_tmp_t)
+manage_files_pattern(amanda_t, amanda_tmp_t, amanda_tmp_t)
+manage_dirs_pattern(amanda_t, amanda_tmp_t, amanda_tmp_t)
 files_tmp_filetrans(amanda_t, amanda_tmp_t, { file dir })
=20
+read_files_pattern(amanda_t, amanda_config_t, amanda_config_t)
+
+rw_files_pattern(amanda_t, amanda_dumpdates_t, amanda_dumpdates_t)
+
+rw_files_pattern(amanda_t, amanda_amandates_t, amanda_amandates_t)
+
 kernel_read_system_state(amanda_t)
 kernel_read_kernel_sysctls(amanda_t)
 kernel_dontaudit_getattr_unlabeled_files(amanda_t)
@@ -145,9 +129,13 @@
 fs_getattr_xattr_fs(amanda_t)
 fs_list_all(amanda_t)
=20
+fstools_domtrans(amanda_t)
+fstools_signal(amanda_t)
+
 storage_raw_read_fixed_disk(amanda_t)
+storage_read_tape(amanda_t)
+storage_write_tape(amanda_t)
=20
-# Added for targeted policy
 term_use_unallocated_ttys(amanda_t)
=20
 auth_use_nsswitch(amanda_t)
@@ -156,11 +144,8 @@
 libs_use_ld_so(amanda_t)
 libs_use_shared_libs(amanda_t)
=20
+logging_send_syslog_msg(amanda_t)
=20
-optional_policy(`
-	logging_send_syslog_msg(amanda_t)
-')
-
 ########################################
 #
 # Amanda recover local policy
@@ -172,23 +157,22 @@
 allow amanda_recover_t self:tcp_socket create_stream_socket_perms;
 allow amanda_recover_t self:udp_socket create_socket_perms;
=20
-manage_files_pattern(amanda_recover_t,amanda_log_t,amanda_log_t)
-manage_lnk_files_pattern(amanda_recover_t,amanda_log_t,amanda_log_t)
+manage_files_pattern(amanda_recover_t, amanda_log_t, amanda_log_t)
+manage_lnk_files_pattern(amanda_recover_t, amanda_log_t, amanda_log_t)
=20
-# access to amanda_recover_dir_t
-manage_dirs_pattern(amanda_recover_t,amanda_recover_dir_t,amanda_recover_d=
ir_t)
-manage_files_pattern(amanda_recover_t,amanda_recover_dir_t,amanda_recover_=
dir_t)
-manage_lnk_files_pattern(amanda_recover_t,amanda_recover_dir_t,amanda_reco=
ver_dir_t)
-manage_fifo_files_pattern(amanda_recover_t,amanda_recover_dir_t,amanda_rec=
over_dir_t)
-manage_sock_files_pattern(amanda_recover_t,amanda_recover_dir_t,amanda_rec=
over_dir_t)
-sysadm_home_dir_filetrans(amanda_recover_t,amanda_recover_dir_t,{ dir
file lnk_file sock_file fifo_file })
+manage_dirs_pattern(amanda_recover_t, amanda_recover_dir_t,
amanda_recover_dir_t)
+manage_files_pattern(amanda_recover_t, amanda_recover_dir_t,
amanda_recover_dir_t)
+manage_lnk_files_pattern(amanda_recover_t, amanda_recover_dir_t,
amanda_recover_dir_t)
+manage_fifo_files_pattern(amanda_recover_t, amanda_recover_dir_t,
amanda_recover_dir_t)
+manage_sock_files_pattern(amanda_recover_t, amanda_recover_dir_t,
amanda_recover_dir_t)
+sysadm_home_dir_filetrans(amanda_recover_t, amanda_recover_dir_t, { dir
file lnk_file sock_file fifo_file })
=20
-manage_dirs_pattern(amanda_recover_t,amanda_tmp_t,amanda_tmp_t)
-manage_files_pattern(amanda_recover_t,amanda_tmp_t,amanda_tmp_t)
-manage_lnk_files_pattern(amanda_recover_t,amanda_tmp_t,amanda_tmp_t)
-manage_fifo_files_pattern(amanda_recover_t,amanda_tmp_t,amanda_tmp_t)
-manage_sock_files_pattern(amanda_recover_t,amanda_tmp_t,amanda_tmp_t)
-files_tmp_filetrans(amanda_recover_t,amanda_tmp_t,{ dir file lnk_file
sock_file fifo_file })
+manage_dirs_pattern(amanda_recover_t, amanda_tmp_t, amanda_tmp_t)
+manage_files_pattern(amanda_recover_t, amanda_tmp_t, amanda_tmp_t)
+manage_lnk_files_pattern(amanda_recover_t, amanda_tmp_t, amanda_tmp_t)
+manage_fifo_files_pattern(amanda_recover_t, amanda_tmp_t, amanda_tmp_t)
+manage_sock_files_pattern(amanda_recover_t, amanda_tmp_t, amanda_tmp_t)
+files_tmp_filetrans(amanda_recover_t, amanda_tmp_t, { dir file lnk_file
sock_file fifo_file })
=20
 kernel_read_system_state(amanda_recover_t)
 kernel_read_kernel_sysctls(amanda_recover_t)
@@ -219,8 +203,6 @@
=20
 auth_use_nsswitch(amanda_recover_t)
=20
-fstools_domtrans(amanda_t)
-
 libs_use_ld_so(amanda_recover_t)
 libs_use_shared_libs(amanda_recover_t)
=20

--=20
Dominick Grift <domg472@gmail.com>

--=-YX0aRbY8/WyvhbRsqnSR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiHOeoACgkQL00QnzrVtlzw5QCgwlJw3pg20EE5Ln53rr9zDQUA
on0AoKsb/D8LsRRTS46YTdUOroxOK0p1
=m8ct
-----END PGP SIGNATURE-----

--=-YX0aRbY8/WyvhbRsqnSR--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

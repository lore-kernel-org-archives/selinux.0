Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6NE6KA7000825
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2008 10:06:20 -0400
Received: from ug-out-1314.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6NE6Is4020381
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2008 14:06:19 GMT
Received: by ug-out-1314.google.com with SMTP id m3so523432ugc.15
        for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2008 07:06:18 -0700 (PDT)
Subject: [refpolicy patch 2/2] revisit and apply trivial modifications to
	fstools module.
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yf7uaDtIDxQPaPvSupwg"
Date: Wed, 23 Jul 2008 16:06:16 +0200
Message-Id: <1216821976.14984.12.camel@sulphur.notebook.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-yf7uaDtIDxQPaPvSupwg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This patch aims to clean the fstools module, and to apply trivial
modifications to the fstools module.

Refer to [refpolicy patch 1/2] revisit and apply trivial redhat
modifications to fstools module.

Index: /home/domg472/Workspace/refpolicy_trunk/policy/modules/system/fstool=
s.if
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /home/domg472/Workspace/refpolicy_trunk/policy/modules/system/fstools.i=
f	(revision 2758)
+++ /home/domg472/Workspace/refpolicy_trunk/policy/modules/system/fstools.i=
f	(working copy)
@@ -16,7 +16,7 @@
 	')
=20
 	corecmd_search_bin($1)
-	domtrans_pattern($1,fsadm_exec_t,fsadm_t)
+	domtrans_pattern($1, fsadm_exec_t, fsadm_t)
 ')
=20
 ########################################
@@ -48,7 +48,7 @@
=20
 	fstools_domtrans($1)
 	role $2 types fsadm_t;
-	allow fsadm_t $3:chr_file { getattr read write ioctl };
+	rw_chr_files_pattern(fsadm_t, $3, $3)
 ')
=20
 ########################################
@@ -66,7 +66,7 @@
 		type fsadm_exec_t;
 	')
=20
-	can_exec($1,fsadm_exec_t)
+	can_exec($1, fsadm_exec_t)
 ')
=20
 ########################################
@@ -84,7 +84,7 @@
 		type fsadm_t;
 	')
=20
-	allow $1 fsadm_t:fifo_file read_fifo_file_perms;
+	read_fifo_files_pattern($1, fsadm_t, fsadm_t)
 ')
=20
 ########################################
@@ -103,7 +103,7 @@
 		type fsadm_exec_t;
 	')
=20
-	allow $1 fsadm_exec_t:file relabelto;
+	relabelto_files_pattern($1, fsadm_exec_t, fsadm_exec_t)
 ')
=20
 ########################################
@@ -122,7 +122,7 @@
 		type fsadm_exec_t;
 	')
=20
-	allow $1 fsadm_exec_t:file manage_file_perms;
+	manage_files_pattern($1, fsadm_exec_t, fsadm_exec_t)
 ')
=20
 ########################################
@@ -140,5 +140,23 @@
 		type swapfile_t;
 	')
=20
-	allow $1 swapfile_t:file getattr;
+	getattr_files_pattern($1, swapfile_t, swapfile_t)
 ')
+
+########################################
+## <summary>
+##	Signal the fstools domain.
+## </summary>
+## <param name=3D"domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`fstools_signal',`
+	gen_require(`
+		type fsadm_t;
+	')
+
+	allow $1 fsadm_t:process signal;
+')
Index: /home/domg472/Workspace/refpolicy_trunk/policy/modules/system/fstool=
s.te
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /home/domg472/Workspace/refpolicy_trunk/policy/modules/system/fstools.t=
e	(revision 2758)
+++ /home/domg472/Workspace/refpolicy_trunk/policy/modules/system/fstools.t=
e	(working copy)
@@ -1,5 +1,5 @@
=20
-policy_module(fstools,1.10.0)
+policy_module(fstools, 1.10.0)
=20
 ########################################
 #
@@ -8,7 +8,7 @@
=20
 type fsadm_t;
 type fsadm_exec_t;
-init_system_domain(fsadm_t,fsadm_exec_t)
+init_system_domain(fsadm_t, fsadm_exec_t)
 role system_r types fsadm_t;
=20
 type fsadm_log_t;
@@ -42,17 +42,16 @@
=20
 can_exec(fsadm_t, fsadm_exec_t)
=20
-allow fsadm_t fsadm_tmp_t:dir manage_dir_perms;
-allow fsadm_t fsadm_tmp_t:file manage_file_perms;
+manage_dirs_pattern(fsadm_t, fsadm_tmp_t, fsadm_tmp_t)
+manage_files_pattern(fsadm_t, fsadm_tmp_t, fsadm_tmp_t)
 files_tmp_filetrans(fsadm_t, fsadm_tmp_t, { file dir })
=20
-# log files
-allow fsadm_t fsadm_log_t:dir setattr;
-manage_files_pattern(fsadm_t,fsadm_log_t,fsadm_log_t)
-logging_log_filetrans(fsadm_t,fsadm_log_t,file)
+manage_files_pattern(fsadm_t, fsadm_log_t, fsadm_log_t)
+logging_log_filetrans(fsadm_t, fsadm_log_t, file)
=20
 # Enable swapping to files
-allow fsadm_t swapfile_t:file { rw_file_perms swapon };
+allow fsadm_t swapfile_t:file swapon; # this is no file perm!
+manage_files_pattern(fsadm_t, swapfile_t, swapfile_t)
=20
 kernel_read_system_state(fsadm_t)
 kernel_read_kernel_sysctls(fsadm_t)
@@ -110,7 +109,6 @@
 term_use_console(fsadm_t)
=20
 corecmd_exec_bin(fsadm_t)
-#RedHat bug #201164
 corecmd_exec_shell(fsadm_t)
=20
 # cjp: these are probably not needed:
@@ -170,7 +168,7 @@
=20
 optional_policy(`
 	# for smartctl cron jobs
-	cron_system_entry(fsadm_t,fsadm_exec_t)
+	cron_system_entry(fsadm_t, fsadm_exec_t)
 ')
=20
 optional_policy(`

--=20
Dominick Grift <domg472@gmail.com>

--=-yf7uaDtIDxQPaPvSupwg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiHOtcACgkQL00QnzrVtlzVHgCgviRDnoxWCpoK0rtrgFxBABbd
LpsAnj1VRbMw7FUlIHK7+IhoX1/udkdO
=n8lA
-----END PGP SIGNATURE-----

--=-yf7uaDtIDxQPaPvSupwg--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

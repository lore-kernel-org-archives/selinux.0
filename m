Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k95CiuaQ018850
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 08:44:56 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k95CiHXA012155
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 12:44:18 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id D9C6961B0F
	for <selinux@tycho.nsa.gov>; Thu,  5 Oct 2006 22:44:52 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp.sws.net.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sajJ2kVHHuPI for <selinux@tycho.nsa.gov>;
	Thu,  5 Oct 2006 22:44:52 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 8510161B09
	for <selinux@tycho.nsa.gov>; Thu,  5 Oct 2006 22:44:52 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 73455A7DDB
	for <selinux@tycho.nsa.gov>; Thu,  5 Oct 2006 22:44:51 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: policy patch against subversion tree
Date: Thu, 5 Oct 2006 22:44:49 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_D5PJF0UWxrxMdnS"
Message-Id: <200610052244.51091.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_D5PJF0UWxrxMdnS
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Allow unconfined processes to see unlabeled processes in ps.

Removed a redundant rule in samba.te, and some inappropriate permissions in 
amavis.te.

Removed support for the pre-Fedora Red Hat code to create sym-links in /boot.

Removed support for devpts_t files in /tmp (there is no way that would ever 
work).

Allowed postgrey to create socket files.

Made the specs for the /lib and /lib64 directories better support stem 
compression.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--Boundary-00=_D5PJF0UWxrxMdnS
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru policy.orig/modules/kernel/files.if policy/modules/kernel/files.if
--- policy.orig/modules/kernel/files.if	2006-10-05 22:30:53.000000000 +1000
+++ policy/modules/kernel/files.if	2006-10-05 22:33:15.000000000 +1000
@@ -1390,26 +1390,6 @@
 
 ########################################
 ## <summary>
-##	Read and write symbolic links
-##	in the /boot directory.
-## </summary>
-## <param name="domain">
-##	<summary>
-##	Domain allowed access.
-##	</summary>
-## </param>
-#
-interface(`files_rw_boot_symlinks',`
-	gen_require(`
-		type boot_t;
-	')
-
-	allow $1 boot_t:dir r_dir_perms;
-	allow $1 boot_t:lnk_file rw_file_perms;
-')
-
-########################################
-## <summary>
 ##	Create, read, write, and delete symbolic links
 ##	in the /boot directory.
 ## </summary>
diff -ru policy.orig/modules/kernel/kernel.if policy/modules/kernel/kernel.if
--- policy.orig/modules/kernel/kernel.if	2006-10-05 22:30:53.000000000 +1000
+++ policy/modules/kernel/kernel.if	2006-10-05 22:33:15.000000000 +1000
@@ -2060,6 +2060,24 @@
 
 ########################################
 ## <summary>
+##	Allow caller to stat unlabeled processes.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`kernel_getattr_unlabeled_procs',`
+	gen_require(`
+		type unlabeled_t;
+	')
+
+	allow $1 unlabeled_t:process getattr;
+')
+
+########################################
+## <summary>
 ##	Allow caller to relabel unlabeled files.
 ## </summary>
 ## <param name="domain">
diff -ru policy.orig/modules/kernel/terminal.te policy/modules/kernel/terminal.te
--- policy.orig/modules/kernel/terminal.te	2006-10-05 22:30:53.000000000 +1000
+++ policy/modules/kernel/terminal.te	2006-10-05 22:33:15.000000000 +1000
@@ -28,7 +28,6 @@
 type devpts_t;
 files_mountpoint(devpts_t)
 fs_associate_tmpfs(devpts_t)
-files_associate_tmp(devpts_t)
 fs_type(devpts_t)
 fs_use_trans devpts gen_context(system_u:object_r:devpts_t,s0);
 
diff -ru policy.orig/modules/services/amavis.te policy/modules/services/amavis.te
--- policy.orig/modules/services/amavis.te	2006-10-05 22:31:08.000000000 +1000
+++ policy/modules/services/amavis.te	2006-10-05 22:33:15.000000000 +1000
@@ -50,6 +50,7 @@
 allow amavis_t self:unix_stream_socket create_stream_socket_perms;
 allow amavis_t self:unix_dgram_socket create_socket_perms;
 allow amavis_t self:tcp_socket { listen accept };
+kernel_read_proc_symlinks(amavis_t)
 
 # configuration files
 allow amavis_t amavis_etc_t:dir r_dir_perms;
@@ -66,7 +67,6 @@
 allow amavis_t amavis_spool_t:dir manage_dir_perms;
 allow amavis_t amavis_spool_t:file manage_file_perms;
 allow amavis_t amavis_spool_t:sock_file manage_file_perms;
-files_spool_filetrans(amavis_t,amavis_spool_t,{ dir file })
 type_transition amavis_t amavis_spool_t:sock_file amavis_var_run_t;
 
 # tmp files
@@ -78,8 +78,6 @@
 allow amavis_t amavis_var_lib_t:file create_file_perms;
 allow amavis_t amavis_var_lib_t:sock_file create_file_perms;
 allow amavis_t amavis_var_lib_t:dir create_dir_perms;
-files_var_filetrans(amavis_t,amavis_var_lib_t,{ file dir sock_file })
-files_var_lib_filetrans(amavis_t,amavis_var_lib_t,file)
 
 # log files
 allow amavis_t amavis_var_log_t:file create_file_perms;
diff -ru policy.orig/modules/services/mailman.te policy/modules/services/mailman.te
--- policy.orig/modules/services/mailman.te	2006-10-05 22:31:08.000000000 +1000
+++ policy/modules/services/mailman.te	2006-10-05 22:33:15.000000000 +1000
@@ -40,6 +40,9 @@
 
 	dev_read_urand(mailman_cgi_t)
 
+# for python pre-compile foolishness
+	dontaudit mailman_cgi_t lib_t:dir write;
+
 	allow mailman_cgi_t mailman_archive_t:dir create_dir_perms;
 	allow mailman_cgi_t mailman_archive_t:lnk_file create_lnk_perms;
 	allow mailman_cgi_t mailman_archive_t:file create_file_perms;
diff -ru policy.orig/modules/services/postgrey.te policy/modules/services/postgrey.te
--- policy.orig/modules/services/postgrey.te	2006-10-05 22:31:08.000000000 +1000
+++ policy/modules/services/postgrey.te	2006-10-05 22:33:15.000000000 +1000
@@ -18,6 +18,8 @@
 
 type postgrey_var_run_t;
 files_pid_file(postgrey_var_run_t)
+files_pid_filetrans(postgrey_t, postgrey_var_run_t, sock_file)
+allow postgrey_t postgrey_var_run_t:sock_file manage_file_perms;
 
 ########################################
 #
diff -ru policy.orig/modules/services/samba.te policy/modules/services/samba.te
--- policy.orig/modules/services/samba.te	2006-10-05 22:31:09.000000000 +1000
+++ policy/modules/services/samba.te	2006-10-05 22:33:15.000000000 +1000
@@ -501,10 +501,6 @@
 userdom_use_sysadm_ttys(smbmount_t)
 
 optional_policy(`
-	cups_read_rw_config(smbd_t)
-')
-
-optional_policy(`
 	nis_use_ypbind(smbmount_t)
 ')
 
diff -ru policy.orig/modules/system/init.te policy/modules/system/init.te
--- policy.orig/modules/system/init.te	2006-10-05 22:31:10.000000000 +1000
+++ policy/modules/system/init.te	2006-10-05 22:33:15.000000000 +1000
@@ -430,11 +430,6 @@
 
 	selinux_set_enforce_mode(initrc_t)
 
-	# Create and read /boot/kernel.h and /boot/System.map.
-	# Redhat systems typically create this file at boot time.
-	bootloader_create_runtime_file(initrc_t)
-	files_rw_boot_symlinks(initrc_t)
-
 	# These seem to be from the initrd
 	# during device initialization:
 	dev_create_generic_dirs(initrc_t)
diff -ru policy.orig/modules/system/libraries.fc policy/modules/system/libraries.fc
--- policy.orig/modules/system/libraries.fc	2006-10-05 22:31:10.000000000 +1000
+++ policy/modules/system/libraries.fc	2006-10-05 22:33:15.000000000 +1000
@@ -41,8 +41,10 @@
 #
 # /lib(64)?
 #
-/lib(/.*)?					gen_context(system_u:object_r:lib_t,s0)
-/lib64(/.*)?					gen_context(system_u:object_r:lib_t,s0)
+/lib					-d	gen_context(system_u:object_r:lib_t,s0)
+/lib/.*						gen_context(system_u:object_r:lib_t,s0)
+/lib64					-d	gen_context(system_u:object_r:lib_t,s0)
+/lib64/.*					gen_context(system_u:object_r:lib_t,s0)
 /lib/.+\.so(\.[^/]*)*			--	gen_context(system_u:object_r:shlib_t,s0)
 /lib64/.+\.so(\.[^/]*)*			--	gen_context(system_u:object_r:shlib_t,s0)
 /lib/ld-[^/]*\.so(\.[^/]*)*		--	gen_context(system_u:object_r:ld_so_t,s0)
@@ -57,7 +59,8 @@
 ')
 
 ifdef(`distro_gentoo',`
-/lib32(/.*)?					gen_context(system_u:object_r:lib_t,s0)
+/lib32					-d	gen_context(system_u:object_r:lib_t,s0)
+/lib32/.*					gen_context(system_u:object_r:lib_t,s0)
 /lib32/.+\.so(\.[^/]*)*			--	gen_context(system_u:object_r:shlib_t,s0)
 /lib32/ld-[^/]*\.so(\.[^/]*)*		--	gen_context(system_u:object_r:ld_so_t,s0)
 ')
diff -ru policy.orig/modules/system/unconfined.if policy/modules/system/unconfined.if
--- policy.orig/modules/system/unconfined.if	2006-10-05 22:31:10.000000000 +1000
+++ policy/modules/system/unconfined.if	2006-10-05 22:33:15.000000000 +1000
@@ -88,6 +88,11 @@
 	optional_policy(`
 		storage_unconfined($1)
 	')
+
+	optional_policy(`
+		kernel_getattr_unlabeled_procs($1)
+		kernel_kill_unlabeled($1)
+	')
 ')
 
 ########################################

--Boundary-00=_D5PJF0UWxrxMdnS--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

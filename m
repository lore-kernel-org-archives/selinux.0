Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KMkut023642
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:22:46 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KMiTm003561
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:22:44 GMT
Date: Thu, 2 Aug 2007 16:22:23 -0400
Message-Id: <200708022022.l72KMNHo031978@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: system_mount changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Added mount_ntfs back into mount domain
mount uses nsswitch
Other random fixes
Fusermount is its own policy

--- nsaserefpolicy/policy/modules/system/mount.fc	2007-05-29 14:10:58.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/system/mount.fc	2007-08-02 11:02:02.000000000 -0400
@@ -1,4 +1,2 @@
 /bin/mount.*			--	gen_context(system_u:object_r:mount_exec_t,s0)
 /bin/umount.*			--	gen_context(system_u:object_r:mount_exec_t,s0)
-
-/usr/bin/fusermount		--	gen_context(system_u:object_r:mount_exec_t,s0)
--- nsaserefpolicy/policy/modules/system/mount.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/system/mount.te	2007-08-02 11:02:02.000000000 -0400
@@ -8,6 +8,13 @@
 
 ## <desc>
 ## <p>
+## Allow mount to mount any dir
+## </p>
+## </desc>
+gen_tunable(allow_mounton_anydir,true)
+
+## <desc>
+## <p>
 ## Allow mount to mount any file
 ## </p>
 ## </desc>
@@ -16,19 +23,21 @@
 type mount_t;
 type mount_exec_t;
 init_system_domain(mount_t,mount_exec_t)
+application_executable_file(mount_exec_t)
 role system_r types mount_t;
 
+typealias mount_t alias mount_ntfs_t;
+typealias mount_exec_t alias mount_ntfs_exec_t;
+
 type mount_loopback_t; # customizable
 files_type(mount_loopback_t)
 
 type mount_tmp_t;
 files_tmp_file(mount_tmp_t)
 
-# causes problems with interfaces when
-# this is optionally declared in monolithic
-# policy--duplicate type declaration
 type unconfined_mount_t;
 application_domain(unconfined_mount_t,mount_exec_t)
+role system_r types unconfined_mount_t;
 
 ########################################
 #
@@ -36,14 +45,15 @@
 #
 
 # setuid/setgid needed to mount cifs 
-allow mount_t self:capability { ipc_lock sys_rawio sys_admin dac_override chown sys_tty_config setuid setgid };
+allow mount_t self:capability { fsetid ipc_lock sys_rawio sys_resource sys_admin dac_override chown sys_tty_config setuid setgid };
 
 allow mount_t mount_loopback_t:file read_file_perms;
-allow mount_t self:netlink_route_socket r_netlink_socket_perms;
 
 allow mount_t mount_tmp_t:file manage_file_perms;
 allow mount_t mount_tmp_t:dir manage_dir_perms;
 
+auth_use_nsswitch(mount_t)
+
 can_exec(mount_t, mount_exec_t)
 
 files_tmp_filetrans(mount_t,mount_tmp_t,{ file dir })
@@ -51,6 +61,7 @@
 kernel_read_system_state(mount_t)
 kernel_read_kernel_sysctls(mount_t)
 kernel_dontaudit_getattr_core_if(mount_t)
+kernel_search_debugfs(mount_t)
 
 dev_getattr_all_blk_files(mount_t)
 dev_list_all_dev_nodes(mount_t)
@@ -101,6 +112,8 @@
 init_use_fds(mount_t)
 init_use_script_ptys(mount_t)
 init_dontaudit_getattr_initctl(mount_t)
+init_stream_connect_script(mount_t)
+init_rw_script_stream_sockets(mount_t)
 
 libs_use_ld_so(mount_t)
 libs_use_shared_libs(mount_t)
@@ -127,10 +140,15 @@
 	')
 ')
 
+tunable_policy(`allow_mounton_anydir',`
+	auth_read_all_dirs_except_shadow(mount_t)
+	files_mounton_non_security_dir(mount_t)
+')
+
 tunable_policy(`allow_mount_anyfile',`
 	auth_read_all_dirs_except_shadow(mount_t)
 	auth_read_all_files_except_shadow(mount_t)
-	files_mounton_non_security(mount_t)
+	files_mounton_non_security_files(mount_t)
 ')
 
 optional_policy(`
@@ -159,13 +177,8 @@
 
 	fs_search_rpc(mount_t)
 
-	sysnet_dns_name_resolve(mount_t)
-
 	rpc_stub(mount_t)
 
-	optional_policy(`
-		nis_use_ypbind(mount_t)
-	')
 ')
 
 optional_policy(`
@@ -189,10 +202,6 @@
 	samba_domtrans_smbmount(mount_t)
 ')
 
-optional_policy(`
-	nscd_socket_use(mount_t)
-')
-
 ########################################
 #
 # Unconfined mount local policy
@@ -201,4 +210,29 @@
 optional_policy(`
 	files_etc_filetrans_etc_runtime(unconfined_mount_t,file)
 	unconfined_domain(unconfined_mount_t)
+	optional_policy(`
+		hal_dbus_chat(unconfined_mount_t)
+	')
+')
+
+########################################
+#
+# ntfs local policy
+#
+allow mount_t self:fifo_file { read write };
+allow mount_t self:unix_stream_socket create_stream_socket_perms;
+allow mount_t self:unix_dgram_socket { connect create };
+
+corecmd_exec_shell(mount_t)
+
+fusermount_domtrans(mount_t)
+fusermount_use_fds(mount_t)
+
+# modutils_domtrans_insmod(mount_t)
+
+optional_policy(`
+	hal_write_log(mount_t)
+	hal_use_fds(mount_t)
+	hal_rw_pipes(mount_t)
 ')
+

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

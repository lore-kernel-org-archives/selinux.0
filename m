Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NJWHSD006515
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 15:32:17 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NJWFsr008384
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 19:32:15 GMT
Message-ID: <46042B39.8040208@redhat.com>
Date: Fri, 23 Mar 2007 15:32:09 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: mount_ntfs policy
Content-Type: multipart/mixed;
 boundary="------------090802000305030502050208"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090802000305030502050208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------090802000305030502050208
Content-Type: text/x-patch;
 name="mount_ntfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mount_ntfs.patch"

--- nsaserefpolicy/policy/modules/system/mount.fc	2006-11-16 17:15:24.000000000 -0500
+++ serefpolicy-2.5.10/policy/modules/system/mount.fc	2007-03-22 15:06:59.000000000 -0400
@@ -1,4 +1,3 @@
 /bin/mount.*			--	gen_context(system_u:object_r:mount_exec_t,s0)
 /bin/umount.*			--	gen_context(system_u:object_r:mount_exec_t,s0)
-
-/usr/bin/fusermount		--	gen_context(system_u:object_r:mount_exec_t,s0)
+/sbin/mount.ntfs-3g		--	gen_context(system_u:object_r:mount_ntfs_exec_t,s0)
--- nsaserefpolicy/policy/modules/system/mount.if	2007-01-02 12:57:49.000000000 -0500
+++ serefpolicy-2.5.10/policy/modules/system/mount.if	2007-03-22 15:06:59.000000000 -0400
@@ -143,3 +143,40 @@
 		mount_domtrans($1)
 	')
 ')
+
+########################################
+## <summary>
+##	Execute a domain transition to run mount_ntfs.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`mount_ntfs_domtrans',`
+	gen_require(`
+		type mount_ntfs_t, mount_ntfs_exec_t;
+	')
+
+	domtrans_pattern($1,mount_ntfs_exec_t,mount_ntfs_t)
+')
+
+########################################
+## <summary>
+##	Allow the specified domain to read/write to
+##	init scripts with a unix domain stream sockets.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`mount_ntfs_rw_stream_sockets',`
+	gen_require(`
+		type mount_ntfs_t;
+	')
+
+	allow $1 mount_ntfs_t:unix_stream_socket { read write };
+')
--- nsaserefpolicy/policy/modules/system/mount.te	2007-01-02 12:57:49.000000000 -0500
+++ serefpolicy-2.5.10/policy/modules/system/mount.te	2007-03-22 15:06:59.000000000 -0400
@@ -9,8 +9,13 @@
 type mount_t;
 type mount_exec_t;
 init_system_domain(mount_t,mount_exec_t)
+application_executable_file(mount_exec_t)
 role system_r types mount_t;
 
+type mount_ntfs_t;
+type mount_ntfs_exec_t;
+init_daemon_domain(mount_ntfs_t, mount_ntfs_exec_t)
+
 type mount_loopback_t; # customizable
 files_type(mount_loopback_t)
 
@@ -29,7 +34,7 @@
 #
 
 # setuid/setgid needed to mount cifs 
-allow mount_t self:capability { ipc_lock sys_rawio sys_admin dac_override chown sys_tty_config setuid setgid };
+allow mount_t self:capability { ipc_lock sys_rawio sys_resource sys_admin dac_override chown sys_tty_config setuid setgid };
 
 allow mount_t mount_loopback_t:file read_file_perms;
 allow mount_t self:netlink_route_socket r_netlink_socket_perms;
@@ -197,3 +207,40 @@
 	files_etc_filetrans_etc_runtime(unconfined_mount_t,file)
 	unconfined_domain(unconfined_mount_t)
 ')
+
+########################################
+#
+# mount_ntfs local policy
+#
+allow mount_ntfs_t self:capability { setuid sys_admin };
+allow mount_ntfs_t self:fifo_file { read write };
+allow mount_ntfs_t self:unix_stream_socket create_stream_socket_perms;
+allow mount_ntfs_t self:unix_dgram_socket { connect create };
+
+corecmd_read_bin_symlinks(mount_ntfs_t)
+corecmd_exec_shell(mount_ntfs_t)
+
+files_read_etc_files(mount_ntfs_t)
+
+libs_use_ld_so(mount_ntfs_t)
+libs_use_shared_libs(mount_ntfs_t)
+
+fusermount_domtrans(mount_ntfs_t)
+fusermount_use_fds(mount_ntfs_t)
+
+kernel_read_system_state(mount_ntfs_t)
+
+logging_send_syslog_msg(mount_ntfs_t)
+
+miscfiles_read_localization(mount_ntfs_t)
+
+modutils_domtrans_insmod(mount_ntfs_t)
+
+mount_ntfs_domtrans(mount_t)
+
+storage_raw_read_fixed_disk(mount_ntfs_t)
+storage_raw_write_fixed_disk(mount_ntfs_t)
+
+ifdef(`targeted_policy',`
+	term_use_generic_ptys(mount_ntfs_t)
+')

--------------090802000305030502050208--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KWEg7024598
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:32:14 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KWDM1006310
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:32:13 GMT
Date: Thu, 2 Aug 2007 16:31:00 -0400
Message-Id: <200708022031.l72KV07g032269@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: system_fusermount policy
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/system/fusermount.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.0.5/policy/modules/system/fusermount.fc	2007-08-02 11:02:02.000000000 -0400
@@ -0,0 +1,7 @@
+# fusermount executable will have:
+# label: system_u:object_r:fusermount_exec_t
+# MLS sensitivity: s0
+# MCS categories: <none>
+
+/usr/bin/fusermount		--	gen_context(system_u:object_r:fusermount_exec_t,s0)
+/bin/fusermount		--	gen_context(system_u:object_r:fusermount_exec_t,s0)
--- nsaserefpolicy/policy/modules/system/fusermount.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.0.5/policy/modules/system/fusermount.if	2007-08-02 11:02:02.000000000 -0400
@@ -0,0 +1,41 @@
+## <summary>policy for fusermount</summary>
+
+########################################
+## <summary>
+##	Execute a domain transition to run fusermount.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`fusermount_domtrans',`
+	gen_require(`
+		type fusermount_t, fusermount_exec_t;
+	')
+
+	domain_auto_trans($1,fusermount_exec_t,fusermount_t)
+
+	allow fusermount_t $1:fd use;
+	allow fusermount_t $1:fifo_file rw_file_perms;
+	allow fusermount_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##	Inherit and use file descriptors from fusermount.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`fusermount_use_fds',`
+	gen_require(`
+		type fusermount_t;
+	')
+
+	allow $1 fusermount_t:fd use;
+')
\ No newline at end of file
--- nsaserefpolicy/policy/modules/system/fusermount.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.0.5/policy/modules/system/fusermount.te	2007-08-02 11:02:02.000000000 -0400
@@ -0,0 +1,46 @@
+policy_module(fusermount,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type fusermount_t;
+type fusermount_exec_t;
+application_domain(fusermount_t, fusermount_exec_t)
+role system_r types fusermount_t;
+
+########################################
+#
+# fusermount local policy
+#
+allow fusermount_t self:capability sys_admin;
+allow fusermount_t self:fifo_file { read write };
+allow fusermount_t self:unix_stream_socket create_stream_socket_perms;
+
+files_read_etc_files(fusermount_t)
+
+libs_use_ld_so(fusermount_t)
+libs_use_shared_libs(fusermount_t)
+
+miscfiles_read_localization(fusermount_t)
+
+files_manage_etc_runtime_files(fusermount_t)
+files_etc_filetrans_etc_runtime(fusermount_t,file)
+files_mounton_all_mountpoints(fusermount_t)
+
+fs_mount_fusefs(fusermount_t)
+
+storage_raw_read_fixed_disk(fusermount_t)
+storage_raw_write_fixed_disk(fusermount_t)
+
+optional_policy(`
+	hal_write_log(fusermount_t)
+	hal_use_fds(fusermount_t)
+	hal_rw_pipes(fusermount_t)
+')
+
+optional_policy(`
+	mount_ntfs_rw_stream_sockets(fusermount_t)
+')
+

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

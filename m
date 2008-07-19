Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6JL2wGu024269
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 17:02:58 -0400
Received: from palpatine.hardeman.nu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6JL2uTc006532
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 21:02:57 GMT
Message-Id: <20080719210251.926242875@hardeman.nu>
References: <20080719205002.462190042@hardeman.nu>
Date: Sat, 19 Jul 2008 22:50:07 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com, cpebenito@tresys.com
Subject: [refpolicy-patch 05/23] kudzu policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

kudzu is RedHat's hw management app, none of the changes seem
controversial.

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/kudzu.te serefpolicy-3.5.0/policy/modules/admin/kudzu.te
--- nsaserefpolicy/policy/modules/admin/kudzu.te	2008-07-10 11:38:46.000000000 -0400
+++ serefpolicy-3.5.0/policy/modules/admin/kudzu.te	2008-07-15 14:05:12.000000000 -0400
@@ -21,8 +21,8 @@
 # Local policy
 #
 
-allow kudzu_t self:capability { dac_override sys_admin sys_rawio net_admin sys_tty_config mknod };
-dontaudit kudzu_t self:capability { sys_ptrace sys_tty_config };
+allow kudzu_t self:capability { dac_override sys_admin sys_ptrace sys_rawio net_admin sys_tty_config mknod };
+dontaudit kudzu_t self:capability sys_tty_config;
 allow kudzu_t self:process { signal_perms execmem };
 allow kudzu_t self:fifo_file rw_fifo_file_perms;
 allow kudzu_t self:unix_stream_socket { connectto create_stream_socket_perms };
@@ -68,6 +68,7 @@
 modutils_read_module_deps(kudzu_t)
 modutils_read_module_config(kudzu_t)
 modutils_rename_module_config(kudzu_t)
+modutils_unlink_module_config(kudzu_t)
 
 storage_read_scsi_generic(kudzu_t)
 storage_read_tape(kudzu_t)
@@ -103,6 +104,8 @@
 init_use_fds(kudzu_t)
 init_use_script_ptys(kudzu_t)
 init_stream_connect_script(kudzu_t)
+init_read_init_state(kudzu_t)
+init_ptrace_init_domain(kudzu_t)
 # kudzu will telinit to make init re-read
 # the inittab after configuring serial consoles
 init_telinit(kudzu_t)
@@ -143,28 +146,6 @@
 ')
 
 optional_policy(`
-	# cjp: this was originally in the else block
-	# of ifdef userhelper.te, but it seems to
-	# make more sense here.  also, require
-	# blocks curently do not work in the
-	# else block of optionals
+	unconfined_domtrans(kudzu_t)
 	unconfined_domain(kudzu_t)
 ')
-
-ifdef(`TODO',`
-allow kudzu_t modules_conf_t:file unlink;
-optional_policy(`
-	allow kudzu_t printconf_t:file { getattr read };
-')
-optional_policy(`
-	allow kudzu_t xserver_exec_t:file getattr;
-')
-optional_policy(`
-	allow kudzu_t rhgb_t:unix_stream_socket connectto;
-')
-optional_policy(`
-	role system_r types sysadm_userhelper_t;
-	domain_auto_trans(kudzu_t, userhelper_exec_t, sysadm_userhelper_t)
-')
-allow kudzu_t cupsd_rw_etc_t:dir list_dir_perms;
-')

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

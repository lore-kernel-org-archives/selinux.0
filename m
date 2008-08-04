Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74CkOvx014137
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:46:24 -0400
Received: from palpatine.hardeman.nu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74CkIpq016422
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:46:19 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id 75C1541C
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:46:22 +0200 (CEST)
Message-Id: <20080804123739.808714725@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:35:28 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 32/35] rsync policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

rsync module policy changes, mostly related to a new type for rsync log
files.
Index: refpolicy/policy/modules/services/rsync.fc
===================================================================
--- refpolicy.orig/policy/modules/services/rsync.fc	2008-07-19 19:15:41.000000000 +0200
+++ refpolicy/policy/modules/services/rsync.fc	2008-08-03 21:58:33.000000000 +0200
@@ -1,2 +1,6 @@
 
 /usr/bin/rsync		--	gen_context(system_u:object_r:rsync_exec_t,s0)
+
+/var/log/rsync\.log      --	gen_context(system_u:object_r:rsync_log_t,s0)
+
+/var/run/rsyncd\.lock      --	gen_context(system_u:object_r:rsync_log_t,s0)
Index: refpolicy/policy/modules/services/rsync.te
===================================================================
--- refpolicy.orig/policy/modules/services/rsync.te	2008-08-03 16:47:00.000000000 +0200
+++ refpolicy/policy/modules/services/rsync.te	2008-08-03 21:58:33.000000000 +0200
@@ -31,6 +31,9 @@
 type rsync_data_t;
 files_type(rsync_data_t)
 
+type rsync_log_t;
+logging_log_file(rsync_log_t)
+
 type rsync_tmp_t;
 files_tmp_file(rsync_tmp_t)
 
@@ -42,7 +45,7 @@
 # Local policy
 #
 
-allow rsync_t self:capability sys_chroot;
+allow rsync_t self:capability { dac_read_search dac_override setuid setgid sys_chroot };
 allow rsync_t self:process signal_perms;
 allow rsync_t self:fifo_file rw_fifo_file_perms;
 allow rsync_t self:tcp_socket create_stream_socket_perms;
@@ -52,7 +55,6 @@
 # cjp: this should probably only be inetd_child_t rules?
 # search home and kerberos also.
 allow rsync_t self:netlink_tcpdiag_socket r_netlink_socket_perms;
-allow rsync_t self:capability { setuid setgid };
 #end for identd
 
 allow rsync_t rsync_data_t:dir list_dir_perms;
@@ -95,7 +97,8 @@
 libs_use_shared_libs(rsync_t)
 
 logging_send_syslog_msg(rsync_t)
-logging_dontaudit_search_logs(rsync_t)
+manage_files_pattern(rsync_t,rsync_log_t,rsync_log_t)
+logging_log_filetrans(rsync_t,rsync_log_t,file)
 
 miscfiles_read_localization(rsync_t)
 miscfiles_read_public_files(rsync_t)
@@ -117,7 +120,6 @@
 ')
 
 tunable_policy(`rsync_export_all_ro',`
-	allow rsync_t self:capability dac_override;
 	fs_read_noxattr_fs_files(rsync_t) 
 	auth_read_all_files_except_shadow(rsync_t)
 ')

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

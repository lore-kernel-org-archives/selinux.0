Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4SFxRNm021188
	for <selinux@tycho.nsa.gov>; Sun, 28 May 2006 11:59:28 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4SFxLYa025401
	for <selinux@tycho.nsa.gov>; Sun, 28 May 2006 15:59:22 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 5899361B0A
	for <selinux@tycho.nsa.gov>; Sun, 28 May 2006 22:26:00 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 11295-09 for <selinux@tycho.nsa.gov>;
	Sun, 28 May 2006 22:25:59 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 5E3F861AF9
	for <selinux@tycho.nsa.gov>; Sun, 28 May 2006 22:25:59 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 840FEA7D94
	for <selinux@tycho.nsa.gov>; Sun, 28 May 2006 22:25:55 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: clam/amavis policy
Date: Sun, 28 May 2006 22:25:52 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TbZeEc8aPT3Jq3N"
Message-Id: <200605282225.55326.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_TbZeEc8aPT3Jq3N
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've attached a patch for the clam/amavis policy against 2.2.40-1.fc5.

avc:  denied  { write } for  pid=5178 comm="amavisd" name="clamd.sock" 
dev=dm-0 ino=902623 scontext=root:system_r:amavis_t:s0 
tcontext=root:object_r:clamd_var_run_t:s0 tclass=sock_file

I'm getting the above AVC message in spite of the following policy:

policy/modules/services/clamav.if:
interface(`clamav_stream_connect',`
        gen_require(`
                type clamd_t, clamd_var_run_t;
        ')

        allow $1 clamd_var_run_t:dir search;
        allow $1 clamd_var_run_t:sock_file write;
        allow $1 clamd_t:unix_stream_socket connectto;
')

policy/modules/services/amavis.te:
optional_policy(`
        clamav_stream_connect(amavis_t)
')

Any advice on what I'm missing would be appreciated.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_TbZeEc8aPT3Jq3N
Content-Type: text/x-diff;
  charset="us-ascii";
  name="rjc-fc5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rjc-fc5.patch"

diff -ru serefpolicy-2.2.40.orig/policy/modules/services/amavis.fc serefpolicy-2.2.40/policy/modules/services/amavis.fc
--- serefpolicy-2.2.40.orig/policy/modules/services/amavis.fc	2006-05-28 19:05:00.000000000 +1000
+++ serefpolicy-2.2.40/policy/modules/services/amavis.fc	2006-05-28 20:14:10.000000000 +1000
@@ -7,6 +7,9 @@
 /var/amavis(/.*)?			gen_context(system_u:object_r:amavis_var_lib_t,s0)
 /var/lib/amavis(/.*)?			gen_context(system_u:object_r:amavis_var_lib_t,s0)
 /var/log/amavisd\.log		--	gen_context(system_u:object_r:amavis_var_log_t,s0)
-/var/run/amavis(/.*)?			gen_context(system_u:object_r:amavis_var_run_t,s0)
+/var/run/amavis(d)?/amavisd.lock --	gen_context(system_u:object_r:amavis_var_run_t,s0)
+/var/run/amavis(d)?/amavisd.sock -s	gen_context(system_u:object_r:amavis_var_run_t,s0)
+/var/run/amavis(d)?/amavisd.pid	--	gen_context(system_u:object_r:amavis_var_run_t,s0)
 /var/virusmails(/.*)?			gen_context(system_u:object_r:amavis_quarantine_t,s0)
 /var/spool/amavisd(/.*)?		gen_context(system_u:object_r:amavis_spool_t,s0)
+/var/spool/amavisd/amavisd.sock	-s	gen_context(system_u:object_r:amavis_var_run_t,s0)
diff -ru serefpolicy-2.2.40.orig/policy/modules/services/amavis.if serefpolicy-2.2.40/policy/modules/services/amavis.if
--- serefpolicy-2.2.40.orig/policy/modules/services/amavis.if	2006-05-16 23:46:17.000000000 +1000
+++ serefpolicy-2.2.40/policy/modules/services/amavis.if	2006-05-28 19:09:10.000000000 +1000
@@ -47,6 +47,49 @@
 
 ########################################
 ## <summary>
+##	Create socket files under the amavis spool
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <param name="socket_type">
+##	<summary>
+##	Type for socket file
+##	</summary>
+## </param>
+#
+interface(`amavis_spool_create_socket',`
+	gen_require(`
+		type amavis_spool_t;
+	')
+
+	allow $1 amavis_spool_t:dir rw_dir_perms;
+	allow $1 $2:sock_file manage_file_perms;
+	type_transition $1 amavis_spool_t:sock_file $2;
+')
+
+########################################
+## <summary>
+##	Read amavis spool files
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`amavis_read_spool_file',`
+	gen_require(`
+		type amavis_spool_t;
+	')
+
+	allow $1 amavis_spool_t:file { getattr read };
+')
+
+########################################
+## <summary>
 ##	Read amavis lib files.
 ## </summary>
 ## <param name="domain">
diff -ru serefpolicy-2.2.40.orig/policy/modules/services/amavis.te serefpolicy-2.2.40/policy/modules/services/amavis.te
--- serefpolicy-2.2.40.orig/policy/modules/services/amavis.te	2006-05-28 19:05:00.000000000 +1000
+++ serefpolicy-2.2.40/policy/modules/services/amavis.te	2006-05-28 21:19:48.000000000 +1000
@@ -50,6 +50,7 @@
 allow amavis_t self:unix_stream_socket create_stream_socket_perms;
 allow amavis_t self:unix_dgram_socket create_socket_perms;
 allow amavis_t self:tcp_socket { listen accept };
+allow amavis_t proc_t:lnk_file read;
 
 # configuration files
 allow amavis_t amavis_etc_t:dir r_dir_perms;
@@ -70,13 +71,12 @@
 allow amavis_t amavis_var_lib_t:file create_file_perms;
 allow amavis_t amavis_var_lib_t:sock_file create_file_perms;
 allow amavis_t amavis_var_lib_t:dir create_dir_perms;
-files_var_filetrans(amavis_t,amavis_var_lib_t,{ file dir sock_file })
-files_var_lib_filetrans(amavis_t,amavis_var_lib_t,file)
 
 # Spool Files
-files_spool_filetrans(amavis_t,amavis_spool_t,{ dir file })
+files_search_spool(amavis_t)
 allow amavis_t amavis_spool_t:dir manage_dir_perms;
 allow amavis_t amavis_spool_t:file manage_file_perms;
+type_transition amavis_t amavis_spool_t:sock_file amavis_var_run_t;
 
 # log files
 allow amavis_t amavis_var_log_t:file create_file_perms;
@@ -146,10 +146,16 @@
 
 mta_read_config(amavis_t)
 
+# dontaudit terminal access
+ifdef(`targeted_policy',`
 term_dontaudit_use_generic_ptys(amavis_t)
+')
 
 optional_policy(`
 	clamav_stream_connect(amavis_t)
+')
+
+optional_policy(`
 	clamscan_domtrans(amavis_t)
 ')
 
diff -ru serefpolicy-2.2.40.orig/policy/modules/services/clamav.fc serefpolicy-2.2.40/policy/modules/services/clamav.fc
--- serefpolicy-2.2.40.orig/policy/modules/services/clamav.fc	2006-05-28 19:05:00.000000000 +1000
+++ serefpolicy-2.2.40/policy/modules/services/clamav.fc	2006-05-28 20:38:04.000000000 +1000
@@ -7,8 +7,10 @@
 /usr/sbin/clamd			--	gen_context(system_u:object_r:clamd_exec_t,s0)
 
 /var/run/clamav(/.*)?			gen_context(system_u:object_r:clamd_var_run_t,s0)
-/var/run/clamav/clamd.ctl	-s	gen_context(system_u:object_r:clamd_sock_t,s0)
+/var/run/clamav/clamd.ctl	-s	gen_context(system_u:object_r:clamd_var_run_t,s0)
+/var/run/amavis(d)?/clamd.pid	--	gen_context(system_u:object_r:clamd_var_run_t,s0)
 /var/lib/clamav(/.*)?			gen_context(system_u:object_r:clamd_var_lib_t,s0)
 /var/log/clamav			-d	gen_context(system_u:object_r:clamd_var_log_t,s0)
 /var/log/clamav/clamav.*	--	gen_context(system_u:object_r:clamd_var_log_t,s0)
 /var/log/clamav/freshclam.*	--	gen_context(system_u:object_r:freshclam_var_log_t,s0)
+/var/spool/amavisd/clamd.sock	-s	gen_context(system_u:object_r:clamd_var_run_t)
diff -ru serefpolicy-2.2.40.orig/policy/modules/services/clamav.if serefpolicy-2.2.40/policy/modules/services/clamav.if
--- serefpolicy-2.2.40.orig/policy/modules/services/clamav.if	2006-05-28 19:05:00.000000000 +1000
+++ serefpolicy-2.2.40/policy/modules/services/clamav.if	2006-05-28 20:42:25.000000000 +1000
@@ -35,11 +35,11 @@
 #
 interface(`clamav_stream_connect',`
 	gen_require(`
-		type clamd_t, clamd_sock_t, clamd_var_run_t;
+		type clamd_t, clamd_var_run_t;
 	')
 
 	allow $1 clamd_var_run_t:dir search;
-	allow $1 clamd_sock_t:sock_file write;
+	allow $1 clamd_var_run_t:sock_file write;
 	allow $1 clamd_t:unix_stream_socket connectto;
 ')
 
@@ -85,3 +85,21 @@
 	allow clamscan_t $1:process sigchld;
 ')
 
+########################################
+## <summary>
+##	Access /var/lib/clamav
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed to transition.
+##	</summary>
+## </param>
+#
+interface(`access_clam_home',`
+	gen_require(`
+		type clamd_var_lib_t;
+	')
+
+	allow $1 clamd_var_lib_t:dir search;
+')
+
diff -ru serefpolicy-2.2.40.orig/policy/modules/services/clamav.te serefpolicy-2.2.40/policy/modules/services/clamav.te
--- serefpolicy-2.2.40.orig/policy/modules/services/clamav.te	2006-05-28 19:05:00.000000000 +1000
+++ serefpolicy-2.2.40/policy/modules/services/clamav.te	2006-05-28 20:42:39.000000000 +1000
@@ -15,10 +15,6 @@
 type clamd_etc_t;
 files_type(clamd_etc_t)
 
-# named socket type
-type clamd_sock_t;
-files_type(clamd_sock_t)
-
 # tmp files
 type clamd_tmp_t;
 files_tmp_file(clamd_tmp_t)
@@ -34,6 +30,7 @@
 # pid files
 type clamd_var_run_t;
 files_pid_file(clamd_var_run_t)
+typealias clamd_var_run_t alias clamd_sock_t;
 
 type freshclam_t;
 type freshclam_exec_t;
@@ -52,6 +49,7 @@
 # clamd local policy
 #
 
+logging_send_syslog_msg(clamd_t)
 allow clamd_t self:capability { kill setgid setuid dac_override };
 allow clamd_t self:fifo_file rw_file_perms;
 allow clamd_t self:unix_stream_socket create_stream_socket_perms;
@@ -63,11 +61,12 @@
 allow clamd_t clamd_etc_t:file r_file_perms;
 allow clamd_t clamd_etc_t:lnk_file { getattr read };
 
-# socket file
-allow clamd_t clamd_sock_t:file manage_file_perms;
-allow clamd_t clamd_sock_t:sock_file manage_file_perms;
-allow clamd_t clamd_sock_t:dir rw_dir_perms;
-files_pid_filetrans(clamd_t,clamd_sock_t,sock_file)
+# Spool Files
+files_search_spool(clamd_t)
+optional_policy(`
+	amavis_spool_create_socket(clamd_t, clamd_var_run_t)
+	amavis_read_spool_file(clamd_t)
+')
 
 # tmp files
 allow clamd_t clamd_tmp_t:file create_file_perms;
@@ -76,14 +75,10 @@
 
 # var/lib files for clamd
 allow clamd_t clamd_var_lib_t:file create_file_perms;
-allow clamd_t clamd_var_lib_t:sock_file create_file_perms;
 allow clamd_t clamd_var_lib_t:dir create_dir_perms;
-files_var_filetrans(clamd_t,clamd_var_lib_t,{ file dir sock_file })
-files_var_lib_filetrans(clamd_t,clamd_var_lib_t,file)
 
 # log files
 allow clamd_t clamd_var_log_t:file create_file_perms;
-allow clamd_t clamd_var_log_t:sock_file create_file_perms;
 allow clamd_t clamd_var_log_t:dir { rw_dir_perms setattr };
 logging_log_filetrans(clamd_t,clamd_var_log_t,file)
 
@@ -95,6 +90,11 @@
 
 kernel_dontaudit_list_proc(clamd_t)
 
+# dontaudit terminal access
+ifdef(`targeted_policy',`
+	term_dontaudit_use_generic_ptys(clamd_t)
+')
+
 corenet_tcp_sendrecv_all_if(clamd_t)
 corenet_tcp_sendrecv_all_nodes(clamd_t)
 corenet_tcp_sendrecv_all_ports(clamd_t)
@@ -147,10 +147,7 @@
 
 # var/lib files together with clamd
 allow freshclam_t clamd_var_lib_t:file create_file_perms;
-allow freshclam_t clamd_var_lib_t:sock_file create_file_perms;
 allow freshclam_t clamd_var_lib_t:dir create_dir_perms;
-files_var_filetrans(freshclam_t,clamd_var_lib_t,{ file dir sock_file })
-files_var_lib_filetrans(freshclam_t,clamd_var_lib_t,file)
 
 # pidfiles- var/run together with clamd
 allow freshclam_t clamd_var_run_t:file manage_file_perms;
@@ -160,7 +157,6 @@
 
 # log files (own logfiles only)
 allow freshclam_t freshclam_var_log_t:file create_file_perms;
-allow freshclam_t freshclam_var_log_t:sock_file create_file_perms;
 allow freshclam_t freshclam_var_log_t:dir { rw_dir_perms setattr };
 allow freshclam_t clamd_var_log_t:dir search;
 logging_log_filetrans(freshclam_t,freshclam_var_log_t,file)
@@ -216,7 +212,6 @@
 
 # var/lib files together with clamd
 allow clamscan_t clamd_var_lib_t:file r_file_perms;
-allow clamscan_t clamd_var_lib_t:sock_file rw_file_perms;
 allow clamscan_t clamd_var_lib_t:dir r_dir_perms;
 
 files_search_var_lib(clamscan_t)
diff -ru serefpolicy-2.2.40.orig/policy/modules/services/dovecot.te serefpolicy-2.2.40/policy/modules/services/dovecot.te
--- serefpolicy-2.2.40.orig/policy/modules/services/dovecot.te	2006-05-28 19:05:00.000000000 +1000
+++ serefpolicy-2.2.40/policy/modules/services/dovecot.te	2006-05-28 19:09:15.000000000 +1000
@@ -80,6 +80,7 @@
 corenet_tcp_bind_pop_port(dovecot_t)
 corenet_tcp_connect_all_ports(dovecot_t)
 corenet_tcp_connect_postgresql_port(dovecot_t)
+allow dovecot_t self:netlink_route_socket r_netlink_socket_perms;
 
 dev_read_sysfs(dovecot_t)
 dev_read_urand(dovecot_t)
diff -ru serefpolicy-2.2.40.orig/policy/modules/services/procmail.te serefpolicy-2.2.40/policy/modules/services/procmail.te
--- serefpolicy-2.2.40.orig/policy/modules/services/procmail.te	2006-05-16 23:46:17.000000000 +1000
+++ serefpolicy-2.2.40/policy/modules/services/procmail.te	2006-05-28 19:09:15.000000000 +1000
@@ -112,3 +112,7 @@
 	spamassassin_exec(procmail_t)
 	spamassassin_exec_client(procmail_t)
 ')
+
+optional_policy(`
+	access_clam_home(procmail_t)
+')
diff -ru serefpolicy-2.2.40.orig/policy/modules/system/selinuxutil.te serefpolicy-2.2.40/policy/modules/system/selinuxutil.te
--- serefpolicy-2.2.40.orig/policy/modules/system/selinuxutil.te	2006-05-28 19:05:00.000000000 +1000
+++ serefpolicy-2.2.40/policy/modules/system/selinuxutil.te	2006-05-28 19:18:38.000000000 +1000
@@ -506,8 +506,6 @@
 	seutil_read_config(run_init_t)
 	seutil_read_default_contexts(run_init_t)
 
-	miscfiles_read_localization(run_init_t)
-
 	logging_send_syslog_msg(run_init_t)
 
 	optional_policy(`
diff -ru serefpolicy-2.2.40.orig/policy/support/misc_macros.spt serefpolicy-2.2.40/policy/support/misc_macros.spt
--- serefpolicy-2.2.40.orig/policy/support/misc_macros.spt	2006-05-16 23:46:18.000000000 +1000
+++ serefpolicy-2.2.40/policy/support/misc_macros.spt	2006-05-28 19:09:15.000000000 +1000
@@ -37,7 +37,7 @@
 #
 # gen_context(context,mls_sensitivity,[mcs_categories])
 #
-define(`gen_context',`$1`'ifdef(`enable_mls',`:$2')`'ifdef(`enable_mcs',`:s0`'ifelse(`$3',,,`:$3')')') dnl
+define(`gen_context',`$1`'ifdef(`enable_mls',`:$2')`'ifdef(`enable_mcs',`:s0`'ifelse(`$3',,,`:$3')')')dnl
 
 ########################################
 #

--Boundary-00=_TbZeEc8aPT3Jq3N--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5LMGU0P002292
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 18:16:31 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5LMGPYv013376
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 22:16:26 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id A409D61B04
	for <selinux@tycho.nsa.gov>; Thu, 22 Jun 2006 08:16:32 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 14386-06 for <selinux@tycho.nsa.gov>;
	Thu, 22 Jun 2006 08:16:31 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id A59B261AEC
	for <selinux@tycho.nsa.gov>; Thu, 22 Jun 2006 08:16:31 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id BACBEA7E73
	for <selinux@tycho.nsa.gov>; Thu, 22 Jun 2006 08:16:21 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: Re: policy patch for FC5 anti-virus and Postgrey
Date: Thu, 22 Jun 2006 08:16:21 +1000
References: <200606212202.51319.russell@coker.com.au>
In-Reply-To: <200606212202.51319.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1UcmEby3YChncjz"
Message-Id: <200606220816.21526.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_1UcmEby3YChncjz
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

My previous message omitted an essential line from the postgrey policy, fixed 
with the attached patch.

I'll release a rawhide patch soon.

On Wednesday 21 June 2006 22:02, Russell Coker <russell@coker.com.au> wrote:
> The attached policy patch and patch for one of the config files used in the
> RPM build process allow a FC5 system to correctly operate with Amavis and
> Postgrey.
>
> These patches allow running a Postfix mail server with every sensible
> anti-spam measure on FC5 in enforcing mode.
>
> If you know of any anti-spam measure other than CR which doesn't work with
> this then please let me know.  I'm running a bunch of mail servers and am
> always looking for new ways of protecting them.
>
> If you apply all of the patch modules-targeted.conf.diff then the result
> will be a policy rpm that can't conveniently be installed with the current
> code that's in FC5.  You have to remove the amavis and clamav modules
> first. Doing this exposed a policy bug in that unconfined_t couldn't kill
> unlabeled_t processes or see their context, so I fixed that bug in the
> policy patch too.
>
> Let me know if you would like a patch for rawhide to do the same things.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_1UcmEby3YChncjz
Content-Type: text/x-diff;
  charset="utf-8";
  name="rjc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rjc.diff"

diff -ru serefpolicy-2.2.43.orig/policy/modules/kernel/kernel.if serefpolicy-2.2.43/policy/modules/kernel/kernel.if
--- serefpolicy-2.2.43.orig/policy/modules/kernel/kernel.if	2006-05-27 04:02:58.000000000 +1000
+++ serefpolicy-2.2.43/policy/modules/kernel/kernel.if	2006-06-18 19:45:10.000000000 +1000
@@ -1942,6 +1942,24 @@
 
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
diff -ru serefpolicy-2.2.43.orig/policy/modules/services/amavis.fc serefpolicy-2.2.43/policy/modules/services/amavis.fc
--- serefpolicy-2.2.43.orig/policy/modules/services/amavis.fc	2006-06-18 09:46:14.000000000 +1000
+++ serefpolicy-2.2.43/policy/modules/services/amavis.fc	2006-06-18 12:08:11.000000000 +1000
@@ -7,6 +7,6 @@
 /var/amavis(/.*)?			gen_context(system_u:object_r:amavis_var_lib_t,s0)
 /var/lib/amavis(/.*)?			gen_context(system_u:object_r:amavis_var_lib_t,s0)
 /var/log/amavisd\.log		--	gen_context(system_u:object_r:amavis_var_log_t,s0)
-/var/run/amavis(d)?(/.*)?		gen_context(system_u:object_r:amavis_var_run_t,s0)
+/var/run/amavis(d)?/.+			gen_context(system_u:object_r:amavis_var_run_t,s0)
 /var/spool/amavisd(/.*)?		gen_context(system_u:object_r:amavis_spool_t,s0)
 /var/virusmails(/.*)?			gen_context(system_u:object_r:amavis_quarantine_t,s0)
diff -ru serefpolicy-2.2.43.orig/policy/modules/services/amavis.te serefpolicy-2.2.43/policy/modules/services/amavis.te
--- serefpolicy-2.2.43.orig/policy/modules/services/amavis.te	2006-06-18 09:46:14.000000000 +1000
+++ serefpolicy-2.2.43/policy/modules/services/amavis.te	2006-06-18 09:51:11.000000000 +1000
@@ -50,6 +50,7 @@
 allow amavis_t self:unix_stream_socket create_stream_socket_perms;
 allow amavis_t self:unix_dgram_socket create_socket_perms;
 allow amavis_t self:tcp_socket { listen accept };
+allow amavis_t proc_t:lnk_file read;
 
 # configuration files
 allow amavis_t amavis_etc_t:dir r_dir_perms;
@@ -62,10 +63,11 @@
 allow amavis_t amavis_quarantine_t:dir create_dir_perms;
 
 # Spool Files
+files_search_spool(amavis_t)
 allow amavis_t amavis_spool_t:dir manage_dir_perms;
 allow amavis_t amavis_spool_t:file manage_file_perms;
 allow amavis_t amavis_spool_t:sock_file create_file_perms;
-files_spool_filetrans(amavis_t,amavis_spool_t,{ dir file })
+type_transition amavis_t amavis_spool_t:sock_file amavis_var_run_t;
 
 # tmp files
 allow amavis_t amavis_tmp_t:file create_file_perms;
@@ -76,8 +78,6 @@
 allow amavis_t amavis_var_lib_t:file create_file_perms;
 allow amavis_t amavis_var_lib_t:sock_file create_file_perms;
 allow amavis_t amavis_var_lib_t:dir create_dir_perms;
-files_var_filetrans(amavis_t,amavis_var_lib_t,{ file dir sock_file })
-files_var_lib_filetrans(amavis_t,amavis_var_lib_t,file)
 
 # log files
 allow amavis_t amavis_var_log_t:file create_file_perms;
diff -ru serefpolicy-2.2.43.orig/policy/modules/services/clamav.fc serefpolicy-2.2.43/policy/modules/services/clamav.fc
--- serefpolicy-2.2.43.orig/policy/modules/services/clamav.fc	2006-05-27 04:02:58.000000000 +1000
+++ serefpolicy-2.2.43/policy/modules/services/clamav.fc	2006-06-18 09:47:19.000000000 +1000
@@ -8,8 +8,10 @@
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
diff -ru serefpolicy-2.2.43.orig/policy/modules/services/clamav.if serefpolicy-2.2.43/policy/modules/services/clamav.if
--- serefpolicy-2.2.43.orig/policy/modules/services/clamav.if	2006-05-27 04:02:58.000000000 +1000
+++ serefpolicy-2.2.43/policy/modules/services/clamav.if	2006-06-18 09:47:19.000000000 +1000
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
 
@@ -84,3 +84,21 @@
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
diff -ru serefpolicy-2.2.43.orig/policy/modules/services/clamav.te serefpolicy-2.2.43/policy/modules/services/clamav.te
--- serefpolicy-2.2.43.orig/policy/modules/services/clamav.te	2006-06-18 09:46:14.000000000 +1000
+++ serefpolicy-2.2.43/policy/modules/services/clamav.te	2006-06-18 11:44:36.000000000 +1000
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
 
 type clamscan_t;
 type clamscan_exec_t;
@@ -74,12 +71,6 @@
 	amavis_read_spool_file(clamd_t)
 ')
 
-# socket file
-allow clamd_t clamd_sock_t:file manage_file_perms;
-allow clamd_t clamd_sock_t:sock_file manage_file_perms;
-allow clamd_t clamd_sock_t:dir rw_dir_perms;
-files_pid_filetrans(clamd_t,clamd_sock_t,sock_file)
-
 # tmp files
 allow clamd_t clamd_tmp_t:file create_file_perms;
 allow clamd_t clamd_tmp_t:dir create_dir_perms;
@@ -87,14 +78,10 @@
 
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
 logging_send_syslog_msg(clamd_t)
@@ -163,10 +150,7 @@
 
 # var/lib files together with clamd
 allow freshclam_t clamd_var_lib_t:file create_file_perms;
-allow freshclam_t clamd_var_lib_t:sock_file create_file_perms;
 allow freshclam_t clamd_var_lib_t:dir create_dir_perms;
-files_var_filetrans(freshclam_t,clamd_var_lib_t,{ file dir sock_file })
-files_var_lib_filetrans(freshclam_t,clamd_var_lib_t,file)
 
 # pidfiles- var/run together with clamd
 allow freshclam_t clamd_var_run_t:file manage_file_perms;
@@ -176,7 +160,6 @@
 
 # log files (own logfiles only)
 allow freshclam_t freshclam_var_log_t:file create_file_perms;
-allow freshclam_t freshclam_var_log_t:sock_file create_file_perms;
 allow freshclam_t freshclam_var_log_t:dir { rw_dir_perms setattr };
 allow freshclam_t clamd_var_log_t:dir search;
 logging_log_filetrans(freshclam_t,freshclam_var_log_t,file)
@@ -230,7 +213,6 @@
 
 # var/lib files together with clamd
 allow clamscan_t clamd_var_lib_t:file r_file_perms;
-allow clamscan_t clamd_var_lib_t:sock_file rw_file_perms;
 allow clamscan_t clamd_var_lib_t:dir r_dir_perms;
 
 # tmp files
diff -ru serefpolicy-2.2.43.orig/policy/modules/services/postfix.te serefpolicy-2.2.43/policy/modules/services/postfix.te
--- serefpolicy-2.2.43.orig/policy/modules/services/postfix.te	2006-06-18 09:46:14.000000000 +1000
+++ serefpolicy-2.2.43/policy/modules/services/postfix.te	2006-06-21 06:46:57.000000000 +1000
@@ -604,3 +604,7 @@
 	sasl_connect(postfix_smtpd_t)
 ')
 
+optional_policy(`
+	postgrey_socket_access(postfix_smtpd_t)
+')
+
diff -ru serefpolicy-2.2.43.orig/policy/modules/services/postgrey.fc serefpolicy-2.2.43/policy/modules/services/postgrey.fc
--- serefpolicy-2.2.43.orig/policy/modules/services/postgrey.fc	2006-05-27 04:02:58.000000000 +1000
+++ serefpolicy-2.2.43/policy/modules/services/postgrey.fc	2006-06-18 20:12:44.000000000 +1000
@@ -4,5 +4,6 @@
 /usr/sbin/postgrey	--	gen_context(system_u:object_r:postgrey_exec_t,s0)
 
 /var/run/postgrey\.pid	--	gen_context(system_u:object_r:postgrey_var_run_t,s0)
+/var/run/postgrey/socket -s	gen_context(system_u:object_r:postgrey_var_run_t,s0)
 
 /var/lib/postgrey(/.*)?		gen_context(system_u:object_r:postgrey_var_lib_t,s0)
diff -ru serefpolicy-2.2.43.orig/policy/modules/services/postgrey.if serefpolicy-2.2.43/policy/modules/services/postgrey.if
--- serefpolicy-2.2.43.orig/policy/modules/services/postgrey.if	2006-05-27 04:02:58.000000000 +1000
+++ serefpolicy-2.2.43/policy/modules/services/postgrey.if	2006-06-22 07:47:23.000000000 +1000
@@ -1 +1,21 @@
 ## <summary>Postfix grey-listing server</summary>
+
+########################################
+## <summary>
+##      Write to postgrey socket
+## </summary>
+## <param name="domain">
+##      <summary>
+##      Domain allowed to talk to postgrey
+##      </summary>
+## </param>
+#
+interface(`postgrey_socket_access',`
+        gen_require(`
+                type postgrey_var_run_t, postgrey_t;
+        ')
+
+        allow $1 postgrey_var_run_t:sock_file write;
+	allow $1 postgrey_t:unix_stream_socket connectto;
+')
+
diff -ru serefpolicy-2.2.43.orig/policy/modules/services/postgrey.te serefpolicy-2.2.43/policy/modules/services/postgrey.te
--- serefpolicy-2.2.43.orig/policy/modules/services/postgrey.te	2006-05-27 04:02:58.000000000 +1000
+++ serefpolicy-2.2.43/policy/modules/services/postgrey.te	2006-06-18 20:21:56.000000000 +1000
@@ -18,6 +18,8 @@
 
 type postgrey_var_run_t;
 files_pid_file(postgrey_var_run_t)
+files_pid_filetrans(postgrey_t, postgrey_var_run_t, sock_file)
+allow postgrey_t postgrey_var_run_t:sock_file manage_file_perms;
 
 ########################################
 #
diff -ru serefpolicy-2.2.43.orig/policy/modules/services/procmail.te serefpolicy-2.2.43/policy/modules/services/procmail.te
--- serefpolicy-2.2.43.orig/policy/modules/services/procmail.te	2006-05-27 04:02:58.000000000 +1000
+++ serefpolicy-2.2.43/policy/modules/services/procmail.te	2006-06-18 09:47:19.000000000 +1000
@@ -112,3 +112,7 @@
 	spamassassin_exec(procmail_t)
 	spamassassin_exec_client(procmail_t)
 ')
+
+optional_policy(`
+	access_clam_home(procmail_t)
+')
diff -ru serefpolicy-2.2.43.orig/policy/modules/system/unconfined.if serefpolicy-2.2.43/policy/modules/system/unconfined.if
--- serefpolicy-2.2.43.orig/policy/modules/system/unconfined.if	2006-06-18 09:46:14.000000000 +1000
+++ serefpolicy-2.2.43/policy/modules/system/unconfined.if	2006-06-18 19:45:44.000000000 +1000
@@ -86,6 +86,11 @@
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
diff -ru serefpolicy-2.2.43.orig/policy/support/misc_macros.spt serefpolicy-2.2.43/policy/support/misc_macros.spt
--- serefpolicy-2.2.43.orig/policy/support/misc_macros.spt	2006-06-18 09:46:14.000000000 +1000
+++ serefpolicy-2.2.43/policy/support/misc_macros.spt	2006-06-18 09:47:19.000000000 +1000
@@ -37,7 +37,7 @@
 #
 # gen_context(context,mls_sensitivity,[mcs_categories])
 #
-define(`gen_context',`$1`'ifdef(`enable_mls',`:$2')`'ifdef(`enable_mcs',`:s0`'ifelse(`$3',,,`:$3')')') dnl
+define(`gen_context',`$1`'ifdef(`enable_mls',`:$2')`'ifdef(`enable_mcs',`:s0`'ifelse(`$3',,,`:$3')')')dnl
 
 ########################################
 #

--Boundary-00=_1UcmEby3YChncjz--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

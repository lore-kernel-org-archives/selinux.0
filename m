Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6SFw94P028294
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2008 11:58:09 -0400
Received: from cdptpa-omtalb.mail.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6SFw9gU022654
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2008 15:58:09 GMT
Received: from basement.kutulu.org ([70.121.200.185])
          by cdptpa-omta06.mail.rr.com with ESMTP
          id <20080728155808.ODQD9085.cdptpa-omta06.mail.rr.com@basement.kutulu.org>
          for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2008 15:58:08 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by basement.kutulu.org (Postfix) with ESMTPS id A14BB11471
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2008 11:58:01 -0400 (EDT)
Message-ID: <488DED3A.1030005@kutulu.org>
Date: Mon, 28 Jul 2008 12:00:58 -0400
From: Mike Edenfield <kutulu@kutulu.org>
MIME-Version: 1.0
To: SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: [refpolicy patch, second try] samba policy updates
Content-Type: multipart/mixed;
 boundary="------------040106080006070001060002"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040106080006070001060002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


* Allow winbindd to manage its own sockets
* Allow nbmd to rename log files
* Add new interface to encapsulate home directory creation.
* Provide tunable policy to allow samba to create home directories on 
system without oddjobs PAM module.



--------------040106080006070001060002
Content-Type: text/plain;
 name="samba.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="samba.patch"

Index: modules/services/samba.if
===================================================================
--- modules/services/samba.if	(revision 2767)
+++ modules/services/samba.if	(working copy)
@@ -484,17 +484,17 @@
 ## </param>
 #
 interface(`samba_stream_connect_winbind',`
-	ifdef(`distro_redhat',`
-		gen_require(`
-			type samba_var_t, winbind_t, winbind_var_run_t;
-		')
+	gen_require(`
+		type samba_var_t, winbind_t, winbind_var_run_t;
+	')
 
-		files_search_pids($1)
-		allow $1 samba_var_t:dir search_dir_perms;
-		stream_connect_pattern($1, winbind_var_run_t, winbind_var_run_t, winbind_t)
-	',`
+	files_search_pids($1)
+	allow $1 samba_var_t:dir search_dir_perms;
+	stream_connect_pattern($1, winbind_var_run_t, winbind_var_run_t, winbind_t)
+	
+	ifndef(`distro_redhat', `
 		gen_require(`
-			type winbind_t, winbind_tmp_t;
+		    type winbind_tmp_t;
 		')
 
 		# the default for the socket is (poorly named):
Index: modules/services/samba.te
===================================================================
--- modules/services/samba.te	(revision 2767)
+++ modules/services/samba.te	(working copy)
@@ -59,6 +59,13 @@
 ## </desc>
 gen_tunable(samba_share_nfs, false)
 
+## <desc>
+## <p>
+## Allow samba to create new home directories (e.g. via PAM) 
+## </p>
+## </desc>
+gen_tunable(samba_create_home_dirs, false)
+
 type nmbd_t;
 type nmbd_exec_t;
 init_daemon_domain(nmbd_t, nmbd_exec_t)
@@ -379,6 +386,14 @@
 	unprivuser_home_dir_filetrans_home_content(nmbd_t, { file dir })
 ')
 
+tunable_policy(`samba_create_home_dirs',`
+	ifdef(`distro_redhat', `
+		refpolicywarn(`Use of samba_create_home_dirs is discouraged.  Please use pam_oddjob_mkhomedir instead.')
+	', `
+		unprivuser_create_home_dirs(smbd_t)
+		allow smbd_t self:capability chown;
+	')
+')
 ########################################
 #
 # nmbd Local policy
@@ -404,8 +419,7 @@
 read_files_pattern(nmbd_t, samba_etc_t, samba_etc_t)
 
 manage_dirs_pattern(nmbd_t, samba_log_t, samba_log_t)
-append_files_pattern(nmbd_t, samba_log_t, samba_log_t)
-allow nmbd_t samba_log_t:file unlink;
+manage_files_pattern(nmbd_t, samba_log_t, samba_log_t)
 
 read_files_pattern(nmbd_t, samba_log_t, samba_log_t)
 create_files_pattern(nmbd_t, samba_log_t, samba_log_t)
@@ -675,6 +689,7 @@
 
 manage_dirs_pattern(winbind_t, winbind_tmp_t, winbind_tmp_t)
 manage_files_pattern(winbind_t, winbind_tmp_t, winbind_tmp_t)
+manage_sock_files_pattern(winbind_t, winbind_tmp_t, winbind_tmp_t)
 files_tmp_filetrans(winbind_t, winbind_tmp_t, { file dir })
 
 manage_files_pattern(winbind_t, winbind_var_run_t, winbind_var_run_t)
Index: modules/roles/unprivuser.if
===================================================================
--- modules/roles/unprivuser.if	(revision 2767)
+++ modules/roles/unprivuser.if	(working copy)
@@ -146,6 +146,22 @@
 
 ########################################
 ## <summary>
+## Create new home directories with the proper
+## home directory label.
+## </summary>
+## <param name="domain">
+##  <summary>
+##  Domain allowed access.
+##  </summary>
+## </param>
+#
+interface(`unprivuser_create_home_dirs',`
+	unprivuser_home_filetrans_home_dir($1)
+	unprivuser_manage_home_dirs($1)
+')
+
+########################################
+## <summary>
 ##	Create, read, write, and delete
 ##	subdirectories of generic user
 ##	home directories.

--------------040106080006070001060002--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

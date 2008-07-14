Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6EKT0gw007840
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2008 16:29:00 -0400
Received: from cdptpa-omtalb.mail.rr.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6EKSx2j002966
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2008 20:29:00 GMT
Received: from basement.kutulu.org ([70.121.200.185])
          by cdptpa-omta01.mail.rr.com with ESMTP
          id <20080714202820.GDNJ8951.cdptpa-omta01.mail.rr.com@basement.kutulu.org>
          for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2008 20:28:20 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by basement.kutulu.org (Postfix) with ESMTPS id 02F2D1143D
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2008 16:28:17 -0400 (EDT)
Message-ID: <487BB78D.6080500@kutulu.org>
Date: Mon, 14 Jul 2008 16:31:09 -0400
From: Mike Edenfield <kutulu@kutulu.org>
MIME-Version: 1.0
To: SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: refpolicy patch: samba enhancements
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I apologize if I'm not doing this right, I'm kinda new at this...

I have made some changes to the SELinux policy for our intranet servers 
that I thought might be useful to a broader audience.  Included below is 
a patch to the latest refpolicy.  This has been tested on the Gentoo 
systems we have here; I don't have easy access to other SELinux systems 
at the moment.  It does the following:

* Updates samba_stream_connect_winbind to match the observed behavior of 
winbind

* Gives winbind access to delete its own sockets

* Gives nmbd access to fully manage (i.e. rename) log files

* Adds a tunable that lets samba create home directories via pam_mkhomedir


Index: policy/modules/services/samba.if
===================================================================
--- policy/modules/services/samba.if	(revision 2758)
+++ policy/modules/services/samba.if	(working copy)
@@ -484,17 +484,19 @@
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
-		stream_connect_pattern($1,winbind_var_run_t,winbind_var_run_t,winbind_t)
-	',`
+	files_search_pids($1)
+	allow $1 samba_var_t:dir search_dir_perms;
+	stream_connect_pattern($1,winbind_var_run_t,winbind_var_run_t,winbind_t)
+	
+	ifdef(`distro_redhat',`', `
  		gen_require(`
-			type winbind_t, winbind_tmp_t;
+			type winbind_tmp_t;
  		')

  		# the default for the socket is (poorly named):
Index: policy/modules/services/samba.te
===================================================================
--- policy/modules/services/samba.te	(revision 2758)
+++ policy/modules/services/samba.te	(working copy)
@@ -59,6 +59,13 @@
  ## </desc>
  gen_tunable(samba_share_nfs,false)

+## <desc>
+## <p>
+## Allow samba to create new home directories (e.g. via PAM)
+## </p>
+## </desc>
+gen_tunable(samba_create_home_dirs,false)
+
  type nmbd_t;
  type nmbd_exec_t;
  init_daemon_domain(nmbd_t,nmbd_exec_t)
@@ -379,6 +386,14 @@
  	unprivuser_home_dir_filetrans_home_content(nmbd_t, { file dir })
  ')

+tunable_policy(`samba_create_home_dirs',`
+    unprivuser_home_filetrans_home_dir(smbd_t)
+    unprivuser_manage_home_dirs(smbd_t)
+
+    allow smbd_t self:capability chown;
+')
  ########################################
  #
  # nmbd Local policy
@@ -404,7 +419,7 @@
  read_files_pattern(nmbd_t,samba_etc_t,samba_etc_t)

  manage_dirs_pattern(nmbd_t,samba_log_t,samba_log_t)
-append_files_pattern(nmbd_t,samba_log_t,samba_log_t)
+manage_files_pattern(nmbd_t,samba_log_t,samba_log_t)
  allow nmbd_t samba_log_t:file unlink;

  read_files_pattern(nmbd_t,samba_log_t,samba_log_t)
@@ -675,6 +690,7 @@

  manage_dirs_pattern(winbind_t,winbind_tmp_t,winbind_tmp_t)
  manage_files_pattern(winbind_t,winbind_tmp_t,winbind_tmp_t)
+manage_sock_files_pattern(winbind_t,winbind_tmp_t,winbind_tmp_t)
  files_tmp_filetrans(winbind_t, winbind_tmp_t, { file dir })

  manage_files_pattern(winbind_t,winbind_var_run_t,winbind_var_run_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

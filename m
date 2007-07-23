Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6OCPDB3032475
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2007 08:25:13 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6OCPChP011819
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2007 12:25:12 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1) with ESMTP id l6OCOPpj019130
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2007 08:24:25 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1/Submit) id l6OCOP1G019129
	for selinux@tycho.nsa.gov; Tue, 24 Jul 2007 08:24:25 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6NJo14a009520
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2007 15:50:02 -0400
Received: from mx2.sygneca.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6NJnxX7003345
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2007 19:50:00 GMT
Received: from [192.168.2.2] (host81-152-178-129.range81-152.btcentralplus.com [81.152.178.129])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.sygneca.com (Postfix) with ESMTP id 5C796B5B9
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2007 20:49:58 +0100 (BST)
Message-ID: <46A5065B.8050709@martinorr.name>
Date: Mon, 23 Jul 2007 20:49:47 +0100
From: Martin Orr <selinux@martinorr.name>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_tiberius-2504-1185220195-0001-2"
To: selinux@tycho.nsa.gov
Subject: alsactl policy
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_tiberius-2504-1185220195-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

The alsa policy doesn't address alsactl, run from an init script and via a
udev rule whenever a sound device is loaded to set volumes.  This patch
addresses this.  Since I have never written SELinux policy before, all
comments are appreciated.

-- 
Martin Orr

--=_tiberius-2504-1185220195-0001-2
Content-Type: text/plain; name="alsa.diff"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa.diff"

Index: policy/modules/system/init.te
===================================================================
--- policy/modules/system/init.te	(revision 2373)
+++ policy/modules/system/init.te	(working copy)
@@ -541,6 +541,10 @@
 ')
 
 optional_policy(`
+	alsa_domtrans(initrc_t)
+')
+
+optional_policy(`
 	amavis_search_lib(initrc_t)
 	amavis_setattr_pid_files(initrc_t)
 ')
Index: policy/modules/system/udev.te
===================================================================
--- policy/modules/system/udev.te	(revision 2373)
+++ policy/modules/system/udev.te	(working copy)
@@ -176,6 +176,10 @@
 ')
 
 optional_policy(`
+	alsa_domtrans(udev_t)
+')
+
+optional_policy(`
 	consoletype_exec(udev_t)
 ')
 
Index: policy/modules/admin/alsa.te
===================================================================
--- policy/modules/admin/alsa.te	(revision 2373)
+++ policy/modules/admin/alsa.te	(working copy)
@@ -14,6 +14,9 @@
 type alsa_etc_rw_t;
 files_type(alsa_etc_rw_t)
 
+type alsa_var_lib_t;
+files_type(alsa_var_lib_t)
+
 ########################################
 #
 # Local policy
@@ -30,9 +33,20 @@
 manage_lnk_files_pattern(alsa_t,alsa_etc_rw_t,alsa_etc_rw_t)
 
 files_read_etc_files(alsa_t)
+files_read_usr_files(alsa_t)
+files_search_pids(alsa_t)
 
+# asound.state: lives in /var/lib/alsa on Debian, /etc elsewhere
+files_etc_filetrans(alsa_t,alsa_etc_rw_t,file)
+files_search_var_lib(alsa_t)
+manage_files_pattern(alsa_t,alsa_var_lib_t,alsa_var_lib_t)
+
+dev_read_sound(alsa_t)
+dev_write_sound(alsa_t)
+
 term_use_generic_ptys(alsa_t)
 term_dontaudit_use_unallocated_ttys(alsa_t)
+init_dontaudit_use_fds(alsa_t)
 
 libs_use_ld_so(alsa_t)
 libs_use_shared_libs(alsa_t)
@@ -43,6 +57,7 @@
 
 userdom_manage_unpriv_user_semaphores(alsa_t)
 userdom_manage_unpriv_user_shared_mem(alsa_t)
+userdom_search_generic_user_home_dirs(alsa_t)
 
 optional_policy(`
 	nscd_socket_use(alsa_t)
Index: policy/modules/admin/alsa.fc
===================================================================
--- policy/modules/admin/alsa.fc	(revision 2373)
+++ policy/modules/admin/alsa.fc	(working copy)
@@ -1,4 +1,8 @@
 
 /etc/alsa/pcm(/.*)?		gen_context(system_u:object_r:alsa_etc_rw_t,s0)
 
+/etc/asound\.state	--	gen_context(system_u:object_r:alsa_etc_rw_t,s0)
+/var/lib/alsa(/.*)?		gen_context(system_u:object_r:alsa_var_lib_t,s0)
+
 /usr/bin/ainit 		--	gen_context(system_u:object_r:alsa_exec_t,s0)
+/usr/sbin/alsactl	--	gen_context(system_u:object_r:alsa_exec_t,s0)


--=_tiberius-2504-1185220195-0001-2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

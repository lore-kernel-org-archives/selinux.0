Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8GKDOVZ011746
	for <selinux@tycho.nsa.gov>; Sun, 16 Sep 2007 16:13:24 -0400
Received: from mx2.sygneca.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8GKDMGA026408
	for <selinux@tycho.nsa.gov>; Sun, 16 Sep 2007 20:13:23 GMT
Received: from [192.168.1.101] (cpc3-bele5-0-0-cust269.belf.cable.ntl.com [82.18.189.14])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.sygneca.com (Postfix) with ESMTP id 809A2A301C
	for <selinux@tycho.nsa.gov>; Sun, 16 Sep 2007 21:13:21 +0100 (BST)
Date: Sun, 16 Sep 2007 21:13:19 +0100
From: Martin Orr <martin@martinorr.name>
To: selinux@tycho.nsa.gov
Subject: alsactl policy
Message-ID: <20070916201319.GA2705@tiberius.martinorr.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here's a new version of the patch I sent a while ago to add policy for
alsactl.  This is run from an init script to set set volume levels on
boot.  At least on Debian and Fedora, it is also run by udev when a
sound card is detected.

Index: policy/modules/admin/alsa.te
===================================================================
--- policy/modules/admin/alsa.te	(revision 2411)
+++ policy/modules/admin/alsa.te	(working copy)
@@ -8,12 +8,18 @@
 
 type alsa_t;
 type alsa_exec_t;
-application_domain(alsa_t, alsa_exec_t)
+init_system_domain(alsa_t, alsa_exec_t)
 role system_r types alsa_t;
 
 type alsa_etc_rw_t;
 files_type(alsa_etc_rw_t)
 
+type alsa_var_lib_t;
+files_type(alsa_var_lib_t)
+
+type alsa_state_t;
+files_type(alsa_state_t)
+
 ########################################
 #
 # Local policy
@@ -30,9 +36,23 @@
 manage_lnk_files_pattern(alsa_t,alsa_etc_rw_t,alsa_etc_rw_t)
 
 files_read_etc_files(alsa_t)
+files_read_usr_files(alsa_t)
+files_search_pids(alsa_t)
 
+allow alsa_t alsa_state_t:file manage_file_perms;
+ifdef(`distro_debian',`
+	files_search_var_lib(alsa_t)
+	filetrans_pattern(alsa_t,alsa_var_lib_t,alsa_state_t,file)
+',`
+	files_etc_filetrans(alsa_t,alsa_state_t,file)
+')
+
+dev_read_sound(alsa_t)
+dev_write_sound(alsa_t)
+
 term_use_generic_ptys(alsa_t)
 term_dontaudit_use_unallocated_ttys(alsa_t)
+init_dontaudit_use_fds(alsa_t)
 
 libs_use_ld_so(alsa_t)
 libs_use_shared_libs(alsa_t)
@@ -43,6 +63,7 @@
 
 userdom_manage_unpriv_user_semaphores(alsa_t)
 userdom_manage_unpriv_user_shared_mem(alsa_t)
+userdom_search_generic_user_home_dirs(alsa_t)
 
 optional_policy(`
 	nscd_socket_use(alsa_t)
Index: policy/modules/admin/alsa.if
===================================================================
--- policy/modules/admin/alsa.if	(revision 2411)
+++ policy/modules/admin/alsa.if	(working copy)
@@ -74,3 +74,26 @@
 	read_files_pattern($1,alsa_etc_rw_t,alsa_etc_rw_t)
 	read_lnk_files_pattern($1,alsa_etc_rw_t,alsa_etc_rw_t)
 ')
+
+########################################
+## <summary>
+##	Read alsa state file.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`alsa_read_state',`
+	gen_require(`
+		type alsa_state_t, alsa_var_lib_t;
+	')
+	ifdef(`distro_debian',`
+		files_search_var_lib($1)
+		read_files_pattern($1,alsa_var_lib_t,alsa_state_t)
+	',`
+		files_search_etc($1)
+		allow $1 alsa_state_t:file read_file_perms;
+	')
+')
Index: policy/modules/admin/alsa.fc
===================================================================
--- policy/modules/admin/alsa.fc	(revision 2411)
+++ policy/modules/admin/alsa.fc	(working copy)
@@ -1,4 +1,10 @@
 
 /etc/alsa/pcm(/.*)?		gen_context(system_u:object_r:alsa_etc_rw_t,s0)
 
+/etc/(alsa/)?asound\.state --	gen_context(system_u:object_r:alsa_state_t,s0)
+/var/lib/alsa		-d	gen_context(system_u:object_r:alsa_var_lib_t,s0)
+/var/lib/alsa/asound.state --	gen_context(system_u:object_r:alsa_state_t,s0)
+
 /usr/bin/ainit 		--	gen_context(system_u:object_r:alsa_exec_t,s0)
+/usr/sbin/alsactl	--	gen_context(system_u:object_r:alsa_exec_t,s0)
+/usr/bin/amixer		--	gen_context(system_u:object_r:alsa_exec_t,s0)
Index: policy/modules/system/udev.te
===================================================================
--- policy/modules/system/udev.te	(revision 2411)
+++ policy/modules/system/udev.te	(working copy)
@@ -190,6 +190,11 @@
 ')
 
 optional_policy(`
+	alsa_domtrans(udev_t)
+	alsa_read_state(udev_t)
+')
+
+optional_policy(`
 	brctl_domtrans(udev_t)
 ')
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

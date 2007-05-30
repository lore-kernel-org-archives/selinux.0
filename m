Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHapDV013724
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:51 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHanue002797
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:49 GMT
Date: Wed, 30 May 2007 11:32:08 -0400
Message-Id: <200705301532.l4UFW8fg010656@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: admin_alsa changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Alsa policy was very broken,  Now works on suspend/resume
--- nsaserefpolicy/policy/modules/admin/alsa.fc	2007-05-29 14:10:59.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/admin/alsa.fc	2007-05-30 09:25:53.000000000 -0400
@@ -1,4 +1,7 @@
 
 /etc/alsa/pcm(/.*)?		gen_context(system_u:object_r:alsa_etc_rw_t,s0)
+/etc/asound(/.*)?		gen_context(system_u:object_r:alsa_etc_rw_t,s0)
+/etc/asound\.state		gen_context(system_u:object_r:alsa_etc_rw_t,s0)
 
 /usr/bin/ainit 		--	gen_context(system_u:object_r:alsa_exec_t,s0)
+/sbin/alsactl 		--	gen_context(system_u:object_r:alsa_exec_t,s0)
--- nsaserefpolicy/policy/modules/admin/alsa.te	2007-05-29 14:10:59.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/admin/alsa.te	2007-05-30 09:25:53.000000000 -0400
@@ -20,20 +20,24 @@
 # Local policy
 #
 
-allow alsa_t self:capability { setgid setuid ipc_owner };
+allow alsa_t self:capability { dac_read_search dac_override setgid setuid ipc_owner };
 dontaudit alsa_t self:capability sys_admin;
 allow alsa_t self:sem create_sem_perms;
 allow alsa_t self:shm create_shm_perms;
 allow alsa_t self:unix_stream_socket create_stream_socket_perms;
 allow alsa_t self:unix_dgram_socket create_socket_perms;
 
+dev_read_sound(alsa_t)
+dev_write_sound(alsa_t)
+
+files_etc_filetrans(alsa_t, alsa_etc_rw_t, file)
 manage_files_pattern(alsa_t,alsa_etc_rw_t,alsa_etc_rw_t)
 manage_lnk_files_pattern(alsa_t,alsa_etc_rw_t,alsa_etc_rw_t)
 
+files_search_home(alsa_t)
 files_read_etc_files(alsa_t)
 
-term_use_generic_ptys(alsa_t)
-term_dontaudit_use_unallocated_ttys(alsa_t)
+kernel_read_system_state(alsa_t)
 
 libs_use_ld_so(alsa_t)
 libs_use_shared_libs(alsa_t)
@@ -44,7 +48,17 @@
 
 userdom_manage_unpriv_user_semaphores(alsa_t)
 userdom_manage_unpriv_user_shared_mem(alsa_t)
+userdom_search_generic_user_home_dirs(alsa_t)
+
+term_use_generic_ptys(alsa_t)
+term_dontaudit_use_unallocated_ttys(alsa_t)
 
 optional_policy(`
 	nscd_socket_use(alsa_t)
 ')
+
+optional_policy(`
+	hal_use_fds(alsa_t)
+	hal_write_log(alsa_t)
+')
+

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbu1j014374
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:56 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbr2p008432
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:54 GMT
Date: Wed, 30 May 2007 11:04:38 -0400
Message-Id: <200705301504.l4UF4cEH009265@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: Avahi changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Avahi needs fowner
Uses nsswitch

--- nsaserefpolicy/policy/modules/services/avahi.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/avahi.te	2007-05-30 09:25:53.000000000 -0400
@@ -18,7 +18,7 @@
 # Local policy
 #
 
-allow avahi_t self:capability { dac_override setgid chown kill setuid sys_chroot };
+allow avahi_t self:capability { dac_override setgid chown fowner kill setuid sys_chroot };
 dontaudit avahi_t self:capability sys_tty_config;
 allow avahi_t self:process { setrlimit signal_perms setcap };
 allow avahi_t self:fifo_file { read write };
@@ -32,6 +32,8 @@
 allow avahi_t avahi_var_run_t:dir setattr;
 files_pid_filetrans(avahi_t,avahi_var_run_t,file)
 
+auth_use_nsswitch(avahi_t)
+
 kernel_read_kernel_sysctls(avahi_t)
 kernel_list_proc(avahi_t)
 kernel_read_proc_symlinks(avahi_t)
@@ -63,8 +65,6 @@
 files_read_etc_runtime_files(avahi_t)
 files_read_usr_files(avahi_t)
 
-auth_use_nsswitch(avahi_t)
-
 init_signal_script(avahi_t)
 init_signull_script(avahi_t)
 
@@ -75,8 +75,6 @@
 
 miscfiles_read_localization(avahi_t)
 
-sysnet_read_config(avahi_t)
-
 userdom_dontaudit_use_unpriv_user_fds(avahi_t)
 userdom_dontaudit_search_sysadm_home_dirs(avahi_t)
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KIZdG023235
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:18:35 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KIYM1003381
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:18:34 GMT
Date: Thu, 2 Aug 2007 16:18:30 -0400
Message-Id: <200708022018.l72KIU8q030133@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: system_raid changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

mdadm makes nodes
Tries to look in users homedirs

--- nsaserefpolicy/policy/modules/system/raid.te	2007-06-15 14:54:34.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/system/raid.te	2007-08-02 11:02:02.000000000 -0400
@@ -19,7 +19,7 @@
 # Local policy
 #
 
-allow mdadm_t self:capability { dac_override sys_admin ipc_lock };
+allow mdadm_t self:capability { dac_override mknod sys_admin ipc_lock };
 dontaudit mdadm_t self:capability sys_tty_config;
 allow mdadm_t self:process { sigchld sigkill sigstop signull signal };
 allow mdadm_t self:fifo_file rw_fifo_file_perms;
@@ -70,6 +70,7 @@
 
 userdom_dontaudit_use_unpriv_user_fds(mdadm_t)
 userdom_dontaudit_use_sysadm_ttys(mdadm_t)
+userdom_dontaudit_search_all_users_home_content(mdadm_t)
 
 mta_send_mail(mdadm_t)
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

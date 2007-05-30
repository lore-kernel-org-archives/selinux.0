Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbQmX014274
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:26 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbLue002852
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:21 GMT
Date: Wed, 30 May 2007 10:17:26 -0400
Message-Id: <200705301417.l4UEHQRW007726@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: iptables reads etc runtime files, execed out of failto ban with terminal redirected
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/system/iptables.te	2007-05-29 14:10:58.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/system/iptables.te	2007-05-30 09:22:02.000000000 -0400
@@ -56,6 +56,7 @@
 domain_use_interactive_fds(iptables_t)
 
 files_read_etc_files(iptables_t)
+files_read_etc_runtime_files(iptables_t)
 
 init_use_fds(iptables_t)
 init_use_script_ptys(iptables_t)
@@ -77,6 +78,10 @@
 userdom_use_all_users_fds(iptables_t)
 
 optional_policy(`
+	fail2ban_append_log(iptables_t)
+')
+
+optional_policy(`
 	firstboot_use_fds(iptables_t)
 	firstboot_rw_pipes(iptables_t)
 ')


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

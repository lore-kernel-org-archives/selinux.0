Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHaow3013672
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:50 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHamue002793
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:48 GMT
Date: Wed, 30 May 2007 11:28:16 -0400
Message-Id: <200705301528.l4UFSGtm010584@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: admin_logrotate changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Remove unconfined_domain from logrotate, needs to be able to write files at different sensitivities
--- nsaserefpolicy/policy/modules/admin/logrotate.te	2007-05-29 14:10:59.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/admin/logrotate.te	2007-05-30 09:25:53.000000000 -0400
@@ -75,6 +75,7 @@
 mls_file_read_up(logrotate_t)
 mls_file_write_down(logrotate_t)
 mls_file_upgrade(logrotate_t)
+mls_process_write_down(logrotate_t)
 
 selinux_get_fs_mount(logrotate_t)
 selinux_get_enforce_mode(logrotate_t)
@@ -193,10 +194,6 @@
 	squid_domtrans(logrotate_t)
 ')
 
-optional_policy(`
-	unconfined_domain(logrotate_t)
-')
-
 ifdef(`TODO',`
 # it should not require this
 allow logrotate_t {staff_home_dir_t sysadm_home_dir_t}:dir { getattr read search };

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

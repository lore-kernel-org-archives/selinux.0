Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74CjxD7014023
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:45:59 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74Cjw7E012563
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:45:59 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id E209641C
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:45:57 +0200 (CEST)
Message-Id: <20080804123738.402815931@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:35:19 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 23/35] iptables policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Trivial changes from the RH patchset to the iptables module...
Index: refpolicy/policy/modules/system/iptables.te
===================================================================
--- refpolicy.orig/policy/modules/system/iptables.te	2008-07-19 19:15:43.000000000 +0200
+++ refpolicy/policy/modules/system/iptables.te	2008-08-03 20:38:53.000000000 +0200
@@ -48,6 +48,7 @@
 
 fs_getattr_xattr_fs(iptables_t)
 fs_search_auto_mountpoints(iptables_t)
+fs_list_inotifyfs(iptables_t)
 
 mls_file_read_all_levels(iptables_t)
 
@@ -70,8 +71,6 @@
 libs_use_shared_libs(iptables_t)
 
 logging_send_syslog_msg(iptables_t)
-# system-config-network appends to /var/log
-#logging_append_system_logs(iptables_t)
 
 miscfiles_read_localization(iptables_t)
 

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

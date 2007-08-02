Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72Jw9nR021298
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 15:58:09 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72Jw7OD028614
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 19:58:08 GMT
Date: Thu, 2 Aug 2007 15:57:04 -0400
Message-Id: <200708021957.l72Jv463029456@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: apps_slocate changes 
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

locate uses nsswitch (getpwnam)
--- nsaserefpolicy/policy/modules/apps/slocate.te	2007-07-25 10:37:37.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/apps/slocate.te	2007-08-02 11:02:02.000000000 -0400
@@ -29,6 +29,8 @@
 manage_dirs_pattern(locate_t,locate_var_lib_t,locate_var_lib_t)
 manage_files_pattern(locate_t,locate_var_lib_t,locate_var_lib_t)
 
+auth_use_nsswitch(locate_t)
+
 kernel_read_system_state(locate_t)
 kernel_dontaudit_search_sysctl(locate_t)
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

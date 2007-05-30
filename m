Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHasGO013790
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:54 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHapue002811
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:51 GMT
Date: Wed, 30 May 2007 10:27:08 -0400
Message-Id: <200705301427.l4UER8UJ007819@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: rlogind needs to be able to change passwd data
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/rlogin.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/rlogin.te	2007-05-30 09:08:15.000000000 -0400
@@ -64,6 +64,7 @@
 fs_search_auto_mountpoints(rlogind_t)
 
 auth_domtrans_chk_passwd(rlogind_t)
+auth_domtrans_upd_passwd(rlogind_t)
 auth_rw_login_records(rlogind_t)
 auth_use_nsswitch(rlogind_t)
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

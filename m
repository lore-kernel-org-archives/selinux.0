Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHajei013496
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:46 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHai2p008176
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:44 GMT
Date: Wed, 30 May 2007 11:22:20 -0400
Message-Id: <200705301522.l4UFMK0D010491@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: apps_mplayer changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Remove comments

--- nsaserefpolicy/policy/modules/apps/mplayer.te	2007-05-29 14:10:48.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/apps/mplayer.te	2007-05-30 09:25:53.000000000 -0400
@@ -22,7 +22,3 @@
 type mplayer_exec_t;
 corecmd_executable_file(mplayer_exec_t)
 
-#ifdef(`targeted_policy',`
-#	unconfined_execmem_alias_program(mencoder_exec_t)
-#	unconfined_execmem_alias_program(mplayer_exec_t)
-#')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

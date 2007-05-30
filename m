Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbu2D014392
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:56 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbr2p008431
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:53 GMT
Date: Wed, 30 May 2007 10:30:49 -0400
Message-Id: <200705301430.l4UEUn0v007884@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: Proper transition rules for pppd to create /etc/resolv.confe
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/ppp.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/ppp.te	2007-05-30 07:35:54.000000000 -0400
@@ -153,7 +153,7 @@
 
 files_exec_etc_files(pppd_t)
 files_manage_etc_runtime_files(pppd_t)
-files_etc_filetrans_etc_runtime(pppd_t, { dir file })
+sysnet_etc_filetrans_config(pppd_t)
 files_dontaudit_write_etc_files(pppd_t)
 
 # for scripts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72JZoRl019601
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 15:35:50 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72JZlev025399
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 19:35:48 GMT
Date: Thu, 2 Aug 2007 15:35:44 -0400
Message-Id: <200708021935.l72JZi7C028806@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: admin_bootloader changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hal redirects output to log file
--- nsaserefpolicy/policy/modules/admin/bootloader.te	2007-07-25 10:37:43.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/admin/bootloader.te	2007-08-02 11:02:02.000000000 -0400
@@ -180,6 +180,7 @@
 
 optional_policy(`
 	hal_dontaudit_append_lib_files(bootloader_t)
+	hal_write_log(bootloader_t)
 ')
 
 optional_policy(`

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

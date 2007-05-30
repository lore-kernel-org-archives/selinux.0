Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbPSa014271
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:25 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbLue002851
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:21 GMT
Date: Wed, 30 May 2007 10:22:43 -0400
Message-Id: <200705301422.l4UEMhjS007772@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: fsdaemon writes files/disks at different levels, Needs write down.
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/smartmon.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/smartmon.te	2007-05-30 09:08:15.000000000 -0400
@@ -60,6 +60,7 @@
 fs_search_auto_mountpoints(fsdaemon_t)
 
 mls_file_read_up(fsdaemon_t)
+mls_file_write_down(fsdaemon_t)
 
 storage_raw_read_fixed_disk(fsdaemon_t)
 storage_raw_write_fixed_disk(fsdaemon_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KIvwE023272
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:18:57 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KIrTm002722
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:18:54 GMT
Date: Thu, 2 Aug 2007 16:18:43 -0400
Message-Id: <200708022018.l72KIh0n030143@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: system_netlabel changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/system/netlabel.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/system/netlabel.te	2007-08-02 11:02:02.000000000 -0400
@@ -19,6 +19,8 @@
 allow netlabel_mgmt_t self:capability net_admin;
 allow netlabel_mgmt_t self:netlink_socket create_socket_perms;
 
+files_read_etc_files(netlabel_mgmt_t)
+
 kernel_read_network_state(netlabel_mgmt_t)
 
 libs_use_ld_so(netlabel_mgmt_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

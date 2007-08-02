Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72L0pHr028142
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 17:00:51 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72L0oTm011089
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 21:00:50 GMT
Date: Thu, 2 Aug 2007 17:00:46 -0400
Message-Id: <200708022100.l72L0kmi000808@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_audioentropy changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Audit entropy needs dav_override and read/write random device

--- nsaserefpolicy/policy/modules/services/audioentropy.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/audioentropy.te	2007-08-02 11:02:02.000000000 -0400
@@ -18,7 +18,7 @@
 # Local policy
 #
 
-allow entropyd_t self:capability { ipc_lock sys_admin };
+allow entropyd_t self:capability { dac_override ipc_lock sys_admin };
 dontaudit entropyd_t self:capability sys_tty_config;
 allow entropyd_t self:process signal_perms;
 
@@ -32,6 +32,8 @@
 dev_read_sysfs(entropyd_t)
 dev_read_urand(entropyd_t)
 dev_write_urand(entropyd_t)
+dev_read_rand(entropyd_t)
+dev_write_rand(entropyd_t)
 dev_read_sound(entropyd_t)
 
 fs_getattr_all_fs(entropyd_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

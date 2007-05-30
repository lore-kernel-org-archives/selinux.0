Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHarxQ013782
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:54 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHap2p008228
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:51 GMT
Date: Wed, 30 May 2007 10:39:17 -0400
Message-Id: <200705301439.l4UEdHj6008019@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: Oddjob does not use the audit system
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/oddjob.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/oddjob.te	2007-05-30 07:35:54.000000000 -0400
@@ -27,7 +27,7 @@
 # oddjob local policy
 #
 
-allow oddjob_t self:capability { audit_write setgid } ;
+allow oddjob_t self:capability setgid;
 allow oddjob_t self:process { setexec signal };
 allow oddjob_t self:fifo_file { read write };
 allow oddjob_t self:unix_stream_socket create_stream_socket_perms;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

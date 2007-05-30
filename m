Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHarDc013777
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:53 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHak2p008191
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:46 GMT
Date: Wed, 30 May 2007 10:22:48 -0400
Message-Id: <200705301422.l4UEMm26007773@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: setroubleshoot sends signull to itself
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/setroubleshoot.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/setroubleshoot.te	2007-05-30 09:08:15.000000000 -0400
@@ -28,7 +28,7 @@
 #
 
 allow setroubleshootd_t self:capability { dac_override sys_tty_config };
-allow setroubleshootd_t self:process { signal getattr getsched };
+allow setroubleshootd_t self:process { signull signal getattr getsched };
 allow setroubleshootd_t self:fifo_file rw_fifo_file_perms;
 allow setroubleshootd_t self:tcp_socket create_stream_socket_perms;
 allow setroubleshootd_t self:unix_stream_socket { create_stream_socket_perms connectto };

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72Kh4Yr025768
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:43:04 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72Kh3Tm007315
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:43:03 GMT
Date: Thu, 2 Aug 2007 16:42:59 -0400
Message-Id: <200708022042.l72Kgxb8032656@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_radius changes, raid with certs
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/radius.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/radius.te	2007-08-02 11:02:02.000000000 -0400
@@ -99,6 +100,7 @@
 logging_send_syslog_msg(radiusd_t)
 
 miscfiles_read_localization(radiusd_t)
+miscfiles_read_certs(radiusd_t)
 
 sysnet_read_config(radiusd_t)
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

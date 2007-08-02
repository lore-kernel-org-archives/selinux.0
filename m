Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72Kf8qw025474
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:41:08 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72Kf4Tm006948
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:41:05 GMT
Date: Thu, 2 Aug 2007 16:40:56 -0400
Message-Id: <200708022040.l72Keu8m032593@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_rshd changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Remove unconfiend_domain from rshd
--- nsaserefpolicy/policy/modules/services/rshd.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/rshd.te	2007-08-02 11:02:02.000000000 -0400
@@ -85,6 +86,5 @@
 ')
 
 optional_policy(`
-	unconfined_domain(rshd_t)
 	unconfined_shell_domtrans(rshd_t)
 ')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KXCBx024716
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:33:12 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KXAM1006457
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:33:10 GMT
Date: Thu, 2 Aug 2007 16:31:59 -0400
Message-Id: <200708022031.l72KVx2S032312@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_amavis changes amavis signals pyzor
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/amavis.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/amavis.te	2007-08-02 11:02:02.000000000 -0400
@@ -166,6 +166,7 @@
 
 optional_policy(`
 	pyzor_domtrans(amavis_t)
+	pyzor_signal(amavis_t)
 ')
 
 optional_policy(`

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

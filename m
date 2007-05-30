Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbLBO014141
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:21 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbG2p008295
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:17 GMT
Date: Wed, 30 May 2007 10:22:57 -0400
Message-Id: <200705301422.l4UEMvG9007776@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: saslauthd needs to be able to update the passwd file (passwd expired)
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/sasl.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/sasl.te	2007-05-30 09:08:15.000000000 -0400
@@ -63,6 +63,7 @@
 selinux_compute_access_vector(saslauthd_t)
 
 auth_domtrans_chk_passwd(saslauthd_t)
+auth_domtrans_upd_passwd(saslauthd_t)
 auth_use_nsswitch(saslauthd_t)
 
 domain_use_interactive_fds(saslauthd_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

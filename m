Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbrES014337
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:53 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbq2p008426
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:52 GMT
Date: Wed, 30 May 2007 10:37:19 -0400
Message-Id: <200705301437.l4UEbJ3D007987@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: fix openvpn log/run file context
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/openvpn.fc	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/openvpn.fc	2007-05-30 09:08:15.000000000 -0400
@@ -11,5 +11,5 @@
 #
 # /var
 #
-/var/log/openvpn.*	--	gen_context(system_u:object_r:openvpn_var_log_t,s0)
-/var/run/openvpn.*	--	gen_context(system_u:object_r:openvpn_var_run_t,s0)
+/var/log/openvpn(/.*)?		gen_context(system_u:object_r:openvpn_var_log_t,s0)
+/var/run/openvpn(/.*)?		gen_context(system_u:object_r:openvpn_var_run_t,s0)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHapRv013693
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:51 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHamue002794
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:48 GMT
Date: Wed, 30 May 2007 11:44:17 -0400
Message-Id: <200705301544.l4UFiHN3011890@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: services_networkmanager changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Additional transition rule so uncofnined_t can transition to network manager, requested by networkmanager maintainers
--- nsaserefpolicy/policy/modules/services/networkmanager.if	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/networkmanager.if	2007-05-30 09:25:53.000000000 -0400
@@ -78,3 +78,22 @@
 	allow $1 NetworkManager_t:dbus send_msg;
 	allow NetworkManager_t $1:dbus send_msg;
 ')
+
+########################################
+## <summary>
+##	Transition to NetworkManager 
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`networkmanager_domtrans',`
+	gen_require(`
+		type NetworkManager_t, NetworkManager_exec_t;
+	')
+	corecmd_search_bin($1)
+	domtrans_pattern($1,NetworkManager_exec_t,NetworkManager_t)
+
+')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

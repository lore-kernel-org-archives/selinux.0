Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHamcT013612
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:48 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHal2p008192
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:47 GMT
Date: Wed, 30 May 2007 08:48:41 -0400
Message-Id: <200705301248.l4UCmfWL003431@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: dhcpc needs additional access to dbus, executes restorecon
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/system/sysnetwork.te	2007-05-29 14:10:58.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/system/sysnetwork.te	2007-05-30 07:35:54.000000000 -0400
@@ -158,6 +158,10 @@
 	dbus_connect_system_bus(dhcpc_t)
 	dbus_send_system_bus(dhcpc_t)
 
+	dbus_read_config(dhcpc_t)
+
+	dbus_dontaudit_rw_system_selinux_socket(dhcpc_t)
+
 	optional_policy(`
 		networkmanager_dbus_chat(dhcpc_t)
 	')
@@ -215,6 +219,7 @@
 optional_policy(`
 	seutil_sigchld_newrole(dhcpc_t)
 	seutil_dontaudit_search_config(dhcpc_t)
+	seutil_domtrans_setfiles(dhcpc_t)
 ')
 
 optional_policy(`

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

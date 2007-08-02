Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KwWmK027902
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:58:32 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KwUTm010685
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:58:31 GMT
Date: Thu, 2 Aug 2007 16:58:27 -0400
Message-Id: <200708022058.l72KwRFF000710@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_bluetooth changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Added interface to allow tools to communicate with normal users
--- nsaserefpolicy/policy/modules/services/bluetooth.te	2007-08-02 08:17:27.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/bluetooth.te	2007-08-02 11:02:02.000000000 -0400
@@ -128,6 +128,7 @@
 	dbus_system_bus_client_template(bluetooth,bluetooth_t)
 	dbus_connect_system_bus(bluetooth_t)
 	dbus_send_system_bus(bluetooth_t)
+	userdom_dbus_chat_all_users(bluetooth_t)
 ')
 
 optional_policy(`

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

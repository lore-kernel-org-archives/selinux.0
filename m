Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHakPI013510
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:46 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHajue002772
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:45 GMT
Date: Wed, 30 May 2007 10:52:00 -0400
Message-Id: <200705301452.l4UEq0GX008232@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: dhcpd needs additional privs from dbus
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/dhcp.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/dhcp.te	2007-05-30 07:35:54.000000000 -0400
@@ -113,6 +113,8 @@
 	dbus_system_bus_client_template(dhcpd,dhcpd_t)
 	dbus_connect_system_bus(dhcpd_t)
 	dbus_send_system_bus(dhcpd_t)
+	dbus_read_config(dhcpd_t)
+	dbus_dontaudit_rw_system_selinux_socket(dhcpd_t)
 ')
 
 optional_policy(`

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

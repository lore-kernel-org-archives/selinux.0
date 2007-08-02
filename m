Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72Ks8jZ027382
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:54:08 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72Ks7M1010490
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:54:07 GMT
Date: Thu, 2 Aug 2007 16:54:03 -0400
Message-Id: <200708022054.l72Ks3lf000570@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_dhcp changes - dbus fixes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/dhcp.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/dhcp.te	2007-08-02 11:02:02.000000000 -0400
@@ -114,6 +114,8 @@
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

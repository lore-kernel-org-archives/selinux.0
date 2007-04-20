Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3KJUPns027416
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 15:30:25 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3KJUOP1004182
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 19:30:24 GMT
From: dwalsh@redhat.com
Date: Fri, 20 Apr 2007 15:29:53 -0400
Message-Id: <200704201929.l3KJTrNg027302@redsox.boston.devel.redhat.com>
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: misc fixes for netutils
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- nsaserefpolicy/policy/modules/admin/netutils.te	2007-03-26 16:24:13.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/admin/netutils.te	2007-04-11 17:07:34.000000000 -0400
@@ -40,6 +41,7 @@
 
 # Perform network administration operations and have raw access to the network.
 allow netutils_t self:capability { net_admin net_raw setuid setgid };
+dontaudit netutils_t self:capability sys_tty_config;
 allow netutils_t self:process { sigkill sigstop signull signal };
 allow netutils_t self:netlink_route_socket { bind create getattr nlmsg_read nlmsg_write read write };
 allow netutils_t self:packet_socket create_socket_perms;
@@ -50,6 +52,8 @@
 manage_files_pattern(netutils_t,netutils_tmp_t,netutils_tmp_t)
 files_tmp_filetrans(netutils_t, netutils_tmp_t, { file dir })
 
+dev_read_sysfs(netutils_t)
+
 kernel_search_proc(netutils_t)
 
 corenet_non_ipsec_sendrecv(netutils_t)
@@ -132,6 +136,8 @@
 
 logging_send_syslog_msg(ping_t)
 
+miscfiles_read_localization(ping_t)
+
 sysnet_read_config(ping_t)
 sysnet_dns_name_resolve(ping_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

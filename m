Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbKCt014110
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:20 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbH2p008300
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:17 GMT
Date: Wed, 30 May 2007 11:06:42 -0400
Message-Id: <200705301506.l4UF6gtR009303@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: Arpwatch uses nsswitch
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/arpwatch.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/arpwatch.te	2007-05-30 09:25:53.000000000 -0400
@@ -28,7 +28,6 @@
 allow arpwatch_t self:process signal_perms;
 allow arpwatch_t self:unix_dgram_socket create_socket_perms;
 allow arpwatch_t self:unix_stream_socket create_stream_socket_perms;
-allow arpwatch_t self:netlink_route_socket r_netlink_socket_perms;
 allow arpwatch_t self:tcp_socket { connect create_stream_socket_perms };
 allow arpwatch_t self:udp_socket create_socket_perms;
 allow arpwatch_t self:packet_socket create_socket_perms;
@@ -78,15 +77,13 @@
 
 miscfiles_read_localization(arpwatch_t)
 
-sysnet_read_config(arpwatch_t)
-
 userdom_dontaudit_use_unpriv_user_fds(arpwatch_t)
 userdom_dontaudit_search_sysadm_home_dirs(arpwatch_t)
 
 mta_send_mail(arpwatch_t)
 
 optional_policy(`
-	nis_use_ypbind(arpwatch_t)
+	auth_use_nsswitch(arpwatch_t)
 ')
 
 optional_policy(`

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

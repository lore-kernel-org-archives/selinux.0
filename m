Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72Km4VG026557
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:48:04 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72Km0M1009275
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:48:00 GMT
Date: Thu, 2 Aug 2007 16:47:49 -0400
Message-Id: <200708022047.l72Klnml000346@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_nscd changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Change to use audit interfaces
Work with samba domain controller

--- nsaserefpolicy/policy/modules/services/nscd.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/nscd.te	2007-08-02 11:02:02.000000000 -0400
@@ -28,14 +28,14 @@
 # Local policy
 #
 
-allow nscd_t self:capability { kill setgid setuid audit_write };
+allow nscd_t self:capability { kill setgid setuid };
 dontaudit nscd_t self:capability sys_tty_config;
-allow nscd_t self:process { getattr setsched signal_perms };
+allow nscd_t self:process { getattr setcap setsched signal_perms };
 allow nscd_t self:fifo_file { read write };
 allow nscd_t self:unix_stream_socket create_stream_socket_perms;
 allow nscd_t self:unix_dgram_socket create_socket_perms;
 allow nscd_t self:netlink_selinux_socket create_socket_perms;
-allow nscd_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
+
 allow nscd_t self:tcp_socket create_socket_perms;
 allow nscd_t self:udp_socket create_socket_perms;
 
@@ -73,6 +73,8 @@
 corenet_udp_sendrecv_all_nodes(nscd_t)
 corenet_tcp_sendrecv_all_ports(nscd_t)
 corenet_udp_sendrecv_all_ports(nscd_t)
+corenet_udp_bind_all_nodes(nscd_t)
+corenet_udp_bind_all_nodes(nscd_t)
 corenet_tcp_connect_all_ports(nscd_t)
 corenet_sendrecv_all_client_packets(nscd_t)
 corenet_rw_tun_tap_dev(nscd_t)
@@ -93,6 +95,7 @@
 libs_use_ld_so(nscd_t)
 libs_use_shared_libs(nscd_t)
 
+logging_send_audit_msgs(nscd_t)
 logging_send_syslog_msg(nscd_t)
 
 miscfiles_read_localization(nscd_t)
@@ -114,3 +117,12 @@
 	xen_dontaudit_rw_unix_stream_sockets(nscd_t)
 	xen_append_log(nscd_t)
 ')
+
+optional_policy(`
+	tunable_policy(`samba_domain_controller',`
+		samba_append_log(nscd_t)
+		samba_dontaudit_use_fds(nscd_t)
+	')
+	samba_read_config(nscd_t)
+	samba_read_var_files(nscd_t)
+')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

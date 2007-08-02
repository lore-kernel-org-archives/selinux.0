Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72JQkEB018748
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 15:26:46 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72JQjOD022917
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 19:26:45 GMT
Date: Thu, 2 Aug 2007 15:26:23 -0400
Message-Id: <200708021926.l72JQNnn025047@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_bind changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

bind now listens on dhcpd port
New cache directory

--- nsaserefpolicy/policy/modules/services/bind.fc	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/bind.fc	2007-08-02 11:02:02.000000000 -0400
@@ -45,4 +45,6 @@
 /var/named/chroot/var/named/slaves(/.*)? gen_context(system_u:object_r:named_cache_t,s0)
 /var/named/chroot/var/named/data(/.*)? gen_context(system_u:object_r:named_cache_t,s0)
 /var/named/chroot/var/named/named\.ca -- gen_context(system_u:object_r:named_conf_t,s0)
+/var/named/dynamic(/.*)?		gen_context(system_u:object_r:named_cache_t,s0)
+/var/named/chroot/var/named/dynamic(/.*)?	gen_context(system_u:object_r:named_cache_t,s0)
 ')
--- nsaserefpolicy/policy/modules/services/bind.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/bind.te	2007-08-02 11:02:02.000000000 -0400
@@ -119,6 +119,11 @@
 corenet_sendrecv_dns_client_packets(named_t)
 corenet_sendrecv_rndc_server_packets(named_t)
 corenet_sendrecv_rndc_client_packets(named_t)
+corenet_udp_bind_all_unreserved_ports(named_t)
+
+#dnsmasq 
+corenet_tcp_bind_dhcpd_port(named_t)
+corenet_udp_bind_dhcpd_port(named_t)
 
 dev_read_sysfs(named_t)
 dev_read_rand(named_t)
@@ -232,6 +237,7 @@
 corenet_tcp_sendrecv_all_nodes(ndc_t)
 corenet_tcp_sendrecv_all_ports(ndc_t)
 corenet_tcp_connect_rndc_port(ndc_t)
+corenet_tcp_bind_all_nodes(ndc_t)
 corenet_sendrecv_rndc_client_packets(ndc_t)
 
 fs_getattr_xattr_fs(ndc_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

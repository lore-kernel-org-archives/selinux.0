Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h37KlUI4018132
	for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2003 16:47:30 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h37KlTxH023241
	for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2003 20:47:29 GMT
Received: from mozart.fwsystems.com (mozart.fwsystems.com [63.101.67.2])
        by jazzband.ncsc.mil  with ESMTP id h37KlSDl023238 for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2003 20:47:28 GMT
Received: from athena (athena.fwsystems.com [63.101.67.13])
	(authenticated bits=0)
	by mozart.fwsystems.com (8.12.8p1/8.12.8) with ESMTP id h37KlRgd073734
	for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2003 16:47:27 -0400
Date: Mon, 7 Apr 2003 16:47:27 -0400
From: forrest whitcher <fw@fwsystems.com>
To: selinux@tycho.nsa.gov
Subject: Prism wlan-ng device operation on SEL
Message-Id: <20030407164727.0b7609d2.fw@fwsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm getting the likes of the following

avc:  denied  { tcp_recv } for  pid=189 exe=/usr/bin/galeon-bin saddr=x.x.x.x source=17664 daddr=y.y.y.y dest=52 netif=wlan0 scontext=system_u:object_r:netmsg_wlan0_t tcontext=system_u:object_r:netif_wlan0_t tclass=netif
avc:  denied  { tcp_recv } for  saddr=x.x.x.x source=17664 daddr=y.y.y.y dest=1428 netif=wlan0 scontext=system_u:object_r:netmsg_wlan0_t tcontext=system_u:object_r:netif_wlan0_t tclass=netif

avc:  denied  { tcp_send } for  saddr=x.x.x.x source=38149 daddr=64.236.41.7 dest=80 netif=wlan0 scontext=system_u:object_r:unlabeled_t tcontext=system_u:object_r:netif_wlan0_t tclass=netif
avc:  denied  { tcp_send } for  saddr=x.x.x.x source=38149 daddr=64.236.41.7 dest=80 netif=wlan0 scontext=system_u:object_r:unlabeled_t tcontext=system_u:object_r:node_t tclass=node

the wlan-ng prism drivers create wlan[N] devices, not eth[N]. I've added
the following changes to the policy to no apparent effect/change, however
make policy ; make reload   did not seem to acutally be reading the 
changed files? -- at least as reported by   ls -lut

Ideas?

thanks,          forrest


Updated policy files:


--- net_contexts        2003-01-18 08:12:45.000000000 -0500
+++ notebook/policy/net_contexts       2003-04-03 16:22:12.000000000 -0400
@@ -87,6 +87,10 @@
 netifcon ipsec1 system_u:object_r:netif_ipsec1_t system_u:object_r:netmsg_ipsec1_t
 netifcon ipsec2 system_u:object_r:netif_ipsec2_t system_u:object_r:netmsg_ipsec2_t
 
+netifcon wlan0 system_u:object_r:netif_wlan0_t system_u:object_r:netmsg_wlan0_t
+netifcon wlan1 system_u:object_r:netif_wlan1_t system_u:object_r:netmsg_wlan1_t
+netifcon wlan2 system_u:object_r:netif_wlan2_t system_u:object_r:netmsg_wlan2_t
+
 # Nodes (default = initial SID 'node')
 #
 # address mask context



--- types/network.te    2003-01-18 08:12:45.000000000 -0500
+++ notebook/policy/types/network.te 2003-04-03 16:23:58.000000000 -0400
@@ -135,3 +135,19 @@
 `allow ping_t netif_type:netif { rawip_send rawip_recv };
 allow ping_t node_type:node { rawip_send rawip_recv };
 allow ping_t netmsg_type:rawip_socket { recvfrom };')
+
+#
+# wlan-ng interface defnintions, permissions 
+#
+type netif_wlan0_t, netif_type;
+type netif_wlan1_t, netif_type;
+type netif_wlan2_t, netif_type;
+type netmsg_wlan0_t, netmsg_type;
+type netmsg_wlan1_t, netmsg_type;
+type netmsg_wlan2_t, netmsg_type;
+allow netmsg_wlan0_t node_t:node { tcp_recv udp_recv rawip_recv };
+allow netmsg_wlan0_t netif_eth0_t:netif { tcp_recv udp_recv rawip_recv };
+allow netmsg_wlan1_t node_t:node { tcp_recv udp_recv rawip_recv };
+allow netmsg_wlan1_t netif_eth1_t:netif { tcp_recv udp_recv rawip_recv };
+allow netmsg_wlan2_t node_t:node { tcp_recv udp_recv rawip_recv };
+allow netmsg_wlan2_t netif_eth2_t:netif { tcp_recv udp_recv rawip_recv };

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

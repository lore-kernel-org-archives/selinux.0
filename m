Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9AHLu4o022673
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 13:21:57 -0400
Received: from atlrel7.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9AHLHlj024667
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 17:21:17 GMT
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.15.136.127])
	by atlrel7.hp.com (Postfix) with ESMTP id 69691365AC
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 13:21:56 -0400 (EDT)
Message-Id: <20061010172155.078810000@hp.com>
References: <20061010171524.936739000@hp.com>
Date: Tue, 10 Oct 2006 13:15:27 -0400
From: paul.moore@hp.com
To: selinux@tycho.nsa.gov
Subject: [RFC 2/2] Reference policy: Restrict NetLabel to same MLS label connections by default
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adjusts the {tcp,udp}_socket recvfrom permissions to only allow
same MLS label connections.

---
 refpolicy/policy/mls |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)

Index: refpolicy.lblnet/refpolicy/policy/mls
===================================================================
--- refpolicy.lblnet.orig/refpolicy/policy/mls
+++ refpolicy.lblnet/refpolicy/policy/mls
@@ -165,7 +165,7 @@ mlsconstrain { socket tcp_socket udp_soc
 	( h1 dom h2 );
 
 # the socket "read" ops (note the check is dominance of the low level)
-mlsconstrain { socket tcp_socket udp_socket rawip_socket netlink_socket packet_socket key_socket unix_stream_socket unix_dgram_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } { read getattr listen accept getopt recvfrom recv_msg }
+mlsconstrain { socket tcp_socket udp_socket rawip_socket netlink_socket packet_socket key_socket unix_stream_socket unix_dgram_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } { read getattr listen accept getopt recv_msg }
 	(( l1 dom l2 ) or
 	 (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
 	 ( t1 == mlsnetread ));
@@ -181,6 +181,12 @@ mlsconstrain { socket tcp_socket udp_soc
 	 (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
 	 ( t1 == mlsnetwrite ));
 
+# used by netlabel to restrict normal domains to same level connections
+mlsconstrain { tcp_socket udp_socket } recvfrom
+	(( l1 eq l2 ) or
+	 (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
+	 ( t1 == mlsnetread ));
+
 # these access vectors have no MLS restrictions
 # { socket tcp_socket udp_socket rawip_socket netlink_socket packet_socket key_socket unix_stream_socket unix_dgram_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } { ioctl create lock append bind sendto send_msg name_bind }
 #

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

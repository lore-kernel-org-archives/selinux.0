Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0DIVeRb020918
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 13:31:40 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0DIVciV024029
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 18:31:38 GMT
Received: from thoron.boston.redhat.com (nat-pool-bos.redhat.com [66.187.230.200])
        by jazzband.ncsc.mil  with ESMTP id i0DIVS08024011 for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 18:31:37 GMT
Date: Tue, 13 Jan 2004 13:31:27 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, <selinux@tycho.nsa.gov>,
   Stephen Smalley <sds@epoch.ncsc.mil>
Subject: [PATCH][SELINUX] 2/2 Add SEND_MSG and RECV_MSG controls
In-Reply-To: <Xine.LNX.4.44.0401131318410.6829@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0401131326240.6829-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch implements two new access controls for SELinux: SEND_MSG and 
RECV_MSG, providing mediation of network packets based on destination 
port (IPv4 only at this stage).

Please apply.

 security/selinux/hooks.c |   47 +++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 43 insertions(+), 4 deletions(-)


diff -urN -X dontdiff linux-2.6.1-rc3.pending/security/selinux/hooks.c linux-2.6.1-rc3.w1/security/selinux/hooks.c
--- linux-2.6.1-rc3.pending/security/selinux/hooks.c	2004-01-08 13:56:32.000000000 -0500
+++ linux-2.6.1-rc3.w1/security/selinux/hooks.c	2004-01-08 14:37:03.251274816 -0500
@@ -2694,7 +2694,7 @@
 static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
 	int err = 0;
-	u32 netif_perm, node_perm, node_sid;
+	u32 netif_perm, node_perm, node_sid, recv_perm = 0;
 	struct socket *sock;
 	struct inode *inode;
 	struct net_device *dev;
@@ -2735,11 +2735,13 @@
 	case SECCLASS_UDP_SOCKET:
 		netif_perm = NETIF__UDP_RECV;
 		node_perm = NODE__UDP_RECV;
+		recv_perm = UDP_SOCKET__RECV_MSG;
 		break;
 	
 	case SECCLASS_TCP_SOCKET:
 		netif_perm = NETIF__TCP_RECV;
 		node_perm = NODE__TCP_RECV;
+		recv_perm = TCP_SOCKET__RECV_MSG;
 		break;
 	
 	default:
@@ -2766,6 +2768,20 @@
 	
 	err = avc_has_perm(isec->sid, node_sid, SECCLASS_NODE, node_perm, NULL, &ad);
 
+	if (recv_perm) {
+		u32 port_sid;
+
+		/* Fixme: make this more efficient */
+		err = security_port_sid(sk->sk_family, sk->sk_type,
+		                        sk->sk_protocol, ntohs(ad.u.net.dport),
+		                        &port_sid);
+		if (err)
+			goto out;
+
+		err = avc_has_perm(isec->sid, port_sid, isec->sclass,
+		                   recv_perm, NULL, &ad);
+	}
+
 out:	
 	return err;
 }
@@ -2826,7 +2842,8 @@
                                               int (*okfn)(struct sk_buff *))
 {
 	int err = NF_ACCEPT;
-	u32 netif_perm, node_perm, node_sid;
+	u32 netif_perm, node_perm, node_sid, send_perm = 0;
+	struct sock *sk;
 	struct socket *sock;
 	struct inode *inode;
 	struct iphdr *iph;
@@ -2837,10 +2854,11 @@
 	struct avc_audit_data ad;
 	struct net_device *dev = (struct net_device *)out;
 	
-	if (!skb->sk)
+	sk = skb->sk;
+	if (!sk)
 		goto out;
 		
-	sock = skb->sk->sk_socket;
+	sock = sk->sk_socket;
 	if (!sock)
 		goto out;
 		
@@ -2861,11 +2879,13 @@
 	case SECCLASS_UDP_SOCKET:
 		netif_perm = NETIF__UDP_SEND;
 		node_perm = NODE__UDP_SEND;
+		send_perm = UDP_SOCKET__SEND_MSG;
 		break;
 	
 	case SECCLASS_TCP_SOCKET:
 		netif_perm = NETIF__TCP_SEND;
 		node_perm = NODE__TCP_SEND;
+		send_perm = TCP_SOCKET__SEND_MSG;
 		break;
 	
 	default:
@@ -2892,6 +2912,25 @@
 	
 	err = avc_has_perm(isec->sid, node_sid, SECCLASS_NODE,
 	                   node_perm, NULL, &ad) ? NF_DROP : NF_ACCEPT;
+	if (err != NF_ACCEPT)
+		goto out;
+
+	if (send_perm) {
+		u32 port_sid;
+		
+		/* Fixme: make this more efficient */
+		err = security_port_sid(sk->sk_family,
+		                        sk->sk_type,
+		                        sk->sk_protocol,
+		                        ntohs(ad.u.net.dport),
+		                        &port_sid) ? NF_DROP : NF_ACCEPT;
+		if (err != NF_ACCEPT)
+			goto out;
+
+		err = avc_has_perm(isec->sid, port_sid, isec->sclass,
+		                   send_perm, NULL, &ad) ? NF_DROP : NF_ACCEPT;
+	}
+
 out:
 	return err;
 }



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

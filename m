Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0HKvIri018154
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2008 15:57:18 -0500
Received: from g5t0009.atlanta.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0HKvHug019656
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2008 20:57:17 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v12 17/18] SELinux: Add network ingress and egress control
	permission checks
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Date: Thu, 17 Jan 2008 15:57:12 -0500
Message-ID: <20080117205711.21013.57138.stgit@flek.americas.hpqcorp.net>
In-Reply-To: <20080117204653.21013.77930.stgit@flek.americas.hpqcorp.net>
References: <20080117204653.21013.77930.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch implements packet ingress/egress controls for SELinux which allow
SELinux security policy to control the flow of all IPv4 and IPv6 packets into
and out of the system.  Currently SELinux does not have proper control over
forwarded packets and this patch corrects this problem.

Special thanks to Venkat Yekkirala <vyekkirala@trustedcs.com> whose earlier
work on this topic eventually led to this patch.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---

 security/selinux/hooks.c |  402 ++++++++++++++++++++++++++++++++--------------
 1 files changed, 280 insertions(+), 122 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d16f586..b80e330 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -12,8 +12,8 @@
  *  Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
  *  Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
  *                          <dgoeddel@trustedcs.com>
- *  Copyright (C) 2006 Hewlett-Packard Development Company, L.P.
- *                     Paul Moore, <paul.moore@hp.com>
+ *  Copyright (C) 2006, 2007 Hewlett-Packard Development Company, L.P.
+ *                Paul Moore <paul.moore@hp.com>
  *  Copyright (C) 2007 Hitachi Software Engineering Co., Ltd.
  *                     Yuichi Nakamura <ynakam@hitachisoft.jp>
  *
@@ -3608,6 +3608,29 @@ static int selinux_socket_unix_may_send(struct socket *sock,
 	return 0;
 }
 
+static int selinux_inet_sys_rcv_skb(int ifindex, char *addrp, u16 family,
+				    u32 peer_sid,
+				    struct avc_audit_data *ad)
+{
+	int err;
+	u32 if_sid;
+	u32 node_sid;
+
+	err = sel_netif_sid(ifindex, &if_sid);
+	if (err)
+		return err;
+	err = avc_has_perm(peer_sid, if_sid,
+			   SECCLASS_NETIF, NETIF__INGRESS, ad);
+	if (err)
+		return err;
+
+	err = sel_netnode_sid(addrp, family, &node_sid);
+	if (err)
+		return err;
+	return avc_has_perm(peer_sid, node_sid,
+			    SECCLASS_NODE, NODE__RECVFROM, ad);
+}
+
 static int selinux_sock_rcv_skb_iptables_compat(struct sock *sk,
 						struct sk_buff *skb,
 						struct avc_audit_data *ad,
@@ -3735,23 +3758,27 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		return selinux_sock_rcv_skb_compat(sk, skb, &ad,
 						   family, addrp);
 
-	if (selinux_secmark_enabled()) {
-		err = avc_has_perm(sk_sid, skb->secmark, SECCLASS_PACKET,
-				   PACKET__RECV, &ad);
-		if (err)
-			return err;
-	}
-
 	if (netlbl_enabled() || selinux_xfrm_enabled()) {
 		u32 peer_sid;
 
 		err = selinux_skb_peerlbl_sid(skb, family, &peer_sid);
 		if (err)
 			return err;
+		err = selinux_inet_sys_rcv_skb(skb->iif, addrp, family,
+					       peer_sid, &ad);
+		if (err)
+			return err;
 		err = avc_has_perm(sk_sid, peer_sid, SECCLASS_PEER,
 				   PEER__RECV, &ad);
 	}
 
+	if (selinux_secmark_enabled()) {
+		err = avc_has_perm(sk_sid, skb->secmark, SECCLASS_PACKET,
+				   PACKET__RECV, &ad);
+		if (err)
+			return err;
+	}
+
 	return err;
 }
 
@@ -3964,151 +3991,255 @@ out:
 
 #ifdef CONFIG_NETFILTER
 
-static int selinux_ip_postroute_last_compat(struct sock *sk,
-					    struct net_device *dev,
-					    struct avc_audit_data *ad,
-					    u16 family,
-					    char *addrp)
+static unsigned int selinux_ip_forward(struct sk_buff *skb, int ifindex,
+				       u16 family)
 {
-	int err = 0;
-	u32 netif_perm, node_perm, node_sid, if_sid, send_perm = 0;
-	struct socket *sock;
-	struct inode *inode;
-	struct inode_security_struct *isec;
+	char *addrp;
+	u32 peer_sid;
+	struct avc_audit_data ad;
+	u8 secmark_active;
+	u8 peerlbl_active;
 
-	sock = sk->sk_socket;
-	if (!sock)
-		goto out;
+	if (!selinux_policycap_netpeer)
+		return NF_ACCEPT;
 
-	inode = SOCK_INODE(sock);
-	if (!inode)
-		goto out;
+	secmark_active = selinux_secmark_enabled();
+	peerlbl_active = netlbl_enabled() || selinux_xfrm_enabled();
+	if (!secmark_active && !peerlbl_active)
+		return NF_ACCEPT;
 
-	isec = inode->i_security;
-	
-	err = sel_netif_sid(dev->ifindex, &if_sid);
-	if (err)
-		goto out;
+	AVC_AUDIT_DATA_INIT(&ad, NET);
+	ad.u.net.netif = ifindex;
+	ad.u.net.family = family;
+	if (selinux_parse_skb(skb, &ad, &addrp, 1, NULL) != 0)
+		return NF_DROP;
+
+	if (selinux_skb_peerlbl_sid(skb, family, &peer_sid) != 0)
+		return NF_DROP;
+
+	if (peerlbl_active)
+		if (selinux_inet_sys_rcv_skb(ifindex, addrp, family,
+					     peer_sid, &ad) != 0)
+			return NF_DROP;
+
+	if (secmark_active)
+		if (avc_has_perm(peer_sid, skb->secmark,
+				 SECCLASS_PACKET, PACKET__FORWARD_IN, &ad))
+			return NF_DROP;
+
+	return NF_ACCEPT;
+}
+
+static unsigned int selinux_ipv4_forward(unsigned int hooknum,
+					 struct sk_buff *skb,
+					 const struct net_device *in,
+					 const struct net_device *out,
+					 int (*okfn)(struct sk_buff *))
+{
+	return selinux_ip_forward(skb, in->ifindex, PF_INET);
+}
+
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+static unsigned int selinux_ipv6_forward(unsigned int hooknum,
+					 struct sk_buff *skb,
+					 const struct net_device *in,
+					 const struct net_device *out,
+					 int (*okfn)(struct sk_buff *))
+{
+	return selinux_ip_forward(skb, in->ifindex, PF_INET6);
+}
+#endif	/* IPV6 */
+
+static int selinux_ip_postroute_iptables_compat(struct sock *sk,
+						int ifindex,
+						struct avc_audit_data *ad,
+						u16 family, char *addrp)
+{
+	int err;
+	struct sk_security_struct *sksec = sk->sk_security;
+	u16 sk_class;
+	u32 netif_perm, node_perm, send_perm;
+	u32 port_sid, node_sid, if_sid, sk_sid;
+
+	sk_sid = sksec->sid;
+	sk_class = sksec->sclass;
 
-	switch (isec->sclass) {
+	switch (sk_class) {
 	case SECCLASS_UDP_SOCKET:
 		netif_perm = NETIF__UDP_SEND;
 		node_perm = NODE__UDP_SEND;
 		send_perm = UDP_SOCKET__SEND_MSG;
 		break;
-	
 	case SECCLASS_TCP_SOCKET:
 		netif_perm = NETIF__TCP_SEND;
 		node_perm = NODE__TCP_SEND;
 		send_perm = TCP_SOCKET__SEND_MSG;
 		break;
-
 	case SECCLASS_DCCP_SOCKET:
 		netif_perm = NETIF__DCCP_SEND;
 		node_perm = NODE__DCCP_SEND;
 		send_perm = DCCP_SOCKET__SEND_MSG;
 		break;
-
 	default:
 		netif_perm = NETIF__RAWIP_SEND;
 		node_perm = NODE__RAWIP_SEND;
+		send_perm = 0;
 		break;
 	}
 
-	err = avc_has_perm(isec->sid, if_sid, SECCLASS_NETIF, netif_perm, ad);
+	err = sel_netif_sid(ifindex, &if_sid);
 	if (err)
-		goto out;
+		return err;
+	err = avc_has_perm(sk_sid, if_sid, SECCLASS_NETIF, netif_perm, ad);
+		return err;
 		
 	err = sel_netnode_sid(addrp, family, &node_sid);
 	if (err)
-		goto out;
-	
-	err = avc_has_perm(isec->sid, node_sid, SECCLASS_NODE, node_perm, ad);
+		return err;
+	err = avc_has_perm(sk_sid, node_sid, SECCLASS_NODE, node_perm, ad);
 	if (err)
-		goto out;
+		return err;
 
-	if (send_perm) {
-		u32 port_sid;
-		
-		err = security_port_sid(sk->sk_family,
-		                        sk->sk_type,
-		                        sk->sk_protocol,
-		                        ntohs(ad->u.net.dport),
-		                        &port_sid);
-		if (err)
-			goto out;
+	if (send_perm != 0)
+		return 0;
+
+	err = security_port_sid(sk->sk_family, sk->sk_type,
+				sk->sk_protocol, ntohs(ad->u.net.dport),
+				&port_sid);
+	if (err)
+		return err;
+	return avc_has_perm(sk_sid, port_sid, sk_class, send_perm, ad);
+}
+
+static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
+						int ifindex,
+						struct avc_audit_data *ad,
+						u16 family,
+						char *addrp,
+						u8 proto)
+{
+	struct sock *sk = skb->sk;
+	struct sk_security_struct *sksec;
 
-		err = avc_has_perm(isec->sid, port_sid, isec->sclass,
-				   send_perm, ad);
+	if (sk == NULL)
+		return NF_ACCEPT;
+	sksec = sk->sk_security;
+
+	if (selinux_compat_net) {
+		if (selinux_ip_postroute_iptables_compat(skb->sk, ifindex,
+							 ad, family, addrp))
+			return NF_DROP;
+	} else {
+		if (avc_has_perm(sksec->sid, skb->secmark,
+				 SECCLASS_PACKET, PACKET__SEND, ad))
+			return NF_DROP;
 	}
-out:
-	return err;
+
+	if (selinux_policycap_netpeer)
+		if (selinux_xfrm_postroute_last(sksec->sid, skb, ad, proto))
+			return NF_DROP;
+
+	return NF_ACCEPT;
 }
 
-static unsigned int selinux_ip_postroute_last(unsigned int hooknum,
-                                              struct sk_buff *skb,
-                                              const struct net_device *in,
-                                              const struct net_device *out,
-                                              int (*okfn)(struct sk_buff *),
-                                              u16 family)
+static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
+					 u16 family)
 {
-	char *addrp;
-	int err = 0;
+	u32 secmark_perm;
+	u32 peer_sid;
 	struct sock *sk;
 	struct avc_audit_data ad;
-	struct net_device *dev = (struct net_device *)out;
-	struct sk_security_struct *sksec;
+	char *addrp;
 	u8 proto;
-
-	sk = skb->sk;
-	if (!sk)
-		goto out;
-
-	sksec = sk->sk_security;
+	u8 secmark_active;
+	u8 peerlbl_active;
 
 	AVC_AUDIT_DATA_INIT(&ad, NET);
-	ad.u.net.netif = dev->ifindex;
+	ad.u.net.netif = ifindex;
 	ad.u.net.family = family;
+	if (selinux_parse_skb(skb, &ad, &addrp, 0, &proto))
+		return NF_DROP;
 
-	err = selinux_parse_skb(skb, &ad, &addrp, 0, &proto);
-	if (err)
-		goto out;
-
-	if (selinux_compat_net)
-		err = selinux_ip_postroute_last_compat(sk, dev, &ad,
-						       family, addrp);
-	else
-		err = avc_has_perm(sksec->sid, skb->secmark, SECCLASS_PACKET,
-				   PACKET__SEND, &ad);
+	/* If any sort of compatibility mode is enabled then handoff processing
+	 * to the selinux_ip_postroute_compat() function to deal with the
+	 * special handling.  We do this in an attempt to keep this function
+	 * as fast and as clean as possible. */
+	if (selinux_compat_net || !selinux_policycap_netpeer)
+		return selinux_ip_postroute_compat(skb, ifindex, &ad,
+						   family, addrp, proto);
+
+	/* If skb->dst->xfrm is non-NULL then the packet is undergoing an IPsec
+	 * packet transformation so allow the packet to pass without any checks
+	 * since we'll have another chance to perform access control checks
+	 * when the packet is on it's final way out.
+	 * NOTE: there appear to be some IPv6 multicast cases where skb->dst
+	 *       is NULL, in this case go ahead and apply access control. */
+	if (skb->dst != NULL && skb->dst->xfrm != NULL)
+		return NF_ACCEPT;
+
+	secmark_active = selinux_secmark_enabled();
+	peerlbl_active = netlbl_enabled() || selinux_xfrm_enabled();
+	if (!secmark_active && !peerlbl_active)
+		return NF_ACCEPT;
+
+	/* if the packet is locally generated (skb->sk != NULL) then use the
+	 * socket's label as the peer label, otherwise the packet is being
+	 * forwarded through this system and we need to fetch the peer label
+	 * directly from the packet */
+	sk = skb->sk;
+	if (sk) {
+		struct sk_security_struct *sksec = sk->sk_security;
+		peer_sid = sksec->sid;
+		secmark_perm = PACKET__SEND;
+	} else {
+		if (selinux_skb_peerlbl_sid(skb, family, &peer_sid))
+				return NF_DROP;
+		secmark_perm = PACKET__FORWARD_OUT;
+	}
 
-	if (err)
-		goto out;
+	if (secmark_active)
+		if (avc_has_perm(peer_sid, skb->secmark,
+				 SECCLASS_PACKET, secmark_perm, &ad))
+			return NF_DROP;
+
+	if (peerlbl_active) {
+		u32 if_sid;
+		u32 node_sid;
+
+		if (sel_netif_sid(ifindex, &if_sid))
+			return NF_DROP;
+		if (avc_has_perm(peer_sid, if_sid,
+				 SECCLASS_NETIF, NETIF__EGRESS, &ad))
+			return NF_DROP;
+
+		if (sel_netnode_sid(addrp, family, &node_sid))
+			return NF_DROP;
+		if (avc_has_perm(peer_sid, node_sid,
+				 SECCLASS_NODE, NODE__SENDTO, &ad))
+			return NF_DROP;
+	}
 
-	err = selinux_xfrm_postroute_last(sksec->sid, skb, &ad, proto);
-out:
-	return err ? NF_DROP : NF_ACCEPT;
+	return NF_ACCEPT;
 }
 
-static unsigned int selinux_ipv4_postroute_last(unsigned int hooknum,
-						struct sk_buff *skb,
-						const struct net_device *in,
-						const struct net_device *out,
-						int (*okfn)(struct sk_buff *))
+static unsigned int selinux_ipv4_postroute(unsigned int hooknum,
+					   struct sk_buff *skb,
+					   const struct net_device *in,
+					   const struct net_device *out,
+					   int (*okfn)(struct sk_buff *))
 {
-	return selinux_ip_postroute_last(hooknum, skb, in, out, okfn, PF_INET);
+	return selinux_ip_postroute(skb, out->ifindex, PF_INET);
 }
 
 #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
-
-static unsigned int selinux_ipv6_postroute_last(unsigned int hooknum,
-						struct sk_buff *skb,
-						const struct net_device *in,
-						const struct net_device *out,
-						int (*okfn)(struct sk_buff *))
+static unsigned int selinux_ipv6_postroute(unsigned int hooknum,
+					   struct sk_buff *skb,
+					   const struct net_device *in,
+					   const struct net_device *out,
+					   int (*okfn)(struct sk_buff *))
 {
-	return selinux_ip_postroute_last(hooknum, skb, in, out, okfn, PF_INET6);
+	return selinux_ip_postroute(skb, out->ifindex, PF_INET6);
 }
-
 #endif	/* IPV6 */
 
 #endif	/* CONFIG_NETFILTER */
@@ -5093,22 +5224,40 @@ security_initcall(selinux_init);
 
 #if defined(CONFIG_NETFILTER)
 
-static struct nf_hook_ops selinux_ipv4_op = {
-	.hook =		selinux_ipv4_postroute_last,
-	.owner =	THIS_MODULE,
-	.pf =		PF_INET,
-	.hooknum =	NF_IP_POST_ROUTING,
-	.priority =	NF_IP_PRI_SELINUX_LAST,
+static struct nf_hook_ops selinux_ipv4_ops[] = {
+	{
+		.hook =		selinux_ipv4_postroute,
+		.owner =	THIS_MODULE,
+		.pf =		PF_INET,
+		.hooknum =	NF_IP_POST_ROUTING,
+		.priority =	NF_IP_PRI_SELINUX_LAST,
+	},
+	{
+		.hook =		selinux_ipv4_forward,
+		.owner =	THIS_MODULE,
+		.pf =		PF_INET,
+		.hooknum =	NF_IP_FORWARD,
+		.priority =	NF_IP_PRI_SELINUX_FIRST,
+	}
 };
 
 #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
 
-static struct nf_hook_ops selinux_ipv6_op = {
-	.hook =		selinux_ipv6_postroute_last,
-	.owner =	THIS_MODULE,
-	.pf =		PF_INET6,
-	.hooknum =	NF_IP6_POST_ROUTING,
-	.priority =	NF_IP6_PRI_SELINUX_LAST,
+static struct nf_hook_ops selinux_ipv6_ops[] = {
+	{
+		.hook =		selinux_ipv6_postroute,
+		.owner =	THIS_MODULE,
+		.pf =		PF_INET6,
+		.hooknum =	NF_IP6_POST_ROUTING,
+		.priority =	NF_IP6_PRI_SELINUX_LAST,
+	},
+	{
+		.hook =		selinux_ipv6_forward,
+		.owner =	THIS_MODULE,
+		.pf =		PF_INET6,
+		.hooknum =	NF_IP6_FORWARD,
+		.priority =	NF_IP6_PRI_SELINUX_FIRST,
+	}
 };
 
 #endif	/* IPV6 */
@@ -5116,22 +5265,27 @@ static struct nf_hook_ops selinux_ipv6_op = {
 static int __init selinux_nf_ip_init(void)
 {
 	int err = 0;
+	u32 iter;
 
 	if (!selinux_enabled)
 		goto out;
 
 	printk(KERN_DEBUG "SELinux:  Registering netfilter hooks\n");
 
-	err = nf_register_hook(&selinux_ipv4_op);
-	if (err)
-		panic("SELinux: nf_register_hook for IPv4: error %d\n", err);
+	for (iter = 0; iter < ARRAY_SIZE(selinux_ipv4_ops); iter++) {
+		err = nf_register_hook(&selinux_ipv4_ops[iter]);
+		if (err)
+			panic("SELinux: nf_register_hook for IPv4: error %d\n",
+			      err);
+	}
 
 #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
-
-	err = nf_register_hook(&selinux_ipv6_op);
-	if (err)
-		panic("SELinux: nf_register_hook for IPv6: error %d\n", err);
-
+	for (iter = 0; iter < ARRAY_SIZE(selinux_ipv6_ops); iter++) {
+		err = nf_register_hook(&selinux_ipv6_ops[iter]);
+		if (err)
+			panic("SELinux: nf_register_hook for IPv6: error %d\n",
+			      err);
+	}
 #endif	/* IPV6 */
 
 out:
@@ -5143,11 +5297,15 @@ __initcall(selinux_nf_ip_init);
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 static void selinux_nf_ip_exit(void)
 {
+	u32 iter;
+
 	printk(KERN_DEBUG "SELinux:  Unregistering netfilter hooks\n");
 
-	nf_unregister_hook(&selinux_ipv4_op);
+	for (iter = 0; iter < ARRAY_SIZE(selinux_ipv4_ops); iter++)
+		nf_unregister_hook(&selinux_ipv4_ops[iter]);
 #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
-	nf_unregister_hook(&selinux_ipv6_op);
+	for (iter = 0; iter < ARRAY_SIZE(selinux_ipv6_ops); iter++)
+		nf_unregister_hook(&selinux_ipv6_ops[iter]);
 #endif	/* IPV6 */
 }
 #endif


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

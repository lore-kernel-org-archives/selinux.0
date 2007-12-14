Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBELvOIH028665
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2007 16:57:24 -0500
Received: from QMTA05.westchester.pa.mail.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBELvIIO020505
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2007 21:57:18 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v8 18/18] SELinux: Add network ingress and egress control
	permission checks
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Cc: vyekkirala@TrustedCS.com, chanson@TrustedCS.com
Date: Fri, 14 Dec 2007 16:51:29 -0500
Message-ID: <20071214215129.10069.75156.stgit@flek.lan>
In-Reply-To: <20071214213548.10069.59135.stgit@flek.lan>
References: <20071214213548.10069.59135.stgit@flek.lan>
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
---

 security/selinux/hooks.c |  335 +++++++++++++++++++++++++++++++---------------
 1 files changed, 228 insertions(+), 107 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2f221b2..2a6d50f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -12,8 +12,8 @@
  *  Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
  *  Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
  *                          <dgoeddel@trustedcs.com>
- *  Copyright (C) 2006 Hewlett-Packard Development Company, L.P.
- *                     Paul Moore, <paul.moore@hp.com>
+ *  Copyright (C) 2006, 2007 Hewlett-Packard Development Company, L.P.
+ *                     Paul Moore <paul.moore@hp.com>
  *  Copyright (C) 2007 Hitachi Software Engineering Co., Ltd.
  *                     Yuichi Nakamura <ynakam@hitachisoft.jp>
  *
@@ -3608,6 +3608,71 @@ static int selinux_socket_unix_may_send(struct socket *sock,
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
+	err = avc_has_perm(if_sid, peer_sid, SECCLASS_PEER, PEER__INGRESS, ad);
+	if (err)
+		return err;
+
+	err = sel_netnode_sid(addrp, family, &node_sid);
+	if (err)
+		return err;
+	return avc_has_perm(node_sid, peer_sid,
+			    SECCLASS_PEER, PEER__INGRESS, ad);
+}
+
+static int selinux_inet_sys_snd_skb(struct sk_buff *skb, int family)
+{
+	int err = 0;
+
+	if (!selinux_policycap_netpeer)
+		return 0;
+
+	if (netlbl_enabled() || selinux_xfrm_enabled()) {
+		u32 if_sid;
+		u32 node_sid;
+		u32 peer_sid;
+		char *addrp;
+		struct avc_audit_data ad;
+
+		AVC_AUDIT_DATA_INIT(&ad, NET);
+		ad.u.net.netif = skb->iif;
+		ad.u.net.family = family;
+		err = selinux_parse_skb(skb, &ad, &addrp, 0, NULL);
+		if (err)
+			return err;
+
+		err = selinux_skb_peerlbl_sid(skb, family, &peer_sid);
+		if (err)
+			return err;
+
+		err = sel_netif_sid(skb->iif, &if_sid);
+		if (err)
+			return err;
+		err = avc_has_perm(if_sid, peer_sid,
+				   SECCLASS_PEER, PEER__EGRESS, &ad);
+		if (err)
+			return err;
+
+		err = sel_netnode_sid(addrp, family, &node_sid);
+		if (err)
+			return err;
+		err = avc_has_perm(node_sid, peer_sid,
+				   SECCLASS_PEER, PEER__EGRESS, &ad);
+	}
+
+	return err;
+}
+
 static int selinux_sock_rcv_skb_iptables_compat(struct sock *sk,
 						struct sk_buff *skb,
 						struct avc_audit_data *ad,
@@ -3748,6 +3813,10 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
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
@@ -3965,151 +4034,175 @@ out:
 
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
+	if (!selinux_policycap_netpeer)
+		return NF_ACCEPT;
 
-	sock = sk->sk_socket;
-	if (!sock)
-		goto out;
+	if (netlbl_enabled() || selinux_xfrm_enabled()) {
+		char *addrp;
+		u32 peer_sid;
+		struct avc_audit_data ad;
 
-	inode = SOCK_INODE(sock);
-	if (!inode)
-		goto out;
+		AVC_AUDIT_DATA_INIT(&ad, NET);
+		ad.u.net.netif = ifindex;
+		ad.u.net.family = family;
+		if (selinux_parse_skb(skb, &ad, &addrp, 1, NULL) != 0)
+			return NF_DROP;
+
+		if (selinux_skb_peerlbl_sid(skb, family, &peer_sid) != 0)
+			return NF_DROP;
+		if (selinux_inet_sys_rcv_skb(ifindex, addrp, family,
+					     peer_sid, &ad) != 0)
+			return NF_DROP;
+	}
 
-	isec = inode->i_security;
-	
-	err = sel_netif_sid(dev->ifindex, &if_sid);
-	if (err)
-		goto out;
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
 
-	switch (isec->sclass) {
+static int selinux_ip_postroute_compat(struct sock *sk,
+				       int ifindex,
+				       struct avc_audit_data *ad,
+				       u16 family, char *addrp)
+{
+	int err;
+	struct sk_security_struct *sksec = sk->sk_security;
+	u16 sk_class;
+	u32 netif_perm, node_perm, send_perm;
+	u32 port_sid, node_sid, if_sid, sk_sid;
+
+	sk_sid = sksec->sid;
+	sk_class = sksec->sclass;
+
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
+	if (err)
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
-
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
+		return err;
 
-		err = avc_has_perm(isec->sid, port_sid, isec->sclass,
-				   send_perm, ad);
-	}
-out:
-	return err;
+	if (!send_perm)
+		return 0;
+	err = security_port_sid(sk->sk_family, sk->sk_type,
+				sk->sk_protocol, ntohs(ad->u.net.dport),
+				&port_sid);
+	if (err)
+		return err;
+	return avc_has_perm(sk_sid, port_sid, sk_class, send_perm, ad);
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
+	int err;
 	struct sock *sk;
-	struct avc_audit_data ad;
-	struct net_device *dev = (struct net_device *)out;
 	struct sk_security_struct *sksec;
+	struct avc_audit_data ad;
+	char *addrp;
 	u8 proto;
 
 	sk = skb->sk;
 	if (!sk)
-		goto out;
-
+		return NF_ACCEPT;
 	sksec = sk->sk_security;
 
 	AVC_AUDIT_DATA_INIT(&ad, NET);
-	ad.u.net.netif = dev->ifindex;
+	ad.u.net.netif = ifindex;
 	ad.u.net.family = family;
-
 	err = selinux_parse_skb(skb, &ad, &addrp, 0, &proto);
 	if (err)
-		goto out;
+		return NF_DROP;
 
 	if (selinux_compat_net)
-		err = selinux_ip_postroute_last_compat(sk, dev, &ad,
-						       family, addrp);
+		err = selinux_ip_postroute_compat(sk, ifindex, &ad,
+						  family, addrp);
 	else
 		err = avc_has_perm(sksec->sid, skb->secmark, SECCLASS_PACKET,
 				   PACKET__SEND, &ad);
-
 	if (err)
-		goto out;
+		return NF_DROP;
 
-	err = selinux_xfrm_postroute_last(sksec->sid, skb, &ad, proto);
-out:
-	return err ? NF_DROP : NF_ACCEPT;
+	if (!selinux_policycap_netpeer) {
+		/* If the network peer controls are enabled we handle all the
+		 * outbound peer label access checks in the
+		 * selinux_inet_sys_snd_skb() hook. */
+		err = selinux_xfrm_postroute_last(sksec->sid, skb, &ad, proto);
+		if (err)
+			return NF_DROP;
+	}
+
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
@@ -4991,6 +5084,7 @@ static struct security_operations selinux_ops = {
 	.inet_csk_clone =		selinux_inet_csk_clone,
 	.inet_conn_established =	selinux_inet_conn_established,
 	.req_classify_flow =		selinux_req_classify_flow,
+	.inet_sys_snd_skb =		selinux_inet_sys_snd_skb,
 
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
 	.xfrm_policy_alloc_security =	selinux_xfrm_policy_alloc,
@@ -5094,22 +5188,40 @@ security_initcall(selinux_init);
 
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
@@ -5117,22 +5229,27 @@ static struct nf_hook_ops selinux_ipv6_op = {
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
@@ -5144,11 +5261,15 @@ __initcall(selinux_nf_ip_init);
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

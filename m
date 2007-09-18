Message-ID: <46F00BAC.8040103@trustedcs.com>
Date: Tue, 18 Sep 2007 12:32:28 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, paul.moore@hp.com, sds@tycho.nsa.gov,
        jmorris@namei.org
Subject: [RFC] [PATCH 4/4] SELinux changes
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This implements the skb_flow_out LSM hook for SELinux. This
also defines a new forward_first netfilter hook to perform
flow-control of forwarded traffic on the way into the system.
Locally destined traffic is flow-controlled inside the existing
rcv_skb LSM hook.

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3694662..5434d7f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3519,6 +3519,124 @@ static int selinux_socket_unix_may_send(struct socket *sock,
 	return 0;
 }
 
+static int selinux_skb_flow_in(struct sk_buff *skb, struct net_device *in,
+			       unsigned short family)
+{
+	u32 node_sid, if_sid, secid = SECSID_NULL;
+	int err;
+	struct avc_audit_data ad;
+	char *addrp;
+	int len;
+
+	if (!in) {
+		if (skb->dev && skb->dev->ifindex == skb->iif)
+			in = skb->dev;
+		else
+			in = __dev_get_by_index(skb->iif);
+
+		if (!in) {
+			err = -EACCES;
+			goto out;
+		}
+	}
+
+	AVC_AUDIT_DATA_INIT(&ad, NET);
+	ad.u.net.netif = in->name;
+	ad.u.net.family = family;
+	err = selinux_parse_skb(skb, &ad, &addrp, &len, 1, NULL);
+	if (err)
+		goto out;
+
+	if (in != &loopback_dev) { /* Non-localhost packet */
+		err = selinux_xfrm_decode_session(skb, &secid, 0);
+		BUG_ON(err);
+		/* TODO: Retrieve and check any NetLabel for agreement with
+		   any Xfrm; also retrieve fallback if necessary */
+	}
+#ifdef TODO
+	else /* localhost packet */
+		/* TODO: Retrieve special IP Option set for localhost traffic */
+#endif
+
+	err = security_node_sid(family, addrp, len, &node_sid);
+	if (err)
+		goto out;
+
+	err = avc_has_perm(secid, node_sid,
+				  SECCLASS_NODE,
+				  NODE__FLOW_IN, &ad);
+	if (err)
+		goto out;
+
+	/* See if skb can flow in thru the interface */
+	err = sel_netif_sids(in, &if_sid, NULL);
+	if (err)
+		goto out;
+
+	err = avc_has_perm(secid, if_sid,
+				  SECCLASS_NETIF,
+				  NETIF__FLOW_IN, &ad);
+
+out:
+	return err;
+};
+
+static int selinux_skb_flow_out(struct sk_buff *skb, int family)
+{
+	u32 node_sid, if_sid, secid = SECSID_NULL;
+	int err;
+	struct avc_audit_data ad;
+	char *addrp;
+	int len;
+	struct sock *sk;
+	struct sk_security_struct *sksec;
+
+	if (!skb->dev) {
+		err = -EACCES;
+		goto out;
+	}
+
+	AVC_AUDIT_DATA_INIT(&ad, NET);
+	ad.u.net.netif = skb->dev->name;
+	ad.u.net.family = family;
+	err = selinux_parse_skb(skb, &ad, &addrp, &len, 1, NULL);
+	if (err)
+		goto out;
+
+	/* TODO: Glean the secid for forwarded packets
+	   from any incoming xfrms, NetLabel/Fallback, etc. */
+
+	if (!secid) {
+		sk = skb->sk;
+		if (sk) {
+			sksec = sk->sk_security;
+			secid = sksec->sid;
+		}
+	}
+
+	err = security_node_sid(family, addrp, len, &node_sid);
+	if (err)
+		goto out;
+
+	err = avc_has_perm(secid, node_sid,
+				  SECCLASS_NODE,
+				  NODE__FLOW_OUT, &ad);
+	if (err)
+		goto out;
+
+	/* See if skb can flow out thru the interface */
+	err = sel_netif_sids(skb->dev, &if_sid, NULL);
+	if (err)
+		goto out;
+
+	err = avc_has_perm(secid, if_sid,
+				  SECCLASS_NETIF,
+				  NETIF__FLOW_OUT, &ad);
+
+out:
+	return err;
+}
+
 static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 		struct avc_audit_data *ad, u16 family, char *addrp, int len)
 {
@@ -3629,10 +3747,14 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	if (err)
 		goto out;
 
-	if (selinux_compat_net)
+	if (selinux_compat_net) {
+		err = selinux_skb_flow_in(skb, NULL, family);
+		if (err)
+			goto out;
+
 		err = selinux_sock_rcv_skb_compat(sk, skb, &ad, family,
 						  addrp, len);
-	else
+	} else
 		err = avc_has_perm(sksec->sid, skb->secmark, SECCLASS_PACKET,
 				   PACKET__RECV, &ad);
 	if (err)
@@ -3924,6 +4046,20 @@ out:
 	return err;
 }
 
+static unsigned int selinux_ip_forward_first(unsigned int hooknum,
+                                              struct sk_buff **pskb,
+                                              const struct net_device *in,
+                                              const struct net_device *out,
+                                              int (*okfn)(struct sk_buff *),
+                                              u16 family)
+{
+	if (selinux_skb_flow_in(*pskb, (struct net_device *)in, family))
+		return NF_DROP;
+
+	return NF_ACCEPT;
+}
+
+
 static unsigned int selinux_ip_postroute_last(unsigned int hooknum,
                                               struct sk_buff **pskb,
                                               const struct net_device *in,
@@ -3969,6 +4105,15 @@ out:
 	return err ? NF_DROP : NF_ACCEPT;
 }
 
+static unsigned int selinux_ipv4_forward_first(unsigned int hooknum,
+                                              struct sk_buff **pskb,
+                                              const struct net_device *in,
+                                              const struct net_device *out,
+                                              int (*okfn)(struct sk_buff *))
+{
+	return selinux_ip_forward_first(hooknum, pskb, in, out, okfn, PF_INET);
+}
+
 static unsigned int selinux_ipv4_postroute_last(unsigned int hooknum,
 						struct sk_buff **pskb,
 						const struct net_device *in,
@@ -3980,6 +4125,15 @@ static unsigned int selinux_ipv4_postroute_last(unsigned int hooknum,
 
 #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
 
+static unsigned int selinux_ipv6_forward_first(unsigned int hooknum,
+                                              struct sk_buff **pskb,
+                                              const struct net_device *in,
+                                              const struct net_device *out,
+                                              int (*okfn)(struct sk_buff *))
+{
+	return selinux_ip_forward_first(hooknum, pskb, in, out, okfn, PF_INET6);
+}
+
 static unsigned int selinux_ipv6_postroute_last(unsigned int hooknum,
 						struct sk_buff **pskb,
 						const struct net_device *in,
@@ -4875,6 +5029,7 @@ static struct security_operations selinux_ops = {
 	.inet_csk_clone =		selinux_inet_csk_clone,
 	.inet_conn_established =	selinux_inet_conn_established,
 	.req_classify_flow =		selinux_req_classify_flow,
+	.skb_flow_out =			selinux_skb_flow_out,
 
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
 	.xfrm_policy_alloc_security =	selinux_xfrm_policy_alloc,
@@ -4978,22 +5133,40 @@ security_initcall(selinux_init);
 
 #if defined(CONFIG_NETFILTER)
 
-static struct nf_hook_ops selinux_ipv4_op = {
+static struct nf_hook_ops selinux_ipv4_ops[] = {
+	{
 	.hook =		selinux_ipv4_postroute_last,
 	.owner =	THIS_MODULE,
 	.pf =		PF_INET,
 	.hooknum =	NF_IP_POST_ROUTING,
 	.priority =	NF_IP_PRI_SELINUX_LAST,
+	},
+	{
+	.hook =		selinux_ipv4_forward_first,
+	.owner =	THIS_MODULE,
+	.pf =		PF_INET,
+	.hooknum =	NF_IP_FORWARD,
+	.priority =	NF_IP_PRI_SELINUX_FIRST,
+	}
 };
 
 #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
 
-static struct nf_hook_ops selinux_ipv6_op = {
+static struct nf_hook_ops selinux_ipv6_ops[] = {
+	{
 	.hook =		selinux_ipv6_postroute_last,
 	.owner =	THIS_MODULE,
 	.pf =		PF_INET6,
 	.hooknum =	NF_IP6_POST_ROUTING,
 	.priority =	NF_IP6_PRI_SELINUX_LAST,
+	},
+	{
+	.hook =		selinux_ipv6_forward_first,
+	.owner =	THIS_MODULE,
+	.pf =		PF_INET6,
+	.hooknum =	NF_IP6_FORWARD,
+	.priority =	NF_IP6_PRI_SELINUX_FIRST,
+	}
 };
 
 #endif	/* IPV6 */
@@ -5001,21 +5174,26 @@ static struct nf_hook_ops selinux_ipv6_op = {
 static int __init selinux_nf_ip_init(void)
 {
 	int err = 0;
+	int i;
 
 	if (!selinux_enabled)
 		goto out;
 
 	printk(KERN_DEBUG "SELinux:  Registering netfilter hooks\n");
 
-	err = nf_register_hook(&selinux_ipv4_op);
-	if (err)
-		panic("SELinux: nf_register_hook for IPv4: error %d\n", err);
+	for (i = 0; i < sizeof(selinux_ipv4_ops)/sizeof(struct nf_hook_ops); i++) {
+		err = nf_register_hook(&selinux_ipv4_ops[i]);
+		if (err)
+			panic("SELinux: nf_register_hook for IPv4: error %d\n", err);
+	}
 
 #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
 
-	err = nf_register_hook(&selinux_ipv6_op);
-	if (err)
-		panic("SELinux: nf_register_hook for IPv6: error %d\n", err);
+	for (i = 0; i < sizeof(selinux_ipv6_ops)/sizeof(struct nf_hook_ops); i++) {
+		err = nf_register_hook(&selinux_ipv6_ops[i]);
+		if (err)
+			panic("SELinux: nf_register_hook for IPv6: error %d\n", err);
+	}
 
 #endif	/* IPV6 */
 
@@ -5028,11 +5206,14 @@ __initcall(selinux_nf_ip_init);
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 static void selinux_nf_ip_exit(void)
 {
+	int i;
 	printk(KERN_DEBUG "SELinux:  Unregistering netfilter hooks\n");
 
-	nf_unregister_hook(&selinux_ipv4_op);
+	for (i = 0; i < sizeof(selinux_ipv4_ops)/sizeof(struct nf_hook_ops); i++)
+		nf_unregister_hook(&selinux_ipv4_ops[i]);
 #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
-	nf_unregister_hook(&selinux_ipv6_op);
+	for (i = 0; i < sizeof(selinux_ipv6_ops)/sizeof(struct nf_hook_ops); i++)
+		nf_unregister_hook(&selinux_ipv6_ops[i]);
 #endif	/* IPV6 */
 }
 #endif

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

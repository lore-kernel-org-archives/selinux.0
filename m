Message-ID: <46F00B88.1080801@trustedcs.com>
Date: Tue, 18 Sep 2007 12:31:52 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, paul.moore@hp.com, sds@tycho.nsa.gov,
        jmorris@namei.org
Subject: [RFC] [PATCH 3/4] Core networking changes
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This calls into the skb_flow_out LSM hook for flow-controlling
all traffic on their way out. The existing postroute_last LSM
netfilter hook couldn't be used since it would be invoked for
each xfrm as it is applied to a packet.

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 0f1d7be..37a05a2 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -204,6 +204,7 @@ static inline int ip_skb_dst_mtu(struct sk_buff *skb)
 
 static inline int ip_finish_output(struct sk_buff *skb)
 {
+	int err;
 #if defined(CONFIG_NETFILTER) && defined(CONFIG_XFRM)
 	/* Policy lookup after SNAT yielded a new policy */
 	if (skb->dst->xfrm != NULL) {
@@ -211,6 +212,10 @@ static inline int ip_finish_output(struct sk_buff *skb)
 		return dst_output(skb);
 	}
 #endif
+	err = security_skb_flow_out(skb, AF_INET);
+	if (err)
+		return err;
+
 	if (skb->len > ip_skb_dst_mtu(skb) && !skb_is_gso(skb))
 		return ip_fragment(skb, ip_finish_output2);
 	else
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 26de3c0..d682e8a 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -73,6 +73,11 @@ static __inline__ void ipv6_select_ident(struct sk_buff *skb, struct frag_hdr *f
 static inline int ip6_output_finish(struct sk_buff *skb)
 {
 	struct dst_entry *dst = skb->dst;
+	int err;
+
+	err = security_skb_flow_out(skb, AF_INET6);
+	if (err)
+		return err;
 
 	if (dst->hh)
 		return neigh_hh_output(dst->hh, skb);

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

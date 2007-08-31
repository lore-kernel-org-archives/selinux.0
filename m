Message-ID: <46D898D3.7020400@trustedcs.com>
Date: Fri, 31 Aug 2007 17:40:19 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, paul.moore@hp.com
CC: jmorris@namei.org, sds@tycho.nsa.gov
Subject: Networking Patch (outline)
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following is a slightly modified version of the patch
(backed here against 2.6.23-rc4) that we have been using here at
TCS. It is intended to help provide an idea as to the points in
code that need to be dealt with for the enhancements that have
been talked about.

Specifically, the following are the primary areas that
have not been addressed here:

1. Replace setting of secid with IP Option or Split secmark.

2. Integrate NetLabel fallbacks.

3. Replace igmp_classify_skb with a generic classification
   mechanism based on protocol and such.

4. Currently this patch modifies xfrm_policy_check()
   to also perform the flow_in checks. This is awkward and
   a separate call into LSM right after the xfrm_policy_check
   invocations would be cleaner.

5. Consolidate label-type-secific checks into a single
   peer.recv check.

6. Also, following in the tradition of MLS, icmp replies
   and such are returned with the same label as the incoming
   packet that resulted in the generation of the reply. This
   needs to be examined from the TE POV.

--- linux-2.6.orig/include/linux/security.h	2007-08-30 09:17:54.000000000 -0500
+++ linux-2.6/include/linux/security.h	2007-08-31 15:19:38.000000000 -0500
@@ -831,6 +831,13 @@ struct request_sock;
  *     Sets the connection's peersid to the secmark on skb.
  * @req_classify_flow:
  *	Sets the flow's sid to the openreq sid.
+ * @igmp_classify_skb:
+ *	Classifies an skb representing an igmp packet.
+ * @skb_flow_in:
+ *	Checks to see if security policy would allow skb into the system
+ *	while also reconciling the xfrm secid, cipso, etc, if any, and
+ *	relabeling the skb with the reconciled secid.
+ *	Returns 1 if skb allowed into system, 0 otherwise.
  *
  * Security hooks for XFRM operations.
  *
@@ -1370,6 +1377,8 @@ struct security_operations {
 	void (*inet_csk_clone)(struct sock *newsk, const struct request_sock *req);
 	void (*inet_conn_established)(struct sock *sk, struct sk_buff *skb);
 	void (*req_classify_flow)(const struct request_sock *req, struct flowi *fl);
+	void (*igmp_classify_skb)(struct sk_buff *skb);
+	int (*skb_flow_in)(struct sk_buff *skb, unsigned short family);
 #endif	/* CONFIG_SECURITY_NETWORK */
 
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
@@ -2958,6 +2967,17 @@ static inline void security_req_classify
 	security_ops->req_classify_flow(req, fl);
 }
 
+static inline void security_igmp_classify_skb(struct sk_buff *skb)
+{
+	security_ops->igmp_classify_skb(skb);
+}
+
+static inline int security_skb_flow_in(struct sk_buff *skb,
+					unsigned short family)
+{
+	return security_ops->skb_flow_in(skb, family);
+}
+
 static inline void security_sock_graft(struct sock* sk, struct socket *parent)
 {
 	security_ops->sock_graft(sk, parent);
@@ -3115,6 +3135,16 @@ static inline void security_req_classify
 {
 }
 
+static inline void security_igmp_classify_skb(struct sk_buff *skb)
+{
+}
+
+static inline int security_skb_flow_in(struct sk_buff *skb,
+					unsigned short family)
+{
+	return 1;
+}
+
 static inline void security_sock_graft(struct sock* sk, struct socket *parent)
 {
 }
@@ -3201,12 +3231,6 @@ static inline int security_xfrm_decode_s
 	return security_ops->xfrm_decode_session(skb, secid, 1);
 }
 
-static inline void security_skb_classify_flow(struct sk_buff *skb, struct flowi *fl)
-{
-	int rc = security_ops->xfrm_decode_session(skb, &fl->secid, 0);
-
-	BUG_ON(rc);
-}
 #else	/* CONFIG_SECURITY_NETWORK_XFRM */
 static inline int security_xfrm_policy_alloc(struct xfrm_policy *xp, struct xfrm_user_sec_ctx *sec_ctx)
 {
@@ -3264,10 +3288,6 @@ static inline int security_xfrm_decode_s
 	return 0;
 }
 
-static inline void security_skb_classify_flow(struct sk_buff *skb, struct flowi *fl)
-{
-}
-
 #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
 
 #ifdef CONFIG_KEYS
--- linux-2.6.orig/include/linux/skbuff.h	2007-08-30 09:17:54.000000000 -0500
+++ linux-2.6/include/linux/skbuff.h	2007-08-30 10:01:42.000000000 -0500
@@ -28,6 +28,8 @@
 #include <linux/rcupdate.h>
 #include <linux/dmaengine.h>
 #include <linux/hrtimer.h>
+#include <net/flow.h>
+#include <linux/security.h>
 
 #define HAVE_ALLOC_SKB		/* For the drivers to know */
 #define HAVE_ALIGNABLE_SKB	/* Ditto 8)		   */
@@ -246,6 +248,7 @@ typedef unsigned char *sk_buff_data_t;
  *	@dma_cookie: a cookie to one of several possible DMA operations
  *		done by skb DMA functions
  *	@secmark: security marking
+ *	@secid: security identifier
  */
 
 struct sk_buff {
@@ -317,6 +320,7 @@ struct sk_buff {
 #ifdef CONFIG_NETWORK_SECMARK
 	__u32			secmark;
 #endif
+	__u32			secid;
 
 	__u32			mark;
 
@@ -1766,5 +1770,52 @@ static inline void skb_forward_csum(stru
 		skb->ip_summed = CHECKSUM_NONE;
 }
 
+#ifdef CONFIG_SECURITY_NETWORK
+
+static inline void security_skb_classify_skb(struct sk_buff *from,
+					struct sk_buff *skb)
+{
+	skb->secid = from->secid;
+}
+
+static inline void security_flow_classify_skb(struct flowi *fl,
+					struct sk_buff *skb)
+{
+	skb->secid = fl->secid;
+}
+
+static inline void security_skb_classify_flow(struct sk_buff *skb,
+					struct flowi *fl)
+{
+	/*
+	 * We need to check for xfrm label here since secid reconciliation
+	 * may or may not have happened yet and we want the
+	 * flow to use the best available label.
+	 */
+	int rc = security_xfrm_decode_session(skb, &fl->secid);
+
+	if (rc || !fl->secid)
+		fl->secid = skb->secid;
+}
+
+#else
+
+static inline void security_skb_classify_skb(struct sk_buff *from,
+					struct sk_buff *skb)
+{
+}
+
+static inline void security_flow_classify_skb(struct flowi *fl,
+					struct sk_buff *skb)
+{
+}
+
+static inline void security_skb_classify_flow(struct sk_buff *skb,
+					struct flowi *fl)
+{
+}
+
+#endif /* CONFIG_SECURITY_NETWORK */
+
 #endif	/* __KERNEL__ */
 #endif	/* _LINUX_SKBUFF_H */
--- linux-2.6.orig/include/net/ip.h	2007-08-30 09:17:55.000000000 -0500
+++ linux-2.6/include/net/ip.h	2007-08-31 15:22:54.000000000 -0500
@@ -54,6 +54,9 @@ struct ipcm_cookie
 	__be32			addr;
 	int			oif;
 	struct ip_options	*opt;
+#ifdef CONFIG_SECURITY_NETWORK
+	u32			secid;
+#endif /* CONFIG_SECURITY_NETWORK */
 };
 
 #define IPCB(skb) ((struct inet_skb_parm*)((skb)->cb))
@@ -393,4 +396,34 @@ extern int ip_misc_proc_init(void);
 
 extern struct ctl_table ipv4_table[];
 
+#ifdef CONFIG_SECURITY_NETWORK
+
+extern struct security_operations *security_ops;
+
+static inline void security_skb_classify_ipcm(struct sk_buff *skb,
+					struct ipcm_cookie *ipc)
+{
+	ipc->secid = skb->secid;
+}
+
+static inline void security_ipcm_classify_skb(struct ipcm_cookie *ipc,
+					struct sk_buff *skb)
+{
+	skb->secid = ipc->secid;
+}
+
+#else
+
+static inline void security_skb_classify_ipcm(struct sk_buff *skb,
+					struct ipcm_cookie *ipc)
+{
+}
+
+static inline void security_ipcm_classify_skb(struct ipcm_cookie *ipc,
+					struct sk_buff *skb)
+{
+}
+
+#endif /* CONFIG_SECURITY_NETWORK */
+
 #endif	/* _IP_H */
--- linux-2.6.orig/include/net/request_sock.h	2007-08-30 09:17:55.000000000 -0500
+++ linux-2.6/include/net/request_sock.h	2007-08-30 09:58:16.000000000 -0500
@@ -261,4 +261,21 @@ static inline void reqsk_queue_hash_req(
 	write_unlock(&queue->syn_wait_lock);
 }
 
+#ifdef CONFIG_SECURITY_NETWORK
+
+static inline void security_req_classify_skb(struct request_sock *req,
+                                       struct sk_buff *skb)
+{
+	skb->secid = req->secid;
+}
+
+#else
+
+static inline void security_req_classify_skb(struct request_sock *req,
+                                       struct sk_buff *skb)
+{
+}
+
+#endif /* CONFIG_SECURITY_NETWORK */
+
 #endif /* _REQUEST_SOCK_H */
--- linux-2.6.orig/include/net/xfrm.h	2007-08-30 11:00:33.000000000 -0500
+++ linux-2.6/include/net/xfrm.h	2007-08-30 11:22:45.000000000 -0500
@@ -695,22 +695,17 @@ extern int __xfrm_policy_check(struct so
 
 static inline int xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb, unsigned short family)
 {
-	if (sk && sk->sk_policy[XFRM_POLICY_IN])
-		return __xfrm_policy_check(sk, dir, skb, family);
-
-	return	(!xfrm_policy_count[dir] && !skb->sp) ||
-		(skb->dst->flags & DST_NOPOLICY) ||
-		__xfrm_policy_check(sk, dir, skb, family);
-}
+	int ret;
 
-static inline int xfrm4_policy_check(struct sock *sk, int dir, struct sk_buff *skb)
-{
-	return xfrm_policy_check(sk, dir, skb, AF_INET);
-}
-
-static inline int xfrm6_policy_check(struct sock *sk, int dir, struct sk_buff *skb)
-{
-	return xfrm_policy_check(sk, dir, skb, AF_INET6);
+	if (sk && sk->sk_policy[XFRM_POLICY_IN])
+		ret = __xfrm_policy_check(sk, dir, skb, family);
+	else
+		ret = (!xfrm_policy_count[dir] && !skb->sp) ||
+		       (skb->dst->flags & DST_NOPOLICY) ||
+		       __xfrm_policy_check(sk, dir, skb, family);
+	if (ret)
+		ret = security_skb_flow_in(skb, family);
+	return ret;
 }
 
 extern int xfrm_decode_session(struct sk_buff *skb, struct flowi *fl, unsigned short family);
@@ -762,19 +757,22 @@ static inline void xfrm_sk_free_policy(s
 static inline int xfrm_sk_clone_policy(struct sock *sk) { return 0; }
 static inline int xfrm6_route_forward(struct sk_buff *skb) { return 1; }  
 static inline int xfrm4_route_forward(struct sk_buff *skb) { return 1; } 
-static inline int xfrm6_policy_check(struct sock *sk, int dir, struct sk_buff *skb)
-{ 
-	return 1; 
-} 
+static inline int xfrm_policy_check(struct sock *sk, int dir,
+		struct sk_buff *skb, unsigned short family)
+{
+	return security_skb_flow_in(skb, family);
+}
+#endif
+
 static inline int xfrm4_policy_check(struct sock *sk, int dir, struct sk_buff *skb)
 {
-	return 1;
+	return xfrm_policy_check(sk, dir, skb, AF_INET);
 }
-static inline int xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb, unsigned short family)
+
+static inline int xfrm6_policy_check(struct sock *sk, int dir, struct sk_buff *skb)
 {
-	return 1;
+	return xfrm_policy_check(sk, dir, skb, AF_INET6);
 }
-#endif
 
 static __inline__
 xfrm_address_t *xfrm_flowi_daddr(struct flowi *fl, unsigned short family)
--- linux-2.6.orig/net/dccp/ipv4.c	2007-08-30 09:17:55.000000000 -0500
+++ linux-2.6/net/dccp/ipv4.c	2007-08-30 10:34:45.000000000 -0500
@@ -495,6 +495,8 @@ static int dccp_v4_send_response(struct 
 		const struct inet_request_sock *ireq = inet_rsk(req);
 		struct dccp_hdr *dh = dccp_hdr(skb);
 
+		security_req_classify_skb(req, skb);
+
 		dh->dccph_checksum = dccp_v4_csum_finish(skb, ireq->loc_addr,
 							      ireq->rmt_addr);
 		memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
@@ -564,6 +566,8 @@ static void dccp_v4_ctl_send_reset(struc
 	dh->dccph_checksum = dccp_v4_csum_finish(skb, rxiph->saddr,
 						 rxiph->daddr);
 
+	security_skb_classify_skb(rxskb, skb);
+
 	bh_lock_sock(dccp_v4_ctl_socket->sk);
 	err = ip_build_and_send_pkt(skb, dccp_v4_ctl_socket->sk,
 				    rxiph->daddr, rxiph->saddr, NULL);
--- linux-2.6.orig/net/ipv4/icmp.c	2007-08-30 09:17:57.000000000 -0500
+++ linux-2.6/net/ipv4/icmp.c	2007-08-30 09:58:16.000000000 -0500
@@ -389,6 +389,8 @@ static void icmp_reply(struct icmp_bxm *
 	if (icmp_xmit_lock())
 		return;
 
+	security_skb_classify_ipcm(skb, &ipc);
+
 	icmp_param->data.icmph.checksum = 0;
 	icmp_out_count(icmp_param->data.icmph.type);
 
@@ -508,6 +510,8 @@ void icmp_send(struct sk_buff *skb_in, i
 	if (icmp_xmit_lock())
 		return;
 
+	security_skb_classify_ipcm(skb_in, &ipc);
+
 	/*
 	 *	Construct source address and options.
 	 */
--- linux-2.6.orig/net/ipv4/igmp.c	2007-08-30 09:17:58.000000000 -0500
+++ linux-2.6/net/ipv4/igmp.c	2007-08-30 09:58:16.000000000 -0500
@@ -295,6 +295,8 @@ static struct sk_buff *igmpv3_newpack(st
 	if (skb == NULL)
 		return NULL;
 
+	security_igmp_classify_skb(skb);
+
 	{
 		struct flowi fl = { .oif = dev->ifindex,
 				    .nl_u = { .ip4_u = {
@@ -663,6 +665,8 @@ static int igmp_send_report(struct in_de
 		return -1;
 	}
 
+	security_igmp_classify_skb(skb);
+
 	skb->dst = &rt->u.dst;
 
 	skb_reserve(skb, LL_RESERVED_SPACE(dev));
--- linux-2.6.orig/net/ipv4/ip_output.c	2007-08-30 09:17:58.000000000 -0500
+++ linux-2.6/net/ipv4/ip_output.c	2007-08-31 15:20:16.000000000 -0500
@@ -925,6 +925,8 @@ alloc_new_skb:
 			if (skb == NULL)
 				goto error;
 
+			security_ipcm_classify_skb(ipc, skb);
+
 			/*
 			 *	Fill in the control structures
 			 */
@@ -1120,6 +1122,8 @@ ssize_t	ip_append_page(struct sock *sk, 
 				goto error;
 			}
 
+			security_skb_classify_skb(skb_prev, skb);
+
 			/*
 			 *	Fill in the control structures
 			 */
@@ -1347,6 +1351,8 @@ void ip_send_reply(struct sock *sk, stru
 	daddr = ipc.addr = rt->rt_src;
 	ipc.opt = NULL;
 
+	security_skb_classify_ipcm(skb, &ipc);
+
 	if (replyopts.opt.optlen) {
 		ipc.opt = &replyopts.opt;
 
--- linux-2.6.orig/net/ipv4/tcp_ipv4.c	2007-08-30 09:17:59.000000000 -0500
+++ linux-2.6/net/ipv4/tcp_ipv4.c	2007-08-30 09:58:16.000000000 -0500
@@ -759,6 +759,7 @@ static int tcp_v4_send_synack(struct soc
 					 ireq->rmt_addr,
 					 csum_partial((char *)th, skb->len,
 						      skb->csum));
+		security_req_classify_skb(req, skb);
 
 		err = ip_build_and_send_pkt(skb, sk, ireq->loc_addr,
 					    ireq->rmt_addr,
--- linux-2.6.orig/net/ipv6/ip6_output.c	2007-08-30 09:18:00.000000000 -0500
+++ linux-2.6/net/ipv6/ip6_output.c	2007-08-30 09:58:16.000000000 -0500
@@ -170,6 +170,8 @@ int ip6_xmit(struct sock *sk, struct sk_
 	int hlimit, tclass;
 	u32 mtu;
 
+	security_flow_classify_skb(fl, skb);
+
 	if (opt) {
 		int head_room;
 
@@ -1218,6 +1220,9 @@ alloc_new_skb:
 			}
 			if (skb == NULL)
 				goto error;
+
+			security_flow_classify_skb(fl, skb);
+
 			/*
 			 *	Fill in the control structures
 			 */
--- linux-2.6.orig/net/ipv6/netfilter/ip6t_REJECT.c	2007-08-30 09:18:00.000000000 -0500
+++ linux-2.6/net/ipv6/netfilter/ip6t_REJECT.c	2007-08-30 09:58:16.000000000 -0500
@@ -125,6 +125,8 @@ static void send_reset(struct sk_buff *o
 	ipv6_addr_copy(&ip6h->saddr, &oip6h->daddr);
 	ipv6_addr_copy(&ip6h->daddr, &oip6h->saddr);
 
+	security_skb_classify_skb(oldskb, nskb);
+
 	tcph = (struct tcphdr *)skb_put(nskb, sizeof(struct tcphdr));
 	/* Truncate to length (no data) */
 	tcph->doff = sizeof(struct tcphdr)/4;
--- linux-2.6.orig/net/xfrm/xfrm_policy.c	2007-08-30 09:18:01.000000000 -0500
+++ linux-2.6/net/xfrm/xfrm_policy.c	2007-08-30 09:58:16.000000000 -0500
@@ -1912,6 +1912,9 @@ int __xfrm_route_forward(struct sk_buff 
 	if (xfrm_decode_session(skb, &fl, family) < 0)
 		return 0;
 
+	/* In case packet didn't use labeled-ipsec coming in */
+	fl.secid = skb->secid;
+
 	return xfrm_lookup(&skb->dst, &fl, NULL, 0) == 0;
 }
 EXPORT_SYMBOL(__xfrm_route_forward);
--- linux-2.6.orig/security/dummy.c	2007-08-30 09:18:01.000000000 -0500
+++ linux-2.6/security/dummy.c	2007-08-31 15:20:37.000000000 -0500
@@ -841,6 +841,17 @@ static inline void dummy_req_classify_fl
 			struct flowi *fl)
 {
 }
+
+static inline void dummy_igmp_classify_skb(struct sk_buff *skb)
+{
+}
+
+static inline int dummy_skb_flow_in(struct sk_buff *skb,
+			unsigned short family)
+{
+	return -ENOENT;
+}
+
 #endif	/* CONFIG_SECURITY_NETWORK */
 
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
@@ -1113,6 +1124,8 @@ void security_fixup_ops (struct security
 	set_to_dummy_if_null(ops, inet_csk_clone);
 	set_to_dummy_if_null(ops, inet_conn_established);
 	set_to_dummy_if_null(ops, req_classify_flow);
+	set_to_dummy_if_null(ops, igmp_classify_skb);
+	set_to_dummy_if_null(ops, skb_flow_in);
  #endif	/* CONFIG_SECURITY_NETWORK */
 #ifdef  CONFIG_SECURITY_NETWORK_XFRM
 	set_to_dummy_if_null(ops, xfrm_policy_alloc_security);
--- linux-2.6.orig/security/selinux/hooks.c	2007-08-30 09:18:01.000000000 -0500
+++ linux-2.6/security/selinux/hooks.c	2007-08-31 15:35:54.000000000 -0500
@@ -3146,6 +3146,11 @@ static void selinux_skb_extlbl_sid(struc
 	u32 xfrm_sid;
 	u32 nlbl_sid;
 
+	if (skb->secid) {
+		*sid = skb->secid;
+		return;
+	}
+
 	selinux_skb_xfrm_sid(skb, &xfrm_sid);
 	if (selinux_netlbl_skbuff_getsid(skb,
 					 (xfrm_sid == SECSID_NULL ?
@@ -3629,9 +3634,28 @@ static int selinux_socket_sock_rcv_skb(s
 	if (selinux_compat_net)
 		err = selinux_sock_rcv_skb_compat(sk, skb, &ad, family,
 						  addrp, len);
-	else
+	else {
+		u32 recv_perm;
+
 		err = avc_has_perm(sksec->sid, skb->secmark, SECCLASS_PACKET,
 				   PACKET__RECV, &ad);
+		if (err)
+			goto out;
+
+		switch (sksec->sclass) {
+		case SECCLASS_UDP_SOCKET:
+			recv_perm = UDP_SOCKET__RECVFROM;
+			break;
+		case SECCLASS_TCP_SOCKET:
+			recv_perm = TCP_SOCKET__RECVFROM;
+			break;
+		default:
+			recv_perm = RAWIP_SOCKET__RECVFROM;
+		}
+
+		err = avc_has_perm(sksec->sid, skb->secid, sksec->sclass,
+				   recv_perm, &ad);
+	}
 	if (err)
 		goto out;
 
@@ -3804,6 +3828,62 @@ static void selinux_req_classify_flow(co
 	fl->secid = req->secid;
 }
 
+void selinux_igmp_classify_skb(struct sk_buff *skb)
+{
+	skb->secid = SECINITSID_IGMP_PACKET;
+}
+
+static int selinux_skb_flow_in(struct sk_buff *skb, unsigned short family)
+{
+	u32 if_sid;
+	int err;
+	struct avc_audit_data ad;
+	char *addrp;
+	int len;
+
+	if (selinux_compat_net)
+		return 1;
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
+	if (skb->dev != &loopback_dev) { /* Non-localhost packet */
+		err = selinux_xfrm_decode_session(skb, &skb->secid, 0);
+		BUG_ON(err);
+		/* TODO: Retrieve and check any NetLabel for agreement with
+		   any Xfrm; also retrieve fallback if necessary */
+	}
+#ifdef TODO
+	else /* localhost packet */
+		/* TODO: Retrieve special IP Option set for localhost traffic */
+
+	err = avc_has_perm(skb->secid, NODE /* TODO */, SECCLASS_PACKET, PACKET__FLOW_IN, &ad);
+	if (err)
+		goto out;
+#endif
+
+	/* See if skb can flow in thru the interface */
+	err = sel_netif_sids(skb->dev, &if_sid, NULL);
+	if (err)
+		goto out;
+
+	err = avc_has_perm(skb->secid, if_sid,
+					SECCLASS_NETIF,
+					NETIF__FLOW_IN, &ad);
+
+out:
+	return err ? 0 : 1;
+};
+
 static int selinux_nlmsg_perm(struct sock *sk, struct sk_buff *skb)
 {
 	int err = 0;
@@ -3936,12 +4016,7 @@ static unsigned int selinux_ip_postroute
 	struct net_device *dev = (struct net_device *)out;
 	struct sk_security_struct *sksec;
 	u8 proto;
-
-	sk = skb->sk;
-	if (!sk)
-		goto out;
-
-	sksec = sk->sk_security;
+	u32 if_sid;
 
 	AVC_AUDIT_DATA_INIT(&ad, NET);
 	ad.u.net.netif = dev->name;
@@ -3951,17 +4026,48 @@ static unsigned int selinux_ip_postroute
 	if (err)
 		goto out;
 
+	sk = skb->sk;
+	if (!sk)
+		goto flow_check;
+
+	sksec = sk->sk_security;
+
 	if (selinux_compat_net)
 		err = selinux_ip_postroute_last_compat(sk, dev, &ad,
 						       family, addrp, len);
-	else
+	else {
+		if (!skb->secid)
+			skb->secid = sksec->sid;
+
 		err = avc_has_perm(sksec->sid, skb->secmark, SECCLASS_PACKET,
 				   PACKET__SEND, &ad);
+		if (err)
+			goto out;
+	}
 
+	err = selinux_xfrm_postroute_last(sksec->sid, skb, &ad, proto);
 	if (err)
 		goto out;
 
-	err = selinux_xfrm_postroute_last(sksec->sid, skb, &ad, proto);
+flow_check:
+	if (!selinux_compat_net) {
+#ifdef TODO
+		err = avc_has_perm(skb->secid, NODE /* TODO */, SECCLASS_PACKET,
+				   PACKET__FLOW_OUT, &ad);
+		if (err)
+			goto out;
+#endif /* TODO */
+
+		err = sel_netif_sids(dev, &if_sid, NULL);
+		if (err)
+			goto out;
+
+		err = avc_has_perm(skb->secid, if_sid, SECCLASS_NETIF,
+				   NETIF__FLOW_OUT, &ad);
+		if (err)
+			goto out;
+	}
+
 out:
 	return err ? NF_DROP : NF_ACCEPT;
 }
@@ -4872,6 +4978,8 @@ static struct security_operations selinu
 	.inet_csk_clone =		selinux_inet_csk_clone,
 	.inet_conn_established =	selinux_inet_conn_established,
 	.req_classify_flow =		selinux_req_classify_flow,
+	.igmp_classify_skb =		selinux_igmp_classify_skb,
+	.skb_flow_in =			selinux_skb_flow_in,
 
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
 	.xfrm_policy_alloc_security =	selinux_xfrm_policy_alloc,
--- linux-2.6.orig/security/selinux/include/av_permissions.h	2007-08-30 09:18:02.000000000 -0500
+++ linux-2.6/security/selinux/include/av_permissions.h	2007-08-30 10:54:30.000000000 -0500
@@ -300,6 +300,8 @@
 #define NETIF__RAWIP_SEND                         0x00000020UL
 #define NETIF__DCCP_RECV                          0x00000040UL
 #define NETIF__DCCP_SEND                          0x00000080UL
+#define NETIF__FLOW_IN                            0x00000100UL
+#define NETIF__FLOW_OUT                           0x00000200UL
 #define NETLINK_SOCKET__IOCTL                     0x00000001UL
 #define NETLINK_SOCKET__READ                      0x00000002UL
 #define NETLINK_SOCKET__WRITE                     0x00000004UL
@@ -792,6 +794,8 @@
 #define PACKET__SEND                              0x00000001UL
 #define PACKET__RECV                              0x00000002UL
 #define PACKET__RELABELTO                         0x00000004UL
+#define PACKET__FLOW_IN                           0x00000008UL
+#define PACKET__FLOW_OUT                          0x00000010UL
 #define KEY__VIEW                                 0x00000001UL
 #define KEY__READ                                 0x00000002UL
 #define KEY__WRITE                                0x00000004UL
--- linux-2.6.orig/security/selinux/include/av_perm_to_string.h	2007-08-30 09:18:03.000000000 -0500
+++ linux-2.6/security/selinux/include/av_perm_to_string.h	2007-08-30 10:55:42.000000000 -0500
@@ -45,6 +45,8 @@
    S_(SECCLASS_NETIF, NETIF__RAWIP_SEND, "rawip_send")
    S_(SECCLASS_NETIF, NETIF__DCCP_RECV, "dccp_recv")
    S_(SECCLASS_NETIF, NETIF__DCCP_SEND, "dccp_send")
+   S_(SECCLASS_NETIF, NETIF__FLOW_IN, "flow_in")
+   S_(SECCLASS_NETIF, NETIF__FLOW_OUT, "flow_out")
    S_(SECCLASS_UNIX_STREAM_SOCKET, UNIX_STREAM_SOCKET__CONNECTTO, "connectto")
    S_(SECCLASS_UNIX_STREAM_SOCKET, UNIX_STREAM_SOCKET__NEWCONN, "newconn")
    S_(SECCLASS_UNIX_STREAM_SOCKET, UNIX_STREAM_SOCKET__ACCEPTFROM, "acceptfrom")
@@ -149,6 +151,8 @@
    S_(SECCLASS_PACKET, PACKET__SEND, "send")
    S_(SECCLASS_PACKET, PACKET__RECV, "recv")
    S_(SECCLASS_PACKET, PACKET__RELABELTO, "relabelto")
+   S_(SECCLASS_PACKET, PACKET__FLOW_IN, "flow_in")
+   S_(SECCLASS_PACKET, PACKET__FLOW_OUT, "flow_out")
    S_(SECCLASS_KEY, KEY__VIEW, "view")
    S_(SECCLASS_KEY, KEY__READ, "read")
    S_(SECCLASS_KEY, KEY__WRITE, "write")

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

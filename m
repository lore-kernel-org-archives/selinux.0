Message-ID: <1512039044.19682.12.camel@gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>, James Morris
 <james.l.morris@oracle.com>
Cc: Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org, Stephen
 Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov, LSM
 <linux-security-module@vger.kernel.org>
Date: Thu, 30 Nov 2017 02:50:44 -0800
In-Reply-To: <ae2e71e4-c366-5a1e-9fd6-4de944f4a158@schaufler-ca.com>
References: <alpine.LFD.2.20.1711292113350.7808@localhost>
 <4d73f839-7a86-6edc-b44b-e296bd5947c2@schaufler-ca.com>
 <alpine.LFD.2.20.1711301130330.17322@localhost>
 <ae2e71e4-c366-5a1e-9fd6-4de944f4a158@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [BUG] kernel stack corruption during/after Netlabel
 error
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-11-29 at 19:16 -0800, Casey Schaufler wrote:
> On 11/29/2017 4:31 PM, James Morris wrote:
> > On Wed, 29 Nov 2017, Casey Schaufler wrote:
> > 
> > > I see that there is a proposed fix later in the thread, but I
> > > don't see
> > > the patch. Could you send it to me, so I can try it on my
> > > problem?
> > 
> > Forwarded off-list.
> 
> The patch does fix the problem I was seeing in Smack.

Can you guys test the following more complete patch ?

It should cover IPv4 and IPv6, and also the corner cases.

( Note that I squashed ipv6 fix in https://patchwork.ozlabs.org/patch/8
42844/ that I spotted while cooking this patch )

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c6bc0c4d19c624888b0d0b5a4246c7183edf63f5..77ea45da0fe9c746907a312989658af3ad3b198d 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1591,6 +1591,34 @@ int tcp_filter(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(tcp_filter);
 
+static void tcp_v4_restore_cb(struct sk_buff *skb)
+{
+	memmove(IPCB(skb), &TCP_SKB_CB(skb)->header.h4,
+		sizeof(struct inet_skb_parm));
+}
+
+static void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
+			   const struct tcphdr *th)
+{
+	/* This is tricky : We move IPCB at its correct location into TCP_SKB_CB()
+	 * barrier() makes sure compiler wont play fool^Waliasing games.
+	 */
+	memmove(&TCP_SKB_CB(skb)->header.h4, IPCB(skb),
+		sizeof(struct inet_skb_parm));
+	barrier();
+
+	TCP_SKB_CB(skb)->seq = ntohl(th->seq);
+	TCP_SKB_CB(skb)->end_seq = (TCP_SKB_CB(skb)->seq + th->syn + th->fin +
+				    skb->len - th->doff * 4);
+	TCP_SKB_CB(skb)->ack_seq = ntohl(th->ack_seq);
+	TCP_SKB_CB(skb)->tcp_flags = tcp_flag_byte(th);
+	TCP_SKB_CB(skb)->tcp_tw_isn = 0;
+	TCP_SKB_CB(skb)->ip_dsfield = ipv4_get_dsfield(iph);
+	TCP_SKB_CB(skb)->sacked	 = 0;
+	TCP_SKB_CB(skb)->has_rxtstamp =
+			skb->tstamp || skb_hwtstamps(skb)->hwtstamp;
+}
+
 /*
  *	From tcp_input.c
  */
@@ -1631,24 +1659,6 @@ int tcp_v4_rcv(struct sk_buff *skb)
 
 	th = (const struct tcphdr *)skb->data;
 	iph = ip_hdr(skb);
-	/* This is tricky : We move IPCB at its correct location into TCP_SKB_CB()
-	 * barrier() makes sure compiler wont play fool^Waliasing games.
-	 */
-	memmove(&TCP_SKB_CB(skb)->header.h4, IPCB(skb),
-		sizeof(struct inet_skb_parm));
-	barrier();
-
-	TCP_SKB_CB(skb)->seq = ntohl(th->seq);
-	TCP_SKB_CB(skb)->end_seq = (TCP_SKB_CB(skb)->seq + th->syn + th->fin +
-				    skb->len - th->doff * 4);
-	TCP_SKB_CB(skb)->ack_seq = ntohl(th->ack_seq);
-	TCP_SKB_CB(skb)->tcp_flags = tcp_flag_byte(th);
-	TCP_SKB_CB(skb)->tcp_tw_isn = 0;
-	TCP_SKB_CB(skb)->ip_dsfield = ipv4_get_dsfield(iph);
-	TCP_SKB_CB(skb)->sacked	 = 0;
-	TCP_SKB_CB(skb)->has_rxtstamp =
-			skb->tstamp || skb_hwtstamps(skb)->hwtstamp;
-
 lookup:
 	sk = __inet_lookup_skb(&tcp_hashinfo, skb, __tcp_hdrlen(th), th->source,
 			       th->dest, sdif, &refcounted);
@@ -1679,14 +1689,19 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		sock_hold(sk);
 		refcounted = true;
 		nsk = NULL;
-		if (!tcp_filter(sk, skb))
+		if (!tcp_filter(sk, skb)) {
+			th = (const struct tcphdr *)skb->data;
+			iph = ip_hdr(skb);
+			tcp_v4_fill_cb(skb, iph, th);
 			nsk = tcp_check_req(sk, skb, req, false);
+		}
 		if (!nsk) {
 			reqsk_put(req);
 			goto discard_and_relse;
 		}
 		if (nsk == sk) {
 			reqsk_put(req);
+			tcp_v4_restore_cb(skb);
 		} else if (tcp_child_process(sk, nsk, skb)) {
 			tcp_v4_send_reset(nsk, skb);
 			goto discard_and_relse;
@@ -1712,6 +1727,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		goto discard_and_relse;
 	th = (const struct tcphdr *)skb->data;
 	iph = ip_hdr(skb);
+	tcp_v4_fill_cb(skb, iph, th);
 
 	skb->dev = NULL;
 
@@ -1742,6 +1758,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
 		goto discard_it;
 
+	tcp_v4_fill_cb(skb, iph, th);
+
 	if (tcp_checksum_complete(skb)) {
 csum_error:
 		__TCP_INC_STATS(net, TCP_MIB_CSUMERRORS);
@@ -1768,6 +1786,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		goto discard_it;
 	}
 
+	tcp_v4_fill_cb(skb, iph, th);
+
 	if (tcp_checksum_complete(skb)) {
 		inet_twsk_put(inet_twsk(sk));
 		goto csum_error;
@@ -1784,6 +1804,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		if (sk2) {
 			inet_twsk_deschedule_put(inet_twsk(sk));
 			sk = sk2;
+			tcp_v4_restore_cb(skb);
 			refcounted = false;
 			goto process;
 		}
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 6bb98c93edfe2ed2f16fe5229605f8108cfc7f9a..1f04ec0e4a7aa2c11b8ee27cbdd4067b5bcf32e5 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1454,7 +1454,6 @@ static int tcp_v6_rcv(struct sk_buff *skb)
 		struct sock *nsk;
 
 		sk = req->rsk_listener;
-		tcp_v6_fill_cb(skb, hdr, th);
 		if (tcp_v6_inbound_md5_hash(sk, skb)) {
 			sk_drops_add(sk, skb);
 			reqsk_put(req);
@@ -1467,8 +1466,12 @@ static int tcp_v6_rcv(struct sk_buff *skb)
 		sock_hold(sk);
 		refcounted = true;
 		nsk = NULL;
-		if (!tcp_filter(sk, skb))
+		if (!tcp_filter(sk, skb)) {
+			th = (const struct tcphdr *)skb->data;
+			hdr = ipv6_hdr(skb);
+			tcp_v6_fill_cb(skb, hdr, th);
 			nsk = tcp_check_req(sk, skb, req, false);
+		}
 		if (!nsk) {
 			reqsk_put(req);
 			goto discard_and_relse;
@@ -1492,8 +1495,6 @@ static int tcp_v6_rcv(struct sk_buff *skb)
 	if (!xfrm6_policy_check(sk, XFRM_POLICY_IN, skb))
 		goto discard_and_relse;
 
-	tcp_v6_fill_cb(skb, hdr, th);
-
 	if (tcp_v6_inbound_md5_hash(sk, skb))
 		goto discard_and_relse;
 
@@ -1501,6 +1502,7 @@ static int tcp_v6_rcv(struct sk_buff *skb)
 		goto discard_and_relse;
 	th = (const struct tcphdr *)skb->data;
 	hdr = ipv6_hdr(skb);
+	tcp_v6_fill_cb(skb, hdr, th);
 
 	skb->dev = NULL;
 
@@ -1590,7 +1592,6 @@ static int tcp_v6_rcv(struct sk_buff *skb)
 		tcp_v6_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v6_restore_cb(skb);
 		tcp_v6_send_reset(sk, skb);
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;

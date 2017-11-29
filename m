Message-ID: <1511995754.16595.27.camel@gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Eric Dumazet <edumazet@google.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <james.l.morris@oracle.com>, Paul Moore
 <paul@paul-moore.com>, netdev <netdev@vger.kernel.org>,
 selinux@tycho.nsa.gov
Date: Wed, 29 Nov 2017 14:49:14 -0800
In-Reply-To: <CANn89iK23gDN_ma3MyybzgDkBr_A7R-MPfAG3dS_f7ehpiJtJQ@mail.gmail.com>
References: <alpine.LFD.2.20.1711292113350.7808@localhost>
 <1511976706.10464.19.camel@tycho.nsa.gov>
 <CANn89iJc=tZkN41WoCm5Zy9nPfs1tfZf9nuSXYS9EB_aem+y4g@mail.gmail.com>
 <1511985547.10464.22.camel@tycho.nsa.gov>
 <CANn89iK23gDN_ma3MyybzgDkBr_A7R-MPfAG3dS_f7ehpiJtJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [BUG] kernel stack corruption during/after Netlabel
 error
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-11-29 at 12:23 -0800, Eric Dumazet wrote:
> 
> I suspect this exposes an ancient bug, caused by fact that TCP moves
> IP[6]CB in skb->cb[]
> 
> Basically the 2nd tcp_filter() added in commit
> 8fac365f63c866a00015fa13932d8ffc584518b8
> ("tcp: Add a tcp_filter hook before handle ack packet") was not
> expecting selinux code being called a 2nd time,
> while skb->cb[] has been mangled [1]
> 
> [1]
> memmove(&TCP_SKB_CB(skb)->header.h4, IPCB(skb),
>     sizeof(struct inet_skb_parm));

Please try this fix for IPv4 (a similar patch will be needed for IPv6)

 net/ipv4/tcp_ipv4.c |   51 ++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c6bc0c4d19c624888b0d0b5a4246c7183edf63f5..912928105942b9714dda9132e45961ab1baf0852 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1591,6 +1591,28 @@ int tcp_filter(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(tcp_filter);
 
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
@@ -1631,24 +1653,6 @@ int tcp_v4_rcv(struct sk_buff *skb)
 
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
@@ -1679,8 +1683,12 @@ int tcp_v4_rcv(struct sk_buff *skb)
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
@@ -1712,6 +1720,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		goto discard_and_relse;
 	th = (const struct tcphdr *)skb->data;
 	iph = ip_hdr(skb);
+	tcp_v4_fill_cb(skb, iph, th);
 
 	skb->dev = NULL;
 
@@ -1742,6 +1751,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
 		goto discard_it;
 
+	tcp_v4_fill_cb(skb, iph, th);
+
 	if (tcp_checksum_complete(skb)) {
 csum_error:
 		__TCP_INC_STATS(net, TCP_MIB_CSUMERRORS);
@@ -1768,6 +1779,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		goto discard_it;
 	}
 
+	tcp_v4_fill_cb(skb, iph, th);
+
 	if (tcp_checksum_complete(skb)) {
 		inet_twsk_put(inet_twsk(sk));
 		goto csum_error;

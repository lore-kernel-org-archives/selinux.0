Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rBAJrbGw025342
	for <selinux@tycho.nsa.gov>; Tue, 10 Dec 2013 14:53:38 -0500
Subject: [PATCH 2/2] selinux: process labeled IPsec TCP SYN-ACK packets
 properly in selinux_ip_postroute()
To: selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Cc: janak.desai@gtri.gatech.edu
Date: Tue, 10 Dec 2013 14:53:24 -0500
Message-ID: <20131210195324.3404.20257.stgit@localhost>
In-Reply-To: <20131210195150.3404.61178.stgit@localhost>
References: <20131210195150.3404.61178.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Due to difficulty in arriving at the proper security label for
TCP SYN-ACK packets in selinux_ip_postroute(), we need to check packets
while/before they are undergoing XFRM transforms instead of waiting
until afterwards so that we can determine the correct security label.

Reported-by: Janak Desai <Janak.Desai@gtri.gatech.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 security/selinux/hooks.c |   42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 95cb134..a98228e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4846,22 +4846,31 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
 	 * as fast and as clean as possible. */
 	if (!selinux_policycap_netpeer)
 		return selinux_ip_postroute_compat(skb, ifindex, family);
+
+	secmark_active = selinux_secmark_enabled();
+	peerlbl_active = selinux_peerlbl_enabled();
+	if (!secmark_active && !peerlbl_active)
+		return NF_ACCEPT;
+
+	sk = skb->sk;
+
 #ifdef CONFIG_XFRM
 	/* If skb->dst->xfrm is non-NULL then the packet is undergoing an IPsec
 	 * packet transformation so allow the packet to pass without any checks
 	 * since we'll have another chance to perform access control checks
 	 * when the packet is on it's final way out.
 	 * NOTE: there appear to be some IPv6 multicast cases where skb->dst
-	 *       is NULL, in this case go ahead and apply access control. */
-	if (skb_dst(skb) != NULL && skb_dst(skb)->xfrm != NULL)
+	 *       is NULL, in this case go ahead and apply access control.
+	 * NOTE: if this is a local socket (skb->sk != NULL) that is in the
+	 *       TCP listening state we cannot wait until the XFRM processing
+	 *       is done as we will miss out on the SA label if we do;
+	 *       unfortunately, this means more work, but it is only once per
+	 *       connection. */
+	if (skb_dst(skb) != NULL && skb_dst(skb)->xfrm != NULL &&
+	    !(sk != NULL && sk->sk_state == TCP_LISTEN))
 		return NF_ACCEPT;
 #endif
-	secmark_active = selinux_secmark_enabled();
-	peerlbl_active = selinux_peerlbl_enabled();
-	if (!secmark_active && !peerlbl_active)
-		return NF_ACCEPT;
 
-	sk = skb->sk;
 	if (sk == NULL) {
 		/* Without an associated socket the packet is either coming
 		 * from the kernel or it is being forwarded; check the packet
@@ -4889,6 +4898,25 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
 		struct sk_security_struct *sksec = sk->sk_security;
 		if (selinux_skb_peerlbl_sid(skb, family, &skb_sid))
 			return NF_DROP;
+		/* At this point, if the returned skb peerlbl is SECSID_NULL
+		 * and the packet has been through at least one XFRM
+		 * transformation then we must be dealing with the "final"
+		 * form of labeled IPsec packet; since we've already applied
+		 * all of our access controls on this packet we can safely
+		 * pass the packet. */
+		if (skb_sid == SECSID_NULL) {
+			switch (family) {
+			case PF_INET:
+				if (IPCB(skb)->flags & IPSKB_XFRM_TRANSFORMED)
+					return NF_ACCEPT;
+				break;
+			case PF_INET6:
+				if (IP6CB(skb)->flags & IP6SKB_XFRM_TRANSFORMED)
+					return NF_ACCEPT;
+			default:
+				return NF_DROP_ERR(-ECONNREFUSED);
+			}
+		}
 		if (selinux_conn_sid(sksec->sid, skb_sid, &peer_sid))
 			return NF_DROP;
 		secmark_perm = PACKET__SEND;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

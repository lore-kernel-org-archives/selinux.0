Message-Id: <20061009195847.992616000@hp.com>
References: <20061009194223.402695000@hp.com>
Date: Mon, 09 Oct 2006 15:42:26 -0400
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: vyekkirala@TrustedCS.com, jmorris@namei.org, sds@tycho.nsa.gov
Subject: [PATCH 03/11] secid reconciliation: Invoke LSM hook for inbound traffic
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Venkat Yekkirala <vyekkirala@TrustedCS.com>

Invoke the skb_flow_in LSM hook for inbound
traffic for secid reconciliation and flow control.

Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>
---
 include/net/xfrm.h |   45 +++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 11e0b1d..8f9c184 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -675,22 +675,18 @@ extern int __xfrm_policy_check(struct so
 
 static inline int xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb, unsigned short family)
 {
-	if (sk && sk->sk_policy[XFRM_POLICY_IN])
-		return __xfrm_policy_check(sk, dir, skb, family);
-
-	return	(!xfrm_policy_count[dir] && !skb->sp) ||
-		(skb->dst->flags & DST_NOPOLICY) ||
-		__xfrm_policy_check(sk, dir, skb, family);
-}
-
-static inline int xfrm4_policy_check(struct sock *sk, int dir, struct sk_buff *skb)
-{
-	return xfrm_policy_check(sk, dir, skb, AF_INET);
-}
+	int ret;
 
-static inline int xfrm6_policy_check(struct sock *sk, int dir, struct sk_buff *skb)
-{
-	return xfrm_policy_check(sk, dir, skb, AF_INET6);
+	if (sk && sk->sk_policy[XFRM_POLICY_IN])
+		ret = __xfrm_policy_check(sk, dir, skb, family);
+	else
+		ret = (!xfrm_policy_count[dir] && !skb->sp) ||
+		      (skb->dst->flags & DST_NOPOLICY) ||
+		      __xfrm_policy_check(sk, dir, skb, family);
+
+	if (ret)
+		ret = security_skb_flow_in(skb, family);
+	return ret;
 }
 
 extern int xfrm_decode_session(struct sk_buff *skb, struct flowi *fl, unsigned short family);
@@ -742,19 +738,22 @@ static inline void xfrm_sk_free_policy(s
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

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

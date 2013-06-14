Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r5EJ3hcg020696
	for <selinux@tycho.nsa.gov>; Fri, 14 Jun 2013 15:04:17 -0400
Subject: [PATCH 7/8] selinux: cleanup the XFRM header
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Date: Fri, 14 Jun 2013 15:04:16 -0400
Message-ID: <20130614190416.30803.29442.stgit@localhost>
In-Reply-To: <20130614185950.30803.17359.stgit@localhost>
References: <20130614185950.30803.17359.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Remove the unused get_sock_isec() function and do some formatting
fixes.

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 security/selinux/include/xfrm.h |   19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/security/selinux/include/xfrm.h b/security/selinux/include/xfrm.h
index b463f210..60774bc 100644
--- a/security/selinux/include/xfrm.h
+++ b/security/selinux/include/xfrm.h
@@ -10,7 +10,7 @@
 #include <net/flow.h>
 
 int selinux_xfrm_policy_alloc(struct xfrm_sec_ctx **ctxp,
-			      struct xfrm_user_sec_ctx *sec_ctx);
+			      struct xfrm_user_sec_ctx *uctx);
 int selinux_xfrm_policy_clone(struct xfrm_sec_ctx *old_ctx,
 			      struct xfrm_sec_ctx **new_ctxp);
 void selinux_xfrm_policy_free(struct xfrm_sec_ctx *ctx);
@@ -23,18 +23,8 @@ void selinux_xfrm_state_free(struct xfrm_state *x);
 int selinux_xfrm_state_delete(struct xfrm_state *x);
 int selinux_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir);
 int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x,
-			struct xfrm_policy *xp, const struct flowi *fl);
-
-/*
- * Extract the security blob from the sock (it's actually on the socket)
- */
-static inline struct inode_security_struct *get_sock_isec(struct sock *sk)
-{
-	if (!sk->sk_socket)
-		return NULL;
-
-	return SOCK_INODE(sk->sk_socket)->i_security;
-}
+				      struct xfrm_policy *xp,
+				      const struct flowi *fl);
 
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
 extern atomic_t selinux_xfrm_refcount;
@@ -74,7 +64,8 @@ static inline int selinux_xfrm_postroute_last(u32 sk_sid, struct sk_buff *skb,
 	return 0;
 }
 
-static inline int selinux_xfrm_decode_session(struct sk_buff *skb, u32 *sid, int ckall)
+static inline int selinux_xfrm_decode_session(struct sk_buff *skb, u32 *sid,
+					      int ckall)
 {
 	*sid = SECSID_NULL;
 	return 0;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

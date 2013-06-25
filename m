Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r5PLIhuh018886
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2013 17:18:51 -0400
Subject: [PATCH 5/9] selinux: cleanup selinux_xfrm_sock_rcv_skb() and
 selinux_xfrm_postroute_last()
To: linux-security-module@vger.kernel.org, eparis@redhat.com,
        selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Date: Tue, 25 Jun 2013 17:18:49 -0400
Message-ID: <20130625211849.5057.681.stgit@localhost>
In-Reply-To: <20130625211306.5057.31329.stgit@localhost>
References: <20130625211306.5057.31329.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Some basic simplification and comment reformatting.

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 security/selinux/include/xfrm.h |   17 ++++----
 security/selinux/xfrm.c         |   85 +++++++++++++++------------------------
 2 files changed, 42 insertions(+), 60 deletions(-)

diff --git a/security/selinux/include/xfrm.h b/security/selinux/include/xfrm.h
index f2a2314..b463f210 100644
--- a/security/selinux/include/xfrm.h
+++ b/security/selinux/include/xfrm.h
@@ -44,10 +44,10 @@ static inline int selinux_xfrm_enabled(void)
 	return (atomic_read(&selinux_xfrm_refcount) > 0);
 }
 
-int selinux_xfrm_sock_rcv_skb(u32 sid, struct sk_buff *skb,
-			struct common_audit_data *ad);
-int selinux_xfrm_postroute_last(u32 isec_sid, struct sk_buff *skb,
-			struct common_audit_data *ad, u8 proto);
+int selinux_xfrm_sock_rcv_skb(u32 sk_sid, struct sk_buff *skb,
+			      struct common_audit_data *ad);
+int selinux_xfrm_postroute_last(u32 sk_sid, struct sk_buff *skb,
+				struct common_audit_data *ad, u8 proto);
 int selinux_xfrm_decode_session(struct sk_buff *skb, u32 *sid, int ckall);
 
 static inline void selinux_xfrm_notify_policyload(void)
@@ -61,14 +61,15 @@ static inline int selinux_xfrm_enabled(void)
 	return 0;
 }
 
-static inline int selinux_xfrm_sock_rcv_skb(u32 isec_sid, struct sk_buff *skb,
-			struct common_audit_data *ad)
+static inline int selinux_xfrm_sock_rcv_skb(u32 sk_sid, struct sk_buff *skb,
+					    struct common_audit_data *ad)
 {
 	return 0;
 }
 
-static inline int selinux_xfrm_postroute_last(u32 isec_sid, struct sk_buff *skb,
-			struct common_audit_data *ad, u8 proto)
+static inline int selinux_xfrm_postroute_last(u32 sk_sid, struct sk_buff *skb,
+					      struct common_audit_data *ad,
+					      u8 proto)
 {
 	return 0;
 }
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 4a7ba4a..1f6c6e6 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -367,14 +367,12 @@ int selinux_xfrm_state_delete(struct xfrm_state *x)
  * we need to check for unlabelled access since this may not have
  * gone thru the IPSec process.
  */
-int selinux_xfrm_sock_rcv_skb(u32 isec_sid, struct sk_buff *skb,
-				struct common_audit_data *ad)
+int selinux_xfrm_sock_rcv_skb(u32 sk_sid, struct sk_buff *skb,
+			      struct common_audit_data *ad)
 {
-	int i, rc = 0;
-	struct sec_path *sp;
-	u32 sel_sid = SECINITSID_UNLABELED;
-
-	sp = skb->sp;
+	int i;
+	struct sec_path *sp = skb->sp;
+	u32 peer_sid = SECINITSID_UNLABELED;
 
 	if (sp) {
 		for (i = 0; i < sp->len; i++) {
@@ -382,23 +380,17 @@ int selinux_xfrm_sock_rcv_skb(u32 isec_sid, struct sk_buff *skb,
 
 			if (x && selinux_authorizable_xfrm(x)) {
 				struct xfrm_sec_ctx *ctx = x->security;
-				sel_sid = ctx->ctx_sid;
+				peer_sid = ctx->ctx_sid;
 				break;
 			}
 		}
 	}
 
-	/*
-	 * This check even when there's no association involved is
-	 * intended, according to Trent Jaeger, to make sure a
-	 * process can't engage in non-ipsec communication unless
-	 * explicitly allowed by policy.
-	 */
-
-	rc = avc_has_perm(isec_sid, sel_sid, SECCLASS_ASSOCIATION,
-			  ASSOCIATION__RECVFROM, ad);
-
-	return rc;
+	/* This check even when there's no association involved is intended,
+	 * according to Trent Jaeger, to make sure a process can't engage in
+	 * non-IPsec communication unless explicitly allowed by policy. */
+	return avc_has_perm(sk_sid, peer_sid,
+			    SECCLASS_ASSOCIATION, ASSOCIATION__RECVFROM, ad);
 }
 
 /*
@@ -408,49 +400,38 @@ int selinux_xfrm_sock_rcv_skb(u32 isec_sid, struct sk_buff *skb,
  * If we do have a authorizable security association, then it has already been
  * checked in the selinux_xfrm_state_pol_flow_match hook above.
  */
-int selinux_xfrm_postroute_last(u32 isec_sid, struct sk_buff *skb,
-					struct common_audit_data *ad, u8 proto)
+int selinux_xfrm_postroute_last(u32 sk_sid, struct sk_buff *skb,
+				struct common_audit_data *ad, u8 proto)
 {
 	struct dst_entry *dst;
-	int rc = 0;
-
-	dst = skb_dst(skb);
-
-	if (dst) {
-		struct dst_entry *dst_test;
-
-		for (dst_test = dst; dst_test != NULL;
-		     dst_test = dst_test->child) {
-			struct xfrm_state *x = dst_test->xfrm;
-
-			if (x && selinux_authorizable_xfrm(x))
-				goto out;
-		}
-	}
 
 	switch (proto) {
 	case IPPROTO_AH:
 	case IPPROTO_ESP:
 	case IPPROTO_COMP:
-		/*
-		 * We should have already seen this packet once before
-		 * it underwent xfrm(s). No need to subject it to the
-		 * unlabeled check.
-		 */
-		goto out;
+		/* We should have already seen this packet once before it
+		 * underwent xfrm(s). No need to subject it to the unlabeled
+		 * check. */
+		return 0;
 	default:
 		break;
 	}
 
-	/*
-	 * This check even when there's no association involved is
-	 * intended, according to Trent Jaeger, to make sure a
-	 * process can't engage in non-ipsec communication unless
-	 * explicitly allowed by policy.
-	 */
+	dst = skb_dst(skb);
+	if (dst) {
+		struct dst_entry *iter;
 
-	rc = avc_has_perm(isec_sid, SECINITSID_UNLABELED, SECCLASS_ASSOCIATION,
-			  ASSOCIATION__SENDTO, ad);
-out:
-	return rc;
+		for (iter = dst; iter != NULL; iter = iter->child) {
+			struct xfrm_state *x = iter->xfrm;
+
+			if (x && selinux_authorizable_xfrm(x))
+				return 0;
+		}
+	}
+
+	/* This check even when there's no association involved is intended,
+	 * according to Trent Jaeger, to make sure a process can't engage in
+	 * non-IPsec communication unless explicitly allowed by policy. */
+	return avc_has_perm(sk_sid, SECINITSID_UNLABELED,
+			    SECCLASS_ASSOCIATION, ASSOCIATION__SENDTO, ad);
 }


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

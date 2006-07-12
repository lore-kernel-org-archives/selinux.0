Message-ID: <44B56634.5070205@trustedcs.com>
Date: Wed, 12 Jul 2006 16:14:28 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: jmorris@namei.org, sds@tycho.nsa.gov, tjaeger@cse.psu.edu,
        selinux@tycho.nsa.gov
Subject: [PATCH 06/10] MLSXFRM: Add security context to acquire messages using
 netlink
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Serge Hallyn <serue@us.ibm.com>

This includes the security context of a security association created for use by IKE
in the acquire messages sent to IKE daemons using netlink/xfrm_user. This would allow
the daemons to include the security context in the negotiation, so that the resultant
association is unique to that security context.

Signed-off-by:  <hallyn@elg11.watson.ibm.com>
---

 net/xfrm/xfrm_user.c |   45 ++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 16 deletions(-)

--- linux-2.6.17.flow/net/xfrm/xfrm_user.c	2006-07-11 16:05:49.000000000 -0500
+++ linux-2.6.17/net/xfrm/xfrm_user.c	2006-07-11 20:55:16.000000000 -0500
@@ -910,27 +910,40 @@ rtattr_failure:
 	return -1;
 }
 
-static int copy_to_user_sec_ctx(struct xfrm_policy *xp, struct sk_buff *skb)
+static int copy_sec_ctx(struct xfrm_sec_ctx *s, struct sk_buff *skb)
 {
-	if (xp->security) {
-		int ctx_size = sizeof(struct xfrm_sec_ctx) +
-				xp->security->ctx_len;
-		struct rtattr *rt = __RTA_PUT(skb, XFRMA_SEC_CTX, ctx_size);
-		struct xfrm_user_sec_ctx *uctx = RTA_DATA(rt);
-
-		uctx->exttype = XFRMA_SEC_CTX;
-		uctx->len = ctx_size;
-		uctx->ctx_doi = xp->security->ctx_doi;
-		uctx->ctx_alg = xp->security->ctx_alg;
-		uctx->ctx_len = xp->security->ctx_len;
-		memcpy(uctx + 1, xp->security->ctx_str, xp->security->ctx_len);
-	}
-	return 0;
+	int ctx_size = sizeof(struct xfrm_sec_ctx) + s->ctx_len;
+	struct rtattr *rt = __RTA_PUT(skb, XFRMA_SEC_CTX, ctx_size);
+	struct xfrm_user_sec_ctx *uctx = RTA_DATA(rt);
+
+	uctx->exttype = XFRMA_SEC_CTX;
+	uctx->len = ctx_size;
+	uctx->ctx_doi = s->ctx_doi;
+	uctx->ctx_alg = s->ctx_alg;
+	uctx->ctx_len = s->ctx_len;
+	memcpy(uctx + 1, s->ctx_str, s->ctx_len);
+ 	return 0;
 
  rtattr_failure:
 	return -1;
 }
 
+static inline int copy_to_user_state_sec_ctx(struct xfrm_state *x, struct sk_buff *skb)
+{
+	if (x->security) {
+		return copy_sec_ctx(x->security, skb);
+	}
+	return 0;
+}
+
+static inline int copy_to_user_sec_ctx(struct xfrm_policy *xp, struct sk_buff *skb)
+{
+	if (xp->security) {
+		return copy_sec_ctx(xp->security, skb);
+	}
+	return 0;
+}
+
 static int dump_one_policy(struct xfrm_policy *xp, int dir, int count, void *ptr)
 {
 	struct xfrm_dump_info *sp = ptr;
@@ -1709,7 +1722,7 @@ static int build_acquire(struct sk_buff 
 
 	if (copy_to_user_tmpl(xp, skb) < 0)
 		goto nlmsg_failure;
-	if (copy_to_user_sec_ctx(xp, skb))
+	if (copy_to_user_state_sec_ctx(x, skb))
 		goto nlmsg_failure;
 
 	nlh->nlmsg_len = skb->tail - b;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

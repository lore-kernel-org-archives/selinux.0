Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5KIOGix004840
	for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2006 14:24:16 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5KIOEOh006999
	for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2006 18:24:14 GMT
Message-ID: <44983D49.4000903@trustedcs.com>
Date: Tue, 20 Jun 2006 13:24:09 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Subject: [PATCH 05/06] MLSXFRM: Add security context to acquire messages using
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

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index bac2dab..9c17261 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -909,27 +909,40 @@ rtattr_failure:
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
@@ -1708,7 +1721,7 @@ static int build_acquire(struct sk_buff 
 
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

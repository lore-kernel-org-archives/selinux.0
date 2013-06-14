Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r5EJ3hcY020696
	for <selinux@tycho.nsa.gov>; Fri, 14 Jun 2013 15:03:53 -0400
Subject: [PATCH 3/8] selinux: cleanup selinux_xfrm_policy_lookup() and
 selinux_xfrm_state_pol_flow_match()
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Date: Fri, 14 Jun 2013 15:03:51 -0400
Message-ID: <20130614190351.30803.84121.stgit@localhost>
In-Reply-To: <20130614185950.30803.17359.stgit@localhost>
References: <20130614185950.30803.17359.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Do some basic simplification and comment reformatting.

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 security/selinux/xfrm.c |   54 ++++++++++++++++-------------------------------
 1 file changed, 18 insertions(+), 36 deletions(-)

diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index f8d7126..4a7ba4a 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -155,42 +155,30 @@ static int selinux_xfrm_delete(struct xfrm_sec_ctx *ctx)
 int selinux_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir)
 {
 	int rc;
-	u32 sel_sid;
 
-	/* Context sid is either set to label or ANY_ASSOC */
-	if (ctx) {
-		if (!selinux_authorizable_ctx(ctx))
-			return -EINVAL;
-
-		sel_sid = ctx->ctx_sid;
-	} else
-		/*
-		 * All flows should be treated as polmatch'ing an
-		 * otherwise applicable "non-labeled" policy. This
-		 * would prevent inadvertent "leaks".
-		 */
+	/* All flows should be treated as polmatch'ing an otherwise applicable
+	 * "non-labeled" policy. This would prevent inadvertent "leaks". */
+	if (!ctx)
 		return 0;
 
-	rc = avc_has_perm(fl_secid, sel_sid, SECCLASS_ASSOCIATION,
-			  ASSOCIATION__POLMATCH,
-			  NULL);
-
-	if (rc == -EACCES)
-		return -ESRCH;
+	/* Context sid is either set to label or ANY_ASSOC */
+	if (!selinux_authorizable_ctx(ctx))
+		return -EINVAL;
 
-	return rc;
+	rc = avc_has_perm(fl_secid, ctx->ctx_sid,
+			  SECCLASS_ASSOCIATION, ASSOCIATION__POLMATCH, NULL);
+	return (rc == -EACCES ? -ESRCH : rc);
 }
 
 /*
  * LSM hook implementation that authorizes that a state matches
  * the given policy, flow combo.
  */
-
-int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x, struct xfrm_policy *xp,
-			const struct flowi *fl)
+int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x,
+				      struct xfrm_policy *xp,
+				      const struct flowi *fl)
 {
 	u32 state_sid;
-	int rc;
 
 	if (!xp->security)
 		if (x->security)
@@ -213,18 +201,12 @@ int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x, struct xfrm_policy *
 	if (fl->flowi_secid != state_sid)
 		return 0;
 
-	rc = avc_has_perm(fl->flowi_secid, state_sid, SECCLASS_ASSOCIATION,
-			  ASSOCIATION__SENDTO,
-			  NULL)? 0:1;
-
-	/*
-	 * We don't need a separate SA Vs. policy polmatch check
-	 * since the SA is now of the same label as the flow and
-	 * a flow Vs. policy polmatch check had already happened
-	 * in selinux_xfrm_policy_lookup() above.
-	 */
-
-	return rc;
+	/* We don't need a separate SA Vs. policy polmatch check since the SA
+	 * is now of the same label as the flow and a flow Vs. policy polmatch
+	 * check had already happened in selinux_xfrm_policy_lookup() above. */
+	return (avc_has_perm(fl->flowi_secid, state_sid,
+			    SECCLASS_ASSOCIATION, ASSOCIATION__SENDTO,
+			    NULL) ? 0 : 1);
 }
 
 /*


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r5EJ3hce020696
	for <selinux@tycho.nsa.gov>; Fri, 14 Jun 2013 15:04:12 -0400
Subject: [PATCH 6/8] selinux: cleanup selinux_xfrm_decode_session()
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Date: Fri, 14 Jun 2013 15:04:10 -0400
Message-ID: <20130614190410.30803.68249.stgit@localhost>
In-Reply-To: <20130614185950.30803.17359.stgit@localhost>
References: <20130614185950.30803.17359.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Some basic simplification.

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 security/selinux/xfrm.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 00801ce..425b9f9 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -215,34 +215,35 @@ int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x,
  */
 int selinux_xfrm_decode_session(struct sk_buff *skb, u32 *sid, int ckall)
 {
+	u32 sid_session = SECSID_NULL;
 	struct sec_path *sp;
 
-	*sid = SECSID_NULL;
-
 	if (skb == NULL)
-		return 0;
+		goto out;
 
 	sp = skb->sp;
 	if (sp) {
-		int i, sid_set = 0;
+		int i;
 
-		for (i = sp->len-1; i >= 0; i--) {
+		for (i = sp->len - 1; i >= 0; i--) {
 			struct xfrm_state *x = sp->xvec[i];
 			if (selinux_authorizable_xfrm(x)) {
 				struct xfrm_sec_ctx *ctx = x->security;
 
-				if (!sid_set) {
-					*sid = ctx->ctx_sid;
-					sid_set = 1;
-
+				if (sid_session == SECSID_NULL) {
+					sid_session = ctx->ctx_sid;
 					if (!ckall)
-						break;
-				} else if (*sid != ctx->ctx_sid)
+						goto out;
+				} else if (sid_session != ctx->ctx_sid) {
+					*sid = SECSID_NULL;
 					return -EINVAL;
+				}
 			}
 		}
 	}
 
+out:
+	*sid = sid_session;
 	return 0;
 }
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

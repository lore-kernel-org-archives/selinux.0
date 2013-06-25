Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r5PLIhuj018886
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2013 17:18:57 -0400
Subject: [PATCH 6/9] selinux: cleanup some comment and whitespace issues in
 the XFRM code
To: linux-security-module@vger.kernel.org, eparis@redhat.com,
        selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Date: Tue, 25 Jun 2013 17:18:55 -0400
Message-ID: <20130625211855.5057.97273.stgit@localhost>
In-Reply-To: <20130625211306.5057.31329.stgit@localhost>
References: <20130625211306.5057.31329.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 security/selinux/xfrm.c |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 1f6c6e6..00801ce 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -56,7 +56,7 @@
 atomic_t selinux_xfrm_refcount = ATOMIC_INIT(0);
 
 /*
- * Returns true if an LSM/SELinux context
+ * Returns true if the context is an LSM/SELinux context.
  */
 static inline int selinux_authorizable_ctx(struct xfrm_sec_ctx *ctx)
 {
@@ -66,7 +66,7 @@ static inline int selinux_authorizable_ctx(struct xfrm_sec_ctx *ctx)
 }
 
 /*
- * Returns true if the xfrm contains a security blob for SELinux
+ * Returns true if the xfrm contains a security blob for SELinux.
  */
 static inline int selinux_authorizable_xfrm(struct xfrm_state *x)
 {
@@ -149,8 +149,8 @@ static int selinux_xfrm_delete(struct xfrm_sec_ctx *ctx)
 }
 
 /*
- * LSM hook implementation that authorizes that a flow can use
- * a xfrm policy rule.
+ * LSM hook implementation that authorizes that a flow can use a xfrm policy
+ * rule.
  */
 int selinux_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir)
 {
@@ -213,7 +213,6 @@ int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x,
  * LSM hook implementation that checks and/or returns the xfrm sid for the
  * incoming packet.
  */
-
 int selinux_xfrm_decode_session(struct sk_buff *skb, u32 *sid, int ckall)
 {
 	struct sec_path *sp;
@@ -248,8 +247,7 @@ int selinux_xfrm_decode_session(struct sk_buff *skb, u32 *sid, int ckall)
 }
 
 /*
- * LSM hook implementation that allocs and transfers uctx spec to
- * xfrm_policy.
+ * LSM hook implementation that allocs and transfers uctx spec to xfrm_policy.
  */
 int selinux_xfrm_policy_alloc(struct xfrm_sec_ctx **ctxp,
 			      struct xfrm_user_sec_ctx *uctx)
@@ -257,10 +255,9 @@ int selinux_xfrm_policy_alloc(struct xfrm_sec_ctx **ctxp,
 	return selinux_xfrm_alloc_user(ctxp, uctx);
 }
 
-
 /*
- * LSM hook implementation that copies security data structure from old to
- * new for policy cloning.
+ * LSM hook implementation that copies security data structure from old to new
+ * for policy cloning.
  */
 int selinux_xfrm_policy_clone(struct xfrm_sec_ctx *old_ctx,
 			      struct xfrm_sec_ctx **new_ctxp)
@@ -352,9 +349,9 @@ void selinux_xfrm_state_free(struct xfrm_state *x)
 	selinux_xfrm_free(x->security);
 }
 
- /*
-  * LSM hook implementation that authorizes deletion of labeled SAs.
-  */
+/*
+ * LSM hook implementation that authorizes deletion of labeled SAs.
+ */
 int selinux_xfrm_state_delete(struct xfrm_state *x)
 {
 	return selinux_xfrm_delete(x->security);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

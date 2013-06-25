Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r5PLIEm7018719
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2013 17:18:32 -0400
Subject: [PATCH 3/9] selinux: cleanup and consolidate the XFRM
 alloc/clone/delete/free code
To: linux-security-module@vger.kernel.org, eparis@redhat.com,
        selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Date: Tue, 25 Jun 2013 17:18:31 -0400
Message-ID: <20130625211831.5057.465.stgit@localhost>
In-Reply-To: <20130625211306.5057.31329.stgit@localhost>
References: <20130625211306.5057.31329.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The SELinux labeled IPsec code state management functions have been
long neglected and could use some cleanup and consolidation.

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 security/selinux/xfrm.c |   71 ++++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 31 deletions(-)

diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 07ae0c0..f8d7126 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -122,6 +122,33 @@ err:
 }
 
 /*
+ * Free the xfrm_sec_ctx structure.
+ */
+static void selinux_xfrm_free(struct xfrm_sec_ctx *ctx)
+{
+	if (!ctx)
+		return;
+
+	atomic_dec(&selinux_xfrm_refcount);
+	kfree(ctx);
+}
+
+/*
+ * Authorize the deletion of a labeled SA or policy rule.
+ */
+static int selinux_xfrm_delete(struct xfrm_sec_ctx *ctx)
+{
+	const struct task_security_struct *tsec = current_security();
+
+	if (!ctx)
+		return 0;
+
+	return avc_has_perm(tsec->sid, ctx->ctx_sid,
+			    SECCLASS_ASSOCIATION, ASSOCIATION__SETCONTEXT,
+			    NULL);
+}
+
+/*
  * LSM hook implementation that authorizes that a flow can use
  * a xfrm policy rule.
  */
@@ -258,17 +285,16 @@ int selinux_xfrm_policy_clone(struct xfrm_sec_ctx *old_ctx,
 {
 	struct xfrm_sec_ctx *new_ctx;
 
-	if (old_ctx) {
-		new_ctx = kmalloc(sizeof(*old_ctx) + old_ctx->ctx_len,
-				  GFP_ATOMIC);
-		if (!new_ctx)
-			return -ENOMEM;
+	if (!old_ctx)
+		return 0;
+
+	new_ctx = kmalloc(sizeof(*old_ctx) + old_ctx->ctx_len, GFP_ATOMIC);
+	if (!new_ctx)
+		return -ENOMEM;
+	memcpy(new_ctx, old_ctx, sizeof(*old_ctx) + old_ctx->ctx_len);
+	atomic_inc(&selinux_xfrm_refcount);
+	*new_ctxp = new_ctx;
 
-		memcpy(new_ctx, old_ctx, sizeof(*new_ctx));
-		memcpy(new_ctx->ctx_str, old_ctx->ctx_str, new_ctx->ctx_len);
-		atomic_inc(&selinux_xfrm_refcount);
-		*new_ctxp = new_ctx;
-	}
 	return 0;
 }
 
@@ -277,8 +303,7 @@ int selinux_xfrm_policy_clone(struct xfrm_sec_ctx *old_ctx,
  */
 void selinux_xfrm_policy_free(struct xfrm_sec_ctx *ctx)
 {
-	atomic_dec(&selinux_xfrm_refcount);
-	kfree(ctx);
+	selinux_xfrm_free(ctx);
 }
 
 /*
@@ -286,14 +311,7 @@ void selinux_xfrm_policy_free(struct xfrm_sec_ctx *ctx)
  */
 int selinux_xfrm_policy_delete(struct xfrm_sec_ctx *ctx)
 {
-	const struct task_security_struct *tsec = current_security();
-
-	if (!ctx)
-		return 0;
-
-	return avc_has_perm(tsec->sid, ctx->ctx_sid,
-			    SECCLASS_ASSOCIATION, ASSOCIATION__SETCONTEXT,
-			    NULL);
+	return selinux_xfrm_delete(ctx);
 }
 
 /*
@@ -349,8 +367,7 @@ int selinux_xfrm_state_alloc_acquire(struct xfrm_state *x,
  */
 void selinux_xfrm_state_free(struct xfrm_state *x)
 {
-	atomic_dec(&selinux_xfrm_refcount);
-	kfree(x->security);
+	selinux_xfrm_free(x->security);
 }
 
  /*
@@ -358,15 +375,7 @@ void selinux_xfrm_state_free(struct xfrm_state *x)
   */
 int selinux_xfrm_state_delete(struct xfrm_state *x)
 {
-	const struct task_security_struct *tsec = current_security();
-	struct xfrm_sec_ctx *ctx = x->security;
-
-	if (!ctx)
-		return 0;
-
-	return avc_has_perm(tsec->sid, ctx->ctx_sid,
-			    SECCLASS_ASSOCIATION, ASSOCIATION__SETCONTEXT,
-			    NULL);
+	return selinux_xfrm_delete(x->security);
 }
 
 /*


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

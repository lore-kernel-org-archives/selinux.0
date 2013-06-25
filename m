Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r5PLIEm5018719
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2013 17:18:26 -0400
Subject: [PATCH 2/9] lsm: split the xfrm_state_alloc_security() hook
 implementation
To: linux-security-module@vger.kernel.org, eparis@redhat.com,
        selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Date: Tue, 25 Jun 2013 17:18:24 -0400
Message-ID: <20130625211824.5057.90361.stgit@localhost>
In-Reply-To: <20130625211306.5057.31329.stgit@localhost>
References: <20130625211306.5057.31329.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The xfrm_state_alloc_security() LSM hook implementation is really a
multiplexed hook with two different behaviors depending on the
arguments passed to it by the caller.  This patch splits the LSM hook
implementation into two new hook implementations, which match the
LSM hooks in the rest of the kernel:

 * xfrm_state_alloc
 * xfrm_state_alloc_acquire

Also included in this patch are the necessary changes to the SELinux
code; no other LSMs are affected.

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 include/linux/security.h        |   26 ++++-
 security/capability.c           |   15 ++-
 security/security.c             |   13 +--
 security/selinux/hooks.c        |    3 -
 security/selinux/include/xfrm.h |    4 +
 security/selinux/xfrm.c         |  199 ++++++++++++++++++---------------------
 6 files changed, 128 insertions(+), 132 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 4686491..e5a5e8a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1039,17 +1039,25 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
  * @xfrm_policy_delete_security:
  *	@ctx contains the xfrm_sec_ctx.
  *	Authorize deletion of xp->security.
- * @xfrm_state_alloc_security:
+ * @xfrm_state_alloc:
  *	@x contains the xfrm_state being added to the Security Association
  *	Database by the XFRM system.
  *	@sec_ctx contains the security context information being provided by
  *	the user-level SA generation program (e.g., setkey or racoon).
- *	@secid contains the secid from which to take the mls portion of the context.
  *	Allocate a security structure to the x->security field; the security
  *	field is initialized to NULL when the xfrm_state is allocated. Set the
- *	context to correspond to either sec_ctx or polsec, with the mls portion
- *	taken from secid in the latter case.
- *	Return 0 if operation was successful (memory to allocate, legal context).
+ *	context to correspond to sec_ctx. Return 0 if operation was successful
+ *	(memory to allocate, legal context).
+ * @xfrm_state_alloc_acquire:
+ *	@x contains the xfrm_state being added to the Security Association
+ *	Database by the XFRM system.
+ *	@polsec contains the policy's security context.
+ *	@secid contains the secid from which to take the mls portion of the
+ *	context.
+ *	Allocate a security structure to the x->security field; the security
+ *	field is initialized to NULL when the xfrm_state is allocated. Set the
+ *	context to correspond to secid. Return 0 if operation was successful
+ *	(memory to allocate, legal context).
  * @xfrm_state_free_security:
  *	@x contains the xfrm_state.
  *	Deallocate x->security.
@@ -1651,9 +1659,11 @@ struct security_operations {
 	int (*xfrm_policy_clone_security) (struct xfrm_sec_ctx *old_ctx, struct xfrm_sec_ctx **new_ctx);
 	void (*xfrm_policy_free_security) (struct xfrm_sec_ctx *ctx);
 	int (*xfrm_policy_delete_security) (struct xfrm_sec_ctx *ctx);
-	int (*xfrm_state_alloc_security) (struct xfrm_state *x,
-		struct xfrm_user_sec_ctx *sec_ctx,
-		u32 secid);
+	int (*xfrm_state_alloc) (struct xfrm_state *x,
+				 struct xfrm_user_sec_ctx *sec_ctx);
+	int (*xfrm_state_alloc_acquire) (struct xfrm_state *x,
+					 struct xfrm_sec_ctx *polsec,
+					 u32 secid);
 	void (*xfrm_state_free_security) (struct xfrm_state *x);
 	int (*xfrm_state_delete_security) (struct xfrm_state *x);
 	int (*xfrm_policy_lookup) (struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir);
diff --git a/security/capability.c b/security/capability.c
index 1728d4e..67afc67 100644
--- a/security/capability.c
+++ b/security/capability.c
@@ -767,9 +767,15 @@ static int cap_xfrm_policy_delete_security(struct xfrm_sec_ctx *ctx)
 	return 0;
 }
 
-static int cap_xfrm_state_alloc_security(struct xfrm_state *x,
-					 struct xfrm_user_sec_ctx *sec_ctx,
-					 u32 secid)
+static int cap_xfrm_state_alloc(struct xfrm_state *x,
+				struct xfrm_user_sec_ctx *sec_ctx)
+{
+	return 0;
+}
+
+static int cap_xfrm_state_alloc_acquire(struct xfrm_state *x,
+					struct xfrm_sec_ctx *polsec,
+					u32 secid)
 {
 	return 0;
 }
@@ -1084,7 +1090,8 @@ void __init security_fixup_ops(struct security_operations *ops)
 	set_to_cap_if_null(ops, xfrm_policy_clone_security);
 	set_to_cap_if_null(ops, xfrm_policy_free_security);
 	set_to_cap_if_null(ops, xfrm_policy_delete_security);
-	set_to_cap_if_null(ops, xfrm_state_alloc_security);
+	set_to_cap_if_null(ops, xfrm_state_alloc);
+	set_to_cap_if_null(ops, xfrm_state_alloc_acquire);
 	set_to_cap_if_null(ops, xfrm_state_free_security);
 	set_to_cap_if_null(ops, xfrm_state_delete_security);
 	set_to_cap_if_null(ops, xfrm_policy_lookup);
diff --git a/security/security.c b/security/security.c
index a3dce87..57e25c9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1322,22 +1322,17 @@ int security_xfrm_policy_delete(struct xfrm_sec_ctx *ctx)
 	return security_ops->xfrm_policy_delete_security(ctx);
 }
 
-int security_xfrm_state_alloc(struct xfrm_state *x, struct xfrm_user_sec_ctx *sec_ctx)
+int security_xfrm_state_alloc(struct xfrm_state *x,
+			      struct xfrm_user_sec_ctx *sec_ctx)
 {
-	return security_ops->xfrm_state_alloc_security(x, sec_ctx, 0);
+	return security_ops->xfrm_state_alloc(x, sec_ctx);
 }
 EXPORT_SYMBOL(security_xfrm_state_alloc);
 
 int security_xfrm_state_alloc_acquire(struct xfrm_state *x,
 				      struct xfrm_sec_ctx *polsec, u32 secid)
 {
-	if (!polsec)
-		return 0;
-	/*
-	 * We want the context to be taken from secid which is usually
-	 * from the sock.
-	 */
-	return security_ops->xfrm_state_alloc_security(x, NULL, secid);
+	return security_ops->xfrm_state_alloc_acquire(x, polsec, secid);
 }
 
 int security_xfrm_state_delete(struct xfrm_state *x)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5c6f2cd..d3555bd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5708,7 +5708,8 @@ static struct security_operations selinux_ops = {
 	.xfrm_policy_clone_security =	selinux_xfrm_policy_clone,
 	.xfrm_policy_free_security =	selinux_xfrm_policy_free,
 	.xfrm_policy_delete_security =	selinux_xfrm_policy_delete,
-	.xfrm_state_alloc_security =	selinux_xfrm_state_alloc,
+	.xfrm_state_alloc =		selinux_xfrm_state_alloc,
+	.xfrm_state_alloc_acquire =	selinux_xfrm_state_alloc_acquire,
 	.xfrm_state_free_security =	selinux_xfrm_state_free,
 	.xfrm_state_delete_security =	selinux_xfrm_state_delete,
 	.xfrm_policy_lookup =		selinux_xfrm_policy_lookup,
diff --git a/security/selinux/include/xfrm.h b/security/selinux/include/xfrm.h
index 65f67cb..f2a2314 100644
--- a/security/selinux/include/xfrm.h
+++ b/security/selinux/include/xfrm.h
@@ -16,7 +16,9 @@ int selinux_xfrm_policy_clone(struct xfrm_sec_ctx *old_ctx,
 void selinux_xfrm_policy_free(struct xfrm_sec_ctx *ctx);
 int selinux_xfrm_policy_delete(struct xfrm_sec_ctx *ctx);
 int selinux_xfrm_state_alloc(struct xfrm_state *x,
-	struct xfrm_user_sec_ctx *sec_ctx, u32 secid);
+			     struct xfrm_user_sec_ctx *uctx);
+int selinux_xfrm_state_alloc_acquire(struct xfrm_state *x,
+				     struct xfrm_sec_ctx *polsec, u32 secid);
 void selinux_xfrm_state_free(struct xfrm_state *x);
 int selinux_xfrm_state_delete(struct xfrm_state *x);
 int selinux_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir);
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index d030818..07ae0c0 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -74,6 +74,54 @@ static inline int selinux_authorizable_xfrm(struct xfrm_state *x)
 }
 
 /*
+ * Allocates a xfrm_sec_state and populates it using the supplied security
+ * xfrm_user_sec_ctx context.
+ */
+static int selinux_xfrm_alloc_user(struct xfrm_sec_ctx **ctxp,
+				   struct xfrm_user_sec_ctx *uctx)
+{
+	int rc;
+	const struct task_security_struct *tsec = current_security();
+	struct xfrm_sec_ctx *ctx = NULL;
+	u32 str_len;
+
+	if (ctxp == NULL || uctx == NULL ||
+	    uctx->ctx_doi != XFRM_SC_DOI_LSM ||
+	    uctx->ctx_alg != XFRM_SC_ALG_SELINUX)
+		return -EINVAL;
+
+	str_len = uctx->ctx_len;
+	if (str_len >= PAGE_SIZE)
+		return -ENOMEM;
+
+	ctx = kmalloc(sizeof(*ctx) + str_len + 1, GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->ctx_doi = XFRM_SC_DOI_LSM;
+	ctx->ctx_alg = XFRM_SC_ALG_SELINUX;
+	ctx->ctx_len = str_len;
+	memcpy(ctx->ctx_str, &uctx[1], str_len);
+	ctx->ctx_str[str_len] = '\0';
+	rc = security_context_to_sid(ctx->ctx_str, str_len, &ctx->ctx_sid);
+	if (rc)
+		goto err;
+
+	rc = avc_has_perm(tsec->sid, ctx->ctx_sid,
+			  SECCLASS_ASSOCIATION, ASSOCIATION__SETCONTEXT, NULL);
+	if (rc)
+		goto err;
+
+	*ctxp = ctx;
+	atomic_inc(&selinux_xfrm_refcount);
+	return 0;
+
+err:
+	kfree(ctx);
+	return rc;
+}
+
+/*
  * LSM hook implementation that authorizes that a flow can use
  * a xfrm policy rule.
  */
@@ -191,111 +239,13 @@ int selinux_xfrm_decode_session(struct sk_buff *skb, u32 *sid, int ckall)
 }
 
 /*
- * Security blob allocation for xfrm_policy and xfrm_state
- * CTX does not have a meaningful value on input
- */
-static int selinux_xfrm_sec_ctx_alloc(struct xfrm_sec_ctx **ctxp,
-	struct xfrm_user_sec_ctx *uctx, u32 sid)
-{
-	int rc = 0;
-	const struct task_security_struct *tsec = current_security();
-	struct xfrm_sec_ctx *ctx = NULL;
-	char *ctx_str = NULL;
-	u32 str_len;
-
-	BUG_ON(uctx && sid);
-
-	if (!uctx)
-		goto not_from_user;
-
-	if (uctx->ctx_alg != XFRM_SC_ALG_SELINUX)
-		return -EINVAL;
-
-	str_len = uctx->ctx_len;
-	if (str_len >= PAGE_SIZE)
-		return -ENOMEM;
-
-	*ctxp = ctx = kmalloc(sizeof(*ctx) +
-			      str_len + 1,
-			      GFP_KERNEL);
-
-	if (!ctx)
-		return -ENOMEM;
-
-	ctx->ctx_doi = uctx->ctx_doi;
-	ctx->ctx_len = str_len;
-	ctx->ctx_alg = uctx->ctx_alg;
-
-	memcpy(ctx->ctx_str,
-	       uctx+1,
-	       str_len);
-	ctx->ctx_str[str_len] = 0;
-	rc = security_context_to_sid(ctx->ctx_str,
-				     str_len,
-				     &ctx->ctx_sid);
-
-	if (rc)
-		goto out;
-
-	/*
-	 * Does the subject have permission to set security context?
-	 */
-	rc = avc_has_perm(tsec->sid, ctx->ctx_sid,
-			  SECCLASS_ASSOCIATION,
-			  ASSOCIATION__SETCONTEXT, NULL);
-	if (rc)
-		goto out;
-
-	return rc;
-
-not_from_user:
-	rc = security_sid_to_context(sid, &ctx_str, &str_len);
-	if (rc)
-		goto out;
-
-	*ctxp = ctx = kmalloc(sizeof(*ctx) +
-			      str_len,
-			      GFP_ATOMIC);
-
-	if (!ctx) {
-		rc = -ENOMEM;
-		goto out;
-	}
-
-	ctx->ctx_doi = XFRM_SC_DOI_LSM;
-	ctx->ctx_alg = XFRM_SC_ALG_SELINUX;
-	ctx->ctx_sid = sid;
-	ctx->ctx_len = str_len;
-	memcpy(ctx->ctx_str,
-	       ctx_str,
-	       str_len);
-
-	goto out2;
-
-out:
-	*ctxp = NULL;
-	kfree(ctx);
-out2:
-	kfree(ctx_str);
-	return rc;
-}
-
-/*
  * LSM hook implementation that allocs and transfers uctx spec to
  * xfrm_policy.
  */
 int selinux_xfrm_policy_alloc(struct xfrm_sec_ctx **ctxp,
 			      struct xfrm_user_sec_ctx *uctx)
 {
-	int err;
-
-	BUG_ON(!uctx);
-
-	err = selinux_xfrm_sec_ctx_alloc(ctxp, uctx, 0);
-	if (err == 0)
-		atomic_inc(&selinux_xfrm_refcount);
-
-	return err;
+	return selinux_xfrm_alloc_user(ctxp, uctx);
 }
 
 
@@ -347,20 +297,51 @@ int selinux_xfrm_policy_delete(struct xfrm_sec_ctx *ctx)
 }
 
 /*
- * LSM hook implementation that allocs and transfers sec_ctx spec to
- * xfrm_state.
+ * LSM hook implementation that allocates a xfrm_sec_state, populates it using
+ * the supplied security context, and assigns it to the xfrm_state.
+ */
+int selinux_xfrm_state_alloc(struct xfrm_state *x,
+			     struct xfrm_user_sec_ctx *uctx)
+{
+	return selinux_xfrm_alloc_user(&x->security, uctx);
+}
+
+/*
+ * LSM hook implementation that allocates a xfrm_sec_state and populates based
+ * on a secid.
  */
-int selinux_xfrm_state_alloc(struct xfrm_state *x, struct xfrm_user_sec_ctx *uctx,
-		u32 secid)
+int selinux_xfrm_state_alloc_acquire(struct xfrm_state *x,
+				     struct xfrm_sec_ctx *polsec, u32 secid)
 {
-	int err;
+	int rc;
+	struct xfrm_sec_ctx *ctx;
+	char *ctx_str = NULL;
+	int str_len;
 
-	BUG_ON(!x);
+	if (!polsec)
+		return 0;
 
-	err = selinux_xfrm_sec_ctx_alloc(&x->security, uctx, secid);
-	if (err == 0)
-		atomic_inc(&selinux_xfrm_refcount);
-	return err;
+	if (secid == 0)
+		return -EINVAL;
+
+	rc = security_sid_to_context(secid, &ctx_str, &str_len);
+	if (rc)
+		return rc;
+
+	ctx = kmalloc(sizeof(*ctx) + str_len, GFP_ATOMIC);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->ctx_doi = XFRM_SC_DOI_LSM;
+	ctx->ctx_alg = XFRM_SC_ALG_SELINUX;
+	ctx->ctx_sid = secid;
+	ctx->ctx_len = str_len;
+	memcpy(ctx->ctx_str, ctx_str, str_len);
+	kfree(ctx_str);
+
+	x->security = ctx;
+	atomic_inc(&selinux_xfrm_refcount);
+	return 0;
 }
 
 /*


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n625WGC7013566
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 01:32:16 -0400
Received: from mail-pz0-f177.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n625VvvX014604
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 05:32:00 GMT
Received: by mail-pz0-f177.google.com with SMTP id 7so1000314pzk.32
        for <selinux@tycho.nsa.gov>; Wed, 01 Jul 2009 22:32:16 -0700 (PDT)
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: selinux@tycho.nsa.gov, "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH 8/8] SELinux xfrm.c non trivial fixes.
Date: Wed,  1 Jul 2009 22:32:47 -0700
Message-Id: <1246512767-2999-9-git-send-email-justinmattock@gmail.com>
In-Reply-To: <1246512767-2999-1-git-send-email-justinmattock@gmail.com>
References: <1246512767-2999-1-git-send-email-justinmattock@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

Fix some comments.
Add some words to some comment's to sound proper.
---
 security/selinux/xfrm.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 72b1845..4313064 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -27,9 +27,9 @@
  *	CONFIG_SECURITY_NETWORK_XFRM=y
  *	CONFIG_SECURITY_SELINUX=m/y
  * ISSUES:
- *   1. Caching packets, so they are not dropped during negotiation
- *   2. Emulating a reasonable SO_PEERSEC across machines
- *   3. Testing addition of sk_policy's with security context via setsockopt
+ *   1. Caching packets, so they are not dropped during negotiation.
+ *   2. Emulating a reasonable SO_PEERSEC across machines.
+ *   3. Testing addition of sk_policy's with security context via setsockopt.
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -51,11 +51,11 @@
 #include "objsec.h"
 #include "xfrm.h"
 
-/* Labeled XFRM instance counter */
+/* Labeled XFRM instance counter. */
 atomic_t selinux_xfrm_refcount = ATOMIC_INIT(0);
 
 /*
- * Returns true if an LSM/SELinux context
+ * Returns true if an LSM/SELinux context.
  */
 static inline int selinux_authorizable_ctx(struct xfrm_sec_ctx *ctx)
 {
@@ -65,7 +65,7 @@ static inline int selinux_authorizable_ctx(struct xfrm_sec_ctx *ctx)
 }
 
 /*
- * Returns true if the xfrm contains a security blob for SELinux
+ * Returns true if the xfrm contains a security blob for SELinux.
  */
 static inline int selinux_authorizable_xfrm(struct xfrm_state *x)
 {
@@ -81,7 +81,7 @@ int selinux_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir)
 	int rc;
 	u32 sel_sid;
 
-	/* Context sid is either set to label or ANY_ASSOC */
+	/* Context sid is either set to label or ANY_ASSOC. */
 	if (ctx) {
 		if (!selinux_authorizable_ctx(ctx))
 			return -EINVAL;
@@ -118,18 +118,18 @@ int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x, struct xfrm_policy *
 
 	if (!xp->security)
 		if (x->security)
-			/* unlabeled policy and labeled SA can't match */
+			/* Unlabeled policy and labeled SA can't match. */
 			return 0;
 		else
-			/* unlabeled policy and unlabeled SA match all flows */
+			/* Unlabeled policy and unlabeled SA match all flows. */
 			return 1;
 	else
 		if (!x->security)
-			/* unlabeled SA and labeled policy can't match */
+			/* Unlabeled SA and labeled policy can't match. */
 			return 0;
 		else
 			if (!selinux_authorizable_xfrm(x))
-				/* Not a SELinux-labeled SA */
+				/* Not a SELinux-labeled SA. */
 				return 0;
 
 	state_sid = x->security->ctx_sid;
@@ -191,7 +191,7 @@ int selinux_xfrm_decode_session(struct sk_buff *skb, u32 *sid, int ckall)
 
 /*
  * Security blob allocation for xfrm_policy and xfrm_state
- * CTX does not have a meaningful value on input
+ * CTX does not have a meaningful value on input.
  */
 static int selinux_xfrm_sec_ctx_alloc(struct xfrm_sec_ctx **ctxp,
 	struct xfrm_user_sec_ctx *uctx, u32 sid)
@@ -237,7 +237,7 @@ static int selinux_xfrm_sec_ctx_alloc(struct xfrm_sec_ctx **ctxp,
 		goto out;
 
 	/*
-	 * Does the subject have permission to set security context?
+	 * Does the subject have permission to set the security context?
 	 */
 	rc = avc_has_perm(tsec->sid, ctx->ctx_sid,
 			  SECCLASS_ASSOCIATION,
-- 
1.6.3.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

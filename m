From: eparis@redhat.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Eric Paris <eparis@redhat.com>
Subject: [PATCH 06/13] SELinux: xfrm.c whitespace, syntax, and static declaraction cleanups
Date: Fri, 18 Apr 2008 17:38:27 -0400
Message-Id: <12085547141335-git-send-email-eparis@redhat.com>
In-Reply-To: <12085547142971-git-send-email-eparis@redhat.com>
References: <1208554714617-git-send-email-eparis@redhat.com>
 <12085547142360-git-send-email-eparis@redhat.com>
 <12085547142711-git-send-email-eparis@redhat.com>
 <12085547143090-git-send-email-eparis@redhat.com>
 <12085547142971-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Eric Paris <eparis@redhat.com>

This patch changes xfrm.c to fix whitespace and syntax issues.  Things that
are fixed may include (does not not have to include)

whitespace at end of lines
spaces followed by tabs
spaces used instead of tabs
spacing around parenthesis
locateion of { around struct and else clauses
location of * in pointer declarations
removal of initialization of static data to keep it in the right section
useless {} in if statemetns
useless checking for NULL before kfree
fixing of the indentation depth of switch statements
and any number of other things I forgot to mention

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 security/selinux/xfrm.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 7e15820..bfe9c4d 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -84,13 +84,13 @@ int selinux_xfrm_policy_lookup(struct xfrm_policy *xp, u32 fl_secid, u8 dir)
 	struct xfrm_sec_ctx *ctx;
 
 	/* Context sid is either set to label or ANY_ASSOC */
-	if ((ctx = xp->security)) {
+	ctx = xp->security;
+	if (ctx) {
 		if (!selinux_authorizable_ctx(ctx))
 			return -EINVAL;
 
 		sel_sid = ctx->ctx_sid;
-	}
-	else
+	} else
 		/*
 		 * All flows should be treated as polmatch'ing an
 		 * otherwise applicable "non-labeled" policy. This
@@ -183,8 +183,7 @@ int selinux_xfrm_decode_session(struct sk_buff *skb, u32 *sid, int ckall)
 
 					if (!ckall)
 						break;
-				}
-				else if (*sid != ctx->ctx_sid)
+				} else if (*sid != ctx->ctx_sid)
 					return -EINVAL;
 			}
 		}
@@ -333,8 +332,7 @@ int selinux_xfrm_policy_clone(struct xfrm_policy *old, struct xfrm_policy *new)
 void selinux_xfrm_policy_free(struct xfrm_policy *xp)
 {
 	struct xfrm_sec_ctx *ctx = xp->security;
-	if (ctx)
-		kfree(ctx);
+	kfree(ctx);
 }
 
 /*
@@ -380,8 +378,7 @@ int selinux_xfrm_state_alloc(struct xfrm_state *x, struct xfrm_user_sec_ctx *uct
 void selinux_xfrm_state_free(struct xfrm_state *x)
 {
 	struct xfrm_sec_ctx *ctx = x->security;
-	if (ctx)
-		kfree(ctx);
+	kfree(ctx);
 }
 
  /*
-- 
1.5.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

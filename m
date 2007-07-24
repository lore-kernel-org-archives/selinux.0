Message-ID: <46A61263.2050404@trustedcs.com>
Date: Tue, 24 Jul 2007 09:53:23 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: jmorris@namei.org, sds@tycho.nsa.gov, latten@austin.ibm.com
Subject: [PATCH] selinux_xfrm_sec_ctx_alloc: null-terminate context string
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

xfrm_audit_log() expects the context string to be null-terminated
which currently doesn't happen with user-supplied contexts.

Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>
---
 security/selinux/xfrm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- selinux-2.6/security/selinux/xfrm.c	2007-07-24 09:43:23.000000000 -0500
+++ selinux-2.6/security/selinux/xfrm.c	2007-07-24 09:44:11.000000000 -0500
@@ -216,7 +216,7 @@ static int selinux_xfrm_sec_ctx_alloc(st
 		return -ENOMEM;
 
 	*ctxp = ctx = kmalloc(sizeof(*ctx) +
-			      uctx->ctx_len,
+			      uctx->ctx_len + 1,
 			      GFP_KERNEL);
 
 	if (!ctx)
@@ -229,6 +229,7 @@ static int selinux_xfrm_sec_ctx_alloc(st
 	memcpy(ctx->ctx_str,
 	       uctx+1,
 	       ctx->ctx_len);
+	ctx->ctx_str[ctx->ctx_len] = 0;
 	rc = security_context_to_sid(ctx->ctx_str,
 				     ctx->ctx_len,
 				     &ctx->ctx_sid);

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

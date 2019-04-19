Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181CFC282DD
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09F2217F9
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="EAIKsjW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfDSAsA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:48:00 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:42488 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726884AbfDSAr7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634878; bh=FJBvj914M4FDb8xtVfzNmCwZw08zuqIGVPHbHm30r/I=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=EAIKsjW28NDCgw2ixzKISqvrUeF6sDxOQK5saafqBpQfucnNxsuZ2UwLpmtwX9HotrnP0SX6XvrSJj6C4j/BBKyZD/ZgvqJARRUvYxcYueSIeY/x98xUid8HJjTLsjm97ObLMFCBUIc5TACNkMbm/ZwBa1lWYhGcv6505GA/+ldGNNXOosZz35vLxjEJZXDO0YCgm8dnZqP0/BfW0OA3VakH3wGOb671IT610OCIkAp/6eyqJgNqow0+s0WenNLKHO+n+8/oq5bL3VtW8bBpez9QXcqfcHk6ePGCv7njrL0H+5HMHQJFf8KY4svL0ecbvRx6QkAMUhUxhmAv6MVC9A==
X-YMail-OSG: jyPLGhsVM1n74IXDpYzN8G7Tk53T_iiG0KWnZrJ6XW_XzWTFgmlcGg41HqjZVZ.
 PpiK5nKB5tzwEDahWW630gTDVm1Hl_cN3fHRIHENERm8jUuB3GergwamgXCeZYoXK4lT4YdVZQHh
 0lOteGFZl0_7JyphrBrDLNI_t3kWaUfT67bST6f3rtohchzePf9tw1p_C25U8Qy59gS5v3hm53Ku
 xnPd9OuM0wqOR7642ViXq9VeKh_eecPm5BURa93QFqWAAtGtTQgZWMSrLdzbBImDoipa6PUsk4D.
 RuEeUjiZX4dyuYNrQEH0LAKyRFJEsLFIqnjbo2nBexO6D7l4e6JKJOBmPMIiKvS_F.kt2kv1yslN
 dxsfHC.PliFRqKwSUSvUp1UKr4ara9oczGhDXjVKzjkImjhVAlMrBw5VlaHKjutOUSs.0gL9r8xo
 U0KFcvd7urh4MDRkCYhwRygqy1IyiDm1EhiqG9vN8._Sf9yPPkQSkku8uFXV4Pn.i1i4Ryd3GqJE
 E66iBH563i5Lzx8Qy_9_u73jie387e2rqXJhYSxtnFgNstiIWDjLxwtpCgvYnoKhiyGrhK0Mf7mY
 HdEOn9tTs4NJdEf8tebORLevWPxRDo_aU2U4VxYcG298KiCJxs87hZ97nN_ndsJxT_bcAWHjpPpR
 rjj.jkLVrAIHs664PBKlClu7iluuGl7lXPvV4kNjGDWpdWm3TnTJ3pmEGbgVn21inuE8AGHUqoTC
 h8dm9c5z5I2snbHWQwwecBqDBu66TjblEJuHykeD7E0yX0rjN7IyF0Nl9QqqerGYWDFIJDqT5KWA
 iNzRfxYgBmu8I_fUVnbBZYZPubaYX1DiY3.n.fZ2qqJC1mry1dnSsEyvNJh75FRrCCQwHwr9V4sU
 dKhXcLkS.6T54No5faN8WJuXywj0lDuq8Ym3JCDqEgQrB_ybR8c2cbIUnlz.kM2NaE6c2q07MiKo
 GGda9sEYzRGBRUq3.7lpGB9xm9_H30tz5JWmgyuXRlCEquz1EOfE_V63WZAgL1NhcpMGxXH.Hs0z
 PcoRSB8nwwkHTM3YQ9T8VVzoF3wjAadJapyLGJiSr0SPLNYUbtE15jG6tojOB2BN7DTty8slmdSj
 jz4GyoHLN27kI1388kRm9jPVv49DELJLky8ilYABeeNnEoXc93uxmIZCLUOz1lmLGuhBkhwcBeR2
 VLzL6App_P.O5Qg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:47:58 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9312487679b1d62a89b866e0f3ee025b;
          Fri, 19 Apr 2019 00:47:55 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 40/90] LSM: Use lsm_context in inode_getsecctx hooks
Date:   Thu, 18 Apr 2019 17:45:27 -0700
Message-Id: <20190419004617.64627-41-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert SELinux and Smack to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  | 7 +++----
 security/security.c        | 9 ++++++++-
 security/selinux/hooks.c   | 6 +++---
 security/smack/smack_lsm.c | 6 +++---
 4 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 8b842fd13fb4..34ed56be82b8 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1401,12 +1401,11 @@
  *	@ctxlen contains the length of @ctx.
  *
  * @inode_getsecctx:
- *	On success, returns 0 and fills out @ctx and @ctxlen with the security
+ *	On success, returns 0 and fills out @cp with the security
  *	context for the given @inode.
  *
  *	@inode we wish to get the security context of.
- *	@ctx is a pointer in which to place the allocated security context.
- *	@ctxlen points to the place to put the length of @ctx.
+ *	@cp is a pointer in which to place the allocated security context.
  *
  * Security hooks for using the eBPF maps and programs functionalities through
  * eBPF syscalls.
@@ -1679,7 +1678,7 @@ union security_list_options {
 	void (*inode_invalidate_secctx)(struct inode *inode);
 	int (*inode_notifysecctx)(struct inode *inode, void *ctx, u32 ctxlen);
 	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
-	int (*inode_getsecctx)(struct inode *inode, void **ctx, u32 *ctxlen);
+	int (*inode_getsecctx)(struct inode *inode, struct lsm_context *cp);
 
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect)(struct sock *sock, struct sock *other,
diff --git a/security/security.c b/security/security.c
index 84f27428b62d..1c59101279ab 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2025,7 +2025,14 @@ EXPORT_SYMBOL(security_inode_setsecctx);
 
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 {
-	return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, ctx, ctxlen);
+	struct lsm_context lc = { .context = NULL, .len = 0, };
+	int rc;
+
+	rc = call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, &lc);
+
+	*ctx = (void *)lc.context;
+	*ctxlen = lc.len;
+	return rc;
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a2257ccaee5c..e881f42d3ff8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6355,14 +6355,14 @@ static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SELINUX, ctx, ctxlen, 0);
 }
 
-static int selinux_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
+static int selinux_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
 {
 	int len = 0;
 	len = selinux_inode_getsecurity(inode, XATTR_SELINUX_SUFFIX,
-						ctx, true);
+						(void **)&cp->context, true);
 	if (len < 0)
 		return len;
-	*ctxlen = len;
+	cp->len = len;
 	return 0;
 }
 #ifdef CONFIG_KEYS
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 78c01ef707eb..46eead699e1d 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4484,12 +4484,12 @@ static int smack_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SMACK, ctx, ctxlen, 0);
 }
 
-static int smack_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
+static int smack_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
 {
 	struct smack_known *skp = smk_of_inode(inode);
 
-	*ctx = skp->smk_known;
-	*ctxlen = strlen(skp->smk_known);
+	cp->context = skp->smk_known;
+	cp->len = strlen(skp->smk_known);
 	return 0;
 }
 
-- 
2.19.1


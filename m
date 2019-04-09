Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C86C10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22572082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="GbY37i3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfDIVlI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:08 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:46525
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726936AbfDIVlF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846063; bh=QBEwHL43ut+mDxdXHm9kJRs4xn/suS1Ne3uAL6B3bPo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=GbY37i3PO4MyAGEiKuEgI45qH1SiW7Al3Db6bK+5c/3djtC3Hrvp2rnsRU6Jfp3TJHDIEg5Lp0dOBOxNOd9RY/hOTxt6glqttpOs8d8AvIlEL0Nmv49dlvU03A/Exsgm0dF6OaVRyPt0yxoQDUKICa+YOtupMfmUlOzhJHkIaO573ksM7blN2nI+EIb+CUNyPBhjoN+VsfroLbUF4nI+r6xXtp2XXmq5ACCpPiYyMsqGv/B9LbyQTV3O5WcggmuDVrJj3/PJRYhrzP5rd1OqrsOsifsMG7LO634S4dRJQFIpGxsrtOV7tfgfM7LmoDV3akkJANJ0gSOdbE/hVez/PQ==
X-YMail-OSG: shsfBnsVM1nxMhRd6FbllN0SfD8XP2A40IYpaTGljnw064e_.vJKump_waCnWrg
 W7r_l915QwNKd75to3VhOmPbn95EMixcD8a7.r641lKKlTmlJEsEze2lb4YJmFvJEIEpA0PZ3f_W
 45_a7c9DhT1drALEC4HgCzqSaf0nvROoH.DRNeRL5kn03aj.KhRz0Oqintl329TNd2_MRq_Rw4E5
 cZmLQgZhrHEqYOHI0O5zGPUcJYmZtvKaEDMI1t8hNIFme6KVdPfxEkNzfgaPFCUHycc6dTyFFfWW
 3jsfVzt0uynQYd3NARLtKfPhY69xLds.MQQbLVo.sFVoswcX4A3tdQfaygo5uxWnxQBPJ.9i3ppG
 9B.7k.0a9q02P64_pEJO715dvB2howBF1zqrC_EPZNZqrKstNeB4I5xIxC.UakMVxqqhRjgebpNX
 HJ8uEKFnImI8wtSkcsi66zifvLAwygAFwSUO7iIyBZYmzxoLvWBmEcfMIZdIdIL6wI5JQrqtcOuN
 aDoxBgBcgblop_QkfakTyNGrTU5v1ieSGfPMjhFM8UQqgf6kTmOWp02Y3oHLsAH9Dw0Vjl.r2D3w
 .Wc6Ek8Xgt8zWLoYza3kHpET4_iKZkx1VWRXc9MTnelpItQ04wU2FQlsZmtV0kO9FhRA9tVgJgqf
 EwO5dzxCwWx9kxIEJaRpFc0wxx07zANiuwOtOSSdCHRI8aMcnvyjMksY0eeQ_6ZuC74950tQ9v.W
 VGu_NSPJ9vZ89j3nzwdQoaqZTOwc54kjJkZ3wE5gn799OgKewrkm8X4VwHfmAhrj1yyBQsUs_tAa
 xwID2XMGPDyUE1.W2sEHz9r2V0yxgC0ANFOmik3N_BMxuqaeNFL.5unYSKMmv2tDJGJIJ1XrBAE3
 BrHyArkgzkgYytLQ9sjV4CxQgCjyJ9ahRUr5_ZCJ1afdwRHQpj91aTsJ0ounAJTS_.Pr0IkqtOCm
 bJ_kuikiyadSFUF9Vl0lFMi9VQ60El8.g2SRtyylOVmNXPtnhHo8QSUzvtWRCsBKxuoLuqeon0et
 guehdiJWTc5hrJp4tCOiB4UFK_pOmzDJVHvueAD9QP_HA4p.g1Cgqdf4cM5RmfVcbSjOiMAZrwci
 ds77ypUr4uMkh38W5k4gZhvDWYVfvKH3qHJQWNrJvSdsE509dLmZE8LWk99E53Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:03 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp403.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0d1cdfa4e40e9d37a3e144929c04344d;
          Tue, 09 Apr 2019 21:41:01 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 41/59] LSM: Use lsm_context in inode_notifysecctx hooks
Date:   Tue,  9 Apr 2019 14:39:28 -0700
Message-Id: <20190409213946.1667-42-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert SELinux and Smack to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  | 5 ++---
 security/security.c        | 6 +++++-
 security/selinux/hooks.c   | 5 +++--
 security/smack/smack_lsm.c | 5 +++--
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 34ed56be82b8..3344d18ba9d0 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1382,8 +1382,7 @@
  *	Must be called with inode->i_mutex locked.
  *
  *	@inode we wish to set the security context of.
- *	@ctx contains the string which we wish to set in the inode.
- *	@ctxlen contains the length of @ctx.
+ *	@cp contains the string which we wish to set in the inode.
  *
  * @inode_setsecctx:
  *	Change the security context of an inode.  Updates the
@@ -1676,7 +1675,7 @@ union security_list_options {
 	void (*release_secctx)(char *secdata, u32 seclen);
 
 	void (*inode_invalidate_secctx)(struct inode *inode);
-	int (*inode_notifysecctx)(struct inode *inode, void *ctx, u32 ctxlen);
+	int (*inode_notifysecctx)(struct inode *inode, struct lsm_context *cp);
 	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
 	int (*inode_getsecctx)(struct inode *inode, struct lsm_context *cp);
 
diff --git a/security/security.c b/security/security.c
index 4625a9b00d1d..ecaabc820d87 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2028,7 +2028,11 @@ EXPORT_SYMBOL(security_inode_invalidate_secctx);
 
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
-	return call_int_hook(inode_notifysecctx, 0, inode, ctx, ctxlen);
+	struct lsm_context lc;
+
+	lc.context = ctx;
+	lc.len = ctxlen;
+	return call_int_hook(inode_notifysecctx, 0, inode, &lc);
 }
 EXPORT_SYMBOL(security_inode_notifysecctx);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e881f42d3ff8..633d62b97e90 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6339,10 +6339,11 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
 /*
  *	called with inode->i_mutex locked
  */
-static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
+static int selinux_inode_notifysecctx(struct inode *inode,
+				      struct lsm_context *cp)
 {
 	int rc = selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX,
-					   ctx, ctxlen, 0);
+					   cp->context, cp->len, 0);
 	/* Do not return error when suppressing label (SBLABEL_MNT not set). */
 	return rc == -EOPNOTSUPP ? 0 : rc;
 }
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 46eead699e1d..3d24503029e5 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4474,9 +4474,10 @@ static void smack_release_secctx(char *secdata, u32 seclen)
 {
 }
 
-static int smack_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
+static int smack_inode_notifysecctx(struct inode *inode, struct lsm_context *cp)
 {
-	return smack_inode_setsecurity(inode, XATTR_SMACK_SUFFIX, ctx, ctxlen, 0);
+	return smack_inode_setsecurity(inode, XATTR_SMACK_SUFFIX, cp->context,
+				       cp->len, 0);
 }
 
 static int smack_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
-- 
2.19.1


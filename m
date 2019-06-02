Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C122EC28CC7
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973C82794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MSpIKJ0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfFBQxn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:53:43 -0400
Received: from sonic303-27.consmr.mail.ne1.yahoo.com ([66.163.188.153]:46524
        "EHLO sonic303-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727054AbfFBQxm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494421; bh=EacMflAD5VaKL1W6672XUiEDYF8wM5Kufsvl3z4Vcto=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=MSpIKJ0nFNK/T3q/bhaxG9U/AEnOFvlxLytdB9rrdaUxtBXLMPbIgrnSTgpCFddUgw6PxkIqGs5RUNWiR87TczxxyKaGkXo/SAYLi8K92SLV3XNJmQDHSYydiU2dEM5IKTbg7p7chae6YMV0HdfzwuhEdwyXa6lHZBfv9NX3BqxBJ3gBzJZ72hVIInV0xu4S7r8pyqcXsujDcnx0eN+GiQrYnznzC9ygvOROqLbLu1F2hmBMcnTJSBspGOZOzRhtai9eo70kj+OdSUUnlRJIu2XaOH4bU2NAbCYTkI1+RKCG4LSn6Kms5bW7sl8AXA1gvrIFMsEFN6PEHN71eHkRuA==
X-YMail-OSG: ctgokzgVM1lCZ3mijAn_HOmGwCNJm6BmCv8y9Bqco6IVE9dSsXH1ZBvHst5_Wi4
 fFYV_jZffHnY0m2.Q2oYVSkbq0dOW4oaWkex9WId_DRp8aezYxySu.WCsIzv3fHvTfcErwFFXkmt
 MjgI0NS3FlevmfUC2LWpLTRtOdMDJ1MRVdYTN1taycgOt54ulItu6hIOqGFBZBw2ZKHPkb6hE2pv
 SrBBAaLugq15o5Hd1FcLxeenKJRCUAp5UNwhSWc7krMy5auh_bTZJ0Y0oCbxJ9FVKH8mibq05B67
 SCoSFrd3IaaBU0dEuLGI3ADhS9YV477GtWsBSeB0dUejzSYnls7uLKViORhDODDWOCL6F542KzQ_
 soXX2wjMR.fbNEHI75ei2LTkmnqWd5b6r0dBryHrw2noLm_luP1mEUxLIXQhUoussn9iJzp46PfU
 TnCCjCifF37ZdDsyq_C8yQF6iTxlxRg2aQc3gVnnWuYiTIBC0ls2UTidmiSj0IiSvEuHVsSfcm4c
 UzC0iUUu_fQ2eCBnY0vWsACl2rDYnPhzuxCSvR3wYKlgcoYQhhkr42g1NSVTIQPLCCFK2SgfCiTu
 KZJ0LIvldVeqof5r1IjOyXUENkK7VNDMmIHvL7F2H37f0uePA6TK0KZ3DbY5LLRhxg2nD3QTNq9P
 KElHUq7b2oTQrdPQra2iMmQ7S1UcVWCJ8d3LlOY2.eRzhm98x9rf05c4yyukwzlQAyj.Du1Vnd0f
 VqWKHoyS09ghN_tlCCNhJhktgp8c1x8OwcZbHpS.y6_noNVg_oTEjL.z98e0fs8s6nnniKEs41NV
 XITkoznkJr6ZXWbtM32iIMNg6C0yG.9lOgGNiojOoGReuKYzELM7OL3pPxjHynEKDkWwKkSL0AfJ
 56LLdeZoJMZrGTQhgsH1aavpgveTIEGHd4TP1EivG3Anto6M_nunefWNc3EHWypApCVgCiP7oStm
 F7UehSd7dKYdT9QJo1FUO.hU1DH1thblEBOrB.rrXPujutiPxck.rZuW3goi3dqmPEbIQItiZsOZ
 EHJLTTV569RIE2do6PfhQ4nPqkWQRUrnlL3z2foPA22dN5QqOZKCD6yemdoEO_9PdKk7jqq_VmVU
 DraA8cPoLIC.mFjONTUlzJu4T6CJ3cIAv5Pbk8C231TIA.hMfwzpIeS8qKfK0W5XUoOcy2vPDw75
 cfMCI56tGjdffTNu5I3CvIqcMFC6SGJ3HYTFqQJ_O76TvIkH41ECwnGXjNkAo7TfLFrTza6WzMHf
 B.2zqQz1qgvFFW2F0wMqCWob5eoYpagtPqS3WXFnAjssyU4OZ8fdgLGSO01Y-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:53:41 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp409.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 111e227deeb5369cccd8023f32784fec;
          Sun, 02 Jun 2019 16:53:36 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 40/58] LSM: Use lsm_context in inode_notifysecctx hooks
Date:   Sun,  2 Jun 2019 09:50:43 -0700
Message-Id: <20190602165101.25079-41-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 20e59e0b775f..eda0a1bcdf07 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1377,8 +1377,7 @@
  *	file's attributes to the client.
  *	Must be called with inode->i_mutex locked.
  *	@inode we wish to set the security context of.
- *	@ctx contains the string which we wish to set in the inode.
- *	@ctxlen contains the length of @ctx.
+ *	@cp contains the string which we wish to set in the inode.
  *
  * @inode_setsecctx:
  *	Change the security context of an inode.  Updates the
@@ -1668,7 +1667,7 @@ union security_list_options {
 	void (*release_secctx)(char *secdata, u32 seclen);
 
 	void (*inode_invalidate_secctx)(struct inode *inode);
-	int (*inode_notifysecctx)(struct inode *inode, void *ctx, u32 ctxlen);
+	int (*inode_notifysecctx)(struct inode *inode, struct lsm_context *cp);
 	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
 	int (*inode_getsecctx)(struct inode *inode, struct lsm_context *cp);
 
diff --git a/security/security.c b/security/security.c
index 0c23ffdd92c9..4f443dd481bd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2013,7 +2013,11 @@ EXPORT_SYMBOL(security_inode_invalidate_secctx);
 
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


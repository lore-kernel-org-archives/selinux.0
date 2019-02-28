Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A15EC10F0E
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CD920851
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Fyqao/xd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbfB1WUS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:18 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:43549
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730698AbfB1WUR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392416; bh=T4Rd37OVukqoSjsrnRppCQbrWAJC3f47UE1BP1dcfAI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Fyqao/xdUhPOhnfOSes3Ljjoged0Oe4dWb4KtgXHikQ0G+PyCPZw4R9GakQoqepwsImirFuPLRLU9jVetsFwK41+sfAdpA8bZ+Cv8HQiadHj7SSyuLbjz8hwawhPcjEBtm81GHJ+HmqeDLEhUFpePlx4tTMEfzJdtlKixutyI2Kc3N3dRbcZ4HjGbKnB96SwMJ8ox7BjHJENbA98B8RePRmnXVcSKTCdwhXlLGJrq+f85rJcw6Iq5Fu4qy9YCE1MaYH3/4zTT2KQGo1OK2Ki3Oqm7+StCPMVLbet4lBI3q/Gq39f7qW8QfNcQjbRUhXmr4rjuko3MP5XESVLLN46CQ==
X-YMail-OSG: pNmnmgUVM1ktdwxX1cTMfXZd60pX6_dwfLMRyYiI3O1eZ00IjmFm1HOHQB7UCkj
 u1YRYdQisnEK.8HlQ3.peUc4vHVBukt5S7.ZuG4B9gr.tNfMUtZgTjLrCmoBxuk7q9hRrM4ogUq8
 dRnqiQRJDPaVhRIPX9Pj7dNLCPCRl4GrG.WlbC2d9bhdKqB0oXIIJOn9eXlM6Ef2FvxOmwNRAK5t
 Gclik2Mt5MBVZ2uWtgEMXGuxUEwrl5N4MrXvtNIdkgzCbBUJnX0rN1OuoKnTC0Ecbqs1Mqlf_933
 SiKdmlU.jBUGxl3x8YSYB7yYv_8lM285HiLWpjfVMsCogfLeMSS68lThF2k66z8Zmcm4YXQB2gBi
 rhPmZkPC1mK4DSdOBZ.ovPCX3gTq6ge4vxh.75eeCmLt3uu0mmg.DxbhCHeBWxB7J0aYErKdsC9J
 81JGAQrD4dw1AIr5jU6V2Ihl0PgAWAzwI4Qxm91UnYLZbLW9bVA9feRLqi7SResqyY012QRxQKc2
 zUpJHZm7GD_QGnq5rssXhHPOLVoy1.v18EYJJ2NnCrRfS5JGKa4mP49zdvQQNE0ABepkF_vUVHle
 XuKdDVBr_fShfXeCD.8wSOOZn5DZrB89KJPmujbLaZ89Hfnh5nO543RhKvuPnY_1FeqazoljbeXT
 0aRJUxMPH5V1K1O0fpXuxC.0_vbX4JKu8Cq5z..ISx7MG_NSILpCAixz58OL.SBtgOgrqqoq3usq
 B40lSoYml8N0.zeDdNkoJPYPCWGMeVeaSPYZX9nDAdhe8N9LxV4yVyjF0ClecBCq9UXcCY5W6zNp
 WsEBcRj3LgZ9Shvtzkys90wZeCM4GH7UBb1em29l7HYeKSLdHLdS78L3__ExBUrg2pqwdQGOxNYG
 q3s1Oq_TqMOvfrIQOITTkSkRm9zqEN2PG44ohC4WhocIJw8ou23cMoFwdDxb.CUA5ZXLSa9mqAU_
 .pXVSEIJvBG2PQ_A9Ui0rz4Q2lXBcp7uyTbXCsbro5OI4kNmJzpscq9G850loeTaZMg4_OFSVATy
 cRczxgdxuw2byc39srN2aTVrTCW8caQyQHneqM9iLbvfrhQVjG3SoJmEKFTDBed02aYI5_mv7L4x
 s55YFxIbGs.JHHifTcDvg5JPX7gKSuoCUgvcwS6.UHffID7Y-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:16 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e588ca5e0935b1286f019b02cb065c6f;
          Thu, 28 Feb 2019 22:20:12 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 47/97] LSM: Use lsm_context in inode_notifysecctx hooks
Date:   Thu, 28 Feb 2019 14:18:43 -0800
Message-Id: <20190228221933.2551-48-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
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
 security/selinux/hooks.c   | 6 ++++--
 security/smack/smack_lsm.c | 5 +++--
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 713378bdd69a..a7a68be7e507 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1367,8 +1367,7 @@
  *	Must be called with inode->i_mutex locked.
  *
  *	@inode we wish to set the security context of.
- *	@ctx contains the string which we wish to set in the inode.
- *	@ctxlen contains the length of @ctx.
+ *	@cp contains the string which we wish to set in the inode.
  *
  * @inode_setsecctx:
  *	Change the security context of an inode.  Updates the
@@ -1658,7 +1657,7 @@ union security_list_options {
 	void (*release_secctx)(char *secdata, u32 seclen);
 
 	void (*inode_invalidate_secctx)(struct inode *inode);
-	int (*inode_notifysecctx)(struct inode *inode, void *ctx, u32 ctxlen);
+	int (*inode_notifysecctx)(struct inode *inode, struct lsm_context *cp);
 	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
 	int (*inode_getsecctx)(struct inode *inode, struct lsm_context *cp);
 
diff --git a/security/security.c b/security/security.c
index b2aa50a583c7..a0c4ae7da840 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2014,7 +2014,11 @@ EXPORT_SYMBOL(security_inode_invalidate_secctx);
 
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
index a67b8a3e6b9c..33e58efe59ce 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6232,9 +6232,11 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
 /*
  *	called with inode->i_mutex locked
  */
-static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
+static int selinux_inode_notifysecctx(struct inode *inode,
+				      struct lsm_context *cp)
 {
-	return selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);
+	return selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX,
+						cp->context, cp->len, 0);
 }
 
 /*
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index b3d4410696a6..26cf42ddba0e 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4389,9 +4389,10 @@ static void smack_release_secctx(char *secdata, u32 seclen)
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
2.17.0


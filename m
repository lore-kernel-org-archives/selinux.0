Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BCEC282DF
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7786A217F9
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="r5bHEgFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfDSAsA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:48:00 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:45023 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726910AbfDSAr7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634878; bh=+UV/tngJ9xERucMty0k3xAUXL9ia8S6enLrSOwE4aM0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=r5bHEgFJzpJLUTQanL6Iz49vTEmX0Dl2y/1drJXH8iSwvaU1a6O60M8i+LPgSSummYEQ0do2GF+CilRm7fbzqCf3nXuYFFLNTLYO8hg7tvAXXHwzAu8KB4D1JgnuSPAsuJEw+BLZJChZ32GY91bkJ/Ua3BZj3GNvDUuDOjNL53rrn5+6XD8j4f4qMvLh85pKTVppm4zKsoP2ja3HSnb+b/rXOWt7rTUrFGUl+bhEF9J+6tZhpGs78ev2htHyAk6aJDq3aE5Wn77E84F3HZTs32iwb0PHNEoRdfuwypFxE77F/r0fRlxkDSh3ms43YORDoMRzW0rcmEue4Wo96rVuKg==
X-YMail-OSG: 4LtKv9UVM1mc_LMT9xrP4O23d3Eaj9z39um4y.USn9lawwWkWOD77TBd4AD80IS
 S6cYD6gIBqv5wVMv8Iser1v86IFyf8iYMKwm2CP4Ia9DtsugP.fkNDGyvYKBfFoychPHro1rAESd
 BKMy91oht8CsoU3JiDcW0zQTKrCwWt.aJ4keLWOm70WxbVqksugOB1U4wG5xy4HVnCl8NgBuPoap
 uWEe6B4n0SnkfenEpfAPMfTKTXeOAEUm5d16y1w8E4u5AHhztmnVjeQqoz1gGYv5en5oEhcSEVbY
 1nV0PUp.TYgmNeBxe2lAfXOi5Dy80jPRN4xVd78E6KVw2aQWfJEI3tEOIhfjXvZlVoPd2pAjHnb9
 mRbNHcVxzZCr8R5DprUzG93aWKF0w12P33wIc9yaZPwzg7oHcVm_D_v8QqdkFmll_RjiwhKkofa1
 PZdXAbpVsklQ.PuglizGUHXXkWGlygoS_7RO7fnRKqPpXyhHbf6t_M5Mw0aEhofjrRbjkNcFrxdU
 K8fEr13ntyZTSvwEDv9oeSuLRexJIgLdYOFZY3g0RJvSiFGZTEp_Qma_2jMLcAtXDisiU.Wy7No8
 fqKc14GEaCmJjTNtvC8gI7NyxOI.GCAcANy.Od4H_VIjbNQ46FEVqjr5ppZ3v1Dg40IWdFIhj1iq
 oAPxahzh6hmw_yryjKJ7sA5R9tvr6f4GgF5Vj3UBhJoR7PsY5aNZyDyt5pGfQ0vAB7MVgY71iafz
 LBdoTo46jUB_Dju7EZao.7iIr4GLyshUGbRwfbYz6BqHS5srUMa_dV2UoTYe0mCBENo.0I2RrEIb
 UnuXk51qW8hEcOwpCXb_CWA728xiToGEkZEIsvzR_p.DhGwMFDzo7L.dtip6FYPFxEishQ8XxxEI
 GRo0P.oa2uUyalMFkcHKiXeItn5f8KXCjGOuHCRHHqujiZIzQrtPRpQdhFTfdpbaiAFWrEcWVKKO
 SpU7RbzcFbsWNxD0BVClo87xGtSlQgHhVdg9CYJZj9ICmEUJNDdFIzBhZXPhMYCNIHlxjodlQUD1
 8PkPqHp3ydcWzikZOab4SYiKi9IxMYoOLv6pbrrUOD4qe1xmGhGlQRzZzPow2BYX8R7rqErbCr8m
 hInYf1C9Zm5_GIU9Im48tO.ybyIWTUA4gacbJOwJXCyTfd4vT4orbtCaI9UEnUHQDfxMP8VwwFg7
 HK4Zz039IvxPIpQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:47:58 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9312487679b1d62a89b866e0f3ee025b;
          Fri, 19 Apr 2019 00:47:56 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 41/90] LSM: Use lsm_context in inode_notifysecctx hooks
Date:   Thu, 18 Apr 2019 17:45:28 -0700
Message-Id: <20190419004617.64627-42-casey@schaufler-ca.com>
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
index 1c59101279ab..5ee80bef9643 100644
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


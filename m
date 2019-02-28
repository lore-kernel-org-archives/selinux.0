Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA4BC4360F
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B951920851
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="GMtobKzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbfB1WUh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:37 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:39450
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731398AbfB1WUW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392420; bh=LnmnhsasaI77ks/RQLogGGlvRpQnpCWHTy6G0cAXoWY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=GMtobKzW9Mf8YY++IBeQqfdUA/bhT26mERqH0fHwpJ4e/judRLfA6r1qaSSgmXy4ZWArf4/ps0j93FJFJhVfClaDkHx7HEkVis6Q00x86QYufQIZIlMldKQSVOjahFSkgLRpY21rakcVUj9RS4Cx2zxZkj5QxDx091zGH/1ZoB1w04V6isD4YIHBnAsmGTQamsmlFYwBh14k8NIQGS7XebPVpGHtZq1IOrDY3sNPrOFfMNKvpd6RLXNofbxrEK21nK+pEO2K5WYv44De/T2+EAzT8FPdIwpNLQVyknwLZOLiW9qGjavmGAgfWhB07ISIB4swZ5XLmdSGsVq5X4AVxg==
X-YMail-OSG: NUsE1NkVM1mNPFLz8updKprpNn.ltT7YRPHotJEWOLGtfxWRZyx2Y0DJW0yghum
 aZ1UxNAOWC_TuVoTQ6x8blZZnPFMvOc2lVoGUQm5i2WQZGnABHcZbxPfj2hgCzjERH4ouQmngJIf
 rJ.yJJ9Jt5FgopgGeY74GDS.XuAsFlbQw1yc6OqsOQSvCDPVN9PKyT.7AL2qnd1lC6dPZefGhwG9
 .M27UUOI_RTq7Rdoi4XhEK3K00RzJJrrtV4bj9hib9oUNnpSwC5LM8J2WT.JiwKCxsRVWiMzTN5f
 hapEPseCFLEkO_xeZk0i9bGrqrOVQyYYA7F0PEtaSDlWr_YriN_Th0wydPCivajK7gvWcRx_Gq24
 VJubk.ka8xZzo5dIIPWYpjvPX8eueGMK1IcnxmFY8ZpJonro.AXE_diflryZ18WEAPStwvMxwlmy
 Bm9KXDw55AjQ.VZcdw9PTVd_VJIyyODucvbeHoPlFAS8U6IYzW6UHBQc3XKdtZ_OxQQIO.uAidvM
 jhOC4bcyBNCW7koqGjsK5MbRXcMIk8Z50Xg762GcZHFtzK24ryQkvf0893HnvLz4Fyh1nuz2FSR6
 g0qZtQY4TgI1sQUs1rwSsmRi0EECcvmfO2S8kUhSVwqvG_dcFRlZv0w9HtFqp8bUirUlF_i32ZI3
 tQ1VerNm_HztYJxfC.AKBxFCCMfW3I8CjeLQitXMaDvegC6YA3NNlbWZYrOXdrTjKjMJhUmQLnDU
 mm2S2mZ6bflDfQivbNOqXo2OVsejNDe0RA2MAMKdFEmW534eM_RK1TQN4tqi9bcqHSz22wYLVc84
 yBvuR67GdCYSd0ag.aOGAU0Arf_6tvL76i8rTyJsRwy1W1gQdD5DxGZTWpnYGEw6LDmSJBjPgqcj
 mj6VT.xaNNdM_2Jlg7LXAKcqSKAy5wGrqg806.qYGlLBzY63S9QOx1iEOjlcTQ_dVVfrofjR3fyc
 E.ONliyM_MCoGscSuapdcXOxoxGuPZFcJAizqTNXvD7.S4XjWVQNCQahBP1NvspzVHN8j90bSR7O
 g12mgRb3iTgn4lBTqpzeIYWNGlev8dqarvJ1aNH4sOuoY82TAe5sxFFQmTK5o_uUi_LcX05vNEXw
 .6XJSYUKQCU89I3SUJIa8bL0HQnyPa0PLN1na8SLh8FI.2wE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:20 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp423.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 51882fbcdd41d0138ebd23ca73a62b12;
          Thu, 28 Feb 2019 22:20:19 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 58/97] LSM: Use lsm_context in inode_setsecctx hooks
Date:   Thu, 28 Feb 2019 14:18:54 -0800
Message-Id: <20190228221933.2551-59-casey@schaufler-ca.com>
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
index 349d7c28147a..84035aea5a2e 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1375,8 +1375,7 @@
  *	Must be called with inode->i_mutex locked.
  *
  *	@dentry contains the inode we wish to set the security context of.
- *	@ctx contains the string which we wish to set in the inode.
- *	@ctxlen contains the length of @ctx.
+ *	@cp contains the string which we wish to set in the inode.
  *
  * @inode_getsecctx:
  *	On success, returns 0 and fills out @cp with the security
@@ -1651,7 +1650,7 @@ union security_list_options {
 
 	void (*inode_invalidate_secctx)(struct inode *inode);
 	int (*inode_notifysecctx)(struct inode *inode, struct lsm_context *cp);
-	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
+	int (*inode_setsecctx)(struct dentry *dentry, struct lsm_context *cp);
 	int (*inode_getsecctx)(struct inode *inode, struct lsm_context *cp);
 
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/security/security.c b/security/security.c
index a49095112416..42c5467ccedc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2009,7 +2009,11 @@ EXPORT_SYMBOL(security_inode_notifysecctx);
 
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
-	return call_int_hook(inode_setsecctx, 0, dentry, ctx, ctxlen);
+	struct lsm_context lc;
+
+	lc.context = ctx;
+	lc.len = ctxlen;
+	return call_int_hook(inode_setsecctx, 0, dentry, &lc);
 }
 EXPORT_SYMBOL(security_inode_setsecctx);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8ecdf975c53d..f58c96e2b6c1 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6247,9 +6247,11 @@ static int selinux_inode_notifysecctx(struct inode *inode,
 /*
  *	called with inode->i_mutex locked
  */
-static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
+static int selinux_inode_setsecctx(struct dentry *dentry,
+				   struct lsm_context *cp)
 {
-	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SELINUX, ctx, ctxlen, 0);
+	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SELINUX, cp->context,
+				     cp->len, 0);
 }
 
 static int selinux_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 4fcd8271ca24..d3ec5f49ef44 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4395,9 +4395,10 @@ static int smack_inode_notifysecctx(struct inode *inode, struct lsm_context *cp)
 				       cp->len, 0);
 }
 
-static int smack_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
+static int smack_inode_setsecctx(struct dentry *dentry, struct lsm_context *cp)
 {
-	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SMACK, ctx, ctxlen, 0);
+	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SMACK, cp->context,
+				     cp->len, 0);
 }
 
 static int smack_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
-- 
2.17.0


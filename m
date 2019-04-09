Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C021EC282E0
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E95E2082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="U7q9nuKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfDIVlW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:22 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:41377
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726572AbfDIVlV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846079; bh=OWoo7vTJwcNQK6ycCy7jbnovWFk2r1PEz4nld5sP+to=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=U7q9nuKPKN4junGR3B0vJnTLIIjpcqG9KvmQ3ns6gQbepA4VDkhrkHieUbFIdpJ2pJXmqHeL/LTRGnHuSGEY4qDk4qKgrvvuVO1d2RhBAV9YSjiMqEwB5/tn7GX5TP7YwF/A7sjx9kjX1yW0fLxmQqjkpq9Uek/VNRKmRaRLXAQzB4QY2PkMzVkYC0iyRPWP8qkOfTGy+XGfcw8ayyuDrJ+2BzqWIQJ3gWqAQR1S98Ga1xc8EyggkDHmdzbFX4VBlcB3tzcgKqKiE50mxbEzvhF46iLyNjwTOmoyzLO3OfhAA16acDJOcurEGqwev3QNIPFkeTFQrS7gd7i5po6QDw==
X-YMail-OSG: 3Pvm_1AVM1mCPR9xZsyDJMjvAFwYi6rpHdIq5Gn3wXQkFCCiQXkd_3iZtIUcVNI
 UA8L9PqB7W7aLe78FD96yLUH1jNEWuoPjlSvQVJgdDx8WlPA6DzgVwtGHZpk4fn2dMU7d_8OaHSp
 8yt_c13ctjgJxgFIG9gqSA79gy_hfQXZk6gWQL17tyZVU37A74E65gynUhFlMYdEUMTPZw8K.g8I
 nCCLZpiX.wsEf3x37yr1EVB8jQv2xIAykAk7Na_dIS_ISOlTVmnw4B5ADvGTfFWZObuVITC63_gq
 F5JvVWqjX0lLcQVJAHE0dwy_BSGSCUiuvcjjLcz3XgNcTiZ5MybPVsmowqLUngOsYtSU_mJqkU7U
 jYybV7lqjMUEu4OkA6wE73HAdnNt5Yx7qtfKBunoh.3AnRR3.lUzKxYI..lpaZVDQA1K4.EQuy35
 2adyvE29sBBCu9mjuQiN5NDVTEhkQ8OCvqbpi6SORauyghZd0KZDKcVSbPAKhdaApxVf0icSN8vb
 3zZLzYrN0ABvjaNWGw9Rwk1Xh0ShSLJV1uBXGShXFLTTdErPNeAmuwpR5CBONbPn8hBdXO3lvgxF
 8K_FxFtHKpCTVUefctYQbBQQ5YGoGMOZy.13MI6V.ToFiksCpOyak9CY0_U5Pnr5mwxQbtpiySyC
 8PDVMSSxu4bzourfAC2nVuGMA7FHC1TQi9jbT2r5p_xRhw5OE1DZCAEM5Uj4zBOU0kQ_556hw8NS
 yu2zaw4dTiW.k9.Rvvxn4lC9WayeHWxyFU4z6vFOr3kVlU1zIleDks55DoY4hYRuRjC7RJlR4zSA
 MLs48G1uEUp3yp2uzFg.Tfb0QU4ix7tvNPg621cMAJLdStvSH38Gam4K4ZxqPQ1w6h_zKsnk96dQ
 4irfrlEcKI0bpeKZLMiaYiHonkpnpffXl_N3xQNEIZogw8ctJ47NswMuv8UbGo6VijqpFr5_pZIj
 DVv5BMtcxziyWtw.QF72OoIhk9XXtEGu5TkSZhsxWJUOPO57cnb9tm5BFTlsqwU4iN5xr6hFxqC0
 5nkQFIi13ZFvivXNapuT9X2OK8IoE2Kowj2XIiOf2lCfk_P9p_aMdvFSZ33H9MugZqTP4CJTI3Ww
 0Pt4yjxI6SHLaggus4t6wYnXwxh2T_ha8DsVp_G4Lh8eJ_v5UBf.Bc23U3iyKcw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:19 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp424.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ef161db9af8fc10234759f56f4c7a0ea;
          Tue, 09 Apr 2019 21:41:19 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 52/59] LSM: Use lsm_context in inode_setsecctx hooks
Date:   Tue,  9 Apr 2019 14:39:39 -0700
Message-Id: <20190409213946.1667-53-casey@schaufler-ca.com>
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
 security/selinux/hooks.c   | 6 ++++--
 security/smack/smack_lsm.c | 5 +++--
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 1d364e211639..014791349bbd 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1390,8 +1390,7 @@
  *	Must be called with inode->i_mutex locked.
  *
  *	@dentry contains the inode we wish to set the security context of.
- *	@ctx contains the string which we wish to set in the inode.
- *	@ctxlen contains the length of @ctx.
+ *	@cp contains the string which we wish to set in the inode.
  *
  * @inode_getsecctx:
  *	On success, returns 0 and fills out @cp with the security
@@ -1669,7 +1668,7 @@ union security_list_options {
 
 	void (*inode_invalidate_secctx)(struct inode *inode);
 	int (*inode_notifysecctx)(struct inode *inode, struct lsm_context *cp);
-	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
+	int (*inode_setsecctx)(struct dentry *dentry, struct lsm_context *cp);
 	int (*inode_getsecctx)(struct inode *inode, struct lsm_context *cp);
 
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/security/security.c b/security/security.c
index 8bb1be7f2b85..36a7034d1f91 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2023,7 +2023,11 @@ EXPORT_SYMBOL(security_inode_notifysecctx);
 
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
index 0e347a26c3d8..af0d98f4dd37 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6356,9 +6356,11 @@ static int selinux_inode_notifysecctx(struct inode *inode,
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
index e00346799cdf..4570e8cac1b3 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4480,9 +4480,10 @@ static int smack_inode_notifysecctx(struct inode *inode, struct lsm_context *cp)
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
2.19.1


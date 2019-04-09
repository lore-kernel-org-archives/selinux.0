Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D6BC10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB68F20820
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VNZzf7du"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfDITTc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:32 -0400
Received: from sonic313-26.consmr.mail.gq1.yahoo.com ([98.137.65.89]:37378
        "EHLO sonic313-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726917AbfDITTb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837570; bh=BkiVgWxV8LugM7dQFM0z6uB/OZ9M/gQ3t5pE0/A8yGY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=VNZzf7duptRaa7JcvpilXuiXsGDbs8wUmoHmmEfgr6DSUKKlnDz4En+46LguosW0FxgCigcYK2/UEUx1gEuRkBBKQfknQ1bysUFt/H2Eb4de+n7aqlS09BL8v90ZyJuaCjqoOkBqJ3UG0xwgHtad4Jo8TyT8kM1fJo0WInrsO2VeWGR6wY4EkbW0Bmr+xEw2u895fuJTLBwS+ltm1Fld4rcH7cjbenHHeVqlhhcnkQg8v0fBJ0ZaqOTysUUrLmy2rZxRbxwYgVnHHddc7mYx69s5Jjc1WK/L8d+LdjoZEIJgvNdnltK9HDtAaInWKfGWI7cROdEfvjDbooOs/vEK+w==
X-YMail-OSG: wSnXHm4VM1mHR_R8BZfO4mfhQ9Dh6SiasFIuKBTOYSQnoVbKDWDd2IYcTgTdpRR
 UX8of67bWMJmAiAcIEMgvmf78Lpug7BgskoXeX4Aqf7vv4vwuiGUPKcwKtOvtry5o7J2xzd6oXJ_
 ZKRR1HhxO9toBLg5Uc8SbGj0LFC6z_OO3O4HxyZ0V4Cpm1elvQOl3yCMtntyNiuvCOTloj8mfj6t
 aVtEzavzkeSYAopVY3mVbv_15b3crvut9JJiEra9nxcTAT3tK1NAwd7SzMqt64v5xUTzouZSpjXk
 alCn7pOSx4n4dsZoF2NxN4XR.cLlxZmNsaDSNKQxcT9QjBFWoXa2KRxvUSnTtghZDV8OsAD6ipFg
 h4TZ3vtMByliQ4uBAqzB7ikhigukiNAAiAWPLXJt4MrcOLuleM.kvSVxJWUCsaD2pRibi6L0dV45
 68hDJjELesFuPCeRSwzZNLPhuwJASIFAnVPhOL04wsLKROXQtN7rat23pQ8569SxWlzx3ICwwPwi
 foS9qqQAiJD6dd50b9wQ40zQKUPf30sNs.RjsIdzgg_ADodo8vgyY.zT8JcFTbWMjgXjc9bkLi9G
 NetZwc3cJmLr3NIDgQvcIZAkxl7TPN_I2qXCeWRR4jAhS9XalylKBrUmAwHBNF6_uI_Wmek35TFV
 9FwZbI4Nq_9WtqslJSn8Z14rIzaBjDrlFlgxHhlKHbUejbRC5T_m5_JXaAPOtXOkFaidXnKIjd5c
 4iEQXYFhJ5HyDj5SHuWlGN3WRmH2g..QVDDlQD5MqAd1rE0W9CGmwiRouZuJBKzpGjjHlgDp61ge
 Eid9TVU4gshKZ_IN1rPHqUyixYKCEUSWpEWjLOcLFjvssHlFV19FBOtsTLM6uW0wqNb4juJWV6kS
 j_z7rJwYzL611spMTLH_ZnxXWhawLdFAXCEPoExQyg2nKo1RB23nCcYYr3iAkFo.XRoyrldEBbHk
 sLA7FrJw.EG4ITVmmMM4gosmbZIAh5bM.._FgYIxVJgI5EO5iIavWu4OqHQidA_JsTnBzI_UCNHO
 8rup0ugqUrtWccK6jjd186FMaWyQwbMq6sy2psHDvN4gzvHmaf.nF4K1vTnfN.QEn7aeFaGuOCaK
 n8zOqI0jr1R_raqnS9gZ5XLbZaKoEb.tV.quL3F3_o0Ba9_GJKqyY_dVDBA4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:30 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 92df6dee4d3144b341710b3f28d23ef8;
          Tue, 09 Apr 2019 19:19:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 44/59] LSM: Use lsm_context in security_inode_notifysecctx
Date:   Tue,  9 Apr 2019 12:18:33 -0700
Message-Id: <20190409191848.1380-45-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert security_inode_notifysecctx to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/kernfs/inode.c        | 6 ++++--
 fs/nfs/inode.c           | 6 ++++--
 include/linux/security.h | 5 +++--
 security/security.c      | 8 ++------
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 0c1fd945ce42..460e611b1938 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -184,6 +184,7 @@ static inline void set_inode_attr(struct inode *inode, struct iattr *iattr)
 static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
 {
 	struct kernfs_iattrs *attrs = kn->iattr;
+	struct lsm_context lc;	/* Scaffolding -Casey */
 
 	inode->i_mode = kn->mode;
 	if (attrs) {
@@ -192,8 +193,9 @@ static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
 		 * persistent copy in kernfs_node.
 		 */
 		set_inode_attr(inode, &attrs->ia_iattr);
-		security_inode_notifysecctx(inode, attrs->ia_secdata,
-					    attrs->ia_secdata_len);
+		lc.context = attrs->ia_secdata;
+		lc.len = attrs->ia_secdata_len;
+		security_inode_notifysecctx(inode, &lc);
 	}
 
 	if (kernfs_type(kn) == KERNFS_DIR)
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 414a90d48493..8d0be9767b14 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -340,14 +340,16 @@ static void nfs_clear_label_invalid(struct inode *inode)
 void nfs_setsecurity(struct inode *inode, struct nfs_fattr *fattr,
 					struct nfs4_label *label)
 {
+	struct lsm_context lc;	/* Scaffolding -Casey */
 	int error;
 
 	if (label == NULL)
 		return;
 
 	if ((fattr->valid & NFS_ATTR_FATTR_V4_SECURITY_LABEL) && inode->i_security) {
-		error = security_inode_notifysecctx(inode, label->label,
-				label->len);
+		lc.context = label->label;
+		lc.len = label->len;
+		error = security_inode_notifysecctx(inode, &lc);
 		if (error)
 			printk(KERN_ERR "%s() %s %d "
 					"security_inode_notifysecctx() %d\n",
diff --git a/include/linux/security.h b/include/linux/security.h
index ba9bcdbfaebe..2abbaf72779e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -439,7 +439,7 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
 void security_release_secctx(char *secdata, u32 seclen);
 
 void security_inode_invalidate_secctx(struct inode *inode);
-int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
+int security_inode_notifysecctx(struct inode *inode, struct lsm_context *cp);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 #else /* CONFIG_SECURITY */
@@ -1234,7 +1234,8 @@ static inline void security_inode_invalidate_secctx(struct inode *inode)
 {
 }
 
-static inline int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
+static inline int security_inode_notifysecctx(struct inode *inode,
+					      struct lsm_context *cp);
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index 7069ff857f58..f5e332bfcdbe 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2026,13 +2026,9 @@ void security_inode_invalidate_secctx(struct inode *inode)
 }
 EXPORT_SYMBOL(security_inode_invalidate_secctx);
 
-int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
+int security_inode_notifysecctx(struct inode *inode, struct lsm_context *cp)
 {
-	struct lsm_context lc;
-
-	lc.context = ctx;
-	lc.len = ctxlen;
-	return call_int_hook(inode_notifysecctx, 0, inode, &lc);
+	return call_int_hook(inode_notifysecctx, 0, inode, cp);
 }
 EXPORT_SYMBOL(security_inode_notifysecctx);
 
-- 
2.19.1


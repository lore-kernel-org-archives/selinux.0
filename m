Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95850C282DC
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3342794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ROewHKjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfFBQxm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:53:42 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:46271
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727040AbfFBQxm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494420; bh=GL92BlbATLhdlRxbERwtGOiRrC+zdGB2SpJVUW1Y7c8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ROewHKjF7dSA+7c8pDE+v2Uii00aJwYBUUDxiybmKf5VHdG8ADbiP57thOs5aQf04Ygi5Qx0zSqp5orKv3Bsqxy/ha8OILRj7HCJPrOPLFiwag0UZw3dEX0+I+D3r0pcCCx/aW0H9BUioWvpjF9zmOGba+Ty75eWEX/SIdt9JnchWUiGb9Y0hX9lW9yQ3orOAqpHeCfozyWohJrxHNJjmZ0UO42hF26Oinspsp/4PM4F047C9PSSQpqYfoTXcOo1LX6Oi7KQfWNyE/ep6ZOs+IgTrWR3KYkhvWZyV9JcBKi0KMPDpdXatIUkXIuH/xJ6J7PV1NfalEkl55zWLWp5PA==
X-YMail-OSG: MEWQWqEVM1n5K_318_JHQDIkQL3YaGtljQWREA2K406VTdhnv6QVdYR1tjDcQ5R
 RbKQGCIvs2UppcRqtZ6ela9TvnQPtRkdBsE_0QsksYsNR9ls4KdljTWn_D_RzR7x6u0Mj1BIvJ3v
 3nyvYyWCJHTNZ3raB.aNB4xUqn7n1mS.Vhbh8Mp7DNAriSikl0EAVWdUgeOf_HUVDMjYSn_6WrTf
 6vuyN8fCJicjak86ZUnqMqzNTQarlabql28ze2mbvhPZKHdvgitBCXEB643QeaTbm_uLQA6AJjdv
 bFzhTxkM8UQ.3bna8tpDen.PAKL_VJqtBAmrHaj0b.oY2atrOB6NyXs7q9IHcPjKPhUUqQON_D6u
 eeC0HvtAvzNVSCrFXNU1jzsu0ffbMYTpxzotWBYXLD3h4E6JeDPaQfkFhpnZrDZ8HGjzOBRoKK7J
 0Z9Q.MIONLMUNJXlZSjlcgDKknnWc0qZpQWH_awdmdvWod4TyzknPhsN18uHpTZMyVZNxcaUsx0f
 cMgJftj9vmfFyzJti3SlO0XJJVXUfZVmYYixzwYuBAVi2Uwixq_EJRkT_DQlOwmJgsbrcgyIy04m
 ctG33R6Llqwd7esBdIHESvEzeU4elogOHyg3Ra0LbVmGic2kFELlijuGqkpyH3Qcl2Hfmj5RJ6pg
 zlo6aLMS_rT0vC5ly5Mlo82kfAPVpIdDDeSpTGdLqu6CNGiWYK5d8QeOs8wOJhMYJE9O6ARmFDnP
 OCxrhGTL7rXfu6Y3_48rUsDGuhX0DkNAXkPfvCF_uRV0JQ6.57uVA0Pd..0Md2wGSAL14_sTsW3v
 ZgrPrfAi83lQG5XGgLLUi_dpsm9OyCJlnz6XX_ieolYe.kqIcmDE1hrNfIUi9i9kxwZODEFqeB2x
 AA_dCIrPhVOPGghcgyZx9_5Cb0MhbyoC63Ul8WOdSejfY1fBNDj3e06qU5uZGqYzs9iHCpvmz3WI
 2V4NpStDGJM7F1doGNqEeRH7DqtUoat8f1UMvu.lDe0PB9ZWF8NQMnKyxxC8_KnkFDNFYnqbkRuK
 rQKX1MnwCupiDi2QUlasV.AKyVDY6rN9qLxr2tio6B.bAEeRUqAHubi6txuOgrZrQFlqQ4B8LlIr
 2Vu.2Xi6wnLVNO_.8LOE7dYpAmbSUmNKyl7riGIq.HVrj4dEi1EwuO9iiM7gPWUct4oOdzqX.Ye9
 ypv84mKM2O.sqgMKMnEpuiJgfyOIBJeSKAU1edG11U9JphPqHxYhOMXBVz3oCkoQdUKW98Bq8IQW
 _d9PydYzgq2Au0hFSkfp4IYrvgFE.oJZMwYdm..rVXYH7otaXk5cAsiuXP2A-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:53:40 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp409.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 111e227deeb5369cccd8023f32784fec;
          Sun, 02 Jun 2019 16:53:38 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 42/58] LSM: Use lsm_context in security_dentry_init_security
Date:   Sun,  2 Jun 2019 09:50:45 -0700
Message-Id: <20190602165101.25079-43-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Casey Schaufler <cschaufler@schaufler-ca.com>

Convert security_dentry_init_security to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/nfs/nfs4proc.c        |  5 ++++-
 include/linux/security.h |  7 +++----
 security/security.c      | 14 ++++----------
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 4dbb0ee23432..de000649f9f3 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -113,6 +113,7 @@ static inline struct nfs4_label *
 nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 	struct iattr *sattr, struct nfs4_label *label)
 {
+	struct lsm_context lc; /* Scaffolding -Casey */
 	int err;
 
 	if (label == NULL)
@@ -122,7 +123,9 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 		return NULL;
 
 	err = security_dentry_init_security(dentry, sattr->ia_mode,
-				&dentry->d_name, (void **)&label->label, &label->len);
+					    &dentry->d_name, &lc);
+	label->label = lc.context;
+	label->len = lc.len;
 	if (err == 0)
 		return label;
 
diff --git a/include/linux/security.h b/include/linux/security.h
index e12b169deed6..6c3a74a44a59 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -302,8 +302,8 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 int security_add_mnt_opt(const char *option, const char *val,
 				int len, void **mnt_opts);
 int security_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen);
+					const struct qstr *name,
+					struct lsm_context *cp);
 int security_dentry_create_files_as(struct dentry *dentry, int mode,
 					struct qstr *name,
 					const struct cred *old,
@@ -674,8 +674,7 @@ static inline void security_inode_free(struct inode *inode)
 static inline int security_dentry_init_security(struct dentry *dentry,
 						 int mode,
 						 const struct qstr *name,
-						 void **ctx,
-						 u32 *ctxlen)
+						 struct lsm_context *cp)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index c04b334370a5..628287180ce7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1014,17 +1014,11 @@ void security_inode_free(struct inode *inode)
 }
 
 int security_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen)
+					const struct qstr *name,
+					struct lsm_context *cp)
 {
-	struct lsm_context lc = { .context = NULL, .len = 0, };
-	int rc;
-
-	rc = call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
-				name, &lc);
-	*ctx = (void *)lc.context;
-	*ctxlen = lc.len;
-	return rc;
+	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
+			     name, cp);
 }
 EXPORT_SYMBOL(security_dentry_init_security);
 
-- 
2.19.1


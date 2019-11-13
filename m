Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1C1C43215
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 17:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511F4206CB
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 17:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jmbpU2oX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfKMR64 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:58:56 -0500
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:41045
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728105AbfKMR6z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 12:58:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573667934; bh=5a1Bn2oGXej0Jcc78dgWtIiwCtWaGO4LPz5VJ3J/aYQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=jmbpU2oXBCxa/wr86z2tIQp5DmvI8JiKOFZNzQM8IP1Hfl2nsXTuX4TPXBTvJLyyuRhLaKKwXpNzy4k2/QdA+iYTfxrGHxm70iagHVNJ/LvR+yIBBkxkJDa2tV1Y3AnCa6F8InxN33Dhy7TeLrVAW/bCfyDheJFGIwFmJtK4Z8FZDMDqP4AhK6Xy1iOl+xhmqRqNq3ANuwOdhGv5dYSjVTweXUzSMTVxxe0q2MLvIXCUzj208O8Ks8uDv3KwGqJTgR9jQfb039i7YXLhhP4iD9ofBf1U4XVUopmYG/XR4fIKsOPICq2sbAzxcAIIMwYAfqWB9gEceC/ZmnNHJZOKdQ==
X-YMail-OSG: dIx6svEVM1mtoAHEEkcDJQ9rSNZS.rL5zcSp_r6YQjjoNYiC.wLvamr8xRlmIfj
 NJBx1Xm4Meoo88cuUPuuWOSHimNgVzzNMA64I0znlvpBM0KfktPvteLpyW7qCX.XTX5OF1qRm0Yx
 AZv_S.kzFb2awWlk1tlvN4Ty5s7xkhkbQE5T5XMT18PLVCn1yBjSL_0BoTBFYCxsobIpsEzNhZd1
 85vvCTh8Sd273Z_4plxoF9Ke9ESy4ZEhrnZOjA1R8WE3hJlFV7IfCBbERslWYVhxgdDD6wt8bv.h
 uTdpYDLw8NaKTUefnktMT7NLXSFLSBeFfqo2Yx2hZoqmPH.yS.en7DFT55IcHt56mBUWNaZ2_GAp
 O8s669ubA0zvW9rYHpA7eYzi1xjg73ivQVcOOv7N62MYF9KlMX0C2Iy4aMvjo5iQgz2GRrPOR_eu
 HgCD9deBCUavptgpqsj2qAsNh.QhEUGGO6_oPgUnPd7Y0mEMbV5tyWFwi_.XuHrmC.Q3nk.90BSC
 MYf9zCma5p2A1OQB8zHArvpr1KG_oA9Yz10cSf4r1yQrM3o73A.F8BAHZIOz8dyFASAwJSfg.eqR
 M.UnEXtaPmSU9gyPnlE0HSh0M9e0Sns5P8vDMvslr4et87TZUmhBiUddmi9sKnyC1QrLYrIJr9mU
 cJn9_223Y3HDL2jyBOpfMFnd1hF_VbwW98anDeZ6jWkEfY1RT4dZZEQVGmoRfcx3pJm_hGbGQa1.
 Cz3dGFg7cOGrWtORmJkDIODqJLW_f_IIMpbW6JV2Fu5KM4NjAcXp0WDKoIT3gjz3oUQCe0cbfF8P
 UB_W.IPfqJd3UstIANpScbaR9ZC0Gtq96LozPQMBCjkkhd6g3NVmRvs9Rl2hS43BwYxb6F1Yzxsq
 dRIeGCjsaHyDY2BnXySz_uYJLDMFQL333De8H3xea5PGWDh55yNhT6DN8uwVngsiRo_6slv90niY
 28HjIWOycOxJgclH5CCaUQUeZTdqPKt4N7hx4XHdFZbjQ1EDuYnnNQfuc47HHyppyW0I8y43GEUY
 iof7i7QyujFoAboSiePpkgdCzZFwH9jSz09BmZPAer4sud7Co60OgQHswW0xUJrFxtjoA6e9BTsY
 77pRAya4_vom0WBKSOtL1W6hIcPrWqImpoRU4XmKF7yHuQ8SPDFX22CN0yTMJ0crkyoLsr_ikXov
 A59BgXl__7P6GdBMIbX4jMeQ8Kj.WKzOASOFMZ5suEdlcFpCn.5fEgU7LOCHO8u9H_yzENCC_1hM
 2LraH3iNZR3mIOkp1mME3LydTpvS9s7otCtsy.R6WoKGZz2cQxVW5QrS33NoXufDO8kbKK1etqBU
 nfjwvB6MGh6KwSb0De.ZLeFQnoW5Jic87lI3bon.dWHFCIMm21c_y6YGuTk93LM7rYPUcfAlHzaY
 QWH3TUBCj.HeqaCb4kf_cPpPNesaQCjE9JTA9JjMwounInyQLSyNUYtAhjGcIsquhaw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 17:58:54 +0000
Received: by smtp417.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1cea930ac777c9304573db67db0c3ad6;
          Wed, 13 Nov 2019 17:58:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v11 16/25] LSM: Use lsmcontext in security_dentry_init_security
Date:   Wed, 13 Nov 2019 09:57:12 -0800
Message-Id: <20191113175721.2317-17-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113175721.2317-1-casey@schaufler-ca.com>
References: <20191113175721.2317-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the security_dentry_init_security() interface to
fill an lsmcontext structure instead of a void * data area
and a length. The lone caller of this interface is NFS4,
which may make copies of the data using its own mechanisms.
A rework of the nfs4 code to use the lsmcontext properly
is a significant project, so the coward's way out is taken,
and the lsmcontext data from security_dentry_init_security()
is copied, then released directly.

This interface does not use the "display". There is currently
not case where that is useful or reasonable.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/nfs/nfs4proc.c        | 26 ++++++++++++++++----------
 include/linux/security.h |  7 +++----
 security/security.c      | 29 +++++++++++++++++++++++++----
 3 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 74e9f4b7cc07..2f76741ee528 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -113,6 +113,7 @@ static inline struct nfs4_label *
 nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 	struct iattr *sattr, struct nfs4_label *label)
 {
+	struct lsmcontext context;
 	int err;
 
 	if (label == NULL)
@@ -122,21 +123,26 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 		return NULL;
 
 	err = security_dentry_init_security(dentry, sattr->ia_mode,
-				&dentry->d_name, (void **)&label->label, &label->len);
-	if (err == 0)
-		return label;
+					    &dentry->d_name, &context);
+
+	if (err)
+		return NULL;
+
+	label->label = kmemdup(context.context, context.len, GFP_KERNEL);
+	if (label->label == NULL)
+		label = NULL;
+	else
+		label->len = context.len;
+
+	security_release_secctx(&context);
+
+	return label;
 
-	return NULL;
 }
 static inline void
 nfs4_label_release_security(struct nfs4_label *label)
 {
-	struct lsmcontext scaff; /* scaffolding */
-
-	if (label) {
-		lsmcontext_init(&scaff, label->label, label->len, 0);
-		security_release_secctx(&scaff);
-	}
+	kfree(label->label);
 }
 static inline u32 *nfs4_bitmask(struct nfs_server *server, struct nfs4_label *label)
 {
diff --git a/include/linux/security.h b/include/linux/security.h
index e47cef3d62f0..3e333104720d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -396,8 +396,8 @@ int security_add_mnt_opt(const char *option, const char *val,
 				int len, void **mnt_opts);
 int security_move_mount(const struct path *from_path, const struct path *to_path);
 int security_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen);
+					const struct qstr *name,
+					struct lsmcontext *ctx);
 int security_dentry_create_files_as(struct dentry *dentry, int mode,
 					struct qstr *name,
 					const struct cred *old,
@@ -788,8 +788,7 @@ static inline void security_inode_free(struct inode *inode)
 static inline int security_dentry_init_security(struct dentry *dentry,
 						 int mode,
 						 const struct qstr *name,
-						 void **ctx,
-						 u32 *ctxlen)
+						 struct lsmcontext *ctx)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index 618d4f90936b..6f43dafe1249 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1011,12 +1011,33 @@ void security_inode_free(struct inode *inode)
 				inode_free_by_rcu);
 }
 
+/*
+ * security_dentry_init_security - initial context for a dentry
+ * @dentry: directory entry
+ * @mode: access mode
+ * @name: path name
+ * @context: resulting security context
+ *
+ * Use at most one security module to get the initial
+ * security context. Do not use the "display".
+ *
+ * Returns -EOPNOTSUPP if not supplied by any module or the module result.
+ */
 int security_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen)
+				  const struct qstr *name,
+				  struct lsmcontext *cp)
 {
-	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
-				name, ctx, ctxlen);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security,
+			     list) {
+		cp->slot = hp->lsmid->slot;
+		return hp->hook.dentry_init_security(dentry, mode, name,
+						     (void **)&cp->context,
+						     &cp->len);
+	}
+
+	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL(security_dentry_init_security);
 
-- 
2.20.1


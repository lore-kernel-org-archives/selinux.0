Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0706C1744A
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CFB2196E
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XhfaZEMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKMABV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:01:21 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:43282
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727022AbfKMABU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 19:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573603279; bh=mzSvHi63vjpUnBvczhTU9LKGZ5M5+g7KBf16W4CKxcU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=XhfaZEMvX/zt80wNlbby4AARcxB9yqBz/seWmG7xsnlNCC970M8RalkIVSgjQYLzcpwWG0u5RFmZWvaDdGKsRM84gOncDooqh1gGA/gtrRU2dUuhSQcJJcFIrGT1ctf35f/tEm/4VvyT/j4pGdO89rTDrKIBIarI6pTYiAvkjy8xIKeTcHj8ZyaBcBfT0RnMi+qC1kIOCS1Mvh3L1OVG2Yb2FGTrzQRrM6xfcQpTdLoPop8COE5nf2QNHVmoenk0cNfhwDCC3GLbOJVGLEcLTTwGzpcN8ElawNjwfCzV7e14KAoI6ozQIomaF+6cHw1YXj7ExGFvwel0bH7vc1ym5Q==
X-YMail-OSG: UHobQcsVM1lqc2d8FCIY2b4VFiVdSBy4bQFL_6QaQaZV_y4JDWZDzXlKN2AsnVY
 uhfUFXIaLzUOEFnsr2G3oEuBPTiTkemv7UxE3ZQQyZn1ol.Pp9amndoxOVGxlgite4nmbYHPeHG5
 grsKh62lGan4Z45WzyKUdS9GW8pN2ot9bvMYqknauRMTFwlZchS_AxfpK612bBXoFfakZ_gByJy1
 zh7CfgAU6Oj0rZ0fPtF_ctDRdlOyW58V8zFxfm_4ncHp5gXVspcBd7ALLkf.eoyBSmzCZ38a8mjQ
 5K.rGgLgBjdVaZXLQHlko8PEt5_Sxs4YWUG8jRU4oFLsY248YfWAFjpZh4hguKAyRrFiWO7mNdkS
 .hDzIouVfAtqzwV0b6GHjE8rv1qwWVyNHGEinUVD8B.SUq0kQyWoONGCz4RUCAik.guYtQgqKgYp
 EYEZOBMn9SPRuczTo903ZPThRX3CeGPdLmWkamvjynPQHGta70pSaDWo3vLo5c51cVhss7HduKO7
 OPv_lHHj4wZiszvjE1zV7R1XjTSIQlBreVxnJlWeTcFCOqilvPa5awALrbc_D0VIc62BYf9NuRxQ
 mrM1_iXUsPONkroIa.b_ykoQzntNtKD4gzLszMJYizRnYZWA2XnaD3YWCJ5s8s8wVD3c9ym99BAq
 O3M5.Ngpqn9NY868xqGiQGcI7IQwCvSCfJrBllJXgl6VuezRFkgFqHeBZcjuPiwAGsXM38TuJp_K
 O9HI64gMh91deG55N4e4k8t2raP9colDKA8Hgz4XQCfOzM0eWKX66gH58ZX6D3qU2WyNoH9wRJdk
 ie5wUoi8ny8oK8qM4unKf6aieyPCGgpx5tvdl44xNlrXKLlRjP0.h9i5FPyxh1OZiRiS6yjj3Up8
 .aMCBGguoe7DFIM5gRW.z.up.0c9CIy7Iy0w7xmeh0hOqga_.DTak1rSle3Hfstr5qgKRbu9cq2C
 L5.N5jw0c8Mk2Y.98U7b2m5loOkzg9lnfk4OB0cTutuTUn7QaPLQJSlf0QYv7ZDFJO9uvi1ezBFv
 BsODaTOywPaNy0eK4Qtk9.LL0nUxAaFbN8yKYMdonl0OWstagXeCqlR.98sNKgUwNaE_DbUZCAej
 DGV2MKWivJ7k2K6jnvbSoWqas1v4.12.lmyuRHUrLErdKtrokPppuB1WPzffNR2xDmzVsQLsWEAp
 rW_fQYwtsCC5z4t1ZHA141D9vG1Jd7V5LbOvqB1AqckJ.W04fsrNZjX5qVBOrTPE_DET6LyNhkun
 i9ZFTS_y2oxURZzSwiddohpgY30BTcu46aeBTjkFBD4Bszoh6VMAJ2EYNvfHE0e3qD0jJz3ANbaZ
 usjT4F8DieKvpyAmJx3DI8WDv0nhV9G7usOduLf8SdoUwM1II12dzCq4E0C8Gwh6xugnZm.Nn7Hx
 SWPYHl6KChBei.IZi8DHmwGK1wNcgpJnBqkdHSFKXF2O7XNo45c1ulVqybBarrHt3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 00:01:19 +0000
Received: by smtp421.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 684ad521453aa3517b6833d573a9ff1b;
          Wed, 13 Nov 2019 00:01:17 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 16/25] LSM: Use lsmcontext in security_dentry_init_security
Date:   Tue, 12 Nov 2019 16:00:13 -0800
Message-Id: <20191113000022.5300-17-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113000022.5300-1-casey@schaufler-ca.com>
References: <20191113000022.5300-1-casey@schaufler-ca.com>
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
index af1c0db29c39..952f805965bb 100644
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
index ea06d601fe42..fb1e53029f1d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -344,8 +344,8 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 int security_add_mnt_opt(const char *option, const char *val,
 				int len, void **mnt_opts);
 int security_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen);
+					const struct qstr *name,
+					struct lsmcontext *ctx);
 int security_dentry_create_files_as(struct dentry *dentry, int mode,
 					struct qstr *name,
 					const struct cred *old,
@@ -716,8 +716,7 @@ static inline void security_inode_free(struct inode *inode)
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
index a823f141915f..4ebf967d5b81 100644
--- a/security/security.c
+++ b/security/security.c
@@ -968,12 +968,33 @@ void security_inode_free(struct inode *inode)
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


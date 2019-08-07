Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A6EC32751
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA61821EF2
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ReJx8FHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389181AbfHGTot (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:44:49 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:39713
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389160AbfHGTot (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 15:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565207088; bh=3/8SBwyf0KgqJrdllcPKv5gQlQttvqvVPo0X4Ea+EQA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ReJx8FHT8avb/SyVFpihdlO5FsriGiWWHtuanWpiO6UxrSCMzXV1vBgZEdc0LzESWvcCdZrqdnWpqLphkLTr6n2QymRv5rn4+/UTyBuZcv4hJVzgboKt3LRllTkBG/v29YXBhBBJwqC4sDV8tVS/B/spv6Z+t+GKJuhjzqGap8Uc3a4Q+CJFlDDG3vufpL/pjGS26G0+pbkhGgP6hAr8Gw4GzZ5P4+6Vf3v38sETBsJ6Pjekdeg+rFQXgsmgoalxSAQg8aoQA3JbOiS3z1xTvXXZhT0boYUypL5oKoFUflJ76/kID+5E5eUDmIwphbzcQi/ZMFPjIgBPUaqEd7eNzg==
X-YMail-OSG: Vr3IGasVM1mtxsBifsCXpIPGtqd29jKtuZbRNXbPFdsMKrkDqWuWgvBVh_I8Fxq
 .OrxSnAfkCf5b2XqZuqvQzIqczYmI9UeApJkNjljCe14TNfa9O_0AycBbl1Mctqs6Igj9tM435FS
 iYgmSVUDMwrnCjpknEc7.PBs.R9PZCHtAF.1UUfHW2swwWRt.J9fRKu0R9n2q1s43VEDBwnFMtIQ
 LGwXw2VMOEtuaoKBQ.ouSwehTB3lVQmCO1FKFUjSAFGcjV0CQtfl5tqmB.EpfxShDHbvkzIHb6Ok
 WcKXn09f_FAEzvR2cqm0goRAr0wzOBBANvb1.QZJ5f4mHDnGfHEjc2XWUtbgTd_MZytytYqMSaHR
 U235XyM58Z.5PzNdfSIRIlJjK_BFAJ6O0XZNVbK_m91IloyxsXJB_948gi7CskzgXzcCc2Kc6xLt
 A2jdC9C3HBf1SJ07ZjnAPDsTIJ9jwu50mCr1XLklwCVSYtNu50rKhD_LqvLj1bqohvUS5hAls5Tx
 gLXbe6qIvLIcJvq61q4R6CIv4arZMT2j0aAUzo.IQE6JzVP_Hy3k1hUnBX3n_gaDiP6TAphggYwD
 N8_20wXJ57dWt3Lvp8vYkC.W4bY.L2BI6FN8LsjvGVU.9IliDg7SvJk5CfZApKKxE_J67phUcyA.
 4lsZ6lr_7GNbxbyFT0c9UjAWN8gkllgoQS0O38IXhrDpB_D15NAOttIVbdpYAEnm_OpCHrAQs3f3
 eqBgNVVxIDDnuIA2gzaRqlfw7Z_lEFkHLqIrj2TItSOvZyS_gl_YvJA6bSxN9tKY0ivXm25mtgej
 jQntrmnliBpjEtvtOEonhC62_hFwGCKLCc135Yk1injjG8Y_xfkpt263ye_pUYC_2GSsC.RUMJ3E
 AeXvnQVeS.bzRgR4dJ7kqjo7gbE8POZMGHCTYhKpbjMVZkSM3NnhbbUfZWdfxWuadSNMDVleFgNc
 FMf_YsSdEWS4luPn_NRdB7rAeXqWaO2yRWnwTcxaCdGnVbEtoGiaP1dfAvggTNwD9Y7Li3I7LRDo
 9ipjpT7wj5y61jlCJp9tL5Uf_sORF2KAfa6b88XqDdCNumfeRrqpRbHatS6xFcyiLFThTePKD2Le
 keHn5Oo8yZ_bR2hS0_K2mlx.uA6A9v9FsYR7p0hQbZzs3tUHuGUvrUbPWRWNC3jOWcMdxTWhrKg0
 vgLRuFu6QU9JtFUInGOFi2Zh0pRGdYLpSTM7Mm0_dUgMNt77OuITjqY3tBHPekqXOqy0qYyfh3gy
 i9TNHBEOTAFyZGIm4POZdcytihN1KxMUtho3pVCP.SHYEVjOmPwvxZdTybfr2dHTi5HrNQ8ZR3Cm
 .ZWA1TVWV13eA
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Aug 2019 19:44:48 +0000
Received: by smtp409.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8b8b8a62e307b49b2157970e55311396;
          Wed, 07 Aug 2019 19:44:47 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 18/28] LSM: Use lsmcontext in security_dentry_init_security
Date:   Wed,  7 Aug 2019 12:44:00 -0700
Message-Id: <20190807194410.9762-19-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807194410.9762-1-casey@schaufler-ca.com>
References: <20190807194410.9762-1-casey@schaufler-ca.com>
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
index 7255825aa697..2674eb70c2d7 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -352,8 +352,8 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
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
@@ -724,8 +724,7 @@ static inline void security_inode_free(struct inode *inode)
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
index 58c9d8ab8353..836e395027d2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1029,12 +1029,33 @@ void security_inode_free(struct inode *inode)
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


Return-Path: <SRS0=Y9t7=WZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D4EC3A5A3
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 23:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC8B2173E
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 23:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="at4dMtko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfH2XaN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Aug 2019 19:30:13 -0400
Received: from sonic311-23.consmr.mail.bf2.yahoo.com ([74.6.131.197]:45538
        "EHLO sonic311-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728192AbfH2XaN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Aug 2019 19:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1567121412; bh=IutdtSBU3rdIdoae04O6ta5dHJ02n75/QIG5JBsSLr8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=at4dMtkoJgd9zhzjX+MLaOnHK2kDz9k9YI11w7bpH3SLxbdsFFe9UoTFA2qb6U7rYW4KaEwGXEcIAYpk9a6zt9VWwQhEaWxBysbfajScnUEQmWdA/4BsQHIMpU4855/Kg7cTRJjEoGjUkonKHEb5mudrVl5WTLVvi2U919PEwOKiPXYJEAbNEGr/uGhcCz/q5sNd7n+TR113K/ypsOUyPeUvR2T9RCoF6lxIOog16gaXsY7lZcjQZSxcRH0i9H2kUghyVQWUFPbeJppy6gYqS1VMgajOsaAdlnZacK+7feDsoGDl138ZDsvHmcZIl9Ei+JzXFVapVawl+lW5S6j1UQ==
X-YMail-OSG: CUM9YQwVM1mcge08sBoMkMD8WUDmUFxHdA1X5RCjPfBAuimuVT0EQ.GbOqjraD5
 .NGl_UjoQmup187PC5IDleO_1H0Rzd2JqD0TPP.DPw27vi1SmoSzU7WmKjW6loK9KR_KcNeJFOou
 EWaJIV98bbEAyxArXRPKdpArc3Ah_8X79VJNjm5Z8C2O3Gpw19d83dgSDoCRYZ0ctYtfhk3OiH5h
 9rD99LsioCR3nS_B1x4y3QgK8I44g2XMpDIPohqECQcPG7DV.w.Gdxo4zQFYZVYMQ.ODU2OroBrE
 KwTUFKgBf71qflLYWyWgD4BNDpJyMu.1hHgc9WQcoLg7VQXnvP2EIgpdrxfnoqpOdF4tJSM0XWsn
 tQ9h9zXi3FS5YfwDlsg4YSoNjKoUzK0d8VJ4Ja.z_qj8bDCnWvnwhO3WVZ.HEpNy.jPyksWCui6a
 wlrT.M_UCu9UNMTtoS07WbO42TMB2FVIVBcB00xHIGxZpYs4tJD6hucAeVawYwJ4efVi2u7sWxhP
 fihLna6pLTMo3WhdgippdLB69qB_VU2fc_VAklQAZSeAEKlwNAaEus0zFqp6ug9E.sWPW8LeG5aV
 RMepnNxslszowOU1UaTGOvXqINiE7yNy7GIkBXgZ1L1wZA3nnmJUnm3e4uaQwBeg27i5sJ3LtFqP
 OG2sVRT3KpvvXHgLrlNKN6OA_O0efkS7MQ0lLt72G_b4bfrqqQjeEr4L3ckq3UsC8gjj0tmX84ff
 PR2rexOh2aL8S0kzgkNgiwEi.Mk8QsF0pC09ukXpGJHY4ubdqv7xjGHvv2g0NFhvS2ZhME98WeVo
 d6F74pOO5a1pPhHOaWluwmRhKt.MkWNH3ipoyCghdv7d41wczEbFjpxiEkmqgOoRDe8WTebu3WSF
 uqh4u0bjdbfrqPgBhiLlPteqmKLPxFTcB50YiFwY.1.t7DoiLDtUaeG1PThH_mxYMeedbH8xSTHT
 EQVtj8TLM9H3j5mI_enuURXcjYAwFC4NkIGRjrATp.fdiYoTHu_YFhYnKnciupvj9Hv0oSPM76EQ
 YECRZQcwtGae1iSDsdmODKUrKB8Vz1uQ1S6rzIC63vyXf4mFrO4g7XXpjvhTE6DFjSExAYfgqhxn
 dPIbmCl.z8bsihtuoklwICOfWeog.O1C4wWReJbGPKonNlm0i8PmU5L14zMsO8CZBPw.pyliZhvG
 v.rkmp4Pjuk07ryYNqvUNU1LPzbqQptU9oNSKM9LT8J7Ov1IDmR36Byyho3MUYLcSZp9tW3i39Vd
 P7UVfZVa70SIfukBgatjLY96I.T_puvfs0HWDqLYampzj6.eA9OnTStnRTsOBkYePSeLBMTxazTe
 K6U4jMTgbdQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Thu, 29 Aug 2019 23:30:12 +0000
Received: by smtp408.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2d799b9799b92d4529ae6bd2b9fbf9fb;
          Thu, 29 Aug 2019 23:30:08 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v8 18/28] LSM: Use lsmcontext in security_dentry_init_security
Date:   Thu, 29 Aug 2019 16:29:25 -0700
Message-Id: <20190829232935.7099-19-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829232935.7099-1-casey@schaufler-ca.com>
References: <20190829232935.7099-1-casey@schaufler-ca.com>
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
index 38e10f92dae3..7bbc17cc212d 100644
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


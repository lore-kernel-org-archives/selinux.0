Return-Path: <SRS0=dBUy=VA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D295C5B578
	for <selinux@archiver.kernel.org>; Wed,  3 Jul 2019 21:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20AF021882
	for <selinux@archiver.kernel.org>; Wed,  3 Jul 2019 21:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rMbG86OA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfGCV00 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Jul 2019 17:26:26 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:38108
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727333AbfGCV00 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Jul 2019 17:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1562189185; bh=zuSWKB404ZAMMTh/n9UvjOPBxvTgTNPjxbW+ClK4pe0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=rMbG86OAv6pUIbnotHNhTMJgWQ6JzGKn/tI74siVXn5vvq/xROHvRJldogNlgMJS4zdxdg67gn0HAXKeCNgFXdzxWrOgNIWIbL0sm3Ljh8sOe7IZpKmeGiG3ySuxTm6bYF9I/YTi7S2oTE+qtivA4+MvKnyJoK5rYLnZxQqX6wm1Aqr5SQOKPy1MHwRDJXnrwtOjxVO6jEYSpwgmg+trurNz2yqyoo5yqEfs/mYGnKrtbohu98zk+IFL33zhik1NTWNfbrdpSXpB2VoecnINxJCknrlvzNQn5OjjrC1jvAPbusGM7aE8uyuZSr9/ntktc+OvTgoB+d+rXOO+aVzxzQ==
X-YMail-OSG: UMIkxKkVM1m6t7SiSEG.VhGQSwrFJRvQzG20FtyR9qdBAmo.YyPxkGqs03vdJH4
 fB_Zue9D2J_DczvhQVucLDesPzPW8sA59GXF0K5IP2uQ2PitEIidok1lH2LdhYxTKgxbReyDt0J8
 B.6FpmtCd_1HdAKRJx7p1nh6H0UJqlx44JZW.2qjqK1f_Q1yUVPE5RKVLfR.2JHqu4VgOtPGQTf.
 u2CMdWpBJCb6XpvqyOGjnE7s0Y0naQqv54RbA5sYZdivRAVQHLpRLj09QdYNWl4sds3j28Q1xbJT
 s2nssp1hYZ2CvrrGA8puhC9A1G7R_.LCylHi4O_T0GMGDQYVlnwxWTObBbXH1LYF8.zvumFCnYrS
 X6NGDbHBZEDEncHWTDEJEVMdDmLXxZ___hof49KPwUB0aFZ7nQ15sO7dIWvb5NgNJRqNQ9maU_5h
 IuQyWHhdQ.gyWJZTOYsVDeqRoy3yVmTQeG7fNA5yCjEUfJdK5e4c5UJMbFHstartvd8yfK4dbhuc
 FFzB.gLjBCJXffmhQYHi7nQDPSpD9Kyvr3eSNHPYLe_mzu1t_VBnJAHO6PQwZVlD2eiqfv612Vuq
 iaD3VCD6X5Chk4WDN2PPFJ.OUqqwxL.uA24DXjbwRIgBxEAPy1XKioxpTpf88TcnqaRGvL9lf11.
 FLmcbgmyM02sy05MCEymKnHiARfbPzJuPKPgrA03OuCV34bc9kzw_QMZ9cPezdsMj6cENcE1c23p
 bkD0vEsHCR4HtY0VzjHWvrVpSc3hHMarZug.BxftizCak5ihhfhzeOfterZ6Eou9HMzRgZBIokqY
 YZQtlEcYeOV4273uTrdSuYMjzT1TIfHqLVNxJo_pYYp4_ASXgxsBvWuiA7nmOrk_Dyx5JL5LDPzx
 HIh1xf0AY0aG6nlt1U8Zl7fcJ9yV_WiZZqlPAykFn_wa6zwKwrkSbxU1_FNByzcpB8DXFRPTc3W.
 .KdPnnYcWSfWUIaruXCGjAGCTn3QigsqDuRB69bipntC7Op_pqXbY5RO9qi4W6VGn6HSSJJXhqHj
 N.k3lm20NdeJ6_dHfUkfPA6hprjgHGlgZW_2r9LPAEvEpfOpunkzWBHc1nkLS0GSOrjDPyeUpYxW
 9bNzAqvpCC.PqpM6CN3NnhUMq98udAGdZuQf.ex4woKXIkxo2liKn0VybeNIGUDupRFiEWHJYf7F
 9z7pKPUyWJY2R9LNSRk9C2YQFjXPyj8DXNziJhdQPX0Um.L_7Cb1Nbl699IRBsa2YCjLlWYHcNmO
 knIQtSrp9Gu1DbA0SgdgQ3LRDXDauO2ss_vB4qOtZCTD7dZDBymUu6Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Wed, 3 Jul 2019 21:26:25 +0000
Received: by smtp420.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2c078f1d0732da9907514b19d300052b;
          Wed, 03 Jul 2019 21:26:22 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v5 18/23] LSM: Use lsmcontext in security_dentry_init_security
Date:   Wed,  3 Jul 2019 14:25:33 -0700
Message-Id: <20190703212538.7383-19-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703212538.7383-1-casey@schaufler-ca.com>
References: <20190703212538.7383-1-casey@schaufler-ca.com>
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
index 529d70d9d9e2..54d7e7f02a8b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1023,12 +1023,33 @@ void security_inode_free(struct inode *inode)
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


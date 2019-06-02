Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30542C28CC5
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCEA2794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AMbBfeYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfFBQyM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:54:12 -0400
Received: from sonic310-27.consmr.mail.gq1.yahoo.com ([98.137.69.153]:33522
        "EHLO sonic310-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727085AbfFBQyM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494450; bh=BDqvrOe/Zpr49BPyFqMi2sAByPPxYi6emNEKjjpBQB4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=AMbBfeYzphfii8sUpptzPcRGYymxbR4YolKCEo2mOODJZkZkaXLpKYyP1mtfkWALMvZgzcRCuJRdWDkL+lFmufO4Q1j4Hp3SQPxyiSLeO1MNO0XdGu8D4dk1VDZ0pwaEda6/Eh+e1iN2G/6taZ16jH7ff8O50KaI4hpRPgqCQol7HH3xs53pNst49kQn2EYJRoVk4n74w6kinc3xCqZzpMcxdvB6tyaohlToqYx62/DP5Tqq2YUqOgsy6GM4MyvIgYT3pscW+cuu+DvLdtLYb7OFrCor4e4p1cmfYaiVyA1OyC0mRu07GozZ/aIn4dsscgyt9YdMP1HnGhkrjNFmEQ==
X-YMail-OSG: UdHhYdIVM1lrYPA9a6k5nA6DJdKpoRNUSWiY0DVlS47bQPfoX_V.77I9pzxm8ro
 GYGBkjjalTqAdpbO5VLadAaorfUFn3eIBktvy_CiCSNaeavPZnacjF480fPJVkMW5Co6pmRanxO_
 4o_okShWlGGcp4NYc7wQ5d2c8aXaevgJ2L3Ldv5cLcH5EpEUBRWtM3UcG_nBpAn4WowHSASMgOOl
 qqN6RMv5fxYUtRUlTbiDWO8NbFOOycisGuF4usjiWzyN_G8SwyJTMTklnMU8veiMSKKmNfj2yjOf
 SKCBi1P9ri__0u4sCqOfpK6MPi.nGJ.TuBVXJ6dfJs4GYxuKDjy.Ds1DFAydN_4VpwJcYI6K9547
 fXgAhvIOuzz1pnW_85BmQbqZdgKBnA3xRD4V75rewPjPkuV5WygEEV_4MM.W7GhEIvbYQ0QH9Lo.
 lRYWJ4dvIxzh.o3EqBQB98ZIFO1ICIzBWAc9EyjGCnuS4SC0unm_GrAKs4PvXnPI4bjRxvUuVarO
 t.gCot9AQYHzBnQjQguzCa6X3.KXI2jIUQx61wec_FFG_GOspNRCAQcaepOthrPtnWxEsxBniE8I
 7e2P_x_TeWlg58UHYg9C_Utakmzh2GANwEZW8xHGQxqk_IaYoAFQXJNoK7Wv8AnKJ_zRyRGDGjHV
 yW2JkeHnLY5XDj6uJBWGtlELry0zjo_JhIwEQWEl8RCqqWTpfYo0Bd4RAuj1VITWD01YZ7d25cG8
 CYbM3Gy0gUzZB0yW1k2ufvHr4PTuSYfhwOQpqvuwKDjWeNjEM3BEjOFmfHTcSb8Sgymgonbg5GRG
 9LAXtC7Hehz8wDrHTiyQqHIRPXCuPC67OF.5JKmLy1IiMt..TH1e5Sq6ia8PySWmfbjJB50iPNp_
 oeFZ3GmKuy0HSwExVUCWYjearinGWnSWNCavStCgaanl7ppI7vq2r.vjPZ6OvhRzG7Kl06I4Am1W
 ncvNPfcXHjSsZLpmq6fWCPlJtq26H.zU3BCxTEpSTNVeNK0m9M5KEyPds7g5Fii8IF.8s0p76HAC
 eEG60HSoRnKUShOYu2XUSxqL30.IClj2nDT_fdlyvufaL5IfEeDej1wCSk090ibH6N9aR7Oym3Ke
 i2PlbsxKc.gMNO3yWWnbO2a9Yb2hhkxH.Auw39IXjpQXes.VGDsvUnTWLTwfcL3SXLi0Z_t2kgUU
 Ylnf3IiF1e2miHV4qd_SGz_ShQjZB0I3mvWqxXcQ3uOMaDbxhme9q_X2uQxBugwup4JuPmbdwkyx
 T0SjsSNlaaja_QMFjEfGkeSQNxSimh2LA6dhjLv8V7K9Iws2VTpHCQDs-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:54:10 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp430.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e9ca3210f73b95a606016904e284b22a;
          Sun, 02 Jun 2019 16:54:09 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 50/58] LSM: Add the release function to the lsm_context
Date:   Sun,  2 Jun 2019 09:50:53 -0700
Message-Id: <20190602165101.25079-51-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In order to ensure that the release function for a
lsm_context matches the LSM that allocated it an element
is added to the lsm_context structure to contain a
pointer to it. This function is called in security_release_secctx
instead of relying on a value in a hook list.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  6 ------
 include/linux/security.h   |  1 +
 security/apparmor/lsm.c    |  1 -
 security/apparmor/secid.c  | 11 ++++++-----
 security/security.c        |  5 ++++-
 security/selinux/hooks.c   | 14 ++++++++------
 security/smack/smack_lsm.c | 16 ++++++++--------
 7 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 3a779a0f9e15..d1235a3cd8e9 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1326,10 +1326,6 @@
  *	@cp contains the security context.
  *	@l contains the pointer to the generated security data.
  *
- * @release_secctx:
- *	Release the security context.
- *	@secdata contains the security context.
- *
  * Security hooks for Audit
  *
  * @audit_rule_init:
@@ -1662,7 +1658,6 @@ union security_list_options {
 	int (*secid_to_secctx)(struct lsm_export *l, struct lsm_context *cp);
 	int (*secctx_to_secid)(const struct lsm_context *cp,
 				struct lsm_export *l);
-	void (*release_secctx)(struct lsm_context *cp);
 
 	void (*inode_invalidate_secctx)(struct inode *inode);
 	int (*inode_notifysecctx)(struct inode *inode, struct lsm_context *cp);
@@ -1939,7 +1934,6 @@ struct security_hook_heads {
 	struct hlist_head ismaclabel;
 	struct hlist_head secid_to_secctx;
 	struct hlist_head secctx_to_secid;
-	struct hlist_head release_secctx;
 	struct hlist_head inode_invalidate_secctx;
 	struct hlist_head inode_notifysecctx;
 	struct hlist_head inode_setsecctx;
diff --git a/include/linux/security.h b/include/linux/security.h
index 9a9de2bafa55..94c714310ab7 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -121,6 +121,7 @@ static inline bool lsm_export_equal(struct lsm_export *l, struct lsm_export *m)
 struct lsm_context {
 	char	*context;
 	u32	len;
+	void	(*release)(struct lsm_context *cp); /* frees .context */
 };
 
 static inline void lsm_context_init(struct lsm_context *cp)
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 76c409737370..771b0ae24a5f 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1225,7 +1225,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(secid_to_secctx, apparmor_secid_to_secctx),
 	LSM_HOOK_INIT(secctx_to_secid, apparmor_secctx_to_secid),
-	LSM_HOOK_INIT(release_secctx, apparmor_release_secctx),
 };
 
 /*
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 9dc17903a936..30fd4ad80948 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -81,6 +81,11 @@ static inline void aa_export_secid(struct lsm_export *l, u32 secid)
 	l->apparmor = secid;
 }
 
+void apparmor_release_secctx(struct lsm_context *cp)
+{
+	kfree(cp->context);
+}
+
 int apparmor_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 {
 	/* TODO: cache secctx and ref count so we don't have to recreate */
@@ -105,6 +110,7 @@ int apparmor_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 		return -ENOMEM;
 
 	cp->len = len;
+	cp->release = apparmor_release_secctx;
 
 	return 0;
 }
@@ -122,11 +128,6 @@ int apparmor_secctx_to_secid(const struct lsm_context *cp, struct lsm_export *l)
 	return 0;
 }
 
-void apparmor_release_secctx(struct lsm_context *cp)
-{
-	kfree(cp->context);
-}
-
 /**
  * aa_alloc_secid - allocate a new secid for a profile
  * @label: the label to allocate a secid for
diff --git a/security/security.c b/security/security.c
index 6588172b3ec8..c8ce190dcdda 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1987,7 +1987,10 @@ EXPORT_SYMBOL(security_secctx_to_secid);
 
 void security_release_secctx(struct lsm_context *cp)
 {
-	call_one_void_hook(release_secctx, cp);
+	if (WARN_ON(cp->release == NULL))
+		return;
+	cp->release(cp);
+	lsm_context_init(cp);
 }
 EXPORT_SYMBOL(security_release_secctx);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7bf73493d10d..0e347a26c3d8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2812,6 +2812,11 @@ static void selinux_inode_free_security(struct inode *inode)
 	inode_free_security(inode);
 }
 
+static void selinux_release_secctx(struct lsm_context *cp)
+{
+	kfree(cp->context);
+}
+
 static int selinux_dentry_init_security(struct dentry *dentry, int mode,
 					const struct qstr *name,
 					struct lsm_context *cp)
@@ -2826,6 +2831,7 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
 	if (rc)
 		return rc;
 
+	cp->release = selinux_release_secctx;
 	return security_sid_to_context(&selinux_state, newsid, &cp->context,
 				       &cp->len);
 }
@@ -6306,6 +6312,7 @@ static int selinux_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 	u32 secid;
 
 	selinux_import_secid(l, &secid);
+	cp->release = selinux_release_secctx;
 	if (l->flags & LSM_EXPORT_LENGTH)
 		return security_sid_to_context(&selinux_state, secid,
 					       NULL, &cp->len);
@@ -6325,11 +6332,6 @@ static int selinux_secctx_to_secid(const struct lsm_context *cp,
 	return rc;
 }
 
-static void selinux_release_secctx(struct lsm_context *cp)
-{
-	kfree(cp->context);
-}
-
 static void selinux_inode_invalidate_secctx(struct inode *inode)
 {
 	struct inode_security_struct *isec = selinux_inode(inode);
@@ -6367,6 +6369,7 @@ static int selinux_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
 	if (len < 0)
 		return len;
 	cp->len = len;
+	cp->release = selinux_release_secctx;
 	return 0;
 }
 #ifdef CONFIG_KEYS
@@ -6781,7 +6784,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ismaclabel, selinux_ismaclabel),
 	LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
 	LSM_HOOK_INIT(secctx_to_secid, selinux_secctx_to_secid),
-	LSM_HOOK_INIT(release_secctx, selinux_release_secctx),
 	LSM_HOOK_INIT(inode_invalidate_secctx, selinux_inode_invalidate_secctx),
 	LSM_HOOK_INIT(inode_notifysecctx, selinux_inode_notifysecctx),
 	LSM_HOOK_INIT(inode_setsecctx, selinux_inode_setsecctx),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 1b5b3e421bff..e00346799cdf 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4425,6 +4425,12 @@ static int smack_ismaclabel(const char *name)
 	return (strcmp(name, XATTR_SMACK_SUFFIX) == 0);
 }
 
+/*
+ * The smack_release_secctx hook does nothing
+ */
+static void smack_release_secctx(struct lsm_context *cp)
+{
+}
 
 /**
  * smack_secid_to_secctx - return the smack label for a secid
@@ -4444,6 +4450,7 @@ static int smack_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 
 	cp->context = (l->flags & LSM_EXPORT_LENGTH) ? NULL : skp->smk_known;
 	cp->len = strlen(skp->smk_known);
+	cp->release = smack_release_secctx;
 	return 0;
 }
 
@@ -4467,13 +4474,6 @@ static int smack_secctx_to_secid(const struct lsm_context *cp,
 	return 0;
 }
 
-/*
- * The smack_release_secctx hook does nothing
- */
-static void smack_release_secctx(struct lsm_context *cp)
-{
-}
-
 static int smack_inode_notifysecctx(struct inode *inode, struct lsm_context *cp)
 {
 	return smack_inode_setsecurity(inode, XATTR_SMACK_SUFFIX, cp->context,
@@ -4491,6 +4491,7 @@ static int smack_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
 
 	cp->context = skp->smk_known;
 	cp->len = strlen(skp->smk_known);
+	cp->release = smack_release_secctx;
 	return 0;
 }
 
@@ -4713,7 +4714,6 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ismaclabel, smack_ismaclabel),
 	LSM_HOOK_INIT(secid_to_secctx, smack_secid_to_secctx),
 	LSM_HOOK_INIT(secctx_to_secid, smack_secctx_to_secid),
-	LSM_HOOK_INIT(release_secctx, smack_release_secctx),
 	LSM_HOOK_INIT(inode_notifysecctx, smack_inode_notifysecctx),
 	LSM_HOOK_INIT(inode_setsecctx, smack_inode_setsecctx),
 	LSM_HOOK_INIT(inode_getsecctx, smack_inode_getsecctx),
-- 
2.19.1


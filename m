Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297CDC10F06
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90F32133D
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Xoeundrb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbfB1WUi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:38 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:45761
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730287AbfB1WUW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392421; bh=fNWGz4uuvEkQLif1Z2lsOSS1NmbXmk0a8XcBcgcY4mM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=XoeundrbI/mPinvmKdmMoTcqcxJcUoh3OqiEKwhwehzwsb7BX2WyCOk1aCsIOtWJmIH0b1fTWn8x3VkSDMFpPaQ2Ykh3wEePhqKyG1GE56wqbS/2WV4PYajF5S2SoZ/hCDyUI6Rn9xLWs4ct+dNq5KcqJXAycWrc6CxrUWdex+iodtUgfBP1tnOKllar8J4OEIt+ajbamLoUKsqSLQ0PzmO26nxstH2qvRRGpW+C9kKQvfR+i14j/FzxWMuGt68UZZv4OjFg+gtBQgJVS7ZcVS3MkdVdpX96+pEZyXLCdlDDKIqXyNVKaweXJXHCDSaEZgvRvzdeNVtRChJYz1QXOQ==
X-YMail-OSG: wnUaZ4MVM1mUnSx_1zJHGPkvglyZytZvxY1RtEdOoE_TPyH6BUrup2VdOdsg5z8
 Pew4qWk0AYmVZrIDeueWeSA2eyQwItkxjzBcPslIzPKbXUKPraqe00C8wmRbRmNdqT4xXvmT2kWc
 5p43dFgaf54ifR0Wfr77KtacgW0qECBurI1TDL6m_sYiQ816DlALfteyyrisBCKJuJJOvXZgpj5.
 UT51CtXDn7fMgqcIRfre5Zu3UwVKoRMPBRAE12ka2xUHhAy2ZT7tww6T5Zi7pypyZYE.jBC5FXUE
 QWXyi45ny7f_FeKyG5UIq6JLtYbaByVNvU11ws2XX4vzyNCYUZF7g5tzLkny6YUDYV3T97DOS0Uc
 GLj.LnfMh1bQCEsT7G5TWnOVuYbNZHLrVBLBKb_dOwcIIt9nnHRdRE4vNEFBQ.628Ie8YfI7nnkb
 GtdA0Hn5gx.HGn2Ihfrq0HvA7fdv6sMsr0i8k7zZSUjtpOLtbCfth_INI62q0yl2hLe8l1mPYKWV
 UfwNxgr2ibc_ubcKSKh6wilppiykFDmMg9r9m.BjIoylwt13Blo3c2ZERX1jVmO.EgGsar0_UX4J
 3N78HSSqyQ4104FzEpzsP2_v6u8ATxBQkVlDbfCAzvKYwUNsdmOoIWsNS3p6mHZ71pUzTrRcAg18
 GohBv8qVYA3iF6pi.RK61zD8Erx3peHL9nQFVR0yTgQejxmgKW5BGc_rOWO3QCQwOF1gWBS7lhRy
 DT6Sb0kvo_0qkAhCl2YRGNtkLtRmLlqPTPbLDuloXoD8SHKWTRHLLnCo.H8wB9GH18ZPsBOJpk1f
 UU4NkCU2652OEIkbhDqt_.t7WNf3mImB.xv_PXDgU1brMfTisXzbSpamo_05hI1WEtkimeUJUWVZ
 un.oIHrAhGVR.5_fZwPChbKoD56dW3rloChynbCCwiNP2FT4azTRYtCe2zmazk4WAiYo93vNITzH
 Y1ZhEYRRAXYoBlMk77.i6wconXwticS9zDtKDhEj7jm0R4IljHi0XkYYp1_yLnRQd3ZsbWxZRbUl
 cZJbZihSxFC1se9d.JvbmIW0kaVRRQpsOR36d3HEwcYNV5lTF_TKkM7fvg.fF_nWo5WaTPwcdjj7
 blJ5m5HUBeHb_3GOF_QuIvA1rzYZoSXefC.aK_7ROLAxFf0oc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:21 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp423.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 51882fbcdd41d0138ebd23ca73a62b12;
          Thu, 28 Feb 2019 22:20:19 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 57/97] LSM: Add the release function to the lsm_context
Date:   Thu, 28 Feb 2019 14:18:53 -0800
Message-Id: <20190228221933.2551-58-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
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
index 2f07be4b9800..349d7c28147a 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1313,10 +1313,6 @@
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
@@ -1652,7 +1648,6 @@ union security_list_options {
 	int (*secid_to_secctx)(struct lsm_export *l, struct lsm_context *cp);
 	int (*secctx_to_secid)(const struct lsm_context *cp,
 				struct lsm_export *l);
-	void (*release_secctx)(struct lsm_context *cp);
 
 	void (*inode_invalidate_secctx)(struct inode *inode);
 	int (*inode_notifysecctx)(struct inode *inode, struct lsm_context *cp);
@@ -1927,7 +1922,6 @@ struct security_hook_heads {
 	struct hlist_head ismaclabel;
 	struct hlist_head secid_to_secctx;
 	struct hlist_head secctx_to_secid;
-	struct hlist_head release_secctx;
 	struct hlist_head inode_invalidate_secctx;
 	struct hlist_head inode_notifysecctx;
 	struct hlist_head inode_setsecctx;
diff --git a/include/linux/security.h b/include/linux/security.h
index 46cc16a67212..749acb6a28a6 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -121,6 +121,7 @@ extern struct lsm_export *lsm_export_skb(struct sk_buff *skb);
 struct lsm_context {
 	char	*context;
 	u32	len;
+	void	(*release)(struct lsm_context *cp); /* frees .context */
 };
 
 static inline void lsm_context_init(struct lsm_context *cp)
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 8c854f95d814..732b4de175bf 100644
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
index 2b2520ba9554..a49095112416 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1988,7 +1988,10 @@ EXPORT_SYMBOL(security_secctx_to_secid);
 
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
index 07213ae8929f..8ecdf975c53d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2714,6 +2714,11 @@ static void selinux_inode_free_security(struct inode *inode)
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
@@ -2728,6 +2733,7 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
 	if (rc)
 		return rc;
 
+	cp->release = selinux_release_secctx;
 	return security_sid_to_context(&selinux_state, newsid, &cp->context,
 				       &cp->len);
 }
@@ -6199,6 +6205,7 @@ static int selinux_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 	u32 secid;
 
 	selinux_import_secid(l, &secid);
+	cp->release = selinux_release_secctx;
 	if (l->flags & LSM_EXPORT_LENGTH)
 		return security_sid_to_context(&selinux_state, secid,
 					       NULL, &cp->len);
@@ -6218,11 +6225,6 @@ static int selinux_secctx_to_secid(const struct lsm_context *cp,
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
@@ -6258,6 +6260,7 @@ static int selinux_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
 	if (len < 0)
 		return len;
 	cp->len = len;
+	cp->release = selinux_release_secctx;
 	return 0;
 }
 #ifdef CONFIG_KEYS
@@ -6669,7 +6672,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ismaclabel, selinux_ismaclabel),
 	LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
 	LSM_HOOK_INIT(secctx_to_secid, selinux_secctx_to_secid),
-	LSM_HOOK_INIT(release_secctx, selinux_release_secctx),
 	LSM_HOOK_INIT(inode_invalidate_secctx, selinux_inode_invalidate_secctx),
 	LSM_HOOK_INIT(inode_notifysecctx, selinux_inode_notifysecctx),
 	LSM_HOOK_INIT(inode_setsecctx, selinux_inode_setsecctx),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 1861587b3620..4fcd8271ca24 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4340,6 +4340,12 @@ static int smack_ismaclabel(const char *name)
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
@@ -4359,6 +4365,7 @@ static int smack_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 
 	cp->context = (l->flags & LSM_EXPORT_LENGTH) ? NULL : skp->smk_known;
 	cp->len = strlen(skp->smk_known);
+	cp->release = smack_release_secctx;
 	return 0;
 }
 
@@ -4382,13 +4389,6 @@ static int smack_secctx_to_secid(const struct lsm_context *cp,
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
@@ -4406,6 +4406,7 @@ static int smack_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
 
 	cp->context = skp->smk_known;
 	cp->len = strlen(skp->smk_known);
+	cp->release = smack_release_secctx;
 	return 0;
 }
 
@@ -4625,7 +4626,6 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ismaclabel, smack_ismaclabel),
 	LSM_HOOK_INIT(secid_to_secctx, smack_secid_to_secctx),
 	LSM_HOOK_INIT(secctx_to_secid, smack_secctx_to_secid),
-	LSM_HOOK_INIT(release_secctx, smack_release_secctx),
 	LSM_HOOK_INIT(inode_notifysecctx, smack_inode_notifysecctx),
 	LSM_HOOK_INIT(inode_setsecctx, smack_inode_setsecctx),
 	LSM_HOOK_INIT(inode_getsecctx, smack_inode_getsecctx),
-- 
2.17.0


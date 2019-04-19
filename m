Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F39C282DF
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E58121736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JGXMiIvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfDSAs1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:48:27 -0400
Received: from sonic308-9.consmr.mail.bf2.yahoo.com ([74.6.130.48]:43893 "EHLO
        sonic308-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726959AbfDSAs1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634904; bh=P/zlsjKsKaSijsEpBcEMsErqE2LJmExsvA7oCdttQkk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=JGXMiIvG7zeco9s8z/EymsHDIfGdp1DWwieOW/2pRUxpDlYoq5LrjXmRWz5NJ6bBSOCEHqhhCaksi3fhO4hyIiEGQbVsAEdhmem3gk8/I2fjNT1pCaZ2KYRI74YvRrxHR7LWGcOdoCQGqINdbdjLPSlflwG+tZpSmllgXUfrzcP9JSG8TGhbIUxzTIb2cREEikMGDrWPl/LSAI7LQRflfHbdiwWgnlHVjozm7wbKESEDwNTbgvLgnIO/Uan3DiRid0K/CkvZVZssnM7R/vQyJgqY3yzf1u5SkumCtT2on8qN0Vv80uyS3SgNKzkYy/+Sh3EtFTsedFBffPvbJc/C7w==
X-YMail-OSG: MxXuSVoVM1lrKPAzXvak2YMSWKBrRIBQSRhFnzbnLw46QTBC3I4YT5sB4V.LVeq
 zPBmPieRNsSZVBd_m.Dnhz7B6Tks2euT5J___DllPkQgmZIisTx3RVhUKLPdQSr58bdRh.3HjDdn
 SoKwRc8H7f2xzXUQXUfjp9kg5wyf20gQr2F1.IB_I4ntNwdPFCb13NeMaHzahBPlelQqraEuI1o4
 UC0IpOcO8c0Tw9BJjjBRkFTpANjDrG2LdXZ9V6YsbaehbDObNMwDTissk7cI03K6JE0x_Kzwoo46
 ID3C4.qUS1bjJ4Pam1YHv_A.jV6Sa0rTlb.rmTSaMiM4HovgV3F67Yb7kglnNsn23lwE4UyvL1CN
 mLLMzazn0nhIPkheXq6x.NrGmglLYFLJ_P6KBaXFMqJosv4pcyHMfVmLaXfb7VUyQrFQx1MFbDQk
 gsXwH1PGX6y4NBYzYe9f.H9oqma._2jwOJN7DW0gHTBP32auS5zGRX8J2Vwg4VSoz9PCaYWsM.Zs
 2DQq6gNoiaZiHpaQUP1EqFzNNp.TXhEz0NN85bXslxa7MXk60YlObeSXjq9jV.Mwjs3xWLVQUqa.
 hEzAelcPGlnnsIv2Z4SYaj0mZdiU_IN2T_QsxuxuMuru7tGGoyB3lFxfc4NQjZbHg_.vyCEymOkV
 32SvdHfPvfCcu0BsXuxt90M3YfivG2LSUvIys7KRe1LM73tmp8fTy0KFKKZELJIcssHom2bP9lB3
 cQZfWtbwMsdJ2gyPE6Ewx0BHxaPpN528IkyF8XmjkoNdg0W4Lse7k53jqHCqL7wZ2c9C5h5LIrP7
 AEyQNa7z5WNfeRV6YvBaynLz0VVlyY_pmYOg3X49qZWvSiqMZR89DIt5F21YWkB_.yARwtAM2QMy
 TG9UgbcBwGLOdYUSxwrksI.m0xxO7DOEg6D11j7UBDu6JOpxNa_c18oYcxvI9hf477sjk9lf7zCf
 .IkmkSDM2sGaYkXzLcIALoAENzB7aHrzA52xcLlCzmCNMXV.QuhD2IL6h7LUdSWcYJ601Sxc6RKS
 EYabp2UN5aiXhJk.Lmd3vGbrdjZovjlSxL2Xj4vAvl4A8cL8yBDLfwvpul29OF7ChX1pKunCntDm
 XfIp5gTi8CVtINfQ1o1uNtBIhcefqcihbHYxFIQ8lk28L5Tk1ja7.nwGpijGRSmYI_9VH4Uro.n7
 euClqNSNE2hv9Xw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:48:24 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp425.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 48f2b950f84a4435a371532cc5391b39;
          Fri, 19 Apr 2019 00:48:19 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 51/90] LSM: Add the release function to the lsm_context
Date:   Thu, 18 Apr 2019 17:45:38 -0700
Message-Id: <20190419004617.64627-52-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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
index 11bfa0a4f188..1d364e211639 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1329,10 +1329,6 @@
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
@@ -1670,7 +1666,6 @@ union security_list_options {
 	int (*secid_to_secctx)(struct lsm_export *l, struct lsm_context *cp);
 	int (*secctx_to_secid)(const struct lsm_context *cp,
 				struct lsm_export *l);
-	void (*release_secctx)(struct lsm_context *cp);
 
 	void (*inode_invalidate_secctx)(struct inode *inode);
 	int (*inode_notifysecctx)(struct inode *inode, struct lsm_context *cp);
@@ -1947,7 +1942,6 @@ struct security_hook_heads {
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


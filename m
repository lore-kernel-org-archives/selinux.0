Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC5AC10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3082133D
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SCMMnaf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfDIVlL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:11 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:38659
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726930AbfDIVlG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846063; bh=oZw+jxmu0klx8qKKkocY1UUY4fu46NlBbhyji1WzJ7A=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=SCMMnaf0nU9kWPEAPiRlwlAOX9KLlZyhJAqN0vcfqNyQW46Kfwcz2cSmRmPa6MrOjtjCQLj9JhfwEkheFdm+WiU7n81BVE//RuT436mrqsN1u8AYFKsVOFQxszQs87msHTkdogKa213nrXAKSVLbcZ9R9bD+OlIW61La+mhqhRDDiC+dU6RWw8jPDx4WRqN2ChxUw+ATRyh2U02VHvxJzepGz/CFz3tGTHIxVmzeyIAqa+wkDDp44hqwjMnQuEb3/p5z/+9+pqtVJ8V5HQ/8ArjbH4gVxjCUpG0XY1BrnKLLZoI1gMq43DKSH3PkmjYpP3kUOp0h/Hw0Rgz+Rhi8fg==
X-YMail-OSG: YZOYJXYVM1n8BlfIL4sCah_QT0Xc1XCbP8iFwE_UgBcEvISwHthvaXIWGkKX83x
 akNQGGA7Qp.keKMFHS7kOQeE7hkG8e7gAQ3ZC_2DVI7Y5gSjHPn54KCDn08KM0JiRjkF3FtEzg.V
 xtprZ7ParUPsOKHrOaWLnhEmlMeOUYlgP63STUtpShq6aymY4OqeDrDRzZt31YQcOtScaiT5IrZG
 erz7CzXd9TNqKSA2G4w6CyLs5zI90QL7LBhcu7Gwio1GUliUWtUK8xRcnxKgErzQp6gI_edAx7o4
 kRYbNKKg6w38cRuU5Mn2GGl73g4FMB5RkxDENggOkc0_Ii2bz8tBxEnlCfty0EYz266KUllXtYu9
 4LhucEX0rQs29n_cs7UPD9OWfOb1ktVebEAONBu8EPjTyFOOFrM5WglesbnZW28S.VQgXbX34XMK
 JAf58wyFuL7hQEvO4_V_wOGoITQIIaErKdVTAFbaFStcckmMeUeOaxgLYbKT.h_022Dv86GRfDuw
 gvlUv1B1e25mM3EBtBZVhhyGdem2A1RCyz95OGNYbdoD3cMaGbcVhnca11WbGME6gXtvZwoVcjcw
 z6HJBX6wmUoCYr_nMc_PLNvwGQksbeRhkBX61Hw.EVP6eOT.ZFAHyAJLvQXHZBDbOuVYEj69.gWe
 9zFo06uQYsj_O6urrySx05.p8KiBsBAGOTa5riv.fXtvpyE1akhByrWnbvrPjwvnvuBDfLxFnK9Z
 LttH5zizls0Hryl32qn01ThVx4HafVwC2BVcdfTfcSED7pd_aOoeDhD_eDaSfcNSf7WwpXDyUrLC
 b64zozaL6X1KCpoi.f_oiESYnpF_j0cWRUyP7P7ijvDQb.BI_MPj1o9wtKLYEtSpvgxcN5ncwk5a
 3uXTEmM08xs.L4vHIvD8WxuFxaK_v6uM8HhfWxewptegqRaCVlxOspjwkOtRi7K6SPRozrTCuikb
 t_s1g1d357hYo1Sg6OWFvFC.ifkLibrirAMwexK9DBE1RNSzurjsnw5JmgNDQjVhAUte0u9MFeyy
 7AwrZoFg7oT7VybTT9ejHARAXQ3hrQEJbwPRUGu8Vo6KPwCJKxuJTz4rXlxePdLPtPXRpKnb6Opb
 gJPbQS9M5ew4Fo3gKiACiL11W173a3IEV5Q.wybm5aiLJklf84az6QpN05pBrXA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:03 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp408.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6a737b6f7572f7259a29fc213d8f0ed1;
          Tue, 09 Apr 2019 21:40:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 39/59] LSM: Use lsm_context in secctx_to_secid hooks
Date:   Tue,  9 Apr 2019 14:39:26 -0700
Message-Id: <20190409213946.1667-40-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert SELinux, Smack and AppArmor to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         | 4 ++--
 security/apparmor/include/secid.h | 2 +-
 security/apparmor/secid.c         | 7 +++----
 security/security.c               | 6 +++++-
 security/selinux/hooks.c          | 4 ++--
 security/smack/smack_lsm.c        | 4 ++--
 6 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 566714aa0caf..8b842fd13fb4 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1327,8 +1327,8 @@
  *	context.
  * @secctx_to_secid:
  *	Convert security context to exported lsm data.
+ *	@cp contains the security context.
  *	@l contains the pointer to the generated security data.
- *	@secdata contains the security context.
  *
  * @release_secctx:
  *	Release the security context.
@@ -1672,7 +1672,7 @@ union security_list_options {
 	int (*setprocattr)(const char *name, void *value, size_t size);
 	int (*ismaclabel)(const char *name);
 	int (*secid_to_secctx)(struct lsm_export *l, struct lsm_context *cp);
-	int (*secctx_to_secid)(const char *secdata, u32 seclen,
+	int (*secctx_to_secid)(const struct lsm_context *cp,
 				struct lsm_export *l);
 	void (*release_secctx)(char *secdata, u32 seclen);
 
diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index 964d3dc92635..acfcf99bff0e 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -27,7 +27,7 @@ struct aa_label;
 
 struct aa_label *aa_secid_to_label(struct lsm_export *l);
 int apparmor_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp);
-int apparmor_secctx_to_secid(const char *secdata, u32 seclen,
+int apparmor_secctx_to_secid(const struct lsm_context *cp,
 			     struct lsm_export *l);
 void apparmor_release_secctx(char *secdata, u32 seclen);
 
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 4e11434605d6..35df38592b6e 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -110,13 +110,12 @@ int apparmor_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 	return 0;
 }
 
-int apparmor_secctx_to_secid(const char *secdata, u32 seclen,
-			     struct lsm_export *l)
+int apparmor_secctx_to_secid(const struct lsm_context *cp, struct lsm_export *l)
 {
 	struct aa_label *label;
 
-	label = aa_label_strn_parse(&root_ns->unconfined->label, secdata,
-				    seclen, GFP_KERNEL, false, false);
+	label = aa_label_strn_parse(&root_ns->unconfined->label, cp->context,
+				    cp->len, GFP_KERNEL, false, false);
 	if (IS_ERR(label))
 		return PTR_ERR(label);
 	aa_export_secid(l, label->secid);
diff --git a/security/security.c b/security/security.c
index 7cf8e268a45c..f3788840019a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2005,8 +2005,12 @@ EXPORT_SYMBOL(security_secid_to_secctx);
 int security_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsm_export *l)
 {
+	struct lsm_context lc;
+
+	lc.context = secdata;
+	lc.len = seclen;
 	lsm_export_init(l);
-	return call_one_int_hook(secctx_to_secid, 0, secdata, seclen, l);
+	return call_one_int_hook(secctx_to_secid, 0, &lc, l);
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6a2a82dcd948..a2257ccaee5c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6310,13 +6310,13 @@ static int selinux_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 				       &cp->context, &cp->len);
 }
 
-static int selinux_secctx_to_secid(const char *secdata, u32 seclen,
+static int selinux_secctx_to_secid(const struct lsm_context *cp,
 				   struct lsm_export *l)
 {
 	u32 secid;
 	int rc;
 
-	rc = security_context_to_sid(&selinux_state, secdata, seclen,
+	rc = security_context_to_sid(&selinux_state, cp->context, cp->len,
 				     &secid, GFP_KERNEL);
 	selinux_export_secid(l, secid);
 	return rc;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 10d6c6a1a001..78c01ef707eb 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4455,10 +4455,10 @@ static int smack_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
  *
  * Exists for audit and networking code.
  */
-static int smack_secctx_to_secid(const char *secdata, u32 seclen,
+static int smack_secctx_to_secid(const struct lsm_context *cp,
 				 struct lsm_export *l)
 {
-	struct smack_known *skp = smk_find_entry(secdata);
+	struct smack_known *skp = smk_find_entry(cp->context);
 
 	if (skp)
 		smack_export_secid(l, skp->smk_secid);
-- 
2.19.1


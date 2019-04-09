Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC01FC282E1
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7729D20833
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="m3ov4Vir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfDIUAq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:00:46 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:39755
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726911AbfDIUAq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 16:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554840044; bh=oZw+jxmu0klx8qKKkocY1UUY4fu46NlBbhyji1WzJ7A=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=m3ov4Vir7w4L7pXUbIINp1r4NItrq0aZ8NB8hwDIHwtfagi81LrIAIQHperDnd68ZgzsFq97iaYjOkSPnTyh5ThhN+GCjOlM+DXZvH7UU+RjePl32sTn3BPfuaFY3saf5m69Nvk8A0bPAJXzsmddQnfukTIwCDC3vx/noK4K85TMVvRFLnONzKmHtxtFeoI7n16+swPTsyguWkmPfVDZmm2EbkkmTJds7iPT/7Kuq9/PP9bf/uKfLD0i1QxvrZ4G5lp+dzN/wddaCsIqDhgMqUoy+FgKCGVO4YDV0GlDPfyG2T6taWec2IfZBmptM4bTDlRHTw1KF5grT9vuU+X1Hw==
X-YMail-OSG: JjaD.rQVM1ku1xHeiBxIRMYSaVMY4gdou9ziBjc53UHO17cC7fxsSm8FSKi_HvV
 4roJ3ZtLSNoTEdl3n4sbBSnUR6MSfQnby.Eu__Kr1eysr34OCe2QKxGESBegmoveUgb_ZNCcA0sf
 81jXRV6I_YxBM43P5Cq9lZ2Q3zDjnEoDIqNAZB2CXH75iTwkKoRaR9AA9e7mo9I4efgAUlIrX.UA
 vUfiGYlpUWebJc481nKBB54tM47c_S4j2XCI0d8X6D1on9R.FSgsAJBObXCh0GuC6UYEM_tPkj43
 1IpZawsppvQtKw9dbJ6jPPGMg2GXuO2RHfUFGJ2h2JNVxHn0B2vLwxax5wHGSQINfxQiS0GssiEq
 dPAJOHnCwEV8RWIuEdxqMSWbP3Fw5XnJtdPmsHhybRbluMAdCxcAP5mMQgwhXtN6AeID_yiMSA4C
 TyL.AxPgt6IiHknXa3RRY3tSQjn84LzVidd8Wb0QBJjeeJh1y36GypTMMzOLepjM9sv7TIc_oKJk
 wCEVigkD70t4n9hSvLs.rzxhKP.zoH4SZotT_fqDKzCSV.HbsGGCMFquEsFgsoNXSbxdg2ZEkJWy
 3jxWXzDhMulD3peuCPtuK6cVMqo4HhJHeEAKW5B0snjZr.41B5wx6fO_jzB5yVixjIigrcM3vznx
 M1lsKwLgKZaZAcqeTzRN0llBpA8w.g6vxgHSCxEHZ7WbiVFTTjZkFTRRlofJ_timWI41BFeUK.W1
 alZMEs5uvFXNJ.XC5YlT4QEhU6YOIc1_cC74yf37AOcMWluvqNwe6zgqcPE2XmjKBDKZdIZ2MP5z
 WPrP_VNeZvLHgxofgpq7okhdUACXSU70fzZoNXzjPOgc8vJBH8hNGbVwXY4n4Bm3rTWkl73BbD2b
 zIkLeb2HaXl6mW4Uy4wNl22gaDb0wafO_N9lR0kW9HLZp54Kymay49L9gB8gWYU4PWdySqLxklao
 ajc3gdAhII_dgQiGh6CsAvcw_ToTjYFCk.6lo5TV4meB_Y8C8e9r8NNXzZWeRbOex2KF2Ln4lk_9
 bJXhJhubZ15oEh4.oCLHWc9TM1XjwHF785KORoKpR2L.Bd_5Uq9b5oAt3Dl9cRlyB0PO3.vlz2oV
 hBxJYtQlVg_3HfQNXfuIqnR2VxNV0ITak4CneHYEcW02wv0osxk1Zs5nJ2VYA
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 20:00:44 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID dd207be9b16b6375049b46b06443493a;
          Tue, 09 Apr 2019 20:00:44 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 39/59] LSM: Use lsm_context in secctx_to_secid hooks
Date:   Tue,  9 Apr 2019 12:59:04 -0700
Message-Id: <20190409195924.1509-40-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
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

